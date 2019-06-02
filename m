Return-Path: <SRS0=W1UI=UB=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA57C28CC5
	for <linux-security-module@archiver.kernel.org>; Sun,  2 Jun 2019 02:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DBB827825
	for <linux-security-module@archiver.kernel.org>; Sun,  2 Jun 2019 02:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QOpMcgQO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfFBC1p (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 1 Jun 2019 22:27:45 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41046 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbfFBC1p (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 1 Jun 2019 22:27:45 -0400
Received: by mail-pf1-f195.google.com with SMTP id q17so8523822pfq.8
        for <linux-security-module@vger.kernel.org>; Sat, 01 Jun 2019 19:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ugf+fTh4qJ6pBmCnLGO8ROUaPCCo3PNhjO7wjjwBTQA=;
        b=QOpMcgQOT7ax7aBmTOcN6nu/T0E0/k5bYUV8OGTHyp0TpeBkwf4alWVLYER9q6KfAu
         YdRChoPh4IwsssikCPumIEsxGT8c23RiR3VoQfsdIYE3xKhR5J9mHTCUo9Anlz8JfF4z
         t0ECKQ7yfP0MHtYS7NofW6hfP7GBh2pJI+Xz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ugf+fTh4qJ6pBmCnLGO8ROUaPCCo3PNhjO7wjjwBTQA=;
        b=LnyYmic6QTdpDyk006tvKj65EpQA9jtChJzqi5tB28+tbF2d6I2jptuMEn9WJltANI
         SkKPfxceW6MPaN/aDI7mpMoALojeA6QJTlipi29PM347xYTMQaQNjAmdrG+0nsucrj1S
         NGRur1e7GaF15bF9QyoY/NmAaT4nDlWgUomLePZ9o4kjL5X/ZG/wSXdsmd8NXv0T0rzm
         p7k6Svb0InYSenTOaIaD8sMgh3lyrU/AizMQ0mD6AooURTExyAvmcQe6ovn+eSWtV6YB
         gyD1YkiiJEPXNhcIhM/YQujzMLpq/mSXN4VsVLK61EjoI9eYMsY9+XRMqpmxMtP7ulea
         MvRg==
X-Gm-Message-State: APjAAAUBaXEPWUosDpd2FTYhhMm4l1sF6sGuTBspTNpGauI1wIOSJYMI
        HrzpdeQTzeah8AGfGaAxuAK2/w==
X-Google-Smtp-Source: APXvYqzEuxp5SgJzYlExv5KafVhdMBVFGHZy361P/xbw1aze+Xw9l4Q84rm6PR9ggNlqLS601v9p4w==
X-Received: by 2002:aa7:9342:: with SMTP id 2mr14209377pfn.241.1559442464775;
        Sat, 01 Jun 2019 19:27:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j72sm11472620pje.12.2019.06.01.19.27.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Jun 2019 19:27:43 -0700 (PDT)
Date:   Sat, 1 Jun 2019 19:27:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH 46/58] LSM: Use lsm_context in release_secctx hooks
Message-ID: <201906011920.C5CC2777@keescook>
References: <20190531231020.628-1-casey@schaufler-ca.com>
 <20190531231020.628-47-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531231020.628-47-casey@schaufler-ca.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, May 31, 2019 at 04:10:08PM -0700, Casey Schaufler wrote:
> -void apparmor_release_secctx(char *secdata, u32 seclen)
> +void apparmor_release_secctx(struct lsm_context *cp)
>  {
> -	kfree(secdata);
> +	kfree(cp->context);
>  }

Maybe better to have common helper?

void lsm_context_clear(struct lsm_context *cp)
{
    kfree(cp->context);
    cp->context = NULL;
    cp->len = 0;
}

-- 
Kees Cook
