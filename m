Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87AD30499A
	for <linux-security-module@vger.kernel.org>; Tue, 19 May 2026 16:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779209277; cv=pass; b=mq9pfMumPYDmOw/uO26TTLQfS3L015ob/ca3EIZqh6Ix5xoqIOTsQxEQJBlxfG5gYH64NW7oBPL/zsN4FVC4dcA0XBcFEP/JK9O7Dg4zZl4XP+IiEwPlYEPXOmv9TLVcCbOcvyc1qsOKXCtHy+AcHghQDch+EIzmY58UGBpiwzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779209277; c=relaxed/simple;
	bh=ViKPE/zs4gsJozSFsoDM9rzZ64VredtJAzBJtyzJDD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MJyiLPC7xbGlC40k4ca29zz3awDSYyq4dK8XgzHKtI0zNOCfqWePmHWVRHZ6/wZbfMPbhFNHpkzFiZYArORMmZl/uaY0BNjyKso3q8yr1btyTbE7xYJyPFzqJOz2zvWkwH4GdOLjFqztvijoxxgjITH13dYFLU1daGZYqpJEMtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qCDj36xB; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qCDj36xB"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1336742714fso245c88.1
        for <linux-security-module@vger.kernel.org>; Tue, 19 May 2026 09:47:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779209275; cv=none;
        d=google.com; s=arc-20240605;
        b=BrHn6B4Ovro3oatfiiaXnY7CEezed5Xf9LqQB8rQEeycZWK3DYanWW32au62xUHqk6
         QgyWBnSoyiSqn+5bwwsAZ6N8hBci0ZaUCRPvM+9FHaXQGyZ/7IVCha/FqR9yV8sCDavM
         Ojulc6azEte0CG5H//FsVHkXqK8W9+IH8tEt71KFj+lH4xKkxoH2WjCBUEs6hVNFjRnJ
         qkldHx4pCo2RNF0tfA8NzWtx6AXVAjo5AcFBHbPomxsvS7D9TMN7KO9AYosjFBM8DK/I
         QuoFi+hCOKezDFe3fXc7ZHqTmFzJ3gmJeivmJZL7hT0THPA1NaPJPgRmHNVFfrNunzrw
         v+RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ViKPE/zs4gsJozSFsoDM9rzZ64VredtJAzBJtyzJDD8=;
        fh=MapF3koIilzsqvCT42cS8wn0UCgS8SPelwuoT17/jWI=;
        b=X7wSNJMOBzl2JtPGEe0RCi2PHCofGZzFKnYwd1bgOKXY+BAjfMC5jseolfKMK8ikTf
         GIOD3zQUPf9e241EMPQSWSY4td0dhpw7JXbfB7Zi00mpZaMgzRjJ+lGZRwtUScgbjQTC
         2mZV82+hW7zMu3FJ8idklyr6cGi/uq17gm4/IsIddMV0Vfq3bmKxrS3LTImrDgdbcAb+
         Pcd1Ij6bPO+8PJIfWj5OtMbHanX32GZ9lXpHZYSXDW0+5sjWPSR6Eyo4aHpu9CQnrgo9
         hP85ymCfm2SY03pnmCE7EQs8qvNKxVTm+SC+8st2388ne21U1x4i3KPnQDSmvEgW0lAy
         CBrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779209275; x=1779814075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ViKPE/zs4gsJozSFsoDM9rzZ64VredtJAzBJtyzJDD8=;
        b=qCDj36xB+gWsx5I++4gl23aTy/IsknfkUlDdViRQo5wucJqQ8XdghhD+kLpe7INyJX
         D5hDNw4zhXmqyvnDQ+SLTsfjy3d+aAzPtHK4Hf/yZvzw4vcTdOfCgbx45BElKmR12hfX
         pu5c2HaqaT73C2IpAxqMFMcZNTBN0dPwrTcBUBQ9H3m6bZt6mx/YJhlrLDFNw5Cvbfji
         jvAUMXhEKAap1D9lrGHZsUO74k7gq02nBUlPXXnPBlgSayaJKDgXw3EWOzWfApAElNs6
         BfzZRPCYgAd0MgV4u2ao7+QnmxOz2O+5xUIt6DXaGaTbjbG45iFgS0OcpDl/H5i84vQ9
         f0/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779209275; x=1779814075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ViKPE/zs4gsJozSFsoDM9rzZ64VredtJAzBJtyzJDD8=;
        b=Stn7WAx3xZYtMnCFQECrHwF5hZsIp2O5qWZWeGeCIWo4M+sSofECf1inyJYZiCtemI
         l9w4ObOdQcqcDudzaXTv+ptsSXdepkLtdbKvSaR+4vHOeZxRTXtUI7wq623NyPcnvPhO
         rBNG+dMRacOSjCFMnWN6Eo0RNTuRjVrTWzZm91kMshvkyb5Tv0KyzeGd5FeokhEGIbMB
         PHFGuH6/OmLvBdzQfN0k3Y8GOP3KeeiZk/66KLofxjxK9kjYSRpSZQYdQwXl5EJi6mQ+
         dKlPNK+ROPUJkLQ5SErdQ8TOp6tV6m72SM3fOLmEwlpxsDP+KW4RD6ypVvV07ggjmpvt
         xtkg==
X-Forwarded-Encrypted: i=1; AFNElJ+bhKdcIDhg1mYd94Psx7g9REW36eN5HjtCIsbQAwN2J80eR6OJbwddlpiSvgL27OGcqct7hso67dE9GcZ+i5Jh9BHb1bE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRHICYrPP0YahSpdNqBqXJPLJ0J44C3snhGhYdLSTbZlThowLK
	hzB/4TNn4msLDbJ06GWOxYIGz16vfWDvqlmMZM23b9j6SJy2eWFL9faAv5RFJ0brsUICCpTR9EG
	aBdXoH5M34ra8bhNE+4eH+oncz0SScZfUTRNtZp20
X-Gm-Gg: Acq92OEbUqsDf9BfC9Q3MqdCa+oXF7a4OUOKNYJMVzBW7kIqbhz0P5OmS+6IYEPk82D
	TNgmaMMfSfVLx9pCbu9vvTcTfEGW67teOIu0iki72SEzaBcHf+ooi5Ar6GOHJ055lazJqOrKD7W
	sxVS4zIdfJ8+69Ww1zNhdzyuVGbNFBkVG55bUZBQo8oq5V+sDY6OYMCKtLWdlVlsZczHBZuAd4F
	6TtUFuEuzUCZH6PmBVkT4XWzWyDzhhR5BJoXb7bGeL+9OSz4tuAvyeESAcB6wSoIpHSSvoID5gz
	IoqFWN2rKJCjIHPLnukT+PV3sDDHRVV7fEdupRqeF4G9z43h
X-Received: by 2002:a05:7022:41a3:b0:12c:2ed4:6314 with SMTP id
 a92af1059eb24-13557dcef85mr326451c88.1.1779209273823; Tue, 19 May 2026
 09:47:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <F78521DA-08DC-424E-BBE1-231BC900CEE0@gmail.com>
In-Reply-To: <F78521DA-08DC-424E-BBE1-231BC900CEE0@gmail.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 19 May 2026 18:47:15 +0200
X-Gm-Features: AVHnY4LvG4Du5d39_T67NOwKnozMptM-y7xFRUTkKn7VXkYMQfWRo6DTkXiA7Lg
Message-ID: <CAG48ez0KsuR5z4RDgxWPUoS8e_MJzF74RgFDJayohG48A_N0PQ@mail.gmail.com>
Subject: Re: [RFC] TID v2.0: kernel module for cache-line zeroization against
 Flush+Reload (CLFLUSHOPT + LFENCE + REP STOSQ)
To: Ahmed Hassan <ahmaaaaadbntaaaaa@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-hardening@vger.kernel.org, kernel-hardening@lists.openwall.com, 
	linux-crypto@vger.kernel.org, linux-mm@kvack.org, linux-api@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 11:47=E2=80=AFPM Ahmed Hassan
<ahmaaaaadbntaaaaa@gmail.com> wrote:
>
> Hi kernel developers,
>
> I am sharing TID (The Instant Destroyer) v2.0, a Linux kernel module
> written in C that addresses a specific gap in existing security
> libraries: none of them (libsodium, OpenSSL, glibc memzero_explicit)
> flush CPU cache lines after memory zeroization.
>
>
> =3D=3D Problem =3D=3D
>
> Standard zeroization functions (explicit_bzero, sodium_memzero,
> OPENSSL_cleanse) prevent the compiler from eliding the wipe, but do
> not evict CPU cache lines (L1/L2/L3). This leaves residual key
> material measurable via Flush+Reload (Yarom & Falkner, 2014) after
> data use ends.

The thing you're talking about isn't really related to the
Flush+Reload side channel attack, right? You're just talking about
flushing cache lines.

In what threat model would this be an issue? Normally, the goal of
memory zeroing is to ensure that sensitive data is wiped before an
attacker has a chance to physically pull out the RAM from a machine
and plug it into another device that can reveal RAM contents, or
before an attacker gains physical control of a locked device and can
connect malicious peripherals to it, or such.

So for this to be an actual security problem, the device would have to
keep running in a sufficiently high power state that data caches are
not discarded, and at the same time not perform enough memory accesses
to cause this memory to be discarded...

Assuming that this is an actual problem, why are you using a kernel
module for this? At least on x86, CLFLUSH is unprivileged, so crypto
libraries should be able to just use that directly. (There is the
caveat of what happens when the kernel migrates pages or kills a
process, but that's a larger problem.)
