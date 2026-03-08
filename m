Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B732A3446CB
	for <linux-security-module@vger.kernel.org>; Sun,  8 Mar 2026 07:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772956099; cv=none; b=I6paUKlGd1iCIkuBxboEZpuRqZNZOlfYpTCiJX6VGF1CG2F2rxKU/9fJH6XhxIJsUgbLbWgeGARzJEaYE/sxLaHq3dnfev0ufwyvFlCdwYtnuxCRK+mB95VpD5i2eU6DRfBvVs4/689zXXuVMEFtoOuJUwOCSCKVWiX0XKtlK70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772956099; c=relaxed/simple;
	bh=5Kn1rIgXr/VfSh2FYokFQ5Xhl/V9jSbyumwCwi8VucI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RasV5S8ya+009lHS1AJgSTK1QrP60X/Yg6T4kICblOu/Q8QR4Lny7fkis7FbuUfFSIM/WbFDEthnxdR+VnSfWJ4vp6iIgf3GpkCZ49ggZxFpxSPHragHdwozxt8g6YV5jEoa3rIFsPZUeFi7qSKUV9Gt38YglotXolDgV3iBGng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fLCiyfsE; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLCiyfsE"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ae50a33ff8so52278905ad.3
        for <linux-security-module@vger.kernel.org>; Sat, 07 Mar 2026 23:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772956098; x=1773560898; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OmbQKad/yw7sNPhRMboDHSs+lSb0BUfzcUHLjfJzC4c=;
        b=fLCiyfsEb4aFwrwUI47NuHrA0s3FSv4le9OAIXnim1UqAxzzt0EbAm4egXa2K9kUvx
         tLjjnr3AUcAfdiD6GNj5s9SQNoaefySw8qwe25FaSi9y9gtfnYvlH8UKdrweJZX7aqUw
         dSaqJxuT4N6HXiaHSpa8j7Vsy9hursjmjUWpx/IPJnuieXz2oV9iCBX5MrpJ598JPv8t
         +HThstHwvmEeC/XuRyuzgPc+C0VBVCgnd+1hj0mI19+P0OxtFjV9WXQKkeKluHxgSrq6
         VRO+mW/nSm38nXeRygpyC12U6FRSsWY2AHJH1l6Sj6+vNp4kFvivULcMF8c40KBzR22F
         jWwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772956098; x=1773560898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OmbQKad/yw7sNPhRMboDHSs+lSb0BUfzcUHLjfJzC4c=;
        b=dhepnciexyMK++8lStuVXMRb+B4LVHRxWgTrclnSLXKsMpxvnNHCNeEPuviPTkv43p
         zMtj8H05oG9KIlYAdVIOKr+gXILIjkrKxgFnZcqwnLoKUF94s2OzqgDI2UoUHVUBZlxf
         kMsM1lyxAwLyi5KDzm//s8B/2MXe1kl1bCiYG/Nn1jigdqHwRai9OW7D0sqqsl73tbxf
         Zlrygmg3tVzjbWPX0LMm902ZNchuBt5EDlGuBn8zV4zKO41739D14wFg80KHJbiNi6dM
         8lO2gHht/dqmrsufg4I03aS9t1OYuOj153OrIH0/gdR6Mn67ap9mrrlKNOdQt5vPQaUv
         iVgQ==
X-Gm-Message-State: AOJu0Yy1iqmDIEt578Yzt8PEjoTfrYYM/9a/0gKNH4LaK/yAksM90Ac7
	celHUW7w4WjHzTr4a8aoliZke/A+zjl0mAh7Uf460FjSjhHx159byALJ
X-Gm-Gg: ATEYQzzt8NjXHbzTTUberAr8sOgdlbE+9z2cr0uXcHdXSE2PIcX3jucdzCese8K5wh3
	vTQN1KSnX1qpHAYd2oypD0bR05dU/qBSyA+WmrTNxI7U/+NPlSeUb6j1QYroZ0LMzqP88vAEhub
	DrvG3wM35kWTpLew3iLnMacNqK0cmNRpFQ0137A2c1hjdGfmZVeM71k/BpUYtAy5LDjUH8JB+rc
	hmNJGljcEGsjVKXki2K/cupxoEIeFC7HeFm1BTk1SEwIgFjW0BGymQEQGUoyFb9KGPczvcJLAaD
	HlHfvsKV0tTNPg7TAqaj8MdZwbiUnoUrShfOIRnI39gS2/Is1+D+WEDwJryxDogZxLP8B8Fqb94
	Xi+jSY9aAH0k132r0shCuaGVYCg16q8WpDk8uOHfOpQqDVy4hWiO6GcKeLao3h7+60CostpS0V9
	BNnqHnn56hjEUWZK2iQqo=
X-Received: by 2002:a17:902:cf4c:b0:2ae:6b54:27b1 with SMTP id d9443c01a7336-2ae82450ddemr76055945ad.40.1772956097968;
        Sat, 07 Mar 2026 23:48:17 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e57b14sm93468275ad.19.2026.03.07.23.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 23:48:17 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 6FAFF41FD8A6; Sun, 08 Mar 2026 14:48:13 +0700 (WIB)
Date: Sun, 8 Mar 2026 14:48:13 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Evan Ducas <evan.j.ducas@gmail.com>, wufan@kernel.org, corbet@lwn.net,
	skhan@linuxfoundation.org
Cc: linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: security: ipe: fix typos and grammar
Message-ID: <aa0pvREYJYrAZRsB@archie.me>
References: <20260308031633.28890-1-evan.j.ducas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vB29sbE/bA8VxDG8"
Content-Disposition: inline
In-Reply-To: <20260308031633.28890-1-evan.j.ducas@gmail.com>


--vB29sbE/bA8VxDG8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 07, 2026 at 10:16:33PM -0500, Evan Ducas wrote:
>  As requirements change over time (vulnerabilities are found in previously
> -trusted applications, keys roll, etcetera). Updating a kernel to change =
the
> +trusted applications, keys roll, etcetera). Updating a kernel to change =
to
>  meet those security goals is not always a suitable option, as updates ar=
e not
>  always risk-free, and blocking a security update leaves systems vulnerab=
le.
>  This means IPE requires a policy that can be completely updated (allowing

As requirements change over time ..., updating a kernel to meet ..., yet
blocking a security update ... .

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--vB29sbE/bA8VxDG8
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaa0puAAKCRD2uYlJVVFO
o5byAQDwdsUfbgqZLGBn546xcdOSlCftJat4qLbiS2NcDKE+9wEAhe+mAGEuqNq3
sg2kekxxONJDUWS1X7oX5QJCwRIH4AM=
=3l/q
-----END PGP SIGNATURE-----

--vB29sbE/bA8VxDG8--
