Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A63546D2AF
	for <linux-security-module@vger.kernel.org>; Tue,  1 Sep 2026 13:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788269180; cv=none; b=eHpCTYtVZ7jLSy7PdScVhsICgEbdbqoZ4mnsD8dbBHKn1iqV17jzfTWJOTK8gSiM5InRFMO6McKZSrrm1TPgpYjqqCaSfu3335tYzBy0v2Ng37XUwfBH44JJXz8gnfOqMR+JAM5Pc34Zp7aVIVRyvx9h5JZFAPYzDv/JkoD+KvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788269180; c=relaxed/simple;
	bh=Rn9/tcknkMhoBJMoT/vDX/T84MaINb69k5oYE5QTRas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MiTWDhVnCq5NX/Pk1DWAc63XVFooJP1HF29fvWSGRiAkkCk4bpvX7abAKXt1xQLhtgOnuUit6TpeiSL9LGKrmZANBKDPfoq9WdkHAjQ9yTWM0UZqV0EkSa3Kxen4x7c6uAX7/7lUB8yWtpPMl5lFYnIjWdkdChgL0MG5ACIDaqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MmLmJrFU; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmLmJrFU"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5b5e18f0439so3980847e87.2
        for <linux-security-module@vger.kernel.org>; Tue, 01 Sep 2026 06:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788269176; x=1788873976; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5YQ2NkdYE1UkDQmtG4k56tSGp0dI9qqzV8dhPz8o8Qo=;
        b=MmLmJrFUY+prIRyTONU+oFVHyOs92yM2LiDDdexmu11edZB8c/MwbOvXoPluCI9onV
         V6tt7E5kd1jXAglceOgm4r4Gt1R3GoawaWepLpC06FSFKPmCgpkdZHL6CD0P0IT2HRtb
         ULbgcbMjPpDlfEQ60BjH4ZVeBCSqwGPYw0ZmOrn8DsPZnF8KUqUgRjkZhIe0Q0Z3iPV6
         oYMsGUZtjgfS7A5ZHjUGTTY+gnql7DzvNcl0/45HgAG5qS2NDxdUSPbpJIP6711Y7sAb
         SNcANDd/MMKJMnd4X2P+j+b5V8+N0p7JtcJLvZabaWScKywLQsupMmPuEwgwBqN+OYdE
         ZiUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788269176; x=1788873976;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5YQ2NkdYE1UkDQmtG4k56tSGp0dI9qqzV8dhPz8o8Qo=;
        b=VjIOQCDnwb6C8rzKiJIgNRobwzbvNa+IRI4D0vTu3PV2QOuV09/cqz4bpsi4gbjVUv
         fkfeJe+zBOJ2h/3LAK7wHC+kq9n/aifMCvYGC6/gF7tpFTO33yjJzKmmx8YjIHts04Jx
         gIto7kX7nkecqOXcBlpEav7tlwTa6adj3kPlbdBuD+9ZCy28p+L8rP0C10/n39gtrxZu
         nR1frIon9yHam8s0040cWhRcuEQix4+xDnlokkwfLo8RIvQTakJJXFdfuAqCsAzb/wb0
         Hu3yHW/SpSjCYClF8vO86kEABKVM2zYDL3Byue9VBiECSLt8+h0u2KYrpfnFh2hwsfbb
         UoZA==
X-Forwarded-Encrypted: i=1; AKwUvBw4Bwz2K0yzdViWy2vtbfewKJMRdOm1D7LEU+kNNZmMaxSMrVlgl9RNYKoea/AABjFciGqCoBl5JE2XxyzbIpsgZU831Vk=@vger.kernel.org
X-Gm-Message-State: AFuF++mVkc59NAn8aWayG3TSQeENtHVCqTOasHmUbGKFsjVVZ/rfy+eQ
	xT0na7el+4dczzkquMf3wmexzkv8URESvQU7Qnfcm0EO0AOyNYMN5GAb
X-Gm-Gg: AYBFou1WHxBVJqfM/M5h7q4lNE2vtVm8VvQ+GKH6nAYDhvkLJtLp6713EAR4grvLbOH
	gTrHgAFRjf2SrsiCuByh92p8zg9rk8V5XE96M0j8DBk44KLxQKdyxh7uv39ybKeUsp2J5mDXtWm
	J9rv/vsNyQOugcFprKSqbvM0f6uPb9WCLEr+wAxeJ1woPHGRjfVQXqDbrgbo1bWUmP1SmDIWW//
	iD1tqMywSt+rUT8Mak5cD0gigowAdmklsttfbkO2f4PrhCfqxxox02eAEOaHLgvW1G05taGWHN3
	6BassILCtdOyGJuhiw584HMIO64xigigPCXNK7wWIrcOY/MeMRxPZsgY2J1g05UVBCEGhBoSb6A
	0zb5hDQmpH7HTBV7PaeQcpibxdyZRTz65FfC/LA+iJdTXdecNos6JD3rdT4BRFmEQmC+NjDq2+4
	6onfARvRV5D+D+jDjhgbuSlvOfaUa04bmFsNoHUVN93EOG1ZAgvHBqwx63m0W6im2al7bkHXnCB
	aiw+BM=
X-Received: by 2002:a05:6512:3985:b0:5b4:b03e:b17 with SMTP id 2adb3069b0e04-5b5fe0914e3mr3071911e87.4.1788269175321;
        Tue, 01 Sep 2026 06:26:15 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b5e8a18422sm2841927e87.76.2026.09.01.06.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 06:26:14 -0700 (PDT)
Date: Tue, 1 Sep 2026 13:36:51 +0000
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
Message-ID: <apbU8-fpioNIwUA8@mail.gmail.com>
References: <20260831110934.241898-1-a.s.protopopov@gmail.com>
 <20260831110934.241898-2-a.s.protopopov@gmail.com>
 <CAHC9VhT7=wMsB9mERWoiM6pF+_T1=2tyAsSrxMphhtdE2NPHMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhT7=wMsB9mERWoiM6pF+_T1=2tyAsSrxMphhtdE2NPHMw@mail.gmail.com>

On 26/08/31 06:42PM, Paul Moore wrote:
> On Mon, Aug 31, 2026 at 6:59 AM Anton Protopopov
> <a.s.protopopov@gmail.com> wrote:
> >
> > The BPF LSM programs are allowed to attach to LSM hooks, all of which
> > are defined in the <lsm_hook_defs.h> header file.  From BPF's point
> > of view the set of attachment points is defined in the bpf_lsm_hooks
> > BTF set. By analogy with existing code, add a new header file
> > <bpf_lsm_hook_defs.h> which will also be included in the bpf_lsm_hooks
> > BTF set.
> >
> > This change allows attaching BPF LSM programs to more functions.
> > The actual hooks are added in subsequent commits.
> >
> > Each BPF hook calls a [__weak] noinline function each time a hook is
> > reached. This may be too expensive for hot paths if a BPF program is
> > not attached. A future commit will optimize this by adding a per-hook
> > static key and inc/dec it on attach/detach. This way disabled hooks
> > will be bypassed efficiently.
> >
> > Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> > ---
> >  MAINTAINERS                       |  1 +
> >  include/linux/bpf_lsm.h           | 12 ++++++++++++
> >  include/linux/bpf_lsm_hook_defs.h |  6 ++++++
> >  kernel/bpf/bpf_lsm.c              |  2 ++
> >  4 files changed, 21 insertions(+)
> >  create mode 100644 include/linux/bpf_lsm_hook_defs.h
> 
> Adding new BPF hooks in the kernel is one thing, but adding new BPF
> LSM hooks outside of the LSM framework is likely to be problematic as
> these new hooks operate disconnected from the LSM framework (callback
> and LSM kernel object state management).  We've seen bugs in the past
> caused by the BPF LSM trying to operate independently of the LSM
> framework, something like this will only make that worse.

Could you please point me to some of the bugs you mention, such that
I understand exactly what you mean? I am not really seeing how the
real LSM hooks differ from the ones added here (from BPF point of
view, and the objects it can access via kfuncs/maps). We provide the
same "sleepable", "untrusted", etc. guarantees with the new hooks,
as for normal ones.

The main reason (for now) to specifically create a new list of BPF-only LSM
hooks is (pcmoore/lsm.git/tree/README.md):

  """New LSM hooks must demonstrate their usefulness by providing a meaningful
  implementation for at least one in-kernel LSM.  The goal is to demonstrate the
  purpose and expected semantics of the hooks.  Out of tree kernel code, and pass
  through implementations, such as the BPF LSM, are not eligible for LSM hook
  reference implementations."""

And for the hooks added in this series

  a) BPF satisfies our needs, as we can precisely analyse what the
     calls are trying to do with good granularity

  b) I am not sure how to actually express this in any in-tree LSMs

Can't BPF be considered enough to demonstrate usefulness?

> 
> -- 
> paul-moore.com
