Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A795028DF27
	for <linux-security-module@vger.kernel.org>; Thu, 10 Jul 2025 21:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752184571; cv=none; b=o2a7C7EaikVc0ugMm2go7xMd8cfcl6vBSe3xkat2Mw35Q4oybezY2XjLpeRU0rkHCfW1oFRv9XHpO9si05gwKlcuRsCrswyg3xsZq/lHx9q/B76UBMdKZXeX7+G8cDaOQ94zToomi+yRQOmmDd8WcMMfF5s0IpOWSzBOuzRnDkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752184571; c=relaxed/simple;
	bh=yEUe36iGT2tjYBEroWVItA/U8MgbKRguqLFT0OU+jLo=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=tJGFdqpsJQ1ogDkyUB6BTE5rpCWbDmDhw2/AbyhtRO9F6oJHSs71ejW3P5y/jMqqtoHFRyLN171wZgJ5T885XtchWS7RCQ+8yE1YrqdqpKr7w+mQWmepGmtUsKgJXiZiJ6t9DQxXD74nvaFqnQGBdF04jrZ52Qk8fH7LBo4VXOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=AneX5pvc; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="AneX5pvc"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4a818ed5b51so11926901cf.1
        for <linux-security-module@vger.kernel.org>; Thu, 10 Jul 2025 14:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1752184568; x=1752789368; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yWbp11K8y8N54piZ0w9HEapGynmdQ61Of/cRxlwOOcw=;
        b=AneX5pvcDwhox3k3cfU2QySpiKm4c0b7zBygPtlf0O5EIRHmYDOKnxdVgfLbqQXE8s
         EJ444n5LJAAu3d6bBMgCFPso9AnU8+R/dmEc52Qyf3fiiNrCzjqoIZ3hjZufR//pq7qE
         Th6R2I+3rViKIq3gVsPWuAHlRYprf0CS52RhSLIijc27ExlRyaS2c9xBIw0TodX/N0HJ
         YjxNGAbvcuw58x/jcqcsJUFCNADYWrWHw82bSX1/Zq0x3IoTtJhgJ3PorpfAMsGFaDh6
         1ON0U4aBAof86ogjtcqzHck7s0/38FUNfoYCJu3ZY50qpDocns2oPNHTo03kLGvN/ZVU
         QGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752184568; x=1752789368;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yWbp11K8y8N54piZ0w9HEapGynmdQ61Of/cRxlwOOcw=;
        b=QtYqNoz70u5jnM3KAnzUUHfCLqA68w1twool7hpZ0NA4T4wBsDbV+6qbiaq9Zh5qM2
         BKVcQGbxkulOPjA+rRIYLzc77Zgi1NQauOxkFiEMmG0oVzHf/Ymodsh/ovm9thC8WUQd
         zIC6sZujZ9DY6yhYoGN6meQevSD4aGByawZ8alWebt9eOgz2NU7ro5uMtbZ1sJNunimR
         zu+m4WerzumPzSR+AZixfYfH2gIOyoUL49RyFC6Wm2dw2mrbBub9UJcllTiaXj9TyIhq
         XvyHhx9UIod9HOoFZUnni31EbmYQZQRYX/UuL5bNV5sxaZb3Qqkee0L9eOXfnHDR1ANY
         iODg==
X-Forwarded-Encrypted: i=1; AJvYcCUzjJd3o3obstxjey84crkhN77YGIctgfMjpuXJD+T3fXa1hu4pnXTKgfYdiOOweJ7QBkqO6ItgyLswmZHvm5oJgMl/VEE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb6OkvA8wBiV/TZZhuAHTtal8CRB8j4vgxe0OnIRjh+Q0T4qPe
	AxEkKkcf44txv6WmTxLxKDaNtoBjv2Yb4ZdWHiWDQq6rGdkD4+yCQAZupKDfBOe+xEyWb3tdEou
	Ob3o=
X-Gm-Gg: ASbGnctx0HqZYU6RKhGktJaFBrk9T6cbDFqHLOLp9IFtDqE0xaRcAGTRwQJeJ6cGKNQ
	7C+hmYpoFBFiNmb3kt3u4NkNJ4PGb8433DwbIOr4AqT5Gm5dwYYiPBwKRutrwOEi8YxCoJXAMgR
	ICLIFloviLiZWDf+Q1wSjIneXunT1abh63GV/ukrKk5jr8RgGT/IbBbk43HEWDj7vMjb4YxwvXP
	IEz59wVxQObcasVOzMfNmL+Y6iglMiSoeBGv85NXyD9nBCni1YBkmnxo2/jBhkc3av4Lqh+kOMO
	AAG8dvoPnDn2IjFHb76YJp3EEvgsKP0NRQz5zRUhnpYKaU8aVib7jFGwDeMyurETN+UF3kl/Dua
	XQMpjKVbzJq74HuYUHVnhr/hr6qvEwqg=
X-Google-Smtp-Source: AGHT+IEpnELhzqIjxusSklObVJoQn6zvdS6ZOqrP6ujD96X7xvUTFs2JekOXI6D29K/IxMigh4k6Mg==
X-Received: by 2002:ac8:7c48:0:b0:4a7:fbd0:79c4 with SMTP id d75a77b69052e-4aa35ca48dbmr4704511cf.11.1752184568511;
        Thu, 10 Jul 2025 14:56:08 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4a9ede764acsm13481451cf.38.2025.07.10.14.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 14:56:08 -0700 (PDT)
Date: Thu, 10 Jul 2025 17:56:07 -0400
Message-ID: <9076ab8364625a675e2c548adedeb854@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250710_1750/pstg-lib:20250710_1741/pstg-pwork:20250710_1750
From: Paul Moore <paul@paul-moore.com>
To: nicolas.bouchinet@oss.cyber.gouv.fr
Cc: Xiu Jianfeng <xiujianfeng@huawei.com>, =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
Subject: Re: [PATCH] MAINTAINERS: Add Xiu and myself as Lockdown maintainers
References: <20250624-add_myself_to_lockdown_maintainers-v1-1-bed2bc934666@ssi.gouv.fr>
In-Reply-To: <20250624-add_myself_to_lockdown_maintainers-v1-1-bed2bc934666@ssi.gouv.fr>

On Jun 24, 2025 nicolas.bouchinet@oss.cyber.gouv.fr wrote:
> 
> The Lockdown LSM has been unmaintained for some time now. It requires
> some work to ensure it works as intended.
> 
> Xiu Jianfeng and I volunteer to maintain the LSM.
> 
> Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> Acked-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  MAINTAINERS | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

It's been a couple of weeks now without any objections, so I'm merging
this into lsm/dev and will send this up to Linus during the next merge
window.  Once again, thank you both for volunteering to maintain
Lockdown.

There are a few more adinistrative things we need to do off-list, but
those are probably best deferred until this change lands in Linus' tree.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0c1d245bf7b84f8a78b811e0c9c5a3edc09edc22..776c7fffcaec08f71faf2740599f0b4570179832 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14060,8 +14060,10 @@ F:	Documentation/admin-guide/LSM/LoadPin.rst
>  F:	security/loadpin/
>  
>  LOCKDOWN SECURITY MODULE
> +M:	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
> +M:	Xiu Jianfeng <xiujianfeng@huawei.com>
>  L:	linux-security-module@vger.kernel.org
> -S:	Odd Fixes
> +S:	Maintained
>  T:	git https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
>  F:	security/lockdown/

--
paul-moore.com
