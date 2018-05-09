From: alexei.starovoitov@gmail.com (Alexei Starovoitov)
Date: Tue, 8 May 2018 19:25:28 -0700
Subject: [PATCH v2 net-next 1/4] umh: introduce fork_usermode_blob() helper
In-Reply-To: <20180507183931.GV27853@wotan.suse.de>
References: <20180503043604.1604587-1-ast@kernel.org>
	<20180503043604.1604587-2-ast@kernel.org>
	<20180504195642.GB12838@wotan.suse.de>
	<20180505013710.2fb2k6e5uotd22kr@ast-mbp>
	<20180507183931.GV27853@wotan.suse.de>
Message-ID: <20180509022526.hertzfpvy7apz6ny@ast-mbp>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, May 07, 2018 at 06:39:31PM +0000, Luis R. Rodriguez wrote:
> 
> > Are you saying make 'static struct vfsmount *shm_mnt;'
> > global and use it here? so no init_tmpfs() necessary?
> > I think that can work, but feels that having two
> > tmpfs mounts (one for shmem and one for umh) is cleaner.
> 
> No, but now that you mention it... if a shared vfsmount is not used the
> /sys/kernel/mm/transparent_hugepage/shmem_enabled knob for using huge pages
> would not be followed for umh modules. For the i915 driver this was *why*
> they ended up adding shmem_file_setup_with_mnt(), they wanted huge pages to
> support huge-gtt-pages. What is the rationale behind umh.c using it for
> umh modules?
> 
> Users of shmem_kernel_file_setup() spawned later out of the desire to
> *avoid* LSMs since it didn't make sense in their case as their inodes
> are never exposed to userspace. Such is the case for ipc/shm.c and
> security/keys/big_key.c. Refer to commit c7277090927a5 ("security: shmem:
> implement kernel private shmem inodes") and then commit e1832f2923ec9
> ("ipc: use private shmem or hugetlbfs inodes for shm segments").
> 
> In this new umh usermode modules case we are:
> 
>   a) actually mapping data already extracted by the kernel somehow from
>      a file somehow, presumably from /lib/modules/ path somewhere, but
>      again this is not visible to umc.c, as it just gets called with:
> 
> 	fork_usermode_blob(void *data, size_t len, struct umh_info *info)
> 
>   b) Creating the respective tmpfs file with shmem_file_setup_with_mnt()
>      with our on our own shared struct vfsmount *umh_fs.
> 
>   c) Populating the file created and stuffing it with our data passed
> 
>   d) Calling do_execve_file() on it.
> 
> Its not clear to me why you used shmem_file_setup_with_mnt() in this case. What
> are the gains? It would make sense to use shmem_kernel_file_setup() to avoid an
> LSM check on step b) *but* only if we already had a proper LSM check on step
> a).
> 
> I checked how you use fork_usermode_blob() in a) and in this case the kernel
> module bpfilter would be loaded first, and for that we already have an LSM
> check / hook for that module. From my review then, the magic done on your
> second patch to stuff the userspace application into the module should be
> irrelevant to us from an LSM perspective.
> 
> So, I can see a reason to use shmem_kernel_file_setup() but not I cannot
> see a reason to be using      shmem_file_setup_with_mnt() at the moment.

That's a good idea. I will switch to using shmem_kernel_file_setup().
I guess I can use kernel_write() as well instead of populate_file().
I wonder why i915 had to use pagecache_write_begin() and the loop
instead of kernel_write()...
The only reason to copy into tmpfs file is to make that memory swappable.
All standard shmem knobs should apply.

> > > > +{
> > > > +	size_t offset = 0;
> > > > +	int err;
> > > > +
> > > > +	do {
> > > > +		unsigned int len = min_t(typeof(size), size, PAGE_SIZE);
> > > > +		struct page *page;
> > > > +		void *pgdata, *vaddr;
> > > > +
> > > > +		err = pagecache_write_begin(file, file->f_mapping, offset, len,
> > > > +					    0, &page, &pgdata);
> > > > +		if (err < 0)
> > > > +			goto fail;
> > > > +
> > > > +		vaddr = kmap(page);
> > > > +		memcpy(vaddr, data, len);
> > > > +		kunmap(page);
> > > > +
> > > > +		err = pagecache_write_end(file, file->f_mapping, offset, len,
> > > > +					  len, page, pgdata);
> > > > +		if (err < 0)
> > > > +			goto fail;
> > > > +
> > > > +		size -= len;
> > > > +		data += len;
> > > > +		offset += len;
> > > > +	} while (size);
> > > 
> > > Character for character, this looks like a wonderful copy and paste from
> > > i915_gem_object_create_from_data()'s own loop which does the same exact
> > > thing. Perhaps its time for a helper on mm/filemap.c with an export so
> > > if a bug is fixed in one place its fixed in both places.
> > 
> > yes, of course, but not right now.
> > Once it all lands that will be the time to create common helper.
> > It's not a good idea to mess with i915 in one patch set.
> 
> Either way works with me, so long as its done.

Will be gone due to switch to kernel_write().

> 
> > > > +int fork_usermode_blob(void *data, size_t len, struct umh_info *info)
> > > 
> > > Please use umh_fork_blob()
> > 
> > sorry, no. fork_usermode_blob() is much more descriptive name.
> 
> Prefixing new umh.c symbols with umh_*() makes it very clear this came from
> kernel/umh.c functionality. I've been dealing with other places in the kernel
> that have conflated their own use of kernel/umh.c functionality what they
> expose in both code and documentation, and correcting this has taken a long
> time. Best avoid future confusion and be consistent with new exported symbols
> for umc.c functionality.

There is no confusion today. The most known umh api is a family of
call_usermodehelper*()
In this case it's not a 'call', it's a 'fork', since part of kernel module
being forked as user mode process.
I considered naming this function fork_usermodehelper(),
but it's also not quite correct, since 'user mode helper' has predefined
meaning of something that has the path whereas here it's a blob of bytes.
Hence fork_usermode_blob() is more accurate and semantically correct name,
whereas umh_fork_blob() is not.

Notice I no longer call these new kernel modules as 'umh modules',
since that's the wrong name for the same reasons.
They are good ol' kernel modules.
The new functionality allowed by this patch is:
forking part of kernel module data as user mode process.
A lot of umh logic is reused, but 'user mode helpers' and
'user mode blobs' are distinct kernel features.

> I don't even want to test USB, I am just interesting in the *very* *very*
> basic aspects of it. A simple lib/test_umh_module.c would do with a respective
> check that its loaded, given this is a requirement from the API. It also helps
> folks understand the core basic knobs without having to look at bfilter code.

I agree that lib/test_usermode_blob.c must be available eventually.
Right now we cannot add it to the tree, since we need to figure how interface
between kernel and usermode_blob will work based on real world use case
of bpfilter. Once it gets further along that would be the time to say:
"look, here is the test for fork_usermode_blob() and here how others (usb drivers)
can and should use it".
Today is not the right time to fix the api. Such lib/test_usermode_blob.c
would have to be constantly adjusted as we tweak bpfilter side becoming
unnecessary burden of us bpfilter developers.
Everyone really need to think of these patches as work in progress
and internal details and api of fork_usermode_blob() will change.

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
