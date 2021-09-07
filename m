Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F45C433EF
	for <linux-security-module@archiver.kernel.org>; Tue,  7 Sep 2021 22:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49B1C61101
	for <linux-security-module@archiver.kernel.org>; Tue,  7 Sep 2021 22:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346385AbhIGW1z (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 7 Sep 2021 18:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346121AbhIGW1t (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 7 Sep 2021 18:27:49 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED71FC061575
        for <linux-security-module@vger.kernel.org>; Tue,  7 Sep 2021 15:26:40 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id e21so1159886ejz.12
        for <linux-security-module@vger.kernel.org>; Tue, 07 Sep 2021 15:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I0zmMnIiAhcfycStlfZRMWh53/bzZhPDg9yKAX8nkCc=;
        b=cNF0wdQ/TI780fTJbXH+7PorV+kNufKENvngWCa75x9+fsFjdodc8BLriyvTsCTO8U
         3xhHhbhNl3mJ8vyi986ZALpOUaKDIIiRRrmudAYEM+8oj2aPJHDjMPeTyMLxFH9iIA3K
         h4nrgFG911smxfTzCOCLFHotIQtnlmu1V6DQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I0zmMnIiAhcfycStlfZRMWh53/bzZhPDg9yKAX8nkCc=;
        b=WAhyxcJrB/R8f5+CXD/1v9RO42gC20imEaSnrjkHDlXr0kUsUlafABxX829E8zm/EA
         0FkEgwfF2WkBKmD49q+UPuX5mp6Mj2SBpKwzfXASR3lioJ7zVExSFGK9ZWwZX9HmcLcp
         BaD60z333LMJyfYy4ix58msbginrYmy5ac3gyLX5dFWrKib8XnCTubLAiC1i9fYBTag6
         KlD5qarx2EkTu3C+e62UkZS+gElTFsU8uacKEE415GP/T9/rH1lA/nuyWRYsqFsLMVWW
         kKCf22mLbyuw/sYXoBKIit84LQTSrZvBsSt2NjJezVLT9PRNd0EatbfagS3tnALiPdAy
         OyYA==
X-Gm-Message-State: AOAM530waNUh3HpwOGR8CHRJIN2xseTffL+YzJ5jwY4JiPJfS9n/hXdN
        mK5Tasi7zDSLnXJyOXgJ6aOdHKwiTBfjoW9DysY=
X-Google-Smtp-Source: ABdhPJyZiiT4s0hPdSQ7pKlTUBiSrjMiXdSTOkMGRvZ3pxrVUwHu2IszQGanFnZrv0howLYC3p81Bw==
X-Received: by 2002:a17:906:1b14:: with SMTP id o20mr687534ejg.154.1631053599383;
        Tue, 07 Sep 2021 15:26:39 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id r6sm68610ejb.119.2021.09.07.15.26.39
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 15:26:39 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id m9so281916wrb.1
        for <linux-security-module@vger.kernel.org>; Tue, 07 Sep 2021 15:26:39 -0700 (PDT)
X-Received: by 2002:a05:6512:3da5:: with SMTP id k37mr426102lfv.655.1631053110042;
 Tue, 07 Sep 2021 15:18:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210907183843.33028-1-ndesaulniers@google.com>
 <CAHk-=whJOxDefgSA1_ojGbweRJGonWX9_nihA-=fbXFV1DhuxQ@mail.gmail.com>
 <CAKwvOdkuYoke=Sa8Qziveo9aSA2zaNWEcKW8LZLg+d3TPwHkoA@mail.gmail.com> <YTfkO2PdnBXQXvsm@elver.google.com>
In-Reply-To: <YTfkO2PdnBXQXvsm@elver.google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Sep 2021 15:18:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgPaQsEr+En=cqCqAC_sWmVP6x5rD2rmZRomH9EnTQL7Q@mail.gmail.com>
Message-ID: <CAHk-=wgPaQsEr+En=cqCqAC_sWmVP6x5rD2rmZRomH9EnTQL7Q@mail.gmail.com>
Subject: Re: [PATCH] Revert "Enable '-Werror' by default for all kernel builds"
To:     Marco Elver <elver@google.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>, llvm@lists.linux.dev,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-toolchains@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Kees Cook <keescook@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vipin Sharma <vipinsh@google.com>,
        Chris Down <chris@chrisdown.name>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Sep 7, 2021 at 3:14 PM Marco Elver <elver@google.com> wrote:
>
>
>  config WERROR
>         bool "Compile the kernel with warnings as errors"
> -       default y
> +       default COMPILE_TEST

That seems reasonable. It very much is about build-testing.

              Linus
