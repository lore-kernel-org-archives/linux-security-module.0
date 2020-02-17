Return-Path: <SRS0=tuct=4F=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48012C34022
	for <linux-security-module@archiver.kernel.org>; Mon, 17 Feb 2020 18:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E2E6215A4
	for <linux-security-module@archiver.kernel.org>; Mon, 17 Feb 2020 18:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VMNuYUmU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbgBQSjC (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 17 Feb 2020 13:39:02 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36855 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727601AbgBQSjC (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 17 Feb 2020 13:39:02 -0500
Received: by mail-pf1-f193.google.com with SMTP id 185so9352821pfv.3
        for <linux-security-module@vger.kernel.org>; Mon, 17 Feb 2020 10:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RbW7duBlVCzDcI0iF9afrjJ7KHsSIzqTpcHq8V46J2Q=;
        b=VMNuYUmUtV6Gj6FG8unzj2/r8y8iMlywPXQRXi0jlcCEJiIzzkZK69KKDVd6PRGwqm
         JkFAi7LU8Kc6FPxQtqfuxXRPQg0ap5JuxNtChTJ4eC4viOVh4S+s5+PbNRqjYxpTSFbs
         bIO9clKiJJOuQ3B7K6T1eBOZeItyoXb+ponFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RbW7duBlVCzDcI0iF9afrjJ7KHsSIzqTpcHq8V46J2Q=;
        b=nNLE42QudQOBYOjyR1nIVY8ikCjots8FVe1fw1QXkptnSuUSqDXI3WWrZyDix0t/96
         lXKkFs2I4XtvyW6I33X2YO6fdrbrASwghnkWvPjyhS4dqRWfbMm9QrMe/7rjhhCJ68tn
         QPmVDtKAuBuAsaDvjHrLD3ccICHaXuwRf1CKtzREPmd3XxebLHh8Tqjv0AwMb4fVti/M
         sKNl7YCMURljVm1CAVnyOLAp4S6U8AqaWYIB6XBRQtrFluaPZfHIQ9+MMQ8NLqYgIBrD
         zh0+8qEYt26evqTjYD1LsRFxhcsz0b7yFuIMODf5z04yoXLNribjZ8c+ODrk+8hA9zLC
         3fVQ==
X-Gm-Message-State: APjAAAWUjtvZD+HfAhQUCaFuTyX8GyC7gWgjdQu0mP7UCy7DO7guvA7H
        H6P83BmWPdIyi+/EFd/ionvctA==
X-Google-Smtp-Source: APXvYqwAJ/E9bXWArRV7T0+/OiXcVcZjQP4+pzYRR+7zBhSyLDjr8Y6RuIlXvzvSuevcOU5KtZ6ZPg==
X-Received: by 2002:a63:5558:: with SMTP id f24mr18111297pgm.92.1581964741987;
        Mon, 17 Feb 2020 10:39:01 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g7sm1184774pfq.33.2020.02.17.10.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 10:39:01 -0800 (PST)
Date:   Mon, 17 Feb 2020 10:39:00 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        Micah Morton <mortonm@chromium.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: Re: [RFC PATCH] security: <linux/lsm_hooks.h>: fix all kernel-doc
 warnings
Message-ID: <202002171038.64EEC770@keescook>
References: <fb2c98bd-b579-6ad0-721a-56a4f81f0d6e@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb2c98bd-b579-6ad0-721a-56a4f81f0d6e@infradead.org>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, Feb 15, 2020 at 11:08:38PM -0800, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix all kernel-doc warnings in <linux/lsm_hooks.h>.
> Fixes the following warnings:
> 
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'quotactl' not described in 'security_list_options'
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'quota_on' not described in 'security_list_options'
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'sb_free_mnt_opts' not described in 'security_list_options'
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'sb_eat_lsm_opts' not described in 'security_list_options'
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'sb_kern_mount' not described in 'security_list_options'
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'sb_show_options' not described in 'security_list_options'
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'sb_add_mnt_opt' not described in 'security_list_options'
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'd_instantiate' not described in 'security_list_options'
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'getprocattr' not described in 'security_list_options'
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'setprocattr' not described in 'security_list_options'
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'locked_down' not described in 'security_list_options'
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'perf_event_open' not described in 'security_list_options'
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'perf_event_alloc' not described in 'security_list_options'
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'perf_event_free' not described in 'security_list_options'
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'perf_event_read' not described in 'security_list_options'
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'perf_event_write' not described in 'security_list_options'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Yay! Thanks for working through these. :)

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
