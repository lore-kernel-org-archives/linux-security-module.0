Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8625BE94133
	for <linux-security-module@archiver.kernel.org>; Fri,  6 Oct 2023 22:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbjJFWT5 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 6 Oct 2023 18:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbjJFWT5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 6 Oct 2023 18:19:57 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E65CBF
        for <linux-security-module@vger.kernel.org>; Fri,  6 Oct 2023 15:19:55 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-584bfb14c59so1803417a12.0
        for <linux-security-module@vger.kernel.org>; Fri, 06 Oct 2023 15:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696630794; x=1697235594; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ec5NVHbOagI42dAvgiLFB5L5PsJa40bcRKKQnaC9gmQ=;
        b=ON2TIh5+R6axoaeHGclGeaglqFrSBEMyFQZceJ2K+Tsp9S+fTRZpJKp12KGEYKJ+La
         QObSxdHSXGUVxyNjMpDDCZB3BO+HCPsWsP3WAmSMr44CRYP7P2zD2azSfVkyRTjP5+rz
         hiPPx8mnG/x/qCH9xmdCm3IXW6AoYUzHW/W0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696630794; x=1697235594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ec5NVHbOagI42dAvgiLFB5L5PsJa40bcRKKQnaC9gmQ=;
        b=JBRzLjaCcXiu4y3XcgYQmfzoZ4y+dPDgFJzt6dGLq8lxig4wK4sSgb79NqAeiSpryP
         5TD5YK9lR4RMWdZ02bI8QY2CYAQR46V6uq8QldGEIDqoxPNf7poGM2TtekSSw2MJrCLk
         XOY4Yn/ffUjPFp6Yfh2V6PM54jMnpiCfQmhRnqo5ywRGe3vqAFFVW9P/y/BugyrNWw1o
         qsBnUwE3zWOf4fRpKKRwirtNy1+jx5l/JGnS3iDHWPnDWzuJRLXkjYXYqIAGSxaqJtZf
         naKgGIZQ0ebT/3g11xUx1TS7Ubock/xUOBhKwXCSfsqhCLMGfUDZ5sA61Pkp/QPEjY7m
         7c9Q==
X-Gm-Message-State: AOJu0YyUTzztKssGK5DZVTc7sp0RaQEaQnwA/EXZfZcOpjVKZfKBem52
        izc/SOk2NXUi7Q66UOm+T9M4rg==
X-Google-Smtp-Source: AGHT+IEey6lOaoGA9MCcQYpZbetqjfB4y53xgl/tiG/jQHm6b7ng4VEgrIdMet51CFBr3t9yqWxMRQ==
X-Received: by 2002:a17:90b:4f46:b0:267:f9c4:c0a8 with SMTP id pj6-20020a17090b4f4600b00267f9c4c0a8mr9120373pjb.4.1696630794515;
        Fri, 06 Oct 2023 15:19:54 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id lj4-20020a17090b344400b0026cecddfc58sm6048065pjb.42.2023.10.06.15.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 15:19:53 -0700 (PDT)
Date:   Fri, 6 Oct 2023 15:19:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     KP Singh <kpsingh@kernel.org>
Cc:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        paul@paul-moore.com, casey@schaufler-ca.com, song@kernel.org,
        daniel@iogearbox.net, ast@kernel.org, renauld@google.com,
        pabeni@redhat.com, Kui-Feng Lee <sinquersw@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH v6 2/5] security: Count the LSMs enabled at compile time
Message-ID: <202310061519.7A41CF216C@keescook>
References: <20231006204701.549230-1-kpsingh@kernel.org>
 <20231006204701.549230-3-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006204701.549230-3-kpsingh@kernel.org>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Oct 06, 2023 at 10:46:58PM +0200, KP Singh wrote:
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

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
