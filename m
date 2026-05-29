Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A497834D4F9
	for <linux-security-module@vger.kernel.org>; Fri, 29 May 2026 01:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780018814; cv=pass; b=QuP+xGUOXmSzniBCwsGtEXsoFWs/I6J47ySlOMuUhYEVdwNpLDgMLjdRDLGCbmwEp+aX0b/dWikSeneeSRiB1e4/w1wVruPjm19lFToVZtDkyfHjIQB/Fuz9rzUNxMJvijcj5wkdKdHgUD0uB06v/9OOBoRoXw/pZW4DXu4mG4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780018814; c=relaxed/simple;
	bh=nB8DzgmI4Uf+wL3FIzeqsKvQeo8gKf6cZlw/sgbKbN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m3iGmiL7Ok69k+OkVZMBN49Y+/bE0N9sWPm27DKvqFZhnodgYVEiEtLfimZd7yFxOzHoEZOfabpstb5UK2HszWGRIBf49fCZ7/L3r7YZYLkEzbfI9IzzPdauzbfnrvyX5mcGqoc86lNlCYv1OToUXoPXHFwFmxPq/yEe8ZbM74c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=aGUs/LOn; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="aGUs/LOn"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2bf2247e38eso1224515ad.3
        for <linux-security-module@vger.kernel.org>; Thu, 28 May 2026 18:40:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780018812; cv=none;
        d=google.com; s=arc-20240605;
        b=Fr6R8OSZ3DfGmwYvYN+Kwr6NWvVVL9dtlykbo3R9yrqp8CGPMMvRoVs0j4dxx12BQE
         wnKohSw8wkP2P+bOF1FGqJ0cpUwBgKhm4DA42FbfXjGNeu3p4FOPhnDzyO/VwAuxOFrS
         BG3eDbnCCGFAp5i4s6L9qs4tOpGUOiPM75wPW+6M/HSar7m2q6zRucLXS+E0qUcdrO5w
         layEpxpV4tJj4Uh0H2wtaV5YmbPTCQp1uxKpnWYlWk+4RPMsjMGChzBTMIjCCDOjUdv0
         9RHFnqu7UiEaRHC0GLRwxUKVnVLfF3GZXj+3luS7RS/KZ5fEx5Uf3t0RGDEGfXlSWtpi
         Wndg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nT+a7lkJsrlAHvzBGXzTzuV1m/oedTj4WpMHSatMKss=;
        fh=m+3j3BVVbkwFugFaqsbnYl62dDvwswi8AgAfN8ukg/0=;
        b=GVY6GzbIgJiQnLyxqJZDtciSvKDmIFB9uRLfZuivRMPH668cK5yKX+PpffSwZBf4H0
         rnrwrd/dE9euGarkP9o0KttnGCAOFJfafasfl8LDOwIvhoJSIMX0i0kmUWaYRsYzukg8
         iuCv8hkUcRnkD7ADRcqqy+vAT6EFjrXiSiM/I0+07LQgMb0tp5LD5Rr6s3jwVxXUMe1J
         PUqjJg2wAoIhR3mNiC2UTovjFwfod6z5Px1SroxRQyUcf808GgcvtwvsLk78Qh4glyi8
         +ni7+UHkf8k0deFGESoTC1Qp09zXRPl9AhH58P69yAjmpxuksbryFN/cheQQsLbk2V50
         wgWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1780018812; x=1780623612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nT+a7lkJsrlAHvzBGXzTzuV1m/oedTj4WpMHSatMKss=;
        b=aGUs/LOnatQSw5Jzp0cQgCCqa2ToLCVn1Ai85XW5+8CNGjqpuRejIZDj/3GK6D/7fb
         TyHm+kPKH1bNcFC8HMByk0Qn47HEziNgI5aJgr4X2eHAA0RC69eMwpq1moiujik/R32f
         YI6lcDQhbgoS4vYb3zJoEt4c6BTqYYCPBm1IDTePjppabcetxMMmfdS5lGl+bkE/8Rbz
         yom/tPo0kn1ag7Pp9JaAFJNepv6BGm6umnZcafXJycjeZKsnml3wxb6WlOH2YnvAWkKQ
         zIenjqVDydOeCCellxTA06gBAiUuL/a4s3HTqgphRCX19ExWL/aBjgggEHNk/wjiEPYq
         n/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780018812; x=1780623612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nT+a7lkJsrlAHvzBGXzTzuV1m/oedTj4WpMHSatMKss=;
        b=Xk5bRcqHPjHVglA6/X5VPQVMrP3f0oYW9oagPm1J4Knt/VQq92AUT7TKWpAl598KhT
         xQtZ0oDHP+mLwCyQBNBxO3MGR2J+xW6oakxCKstnhF0ooNSvkdGTc+MiGXGz9fMu0EEI
         bKCBm8Dx8YIaZjMrX//HSiCgryhXpFcmN3Si3v5qrzfYQGvnpNefaaxUTBDaOu06p0Ht
         1xntYoah6xIkK89ON8aejZZ+DI5UbC+f4xaT1pJCY1KjcqyEGCWDxlMoZ/AViFE+rYGH
         IWBqeWHvyP3pWixqjnf8Zv0wh9IM3JCRaS8bYlSDHT6kYR2136qqkCutUNOE7hNZqY69
         ADaw==
X-Forwarded-Encrypted: i=1; AFNElJ9xpAecTuJCa6RTYozVBKLWtT+wEX1tLpgEhLyaMhS4b676lu8dpgOrnXqCW2DNJyaY1BAL8jMjbJG/w9/xTdDcCrjJ3WY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVxKfTKBRAIast6BaLhbIl2HALjZZi8/6n4bqZdh8AA336FdxM
	fFg0+m0mneQKxAfnLeDa05ii9d2muPlNgYWOqnGQvn6RPOoC+WlnD5gHPQcVQcGenkDHVhKU9jf
	JGmafGTgpSgZme5pi+gxL7xusU1Fd7YD5wBAisS3U
X-Gm-Gg: Acq92OHConyVZPfnnoVB6F6wDHB2TqJuNBr2l2nKtrV/MtBZd2MHO2AKSLJ6m7AlIoj
	QdzV4k6y5eRErwwNhr3Cn0O3iqSHDkVYdZ98BrHIfOI/wOTi1Ef5jj8NxxaviO2LY/FdoKZ9Wnk
	55wyjpR2ssmoRvg21UuWAq+6XxNH2/cf5J3SIg9PHYLQlI172W0uc3JQwGiZdQskpIRNZ7vOvEj
	pT80t/lYesVCIn/kBtT+pW+nWPFu68zOrlOG3Yj20DO2ZtlWx4hETEbGVzjDK/SGSfHY2SAv/Z1
	gNkxB4+9jkxwEMuP4g==
X-Received: by 2002:a17:902:fc43:b0:2bd:8db9:cc0c with SMTP id
 d9443c01a7336-2bf2050c287mr10732425ad.6.1780018811824; Thu, 28 May 2026
 18:40:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528030915.2654994-1-bboscaccy@linux.microsoft.com>
In-Reply-To: <20260528030915.2654994-1-bboscaccy@linux.microsoft.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 28 May 2026 21:39:59 -0400
X-Gm-Features: AVHnY4JBgScHzdO23PZfFoqVg3OLDZJpvyel47BsFvYr_UPv7rpRCxmoGNJCcHM
Message-ID: <CAHC9VhSQzV0xZPFwkNdUJ5Lz8Mw6gppBhR6QyRdrY8xCTohHDw@mail.gmail.com>
Subject: Re: [PATCH 00/11] hornet: security, tooling and selftest fixes
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Eric Biggers <ebiggers@kernel.org>, 
	Fan Wu <wufan@kernel.org>, James.Bottomley@hansenpartnership.com, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 11:09=E2=80=AFPM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
>
> Patch 1 closes a TOCTOU race in signature verification. Map
> contents were hashed at the program-load hook and re-hashed at
> the program-run hook, leaving a window in which a sufficiently
> privileged attacker could mutate a map between the two checks
> and run a program whose maps no longer matched what was signed.
> The fix records the verified hashes on the prog at load time
> and, in security_bpf_prog, checks them against
> prog->aux->used_maps =E2=80=94 the same map set the verifier and
> runtime resolve against =E2=80=94 so the verified and executed sets
> cannot diverge. The per-map index in the signature format is no
> longer needed and is dropped; the check becomes a subset test.
> Reported by Eric Biggers.
>
> Patches 2-3 fix two counting bugs in the same area: duplicate maps
> could satisfy the required hash count, and an off-by-one capped
> accepted maps at MAX_USED_MAPS.
>
> Patches 4-11 are in response to sashiko feedback found here:
> https://sashiko.dev/#/patchset/20260507191416.2984054-1-bboscaccy%40linux=
.microsoft.com
>
> They provide some correctness fixes in the hornet tooling along with
> making the selftest behave under cross-compilation and skip cleanly
> when signing keys / bpftool / vmlinux BTF are unavailable, instead of
> breaking the global selftest build.
>
> Blaise Boscaccy (11):
>   hornet: fix TOCTOU in signed program verification
>   hornet: invert map set check logic
>   hornet: fix off-by-one bug in max used maps check
>   selftests: hornet: handle cross compilation and test skipping
>   hornet: gen_sig: fix off-by-one check for used maps
>   hornet: gen_sig: fix error string allocations
>   hornet: gen_sig: check for bad allocations
>   hornet: gen_sig: fix missing command line switches
>   hornet: scripts: set a non-zero error code for usage
>   hornet: scripts: harden scripts to handle trailing whitespace
>   hornet: scripts: Improve argument handling and error messages
>
>  Documentation/admin-guide/LSM/Hornet.rst |  39 +++---
>  scripts/hornet/extract-insn.sh           |  24 ++--
>  scripts/hornet/extract-map.sh            |  25 ++--
>  scripts/hornet/extract-skel.sh           |  35 ++++--
>  scripts/hornet/gen_sig.c                 |  61 ++++++----
>  scripts/hornet/write-sig.sh              |  10 +-
>  security/hornet/hornet.asn1              |   1 -
>  security/hornet/hornet_lsm.c             | 148 ++++-------------------
>  tools/testing/selftests/hornet/Makefile  | 114 +++++++++++++----
>  9 files changed, 235 insertions(+), 222 deletions(-)

Aside from a possible (?) typo in patch 5/11, this patchset looks okay
to me so I'm going to merge it to lsm/dev-staging now with the idea of
moving it to lsm/dev once Blaise provides some clarity on patch-5.

--=20
paul-moore.com
