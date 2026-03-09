Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C59B33711D
	for <linux-security-module@vger.kernel.org>; Mon,  9 Mar 2026 12:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773058520; cv=none; b=JdFSF9qdwMarBvIdfF+qaL+B0pzOltx8442vcLASj1M6bmYsFowr8XhJ2KBO2LkzxXvGNPzMvydxm7+6InUCvEvkwpzxT3ALhH+2wat99rQkTtkX3KFGbpqjiUFCsVWZQJr5L+jePjWA+IMPceEmxD/ttwYhC0oHfEzgcBEBBN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773058520; c=relaxed/simple;
	bh=HPiSJ93sUzqz5SidOlMS933Yx3yWvCUQ5wbilVvU0I0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=luHelD5Ktm507OA1dS7oqTxLMRSlPlgtFy1Zb2Mp1U71DNnvMnq+N+lBXlxV5QGYDR21JtEbeK0PhmcmFLKkajtf9ZZgT5gX4GhA3qMn3lpOTabYqdO1uFs2eke13GNad6qIPCsQ6RuzhkyHYCU+XgYlVheWg1/f0azPy13RJjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VbpQ0agn; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbpQ0agn"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35994d84c6dso3226331a91.2
        for <linux-security-module@vger.kernel.org>; Mon, 09 Mar 2026 05:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773058519; x=1773663319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HPiSJ93sUzqz5SidOlMS933Yx3yWvCUQ5wbilVvU0I0=;
        b=VbpQ0agnypTOPPjI8m/21HBhHNH5aAc7ANzcsMeyyTush88NDbcEKIDU/0FNDrmpe2
         AKFJJIPXU4fyZtFDdF8bTYLCxjX1aOuVenPZRcUp2sjiUJF5NaOBayfLhruDiqVWKr4X
         3UblMgyuSQyfM/GkJaqo4Cs+4AHZ/lcpwpxJIv2Kaa7h+03sncESZSkM2HsRsKqlvbZ4
         tTGc0gsFE6YiZVYxmkP2kGFnsO4NfIhc1X0y06Th3ssZBxSIMeuN1pJyOm+t5Il5z0wr
         l/VhxyPwH3xy6Gu4Q6KAL7q8BevPFztCYMh7PILLF3ownniEyDtSwVFOwFrNXvOrM7UR
         ga2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773058519; x=1773663319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HPiSJ93sUzqz5SidOlMS933Yx3yWvCUQ5wbilVvU0I0=;
        b=BEbFVsh+NJT4epuOzexvXBUnacoNYTSWqU1998WvJM1FtyAlpobXXnXGXMwUOcvGkq
         MnkVZgJ1Pd+jCgcMwPSz8btv3J+ZY6vTG3d8GwFAHRxTVoefGl0rJmPM/2IAErP4wTAW
         RZtDA/1DLX0S8mHoYLoZGtwtl/S2E4w/ChNRLo76IqcsQLnpZNcicpYxmDR5d2EgQ1x2
         GJgHHWqXlHIYBz1Q5CfRrBabH2tNECilWH09qtSq8q9NSvhtVwx78eDUqt+/wApg98eh
         V/WmeGmL1pZxefoRZH0e/L2oPBwZXIYGx22xQm/hqn+A31Mrs6xLesBoyvSUsc6Em/91
         fryQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrZzgs6RmcSb8xnkAy6KIjgvn1q6p1LeSKoBToI01jfRqrWHRz0bW4DAllBrUrK8qzqguZy2Po4EBrBrbJyuGGsC8h3EQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWtNGCANJN0S6T8Vq+5OhCR3BI6Kw7xacXdW6U0QXkAe2/M8Gv
	9CKnaMzLgEgdI2OqJdBOaujSzQTX1w+ftJnN4X9nK5135S8KgK6f+NMA
X-Gm-Gg: ATEYQzzFwoKAJ3mkPLCnB60ZE4bvcpqaoM+wY6HXxIMDJb41SVNXpioS/DeLsGyMaby
	ITUUo7qYywGmlk0V0Et2cENUUcz7D2vTwXBj7CvvrCH2NWH100omfMKbItKqUoHKcgAz4WCbXTg
	sElK17dVTjJMW/CWUlY/RBBXO0uD+NxZZLd692KcrUb0VeANy9PbljShGJJAZbbLs1eRq6dPDFl
	3EbFFHC+Qy5B+pWuugH8b7vKQ9+/lX5mReljOjPuksHQUKnwLBfvsh2Si1Ox4cCKBPfhYpsYwMm
	Jdkt2dPaxwK5Ubuolt6Cj+OkfuJryOPqNaKWZmBaB5/UtMgONvQNIiSNndnmVBzwqd7Nw6+yGOR
	ssuoYlzFt1H4aBfkuapzflFYtLd8LbupITZ9c+VGmN1F+CzdCb6p4JAnCNx3x6LJXcF3jXNL0uE
	t++AAPF4PQ8zcW1YLcqxU=
X-Received: by 2002:a17:90b:4ac7:b0:359:7fe6:7de with SMTP id 98e67ed59e1d1-359be3736e7mr9726794a91.23.1773058514021;
        Mon, 09 Mar 2026 05:15:14 -0700 (PDT)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359c0154a09sm10902291a91.12.2026.03.09.05.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 05:15:12 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 3278B4208F41; Mon, 09 Mar 2026 19:15:09 +0700 (WIB)
Date: Mon, 9 Mar 2026 19:15:08 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Evan Ducas <evan.j.ducas@gmail.com>, wufan@kernel.org, corbet@lwn.net,
	skhan@linuxfoundation.org
Cc: rdunlap@infradead.org, linux-security-module@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: security: ipe: fix typos and grammar
Message-ID: <aa65zOqsFLKzgL1P@archie.me>
References: <20260308180734.5792-1-evan.j.ducas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WlQl3PTVy40ZKrDC"
Content-Disposition: inline
In-Reply-To: <20260308180734.5792-1-evan.j.ducas@gmail.com>


--WlQl3PTVy40ZKrDC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 08, 2026 at 02:07:34PM -0400, Evan Ducas wrote:
> Fix several spelling and grammar mistakes in the IPE
> documentation.

Acked-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--WlQl3PTVy40ZKrDC
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaa65xwAKCRD2uYlJVVFO
o/D6AQCQz/ijZESqN6jyW5u4EgkfCM8QCoDE3QAGxp1yQFRSDQD9H0AwrEQ/Omij
xMlXzOiUS1xLbjwmeV9LMLCBiJSd+wE=
=SsgC
-----END PGP SIGNATURE-----

--WlQl3PTVy40ZKrDC--
