Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E14F1E519
	for <linux-security-module@vger.kernel.org>; Wed,  6 Mar 2024 12:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709728808; cv=none; b=rGa+FmCtsSUci550arubr7SjlrymwZHo0dAWL8U5DfQXbkmgvs6AcBePFZh5yk3Tsg/uI8si1nIzPjsSf3yRWCDYp9KxJA7TGwNCBTVkDbs22COzA6sWWCqdYw1U0nNzwJJMjp7b61Eu/s2CG3A8No19D8UWW1gFwi551QxZSFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709728808; c=relaxed/simple;
	bh=s0RgG9vqq135wgTU/3tFpTGeNbkjasrCrM+BcD67+KA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AgoR3xgsvcrJuOlmAwyHTaiyg3HKClHIUqZUHNIGKSduLtxWJRmS4liXTz6VBNZYGi5Ni9oj5Ilyxt59qosqx9QrgOHm+6ZL2KizgKhwqKUDGjtsJtTtHEhv2r5OqtgZbB2CuYHiqeAgpacwJ62FtrBdpO55oUyBuECVlslS6Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aJXYphWX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aJXYphWX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709728806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s0RgG9vqq135wgTU/3tFpTGeNbkjasrCrM+BcD67+KA=;
	b=aJXYphWXfop9UiGl+p0OdRwmjxcbNa/fukz84U12GR9uskK61buoEseqGbiZU1kA0Pddn9
	S1mfc/p9EW6n0tsBBvwabz01yi25Ib8NzBh+PkkOgrll1PWTdRRSYwn8sB6W4RZEPp5vFO
	bUfgRxsyUIRqNY5+LGgdA36Au4Pj0yE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-lhMcu8LUMFOeUgdDbchU2g-1; Wed, 06 Mar 2024 07:40:04 -0500
X-MC-Unique: lhMcu8LUMFOeUgdDbchU2g-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33d8d208be9so4230600f8f.2
        for <linux-security-module@vger.kernel.org>; Wed, 06 Mar 2024 04:40:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709728803; x=1710333603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s0RgG9vqq135wgTU/3tFpTGeNbkjasrCrM+BcD67+KA=;
        b=q7WoepZWlTDt8O/LNPERuyJY7WZl+qKLetxdrPqY5CdopDMEPzRoshK1ll8EU0+TJ6
         3LJ2uMBGcCEAJY87lwOwRsBrOvg8nDkrr6AJvPBSdnHmQPYmOjRr8Hk41lqjnxIfbbl7
         oSHmdTQvcU/P6khKlcfu/yHXvlZrvcbZs0EZm4+XMq5grT5esDRIpBFOshx/l4vbK6Cm
         W0iiN2Q1rWSHKLk4JNutNpjvLIDBecfVBzufnhBn8pX+es4USl+HLqBYaU1rVGTTPq10
         laIB7azYX9WpDfWUttKryynJyNl+CbEO71wJcOf99sF0hBhXaeV6250uJEYwQzylaG3S
         ETaQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8JncC38N2LKki1y1guLjNh3yTuIqPJS4P1tFl132qFd++wkijaazbx5ffymEcA+30jhotu2YTUfHr2JVUC4whZeD07hYWA0Ve+t02vIg8ChiYCKuV
X-Gm-Message-State: AOJu0YxiEk9yN+eVw/emszxcAoQikCJ2n6tR9SoNGkOc032JeGSm8EJJ
	omsTEzQaLVLOIAxyqAeFtLzzf98BRPh5Kz6yjalbUo6lx4qXi+7E6L/ps4ZvGgAX6OWQM9uTK6t
	IpS2GR6jT6FA+wjQUb3vLpcSwX54v5LTKx9nO42tAYCvF7ZF9UDo0Tzzk6HfIKGowFzxXhXG9iQ
	==
X-Received: by 2002:a5d:4dc3:0:b0:33e:1a96:2be7 with SMTP id f3-20020a5d4dc3000000b0033e1a962be7mr10229338wru.11.1709728803297;
        Wed, 06 Mar 2024 04:40:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+IGBdm6R5QstlgXd6ZKEAdg48EKt2mibrn0E+a72ARgbuLLefhc1N0Jrjhjq8vX7cVKF5Nw==
X-Received: by 2002:a5d:4dc3:0:b0:33e:1a96:2be7 with SMTP id f3-20020a5d4dc3000000b0033e1a962be7mr10229315wru.11.1709728802693;
        Wed, 06 Mar 2024 04:40:02 -0800 (PST)
Received: from localhost ([2a01:e0a:b25:f902::ff])
        by smtp.gmail.com with ESMTPSA id bt12-20020a056000080c00b0033e3a110d7fsm9196110wrb.71.2024.03.06.04.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 04:40:02 -0800 (PST)
Date: Wed, 6 Mar 2024 13:40:01 +0100
From: Maxime Ripard <mripard@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Coiby Xu <coxu@redhat.com>, linux-integrity@vger.kernel.org, 
	itrymybest80@protonmail.com, Eric Snowberg <eric.snowberg@oracle.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] integrity: eliminate unnecessary "Problem loading
 X.509 certificate" msg
Message-ID: <20240306-large-lush-catfish-e75cb2@houat>
References: <20231227044156.166009-1-coxu@redhat.com>
 <20240109002429.1129950-1-coxu@redhat.com>
 <20240306-humongous-nuthatch-of-science-00e58b@houat>
 <a677a9cd8eda40e5529094ba2a6ad2f7c0c927fa.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2lpkp2cicuwnndoz"
Content-Disposition: inline
In-Reply-To: <a677a9cd8eda40e5529094ba2a6ad2f7c0c927fa.camel@linux.ibm.com>


--2lpkp2cicuwnndoz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2024 at 06:55:00AM -0500, Mimi Zohar wrote:
> On Wed, 2024-03-06 at 11:57 +0100, Maxime Ripard wrote:
> > Hi Dmitry, Eric, James, Mimi, Paul, Serge,
> >=20
> > On Tue, Jan 09, 2024 at 08:24:28AM +0800, Coiby Xu wrote:
> > > Currently when the kernel fails to add a cert to the .machine keyring,
> > > it will throw an error immediately in the function integrity_add_key.
> > >=20
> > > Since the kernel will try adding to the .platform keyring next or thr=
ow
> > > an error (in the caller of integrity_add_key i.e. add_to_machine_keyr=
ing),
> > > so there is no need to throw an error immediately in integrity_add_ke=
y.
> > >=20
> > > Reported-by: itrymybest80@protonmail.com
> > > Closes: https://bugzilla.redhat.com/show_bug.cgi?id=3D2239331
> > > Fixes: d19967764ba8 ("integrity: Introduce a Linux keyring called mac=
hine")
> > > Reviewed-by: Eric Snowberg <eric.snowberg@oracle.com>
> > > Signed-off-by: Coiby Xu <coxu@redhat.com>
> >=20
> > Any chance this patch can be merged? This is breaking (at least) Fedora
> > at the moment.
>=20
> https://git.kernel.org/torvalds/c/29cd507cbec282e13dcf8f38072a100af96b2bb7

Oh, awesome, we missed it.

Thanks!
Maxime

--2lpkp2cicuwnndoz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZehkIQAKCRDj7w1vZxhR
xY7WAQCnEqMeBo12XOqakTVapFgeJkCAw0LKLelyqoAfjYH10wEAna6Y24H2p/uZ
IHeuKetyVMuIur4tt+g9va7Xh70iYAk=
=yOKe
-----END PGP SIGNATURE-----

--2lpkp2cicuwnndoz--

