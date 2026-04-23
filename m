Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DC53ECBFB
	for <linux-security-module@vger.kernel.org>; Thu, 23 Apr 2026 12:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776947136; cv=none; b=TmYkg2scOuaKk2Ae/LMHD8W3fbguVNTs+1Fet9Mcgi8i8AVnuAGA4g7Vim1GTK9w/Kq0B5lS0yjBVtqz9Ik2DHgwdrkqcywij1nrpXtZOdL9zWjOLnC33B59XgV7ah5JBU558mQVUUxRYUY9MafbtSVVFtt0nnWnkLj0E2s77Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776947136; c=relaxed/simple;
	bh=4PiMwKbGqc68zTiZ+OmL03wP5AWBpSr38ZAoA7Ui1Mo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UEKn4gHzfebCesZIxXiNE9IJuld/OqPsJQiQtMw3/wEvfvmw42J3g/Y3WPYbB5oT6Ut/2n2fPXiOVYmlYxt1moMvvuLIH4afZXsWlwHCDG/XnTxq/cAbbpEQ2Hqa6igjFmcMrq/6qIn0w1OBpJHAVfroRULH8YN3eCiyJlzHXSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=QJOhHHRa; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="QJOhHHRa"
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5F82C3F212
	for <linux-security-module@vger.kernel.org>; Thu, 23 Apr 2026 12:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1776947131;
	bh=NkPqKO7ZmpqAAc7Ac7xNIDTe0L1sSM5Ly9dix8xV50o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version;
	b=QJOhHHRaq2HkEz846RzCjirWDgeDg3PjJS+hPrTMjy1zks4W+QQbwDta59Dhc3ytv
	 9vn1dZmV87EV3+0yy59E51aMkF1nxsG0kIBOD2hlppzG+Vy2sasminP+2C22gML6YN
	 +f1JCCc8PMo+0A/WnEcK9ohNWh/7S0V4fnPyIM5OsCOGGwdno4r1TDJWQHzK1/gRYb
	 ZEvhtuvfuUeQNDkWvMh4b2c9SWFV5qE5OTJy+yZAS4UnhbbSlAEdsy76UgqxSSrl1P
	 x66zymw8SwEFzaOGforbt7/GL2hs9PhZaiwL2OV7uZi2zNNKG5q2VRC+Z7FBKNRRI/
	 fTG/MMujPXaIg3XMTsOU3si+y421Jp+Ok9saBzAOhrEkWZpUE26/tmQU4ScLkGMO3h
	 ZPR0iZkURuOgaDmsAB/sEtiIzIhSmsQUVGf4xPKvT4oe0YSPNdHUppCYZSMLp4VN9N
	 29EI0mQprc7/7rt782WlZS1odi+xKKHqIQlrxNBQdnQuHIvcT0+/c8oFqDGR7z5Rau
	 5N9KYU2HoO1vc/M6cN8SBmVX+5ocOZhuGk2/zd357WmUhwfSn2vEwHgv2uoK09o4RX
	 xK9um48cuzxfhS/0vUPYfKJb+2kYYeBcrPZUv6ANyqqYd6sRXMYKDA+YUuACWH+GY+
	 Q+KX4YpWzZX/Ua6gam1I07cw=
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-56fb91588deso3598897e0c.0
        for <linux-security-module@vger.kernel.org>; Thu, 23 Apr 2026 05:25:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776947130; x=1777551930;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NkPqKO7ZmpqAAc7Ac7xNIDTe0L1sSM5Ly9dix8xV50o=;
        b=UaQ4YbErkNg4Q5bKg5WKS6abTtQWzRV31MfUGvygCTtCkqjmRCjLS3Zh5Kp6pNwOSQ
         LtrmDRTjHRUvcXAW94EhfNwrZMd2fWLwpKyVo1h3t8f6U7xX3g1s+XgdlIonJvSr8uQw
         19G69oPhn0aWzjxT2J++Yvghdu/n/B2Ptk98Cf3udOaxGY0qjty27WGK7wivXGdUGHN7
         fNONSdTt8t3bdMCp0vtUEFYcfrfUDdMW9le+2TkMc5TZLc0pvaZ2gaQ6MYL0TqczJxpt
         8KRnjVPW7fhQfChNpKWJ+nvBgpU1eSMM67OAPLsL9dsJlFAE8zdTWXPpanbAADXTjXpi
         Mw+Q==
X-Forwarded-Encrypted: i=1; AFNElJ91qclgerCEOSNZyE35Idz0/nwIF4ZA+5Wxfo1FFGdWNeYZSKsYsUWNHEjoHqL/DXFor1i4AzItQtdNrven99zwdJMrezg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7XATSeSzblwHhugatM938AQgkyAe5bge//mCbM8glmbRu+T9Z
	BJl3YseOVYIHdy0LnB2JjjRQEwVxQOfP2fIs4+/5H+cG7OQTFpNVBqXQd6PI3EEjWosb8zup9M5
	nVfj2qHyca5gOlgDqbrwI/PAXOVpdlsMzNUZtW9sE/Mx9IvHvuxvgX9uKmS7q5JzX7ccUb1SdQl
	03o9s1YtXau968BG82Dw==
X-Gm-Gg: AeBDiesY1ltWqJq6Ia/RUKnLUbAT+BYPDMkY+CLFyUTBJ2Y1Xt/9UP+6Slkfw3U3zct
	pJ6acearoa5+qQ4qH2+kTNo01YB4+cFoOXWV6jJQFiPIJnyd/kBzA9BSFrjMT/kmE3yFkPDd2zi
	4H+tRmHNPnWxKXBHhHGmEIwn3CjGHTMVY5y3cQ/ABTwqrEyzgUOI7LsuAXHAjVjzwo3ScOOFH1o
	BxFvMz8k39fQ+1YavUpr3O8Op21A4kWPbSKMY9L4IvRR6rTTFOxueqV933LtXHKkpT/zufH8rv+
	WnFEsT4kxZfuXZilv9aTASrLIhtkkRvSSDIW+CaAAPXqmLJuX14ufp7ZbA+WHu8wz6A+Biz4nmT
	WGavFSoa5qGnzJCjsbCCws+out886IgFmbtg5cKSv4crSgus2VQnVxQEDPTO+gKjsuLxew8qOr6
	4cCroQ
X-Received: by 2002:a05:6122:2087:b0:56f:2aaa:450c with SMTP id 71dfb90a1353d-56fa57a56e7mr13477202e0c.1.1776947130416;
        Thu, 23 Apr 2026 05:25:30 -0700 (PDT)
X-Received: by 2002:a05:6122:2087:b0:56f:2aaa:450c with SMTP id 71dfb90a1353d-56fa57a56e7mr13477194e0c.1.1776947130033;
        Thu, 23 Apr 2026 05:25:30 -0700 (PDT)
Received: from [192.168.0.106] ([187.95.109.208])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56fa91ea606sm11459481e0c.5.2026.04.23.05.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 05:25:29 -0700 (PDT)
Message-ID: <7861e5cac7997776abf068836e649efb0460db3c.camel@canonical.com>
Subject: Re: [PATCH] apparmor/lsm: Fix aa_dfa_unpack's error handling in
 aa_setup_dfa_engine
From: Georgia Garcia <georgia.garcia@canonical.com>
To: GONG Ruiqi <gongruiqi1@huawei.com>, John Johansen
 <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, James
 Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>
Cc: apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lujialin4@huawei.com, zhaoyipeng5@huawei.com
Date: Thu, 23 Apr 2026 09:25:23 -0300
In-Reply-To: <20260423031056.563527-1-gongruiqi1@huawei.com>
References: <20260423031056.563527-1-gongruiqi1@huawei.com>
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

On Thu, 2026-04-23 at 11:10 +0800, GONG Ruiqi wrote:
> aa_dfa_unpack returns ERR_PTR not NULL when it fails, but aa_put_dfa
> only checks NULL for its input, which would cause invalid memory access
> in aa_put_dfa. Set nulldfa to NULL explicitly to fix that.
>=20

Thank you!

Acked-by: Georgia Garcia <georgia.garcia@canonical.com>

> Fixes: 98b824ff8984 ("apparmor: refcount the pdb")
> Signed-off-by: GONG Ruiqi <gongruiqi1@huawei.com>
> ---
>  security/apparmor/lsm.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index c1d42fc72fdb..ead2f07982b6 100644
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

