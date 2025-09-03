Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDA92868AF
	for <linux-security-module@vger.kernel.org>; Wed,  3 Sep 2025 08:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756889309; cv=none; b=AyZCXx6QCBRd3TjwGnh5EF8O7TkcN7B1F4Bl6Kg6nSgP/R6yVm0PoJioWuFTyvbAakRDs/9IwJZNkL9pSZn6A/KP6VAK+U92yp7Gd6gLITjU9ecu+jw/D//XSaIOFqIMNSpw84bJjjVlGZBoyqVo5DL72+nOCrzUEi0xIVPMDzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756889309; c=relaxed/simple;
	bh=y9ZYSUEhCgsCJs3MwjoxmJGXrLDrMvHRP13qwAwxu/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cbl197Zb+p0JVvnYcNrAwGf+oC7LqBoH66DmI6u/ZaamNrBchelmVN+1CDxK3A4279+ZU35akJiv5lb4b610hTVoMsPR10rkB5bLgbng/qP0fgGvSeFDPh7aRr6DzbWQpV111DQlhSiQdWeci4YWHkJlCDPxsaw/TshkyW9buww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=JK0C1X4y; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="JK0C1X4y"
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E6E0B3F57D
	for <linux-security-module@vger.kernel.org>; Wed,  3 Sep 2025 08:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1756889304;
	bh=ffOZA5hnHgybhwTy/ph2Q460TcUr010LL7KmyqTh0ro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=JK0C1X4yHunLbl9CGcpHk8bIJKx8hNH3pY9cFf5+octVhZSbmKZxRwJ7mNmeoQuVf
	 x74b2x0eMtrI0B0nUIWvN6ZYqpzkBT9Cwg/mQjbXIQ7DkGp4/1xx2ukW5wOg7xEVke
	 SAnvyT8yufrGwcfaXhpSgCDw6kqNpPBN9fjmz35CCMpF6aCCk5saO6QtbQqqTE4A5l
	 d+0/ODtSPp/+OH+FdGcY7cewuXyPsHUFZFu//an2A8tWitoIgDnIBgz1jeghXnxXAp
	 1vflQ5NXGvW2UHsqpfIalm1OQcfjKmYXsH2fRn95feD+ckXRnXVil3eQCk7J8j4tzN
	 3pVx2xb1sSHbA==
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32b698861d8so289990a91.2
        for <linux-security-module@vger.kernel.org>; Wed, 03 Sep 2025 01:48:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756889303; x=1757494103;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ffOZA5hnHgybhwTy/ph2Q460TcUr010LL7KmyqTh0ro=;
        b=Iispu+ysAQut2K5Bo2pHLW8Nhe2rArI6BlPFu9Nq6OB+Y7pjouWYo/M0xiKiMjbZX2
         x6YAUn1L0otcotFe2liBAoXkr8dWL1GtsZNEY382KarU4gKmmaUHxJ61AgdMMV9HAl5i
         SxSGnjAiptsb7c90YQmBIeNUy6vOsZ+jOWt0TDWO9gY+2t8ai/j5yyKvEonIAZk4fZs4
         bbaG82xb2e2XjkI9xzrWk3cHy0/Srx2jJATvq0OARZd4NzOXKcHejQVSJxJN68wM1o4j
         mdm7pnzfVHrroDFdRVw7/ErCWtv1dq3iNRPGIBPgvd5Oa4CrO+1XaN5k5z4eswmgfZK8
         1DWw==
X-Forwarded-Encrypted: i=1; AJvYcCV+tFcnw/YMCd2GjP5wE5uwbjO9gTrA+MsQXY+ovXV4F5hCvvEER1GCZG4V+N7Z63OrQaojE/nqBnZM1kE+5WKjb5BRmls=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtEKPi4rU8S1Mhrki+2a7KjwvEgQDaw2o0+wzla/V7TNgzAFPK
	vt0M6zdNdIkziHwdfan0hA0W+S5miAm+dz4GcU65rENYY2VO2+EHH/V9TTRsFOgpGGHX66G5sC8
	56SDt46EjHVsmSPfzWIPdj3pLr5aIDA5tcNAHfKxoHWy+IbNJX+eFjdAiZJ8DSTuRkRfRmBx5oE
	QAYOtWcslMqM6QbU+OLA==
X-Gm-Gg: ASbGnctHYGmqIzrUjwGEU0uMSPP4KTOT8c1kJw9EsO9LF2bSP+BP5ASgy4pMXmSx/bu
	Bqg/S7xLVu4rESjnfDGmYpyN+O5bOz33YJpXkIhrlD+PirkShlGImYs7Ayy8mZl93yDoqGK17VO
	zFH1b6As9oAkuFIxSguATikaZjN1E/uOt80AEmLi2+52NVDD5k7b7cABV/IOariHJP5XJ6sB5Eo
	V1AC5au0iTK7BPB7NT/RnAjbCjIBdcSvip0jOThXnU9anwHkoZBz22vtXJCssJbCMmvUpa+d7DN
	ERze9p1illkmI0z49YQTY8m5EzMNckSylKYQYvLxPCva/sXRD/mezg==
X-Received: by 2002:a17:90a:d408:b0:329:ca48:70b0 with SMTP id 98e67ed59e1d1-329ca487480mr8579838a91.34.1756889303237;
        Wed, 03 Sep 2025 01:48:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETN1qvfRt9Y3d3UzU/fKb/YpD4Cp2ZijD2fStapzs597LcKIRDuItaN79/2XYzzasAA6LXkA==
X-Received: by 2002:a17:90a:d408:b0:329:ca48:70b0 with SMTP id 98e67ed59e1d1-329ca487480mr8579807a91.34.1756889302811;
        Wed, 03 Sep 2025 01:48:22 -0700 (PDT)
Received: from [192.168.192.85] ([50.47.129.42])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-329f633749bsm3523330a91.27.2025.09.03.01.48.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 01:48:22 -0700 (PDT)
Message-ID: <12483ddf-db29-4e43-a870-cfd77b01de97@canonical.com>
Date: Wed, 3 Sep 2025 01:48:21 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/34] lsm: add/tweak function header comment blocks in
 lsm_init.c
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu
 <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>,
 Casey Schaufler <casey@schaufler-ca.com>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
 Xiu Jianfeng <xiujianfeng@huawei.com>
References: <20250814225159.275901-36-paul@paul-moore.com>
 <20250814225159.275901-55-paul@paul-moore.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20250814225159.275901-55-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/25 15:50, Paul Moore wrote:
> Add function header comments for lsm_static_call_init() and
> early_security_init(), tweak the existing comment block for
> security_add_hooks().
> 
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: John Johansen <john.johansen@canonical.com>

> ---
>   security/lsm_init.c | 17 ++++++++++++-----
>   1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index f87f5441617b..37593805ba9e 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -315,6 +315,10 @@ static void __init lsm_order_parse(const char *list, const char *src)
>   	}
>   }
>   
> +/**
> + * lsm_static_call_init - Initialize a LSM's static calls
> + * @hl: LSM hook list
> + */
>   static void __init lsm_static_call_init(struct security_hook_list *hl)
>   {
>   	struct lsm_static_call *scall = hl->scalls;
> @@ -335,12 +339,12 @@ static void __init lsm_static_call_init(struct security_hook_list *hl)
>   }
>   
>   /**
> - * security_add_hooks - Add a modules hooks to the hook lists.
> - * @hooks: the hooks to add
> - * @count: the number of hooks to add
> - * @lsmid: the identification information for the security module
> + * security_add_hooks - Add a LSM's hooks to the LSM framework's hook lists
> + * @hooks: LSM hooks to add
> + * @count: number of hooks to add
> + * @lsmid: identification information for the LSM
>    *
> - * Each LSM has to register its hooks with the infrastructure.
> + * Each LSM has to register its hooks with the LSM framework.
>    */
>   void __init security_add_hooks(struct security_hook_list *hooks, int count,
>   			       const struct lsm_id *lsmid)
> @@ -353,6 +357,9 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
>   	}
>   }
>   
> +/**
> + * early_security_init - Initialize the early LSMs
> + */
>   int __init early_security_init(void)
>   {
>   	struct lsm_info *lsm;

