Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB299E6FE52
	for <linux-security-module@archiver.kernel.org>; Fri, 22 Sep 2023 15:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbjIVPu6 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 22 Sep 2023 11:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbjIVPu6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 22 Sep 2023 11:50:58 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EB21A2
        for <linux-security-module@vger.kernel.org>; Fri, 22 Sep 2023 08:50:51 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c0c6d4d650so20084775ad.0
        for <linux-security-module@vger.kernel.org>; Fri, 22 Sep 2023 08:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695397851; x=1696002651; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GCt9r9r6pcwQ01zw7eTpBXFaLocd8WZkRBmpguNZjpw=;
        b=Cj5ODQZ/tWB/NEAdGYKcW0UfAGaITK6r+OZ9NsIbxHKSKqJHA92gSoCiFepmnyBirg
         RBNL1EqdG4FRwtYRKAmOWwIDoRQzrmfBLEtmCwnfJxKDZM2959FzKmE7zQ+vhOVdi92q
         /+iSrZU4J2MsC0/HWmVl/TTqKag2lY2TNATZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695397851; x=1696002651;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GCt9r9r6pcwQ01zw7eTpBXFaLocd8WZkRBmpguNZjpw=;
        b=Jo6aBNnk88Vzx/cz7CPuenDkKl6z8xc4A72arjg4L0lRtzXqx7oeUNLf6By+XOYv//
         2ent0QUuYg5aTeVVztfHRXvLpjd+3/EDxeD1QIRXrrHH5o3HAgSzEiVjuuN27rA/W1yw
         8cvC0Kd4IidLeCjusKVA/A+SyMyDSzJWDSSjWdZXECQ+kc0UCe9It9QpTXpFf0YrBx2S
         lJVzsHNe67MnZQX4omU1l+MJoXnytLJzipSvBT26/NmObiW/jJRPfRBsWmZReDan2Zz6
         AvSHwwXVeOrmWaPq7EjhV73mdljZD7spuLiSR9i+vmoWMJpKe5nI70r+wrdlX6pIk5M2
         rbgQ==
X-Gm-Message-State: AOJu0Yx7pYG35AmW5b2YgNqT7Y3nAxrxyTHiI4Mc7CWAXDui++vLDxMO
        n655P5/k2v9MJd6xRRlHttpuJA==
X-Google-Smtp-Source: AGHT+IFIZUJW8EvIXtaqBAUAN/5h1sgrri6MO1ZH4F/4vvitQe+RxprVzaGqaaM4oqel58v0tuLLhA==
X-Received: by 2002:a17:902:ce81:b0:1c5:f0fd:51b5 with SMTP id f1-20020a170902ce8100b001c5f0fd51b5mr874407plg.40.1695397851168;
        Fri, 22 Sep 2023 08:50:51 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c3-20020a170902d90300b001bbfa86ca3bsm3640333plz.78.2023.09.22.08.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 08:50:50 -0700 (PDT)
Date:   Fri, 22 Sep 2023 08:50:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     KP Singh <kpsingh@kernel.org>
Cc:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        paul@paul-moore.com, casey@schaufler-ca.com, song@kernel.org,
        daniel@iogearbox.net, ast@kernel.org, renauld@google.com
Subject: Re: [PATCH v4 5/5] security: Add CONFIG_SECURITY_HOOK_LIKELY
Message-ID: <202309220850.E62D1EA217@keescook>
References: <20230922145505.4044003-1-kpsingh@kernel.org>
 <20230922145505.4044003-6-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922145505.4044003-6-kpsingh@kernel.org>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Sep 22, 2023 at 04:55:05PM +0200, KP Singh wrote:
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
> [...]
> Acked-by: Song Liu <song@kernel.org>
> Signed-off-by: KP Singh <kpsingh@kernel.org>

Looks great!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
