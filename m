Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E404A8A14
	for <linux-security-module@vger.kernel.org>; Wed,  2 Sep 2026 15:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788362433; cv=none; b=Rte5GXpRngpbDXUnLk3qGZ7N2YSj0HdkgGC8RvvqI8Rt0OjdMvtG9kqDFkYAtTotMbBS7OTb+0FHpWYHK8787XduWSsVvR9QW9mSyeW7yOCnnJ6yNjq1lWD2h3HDUPGxuEdVQD6du17TCltgAWXl7aRaVjCGcvDk67MLW2R7sFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788362433; c=relaxed/simple;
	bh=7xuDMIlFysPCGTCdJAsweWLwA/wrkwLbnesyHF9L3Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PGczTvElzmxxJz8b3MoaEpQ2vJZVoi6jxqFndoVVeA6825QD7/V+KnxWqb0BG32iqlfDLXM662FOQCMxaXjKzRsdS6ZThVVDOtBxbsefNP35jO0unflC3OGDD2iJTg3Y89xW9H2nIXRUAzuBGw+YrKm5pa98RQRu/X2NrMFzqtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rJ7T+BOJ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rJ7T+BOJ"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48441a2ba1bso814553f8f.1
        for <linux-security-module@vger.kernel.org>; Wed, 02 Sep 2026 08:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788362430; x=1788967230; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ba9zSR0pFL6J1qeSltvfRoRTGU1ERDBWr20h/vbRz9o=;
        b=rJ7T+BOJsKL8xsUmp8sVc2QQI3Qfs5ycY8z05IP/J+zPtC8yJQzOSFzV71byya2IyT
         VJJVtQYsm34uGhNMWTVUtGOwKPQWdyaojOT8/vDq/ufacMbrEvHep7limHrCuS/d5yer
         fmKelJWPD7hMDcYCFSVkyPHud3Cdf2M+I27i/VNERvBEik8rVFSWuLfgdFsMxoIL4A4i
         BNw4/8KtX2SosfwOwGMRR/5tx5nlmOUo8ctLghp3QxJvi+2siOVT8AnKW+NpRWMbkLK6
         O291vZrpaAHvEg2OJMB+5mOgnuSeSoCkn7VNFMetYLLRkAsyY7nBmaLEYy6KOKSlGT8+
         OLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788362430; x=1788967230;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Ba9zSR0pFL6J1qeSltvfRoRTGU1ERDBWr20h/vbRz9o=;
        b=oamnxMAyCdWr0dZQnd86ARtZsn0B685F3BiFxCS9LJu21XUcaj0ir03z3yyAuNu98o
         U2+fisQObVFH0/0Jnz3FbbakgJ2SugDorC0GdxFdZlrJRORa7Jva8KSkLcSfuGe1C33m
         MI2TeImiqYvmJmr2wU1jVzXkwmjrV8dF86yoN5yjRqjIdYmNF42326Q0Cx+CNIQBgego
         J+dJ8ndkR7qEo5l7CKnXjt84cxcSCc86/u69H6fku1wsrQBE9a0PMfLsMRLkM8ynTlCR
         mXPj33ef3h6Vce2Ya7wtCe/vkuRkwOxJyxTUSjZUl1IzBmOmfh0E6g67+bSR8YMo0qvz
         ltBg==
X-Forwarded-Encrypted: i=1; AKwUvByPelpZPzgUj+OwaP+yqqIvC5KgJ3eNrGW6JTS+KYnuB0kRJMgqfQP77reeEKkWwaBAbI4Y4Q63RzAQ/zvy50ujD2mi9zo=@vger.kernel.org
X-Gm-Message-State: AFuF++l9PN0tOZKq2Jj07egI7tAO9VQh6Z/LORUZlxFGranf8SVFDoJH
	PMKxIxc1dkFZywWuQ3VLVWpXjpzzmROTLsmQL18LKASaSlIdqPNSoJwM
X-Gm-Gg: AYBFou3VszWAmo6g+PyFFpc7Pvjq+n1rUqasI7lijrMI2imy+w4aO/asg8BvrzdI9L4
	PCkGxzFOnoKAczEE5RGv70nahVvKu0C4kcUbmVp1E0o6ipWuzLy76MuM5ZG+sXIfhr1RQnwePEh
	iOtOa0DdJm5y5PauraXic3X1nGX5Lus8Bm9s1Le2nnDLwPgVV7hP3qWnmdgdEZgzbkjCWqMYRO6
	Yc47vRVgb6rC93AIbeGFahxsJkmR7i63Wa1COqTrGV6Ec0NMOGWxwHThFCzwGcwRLhezWgXzIv7
	G4pqbAWfzoZRvQZ9Y1mryoSoZePgarLHcqgECifvvn+FgpX7WrHWxYlqoomrvH1P32dpK+y2RQL
	DsMHSYrFCJ5K/DrKoB5tYaZjLKQ/hsnwN3CmJsBbxV6ByG77xqPKjsW/yt7Lmf+sV2ybxN2EpVI
	DPYAyWJy3xcXxCQj8aBHRK6Z3VopPB8nMKCJc+5yviCPvlWOtkLvP35RmQikG5TbyMqUE6
X-Received: by 2002:a05:6000:71c:b0:482:ee81:f0ca with SMTP id ffacd0b85a97d-48488dfd8bamr12215044f8f.12.1788362429459;
        Wed, 02 Sep 2026 08:20:29 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448e72c28sm7368681f8f.6.2026.09.02.08.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 08:20:27 -0700 (PDT)
Date: Wed, 2 Sep 2026 15:31:02 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: bpf <bpf@vger.kernel.org>, lsm <linux-security-module@vger.kernel.org>,
	netdev <netdev@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Matt Bobrowski <matt@bobrowski.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH bpf-next 1/7] bpf: Allow BPF LSM programs to attach to
 more hooks
Message-ID: <aphBNqQK0JeVy5Sm@mail.gmail.com>
References: <20260831110934.241898-1-a.s.protopopov@gmail.com>
 <20260831110934.241898-2-a.s.protopopov@gmail.com>
 <CAHC9VhT7=wMsB9mERWoiM6pF+_T1=2tyAsSrxMphhtdE2NPHMw@mail.gmail.com>
 <apbU8-fpioNIwUA8@mail.gmail.com>
 <CAHC9VhQbWPqEz5g1rVcMyJgrzzd4cQuwi7cddgJQK1H3ugMz7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhQbWPqEz5g1rVcMyJgrzzd4cQuwi7cddgJQK1H3ugMz7A@mail.gmail.com>

On 26/09/01 06:15PM, Paul Moore wrote:
> On Tue, Sep 1, 2026 at 9:26 AM Anton Protopopov
> <a.s.protopopov@gmail.com> wrote:
> > On 26/08/31 06:42PM, Paul Moore wrote:
> > > On Mon, Aug 31, 2026 at 6:59 AM Anton Protopopov
> > > <a.s.protopopov@gmail.com> wrote:
> > > >
> > > > The BPF LSM programs are allowed to attach to LSM hooks, all of which
> > > > are defined in the <lsm_hook_defs.h> header file.  From BPF's point
> > > > of view the set of attachment points is defined in the bpf_lsm_hooks
> > > > BTF set. By analogy with existing code, add a new header file
> > > > <bpf_lsm_hook_defs.h> which will also be included in the bpf_lsm_hooks
> > > > BTF set.
> > > >
> > > > This change allows attaching BPF LSM programs to more functions.
> > > > The actual hooks are added in subsequent commits.
> > > >
> > > > Each BPF hook calls a [__weak] noinline function each time a hook is
> > > > reached. This may be too expensive for hot paths if a BPF program is
> > > > not attached. A future commit will optimize this by adding a per-hook
> > > > static key and inc/dec it on attach/detach. This way disabled hooks
> > > > will be bypassed efficiently.
> > > >
> > > > Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> > > > ---
> > > >  MAINTAINERS                       |  1 +
> > > >  include/linux/bpf_lsm.h           | 12 ++++++++++++
> > > >  include/linux/bpf_lsm_hook_defs.h |  6 ++++++
> > > >  kernel/bpf/bpf_lsm.c              |  2 ++
> > > >  4 files changed, 21 insertions(+)
> > > >  create mode 100644 include/linux/bpf_lsm_hook_defs.h
> > >
> > > Adding new BPF hooks in the kernel is one thing, but adding new BPF
> > > LSM hooks outside of the LSM framework is likely to be problematic as
> > > these new hooks operate disconnected from the LSM framework (callback
> > > and LSM kernel object state management).  We've seen bugs in the past
> > > caused by the BPF LSM trying to operate independently of the LSM
> > > framework, something like this will only make that worse.
> >
> > Could you please point me to some of the bugs you mention, such that
> > I understand exactly what you mean?
> 
> The latest that I'm aware of was a few months ago:
> 
> https://lore.kernel.org/bpf/20260628201103.3624525-1-mattbobrowski@google.com

So, for this one patch specifically uses the same fix.

> > I am not really seeing how the
> > real LSM hooks differ from the ones added here (from BPF point of
> > view, and the objects it can access via kfuncs/maps).
> 
> The existing LSM hooks, LSM security blobs (the 'void *security'
> fields present in many kernel objects), and individual LSM callbacks
> are managed by the LSM framework whereas the functions you are
> proposing are not.  This is important because the LSM framework
> enables/disables individual LSMs at boot time which impacts both the
> executed LSM callbacks and the security blob allocations.
> Implementing "hooks" that operate outside the LSM framework can cause
> unexpected user behavior and potentially destabilize the kernel,
> leading to a system crash.
> 
> We require all LSMs (Landlock, Smack, AppArmor, SELinux, etc.) to go
> through the LSM framework, the BPF LSM is no exception to this rule.
> If you want to add additional BPF program call sites beyond what the
> LSM framework provides, please implement them outside of the BPF LSM;
> there is plenty of precendence for that already.

Thanks, this makes sense.

> > The main reason (for now) to specifically create a new list of BPF-only LSM
> > hooks is (pcmoore/lsm.git/tree/README.md):
> >
> >   """New LSM hooks must demonstrate their usefulness by providing a meaningful
> >   implementation for at least one in-kernel LSM.  The goal is to demonstrate the
> >   purpose and expected semantics of the hooks.  Out of tree kernel code, and pass
> >   through implementations, such as the BPF LSM, are not eligible for LSM hook
> >   reference implementations."""
> >
> > And for the hooks added in this series
> >
> >   a) BPF satisfies our needs, as we can precisely analyse what the
> >      calls are trying to do with good granularity
> >
> >   b) I am not sure how to actually express this in any in-tree LSMs
> >
> > Can't BPF be considered enough to demonstrate usefulness?
> 
> The core issue has little to do with BPF, it has everything to do with
> in-tree vs out-of-tree code.  The BPF LSM is explicitly mentioned as a
> "pass through" because some have argued that the BPF LSM is in-tree,
> and while the basic BPF enablement is in-tree, the actual LSM code
> that is executed has thus far always been out-of-tree.

Yes, the actual code isn't, but all the building blocks are.
The BPF is just a sophisticated policy language, in which,
given, say, ethtool hooks are present, one can say "block
all ethtool ETHTOOL_TEST_CMD calls for the XXX driver" or so.

Is there any way into turning BPF first-class citizen from LSMs
point of view?

> -- 
> paul-moore.com
