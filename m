Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10323218AB0;
	Mon,  3 Mar 2025 18:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741026380; cv=none; b=YZPRQFR3J/sFYroEYFoSZB3/KEhsIXadHrAs05jQPAxfiD0ZFXn3zMDxLgaf/ZMvGflDJSPjPJn2qnz5yQwrFjSo64IOCDUG5u00uvckNhhXr5ClVEYIM1WDfFyogxB/2fxEdw7dn8q5V9zQgwGjmGcL7JY5p+9HEJdSLmNc2UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741026380; c=relaxed/simple;
	bh=DkG1XJzDkXVrTrer0svkmS2I7Oi2rxJRTADzamkxNK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCaBu119N+07DtPiSX8SHdfuhHSxNMqw8Oa1xv/D14km5X0DV9tB+6rsY7K5cXNdnUhfbzI4PYKh6tZlalun3a3wZbqafhgAurDIk4ZFWx8Uoh8Vc+q/I7wXWeUajyXjft50xymbBQ4jUF67+XzqMrUPsv99PaICPD9lc8taBSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IsT4V5P9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IsT4V5P9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E59EC4CED6;
	Mon,  3 Mar 2025 18:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741026379;
	bh=DkG1XJzDkXVrTrer0svkmS2I7Oi2rxJRTADzamkxNK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IsT4V5P9fZjNrkvXq4NLjZAXln7pmANaCdtG0+bDs7BtoKXwaCtTDeuUKTPVgoPQc
	 FdwXrS7m03WWXhEW2zWWEY1ChXpCK/ww+uALVJQb31qiXkHzKvJopM0lD+sWtmZwlW
	 c63WvsptzN6BHZizfA2cPPZhI9FQ5rILrNQGllb/q7gmOl5WWJS7uAUG6Dgq8i9zcL
	 vlxY1IiLNQUIP0sDqxXVJKd4duzsUBglZ47t+rymRLZpLneV8S+YLba5Pzg0ky+7Ez
	 zcx7to8HiAmq7ep/8L237rJwvyJ4Kk7vXpYTwVIL/lODohHUB6uOA/cR2qfhpP27YB
	 uz1EdnAZWqJvw==
Date: Mon, 3 Mar 2025 10:26:16 -0800
From: Kees Cook <kees@kernel.org>
To: Maxwell Bland <mbland@motorola.com>
Cc: linux-hardening@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-security-module@vger.kernel.org,
	Serge Hallyn <serge@hallyn.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Andrew Wheeler <awheeler@motorola.com>,
	Sammy BS2 Que <quebs2@motorola.com>
Subject: Re: [RFC] Type-Partitioned vmalloc (with sample *.ko code)
Message-ID: <202503030942.307489FC8@keescook>
References: <uqgb234tm4svoz2yvbamzal2srxnjnwrj2coiimvuz5bzblbia@pfabobbxo2jf>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <uqgb234tm4svoz2yvbamzal2srxnjnwrj2coiimvuz5bzblbia@pfabobbxo2jf>

On Fri, Feb 28, 2025 at 02:57:40PM -0600, Maxwell Bland wrote:
> Dear Linux Hardening, Security, and Memory Management Mailing Lists,
> 
> This is primarily an FYI and an RFC. I have some code, included below,
> that could be dropped into a *.ko for the 6.1.X kernel, but really this
> mail is to query about ideas for acceptable upstream changes.
> 
> Thank you ahead of time for reading! If the title alone of this email
> sticks out and makes sense immediately, feel free to skip the
> introduction below.
> 
> INTRODUCTION
> 
> For the past few months, I have been sparring with recent CVE PoCs in
> the kernel, applying monkey patches to dynamic data structure
> allocations, attempting to prevent data-only attacks which use write
> gadgets to modify dynamically allocated struct fields otherwise declared
> constant.
> 
> I wanted to share, briefly, what I feel is a reasonable and general
> solution to the standard contemporary exploit procedure. For those
> unfamiliar with recent PoC's, see a case study of recent exploits in Man
> Yue Mo's article here:
> 
> https://github.blog/security/vulnerability-research/the-android-kernel-mitigations-obstacle-race/
> 
> Particularly, understanding the "Running arbitrary root commands using
> ret2kworker(TM)" section will give a general idea of the issue.
> 
> Summarizing, there are thousands of dynamic data structures alloc'd and
> free'd in the kernel all the time, for files, for processes, and so
> forth, and it is elementary to manipulate any instance of data, but hard
> to protect every single one of them. These range from trng device
> pointers to kworker queues---everything passing through vmalloc.
> 
> The strawman approach presented here is for security engineers to read
> CVE-XYZ-ABC PoC, identify the portion of the system being manipulated,
> and patch the allocation handler to protect just that data at the
> page-table layer, by:
> 
> - Reorganizing allocations of those structures so that they are on
> the same 2MB hugepage, adjacently, as otherwise existing hardware
> support to prevent their mutation (PTE flags) will trigger for unrelated
> data allocated adjacently.

This sounds like the "write rarely" proposal:
https://github.com/KSPP/linux/issues/130

which isolates chosen data structures into immutable memory, except for
specific helpers which are allowed to write to the memory. This is
needed most, by far, for page tables:
https://lore.kernel.org/lkml/20250203101839.1223008-1-kevin.brodsky@arm.com/

It looks from your example at the end that you're depending on a
hypervisor to perform the memory protection and fault handling? Or maybe
I'm misunderstanding where the protection is happening?

> - Writing a handler to ensure non-malicious modifications, e.g.  keeping
> "const" fields const, ensuring modifications to other fields happen at
> the right physical PC values and the right pages, handling atomic
> updates so that the exception fault on these values maintains ordering
> under race conditions (maybe "doubling up" on atomic assembly operations
> due to certain microarch issues at the chipset level, see below), and so
> on, and so forth.

As I understand it, this depends on avoiding ROP attacks that will hijack
those PC values. (This is generally true for the entire concept of
"write rarely", though -- nothing specific to this implementation.)

The current proposals use a method of gaining temporary write permission
during the execution path of an approved writer (rather than doing it
via the fault handler, which tends to be very expensive).

> Eventually, this Sisyphean task amounts to a mountain worth of
> point-patches and encoded wisdom, valuable but absurd insofar as there
> are a thousand more places for an exploit to manipulate instead of the
> protected ones.
> 
> DATATYPE PARTITIONED VIRTUAL MEMORY ALLOCATION
> 
> The above process can be generalized by changing Linux's vmalloc to
> behave more like seL4 (though not identically), by tying allocation
> itself to the typing of an object:
> 
> https://docs.sel4.systems/Tutorials/untyped.html "objects should be
> 
> Without the caveat that objects must be "allocated in order of size,
> largest first, to avoid wasting memory."
> 
> I demonstrated something similar previously to prevent the intermixed
> allocation of SECCOMP BPF code pages with data on ARM64's Android Kernel
> here (with which you may be familiar):
> 
> https://lore.kernel.org/all/20240423095843.446565600-1-mbland@motorola.com/

Did this v4 go any further? I see earlier versions had some discussion
around it.

> That said, the above patch does not do the same for other critical
> dynamically allocated data.
> 
> So, for instance, to prevent struct file manipulation, I've written the
> following code into a init-time loaded kernel (v6.1.x) module:
> 
> 	filp_cachep_ind =
> 	        (struct kmem_cache **)kallsyms_lookup_name_ind("filp_cachep");
> 	/* Just nix the existing file cache for one which is page-aligned */
> 	*filp_cachep_ind = kmem_cache_create(
> 	        "filp", sizeof(struct file), PAGE_SIZE,
> 	        SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT, NULL);
> 
> I.e. aligning cache allocations to PAGE_SIZE. See the appendix for
> associated module code.

Just a semantic note: this is kmalloc not vmalloc. You mention
vmalloc, but I don't really see anything specific to vmalloc vs kmalloc
in here... Do you mean to make a distinction between the allocators?
Linux has 3 allocators: page(buddy), kmalloc(kmem), and vmalloc(vmap).

> Of course, this is a little insane since:
> 
> (1) I'm effectively double allocating the cache to change how
> the structs are allocated, because I can't change the kernel's
> init process (part of this has to do with Google's GKI).
> 
> (2) The kmem infrastructure needs to be also monkey patched so
> that this "PAGE_SIZE" alignment actually indicates that objects
> can still be allocated next to eachother at the originally
> set alignment, reducing dead space due to wasted bytes (not
> implemented). And, most important

A dedicated kmem cache should live in its own page, so I don't think
anything special is needed for things already using kmem_cache_create(),
except that they must not be aliased with same-sized allocations. (i.e.
include the SLAB_NO_MERGE flag.)

> (3) struct file is just one case of thousands.
> 
> However, it seems fine for protecting a specific, given file allocation
> targeted by something like:
> 
> https://github.com/chompie1337/s8_2019_2215_poc/blob/34f6481ed4ed4cff661b50ac465fc73655b82f64/poc/knox_bypass.c#L50
> 
> given you also have the appropriate protection handlers (see appendix
> below), this works fine even outside of access to a HVCI system.
> 
> Hopefully the above reasoning is clear enough. If so, the proposal
> (though it is not clear the best way to do this with standard C, maybe
> some preprocessor magic), would be to pass the data's type itself to
> kmem_cache_create (and other APIs used to reserve virtual memory for a
> struct).
> 
> kmem_cache_create would then use this type identifier to allocate and
> resolve a region of virtual memory for just objects of that type.

Doing this automatically requires compiler support to provide a way to
distinguish types from the lvalue of an expression:

// kmalloc has no idea what type it will provide an allocation for
struct whatever *p = kmalloc(...);

Or, for the allocation system in the kernel to be totally rearranged to
pass the variable into a helper so the type (and things like alignment)
can be introspected. I proposed doing that here:
https://lore.kernel.org/all/20240822231324.make.666-kees@kernel.org/

It's unclear if this approach will be successful, and I've been waiting
for compiler support of "counted_by" to be more widely usable.

An alternative is to separate allocations by call site (rather than
type). This has some performance benefits too, and requires no special
compiler support. I proposed that here:
https://lore.kernel.org/all/20240809072532.work.266-kees@kernel.org/

With this in place, simple Use-After-Free type confusion is blocked,
but not cross-cache attacks. To defend against cross-cache UAF attacks,
full separation of the virtual memory spaces ("memory allocation pinning")
is needed. SLAB_VIRTUAL has been proposed here:
https://lore.kernel.org/lkml/20230915105933.495735-1-matteorizzo@google.com/

> This is an old idea, and I've found evidence of it in, for example,
> Levy's discussion of Hydra in 1984's Capability-Based Computer Systems,
> which contains the following statement regarding object allocations:
> "the appropriate list for an object’s fixed part is determined by a
> hashing function on the object’s 64-bit name" (though my implication
> here is that the word "name" should be the 64 bit type. I also don't see
> much reference to the hardware page tables, and write exception faults
> which are the motivation behind the design of such a system.
> 
> CONCLUSION
> 
> Whatever the implications are, beyond seL4's rough sketch of this idea,
> I cannot find Type-Partitioned Virtual Memory Allocation coded in many
> other places.
> 
> Hopefully, even for those unfamiliar with the exploits in question, the
> benefits here are clear, as it closes a certain semantic gap between
> heap allocations and the hardware's ability to protect memory. 
> 
> Thoughts? I've tried, pretty desperately, to figure out an
> alternative/easy solution here, but knowing current hardware exception
> fault handlers, I see few other ways that we will ever have a system to
> prevent the repercussions of write gadgets.
> 
> References? I know of the existing efforts toward HVCI, KASAN, and the
> KSPP, but hopefully the distinction here is clear enough: I am
> referring, specifically to the pain of adjacency between, for example,
> f_lock and f_ops, and the implications that this has for hardware. From
> what I understand (very little), even OpenBSD does not, though maybe
> there has been some discussion of it somewhere in
> https://www.openbsd.org/papers/ ... I found nothing for all those
> grep-matching "alloc".

Yes, the "write rarely" case is painful since most structures have
elements that are very frequently written. :(

> Please let me know if you've seen anything else discussing this problem,
> particularly anything that might save me from having to rewrite the
> virtual memory allocator in our OS to prevent these attacks.

Hopefully some (all) of the proposals above should provide you with the
desired coverage, though if you're doing this on arm64 you'll need to
implement the arch-specific portions of SLAB_VIRTUAL on arm64.

> Solutions? I have also been weighing a few other ideas, such as a second
> page, similar to or built on KASAN, to understand the "allocation map"
> for a given page: but the issue is this allocation map page, or datatype
> tag, must then also have a window of writability unless maintained by a
> hypervisor or otherwise isolated system.
> 
> Thank you again for your time in considering this subject, and providing
> your thoughts in this public forum.

I'd say there are two other things that probably need some
consideration, which are hardware memory tagging, which should provide
much of the SLAB_VIRTUAL protection without the TLB overhead nor
confined memory usage limits.

Another possibility is using stuff like Top Byte Ignore (TBI, arm64)
or Linear Address Mapping (LAM, x86) where a hybrid hardware/software
memory tagging style protection could be built with compiler support
(i.e. checking the pointer tags against the current tag for a given
memory region before writes, or before first use in a function, etc).

There are a lot of options for protecting against UAF and data-only
attacks, but they span a pretty wide range of performance impact, unmet
hardware capabilities, and unmet compiler implementations...

I'd really like to see more movement in this whole area, but it's been a
tricky balancing act. :P

> The patches/discussions here:
> https://lore.kernel.org/all/rsk6wtj2ibtl5yygkxlwq3ibngtt5mwpnpjqsh6vz57lino6rs@rcohctmqugn3/
> https://lore.kernel.org/all/994dce8b-08cb-474d-a3eb-3970028752e6@infradead.org/

Has this moved forward? This got to a v5...

> https://lore.kernel.org/all/puj3euv5eafwcx5usqostpohmxgdeq3iout4hqnyk7yt5hcsux@gpiamodhfr54/

I think Peter Zijlstra solved all the BPF KCFI interactions? See commit
4f9087f16651 ("x86/cfi,bpf: Fix BPF JIT call")

> https://lore.kernel.org/all/h4hxxozslqmqhwljg5sfold764242pmw5y77mdigaykw5ehjjs@nc4xtzw7xprm/

Did this move forward? Another v5...

> https://lore.kernel.org/all/20240503131910.307630-1-mic@digikod.net/

I'd like to see something like Heki move forward too. :)


-Kees

-- 
Kees Cook
