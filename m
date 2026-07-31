Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD4B37E5DF
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 20:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785529856; cv=pass; b=qWejU0JSgmZAVsqn4lQ4fp7WFa4r6XFCSvKClt7r8AoVWkDpvxYCJEXvE+JrSoJGYHI9x7UEawucaLzGhV5tP7qyZtB1YVDFmYtfBQEQHRivqP8BJJ5sL8T3n7AReynkI2PTui6/TiSfgjhSsFM5sjCwBrRSpRPHGi/iFBApc5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785529856; c=relaxed/simple;
	bh=6OZybQH9mjdmuIJ0VC3HF4/1LHBpsWKz2iwSWBXuZog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bt8P2Ms3RKGj95qB6gS3/6CU2UXPnBbwGG6cbiKnGsfsByBSHPIoemGxvbO03JbHmOFrY7hOblur7jxxKwOSEWQ86f0SV61BmGahJMn4hlSATJycI/wrPYnFwyOAzcz/B817VB7qIlHejNMDDmyQFXYbl08F+BtENwrRrgfwvyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KN4eoMOb; arc=pass smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KN4eoMOb"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38dcbade417so1430515a91.1
        for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 13:30:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785529853; cv=none;
        d=google.com; s=arc-20260327;
        b=VlloUBnPjQ8igzbQ9/HZgF+2xlCOOU0cgYRx69Ld01/+iHsVpiI8kzwTHGfyMUOy2T
         KZhyeK5YfyEmT+59Ms4iIvI5uUhd1ZjEA5CiHu04hY0OikMdxth2W4GBdGuI0tPHOrM0
         hDgwJKbQY9nrNtJvrzVMfl009gZTYabXzcbEGz6OkvWfCdfh7KQ4094np6kIY+HM7mPC
         h8+V7dyGSLyeiSgG7tczkXAjEYpg1ud+54B6qKbkR2z6F6NoCHmy8LBWdyn6eB+69yFP
         RKfN3KQomKd/YxKvxx5YBddeChk3ZRClcCzCm1cgjJIgupN39Krae72QuyxRWktXmPwJ
         kWKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sJPatjaoGt9TgsVyGfH9eHA98XjRAYWgm2TTNnuirns=;
        fh=ZM1af7H9S3hNCsmf1OmNbkekzBASeyqsSmSNecVxiAU=;
        b=GTzXDut/Vc+IMf/wjBAc2cEMwliACp0SbFIBlnKpTHxfe2oS4MSnYon1BURhdmDAVM
         RPtusFdrchXMLflZTg1+MBAXCcZo5/p6HcfZT/cD8Ogfp8DoHJq/EDAgAPdvBORkkOLW
         z+8VzzBBMA8r/kB9yjSSBoNIYrbR6tVCRMShtoxRxzi3R/WXOh6mL65yuPvPyLXtAQFd
         ISYhRwtrz5Qctj/ur0o1w7Wpdn5zaF8yFZ3JT7XwarWj8s7VNulkCPFUYHcMxgt427Qn
         Nynw3e63cwBlzjSQLPhRA0P7dUfJMEqgRTIxGmgVZCnFEIvNoR/mE1ArA9nz1S/MZaD0
         qG6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785529853; x=1786134653; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sJPatjaoGt9TgsVyGfH9eHA98XjRAYWgm2TTNnuirns=;
        b=KN4eoMObbRKuK2oVBAZMpz/oMX6pfSX80SxISod+oCf8IKcSC4PyK6R99/4ceS1Eod
         7jPwZ7Tbr9c62tawWPGHzaD+yLkjJDCFL3ZOrLnsKLSNbPQCH/tzmzffzoWPgGxbP2/s
         zvAlnU3TGwEdqiYmJjJQdfCbN+O+6tFRLx9ujfCcfJVZyTZ268BUch+FyXdzUPD3wPDS
         BYs6VYlJ/jYPqUe+ikA236WwJpvto9vIcz283p2YSjEmgHCyQzhv5fnHjXF7Cq7qRpt6
         8+4XCkC3wK8GzDjK5fAkikHUfjQIgAoLtJpCQTnLCKNIk1W6CjP1yY7qvNCvLpd50AIm
         NvzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785529853; x=1786134653;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sJPatjaoGt9TgsVyGfH9eHA98XjRAYWgm2TTNnuirns=;
        b=ryrle4uN09I2g+5/sJvsn5fGyzu7K+7abANxXv1ipKDs3kBJllhVw9w0IbhiqVKPl3
         CMaIABn0d5NEXB5KLZ64qOTmdLOg2ARofWvOVD2x3gC8f8ZyMK0B2qox2L0Ck1YwdLs3
         XpKMvZZ7W5rfS8u08Dfo5PGg1BKJ+Ie5x+LzFPB0CyKIrf7hAcERmM+XQ3vyT5hz6TQz
         KYooVObgAxBaVSueI0bAETv1eaRXPJ8t8mj7Y7fGSuVfZZZP5pot2ODKKqG9nFTJncNk
         p+mZORvr1qoVPwmVPdqWneXde+FiluaHrOzjMGxFziK/AoD+eOLL+LaD9SH10w9sTs3f
         3N+A==
X-Forwarded-Encrypted: i=1; AHgh+RqDlkXIuJJbVHdUz+YJHX4F4oEfLOwujp7q31NBYYqcKQKtivS3e5B19W//u2r9pftSqPzuTbeQCghzrCgvkqAvIvCGhTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqrvuK2yTZqEMmV8+Y9AXcpE9BRtvk/sla8mOGtuTtYRJ/ej4G
	GM+dTv7CQUBMD+94Hy0wvAcsIzFCDbEOwbc8OOo1lch3bjON5Pz6HeHAHVL/xNHZyEaz0yl6Bud
	rzmYOM0B/VqjPkdJgjstc7oqXrs7M3WcnIQWC29IW
X-Gm-Gg: AR+sD110iug3DtGyFllqatRxscaUQXqd1fIbLNWbnB9N6dKzrOBp9GfOIyuGk9JfH4y
	/nzztnOaO3ij8D+Kjt6v1dHtyBN0OE+vxMzXUoWLj/Zj12FQqfNq8KCXoafnJzDFn24d+V0wK/e
	e+tIjqdx+rc1I8WoZ2sbVYJzRcWhSA9KmdEE/IJM51EagwERQmv0jWTuTy8orHKe6ogRiae1QW7
	zPcgmK6x2EzhxWtrlbjXjbU2eZ71I9yYHKGCnV3kY8YuG4T2uPs5ewf6cjBYiN1bZvlZm32hdZ9
	BOaOM2WojSTlQL7ofsSglU4EsmB2798gSVHbPB17+QhB
X-Received: by 2002:a17:90b:524b:b0:38f:2168:b9cb with SMTP id
 98e67ed59e1d1-38fbc3e5c67mr938294a91.9.1785529852735; Fri, 31 Jul 2026
 13:30:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731022047.189137-1-utilityemal77@gmail.com>
In-Reply-To: <20260731022047.189137-1-utilityemal77@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 31 Jul 2026 16:30:39 -0400
X-Gm-Features: AUfX_mxKHXyCJl3oze3VVACC862OElbuxSdP7kNF71uPYmySH4_LSdAxPXYGbl0
Message-ID: <CAHC9VhSSzNBCSvy4cQHh6OOM4-EvHF+bmrB9=V1y=Lj53RvxQQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/13] BPF interface for applying Landlock rulesets
To: Justin Suess <utilityemal77@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	kpsingh@kernel.org, mic@digikod.net, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, kees@kernel.org, gnoack@google.com, jack@suse.cz, 
	song@kernel.org, yonghong.song@linux.dev, martin.lau@linux.dev, m@maowtm.org, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 10:21=E2=80=AFPM Justin Suess <utilityemal77@gmail.=
com> wrote:
>
> Howdy,
>
> This series lets BPF programs apply an existing, userspace-created
> Landlock ruleset to a program during exec.  The goal is unchanged from
> the RFC [1]: BPF does not create, inspect, or mutate Landlock policy,
> it only decides whether a ruleset that was already created and
> validated through Landlock's existing userspace API should be applied,
> based on runtime exec context.
>
> Motivation
> ---
> Deploying Landlock today requires the sandboxed program's
> cooperation.  A process can only restrict itself, so applying a
> policy system-wide means wrapping every launch path with a helper
> that calls landlock_restrict_self(2) before exec, and anything
> spawned outside those wrappers runs unconfined.  Supervising exec
> from userspace instead (ptrace, seccomp user notifications) is racy
> and slow.  Meanwhile, the tools that do enforce system-wide policy
> with BPF LSM programs today (container security agents such as
> KubeArmor and Tetragon) end up reimplementing path-based access
> control in BPF, fraught with horrors of path reconstruction, bind
> mounts, rename races, and worse, which is exactly the problem Landlock
> already solves in the kernel, with maintained and versioned semantics.
>
> This series composes BPF and Landlock along their natural grain.  The
> intended deployment: a supervisor creates one ruleset per policy
> class through the existing syscalls, a syscall BPF program parks
> them in map kptr fields, and an LSM BPF program picks which (if
> any) to apply to an execution based on its runtime context.  The
> policy semantics stay Landlock's; BPF contributes only the
> programmable decision of when and to whom.  Deciding inside the
> exec path closes the race a userspace supervisor cannot: the
> policy is in place before the first instruction of the new program
> runs.

Discretionary models are fun, and useful in certain situations, but
they do have their limitations ;)  To be fair, mandatory models have
their limitations too :)

I've only just barely skimmed some of the patches in this patchset,
and I didn't have a chance to fully read your reply in the previous
revision yet, so I wanted to get you a quick response here ... as
incomplete as it may be.

As you may, or may not have seen, there is currently an ongoing debate
regarding the location of LSM kfuncs that will impact this patchset.
Sadly, we don't appear to be approaching an agreement on this issue
which introduces some additional risk to this patchset.  We'll have to
see how that ends up, but I just wanted you to be aware of the
situation.

I need to look closer at both the LSM hooks and the BPF kfuncs before
I can really definitively comment on them.  It looks like there has
been some progress towards an LSM agnostic interface, but I'm
concerned more work might be needed.  However, as I said earlier, a
closer examination is needed and perhaps that will reveal something
different.

It's also worth mentioning that this functionality looks an awful lot
like a call to lsm_set_self_attr(LSM_ATTR_EXEC,
<lsm_ctx:LSM_ID_LANDLOCK>, size, 0) with a lsm_ctx::ctx set to a
policy fd.  Once again, perhaps a closer inspection will reveal that
it is nothing like that, but it kept popping into my head while
reading things so I wanted to mention it, especially as it a lot of
the framework infrastructure already exists.

--=20
paul-moore.com
