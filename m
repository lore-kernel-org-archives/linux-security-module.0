Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951D8C04AA9
	for <linux-security-module@archiver.kernel.org>; Wed, 20 Sep 2023 15:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236432AbjITPpB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 20 Sep 2023 11:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234622AbjITPpA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 20 Sep 2023 11:45:00 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0697CAF
        for <linux-security-module@vger.kernel.org>; Wed, 20 Sep 2023 08:44:55 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c43166b7e5so50620495ad.3
        for <linux-security-module@vger.kernel.org>; Wed, 20 Sep 2023 08:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695224694; x=1695829494; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dQNo/7m+9++c/N59rrtD7EFgYIcDr9yhzLesZUcLlbI=;
        b=D7KSFNsgMgUF9jumnNwcCdCpkQtizbxnfZJUCkWtLEzsQkxe2zqNNvCiKKTDhwk2Ua
         DWNXbS5CUC68TG1vSgVtxqU2zC321cw3vRotW2zLlQC+jgXxRR3W3b1QZ/vfxqJ/Bnn+
         xgraNgUif/bLx1zNaka762rjME3UCz4PUPFw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695224694; x=1695829494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQNo/7m+9++c/N59rrtD7EFgYIcDr9yhzLesZUcLlbI=;
        b=dkYsOs6tVyhlQWPKYE/IRLzn7hOO4+Qn99/GRchSNybqbVRkOgmc5EWhDekheqDIMO
         i4pK/EjsIA7RcFdw0zpbO+TxVUdKqwnKdq4P6MiviRElbrGcXOq3iaaoHdpFCQHJk1pU
         jAAe2W3KKQrlyYCS7d8rmvZGyOGwi8uZMw0PDyntJJLo+IzDyVsCTV3bJMoIANzvZRsF
         FIhsEP+xPo1fjeOwSEFgxb1qvJlNGG3d1dfiZYNTEZReXgTusIaeiSnL2QCZyAxnZ+9J
         37LkAXPf4ZUmi9e1FlNtHW0krvZ0HbiJmb7D9b+8E9+sYCQrHe02Wd1beTiOqLt3U/yV
         X/Zg==
X-Gm-Message-State: AOJu0YxUT8EjZWMMtu/R0rJGnquy/STcvcAJFlLEt54LBqPhHbfEIqnz
        W0XsUohV+6aa3umQIgwSkiaoUw==
X-Google-Smtp-Source: AGHT+IHRAS+gnucMNkh5YLNn4zi1V35FmEsgOxnUBXnohSRpWJbdgtifaPuh8zXnvg0GrB8kYDJShA==
X-Received: by 2002:a17:902:d88e:b0:1c5:ae89:e1bc with SMTP id b14-20020a170902d88e00b001c5ae89e1bcmr2398804plz.65.1695224694423;
        Wed, 20 Sep 2023 08:44:54 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n6-20020a170902e54600b001b694140d96sm12044869plf.170.2023.09.20.08.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 08:44:53 -0700 (PDT)
Date:   Wed, 20 Sep 2023 08:44:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     KP Singh <kpsingh@kernel.org>
Cc:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        paul@paul-moore.com, casey@schaufler-ca.com, song@kernel.org,
        daniel@iogearbox.net, ast@kernel.org
Subject: Re: [PATCH v3 5/5] security: Add CONFIG_SECURITY_HOOK_LIKELY
Message-ID: <202309200840.722352CCB@keescook>
References: <20230918212459.1937798-1-kpsingh@kernel.org>
 <20230918212459.1937798-6-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918212459.1937798-6-kpsingh@kernel.org>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Sep 18, 2023 at 11:24:59PM +0200, KP Singh wrote:
> This config influences the nature of the static key that guards the
> static call for LSM hooks.
> 
> When enabled, it indicates that an LSM static call slot is more likely
> to be initialized. When disabled, it optimizes for the case when static
> call slot is more likely to be not initialized.
> 
> When a major LSM like (SELinux, AppArmor, Smack etc) is active on a
> system the system would benefit from enabling the config. However there
> are other cases which would benefit from the config being disabled
> (e.g. a system with a BPF LSM with no hooks enabled by default, or an
> LSM like loadpin / yama). Ultimately, there is no one-size fits all
> solution.
> 
> with CONFIG_SECURITY_HOOK_LIKELY enabled, the inactive /
> uninitialized case is penalized with a direct jmp (still better than
> an indirect jmp):
> [...]
> index 52c9af08ad35..bd2a0dff991a 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -32,6 +32,17 @@ config SECURITY
>  
>  	  If you are unsure how to answer this question, answer N.
>  
> +config SECURITY_HOOK_LIKELY
> +	bool "LSM hooks are likely to be initialized"
> +	depends on SECURITY
> +	default y
> +	help
> +	  This controls the behaviour of the static keys that guard LSM hooks.
> +	  If LSM hooks are likely to be initialized by LSMs, then one gets
> +	  better performance by enabling this option. However, if the system is
> +	  using an LSM where hooks are much likely to be disabled, one gets
> +	  better performance by disabling this config.

Since you described the situations where it's a net benefit, this could
be captured in the Kconfig too. How about this, which tracks the "major"
LSMs as in the DEFAULT_SECURITY choice:

	depends on SECURITY && EXPERT
	default BPF_LSM || SECURITY_SELINUX || SECURITY_SMACK || SECURITY_TOMOYO || SECURITY_APPARMOR


-- 
Kees Cook
