Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F4C227E83
	for <linux-security-module@vger.kernel.org>; Thu, 20 Nov 2025 01:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763602758; cv=none; b=UOBT3MQk35WLSaKKuTa4MMdQQ5pYBIHGslKFGOhU41QUzs0SP67kph7w9ifOpHj8utq4IRF+uB/PxpB2ucBGCEegvZbtIksGUDbEcpy9k2AHvf9YqREc0B4nJR1Zwku3p/pO7o5cV2RzZbCYvHlLRBdt/uf0Gd+4YBjkp0mRmVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763602758; c=relaxed/simple;
	bh=Dd+oYCoNpPVqRLegm/T2EqO+kP3OTwZSVHn0wUKym+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jSq4dV86U+KlyeaDE1E3kOmFhtMS24WISE7Y6IBxOcuz/6F7mANLrYj0ow3gdcajpe2UhB2A07bduRvXdnrGK1/7/hU3UXaQzTkS9H2+ptjczbEgShhWN4X8twFzKGMF24NcId+qE9yQEUVoQeHHNAk0M0eaNZGh29qZoGT43u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UjQ6vZAC; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UjQ6vZAC"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-297ef378069so3417715ad.3
        for <linux-security-module@vger.kernel.org>; Wed, 19 Nov 2025 17:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763602757; x=1764207557; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dd+oYCoNpPVqRLegm/T2EqO+kP3OTwZSVHn0wUKym+s=;
        b=UjQ6vZACQSa4i8ObmummS1XC6urON8aa5AddPVztIBD+NsclPjBQHVYhvTdfHOe93p
         rObUOhXUd/yiLy+kyam1iAfhIXLN5tIpRoEvJZnFZLuFDKXJ+X8Lrw+BcxXpqmDjLoSt
         uUqnz/L78KTQdzlXJSERfdRweMUrQIRUid+59hirZX588pxx+xZtXzA0Dvek3SlD/oIF
         3m88Dyn6/bJChBHR4FpQXOXpAuNZLjDZWeyhfHcqkKaIgvetws4+ZPgpiQo2m75s1bGu
         zqPwDby35+xGMJayFbq0SjOuVFY3bk9wyqnHt6kzbOuGowLz7+O0wVbfcE8u6VgYDmsH
         DDaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763602757; x=1764207557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dd+oYCoNpPVqRLegm/T2EqO+kP3OTwZSVHn0wUKym+s=;
        b=mvw56QdD9UWEz+MoMLeMohD0bGFgKZ000Kq/vWW3BI2iD3suSwyztl15fD1YITfK7y
         R+mJoF09HbiwUWqNIALdg7yNbuLoQCNSQUxGSpsqGHBryt5ro8hXU5++6oZym/eZkWW7
         3so7Xo6sY4mFtYU4J7VIGIEps6PG9kVkeBeP1FQklOKSEnsnYr/TXfTfvMfjv7qJSdI9
         eTdYqhYrV/PrkroCBDM6QxXUXZRW/8TMulIv0h+SSxF32xMcBaaCH4ZAbvAHAW4aEjAT
         CFL/rDOJdvpzDdBfOi4CXyE/BCuNO+WjJIQ0z6i6Yul2KGn1jKmZ5G5ntS+TzpC4keB0
         l3xA==
X-Forwarded-Encrypted: i=1; AJvYcCVvPHPfgq6hW9n3bhzkKJ8X68dp0JuoVgPTaKsf1CBumZu1mAFqHMUCs5tC3fomYF8kbp2jZqOeDt7bF7YlYsd4PehFly4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUBC6gZNRyG70B/jduAOFpmgVwtGvUsaBLjCexWPSZ/y0SgJKU
	Egu7+P7N2UqGfODHhKSPd6h3ydYK+0rnbj6eAxLOyuuQTuxjFbP7mvh8
X-Gm-Gg: ASbGnctOsiBdmqrLjbWvIwGbBgYLv8CohO5RKp7LzO3+8pWY4jWDfAllXTzciNBuncu
	1oEtJnDEWc9UUKJ3P3VrtFSWW/qpkZ1O1tdQJWNfervfPjip8DdPUfCLPYor978KU6R/WDE+4wa
	sqG6e+9tGl0vNKv2osyMMeXfWyAPgoayBp3ZjerXpFNy/gLNjslMOubOlqwbVTY7K9C8Bm/DrMq
	rDyretmUZ3OykLnt4dca7r9Fjx9kQUQLiSRhv6dE7saRJ2w8jwph9dGfMvRI+iNEVd10BTScAEE
	YpeYDsvQcyJcL42N5I8LOZ6lqJBwSR7NPyx+VJ0Vc6hjbxkXAnbhI8UaKBFXYz+mrCnHaEfWxxW
	LN0KHlLWKiMUB/1sKSiTxYOm7obLdhjlZApJaIsC3C2mzXqg38O47LikgTVn+cmY+3SGMAzOJ2f
	1O8uOklRmgfuboJFu8F3//AQ==
X-Google-Smtp-Source: AGHT+IFzPepFO8+6WktR0iMdc7Km/cWXFw1wrHBNUJBW6cjwzPTXcCih+h4/2LHYE11DndYuW9VcSA==
X-Received: by 2002:a17:903:183:b0:295:8dbb:b3cd with SMTP id d9443c01a7336-29b5b08d6dfmr16925365ad.27.1763602756517;
        Wed, 19 Nov 2025 17:39:16 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b2b82a5sm7171265ad.97.2025.11.19.17.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 17:39:15 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id D4A3C41117C4; Thu, 20 Nov 2025 08:39:08 +0700 (WIB)
Date: Thu, 20 Nov 2025 08:39:08 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Paul Moore <paul@paul-moore.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Security Module <linux-security-module@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Jarkko Sakkinen <jarkko@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>, Kees Cook <kees@kernel.org>,
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	Stuart Yoder <stuart.yoder@arm.com>
Subject: Re: [PATCH] security: sctp: Format type and permission checks tables
Message-ID: <aR5xPJEiqyE0HHL8@archie.me>
References: <20251103113922.61232-2-bagasdotme@gmail.com>
 <d5efca7df0d2e12ad9d6f3d35afa2828@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UWjdjlnL/fJW9B81"
Content-Disposition: inline
In-Reply-To: <d5efca7df0d2e12ad9d6f3d35afa2828@paul-moore.com>


--UWjdjlnL/fJW9B81
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 07:10:31PM -0500, Paul Moore wrote:
> I rendered the patched file to HTML, and given that large portions of
> the file are still rendered as monospaced preformatted text, the new
> table rendering looks a bit out of place.
>=20
> Let's stick with the existing table format until the entire document
> is converted to something that is at least as constitent and
> aesthetically pleasing as the current revision.

OK, thanks!

--=20
An old man doll... just what I always wanted! - Clara

--UWjdjlnL/fJW9B81
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaR5xNAAKCRD2uYlJVVFO
o+P2AP9xfIKlhl2FqVJ5HkygiJ6f4Fc9WTDEhr8DjcPe7uodsgEA4Qvh1NLz3P2H
4gxCnsF8uOShQicH0Pfbh98nbaBE6g0=
=/3zw
-----END PGP SIGNATURE-----

--UWjdjlnL/fJW9B81--
