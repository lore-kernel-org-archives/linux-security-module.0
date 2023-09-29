Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477E0E743D0
	for <linux-security-module@archiver.kernel.org>; Fri, 29 Sep 2023 00:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjI2AhK (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 28 Sep 2023 20:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbjI2AhI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 28 Sep 2023 20:37:08 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D9A1A3
        for <linux-security-module@vger.kernel.org>; Thu, 28 Sep 2023 17:37:04 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1e10ba12fd3so546217fac.1
        for <linux-security-module@vger.kernel.org>; Thu, 28 Sep 2023 17:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695947824; x=1696552624; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4+nBnzcJJ7xEy+h+rie43j8O0Ss49rlif7Rw69Zqx9E=;
        b=Yew1IOK8SankL2LehubJpai1i7dER+tJuegS1CVW5AyzR84KBrUF3+FM1eewNT6wNY
         l8DNQ7OSUQlZVbeTCn+Klo7p3fifcLFNbqPPQ3s5q1dhXSChM2x74OElGBLyuy1Y6/LO
         ltEReAOOptlhz/lrVkaEYN4POW8qw6Vl4ZDy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695947824; x=1696552624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4+nBnzcJJ7xEy+h+rie43j8O0Ss49rlif7Rw69Zqx9E=;
        b=hFWWAcDGCRGWmRFi4uJdFVHCVyY/AIKEKsJ2eTKbSCZiy8LwNjqwYPfCHuNIFF3DVU
         yovR5Bb+qr0nfZAnNWXVNjFgia173Ta1ZP2ASuETuZsvJnS4T+//No+lQtprBekJynKy
         QX/65E5gZiccLSlJHI6O3oGJyzlAmV0sSuZwBm228qeNPD3Ez0iVu/J1wm9PUVHMNppN
         5UmlWqE6b/yfYXuZBX3cKiul6YTR8jFBMNsLsWkcMxQzzqW89E3NlpSH6bJNIqOaMgnW
         BYC2ifBp0X/KULllYSIWBmJLKqMjurY/JTT3M3adP7apDGG62zwMp0DLHx79NcehoLNd
         c+fg==
X-Gm-Message-State: AOJu0YyLf/R6P5Iene01MLfUm7ZSEcdotWBl0fM74AYeW2e8yukEbRir
        69/5pVQQWqUyEY9m7BQWuUv+Gg==
X-Google-Smtp-Source: AGHT+IHqoAYcIt2C+tgcA8ZtaPigw4o8v2oIltMhYNCuA6I66P8BF8ERIzHBkEh5TvogpttCseMOkg==
X-Received: by 2002:a05:6870:9720:b0:1d5:c134:cecb with SMTP id n32-20020a056870972000b001d5c134cecbmr3043273oaq.1.1695947823867;
        Thu, 28 Sep 2023 17:37:03 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o17-20020a639211000000b00578d0d6e8desm13542196pgd.9.2023.09.28.17.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 17:37:03 -0700 (PDT)
Date:   Thu, 28 Sep 2023 17:37:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     KP Singh <kpsingh@kernel.org>
Cc:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        paul@paul-moore.com, casey@schaufler-ca.com, song@kernel.org,
        daniel@iogearbox.net, ast@kernel.org, renauld@google.com,
        Kui-Feng Lee <sinquersw@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH v5 2/5] security: Count the LSMs enabled at compile time
Message-ID: <202309281736.4E7D88678@keescook>
References: <20230928202410.3765062-1-kpsingh@kernel.org>
 <20230928202410.3765062-3-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928202410.3765062-3-kpsingh@kernel.org>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Sep 28, 2023 at 10:24:07PM +0200, KP Singh wrote:
> These macros are a clever trick to determine a count of the number of
> LSMs that are enabled in the config to ascertain the maximum number of
> static calls that need to be configured per LSM hook.
> 
> Without this one would need to generate static calls for the total
> number of LSMs in the kernel (even if they are not compiled) times the
> number of LSM hooks which ends up being quite wasteful.
> 
> Suggested-by: Kui-Feng Lee <sinquersw@gmail.com>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Acked-by: Song Liu <song@kernel.org>
> Signed-off-by: KP Singh <kpsingh@kernel.org>

Thanks for doing the refactor with the existing macro!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
