Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3BA198A08
	for <linux-security-module@vger.kernel.org>; Thu, 19 Dec 2024 20:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734641146; cv=none; b=IMy7Vmd0iqYq2wrVqcyELaEYhJODP4kEW56UruBqXBCoTovmZukrbeJ52otAtfznXDNIcACWMb45mJV/bBYhaeEU6REAW5ncH+Z363OXJzJxQ/Tzu9o0UozRqqpBXT7vsJxPh7caST3NLTFmqiOBLC58NvYiggo/wo6lmZxYW9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734641146; c=relaxed/simple;
	bh=EXHvnoGK4LzozmsS1APMYygdmEh4PtL1Gw6DZu1bVxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jY5eBxWIdJAqLKEbdH3AIXVvrWLy4ZhiIkREDx83zYXfoX+DUzfb6oMcm8h6txDgxus62EuuV5GZOTOM++CJezuBD/CnImez1P255I4799vWdWYawMRLEUNvP26Qh2R92w3iit6ziYnGKIfGvG8EcZov2++mNv7OpXlV+HwTetc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=herbTaDF; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="herbTaDF"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-844d67eb693so91916539f.3
        for <linux-security-module@vger.kernel.org>; Thu, 19 Dec 2024 12:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734641143; x=1735245943; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wRdYDdHbyZXzcPCpB7wABkwUTOuxolmnucq278Cp6Tc=;
        b=herbTaDFSF+fLrp05YktrbfUY99QMKq8ATHfKlZqAq9rNjJC6BuvR9+L1FOH8l0nX9
         z8CiZ7DHm4LFa1zTg2fUicA2f95uM9Pv72Tryk5Zn8BNAKyAe1sjtfOzlNOGh8bsrc77
         uDC7Rf5Mkm6ms5EM9lAL801GogxvJslyw12f3cr1VZjvHteMZhyIvpa1i5B12AuL19Ok
         9lbnT/GgMZOjJnffCpiP30vcfD0hG81C1BWFxZCXmaKWSXzjYrsX8cDexB6/BSssFy5t
         GxC8dnyn2B+bSoGOlEN+f5q9tJVqQDn/l8PGOPRJv7IEqH5hZaIzsafLk4Dz30DClD6r
         dE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734641143; x=1735245943;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wRdYDdHbyZXzcPCpB7wABkwUTOuxolmnucq278Cp6Tc=;
        b=Enne3RVqTXrDnHWtu5yYbkxErN6MnB3hBQRoi1aw9fDP6eg2/WpqeBbkRNAvaiFRu5
         OTnFGiMAyq23QQtTYl5eyZy603DpbJ9CRFWFEoIIs4C8WJ9Kv/y+/Kt5kDM1V9ZhPR+4
         eybCd+XFtUYB2gj/oDXqQVyPIEA+948C3lR3Cp4chQY1bEidxJK2pvajw9K6kdvwbzRp
         yobarQiXEbAv+w0r51JEYglSP2pMqsoNbQiENe/hDBfdPe4H3YQhA5N5ykO8QFsapyyd
         B97emJVuxXxZnKUqSQG8/+CoRTv/ZI0kC8nh5k3KffDqBBRap/twBZeK05SQZBw2+JCU
         dDHA==
X-Forwarded-Encrypted: i=1; AJvYcCV2A3JI+raYb3P1lWas6aZR4nMvgLvDq1R1ySx43V+rOTu3xHOTSDJGMvKJIUG8igp+czhrC/L+T7H1trHjPItAaAKCrYw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfu29Th6fCIn+bRlcqo81HtaAj7fYoY8GvHL0FuFK0/LvZa1sC
	2Vw0Du9Is3Gx+3XcnBGvkSA5yvFtuGIkBU8lNA5tFfugUgKrLSFSM0ODNr9bq4Q=
X-Gm-Gg: ASbGnctAYi1WPHuXracSrHLHB/bl5xAGtHk9n3iK+jj4KX0GxcGSMrY7jGwk15Y4pt6
	i8wh+Uke4XfyhLAr65DVQtE0rNZyT55Q47I8aW4L0D6HCMdvfROH8dSQUnerj7Vzhhytdu6Oadx
	0NYKeS8SYfAWtQiIpGnrHjOj4AvvuxVHC21UDgjk6BfH7XLxI+Dzm6YbiSmT3WlHc+7lG400C0h
	evf44xMgLuyLkgRyu/1qUJuUrtMDNg8vLmU6t9tvnk6K31MdZuI
X-Google-Smtp-Source: AGHT+IFxSutrUvWsiAV11hP3721+cW/ZW7QVXOWP5b/gzeaAb8Kzg89614qhyJXX7v9wmOje6hR6ow==
X-Received: by 2002:a05:6e02:19cc:b0:3a7:6e97:9877 with SMTP id e9e14a558f8ab-3c2d5a27dd7mr5124115ab.24.1734641143213;
        Thu, 19 Dec 2024 12:45:43 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e68bf7ed01sm457933173.66.2024.12.19.12.45.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 12:45:42 -0800 (PST)
Message-ID: <f72a3036-fe4f-4a94-963a-b994d946d5af@kernel.dk>
Date: Thu, 19 Dec 2024 13:45:41 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lsm,io_uring: add LSM hooks for io_uring_setup()
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
 linux-security-module@vger.kernel.org, io-uring@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>, Pavel Begunkov
 <asml.silence@gmail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>,
 Ondrej Mosnacek <omosnace@redhat.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?=
 <tweek@google.com>, Masahiro Yamada <masahiroy@kernel.org>,
 =?UTF-8?Q?Bram_Bonn=C3=A9?= <brambonne@google.com>,
 linux-kernel@vger.kernel.org, selinux@vger.kernel.org
References: <20241219204143.74736-1-hamzamahfooz@linux.microsoft.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241219204143.74736-1-hamzamahfooz@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/19/24 1:41 PM, Hamza Mahfooz wrote:
> diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
> index 06ff41484e29..0922bb0724c0 100644
> --- a/io_uring/io_uring.c
> +++ b/io_uring/io_uring.c
> @@ -3806,29 +3806,36 @@ static long io_uring_setup(u32 entries, struct io_uring_params __user *params)
>  	return io_uring_create(entries, &p, params);
>  }
>  
> -static inline bool io_uring_allowed(void)
> +static inline int io_uring_allowed(void)
>  {
>  	int disabled = READ_ONCE(sysctl_io_uring_disabled);
>  	kgid_t io_uring_group;
>  
>  	if (disabled == 2)
> -		return false;
> +		return -EPERM;
>  
>  	if (disabled == 0 || capable(CAP_SYS_ADMIN))
> -		return true;
> +		goto allowed_lsm;
>  
>  	io_uring_group = make_kgid(&init_user_ns, sysctl_io_uring_group);
>  	if (!gid_valid(io_uring_group))
> -		return false;
> +		return -EPERM;
> +
> +	if (!in_group_p(io_uring_group))
> +		return -EPERM;
>  
> -	return in_group_p(io_uring_group);
> +allowed_lsm:
> +	return security_uring_allowed();
>  }
>  
>  SYSCALL_DEFINE2(io_uring_setup, u32, entries,
>  		struct io_uring_params __user *, params)
>  {
> -	if (!io_uring_allowed())
> -		return -EPERM;
> +	int ret;
> +
> +	ret = io_uring_allowed();
> +	if (ret)
> +		return ret;
>  
>  	return io_uring_setup(entries, params);
>  }

Please do a prep patch that makes io_uring_allowed() return the actual
error rather than true/false, then the rest of your patch can stand
alone.

-- 
Jens Axboe
