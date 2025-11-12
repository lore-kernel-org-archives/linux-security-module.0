Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4583A31281C
	for <linux-security-module@vger.kernel.org>; Wed, 12 Nov 2025 12:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762949249; cv=none; b=Nb+4goZBOvEuvnM3XlyHW3zcWZzob2ph6wqp5CQyTu6KH35eJ7Hv30+44c9XvLmlJQwkDQfSEMF9EH5ANsYdM1TJTdmXeXkyBfeOYL430J7j+1BWr9AOspauu2E4lN4sWgA9wL9+WWtgXF3Oo8e9DDwm0pyZsLnB9jdaVc48N4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762949249; c=relaxed/simple;
	bh=rmaw8uxqe2EYzaqnQYDzGZ3+OW1penkChF7AR/TE5b4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=to6P1llTilxekUYkaMz0UvWzAnMFJpv3JxJhbeIs1ncXMiMlLSfhNeGoHVoza09SLCb/2qYSq4lmFgl7sg6KjYp0wpaNSM+FQ6gTSJZny3xyOHuHmBJpQbpvD21QnkGTKjOPr0lMHjBaBwj3nXogf8puMI+SpCNCssHnUUgfimc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+MVu7u+; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+MVu7u+"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8a479c772cfso56160985a.0
        for <linux-security-module@vger.kernel.org>; Wed, 12 Nov 2025 04:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762949247; x=1763554047; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rmaw8uxqe2EYzaqnQYDzGZ3+OW1penkChF7AR/TE5b4=;
        b=T+MVu7u+UMAI2WUUFd26WraGC3lDj+PRQi2AtwiJHtXKAwu1kEpZPZSu6z+EUkqOs1
         qSaAIasPEs+R566KAGP8osjfuHmYYt1bFp/IwTD1kYnqZnTdQEbaByFBTqIwEX4BVCyN
         fAdbirMizZlUnAPug4aVfKiPvVbCFT2Vwhw/zGe2HruhjLiYyZuFk1em7/O77p8LwrEr
         rt7Y4Op7k026U3WWlZDyfwx7pq7N/c/Qt6tSRA0RR8TdtblGDTTZBzvmvcq4e2l3Txjc
         Cu2X7tTxYPXSYkPGbScgGBWsIikHWZtpo0Wd0jjjs3Cc9e2qrNl1yB6GwJjlGgt6hUsU
         pgVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762949247; x=1763554047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rmaw8uxqe2EYzaqnQYDzGZ3+OW1penkChF7AR/TE5b4=;
        b=rO9oYFlMgrfmBNQ6VkH4pWEXWJOyOcB8gCyOq/Y0CPgsGB9AQCsbwocbPtTOPBj6QP
         JlTMuB6W864q8fbfwGZMmf6gnXZnOJOrXlbxIzWYlnEW+Iz75+683T5FyxBltgkH83q1
         K55rkeGmsRrFbR34v0/UULFNyL2US7OTMw/G4WaqeJB97jhqr1bFfCYXzd5P+EhHeHIX
         FOHV8ANPPTEG2Gk+DkDEHGHA3qtD3hGcz57tDik7VCAvNkndaVv/hpngOWHPjKDGR5yy
         atfhBHIL2JA9Y7neXtZ3EPfwtO71QotCnm12kUn/BojDp4S1trwgP/i/GSQQqSPg17WS
         BpjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSmOaHIL/eqp+du/ogTxDZvi8osAzS0mZ0MBCI56UvtBbv/xW/u0hXZhUxdPuiBJfdNqtNuWlKvDvmNYc2Sb0rQI84Rrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHdbxxcrjvbqp7dCFdCESYgS2NC14kOOXvTsSXN4xVWFRY48K8
	+hOa0t/upR9qulWUSC5CjzZeFNndrmgSkMVHBp9FFoiENLgvwhAROWc8
X-Gm-Gg: ASbGncuDeVH6L3EruowI4xsq5PHgSr9UVSLfeS9GVN/rjoG69L7E+2v/ryD807+g1Y8
	ulwETkL5S7egJCVtgQJrHe9PbRv6lr5P61K41vioIbCo1O9j6m3OllaG5AxmiH9sWJiFmxs1Ji8
	DoREpg3TIrRWHqXOsXtXXtTunoRNTvfbtipI9/BZS499FyXqDzQ3+AYi6eYg9EYutYJkbb9VtAP
	F+1PO33Dpwp9afrJkDgpjCrHmwieiBHGezm+a/qc/+U9ZGq60wKMro2wVLC/z4INKXnLfL/7mhe
	jRBI78JBlDErIKLCAB18+AC+n/uNVC8ldZqbimpRrMEVBvf7RZiIgbnrw/oDNFB16bkNzjiNNfQ
	QsXB3guzKZSqf9Mwkr1Pcpi5ZkmR0TwpSzTUMP8K6fhidZuP6H/OXCX0rNn6mj0/jaNFyM6zWWF
	r/
X-Google-Smtp-Source: AGHT+IHodS+pTxbKK//f1GSMGDWXc+XiJHZj4dNVP6EykXSirX90SEf7NOQJlws/+WQMWWTXQYW47w==
X-Received: by 2002:a05:622a:19aa:b0:4ec:f403:3019 with SMTP id d75a77b69052e-4eddbc82c32mr34381541cf.21.1762949247017;
        Wed, 12 Nov 2025 04:07:27 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eda7116927sm80703501cf.13.2025.11.12.04.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 04:07:24 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 87BE14209E71; Wed, 12 Nov 2025 19:07:17 +0700 (WIB)
Date: Wed, 12 Nov 2025 19:07:17 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Security Module <linux-security-module@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>, Kees Cook <kees@kernel.org>,
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	Stuart Yoder <stuart.yoder@arm.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] security: sctp: Format type and permission checks tables
Message-ID: <aRR4daS-XsAFLkfe@archie.me>
References: <20251103113922.61232-2-bagasdotme@gmail.com>
 <aRKgyvrTxldlTv9t@archie.me>
 <CAHC9VhQeghqosexgOQO3==poNwsf_6mNiOqkUTUOdYnzRYzKmQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kaEZR4YZ+xgx6+Vu"
Content-Disposition: inline
In-Reply-To: <CAHC9VhQeghqosexgOQO3==poNwsf_6mNiOqkUTUOdYnzRYzKmQ@mail.gmail.com>


--kaEZR4YZ+xgx6+Vu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 07:50:56PM -0500, Paul Moore wrote:
> On Mon, Nov 10, 2025 at 9:35=E2=80=AFPM Bagas Sanjaya <bagasdotme@gmail.c=
om> wrote:
> >
> > On Mon, Nov 03, 2025 at 06:39:23PM +0700, Bagas Sanjaya wrote:
> > > Use reST grid tables for both type and permission checks tables.
> >
> > review ping
>=20
> You don't need to 'ping' for a review, your patch is in my review
> queue, but code changes take priority at this point in the dev cycle
> as I'm okay with merging documentation changes fairly late.

OK, thanks!

--=20
An old man doll... just what I always wanted! - Clara

--kaEZR4YZ+xgx6+Vu
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaRR4bgAKCRD2uYlJVVFO
o9V7AQDHOga8MTEGHoVGvfFH7x5J65YayPNmGzE8rkS1swU6tAD+PMbAFNdlVCkb
PuY83h41Kn/NdSbZDx6xQS5WY2RdmgY=
=fNJb
-----END PGP SIGNATURE-----

--kaEZR4YZ+xgx6+Vu--
