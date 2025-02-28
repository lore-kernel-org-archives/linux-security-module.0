Received: from mx0a-00823401.pphosted.com (mx0a-00823401.pphosted.com [148.163.148.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D6823F38F;
	Fri, 28 Feb 2025 20:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740776304; cv=none; b=U0cWR5zL3QbHXhNITVbwEQYwTB4PMVlcpA4VmF3opFGMSPtX595OcBQlcNdCq6s1O8vyhZeH72HQpl2DkbgZcRqaZfC3sZoEbi2mNPIUAMGeOrYYOC6iMD8Q4m0POFdBbhjkHuGEA7tA14l0E7qPojlneWeJ9RgUQ/odI+yixUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740776304; c=relaxed/simple;
	bh=NIvmfVEYo264FtLaXd3dD1piSEJVGuUis/Yd0djUm9E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EURxApfRyEVkJtpvsjnsWqld0zmtOzENtdRCM5LNkBAwxRcF4pmz129YN8/n4Jf3UPO8z6bsfqyFYC9IoYIc10AMe+0rhglPQYRwD8xJbrx02R1enfWybOCjWw8KWP8LcsoTky7uIts25v9RGnmm77pZ75LQi61E7Pr3L/4U/50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=nIW3xHVc; arc=none smtp.client-ip=148.163.148.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="nIW3xHVc"
Received: from pps.filterd (m0355085.ppops.net [127.0.0.1])
	by mx0a-00823401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51SK7vX5001424;
	Fri, 28 Feb 2025 20:57:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM202306; bh=uz5fc0o+uCPEt9zw/vgWN
	W6RVv+G0BqESnAsi3k2YvE=; b=nIW3xHVcri41GMCDIt8oMxtWf2LMjrQvrziwQ
	tNYMAtrBbJQD2LzrnMPM5D1rVMnTl3FHpNDAxfPCAQ/g2v5cwrBAb0BXHEKIwraD
	dr+09b/Z8K9XpTRlzP+sk82XZHHgdDE9gN0I7EVI9PkHjzCQnw/Jb0ICfUouvDNH
	b+NT9yxN/ZvLuQ5kjHee2te23gNydmA6JS8bqYRQxXid3wggyJ84hf20LnpSPF7i
	+1IckRnx27TwJ9DjIJmIanJsGrpFnebHGTkx7gICAPG9lM5d/c+sOwh0uGhI8UX3
	1kdjysUQRibSMR+REj/z6XT4Nx9W8BeUQWBpjkvId6qQPkKcA==
Received: from iadlppfpol1.lenovo.com ([104.232.228.80])
	by mx0a-00823401.pphosted.com (PPS) with ESMTPS id 4539bb1rnh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 20:57:41 +0000 (GMT)
Received: from ilclmmrp01.lenovo.com (unknown [100.65.83.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by iadlppfpol1.lenovo.com (Postfix) with ESMTPS id 4Z4LBX3dpcz8flSQ;
	Fri, 28 Feb 2025 20:57:40 +0000 (UTC)
Received: from ilclasset02 (ilclasset02.mot.com [100.64.11.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mbland@motorola.com)
	by ilclmmrp01.lenovo.com (Postfix) with ESMTPSA id 4Z4LBX151pz3nd85;
	Fri, 28 Feb 2025 20:57:40 +0000 (UTC)
Date: Fri, 28 Feb 2025 14:57:40 -0600
From: Maxwell Bland <mbland@motorola.com>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-security-module@vger.kernel.org, Serge Hallyn <serge@hallyn.com>,
        =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Andrew Wheeler <awheeler@motorola.com>,
        Sammy BS2 Que <quebs2@motorola.com>, mbland@motorola.com
Subject: [RFC] Type-Partitioned vmalloc (with sample *.ko code)
Message-ID: <uqgb234tm4svoz2yvbamzal2srxnjnwrj2coiimvuz5bzblbia@pfabobbxo2jf>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: v6XwhvuRT-Cd9dVhV0Ci017aR-bSEYqG
X-Authority-Analysis: v=2.4 cv=StFq6OO0 c=1 sm=1 tr=0 ts=67c22345 cx=c_pps a=LMRlKrtnqgVLeY6h3uZyow==:117 a=LMRlKrtnqgVLeY6h3uZyow==:17 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=ClEIKiW6AAAA:8 a=rIwV-iKiAAAA:8 a=VwQbUJbxAAAA:8 a=xy62-MGwAAAA:8 a=NEAV23lmAAAA:8
 a=3tcz3bTJAAAA:8 a=JfrnYn6hAAAA:8 a=edGIuiaXAAAA:8 a=vnREMb7VAAAA:8 a=lWXDd5jb84Ew4EOMe_0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=Bh4fX1zalB0A:10 a=-FEs8UIgK8oA:10 a=SznFzKNPCmLvHFQx5ISb:22 a=iZj8yvaUcTUqdV_w9hB4:22 a=GnfvfRyZ3owwWl8_2aAi:22
 a=4EbjBm0RLgFgoQzmu6QD:22 a=1CNFftbPRP8L7MoqJWF3:22 a=4kyDAASA-Eebq_PzFVE6:22
X-Proofpoint-GUID: v6XwhvuRT-Cd9dVhV0Ci017aR-bSEYqG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_06,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 malwarescore=0 spamscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502280152

Dear Linux Hardening, Security, and Memory Management Mailing Lists,

This is primarily an FYI and an RFC. I have some code, included below,
that could be dropped into a *.ko for the 6.1.X kernel, but really this
mail is to query about ideas for acceptable upstream changes.

Thank you ahead of time for reading! If the title alone of this email
sticks out and makes sense immediately, feel free to skip the
introduction below.

INTRODUCTION

For the past few months, I have been sparring with recent CVE PoCs in
the kernel, applying monkey patches to dynamic data structure
allocations, attempting to prevent data-only attacks which use write
gadgets to modify dynamically allocated struct fields otherwise declared
constant.

I wanted to share, briefly, what I feel is a reasonable and general
solution to the standard contemporary exploit procedure. For those
unfamiliar with recent PoC's, see a case study of recent exploits in Man
Yue Mo's article here:

https://github.blog/security/vulnerability-research/the-android-kernel-mitigations-obstacle-race/

Particularly, understanding the "Running arbitrary root commands using
ret2kworker(TM)" section will give a general idea of the issue.

Summarizing, there are thousands of dynamic data structures alloc'd and
free'd in the kernel all the time, for files, for processes, and so
forth, and it is elementary to manipulate any instance of data, but hard
to protect every single one of them. These range from trng device
pointers to kworker queues---everything passing through vmalloc.

The strawman approach presented here is for security engineers to read
CVE-XYZ-ABC PoC, identify the portion of the system being manipulated,
and patch the allocation handler to protect just that data at the
page-table layer, by:

- Reorganizing allocations of those structures so that they are on
the same 2MB hugepage, adjacently, as otherwise existing hardware
support to prevent their mutation (PTE flags) will trigger for unrelated
data allocated adjacently.

- Writing a handler to ensure non-malicious modifications, e.g.  keeping
"const" fields const, ensuring modifications to other fields happen at
the right physical PC values and the right pages, handling atomic
updates so that the exception fault on these values maintains ordering
under race conditions (maybe "doubling up" on atomic assembly operations
due to certain microarch issues at the chipset level, see below), and so
on, and so forth.

Eventually, this Sisyphean task amounts to a mountain worth of
point-patches and encoded wisdom, valuable but absurd insofar as there
are a thousand more places for an exploit to manipulate instead of the
protected ones.

DATATYPE PARTITIONED VIRTUAL MEMORY ALLOCATION

The above process can be generalized by changing Linux's vmalloc to
behave more like seL4 (though not identically), by tying allocation
itself to the typing of an object:

https://docs.sel4.systems/Tutorials/untyped.html "objects should be

Without the caveat that objects must be "allocated in order of size,
largest first, to avoid wasting memory."

I demonstrated something similar previously to prevent the intermixed
allocation of SECCOMP BPF code pages with data on ARM64's Android Kernel
here (with which you may be familiar):

https://lore.kernel.org/all/20240423095843.446565600-1-mbland@motorola.com/

That said, the above patch does not do the same for other critical
dynamically allocated data.

So, for instance, to prevent struct file manipulation, I've written the
following code into a init-time loaded kernel (v6.1.x) module:

	filp_cachep_ind =
	        (struct kmem_cache **)kallsyms_lookup_name_ind("filp_cachep");
	/* Just nix the existing file cache for one which is page-aligned */
	*filp_cachep_ind = kmem_cache_create(
	        "filp", sizeof(struct file), PAGE_SIZE,
	        SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT, NULL);

I.e. aligning cache allocations to PAGE_SIZE. See the appendix for
associated module code.

Of course, this is a little insane since:

(1) I'm effectively double allocating the cache to change how
the structs are allocated, because I can't change the kernel's
init process (part of this has to do with Google's GKI).

(2) The kmem infrastructure needs to be also monkey patched so
that this "PAGE_SIZE" alignment actually indicates that objects
can still be allocated next to eachother at the originally
set alignment, reducing dead space due to wasted bytes (not
implemented). And, most important

(3) struct file is just one case of thousands.

However, it seems fine for protecting a specific, given file allocation
targeted by something like:

https://github.com/chompie1337/s8_2019_2215_poc/blob/34f6481ed4ed4cff661b50ac465fc73655b82f64/poc/knox_bypass.c#L50

given you also have the appropriate protection handlers (see appendix
below), this works fine even outside of access to a HVCI system.

Hopefully the above reasoning is clear enough. If so, the proposal
(though it is not clear the best way to do this with standard C, maybe
some preprocessor magic), would be to pass the data's type itself to
kmem_cache_create (and other APIs used to reserve virtual memory for a
struct).

kmem_cache_create would then use this type identifier to allocate and
resolve a region of virtual memory for just objects of that type.

This is an old idea, and I've found evidence of it in, for example,
Levy's discussion of Hydra in 1984's Capability-Based Computer Systems,
which contains the following statement regarding object allocations:
"the appropriate list for an object’s fixed part is determined by a
hashing function on the object’s 64-bit name" (though my implication
here is that the word "name" should be the 64 bit type. I also don't see
much reference to the hardware page tables, and write exception faults
which are the motivation behind the design of such a system.

CONCLUSION

Whatever the implications are, beyond seL4's rough sketch of this idea,
I cannot find Type-Partitioned Virtual Memory Allocation coded in many
other places.

Hopefully, even for those unfamiliar with the exploits in question, the
benefits here are clear, as it closes a certain semantic gap between
heap allocations and the hardware's ability to protect memory. 

Thoughts? I've tried, pretty desperately, to figure out an
alternative/easy solution here, but knowing current hardware exception
fault handlers, I see few other ways that we will ever have a system to
prevent the repercussions of write gadgets.

References? I know of the existing efforts toward HVCI, KASAN, and the
KSPP, but hopefully the distinction here is clear enough: I am
referring, specifically to the pain of adjacency between, for example,
f_lock and f_ops, and the implications that this has for hardware. From
what I understand (very little), even OpenBSD does not, though maybe
there has been some discussion of it somewhere in
https://www.openbsd.org/papers/ ... I found nothing for all those
grep-matching "alloc".

Please let me know if you've seen anything else discussing this problem,
particularly anything that might save me from having to rewrite the
virtual memory allocator in our OS to prevent these attacks.

Solutions? I have also been weighing a few other ideas, such as a second
page, similar to or built on KASAN, to understand the "allocation map"
for a given page: but the issue is this allocation map page, or datatype
tag, must then also have a window of writability unless maintained by a
hypervisor or otherwise isolated system.

Thank you again for your time in considering this subject, and providing
your thoughts in this public forum.

Best Regards,
Maxwell

REFERENCES

The patches/discussions here:
https://lore.kernel.org/all/rsk6wtj2ibtl5yygkxlwq3ibngtt5mwpnpjqsh6vz57lino6rs@rcohctmqugn3/
https://lore.kernel.org/all/994dce8b-08cb-474d-a3eb-3970028752e6@infradead.org/
https://lore.kernel.org/all/puj3euv5eafwcx5usqostpohmxgdeq3iout4hqnyk7yt5hcsux@gpiamodhfr54/
https://lore.kernel.org/all/h4hxxozslqmqhwljg5sfold764242pmw5y77mdigaykw5ehjjs@nc4xtzw7xprm/
https://lore.kernel.org/all/20240503131910.307630-1-mic@digikod.net/

PoC's floating around the following CVEs:

- CVE_2024_1086 (pagetable modification)
- CVE_2021_33909 (seccomp codepage modification)
- CVE_2022_22265 (selinux_enforcing state, AVC cache corruption)
- CVE_2021_2215 (struct file pointer manipulation)
- CVE_2022_22057 (kworker queue manipulation)

Some public discussions I've given here include additional notes on CFI
primitives and other errata (excuse my public speaking skills and
ignorance, as this is a developing subject for me):

https://www.youtube.com/watch?v=Rgg01n4jdBU&t=4s&pp=ygUNbWF4d2VsbCBibGFuZA%3D%3D
https://www.youtube.com/watch?v=3DBGardQsHk&t=1844s&pp=ygUNbWF4d2VsbCBibGFuZA%3D%3D

APPENDIX

Below, I'll include a specific example of protecting struct file, for
the 6.1.x kernel, you'll have to excuse the stylistic and questionable
hacks here, since the GKI ensures any useful changes to the kernel need
to use the always-on kernel self-patching mechanism.

- Patching File Allocation:

static struct file *alloc_file_handler(const struct path *path, int flags,
				       const struct file_operations *fop)
{
	struct file *file;

	file = alloc_empty_file_ind(flags, current_cred());

	if (IS_ERR(file))
		return file;

	/* TODO: had to expand out the direct struct assignment here
	 * since the snapdragon cannot handle perm faults on stp instructions
	 * with two input registers */
	file->f_path.dentry = path->dentry;
	file->f_path.mnt = path->mnt;
	file->f_inode = path->dentry->d_inode;
	file->f_mapping = path->dentry->d_inode->i_mapping;
	file->f_wb_err = filemap_sample_wb_err(file->f_mapping);
	file->f_sb_err = file_sample_sb_err(file);
	if (fop->llseek)
		file->f_mode |= FMODE_LSEEK;
	if ((file->f_mode & FMODE_READ) && (fop->read || fop->read_iter))
		file->f_mode |= FMODE_CAN_READ;
	if ((file->f_mode & FMODE_WRITE) && (fop->write || fop->write_iter))
		file->f_mode |= FMODE_CAN_WRITE;
	file->f_iocb_flags = iocb_flags(file);
	file->f_mode |= FMODE_OPENED;
	file->f_op = fop;
	if ((file->f_mode & (FMODE_READ | FMODE_WRITE)) == FMODE_READ)
		i_readcount_inc(path->dentry->d_inode);

	/* NOTE/TODO: until the underlying vmalloc infrastructure is
	 * patches or rewritten, it is difficult, if not impossible,
	 * to effectively and efficiently protect all struct file's in the
	 * kernel. The same holds for kworker queues and many other
	 * dynamically allocated data structures. Will message mailing
	 * list about this and maybe continue working on it for the next
	 * decade )-: */
	qcom_smc_waitloop("alloc_file_handler_smc", SMCID_TAG_MEM_PROTECT,
			__virt_to_phys(file), PAGE_SIZE);

	return file;
}

static void __fput_handler(struct file *file)
{
	struct dentry *dentry = file->f_path.dentry;
	struct vfsmount *mnt = file->f_path.mnt;
	struct inode *inode = file->f_inode;
	fmode_t mode = file->f_mode;
	bool run_dput = true;

	if ((!(file->f_mode & FMODE_OPENED)))
		goto out;

	might_sleep();

	/* Hacks because of QCOM's perm fault handler */
	if (atomic_long_read(&file->f_count) == 0xFFFFFFFFFFFFFFFF)
		return;
	if (atomic_long_read(&file->f_count) == 0x0)
		atomic_long_set(&file->f_count, 0xFFFFFFFFFFFFFFFF);

	fsnotify_close(file);

	/*
         * The function eventpoll_release() should be the first called
         * in the file cleanup chain.
         */
	eventpoll_release_ind(file);

	locks_remove_file_ind(file);

	ima_file_free(file);
	if ((file->f_flags & FASYNC)) {
		if (file->f_op->fasync)
			file->f_op->fasync(-1, file, 0);
	}
	if (file->f_op->release)
		file->f_op->release(inode, file);

	if ((S_ISCHR(inode->i_mode) && inode->i_cdev != NULL &&
	     !(mode & FMODE_PATH))) {
		cdev_put_ind(inode->i_cdev);
	}
	fops_put(file->f_op);
	put_pid(file->f_owner.pid);
	put_file_access(file);
	if (run_dput)
		dput(dentry);
	if ((mode & FMODE_NEED_UNMOUNT))
		dissolve_on_fput_ind(mnt);
	mntput(mnt);
	qcom_smc_waitloop("__fput_handler_smc", SMCID_TAG_MEM_UNPROTECT,
			  __virt_to_phys(file), PAGE_SIZE);
out:

	file_free(file);
}

And on the fault handler side, because the kmem cache allocation places
each struct file on a separate page. Maintaining the mappings of type is
pretty easy to resolve via the SMC call.

if (type == FILE_STRUCT_TYPE) {
    if (ipa % PAGE_SIZE == 0x048) {
	// manage writes to the atomic type/updates according to CASA semantics on ARM64, etc
    }
    if (ipa % PAGE_SIZE == 0x030) {
	// manage writes to the atomic type/updates according to CASA semantics on ARM64, etc
    }
    ... // prevent writes to f_ops, etc, etc, etc
}

