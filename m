Return-Path: <SRS0=W1UI=UB=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775E6C28CC5
	for <linux-security-module@archiver.kernel.org>; Sun,  2 Jun 2019 02:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 508E027813
	for <linux-security-module@archiver.kernel.org>; Sun,  2 Jun 2019 02:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oHLBHGLn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfFBCGl (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 1 Jun 2019 22:06:41 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34427 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbfFBCGl (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 1 Jun 2019 22:06:41 -0400
Received: by mail-pf1-f195.google.com with SMTP id c14so6103072pfi.1
        for <linux-security-module@vger.kernel.org>; Sat, 01 Jun 2019 19:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yEDOMLg43l/OxcdDDGPDDhjZbyNKTINZY1cleXkP44Y=;
        b=oHLBHGLnvG0KIOYAY4YUyDml0pFEM/x7XtbLSiPIA7UOKtxRplS717RUom8Vn70itw
         MqWKOuM89gBL65CnXo/d1qPI1QMyWkcNOZFVyhuGRW/x4h2YUr/+QyGu2Z9tqAFkBivT
         kG9bLduV3NuWvGs5GoOklG6qLvPuGD0JMw9lU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yEDOMLg43l/OxcdDDGPDDhjZbyNKTINZY1cleXkP44Y=;
        b=aKeyOJdM4Z8E5R3H3LiUrsLF7Dr3X0AaJS318JaFqgrw4u2pZKAaFNJSyUbFqGn8k9
         0evJR2f/39FIATR6U77J6DhonoQ9/gSYQIB+LB/zUlGvX7ImUIB+yW4x/hmsRsSUYUEB
         b2fPV+Evdwocs/v+zadGU7rO/2hE6rB9bYgniQjtBh+aBMtLgVg7ZsHcyXwtAxlxRcwS
         EVRogFDMOLNW8izYGhTxPXJs46rZEtLfhAjBIJU+GZTNGxZsd1iQ6wfKE4IBfZ5vgk/A
         OGTQIY5YWjeJxL7Mq8t05FoGPxcBqlJo2b/VFwa3lRluJcamFLdKEJ/adYpPNGCxaf1a
         x+Zg==
X-Gm-Message-State: APjAAAXwU2YkiJH4A2Wonl+gyXK0Z7RYxtr97JrFuBUVBWZZadzlycca
        3rW6kO5Df9sOSdNJU11zhsGllg==
X-Google-Smtp-Source: APXvYqykMKR9oU2QH0dFynfspSHhFJWapuCvbqs2H076Ap43d8wdl1WNq39lfAjUi2fy+u0uRSpy4g==
X-Received: by 2002:a62:160b:: with SMTP id 11mr21704975pfw.30.1559441200799;
        Sat, 01 Jun 2019 19:06:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d9sm9044282pgj.34.2019.06.01.19.06.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Jun 2019 19:06:40 -0700 (PDT)
Date:   Sat, 1 Jun 2019 19:06:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH 25/58] IMA: Clean out lsm_export scaffolding
Message-ID: <201906011905.75B11DC86@keescook>
References: <20190531231020.628-1-casey@schaufler-ca.com>
 <20190531231020.628-26-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531231020.628-26-casey@schaufler-ca.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, May 31, 2019 at 04:09:47PM -0700, Casey Schaufler wrote:
> +++ b/security/integrity/ima/ima_api.c
> @@ -159,7 +159,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
>   * ima_get_action - appraise & measure decision based on policy.
>   * @inode: pointer to inode to measure
>   * @cred: pointer to credentials structure to validate
> - * @secid: secid of the task being validated
> + * @l: LAM data of the task being validated
>   * @mask: contains the permission mask (MAY_READ, MAY_WRITE, MAY_EXEC,
>   *        MAY_APPEND)
>   * @func: caller identifier

Call this "l" just hurts me. Why shouldn't it still be secid?
Also typo: LAM -> LSM.

-- 
Kees Cook
