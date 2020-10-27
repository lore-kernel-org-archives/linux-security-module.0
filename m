Return-Path: <SRS0=YDB1=EC=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76AA5C4363A
	for <linux-security-module@archiver.kernel.org>; Tue, 27 Oct 2020 19:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 117022222C
	for <linux-security-module@archiver.kernel.org>; Tue, 27 Oct 2020 19:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivZMUEdn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1808758AbgJ0TiB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 27 Oct 2020 15:38:01 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43238 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504319AbgJ0TiA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 27 Oct 2020 15:38:00 -0400
Received: by mail-lf1-f67.google.com with SMTP id l28so3822246lfp.10;
        Tue, 27 Oct 2020 12:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EGjFU2HtewWIYk+zR7rYt/gKEi0EZXYQo9cL0+1N+xo=;
        b=ivZMUEdnYEBDd80AhRKTUWJgS4p4iCRMDZFOLZHKm+H3TCpxxUFatS/SgnwPTmfgTa
         pgDf04IgmX1gwano/QCWjk0cp9PCX06AklXGi7ibrFBHs7Tr2QB4T569o7J3wi2wE5ly
         wsUTwr7JnvowxRO+zXhOV1NdbPDq+9zEbsF2SUwAakenfYbf8zCCmiTfp9elGNcThSN7
         w9HZ4HiGRjPnUI7XzBvMzpuciQlhh3O0lGtWPAaprIOtwRX6AE7PrQfC2ipne9GD2Pgw
         sJq7I3zVBzRkvwxSURNEb/Nd8uX/+1CtvE31klVPwq/NmTKyvH2gkq80XwUNvOz2+wWE
         JXGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EGjFU2HtewWIYk+zR7rYt/gKEi0EZXYQo9cL0+1N+xo=;
        b=MGEX0Y7HkGUjgFWpGFSfhBBVvozO8WpvGjQZJpdGK7XL6COcWp7owlv9DsJkGN/37r
         8SraDZIy2ALL+OY4tZD1eKAESNjeprgSmLKegoNkkoLgcp3j05WIv29fuwMBj3b61R2/
         SWFKa8iXwLEPvelpVuTF4m/C1oSmnNGBCy32A52Ls2pgAR2FxiDkhSqFk4WxLAOGQVcK
         tMk/iVL1Sj7cSZ2O7SgIFAnM3HZJqh1z+3J6Vjtk4Ivde8QM8uTiPZgnutEnFfUJKy1w
         Bryw0vWN5IMTTDHsNFewfB7xWBGhUSUgG2pUtPI4gsajZGGs1wzfxvk2zefhPuV8hLu+
         5z4A==
X-Gm-Message-State: AOAM530VJaG7gnJ6jpV1fu/LsmmZ7iDkzKztBrbzF1W7Hbx0OYmIzHKT
        LRH3MC4H2W+FzZlcvEj0Z/k=
X-Google-Smtp-Source: ABdhPJydCbe7yUTRQC0vVGJG0xMUcN5lcjTDUhWqbzfV41X7tcQRe3JMGjY5cpoLSUOHE95B+KtH2w==
X-Received: by 2002:a19:7710:: with SMTP id s16mr1238315lfc.293.1603827477365;
        Tue, 27 Oct 2020 12:37:57 -0700 (PDT)
Received: from grain.localdomain ([5.18.91.94])
        by smtp.gmail.com with ESMTPSA id t80sm271413lff.72.2020.10.27.12.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 12:37:56 -0700 (PDT)
Received: by grain.localdomain (Postfix, from userid 1000)
        id 8EA5D1A0078; Tue, 27 Oct 2020 22:37:55 +0300 (MSK)
Date:   Tue, 27 Oct 2020 22:37:55 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Adrian Reber <areber@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Jann Horn <jannh@google.com>, Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>
Subject: Re: Inconsistent capability requirements for prctl_set_mm_exe_file()
Message-ID: <20201027193755.GB2093@grain>
References: <7655a573-544f-05a4-36dc-0c84c73ac9ee@gmail.com>
 <2b66ac32-adfd-de1b-499b-8ba4f7b9bea4@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b66ac32-adfd-de1b-499b-8ba4f7b9bea4@virtuozzo.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Oct 27, 2020 at 08:22:11PM +0300, Kirill Tkhai wrote:
> 1)Before my commit there also were different checks
> 
>         !capable(CAP_SYS_RESOURCE))
> and
> 	uid_eq(cred->uid, make_kuid(ns, 0)) && gid_eq(cred->gid, make_kgid(ns, 0))
> 
> so it is not the initial reason. The commit even decreased the checks difference
> and it made both the checks are about capability().
> 
> 2)As I understand new PR_SET_MM_MAP interface differs in the way, that it allows to batch
> a setup of prctl_mm_map parameters. So, instead of 14 prlctl calls with different arguments:
> PR_SET_MM_START_CODE, PR_SET_MM_END_CODE, PR_SET_MM_START_DATA, .., PR_SET_MM_ENV_END,
> we set then all at once and the performance is better.
> 
> The second advantage is that the new interface is more comfortable in case of we set all
> of 14 parameters. Old interface requires special order of calls: sometimes you have to
> set PR_SET_MM_START_CODE first and then PR_SET_MM_END_CODE second, some times it is vice
> versa. Otherwise __prctl_check_order() in validate_prctl_map() will fail.

Since I've been the person who introduced the former PR_SET_MM_X interface I already
explained that the PR_SET_MM_X is simply shitty and better be vanished and forgotten.
Which we simply can't do :/ In turn PR_SET_MM_MAP is the only right way to verify
all fields in a one pass not only because of speed but otherwise the validation
of parameters is not even associative and in result (as you mentioned) _order_ of
calls does matter for start_code/end_code.

> 3)For me it looks like any combinations of parameters acceptable to be set by both interfaces
> are the same (in case of we don't see on permissions checks). In case of we can assign a set of
> parameters {A} using old interface, we can assign it from new interface and vice versa.
> Isn't this so?! If so, we should use the same permissions check.

Yup, if only I'm not missing something obvious we could drop cap(sys-resource) here
because internally after this check we jump into traditional verification procedure
where the map is filled from runtime data.

I'm quite sceptic that LSM hook Jann mentioned gonna be better. It might be an
addition but not the replacement. Moreover if we add it here someone from CRIU
camp have to verify that it won't break current CRIU tests.
