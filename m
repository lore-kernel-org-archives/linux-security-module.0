Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6C21D5160
	for <linux-security-module@vger.kernel.org>; Mon,  6 Jul 2026 17:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783358184; cv=pass; b=jrtKbytQxMc/uBVc/Tgu1hzoGnFj3qV8qYgHNSAI2vnb9JHcq33PO1XrQc1XUjDAerUvOdtlE6ku9nNhXXJWP8z6UFO1dU1pJ036lNjrcshzBqVR+YKbvMnxZR/afPUBWLAlhKOPpiMir9t87i76PPbgUUikavye7UdIHJxJ82Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783358184; c=relaxed/simple;
	bh=84cTg8yyLrvuEtMq92EVwXi/eEOivoXxHubWUwjxp70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UEjrFIGdODiPgu9rRNJvOZy+eRQ/uMjGXG3kZhOXbBviMWo90foWK3chmIMihB+DtMB7+1CaFUQsnO0381mGPXQ+v4wNFKHlCTvt4NycPt8Si0yxe2QNjEHzmfNvVRoQV4WHETb7xUYr8qrYagsU6L2ETOxEqU0iqgxgeZ6bHPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=gchhu0bV; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="gchhu0bV"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2caced6038eso830625ad.0
        for <linux-security-module@vger.kernel.org>; Mon, 06 Jul 2026 10:16:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783358182; cv=none;
        d=google.com; s=arc-20260327;
        b=UYa2Dnp5Cd8sxlkq/L1/bDNff+Wand8NFO7jHbY154xjXojNKy5oFP5DDGv1X8+d5b
         Slw3tz+qG2CMHqwBPKt3gPSMtpeCogRHlSxz61r/Q8b42M2zQRp2V2ZD9zqrWayd72E1
         kOT36ZztmGOmrY1FbiOzrZJma5DLfJvl11JRYDWixXVBaQ52YqC45BNn4ivH+6grSwUr
         eYCLBY12jVg0cbaBRGaq35C3TE/AU5EVkBhIRtLwJ+64s0me1S931t13epsIeV9UAWe1
         b5x9AWe1QaRbqfWcR3jXqtJ4tPKsWjue9SD4qTQIjjbt4JWHAOigdO9afHzprcSBHxU6
         cniA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p8csJ3JV9Nmi1fu2Dico85NwPbV53oZJfbEJZO4SZhM=;
        fh=Gq6u2sYWRunghIDieWLlhd+KanG/71cgb33uR9nJAfI=;
        b=gUTmORKkOexeesGLCDK+c26A8TI9WeqGuHd3AXSFBzxUwJroIPdixpX+9QDOvoiKQm
         z99YJFrgtXek2aUQBJDz4i+EN97nVg5XJbqxC2LVXtVvh/9xBkWnMTSrRNtFdEbDfuoC
         3PM06D9nzqaB2X5i/mzhgogaE/cKo/92S2NottAbrm+zPgirXw1LfgzuLVHoDv4nGSK2
         3hQYH8ysXWWNoNu8y26jy+Cms2bqNSCirWImhooKH57pldW2P8/E1oGTYtjymz4ZYF0p
         gpeSR+XUrnxo4pvA98RbKRE4wfu0NJdz6dtWdXwO5HcAu3jWJO1rQxdWIBKHHFgCm/NI
         wmDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1783358182; x=1783962982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p8csJ3JV9Nmi1fu2Dico85NwPbV53oZJfbEJZO4SZhM=;
        b=gchhu0bVfj0gaZdJi0hAEjNNYH4+n3RxasyhL2oC2gLazycBFBtW6lzxjv/UlTlOuz
         rZe/0zQ/Btw4EJ2tbWlCtP2jqQkBHZdFjgdeCygD7VHN1dwbXRQdGoBLtKSEzbEGtC43
         TUN+lEzaPHll4LPav0I9DsNpr/xNMbw0sHVjCErHZF5OUNoVUgdwIr2PF2AkklKlXE/k
         9Q4KCsGZmDgbDJe4blUgKGkyRlmo90bfYlu2z/lSYuZ+zBr5bKUB6v1RUNTwdbXOlivN
         xggYJD2/XbnX/u3KAc5ErFt5+SUdgSq9rwy690sDQwRlfWl7dLMMjwrDtBVuyA9srIZG
         i90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783358182; x=1783962982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p8csJ3JV9Nmi1fu2Dico85NwPbV53oZJfbEJZO4SZhM=;
        b=sCBjorGK0wWehJQ3aUcvKUwx+YmSNF2BwkQrT1cMW7TBTFRqCl4qTlZbHgJnP5jgNd
         BHAL+uZQQDmsPP/yhy+hQsDcTUj7a1GzZqQQeDNaZBwEMBK+/xKQ9/BI0+6xIxNv+yg2
         q96r+L1aQmCDA77Ir97m5xoIzJrHogcVSY/PYFCQWqrnlZDAaZrfHUtm390XajJeru8I
         N2QcT1E3RKoyuMOnPPryo7EvOfR0LyfSKyiek3Ot6CaKL75Eh8gc5nUzssO4iK8Oip0i
         lvWfW3+0edQjOYfxUIG9vCNb4sPw4z4TwTeUpGTOhZMVfF9wHE5TT/OW8ANblCPxfcFm
         ogpw==
X-Forwarded-Encrypted: i=1; AHgh+Rp+n8Z3O7KTwVkLpVplB9jPcdJG9OWowF3oJp25evZBM11+G8lGnErROVELHBN38v7WMMWHw+viYng6RbB+RAnLH1BlbJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPhkrw7PHiTr8rtsfgz7/8ZvBycP+1WUjaCehebCEPJGM5lFIK
	0oHMl7Dj0PY58njO2vhKCvQR3BZdHl0uqO94rPO0KzEOx5I4X2Iezq34ckrAtV597rdfGWcegdY
	Qa3Ig8QmNEUMJmJWfmyTH08D+oim0QI/u2Mw7OTIH
X-Gm-Gg: AfdE7ckxy4pNZcc25xZBXD8VEz3IsOwf4Q2KPJemy514v0OlQ9cf+/rMNMXlqORn7YA
	xIPVDgBKcZx8mcR/v0Z7+HFoWasIB1OHMflS6ngD3qu9K9DTbbiAV7xar3Lrzq/Obx8GVqhKswG
	9zg5jEGeSOOLDQ9aoyOoJ+tdaS4PlzEG1SG3dF55W5DbPhr5D18IUFDVOFRCCJzCMFgNQ20QDOQ
	/0T6MSqyj37d9+5LRX0nVBWVolL3LHFvy1C++EcBPOrpu8PA0cCvW4F5bEZqFFifmBjPI8h
X-Received: by 2002:a17:903:98c:b0:2ca:12aa:a390 with SMTP id
 d9443c01a7336-2ccbce6c3efmr16539365ad.0.1783358182280; Mon, 06 Jul 2026
 10:16:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706135644.326006-1-daniel@iogearbox.net> <20260706135644.326006-4-daniel@iogearbox.net>
In-Reply-To: <20260706135644.326006-4-daniel@iogearbox.net>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 6 Jul 2026 13:16:10 -0400
X-Gm-Features: AVVi8CeRwYC1EaFERKCui17anEbPyUnlPMJdGVYrkAfeveKfXt06y9OSTwJveN8
Message-ID: <CAHC9VhRWG=Of4pKmo8KRjCYnVmfX5ZD7JPVa0D0N0Z=1ts4iQw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 3/9] bpf: Verify signed loader metadata at
 load time
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: ast@kernel.org, kpsingh@kernel.org, James.Bottomley@hansenpartnership.com, 
	bboscaccy@linux.microsoft.com, memxor@gmail.com, 
	torvalds@linux-foundation.org, a.s.protopopov@gmail.com, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 9:56=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.ne=
t> wrote:
>
> A signed gen_loader program carries the programs, maps and relocations
> it installs in a metadata array map. The loader instructions are covered
> by the PKCS#7 signature, but the metadata map is not: Today the loader
> compares the map contents from within BPF against a hash baked into its
> (signed) instructions, using the kernel-cached map hash. The kernel
> itself never actually attests that the metadata the loader installs is
> the metadata that was signed.
>
> This split is the core of the long-standing objection to the BPF signing
> scheme from the LSM / integrity side: the integrity check of a light
> skeleton only completes once the loader program runs, that is, after the
> security_bpf_prog_load() hook, so at admission time an LSM observes a
> program whose payload has not yet been verified. Auditing the chain
> link is also not a purely cryptographic operation: whoever signs or
> reviews an lskel has to disassemble the loader's preamble to convince
> themselves that the embedded hash check is present and correct [0][1].
> Two acceptable fixes were identified in those threads: Complete the
> integrity check before the admission hook fires, or add a second hook
> that collects the verification result after the loader ran [2]. Covering
> both the loader and its maps directly with the PKCS#7 signature is what
> Blaise Boscaccy's patchsets proposed in several forms. Let's implement
> the former, without growing the UAPI, and in particular as a single
> unified scheme where the signature spans the raw bytes rather than
> derived hashes.
>
> A signed loader binds its metadata map(s) through the existing fd_array,
> and an exclusive map is already bound to a program digest (excl_prog_hash=
).
> So when a signature is present, collect the exclusive maps from fd_array
> and append their frozen contents to the instructions before verification:
> The signature now covers insns || metadata_0 || metadata_1 || [...] in
> the fd_array order, and verification completes in bpf_check(), once the
> fd_array maps are resolved into used_maps, before the LSM admission hook
> and the rest of verification. A program is either BPF_SIG_UNSIGNED or
> BPF_SIG_VERIFIED, with nothing in between. While folding the fd_array
> maps, a non-exclusive map bound to a signed program is rejected, so every
> map folded into the signature is exclusive. A signed loader that fails
> to cover its metadata thus does not load, and BPF_SIG_VERIFIED always
> means the instructions and every exclusive map are authentic. The maps
> must be frozen so the hashed bytes cannot change before the loader runs;
> the map <-> program digest binding is enforced by the verifier for every
> used map. Binding maps through fd_array_cnt makes the verifier resolve
> and excl-check them (excl_prog_sha vs prog->digest) before it would
> otherwise compute the digest, so compute prog->digest up front in
> bpf_check(), over the unmodified instructions the signature covers, for
> a load that folds metadata.
>
> Unsigned programs are not affected by the signature path; for them the
> LSM admission hook merely moves below fd_array resolution, with minimal
> bounded work in between (see the previous commit). Note, signed loaders
> generated by older libbpf/bpftool versions need to be regenerated; some
> of the recent fixes we've had on the signed loader side require the
> latter already to close gaps.
>
> Finally, some remarks around the security_bpf_prog_load() placement
> given there was pushback, demanding either a new hook or a reuse of
> the existing security_bpf_prog() hook [3]: Just for loading a single
> BPF program it would then need to pass through four layers of LSM hooks:
>
>   1) security_bpf (cmd=3DPROG_LOAD): for gating various bpf subcmds
>   2) security_bpf_prog_load: historical admission hook (CAP/token,
>      prog_type, attach point), pre-verification
>   3) security_bpf_prog_verify_signature: newly asked admission hook,
>      same role as 2), plus the BPF signature verdict
>   4) security_bpf_prog: gate handing the prog fd back to userspace,
>      verification done & signature verified
>
> The use-cases of 2) and 3) conflate, thus BPF community prefers to just
> keep a total of 3 LSM hooks (as-is today): 3) makes 2) incoherent given
> they are the /same class/ of hook, that is, access-control admission on
> the load and split only by _what_ they can see. Worse, with the split,
> for a signed BPF program security_bpf_prog_load 2) admits a program whose
> signature has not been checked, so a policy gating at 2) is structurally
> unable to express "admit only verified" and every such policy is forced
> onto 3) *anyway*. In other words, one doesn't get two complementary hooks=
,
> but rather, one real admission hook aka 3) plus a now-degraded /legacy/
> hook 2) that can't answer the question operators actually want to ask.
>
> Reusing security_bpf_prog() 4) for admission is no alternative either:
> it fires only after the entire verifier (and JIT) pipeline ran, so
> denying a not-yet-verified program at that point burns exactly the
> work a denial is supposed to avoid, and by then the program has an id
> assigned and the kallsyms/perf/audit load events fired. Policies are
> free to also consume the signature verdict at 4), but admission control
> belongs into security_bpf_prog_load(). Hence the latter remains the only
> admission hook, merely moved past signature verification; with moving
> large allocations further down into the BPF verifier, there is now only
> minimal work between the old and new location.

See my comment on patch 0/9, but if we can combine this patch with the
vzalloc(progam) patch, I'll be happy to drop my NACK, and you can trim
the last half of this patch description ;)

I suspect that squashing the two patches should also quiet sashiko's
comments as it will be able to see the vzalloc() below the
security_bpf_prog_load() hook in this same patch.

> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Nacked-by: Paul Moore <paul@paul-moore.com> # (don't move bpf_prog_load L=
SM hook)
> Link: https://lore.kernel.org/bpf/2f71d6c03698eb17d51f7247efde777627ee578=
a.camel@HansenPartnership.com [0]
> Link: https://lore.kernel.org/lkml/ecf0521ed302db672672ebfbc670ecfba36a6e=
00.camel@HansenPartnership.com [1]
> Link: https://lore.kernel.org/bpf/88703f00d5b7a779728451008626efa45e42db3=
d.camel@HansenPartnership.com [2]
> Link: https://lore.kernel.org/bpf/DJOFY21DYUI4.19WKQ3NPZ4H5R@gmail.com [3=
]
> ---
>  include/linux/bpf_verifier.h |   1 +
>  kernel/bpf/syscall.c         |  76 +--------------
>  kernel/bpf/verifier.c        | 175 +++++++++++++++++++++++++++++++++++
>  3 files changed, 178 insertions(+), 74 deletions(-)

--=20
paul-moore.com
