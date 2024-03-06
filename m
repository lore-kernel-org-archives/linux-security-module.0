Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F8D779FD
	for <linux-security-module@vger.kernel.org>; Wed,  6 Mar 2024 10:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709722647; cv=none; b=bVJsPF7Vo5U4vPdU1Ihyf158YlUbHVxyL5fzj3hxS9zpV/Raax04P+fJFnSr589/Xr18QXby+EXVxoXWUzW5T9d+do6w4VZpMaOOP4W1k7iFcOHF6o4k0U+2k9Slz+rIuQpC5k1SaguCQggSiFwOrdiKExYQlwaRJO4OCwy+Vx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709722647; c=relaxed/simple;
	bh=b4XyqL2PnC56hJ2b/S40mLdDbJwaGE9J/KbgoSiF4LY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ujenf7SHgUy/P5piDiiJokJjaF9QYGYXF6DOA+CCxSlEvpQyj/CZvo1MGA/sWPw4y/ZZfb1g/UuasxeYG4O8ZXZXGH+3LzhBzlK8XJ7YGPsodIGSjAYUJGgXE/1O/gvhew/c0rlu8lcNk8/Cd3InF9xChVSMDT5reU3J+UiDsFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZX/KZp6X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZX/KZp6X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709722644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b4XyqL2PnC56hJ2b/S40mLdDbJwaGE9J/KbgoSiF4LY=;
	b=ZX/KZp6Xj3JRp9bGKBNBl6CFElyG+zJd1CjWzRlNowBMHpFY6TGPIzQtOb8tNqrXDsEuIr
	0yFdnroyqUIixZV8Tpln/j9wpKliWMMzMDQoUPOapTYHQtNQpn4oN5L0wgtb1RBR/Jgy/b
	9P61hSyBKzec1Nxplo2Hs2zoP3b24l0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-w1wNBh4mOZicoIi8gA2CVw-1; Wed, 06 Mar 2024 05:57:21 -0500
X-MC-Unique: w1wNBh4mOZicoIi8gA2CVw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33d10bd57d7so801158f8f.3
        for <linux-security-module@vger.kernel.org>; Wed, 06 Mar 2024 02:57:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709722640; x=1710327440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4XyqL2PnC56hJ2b/S40mLdDbJwaGE9J/KbgoSiF4LY=;
        b=eUAYRG2zZOebkSc0J0/euPN4vfkztKhEQ7rYu5vi/y+Vwg5nkeCYmVyUXQjbGH6bH0
         y5UK2nCQsq6Gy5m9KAUTcXwTSwyu51pEevqQFpfBpZPoK2fkBqf8mujMmNPKYqBy1OPl
         8AanaI96uIeZhsIZZCRlgQyd4tUjGoiUP1rdlfDI/uyLxWwKRfv1rSRAEo4P9dF3/emz
         qGqv9ft+LnC2Ie7SXg2EZ5lquVEMQX1yujEnIPKgn0iBdCkMmb7mQvVf8WnM83p07iGH
         werD9eY2AMVNk4tlaOxuD4Vw7/Vu6NhAJ0iariA/ZxqPJ0QvYqol5la+lQfRcDL81A4O
         QpGw==
X-Forwarded-Encrypted: i=1; AJvYcCW0TRTtUwxSMnGYDmDqJ8k7DnMOyPBZhTJjBMt6eB5ZgbNOvU9TC0AqX0H0Op0s3AxtJGJJTEjM1haKfxb8tbetPiaZcy7UiB1z7LeV/rwAYnuyXkig
X-Gm-Message-State: AOJu0YyGUbYdOxXpUWh2qGosSEXjXwkGDIblCIOi8/QRjFmbeCrsagoZ
	gaD534U8jK++Ly4DXq2JihvWAt5RvDFANTAovfkr6Mskl7lqnVhjpfam+7nuTUvgncZUYiRQz9h
	uCNpf8PSOcXWIr/W+fjE20FKW66GhaCQzjEd3OZ6d3MOVVOiEwwgQK1l5NZiPoa5Uz4G+/QKAIw
	==
X-Received: by 2002:a5d:5f48:0:b0:33d:215a:1914 with SMTP id cm8-20020a5d5f48000000b0033d215a1914mr13001139wrb.38.1709722640457;
        Wed, 06 Mar 2024 02:57:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRZPOXIucKkLpt2y1Kl5ONuSx0wUfC6rVS8K/ER3pp2uiUyHn4H8Vrm+c3L1dNUe5NOyldIw==
X-Received: by 2002:a5d:5f48:0:b0:33d:215a:1914 with SMTP id cm8-20020a5d5f48000000b0033d215a1914mr13001113wrb.38.1709722639939;
        Wed, 06 Mar 2024 02:57:19 -0800 (PST)
Received: from localhost ([2a01:e0a:b25:f902::ff])
        by smtp.gmail.com with ESMTPSA id bx5-20020a5d5b05000000b0033e103eaf5bsm17353346wrb.115.2024.03.06.02.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 02:57:19 -0800 (PST)
Date: Wed, 6 Mar 2024 11:57:19 +0100
From: Maxime Ripard <mripard@redhat.com>
To: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Paul Moore <paul@paul-moore.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Coiby Xu <coxu@redhat.com>
Cc: linux-integrity@vger.kernel.org, itrymybest80@protonmail.com, 
	Eric Snowberg <eric.snowberg@oracle.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] integrity: eliminate unnecessary "Problem loading
 X.509 certificate" msg
Message-ID: <20240306-humongous-nuthatch-of-science-00e58b@houat>
References: <20231227044156.166009-1-coxu@redhat.com>
 <20240109002429.1129950-1-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xv7pnznz2fqkk5di"
Content-Disposition: inline
In-Reply-To: <20240109002429.1129950-1-coxu@redhat.com>


--xv7pnznz2fqkk5di
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dmitry, Eric, James, Mimi, Paul, Serge,

On Tue, Jan 09, 2024 at 08:24:28AM +0800, Coiby Xu wrote:
> Currently when the kernel fails to add a cert to the .machine keyring,
> it will throw an error immediately in the function integrity_add_key.
>=20
> Since the kernel will try adding to the .platform keyring next or throw
> an error (in the caller of integrity_add_key i.e. add_to_machine_keyring),
> so there is no need to throw an error immediately in integrity_add_key.
>=20
> Reported-by: itrymybest80@protonmail.com
> Closes: https://bugzilla.redhat.com/show_bug.cgi?id=3D2239331
> Fixes: d19967764ba8 ("integrity: Introduce a Linux keyring called machine=
")
> Reviewed-by: Eric Snowberg <eric.snowberg@oracle.com>
> Signed-off-by: Coiby Xu <coxu@redhat.com>

Any chance this patch can be merged? This is breaking (at least) Fedora
at the moment.

Thanks!
Maxime

--xv7pnznz2fqkk5di
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZehMDgAKCRDj7w1vZxhR
xRjcAQDO43bKYImGBD+B/EBUcAe1M2J0uqbm6+QesqiYtsPvGAD/fUFr3rDbhTvM
CAt76KLDM5Hbt0iKpgt0TgS06wTsLQQ=
=tyck
-----END PGP SIGNATURE-----

--xv7pnznz2fqkk5di--

