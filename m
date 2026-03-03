Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A8A34F48C
	for <linux-security-module@vger.kernel.org>; Tue,  3 Mar 2026 09:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772528897; cv=none; b=UMVI5U9XsDDbTFg/kUKiQJylCeF6z0fSItOOBcDT90UrTzOAq3+ceecFwmtzQ8lGzL5AdPbzEG4obbpVXAzXYVW2OYdnjINlNrxgbjjrueLlSNOheGBzXSVyuLeGfmf44vC7lS2fFk7hyL+RZpEEB8BqhPM6rLEkpU5E58usfuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772528897; c=relaxed/simple;
	bh=jH3a5WvSl4hsNVqvGQHSPUcAxKpQELeoMlBc1iNZgoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QYbdNUF5lO3qhP2J9yRsFzV0LqcWqV20ilIPSY2+fDie3B53J+6E8kdaOy2BDie4qJSL3JHhE+qPnhU/rFpzkoFZM3KXvfPj/tgUYsGt/PgrnqKqZ6fTxZrZoMOKaG7VeddxF/TwNaWllOGJYYal79N29VFmBzW11O3dKf5/rS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWo9rSby; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWo9rSby"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-483770e0b25so46007475e9.0
        for <linux-security-module@vger.kernel.org>; Tue, 03 Mar 2026 01:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772528895; x=1773133695; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=phEiBdG5ZIERY6yJr+I2LBbcsXFa1y6p3ngiHNYKF5Q=;
        b=IWo9rSbykMmGKJ5+zb+hpN+8JAYMBfFE3YDDSmCUlirTW7hr2dSl7Pk9LlOxwUEhxC
         yBsGw0/9SAALxn5GDF82m3jEYThxPfRVoiNNeizRg489gWad8iJNwRAA7Vv0gFLQxcR1
         ZsgQJj84VoDvSc9+BZwK7bCLC20xm7jzRGcrhu2UQho0VWEuEO5cjxNjIfAq/5m/BQDs
         eW9m5ArivDapLdiLPPlHNSYkvjszlUv+IlfJMgJMKjFj09t6wgG5WhUHYQTqcSYnhqzl
         Qk4Osx5+pDE/GZTadtQK6cJC6C3UiXnRlq1xijezURTZsuJlfijwp23biaNulCnyYOMx
         DPJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772528895; x=1773133695;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=phEiBdG5ZIERY6yJr+I2LBbcsXFa1y6p3ngiHNYKF5Q=;
        b=ahQC7KHl7KB8Cis8hOLjOWgjwdmQgpEhBgrO7aSEgneRPZvgFMTsIZkZbsvWQzojxr
         /ymrIZT0U8K8UdPSxaSyRLpJCEfiPSfASawMB/ABKR17kHKXLaUFLwnODgmDqh+yNrBY
         EZUJmG0FyQ8h/vfm+2Yny5GHq96udQvqnXKEamz/SUCvYaYzqah2eUQpIHjBZ1eZDIYj
         4pURRIWQHqEh3tdjszEheHP+dULplJ3mEU3zo9NebAKsSqkEfNQb/EvYaWmw+DcXSOBh
         mQ6mmexfnkeN4H8HBf1JdX0oaejL4dhPdNm7JbmxVFNdZKH+Qbhdpr0sZLdk0UTv42Hp
         0YKA==
X-Forwarded-Encrypted: i=1; AJvYcCVfsF+QBWdKTUxaAPEJhkPbRPhUJWNlU+YYOU4858JmyFtpErgE81pSOYOgaCWqcqrfN5EhEfmRIzI3PZRnEEl7wo2LRVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE/olkW6ngPPynoMvufRm0wbmGjx8uLLlHK1dedDLRCnhuI3yx
	j5Irh3Z7iaLu2KwrvZnBXSdp+aJpOTDRK94G2Yx0OmirZhjoEvr29Svn
X-Gm-Gg: ATEYQzzS1ipi7D0ffKWCgfcnLei3FZn4B8CSM2Fn2fdBuoRXElVEYZ58YMj9wIz25D9
	ZnBs2qYHXKp4eNK343zUhNb3hSTHPK0zgBVCSy219Ccnlx3OK02uXtONa1cVtKGi685Dd5ODUtW
	lBWMzsxRGf49Z2xzzO3+ukjC5TOk0j39CTujV8aVdAzDhxbYNxda/ZGDIJfpyoqFjOV8VA47u4/
	5zKoyK+GaRfunx+W2ijTYwdgjOw5Pc7aPa0zPFVbDw2NCmN59EaqYUEfKOJUlnBRC51/7XqhID2
	5Xe6mtSUTkEJI9t+HonADB0Gt+Dr5buOFZg70p+cjSR5U6txbFAmgW6ecyL4pkPPfJ+QT9fycXW
	tL6gDqMOW5U1Vc7hxdhuoohVD8RqoNR6/UN/5elBGruBVLtuDIZt5A3tHBrjuV27tQjWTAAkE0d
	6X9SECx2v1emJnd5whhdVQI09r2jSL9XJinnzx7iopXgwqMTha
X-Received: by 2002:a05:600d:13:b0:485:110f:5b7f with SMTP id 5b1f17b1804b1-485110f5be6mr54843725e9.19.1772528894586;
        Tue, 03 Mar 2026 01:08:14 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3b841absm376589785e9.13.2026.03.03.01.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 01:08:14 -0800 (PST)
Date: Tue, 3 Mar 2026 10:08:07 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: "Panagiotis \"Ivory\" Vasilopoulos" <git@n0toose.net>
Cc: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Dan Cojocaru <dan@dcdev.ro>
Subject: Re: [PATCH v3] landlock: Expand restrict flags example for ABI
 version 8
Message-ID: <20260303.13455f40d0c5@gnoack.org>
References: <20260228-landlock-docs-add-tsync-example-v3-1-140ab50f0524@n0toose.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260228-landlock-docs-add-tsync-example-v3-1-140ab50f0524@n0toose.net>

On Sat, Feb 28, 2026 at 10:36:59PM +0100, Panagiotis "Ivory" Vasilopoulos wrote:
> diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> index 13134bccdd39d78ddce3daf454f32dda162ce91b..b71ac7aa308260b8141e5d35248fb68cec6dcba9 100644
> --- a/Documentation/userspace-api/landlock.rst
> +++ b/Documentation/userspace-api/landlock.rst
> @@ -196,13 +196,33 @@ similar backwards compatibility check is needed for the restrict flags
>  (see sys_landlock_restrict_self() documentation for available flags):
>  
>  .. code-block:: c
> -
> -    __u32 restrict_flags = LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON;
> -    if (abi < 7) {
> -        /* Clear logging flags unsupported before ABI 7. */
> +    __u32 restrict_flags =
> +        LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON |
> +        LANDLOCK_RESTRICT_SELF_TSYNC;
> +    switch (abi) {
> +    case 1 ... 6:
> +        /* Clear logging flags unsupported for ABI < 7 */
>          restrict_flags &= ~(LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF |
>                              LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON |
>                              LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF);
> +        __attribute__((fallthrough));
> +    case 7:
> +        /* Removes multithreaded enforcement flag unsupported for ABI < 8 */
> +        /*
> +         * WARNING!
> +         * Don't copy-paste this just yet! This example impacts enforcement
> +         * and can potentially decrease protection if misused.
> +         *
> +         * Below ABI v8, a Landlock policy can only be enforced for the calling
> +         * thread and its children. This behavior remains a default for ABI v8,
> +         * but the flag ``LANDLOCK_RESTRICT_SELF_TSYNC`` can now be used to
> +         * enforce policies across all threads of the calling process. If an
> +         * application's Landlock integration was designed under the assumption
> +         * that the flag is used (such as when children threads are responsible
> +         * for enforcing and/or overriding policies of parents and siblings),
> +         * removing said flag can decrease protection for older Linux versions.
> +         */
> +        restrict_flags &= ~LANDLOCK_RESTRICT_SELF_TSYNC;
>      }

Hello!

Sorry for nit-picking even further here;

* You have two immediately adjacent comments here which should be
  merged into one.
* It is enough to use a more terse warning here;
  would suggest something like:

/*
 * Removes multithreaded enforcement flag unsupported for ABI < 8.
 *
 * WARNING: Calling landlock_restrict_self(2) without this flag
 * is only equivalent if the calling process is single-threaded.
 */

Thanks,
–Günther
