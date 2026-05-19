Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E193BCD2E
	for <linux-security-module@vger.kernel.org>; Tue, 19 May 2026 21:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779226957; cv=pass; b=WgvekFRBq9QOxGeEA4TbsS/IS9/CmkPfLrhFsAfzNiwNJfOQxsYk9yDm/h1Drvbzz/oxrV8FwAfburSqcJDx7e8MHDXM+GcbcAYZ9RFgs5iXrZsr/N0b8mqB6I5azuLKC+8ILDdIwG6/AJweqCD3YXTWY9akNY/uZnOOd9/7Byk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779226957; c=relaxed/simple;
	bh=agpQDPE0e0tDa6PFtfyC+WslCRjLfXBgwgqDsBVIG9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uuFOtf6bFbZ/1BxZpZO3f9PL3IDpUvSM7enV4S5zDfkpakJEIh/pvaGq6YpfjsDfb76TjxO2BhJLOJ0G+lSHJNm/haL5bp3BvC5ouLTkqWZlg3Supeil6ELucgiZhb3dmuQLnCxq7ikorHdQuVXVd39GB7N4foP2H+EaweX/Gy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cBBOp9lP; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cBBOp9lP"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-67bf769704eso117a12.0
        for <linux-security-module@vger.kernel.org>; Tue, 19 May 2026 14:42:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779226954; cv=none;
        d=google.com; s=arc-20240605;
        b=WyqmvFIbqLGHc/6hppJJ9xYbnG3Fe57YdsNiG06dnOXlDVOzENuPOE26U6fC/StnLQ
         Dj3y+BDq2TSqL6rB+EAc7Y3K/up3o5+KaSoJGg14WEfgm0TUacwwM2MTf3xmRkfthBZn
         wXqN6VX10NU0ly6sGgMtnBKKA3C5dMoMzxA+H6X9m7BscblbtG+R/XAR4Nt0eVofNdOG
         oABSoqMY6zoZFuqaUn1F1DaJD0Zf91gJmzO9/LExOmpiJo6punXkYo5aJzJW7QW2gTGS
         ati0aFsONqWVsMaNXEH3NZJSxUwlg6FRtGLyguoRxgsDQk09mejuO+dQmzIl8jnvnpel
         9ZVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=agpQDPE0e0tDa6PFtfyC+WslCRjLfXBgwgqDsBVIG9k=;
        fh=KJJ7ycJgE8qBTUchSPc/mhhQnmzn1be1zz2hVcvS5ck=;
        b=BrYmo7aR5120vdtNgmKUBGZ24QKOyWJrF9W6qQENWEx+qPfyrRQarJvOEqimOS7nJo
         hZEwaWSngdOCBnEbG+/KSgaQ3sG0GPmRiE0W8n1KeSat5RQYE5ejRwX7Ou9v5CLi+is7
         lC8t4ueC+yS8VANFfQPyIWj5Xl4Rxc9eBMME2i0peM4nS5seiAE2VOqRFEnFQ6wfmNpg
         NpD4LCg4/xskd+JS5+Y1aIfp98F38YFzCGXvyP//FGRFMwkDG3jRzNQj28Y3klwKTWSj
         F5q0o4SxZtEE8ba/SIsRbt8a6L1BpIU9liKF6u2DEKwn6shiI0PvkzcrZmzzYqWoov2D
         R82A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779226954; x=1779831754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=agpQDPE0e0tDa6PFtfyC+WslCRjLfXBgwgqDsBVIG9k=;
        b=cBBOp9lPxsBqzp5DiVVxXZDcRjTE3euWHcLy8b7vbCVmNAJKacI97hsJ3Vh0KDFaXt
         NXU/Zw17XqHcSHLDvSXAwaJJyllAMtOnzA54IEMDi5toSkc1FhEXHqZzqiln7NYZ4wvW
         lfDw4ZrKlWmzFMu6D/n8ftMX8TONAUMPAsEN31ppZN2D373vE0vjsNy/4phHOsAWuYNI
         nF/qzfTTzsfvL29YjAa8hB1+SvxRY6O7eKRjW3auOF834Bo2J3b1uCxJC4HpkvPM5oIs
         V7wciD7Ct1uavsVVCtQKUXyo51LalxiQasEvoLneaUrOkZFwJnRtJwnYl4KuZY4B5BFn
         MUcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779226954; x=1779831754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=agpQDPE0e0tDa6PFtfyC+WslCRjLfXBgwgqDsBVIG9k=;
        b=F6NXUUis3ZtexueBpwcoKS+DgqCHXdGeKYHyYM5omy6sYyK9634nlvJmU5A7tFGB/n
         dem8CcZaU5Tljjrdyp3RiQi+ayP1L8CaKXfCQznQkm1maYZSURi+PRrzaPgSljjtybCp
         QL+RxqKFNexYG1shajkvF1ISGprsEQ5gdXHyPCQ79G6CRRYsTYDG/4A36vr2MDR9rHnp
         yfk5fqTR1rpeuw7Cx/aw0Hept9QgiCxpEKAfDpJWWek3wDD6F9ykFvB3epyTjtQFbuUl
         zVyWKMxWBJE361hgW/cxftR4BXgTTcbWRJIKJoYesnfKYl1DLbrKFG0NRNAVmhl4+Yfs
         eODA==
X-Forwarded-Encrypted: i=1; AFNElJ8JuBmajfDlhR4bRKZjSIJxO5NngNmz891wNgb2cIk4PXL2BXgHp52B7DeKyfV6dQ9Cn+dkTpclZZz7+vfdAAqa6RT5FSs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlevvjss01agqNpP0HcAZggyDMS2xdA5xHLj8bn8W1UGCe7dpZ
	rus8rxnggfzCx0m9Kd6n+3bAqRHbg/xJHmM+b2i8wRhr6hCmwVP+9r49gwwJlkvPwzbbERWlU64
	fWw8t/gVdUx6WJETvItgKIyN+aovhweVIeALGU7ov
X-Gm-Gg: Acq92OGlO6U4Odu1KIFZ8uPtmx+vJBRE56uW/7BmUKxYmiXSduaEK4/gXsA1lQhlN4R
	d1/eXOaSoxK7rYWL6Tc+O4cYJGjPBoioFsqLQUroPVMHKBs4nuB8fk7T673D+Mx4M53c5AOBMMe
	5BvdbT7SoKBKS5k59R04YV55xyajLJ2hVDUmJjFZnw7DpB+h1w8DIZJikVxCdTmpWqO0iZrbUfe
	ENoJkcdAQ2vNW81laqTXoOxm/VaOdq4vcDyud/M1EmXlswVyybbV/bcKvmhSbLi4+1roFED7hir
	CF+RoockCfetsdtGgxYP1gwmQp91pzTbAnFYfKYVxUrN3vc=
X-Received: by 2002:a05:6402:20c6:20b0:678:a5c3:4d12 with SMTP id
 4fb4d7f45d1cf-684985e277fmr173995a12.3.1779226953632; Tue, 19 May 2026
 14:42:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <F78521DA-08DC-424E-BBE1-231BC900CEE0@gmail.com>
 <CAG48ez0KsuR5z4RDgxWPUoS8e_MJzF74RgFDJayohG48A_N0PQ@mail.gmail.com> <CAAmtCfMHqdWbYh-Hc5sGbOhXSM-aCA9G0-s64G8FTM+rGEV5RA@mail.gmail.com>
In-Reply-To: <CAAmtCfMHqdWbYh-Hc5sGbOhXSM-aCA9G0-s64G8FTM+rGEV5RA@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 19 May 2026 23:41:56 +0200
X-Gm-Features: AVHnY4KelXMX0Ox3UHP6DtmSDnRxPxmxV49wSNMKd-K67wpQhqz9skVmJZNDODo
Message-ID: <CAG48ez3u1OCx+zCWEs-_gowDmQ=KLbXO2xZ83LCZ1o1gxRT3Ww@mail.gmail.com>
Subject: Re: [RFC] TID v2.0: kernel module for cache-line zeroization against
 Flush+Reload (CLFLUSHOPT + LFENCE + REP STOSQ)
To: Ahmad Hasan <ahmaaaaadbntaaaaa@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-hardening@vger.kernel.org, kernel-hardening@lists.openwall.com, 
	linux-crypto@vger.kernel.org, linux-mm@kvack.org, linux-api@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 11:31=E2=80=AFPM Ahmad Hasan
<ahmaaaaadbntaaaaa@gmail.com> wrote:
> Thank you for your questions. I'll address each one:
>
> =3D=3D 1. Threat Model =3D=3D
>
> The target scenario is a same-machine attacker
> in multi-tenant/cloud environments where two
> processes share physical L3 cache.
>
> Example: a cryptographic service and a malicious
> process running on the same host. The attacker
> uses Flush+Reload to measure cache access timing
> after every encryption operation =E2=80=94 no physical
> access required.
>
> This is documented with real measurements:
> - Without TID: 78 cycles (Cache HIT =E2=80=94 key pattern visible)
> - With TID v2.0: 286 cycles (Cache MISS =E2=80=94 attack defeated)

So you're assuming that the cryptographic code leaks secrets through a
cache-based side channel? That would be a vulnerability in the crypto
code.

> =3D=3D 2. Why Kernel Module and not userspace? =3D=3D
>
> You are correct that CLFLUSHOPT does not require
> Ring 0. However, userspace execution can be
> interrupted by a Context Switch, which expands
> the timing window from 372ns to 36,640ns =E2=80=94
> making the attack significantly easier.

Why does it matter how many hundreds of nanoseconds it takes to wipe
the data from memory? You can also have a context switch directly
before you enter your cache-wiping syscall, or in the middle of a
crypto operation.

> =3D=3D 3. Why not add this directly to libraries? =3D=3D
>
> No major security library implements CLFLUSHOPT
> after wiping =E2=80=94 not OpenSSL, not libsodium, not
> glibc, not memzero_explicit. This gap has existed
> since Flush+Reload was published in 2014.

I don't think that's a gap, because the standard approach to
mitigating cache-based side channels such as FLUSH+RELOAD is to not
access memory at secret-dependent indices in the first place.
