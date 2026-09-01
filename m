Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8F047ACD1
	for <linux-security-module@vger.kernel.org>; Tue,  1 Sep 2026 22:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788300966; cv=pass; b=n9axbSn4cn/NPoKz+f/baaAsVSuV02gndm1Jc4kFsh//5fzY81laXjTu7B5LbYkcAUnMUMfjZnftPa8d1giCHfZx43En59BV+NFlbjRfrRFKWwlJr2U3zdilv7+pq8w6FhYqQDuteLgf+q23jxCkrNG2ORJKbWWDfBL43i7bao0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788300966; c=relaxed/simple;
	bh=mKdTmKx+z6mwUGqcorW8iH+bPrZTGVyvSXc8efMHImI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oZMvLpGoAOqjlBNetcsIJkleFfmj9rltjgds6aGmpUGIwdk24i2uRjKTPSR/DOPPM9071ZySITUNpZGWR2tnd4pme5mg23WK2cS1pqH1YBTHhtpAzbN4AEkfJytqOkjpG1Rp5Y8fCZmMFiYoOzcu7Z9mEOn9vZ57Bkn+P0lmeMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=eqHh81s+; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eqHh81s+"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2caced6038eso3661735ad.0
        for <linux-security-module@vger.kernel.org>; Tue, 01 Sep 2026 15:16:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788300962; cv=none;
        d=google.com; s=arc-20260327;
        b=qrczzNnBqZh0VbBsjGPjE2NSr3w3HPSDSPdhOtaPt0Kdu7KbSuAz0ztIw1G3Hsuh8u
         3LKHQHXKToRvLnuIIb8LPWl4avesmIhW0ZAufrqjCDoxlUQCOAfeNAfut/66kYUJDW8l
         hJCJMIS7dMxmwgwSqpeqxTiloMJEsPqY82tYQwhtO/pacs5gNUchAv3mnamP+kXJ8Yw2
         kJf6+MSEkeaw47OEHzkaFg6h236BGnGGBPiZfIs4YtyUz5ETKQvJXvnBi7dcWJGNtnBx
         1HAlpbgNHtUVcUwr6VD/aBlsGSxRxpxx3Nv+FZTwBbXillVQyGHy9+TFibmg1nRsaDNP
         hwJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1ATcm8apudD2vfrozzvIh0C6UKnA5qihRpZDqTJ19B8=;
        fh=wH0p2Hhr8U7G4QEc2FOAtSfOt4g3JmGG64v0hHYfNRU=;
        b=qlPZocLp+NGQMMQcr08nMGES+gZHhwDX0ggru8OkabOQkMG27C2DFsmjC3KnvSjGZn
         +lK20Px0RkqCaLB2aO8gqEJOQ7s2B0eg6zmETHWnkxSHTyyoFuw+cqzyy8dVQIc3jT0H
         XwbaJoNQYTPK1GNphhkfzbhV0sDxGBgMYVZ4yPbVmEALDB+U0KUVC2PdfqEy47iYLLQR
         1qiFH/vmayFm7NreTZTSLJjCWvOxR8bAMOLEAV1O4tsUiJwqrgF9ZAUfRoxuUugNBcKK
         hIG6//LEcP6VqY9P0qUcIagx/9CPP2McTp35k69eMY8IbHUOHa7xCQPfD8OhuemFgjUz
         eHhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1788300962; x=1788905762; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1ATcm8apudD2vfrozzvIh0C6UKnA5qihRpZDqTJ19B8=;
        b=eqHh81s+7tojPHBWGAv5Z71iklqC1frwXCy5DQz86f05QiXQaT0WK1ayrOxB4tvX6w
         9NP4C53JDCak/Lsv2Lr74xcFbCdQCssDxn8y1jzTU8uezehh5OxhJQuQ3tVdovDu1G5S
         Dx1gpayTpCB6fRm/3vIjzMM/Rcs0cUzvZ+/aH8PRHNoDAyplBfdwfniUhdMONtJGO6Px
         doLJ9pBtEZfOEO9M/oiURYUS5ZQ/6ACZcWCBi7g8OQnYWYxfGGr5/9+sO9twEA1SsdE4
         O0Zm175JagvCH8VKyYXt5pleEW9b/88f1NX6YFreDqbNy4IMGIl/6+2ZN7FQzgTCikwG
         HIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788300962; x=1788905762;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1ATcm8apudD2vfrozzvIh0C6UKnA5qihRpZDqTJ19B8=;
        b=leMn8I8do6LAJQUxjPCYc4X9wqmBaKYC6M6mZ8mFQ+RxRvHpHaexNQYUWh82CwMQAT
         Kea50Y+hvqHIca4tUHV2fbHJgnifFtCsmSLnJqeXcZuc6qr6zZJQLJDJZrwCjStqz4A1
         VwdFuH9eCEQMpk7uFfjAD42DYln7x/QMYciCZI7BcU9KS9w7lK2/6pNj7Kgxzjz5quks
         vOmKyhhAkr34e+mt5pkLVimeM1Umt8T/JmglbEtJ53zsN/9MwOHYMQNus0S3K3FQ0Z5Y
         FqLxy3LJswE3WzUsiJstCDdv1IrZNHJpK+qJOtq0LsNmtPfCm8SGKdiHFhQBQQ9rUDp/
         h4rQ==
X-Forwarded-Encrypted: i=1; AKwUvBzGciowsTmHRhYCpmPVg/X/kZRYHSk2INV5y+iHbli8SSHF70GoTySx1ko3hwGFlMWhXbQY0pkLSCbijcH6CH76uwEesvA=@vger.kernel.org
X-Gm-Message-State: AFuF++nwqTzw27CsmHUF97ChlQeqA7Zvuc/RQbyu0VTWE1rrh25dej1Z
	dyj7euy0zFhRMyeWsEhNN7QAbpZmFguxJJoAbdPCCMckGo2L7+Cx0F43Nhk1e08jdw63H9GDLjj
	aAvApBqORF8RDIK/W1UzSbwUIJsM6fOpsEJMwxYrR
X-Gm-Gg: AYBFou1xcWNTjUb9DGGmh1/FOn9gYnsqk4I4SzfNXCr7JccGGXXvzi8NVFsyBy1GJrV
	oV9LFxoySmV4ON3f0JiPlnbQyjJ6NxwkEN63laiLrVAdgnJ9MVECFU6E/Wz3Y2RZsf/8t4Km4Rf
	W8rpTyqgaTF7bhuEnW+JZkQeLzDRxD5tkwjoiNFnmJE+sODG1c8Ercrlum4Ff6oO+9qvX+26DTs
	4670GW5VStT4WZ4c2yuUz5zt75BWElb5AXaXGNxHQZGO54K16nlyNGF9FNBbXR63pdLLByeww2d
	tCpUbXeWoWUqV9QjlKJdDaGc49HNPJ2TKVVH7R2s++RD
X-Received: by 2002:a17:903:2410:b0:2d9:2b1b:878a with SMTP id
 d9443c01a7336-2d9526c2cdfmr80572575ad.10.1788300961608; Tue, 01 Sep 2026
 15:16:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831110934.241898-1-a.s.protopopov@gmail.com>
 <20260831110934.241898-2-a.s.protopopov@gmail.com> <CAHC9VhT7=wMsB9mERWoiM6pF+_T1=2tyAsSrxMphhtdE2NPHMw@mail.gmail.com>
 <apbU8-fpioNIwUA8@mail.gmail.com>
In-Reply-To: <apbU8-fpioNIwUA8@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 1 Sep 2026 18:15:49 -0400
X-Gm-Features: AcwNN1W7aLRefGcheWJ-uymO40RrLBDpF_-JUw-mmYcnuhgB-KD2OI0728rejLU
Message-ID: <CAHC9VhQbWPqEz5g1rVcMyJgrzzd4cQuwi7cddgJQK1H3ugMz7A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/7] bpf: Allow BPF LSM programs to attach to
 more hooks
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, lsm <linux-security-module@vger.kernel.org>, 
	netdev <netdev@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <matt@bobrowski.net>, John Fastabend <john.fastabend@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 9:26=E2=80=AFAM Anton Protopopov
<a.s.protopopov@gmail.com> wrote:
> On 26/08/31 06:42PM, Paul Moore wrote:
> > On Mon, Aug 31, 2026 at 6:59=E2=80=AFAM Anton Protopopov
> > <a.s.protopopov@gmail.com> wrote:
> > >
> > > The BPF LSM programs are allowed to attach to LSM hooks, all of which
> > > are defined in the <lsm_hook_defs.h> header file.  From BPF's point
> > > of view the set of attachment points is defined in the bpf_lsm_hooks
> > > BTF set. By analogy with existing code, add a new header file
> > > <bpf_lsm_hook_defs.h> which will also be included in the bpf_lsm_hook=
s
> > > BTF set.
> > >
> > > This change allows attaching BPF LSM programs to more functions.
> > > The actual hooks are added in subsequent commits.
> > >
> > > Each BPF hook calls a [__weak] noinline function each time a hook is
> > > reached. This may be too expensive for hot paths if a BPF program is
> > > not attached. A future commit will optimize this by adding a per-hook
> > > static key and inc/dec it on attach/detach. This way disabled hooks
> > > will be bypassed efficiently.
> > >
> > > Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> > > ---
> > >  MAINTAINERS                       |  1 +
> > >  include/linux/bpf_lsm.h           | 12 ++++++++++++
> > >  include/linux/bpf_lsm_hook_defs.h |  6 ++++++
> > >  kernel/bpf/bpf_lsm.c              |  2 ++
> > >  4 files changed, 21 insertions(+)
> > >  create mode 100644 include/linux/bpf_lsm_hook_defs.h
> >
> > Adding new BPF hooks in the kernel is one thing, but adding new BPF
> > LSM hooks outside of the LSM framework is likely to be problematic as
> > these new hooks operate disconnected from the LSM framework (callback
> > and LSM kernel object state management).  We've seen bugs in the past
> > caused by the BPF LSM trying to operate independently of the LSM
> > framework, something like this will only make that worse.
>
> Could you please point me to some of the bugs you mention, such that
> I understand exactly what you mean?

The latest that I'm aware of was a few months ago:

https://lore.kernel.org/bpf/20260628201103.3624525-1-mattbobrowski@google.c=
om

> I am not really seeing how the
> real LSM hooks differ from the ones added here (from BPF point of
> view, and the objects it can access via kfuncs/maps).

The existing LSM hooks, LSM security blobs (the 'void *security'
fields present in many kernel objects), and individual LSM callbacks
are managed by the LSM framework whereas the functions you are
proposing are not.  This is important because the LSM framework
enables/disables individual LSMs at boot time which impacts both the
executed LSM callbacks and the security blob allocations.
Implementing "hooks" that operate outside the LSM framework can cause
unexpected user behavior and potentially destabilize the kernel,
leading to a system crash.

We require all LSMs (Landlock, Smack, AppArmor, SELinux, etc.) to go
through the LSM framework, the BPF LSM is no exception to this rule.
If you want to add additional BPF program call sites beyond what the
LSM framework provides, please implement them outside of the BPF LSM;
there is plenty of precendence for that already.

> The main reason (for now) to specifically create a new list of BPF-only L=
SM
> hooks is (pcmoore/lsm.git/tree/README.md):
>
>   """New LSM hooks must demonstrate their usefulness by providing a meani=
ngful
>   implementation for at least one in-kernel LSM.  The goal is to demonstr=
ate the
>   purpose and expected semantics of the hooks.  Out of tree kernel code, =
and pass
>   through implementations, such as the BPF LSM, are not eligible for LSM =
hook
>   reference implementations."""
>
> And for the hooks added in this series
>
>   a) BPF satisfies our needs, as we can precisely analyse what the
>      calls are trying to do with good granularity
>
>   b) I am not sure how to actually express this in any in-tree LSMs
>
> Can't BPF be considered enough to demonstrate usefulness?

The core issue has little to do with BPF, it has everything to do with
in-tree vs out-of-tree code.  The BPF LSM is explicitly mentioned as a
"pass through" because some have argued that the BPF LSM is in-tree,
and while the basic BPF enablement is in-tree, the actual LSM code
that is executed has thus far always been out-of-tree.

--=20
paul-moore.com
