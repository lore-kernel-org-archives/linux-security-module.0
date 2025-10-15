Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA95A314D36
	for <linux-security-module@vger.kernel.org>; Wed, 15 Oct 2025 22:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760568522; cv=none; b=TMKTm9CEM0yguMKMliN3/1dcKu2exY3WP+qqOgbLZyx50ZCHUB6HVQxi2foeU7p3pgAT9VcowHqQCEumIbjZDqZPlia20S0bn8U4Ni1o3HsH/d9hJBT3iEztqynNgjz70zXtrbpZ6PqtsazQQBWpQ5+hLimrN6JtItbKl990RmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760568522; c=relaxed/simple;
	bh=Zt/pWqHt/iqQ+2OV/rzrh0fmDpxk2J2y6d2dSCcAMnQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D0cnFu7qLHz4RNKch/4HQ9bVy5TcBAV93pg/W9wXpT9mmg0LHhYyFjykf+RrmZ8FgZye3F+GBb2H/rxF4cIGfM9I4aaf1FNFtceyxjFr7TfrDwVi1x5ob5GCkq7M3b7WdfhBnkvhP6XvytcBQow28Zu5QXNvgybogoei1wckq/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jkh12GVV; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jkh12GVV"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b5edecdf94eso59095a12.2
        for <linux-security-module@vger.kernel.org>; Wed, 15 Oct 2025 15:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760568520; x=1761173320; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VfHhobHRKUrZuY035WUhQS9GUM0Uyoej5h99Za9ASAY=;
        b=jkh12GVVDciv67h9o1dtfoMkgiOUJERwhdlF5WW0DfKfbPBii8OggGWqbZRHnhgWPe
         AB6XcScbLiyO2cSib7BCFJIDpFsX1bVfL3KLVyYyxFPzKKSmS5B9BOtiDD/pCMFczU89
         zJAnZNpg5bPN4Ke4M7GGQZUxPTpqYvrAfT137m69QawpSbia2QD8iaz+sLfpY4U1LITr
         wsqe473g5ZT9Ua1e5f4PSE+pPNpAjKYj4eE3vpH2q9N2PegoBnC1I7JXAvyLUQ0t36f8
         sq72oxgiyWPWq8UbXoOe6hZsGznOLdeoYgScyFvy2ET082yX+8+Mt5qsXRuav4V7u6bE
         Nvpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760568520; x=1761173320;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VfHhobHRKUrZuY035WUhQS9GUM0Uyoej5h99Za9ASAY=;
        b=aABzaTi2wozjR6ODbwfG69Ag5GTPv2zNlwzomKD6ZY+EYhVg7aGdJCVK/GDu3Brma9
         kf/C+1qJ7PpsmJN2XMgB8mobFEPKWCdz7P6xkFk+jDT89b6FaqRNvePTiMpdoktD3/dO
         HXvk8aF8ObxgIjE9f5xYE4I91ZzITkb8O9svvQ5z70rR7H6Jq11moTVGH2nmFaNoGJWP
         geW/gLhdZo7HE38pXYZz5BLoqEMvhsuF+ajfyg0PUn0T6vs8BfjqhuHokxCWNXcSbi+o
         PtGJVRiCSdHzd1QfEjtqclKYB0scuddh5GwQkerSRfTwgy25PbXvUr8c9wf6tOGixjgr
         WPBA==
X-Forwarded-Encrypted: i=1; AJvYcCX0Cit4ZBL5RnsYuYxdX3oNa8CLSMAgBVyZMbitQs9oKx/BYaVjF68ePMCYcVN5dFAPK0XiPK2IEkrlvzjrF9ZO5WfWxy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtECsVy9iHW1UuVro8gU2v7jFu4J2vSqoFfDjhBTeATEJVGRIg
	2dskWkDvajepiZLOf4UnUcrUMfj0w42LoQ4oswfxm9YEzAB7pxkfPwM8SdHZr4fKlBDeP0cuyvk
	Byw37aA==
X-Google-Smtp-Source: AGHT+IEyb34/gE6QWzF0uzhcKPL3N9PV8BEpaNWr9b3Rp3K51ypbe1jmOBzkgqmwgOny3WdOfUFKvL+VZBw=
X-Received: from pjz11.prod.google.com ([2002:a17:90b:56cb:b0:33b:a35b:861])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7351:b0:251:c33d:2783
 with SMTP id adf61e73a8af0-32da813ce42mr40108259637.23.1760568519460; Wed, 15
 Oct 2025 15:48:39 -0700 (PDT)
Date: Wed, 15 Oct 2025 15:48:38 -0700
In-Reply-To: <aPAWFQyFLK4EKWVK@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250827175247.83322-2-shivankg@amd.com> <20250827175247.83322-9-shivankg@amd.com>
 <aNVQJqYLX17v-fsf@google.com> <aNbrO7A7fSjb4W84@google.com> <aPAWFQyFLK4EKWVK@gourry-fedora-PF4VCD3F>
Message-ID: <aPAkxp67-R9aQ8oN@google.com>
Subject: Re: [f2fs-dev] [PATCH kvm-next V11 6/7] KVM: guest_memfd: Enforce
 NUMA mempolicy using shared policy
From: Sean Christopherson <seanjc@google.com>
To: Gregory Price <gourry@gourry.net>
Cc: Shivank Garg <shivankg@amd.com>, jgowans@amazon.com, mhocko@suse.com, jack@suse.cz, 
	kvm@vger.kernel.org, david@redhat.com, linux-btrfs@vger.kernel.org, 
	aik@amd.com, papaluri@amd.com, kalyazin@amazon.com, peterx@redhat.com, 
	linux-mm@kvack.org, clm@fb.com, ddutile@redhat.com, 
	linux-kselftest@vger.kernel.org, shdhiman@amd.com, gshan@redhat.com, 
	ying.huang@linux.alibaba.com, shuah@kernel.org, roypat@amazon.co.uk, 
	matthew.brost@intel.com, linux-coco@lists.linux.dev, zbestahu@gmail.com, 
	lorenzo.stoakes@oracle.com, linux-bcachefs@vger.kernel.org, 
	ira.weiny@intel.com, dhavale@google.com, jmorris@namei.org, 
	willy@infradead.org, hch@infradead.org, chao.gao@intel.com, tabba@google.com, 
	ziy@nvidia.com, rientjes@google.com, yuzhao@google.com, xiang@kernel.org, 
	nikunj@amd.com, serge@hallyn.com, amit@infradead.org, thomas.lendacky@amd.com, 
	ashish.kalra@amd.com, chao.p.peng@intel.com, yan.y.zhao@intel.com, 
	byungchul@sk.com, michael.day@amd.com, Neeraj.Upadhyay@amd.com, 
	michael.roth@amd.com, bfoster@redhat.com, bharata@amd.com, 
	josef@toxicpanda.com, Liam.Howlett@oracle.com, ackerleytng@google.com, 
	dsterba@suse.com, viro@zeniv.linux.org.uk, jefflexu@linux.alibaba.com, 
	jaegeuk@kernel.org, dan.j.williams@intel.com, surenb@google.com, 
	vbabka@suse.cz, paul@paul-moore.com, joshua.hahnjy@gmail.com, 
	apopple@nvidia.com, brauner@kernel.org, quic_eberman@quicinc.com, 
	rakie.kim@sk.com, cgzones@googlemail.com, pvorel@suse.cz, 
	linux-erofs@lists.ozlabs.org, kent.overstreet@linux.dev, 
	linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	pankaj.gupta@amd.com, linux-security-module@vger.kernel.org, 
	lihongbo22@huawei.com, linux-fsdevel@vger.kernel.org, pbonzini@redhat.com, 
	akpm@linux-foundation.org, vannapurve@google.com, suzuki.poulose@arm.com, 
	rppt@kernel.org, jgg@nvidia.com
Content-Type: text/plain; charset="us-ascii"

On Wed, Oct 15, 2025, Gregory Price wrote:
> On Fri, Sep 26, 2025 at 12:36:27PM -0700, Sean Christopherson via Linux-f2fs-devel wrote:
> > > 
> > > static struct mempolicy *kvm_gmem_get_policy(struct vm_area_struct *vma,
> > > 					     unsigned long addr, pgoff_t *pgoff)
> > > {
> > > 	*pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);
> > > 
> > > 	return __kvm_gmem_get_policy(GMEM_I(file_inode(vma->vm_file)), *pgoff);
> > 
> > Argh!!!!!  This breaks the selftest because do_get_mempolicy() very specifically
> > falls back to the default_policy, NOT to the current task's policy.  That is
> > *exactly* the type of subtle detail that needs to be commented, because there's
> > no way some random KVM developer is going to know that returning NULL here is
> > important with respect to get_mempolicy() ABI.
> > 
> 
> Do_get_mempolicy was designed to be accessed by the syscall, not as an
> in-kernel ABI.

Ya, by "get_mempolicy() ABI" I meant the uABI for the get_mempolicy syscall.

> get_task_policy also returns the default policy if there's nothing
> there, because that's what applies.
> 
> I have dangerous questions:

Not dangerous at all, I find them very helpful!

> why is __kvm_gmem_get_policy using
> 	mpol_shared_policy_lookup()
> instead of
> 	get_vma_policy()

With the disclaimer that I haven't followed the gory details of this series super
closely, my understanding is...

Because the VMA is a means to an end, and we want the policy to persist even if
the VMA goes away.

With guest_memfd, KVM effectively inverts the standard MMU model.  Instead of mm/
being the primary MMU and KVM being a secondary MMU, guest_memfd is the primary
MMU and any VMAs are secondary (mostly; it's probably more like 1a and 1b).  This
allows KVM to map guest_memfd memory into a guest without a VMA, or with more
permissions than are granted to host userspace, e.g. guest_memfd memory could be
writable by the guest, but read-only for userspace.

But we still want to support things like mbind() so that userspace can ensure
guest_memfd allocations align with the vNUMA topology presented to the guest,
or are bound to the NUMA node where the VM will run.  We considered adding equivalent
file-based syscalls, e.g. fbind(), but IIRC the consensus was that doing so was
unnecessary (and potentially messy?) since we were planning on eventually adding
mmap() support to guest_memfd anyways.

> get_vma_policy does this all for you

I assume that doesn't work if the intent is for new VMAs to pick up the existing
policy from guest_memfd?  And more importantly, guest_memfd needs to hook
->set_policy so that changes through e.g. mbind() persist beyond the lifetime of
the VMA.

> struct mempolicy *get_vma_policy(struct vm_area_struct *vma,
>                                  unsigned long addr, int order, pgoff_t *ilx)
> {
>         struct mempolicy *pol;
> 
>         pol = __get_vma_policy(vma, addr, ilx);
>         if (!pol)
>                 pol = get_task_policy(current);
>         if (pol->mode == MPOL_INTERLEAVE ||
>             pol->mode == MPOL_WEIGHTED_INTERLEAVE) {
>                 *ilx += vma->vm_pgoff >> order;
>                 *ilx += (addr - vma->vm_start) >> (PAGE_SHIFT + order);
>         }
>         return pol;
> }
> 
> Of course you still have the same issue: get_task_policy will return the
> default, because that's what applies.
> 
> do_get_mempolicy just seems like the completely incorrect interface to
> be using here.
