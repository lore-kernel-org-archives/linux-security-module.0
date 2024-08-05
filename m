Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7519D166F3B
	for <linux-security-module@vger.kernel.org>; Mon,  5 Aug 2024 19:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722887883; cv=none; b=rDXvsNKzqOsKsevaSeyknPH/nBvYDsQiWnDGInWysSSUgbQEJIVK9eXP47z3lrp9xDmBRellCAlYQegNDvmxNoKw7JztNrsVjulpo1QQgHLuiUqdts6bn1otw+7cpGhSrRqqAfXTOsRQB57rtkAIAoxbzzv2Avmok/voWmdz1gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722887883; c=relaxed/simple;
	bh=rxeLc0f8DRhPsmh0FjjZBjED0NX11DTdFc6s6f4LPcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pGf6ooRCJZxqlsi7bc4YJ8jHSvfVd7AkZ9HJMcXfOVzAE4dxYzNu1LZ05MPn90Y7n8JADftvT0XpjkbGEkVFrMNlrUF+bZSTRgeJFVXC5ZGPokQi8SDEjBSEP4UvtYcanCb6YCiHvxDQcP9CmRbHe36eZUt8VQXB1Eltmgb+87g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=DD+k/WVY; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="DD+k/WVY"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e02c4983bfaso9614797276.2
        for <linux-security-module@vger.kernel.org>; Mon, 05 Aug 2024 12:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1722887880; x=1723492680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UPPnAP7qxMYZ1TKRWZYPmOYj/E8z7mPvmJgbldEEpHs=;
        b=DD+k/WVYhaPVH6nzw7yZ71iNnISojbXnK81DAfHwDCforJH51cQlzhfHOZNsKK/CjN
         3N/zRIvqXqM7S0kPAGXxYnzygainD+JbcLj+277t6SyFq/xLJhPkCj8QgRwIYufJrNr0
         StHAUREUL7KfZLBM6Oz6JF0sL1qHqspPorYRHhIXhbHt8W+8ZyxgdGx3ng27gZ0EimyY
         LNFopB8Jkoujt5iJBp/Ui4t99kSpYax+PXfgz0v5BhVMl80OhvEqr4jotQ6TZSR3G5MD
         /VE0saSEKp+T7+MRuK7Isleg/NR5EBnxga23qduHr6xufEf/wY2UKbIkQj1CQpVB+ekA
         ezow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722887880; x=1723492680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UPPnAP7qxMYZ1TKRWZYPmOYj/E8z7mPvmJgbldEEpHs=;
        b=s8OWkPR0/b82IbqCo4RjaOcnEYBoMQAYzMt0umeQjtTaQRXAVs1RRIEbr6C5hrbLtf
         fhP0ZyS6WCZYywVGllOsfB+bzW4nstj5gEncXb03sG+azzqtMTdbnpKkCOUTpdnYfrtq
         n1VNQrMNSrD4slEPttbiCnITAu1ZhsDiljPOOO2yVw9nImeZfgv6Tx08wxHD8no7DMGZ
         PH4EF44pw3ijYSvDfZleenU5abamVfh5qCLkoBrpvmDGvMmjjGYDja2F7JDI0TX6+sav
         COTxKKuXz8ZgPYQQthH5zQx+C4I+Yg1Tejb+iZaWsGO1BXNOMrRuO6H15d6MFjqr3NPU
         FuAg==
X-Forwarded-Encrypted: i=1; AJvYcCVQaAG0txDkK3luPsJ/jaTAgUuuDSiV+FZCzAfM6KLcTxHa7u5Wg3YHB0Tx4u02gZfZV0I5+eNtfsVFXfCvdnTu+OfUuSH8q0GnONOi+Ohum2YBX6hu
X-Gm-Message-State: AOJu0Yz06OYPox2s7Z103bKQBTHNT+xIDPf7fsvesFjCjkCToOPncY7r
	wFcorwIQoC0OowtWZarRuX/s+o8nmrruNiwwL6D3rnV7fNEXa9unsrLJMbKp4X5r7dmu/VNDQjW
	zzcHR8Fy2BirfzJC0/V8zw6zdZ1+YpcXFQ/Zb+BVG+I3Ks+s=
X-Google-Smtp-Source: AGHT+IGa9SUejtgqxNEB5F9IenJObH511HYzk082Jg1xU2pMV2j06uhI6f3vEg6NNtPmhDJjw6qggd3g7GrSoM6h15c=
X-Received: by 2002:a05:6902:725:b0:e0e:65e4:b7ef with SMTP id
 3f1490d57ef6-e0e65e4ba58mr2206966276.51.1722887880428; Mon, 05 Aug 2024
 12:58:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801171747.3155893-1-kpsingh@kernel.org>
In-Reply-To: <20240801171747.3155893-1-kpsingh@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 5 Aug 2024 15:57:49 -0400
Message-ID: <CAHC9VhRO-weTJPGcrkgntFLG3RPRCUvHh9m+uduDN+q4hzyhGg@mail.gmail.com>
Subject: Re: [PATCH] init/main.c: Initialize early LSMs after arch code
To: KP Singh <kpsingh@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	bp@alien8.de, sfr@canb.auug.org.au, peterz@infradead.org, nathan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 1:17=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote:
>
> With LSMs using static calls, early_lsm_init needs to wait for setup_arch
> for architecture specific functionality which includes jump tables and
> static calls to be initialized.
>
> This only affects "early LSMs" i.e. only lockdown when
> CONFIG_SECURITY_LOCKDOWN_LSM_EARLY is set.
>
> Fixes: 2732ad5ecd5b ("lsm: replace indirect LSM hook calls with static ca=
lls")
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
>  init/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Considering the problems we've had, I'd like to hear more about how
you've tested this and I'd like to see some reviews/ACKs from some
arch people too.

> diff --git a/init/main.c b/init/main.c
> index 206acdde51f5..a0e3f3c720e6 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -922,8 +922,8 @@ void start_kernel(void)
>         boot_cpu_init();
>         page_address_init();
>         pr_notice("%s", linux_banner);
> -       early_security_init();
>         setup_arch(&command_line);
> +       early_security_init();
>         setup_boot_config();
>         setup_command_line(command_line);
>         setup_nr_cpu_ids();
> --
> 2.46.0.rc2.264.g509ed76dc8-goog

--=20
paul-moore.com
