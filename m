Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777D9C4167B
	for <linux-security-module@archiver.kernel.org>; Fri, 23 Dec 2022 18:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbiLWSlN (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 23 Dec 2022 13:41:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbiLWSlM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 23 Dec 2022 13:41:12 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823581CB2B
        for <linux-security-module@vger.kernel.org>; Fri, 23 Dec 2022 10:41:11 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id o8-20020a17090a9f8800b00223de0364beso9485418pjp.4
        for <linux-security-module@vger.kernel.org>; Fri, 23 Dec 2022 10:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fR8IA5HghKSQ9FgjGdgnRa1qakr0JhCwjYS6vZEikZU=;
        b=LnhS/jgwr3aFvQJYbl+K5MsWVcPAP5jRbK6RiU1mm7FqD5WaS6fHe0JdjgBCEYZ26m
         676+zKKbgSDVBO+1a3g+zDTowtMA0w7l/Qsc6a1tmLPL5Kf+/IHV8YXMUNfKJOaTpkpE
         BXB+Ba0gx+Tq5B2Cq3z4tKWx1+qt39I9vRI94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fR8IA5HghKSQ9FgjGdgnRa1qakr0JhCwjYS6vZEikZU=;
        b=W7vzACgk3voWrYCye0Q6wn2RTNrPKsJYLEtVV1dofwQITN6lWyxss880+JxbimX3p6
         hVivZfAE+oEIQL0C927nwOQ4M+69PMSHK6y9rvg/SbyLqHf1i52ufZ1TcHFo9O4yDe6O
         E+sQamGO89qdHvwBnDZnnfrNQILBDCfS6pPLovyQJwkD+Vk5TUsedkPGKH5T79m6H0l/
         dEwuh6G8bJ3iKYixxRVP17pT13bjAJkYvTggHS+eRC5MZ6jODEsxdH419/Hrf0Kvat7X
         XAb6Ztk08Hrz6q6St18Czp07T6hhHC8HX1sqBksxJy+lbUAs+xJcZC/G/zP03nPDjSAV
         gd2w==
X-Gm-Message-State: AFqh2krBPtgVDqWx+EsUYVdEImcUR5ujeXkuetmxjcsw6PMQLxv3afIA
        VGAesfAemFX4A/VuS1+JVN9+hw==
X-Google-Smtp-Source: AMrXdXsAa24RroS47+INAqXRa2gPvLFTO4iM9NRBoXhjWS+RYk/23NCC7e9uMO2E4ap5gEywVStVLQ==
X-Received: by 2002:a17:902:b60e:b0:189:89a4:3954 with SMTP id b14-20020a170902b60e00b0018989a43954mr11176601pls.41.1671820871085;
        Fri, 23 Dec 2022 10:41:11 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902e74400b00178b9c997e5sm2723760plf.138.2022.12.23.10.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 10:41:10 -0800 (PST)
Date:   Fri, 23 Dec 2022 10:41:10 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        kernel test robot <lkp@intel.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        tangmeng <tangmeng@uniontech.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [GIT PULL] kernel hardening fixes for v6.1-rc1
Message-ID: <202212231040.2D92409F@keescook>
References: <202212231009.EC864645D8@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202212231009.EC864645D8@keescook>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Dec 23, 2022 at 10:10:19AM -0800, Kees Cook wrote:
> Please pull these kernel hardening fixes for v6.1-rc1, collected over the
> last week.

Ugh. I mistyped the version obviously. This should be v6.2-rc1. I've
sent another PR with the tag fixed. Sorry about the noise.

-- 
Kees Cook
