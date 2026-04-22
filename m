Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39137371D05
	for <linux-security-module@vger.kernel.org>; Wed, 22 Apr 2026 21:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776894676; cv=none; b=fq1OWhs8cfYDcVoqfW6O3V9+kOAZZhlVoLc+5U1tcoU+7ClEJlv97/mFLL4byQQcASOqTXfPz+kahQQ66IVdcB81kMtLvFBgjIuWY51+ZMLnLm0BGYoOmanIxzVQSqtaG6+rwYu6nKVuCNS2DO2GKzss312HofGR34d7Ui4nM28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776894676; c=relaxed/simple;
	bh=Y7Mge9b13Svxhx8TJEk6lCMvUzQkVEYyshKzVnitd/I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fM8K5me6PUTZUeBy9mloMJ73x6jEnOqgcPpJ/+WYzUSUtiWapGnA1DgrzzeOOWewT6+Cg0aNvp/ssVdov/BK5yk76Ekq9tu293+57bDVDmImE9b56a5/ULsJP0fQghHCHov9Tz5mziGnNygCmo0Z446tiHHP4H6IJCgpKfH4yFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=dqx0d0eM; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="dqx0d0eM"
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BCB4E3F61A
	for <linux-security-module@vger.kernel.org>; Wed, 22 Apr 2026 21:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1776894671;
	bh=6VLo/yUVeRMGUhJnZEuYHpDbSPtBEUiWsLgK1CGuy4E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version;
	b=dqx0d0eMcZBH1jCgrF5lya5tOtA3m/dUvnsrugO52AAXLMQEnOXnntMymD27nYf3t
	 mhiMGDwqM0BYnaKpKoY/z8/QspDU8nDNtJO0Msaf7JBl0vTs7DDMtIaFSxhzLV5BwT
	 yWtTEcPhbfxvZpU7xMrjCIgkBvYpGV7ZGHu1Eco0zltZSLsAuzCPCC9x9HwKhi2gt2
	 qolLlnfnAWDyHNCGyWtKQd4FT6X/JQNB2P02mO463oK5t+PXTvkKlaRtdev4KgTMp1
	 /NCO/P6Li3sXAZ0clOwM6INrLetuZ/Xy2p+XlMGi18Ihff5fKTsRBP5au1oQbxT9Fa
	 A1zGxUUuA15jMMptVrD18fBcSbSrNccFUfEyNqsT/x7+8O2O0LRs0fz//7nAY7fi/q
	 vi7Ttz6kpjcXj8W2luzFoaoN6gm2+L3aXaiyfJUeOEcrIdOd1Z7PdciqgYm8oKTQ+Q
	 bkMtKPlo2hL7EJtaJghSinTv96WIaglaao6ASn/knI1uCKLQ8+rPZ3T0yuHwD7kpW5
	 xM7qN8GrCzWY6GJaWmXh97CeLEum06Amx3LnxwXpNZ77fa6Ej5JYcZohXStJY3+weQ
	 yD31v4Q0SEwFgq+lh85MGqD5FMDKrwPdAcz7znvqiGLiETlUVdH71LDF1WG6cWJObd
	 ShqwpbggLz5Wcg078Q5fl4x0=
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-5fc74c6634aso4752931137.3
        for <linux-security-module@vger.kernel.org>; Wed, 22 Apr 2026 14:51:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776894670; x=1777499470;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6VLo/yUVeRMGUhJnZEuYHpDbSPtBEUiWsLgK1CGuy4E=;
        b=cYk7BaGsqfbc72hAhorYv8QKpnC5cxld+H1MJqrqwhDjugrSLLaPNl37O6iCnxy/12
         XsuWw882vjKkVTUVfHQGyguWXFo+u0XNyL2COKM6ByyAHwWsL/JJxAO7gP09kx9kJCZ5
         1JZfEPCMQU9Pfiyw8rSQZE1sq9tLxlqCGLNQ1jjTyZUeZQ780b46nusUKZuU0QsnAE4j
         cdC6i6UwJ8qlzhpBzaIQRyUXWYQzz/mpCwc58p0+FUaugi5Mn2Di0ZBzWBC+LfesHy+g
         jJK1SDFzEdQdEGXYC9yyMXuo9oEYEqdvcJ6TWkcqtajCHJbB11pIK5aQ569CA64trGhB
         2HOg==
X-Forwarded-Encrypted: i=1; AFNElJ+OfoEuN6l3IDeTsSeudzfyi5ddVp3BwzpRNdj9RQZTq682pH/QnaQxEqMVvwYbbg2rmBWR8yTprZC1rOVJJx9zKR9vGTA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8+wXA/14O4QkpoalenKeuEabPAys8KGN4V0RSx6sgr1DW4fNj
	feX+uCWK6nNij8ClJShAi4o3NLN7cKKJVBXQlCLtgkNkFXlFUS/A/NUddIId5Y073x06gK/1/bz
	e7VFdMgcMUdjIyfTd1ohHlY1jMXeariscoZUyyIPI3ZAoKLsnjWffkEXmKu8ImWcOT6AiOuCPD5
	N1UJeDnZrk+KHYi+arag==
X-Gm-Gg: AeBDievPJ/8xE+UTWsKEYk6VFT+fw+xt0g9GvtLXDoffOZa+oskdhfLpDWG6/W/dInS
	1QW2akjI5oqCzk4TBYC92mNJRBDPNq7WvPDeLtKatOR0xgaS1vCe3KHHV2CtSR5jJvSkDvhHK4v
	V+15OK9ZBX0PGrX2HdxsHXGsYPbmiVJwNdSEEPPDgaBArOQ24l2opfNxZE7dLTbZzG+hqg6srIR
	QDkprChIVqZkpr18EbS0bp85ROHII5IVMEfT9PKViCJF2UbkE6RoMcPnBsfTx1N0Q3QSJ5rH15r
	x5+NaEFetUWKo/YznCxRI6oZ5cmEQTuQV5GzA12NA6qzEc5DyEbaYupvQXK5k+pINh2erb30CT0
	8lHAbj80zEP9ecoZ+yBJIzystENA6VmmcBP48U5axKU+siKdfCv7XcegVqcvUNKafPUxZqN5wCK
	EtHbf1
X-Received: by 2002:a05:6102:41ab:b0:608:706b:dc5f with SMTP id ada2fe7eead31-616f71f0b71mr12058837137.23.1776894670644;
        Wed, 22 Apr 2026 14:51:10 -0700 (PDT)
X-Received: by 2002:a05:6102:41ab:b0:608:706b:dc5f with SMTP id ada2fe7eead31-616f71f0b71mr12058831137.23.1776894670293;
        Wed, 22 Apr 2026 14:51:10 -0700 (PDT)
Received: from [192.168.0.106] ([187.95.109.208])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-95890937db2sm8334640241.2.2026.04.22.14.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 14:51:09 -0700 (PDT)
Message-ID: <1b87ab3652ca165364e1bb86623f2b26a135dae7.camel@canonical.com>
Subject: Re: [PATCH] apparmor: Fix two bugs of aa_setup_dfa_engine's fail
 handling
From: Georgia Garcia <georgia.garcia@canonical.com>
To: GONG Ruiqi <gongruiqi1@huawei.com>, John Johansen
 <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, James
 Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>
Cc: apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lujialin4@huawei.com
Date: Wed, 22 Apr 2026 18:51:05 -0300
In-Reply-To: <20260403035119.2132418-1-gongruiqi1@huawei.com>
References: <20260403035119.2132418-1-gongruiqi1@huawei.com>
Organization: Canonical
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello,

On Fri, 2026-04-03 at 11:51 +0800, GONG Ruiqi wrote:
> First, aa_dfa_unpack returns ERR_PTR not NULL when it fails, but
> aa_put_dfa only checks NULL for its input, which would cause invalid
> memory access in aa_put_dfa. Set nulldfa to NULL explicitly to fix that.
>=20
> Second, aa_put_pdb calls aa_pdb_free_kref -> aa_free_pdb -> aa_put_dfa,
> i.e.  it will free nullpdb->dfa. But there's another aa_put_dfa(nulldfa)
> after aa_put_pdb(nullpdb), which would cause double free. Remove that
> redundant aa_put_dfa to fix that.
>=20
> Fixes: 98b824ff8984 ("apparmor: refcount the pdb")
> Signed-off-by: GONG Ruiqi <gongruiqi1@huawei.com>
> ---
>  security/apparmor/lsm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index c1d42fc72fdb..be82ec1b9fd9 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -2465,6 +2465,7 @@ static int __init aa_setup_dfa_engine(void)
>  			    TO_ACCEPT2_FLAG(YYTD_DATA32));
>  	if (IS_ERR(nulldfa)) {
>  		error =3D PTR_ERR(nulldfa);
> +		nulldfa =3D NULL;
>  		goto fail;
>  	}
>  	nullpdb->dfa =3D aa_get_dfa(nulldfa);
> @@ -2486,7 +2487,6 @@ static int __init aa_setup_dfa_engine(void)
> =20
>  fail:
>  	aa_put_pdb(nullpdb);
> -	aa_put_dfa(nulldfa);

This isn't right. aa_dfa_unpack does kref_init(&dfa->count), and later
we have nullpdb->dfa =3D aa_get_dfa(nulldfa);
So the second is put on aa_put_pdb but the first, from the init, does
need to be put too.

>  	nullpdb =3D NULL;
>  	nulldfa =3D NULL;
>  	stacksplitdfa =3D NULL;

