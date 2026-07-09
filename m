Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771A835975
	for <linux-security-module@vger.kernel.org>; Thu,  9 Jul 2026 02:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783563703; cv=pass; b=JhrnD7LkVhRzoW1QfeQUp3gLjFiVdBMLHej5o+t43uYbsYeD6ePxOT8gqqCFNvyeN+znMKmvp2jYUxGqyLxElWpWCRbFvYC9WiBuDCIRjJzz7JJ5pEvL8oNRJ8VmuPkMuEdz011YyYhY9BaecjgOcLn7SbwbLgXoe5JOR6pGvZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783563703; c=relaxed/simple;
	bh=Hf2tG5rjaquIxB3mQsxa2j6npbMAgqW19BB3qIeNMV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DPh5m785aT3IZrzgvbHWJ8nQfwSxaH/Rso6O8JqyiuA1y8E2sYZqohV53IemcOSTEEEHfjTGZa6EksElbSL/GfmcOlZoStRnHPYYYlvczZ3qGsB/zAbgNsAWN6kXQxsRhCs28Poa2FfZeEFGUtbje5DRFoK9MUhKuR8ltXspz0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=e1Bdsqdp; arc=pass smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="e1Bdsqdp"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-847a5528b33so847415b3a.3
        for <linux-security-module@vger.kernel.org>; Wed, 08 Jul 2026 19:21:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783563702; cv=none;
        d=google.com; s=arc-20260327;
        b=Cyc4NSphTHYG8+7uBviUI9+EUXYYqwUsSvlS/RPPYI1jRve1gcg016zzgsv7d69P+w
         tP3DBpRoLdIcuyPJuzAuS0JacCiQLce/eKdEVf2TshPxyaBiHTzQnw6QvBtTnNOp263P
         3nypN9v/0s0O1KCgTlDiSchiIsG5sE2Q//lwGZXW0HVcTrXax+5IdQIj07990UAW9Atz
         FsD4jXCA3rbTAZtfd3JimmbDeANG9hi/L9NjKcEt4Wh/FP1SQQ89WgMT3TNjJcNjOLmt
         tn3IpeWsio3DovLq7G0Z+cx6R/MgcNRtrLTX7UtkDB4rB8RcWdOu34mvj/3V561o0h8N
         n47Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ujdbWcKs5QrHmjMr7suLiT2KeQNYhawhbrLCyECtjEQ=;
        fh=ceqVL3dhPdijAoC0ulcdaeeghXVkAU1V7dKSA8AOd80=;
        b=HdDczAHjJlykkMOvpjA9JmhU0bJrr51gGeR8T6tue02plw0XqrPX5Y6UZ6vptub6n9
         GHwOjAxfgPkB7drgAesDPfW55wy4VnxDhGRmorub8KBxZSV0V70TwIEciyJd0rHjapcd
         e2cct6t19dEJNBneW9cN8hIRoliKotilYWtLZvnnHl19vSbflpIoN2aC54pjcNHo3ohJ
         4q/Ms5MUiZ3jSw9yIc1fTn0DMURvq5obLZEyjzW8jZT1U0xYvuI7G2GQUdVMR4oL+DCZ
         kTMAHNEBtqJCTkNJwFj3GbUh825B928u4UmDOUHMKXj5bUSyHqs9OibI8R1s7yy/kdyu
         f5wQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1783563702; x=1784168502; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ujdbWcKs5QrHmjMr7suLiT2KeQNYhawhbrLCyECtjEQ=;
        b=e1BdsqdpegqtNdRcZiVQ0heEvubAhmvehdrydhjkjzzdbDisrz5VY7Txxt1PO/Z1lC
         kCJtNBSGXgO7xhalFnu1NqlPYKF3nTtdmzA6rvqkcuWEUR+IMEmtN25d4cOS/brhg3x9
         cHjI3Pvfhn38K1kDAsIIk6i/r21YiAM6o7w2lqSVmMFVpLlnluCrBJILreZpRovZaeuz
         G+lRaM8rTFNoIF3ZJFu99Nm0emD59vWP6iT+UyQ2zxwO+Kmk9DnTYmk+kFQoZyjpo+xo
         MX1XfUnsBu6+/Nkce12BNGBknGxW+2yIabQgxO1XOZd7m5w7VPtpjhEHjdjHU2vYw0+C
         ZWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783563702; x=1784168502;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ujdbWcKs5QrHmjMr7suLiT2KeQNYhawhbrLCyECtjEQ=;
        b=DKlQ0xyhaOoWn64OxmaX7GkcNEoPM2FzTKGbsMcFRajlzU/ChEu5zrc2tCSOyhKwtt
         RopJu0OLp/TPMkL9z6om2n+YXEAYR9AkYA2CnkoqdUtgD6ol6U9zBilsvb5THp69H+dJ
         dfpIUjiYURhEgB2z0Vk2aKHsVo/64OBf8zCxd97X7ZAD4Wx3bwXq3/xwkUH08jflFto6
         hZCKtKF+qbW72B19EkK9WSFWx0QAifwiXCfoa40ry6dIodp2mfRIejovQNZPJnQiD5w/
         QCNl8zM1Qbz+e/pgA/QDnm7JOrJEoTHPWby+Lp4YOvBaHp0MHcBt325px7KpKS+vm/wO
         ke9A==
X-Forwarded-Encrypted: i=1; AHgh+RpwJo6tnuHMeYM3bDMcqpJNV3KR4nUrmM+r6pnus4yCwlYO4P6FhDoDucvGZsFuGOm0DjHUhEGkKzFlov19/WnBswmY4sU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+vs+ftgZmir0+TO/IGR9Eo5b7oTKFjJRklgfkASbGfmQx3iad
	RkWER8KVJW8SBKxzPGJ99QPQTK1tWLyl4ldfWFItPFhMtY612qw0BSj0PVqsQqeOT/PVvhD3mjj
	t2Nr/1YLbgFpBAkp/DI3H+M6arcxoHp70ACnTm8JC
X-Gm-Gg: AfdE7cnvypP1uFf5tdek99Z8945NcszTFrcubVCw0KZMPAijaxgfbAkPleefUo2KQTP
	QvafIdGg0uv9h+XhWDJWOM2aynBACtw4BRoJhrjVeH4aBshntQvApgyArgSsFU3zycwhlCGJzs6
	cQnuHGLtCPtLoBl5va5kTmT+s9t/rNfT6Q2hU6rbL+jS8zyHIJ5b4QavDTlYbcVFPQsdOlrP4Tc
	no9HkcExNTWQFJHw4frMEONS3M4giMVmVLN5jIntD1kG+J9rXYjT8of9zuRHEzpZSaLjHy+
X-Received: by 2002:a05:6a00:3cca:b0:845:e43b:ae7a with SMTP id
 d2e1a72fcca58-8484368e1eemr5018505b3a.62.1783563701741; Wed, 08 Jul 2026
 19:21:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <umQp9Qs18vw53oZDFIgYE4MyUWNemeNL8-Vbs-BOYEvQByiyPSZ3RrEvOpmdWUZ1YtjEHpjlgZnMo5DkJuJziwrKWTYS_A0QF_B3ixToMBY=@proton.me>
In-Reply-To: <umQp9Qs18vw53oZDFIgYE4MyUWNemeNL8-Vbs-BOYEvQByiyPSZ3RrEvOpmdWUZ1YtjEHpjlgZnMo5DkJuJziwrKWTYS_A0QF_B3ixToMBY=@proton.me>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 8 Jul 2026 22:21:29 -0400
X-Gm-Features: AVVi8Cf8epDZUvAGsMWUetpWhJurNwoB-tiGg2Boh_8Edu32EBPYzzzvT_qTOLg
Message-ID: <CAHC9VhRCo1nc2qLfq=Fk9Q26vjSOUBgfM8wV6U4S+Hv1KM9LNQ@mail.gmail.com>
Subject: Re: [RFC/discuss] memfd_secret(): opt-in visibility for security
 monitoring (eBPF/audit)
To: BoxStrikesTeam <BoxStrikesTeam@proton.me>
Cc: "rppt@kernel.org" <rppt@kernel.org>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, 
	"jmorris@namei.org" <jmorris@namei.org>, "serge@hallyn.com" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 8, 2026 at 8:09=E2=80=AFAM BoxStrikesTeam <BoxStrikesTeam@proto=
n.me> wrote:
>
> Hi,
>
> While experimenting with mseal() and memfd_secret() together on a
> recent kernel, I ran into what looks like a gap worth discussing:
> content placed in memfd_secret()-backed memory is invisible not just
> to other processes, but also to in-kernel tracing/observability
> mechanisms such as eBPF's bpf_probe_read_user() (EFAULT, as expected,
> since the region is removed from the direct map and kernel page
> tables entirely).
>
> That's working as designed for the threat model memfd_secret targets
> (protect secrets even from a compromised kernel / ROP-based
> exfiltration). But it does mean a local, unprivileged process can
> now allocate memory that:
>
>  1. Is invisible to kernel-side introspection (eBPF tracing,
>  /proc/<pid>/mem, ptrace-based tooling) once populated via
>  memfd_secret(), and
>  2. Can additionally be sealed against mprotect()/munmap()/mremap()
>  via mseal() so its protection bits can't be relaxed either.
>
> Neither primitive alone is new or alarming - mseal() protects mapping
> metadata, not confidentiality, and memfd_secret() is explicitly
> opt-in and disabled by default. But combined, they let a process
> carve out a region that a host-based EDR relying on eBPF
> tracing/probe_read helpers cannot inspect, and cannot force back into
> an inspectable state either. For userland security tooling that
> assumes 'anything a tracing eBPF program can attach to, it can read',
> this is a small blind spot.
>
> I want to be clear I'm not suggesting memfd_secret()'s core guarantee
> should be weakened - the ability to keep data hidden from a
> compromised kernel is the entire point, and forcibly exposing content
> to tracing programs would undermine that model and create a new
> attack surface via the eBPF verifier/helper path itself.
>
> What I'd like to raise for discussion instead is something closer to
> what was already anticipated in the original series - Mike, your
> commit message for memfd_secret() mentions: 'Once there will be a use
> case that will require exposing secretmem to the kernel it will be an
> opt-in request in the system call flags.' Two lighter-weight
> directions that stay consistent with that opt-in philosophy:
>
>  a) An LSM hook / audit event at memfd_secret() call time (this
>  echoes Christian Gottsche's 2022 RFC to label secretmem inodes
>  via inode_init_security_anon for SELinux). Even without content
>  visibility, logging 'process X created a N-byte kernel-invisible
>  mapping' gives EDR/audit systems a behavioral signal to alert on,
>  without touching the confidentiality guarantee at all.
>
>  b) A distinct opt-in flag (as foreshadowed in the original commit)
>  that a process could set to allow a CAP_BPF/CAP_SYS_ADMIN-gated
>  tracing context to read the region for legitimate
>  monitoring/debugging - fully opt-in, off by default, and never
>  implicitly available to unprivileged tracers.
>
> Is (a) something that's been considered further since the 2022
> secretmem-inode-labeling thread? And is there any existing tracking
> issue for the kind of opt-in-visibility idea in (b), or was it
> dropped as not worth the complexity?

Modern kernels do allow LSM labeling of secretmem inodes, see
secretmem_file_create().

--=20
paul-moore.com
