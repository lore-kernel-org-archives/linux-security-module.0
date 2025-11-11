Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D14313E3B
	for <linux-security-module@vger.kernel.org>; Tue, 11 Nov 2025 02:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762828498; cv=none; b=UzCsf8d3CRfIGPc+YUjOJSMQL3NCKUcYi9YDB8CW4uxTFxUzJvPyEZtldQ1ZSvDBb5vdPNVnOnY1hzmP4bfqBVLmCNm0mymFQBVcpPhzErub99BHtZPR8Gv9p2YObedmtei7st/kEjTtw4gcKR440ep0Xe+UTaHK35Iry9k51Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762828498; c=relaxed/simple;
	bh=36ncl0PUcmfXo8Ga7gX6fzon1aa5NOwmeXnlIwgkJX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J6SClM09TtKaJ5QZCCm+zta4ZHf1PsEg8KJ5B7+GIxUuEvia2bo7f3audarxotX9YlkmdT2iqA4knJqZj2axmMehn22v5Up4KS61BZBV3PfM8sIzMFDpA37CI5h6EKGt71LKsvweqYtMIwl+ufxuApvyc0rXnStSBCiYm+swIck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F6v6IXy2; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6v6IXy2"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-88e51cf965dso468687285a.2
        for <linux-security-module@vger.kernel.org>; Mon, 10 Nov 2025 18:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762828495; x=1763433295; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=36ncl0PUcmfXo8Ga7gX6fzon1aa5NOwmeXnlIwgkJX0=;
        b=F6v6IXy2qLAntaPMTSBDELWgeeR0OIJyGu+bTHJVw3KSrZpZWno6Q/sQlfDV6/W9U1
         Fiq+nYdVArGVmNOiL9Dgm136uSSO4yGtKMibRLz9PtlTDWEN4LFVa21HSmq7doiKvKvE
         JV1K+CpqMD4PBOB87qb1NjmkGW9C7vg22ZFveH+MgTAc2WBV7McIKQAbJcw+RtEYCpzM
         5s3f4eIkgwlBme5h2qh8yzw9Q1y1ONPNdP2sIDq4gjIrMC8nJk4vnr1J8I+eB8zgNE8T
         +oyGvTnFJyXjF1y1pO9kBL3N1kWZ88RKu7BGfvdh57yiqH0vx9RG9U36KHjcaEQVJ+P1
         mGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762828495; x=1763433295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36ncl0PUcmfXo8Ga7gX6fzon1aa5NOwmeXnlIwgkJX0=;
        b=RLnHU5mLAbltjlaQxvYfkVUOwncIqZSg44JVniuWf5sdFtVs29sI39lBncOGyvAcLN
         nbvxid3LpzCvvxBHPQutgInjFYeoJ/6TAX6p9zvl7dcixYOvfWkqM0sgWCaQulQ75SvK
         iWy+ErJNcOsMc/KDLfBENz1UV4YtAUBjR2nWsZd9ThDVg3dmAF9n+hmCRwWLkDJr9ICb
         tjg4cUS6hzr8AsMw6O1jZX+1dgX+qyWuV3ogrfHsXLGOyg2egpK6HaFdgp4CdSVQoy78
         SiqZLfHqkDydvqtm3hVXyb4lK1LPta5SW6fKFP/GOaDAFr5LKjig5mIiCr+ruPMv8u+M
         XueA==
X-Forwarded-Encrypted: i=1; AJvYcCXGOPmP4whZuKPjYG8byrVlj6MDdFRpRyXDExqMPP+OU6sxO4BgAZJaEYzwbe7U3KZOPWMkv+L1Mjc2EiPNVXpuuJdLlgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTrt/k8Y87ySIy8Z4ReZjX/rqy9cPVgbLGTvArzU2ZxzUkVZjm
	NrL4gghlm4GcNapzN+u+TdxPNqlDw9vaGLBy2oIZtZMeyJic1rQF3Y2l
X-Gm-Gg: ASbGncsRA7U6lIYrOmpOtJOUkxL1OYXS1DoLTN12phZCDmk7WiPXy4C5w4WB9Gk7aYJ
	XvuzvwiZFAAtNIPexhFHbcVZBVBMzGZWinifNKgjhvq7Z4R/VikIJILdWMqimTyRymkhQgk3qbc
	DLzA+eQIlTANFDbsCkHMaOsutI6bKD3seHujodE/B9KBTKLfg6xKS0vFd6QUdeZLtvLkWGmdG6r
	+4LfAIqaLXrDzFELEaytklcTEwME8AKsePPcleONpbA3foPHM6Ty0aTjc6+qFU9w+nZOMzaZdAh
	4iTC6+NEvR8J+J+hDaF0ju4g6TyiilcYX5Y0Gf5PDw4V0rFl3QJx4O2XycXZTocD1kZSq4v3dWf
	Eja2gLRVv7n+PWD6GN2Ur2VsifrWMOihAXN1FJ5WQZHPeWwmZDsQBe5VZANmaUKLxquoywGcz6p
	N1zJTKs4tdjMo=
X-Google-Smtp-Source: AGHT+IGbk0YLpiY579gVpZiZCi3ixwsphSaTRqh2TflzCCa7sl2R7fDDID7LfBG+DM0e7yvO1fyTxw==
X-Received: by 2002:a05:620a:700b:b0:8b1:a624:17b1 with SMTP id af79cd13be357-8b257ef53femr1353533685a.27.1762828495281;
        Mon, 10 Nov 2025 18:34:55 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b262aa810asm556535685a.39.2025.11.10.18.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 18:34:54 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 5B906420A6B3; Tue, 11 Nov 2025 09:34:50 +0700 (WIB)
Date: Tue, 11 Nov 2025 09:34:50 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Security Module <linux-security-module@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Jarkko Sakkinen <jarkko@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>, Kees Cook <kees@kernel.org>,
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	Stuart Yoder <stuart.yoder@arm.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] security: sctp: Format type and permission checks tables
Message-ID: <aRKgyvrTxldlTv9t@archie.me>
References: <20251103113922.61232-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qvMASAdkqo7heMZ7"
Content-Disposition: inline
In-Reply-To: <20251103113922.61232-2-bagasdotme@gmail.com>


--qvMASAdkqo7heMZ7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Mon, Nov 03, 2025 at 06:39:23PM +0700, Bagas Sanjaya wrote:
> Use reST grid tables for both type and permission checks tables.

review ping

--qvMASAdkqo7heMZ7
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaRKgxQAKCRD2uYlJVVFO
o2LrAPwMHby35jPtxyGXpWYYSXXuCRk5uukKnesFG++5jEn9wwEArl/pKT9VjSes
nEPBegou4DPD34Ra21k7Rr1VjGy+mAM=
=pGcR
-----END PGP SIGNATURE-----

--qvMASAdkqo7heMZ7--
