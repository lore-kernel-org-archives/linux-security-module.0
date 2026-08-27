Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967FD47A0C4
	for <linux-security-module@vger.kernel.org>; Thu, 27 Aug 2026 16:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787848262; cv=none; b=XzC9vaSILkZZPwLWHiB1fW1bLSpVYmwayt46RlmraWbSDMB3PonQwguk5nGro5PJAycHrKxmexfWfnZ8sJXoHILF/YBkrIUlNgABISdy+QJpOEiIubAUh80behr8OMqY0QgXzlTG/y3enumvE1uDMsrZzEOGhRwYmaabxb7pUac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787848262; c=relaxed/simple;
	bh=1N6AHvApy7G/ZYAR4JX1g8TL5MbzzGoa4Zmf8cdN5Fw=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=OzHy+Agynrytd7AtgclXhj44VeolEYV7WaPe57OyamLkUcDmUyRBHQs8NwAuR553wRDRYrSYqyilfi1qSQ3EJbL9sW1FEyQPrWKWz2dXeZDXhsz9g85y2jUxZwGZ36BLwtvMqk6mqMIm6LFu5NW86EjGX2Hw/LWmXzMN/bu5PDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TN/Vs8mQ; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TN/Vs8mQ"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51c0ecfaee7so722441cf.0
        for <linux-security-module@vger.kernel.org>; Thu, 27 Aug 2026 09:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1787848259; x=1788453059; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1BQqLdPEbctnOJcoRx8H6SH9gQ3ki0NmAYqsyTGA1uQ=;
        b=TN/Vs8mQABhoGOODLWBZkAdSObKsGK1PV/vngn11f6ks3YEw/XRuTUQ4V5cPAZAJOq
         6E2Bu0uIjK7yRdKs3rtSontduc5RLW9bf0RVDN74T9Us8YP497InrvN5eUCX6wNdIgSU
         JTOG2LP3pSErBcZBL/r4X2x3yeeD6tNN7UFfaR/qZNEMFVUV0YuEty8Uz6o0CAGdUIuU
         Ohrqi2as1Dre7iPR6C7RDO2gmum8AHrqYNAkD9VTV9TOTRJKFopMKP8MAZPXIHu8PekK
         A/4CyvjkYeqCwdb2jdTNoSlcgNdPJoapAFCOTJND160TDFAzhdxnWILHy7klaGPDb0NK
         2VXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787848259; x=1788453059;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1BQqLdPEbctnOJcoRx8H6SH9gQ3ki0NmAYqsyTGA1uQ=;
        b=MUqOjHKNZlhs7vbeHaWQ/bSr9cTH5AVpRiCHBqBC/81J6s8aRxZ4EcwmMc/0z6+z7o
         LYzu+tAmO4WvbJvHzBAunwFSz08//aekQp64fde7DY1PPMLh4QX4Wm5O+cQ26nm4Kl38
         kUJNmPFPpSf1wI9vCuUyj/EjK6aL4g1z6uivIOz8KD1+cMruGyBWYQqHa17E9edN+LUO
         42ZJF6Z2/T4gkszbmBlajqgRr+uA57RNVZVwwIvzvH1zs1boRALzJHYhXQBrk0V/XhdR
         nmCUIYIgnBB49IjikNvQxdOWl0wpLLDc/x8Fy2bZrZW/TaId+v94G7FNF1/byrka/Cm3
         +nmw==
X-Gm-Message-State: AFuF++lNVBrqG6pbhYEegVxDRLk4Dy2k6nK6cEBtnDEMo0UF5rBDztcD
	HPOC9Go4tTq2CGUIb2Q+OrVyHuS2b6ALuWw4/pllHCciHPD5cauGv7PwEmTZNeNbuQ==
X-Gm-Gg: AR+sD10cnUr0DY0pMMyTqJZIhg0c3E6Ono6SiR57Ucgv1qTX6Ja8FHXfEW7gc2Te1oT
	YgQJxi+BaK6uTof7GPizIZ3SX3m2ml2VYhzsnVcjivYAY5XUtwfU+knt7A51UdhqGwh5VJneWJq
	IgZMWg+mjHMrKHp+rugNyt0Y99eAURsLj40r1qzfnh7/QMRmsTuhmdcfZ5ycePbnMx0pzH/92sD
	NRF9cfJXs4JWDdldlKn8CT3eaJbvkH7bs7lmYUvBUENKDsc9XLz0CCT6Lk/Y7h7WDIUzCgmzNPf
	FYLGRQGXeo173rBbsLQOhcEREFe4vORS0N8sGaIrZA95AzQBQnoVv7HHTXpFbISNZjLfUaMVVgR
	d/8MwEarM1EW803nTKWKWhuumVhzPuGH1SjUVsInh68Alilhmm/lX8jPLv1CprQdeY4BzVa7NsT
	6WGXKzn6woWZDVaiW7mdCdtCD15CgkGxrFwE8koRRTpATQ+ElqBSQ/Oq+ZuNv1Mu3Asizk4S1Zt
	1sPqk8sTUuZbz6ATNnM2RKKU/XT2qSPfwE=
X-Received: by 2002:a05:622a:1e05:b0:52d:6e05:88a5 with SMTP id d75a77b69052e-52fb93d2780mr3450571cf.5.1787848258523;
        Thu, 27 Aug 2026 09:30:58 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52e4270a950sm39982521cf.15.2026.08.27.09.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 09:30:57 -0700 (PDT)
Date: Thu, 27 Aug 2026 12:30:55 -0400
Message-ID: <e94ebd7547b7c28a7caaf6948d3d4953@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260827_1122/pstg-lib:20260826_1402/pstg-pwork:20260827_1122
From: Paul Moore <paul@paul-moore.com>
To: Cai Xinchen <caixinchen1@huawei.com>, <jmorris@namei.org>, <serge@hallyn.com>, <amir73il@gmail.com>, <brauner@kernel.org>, <caixinchen1@huawei.com>
Cc: <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <lujialin4@huawei.com>
Subject: Re: [PATCH v2 1/2] security: Delete dumplicate assignment
References: <20260707080615.1235830-2-caixinchen1@huawei.com>
In-Reply-To: <20260707080615.1235830-2-caixinchen1@huawei.com>

On Jul  7, 2026 Cai Xinchen <caixinchen1@huawei.com> wrote:
> 
> Delete a blobs variable with duplicate assignment.
> 
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>
> ---
>  security/lsm_init.c | 1 -
>  1 file changed, 1 deletion(-)

Merged into lsm/dev-staging and I'll plan to move it to lsm/dev once the
merge window closes, thanks!

--
paul-moore.com
