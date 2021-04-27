Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84B1C433ED
	for <linux-security-module@archiver.kernel.org>; Tue, 27 Apr 2021 19:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93FC3613F8
	for <linux-security-module@archiver.kernel.org>; Tue, 27 Apr 2021 19:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236903AbhD0TOs (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 27 Apr 2021 15:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbhD0TOr (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 27 Apr 2021 15:14:47 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C20AC061574
        for <linux-security-module@vger.kernel.org>; Tue, 27 Apr 2021 12:14:04 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 124so14313288lff.5
        for <linux-security-module@vger.kernel.org>; Tue, 27 Apr 2021 12:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AB1V5oTeJ2WhmRUJ2GQVF15rRhUULVDZ8xbuGavAGZA=;
        b=I8zIhzF4xgs5c9h1B1B6xucfwUSXsJCLvkzdvgFByQMkD/6NohNVrRzONOvdpaA7Yt
         9flVvqBihPi+J/VFGoIeA+5FWdpIVgL4jXedmK4WaWIH6QSYY/Y099cYHSbZZCZnSX/e
         eAs+KD+7AF7yVcTjiL8nPKQRhuRs2KHwUSfcRs+EAXl8dZw79iBX5mr8sTM/RHfgLjGv
         c7S/fgXvQ7rOqxXwwX9eqRS+KymuHnsiiMELAfJoasgxe1gH9JkpBWGmbQ+ySfwQc0IF
         mFQcSyMPUoDIAnzO0u7bBbiuDv+PCAICjPvJ73Pftnqtcsf6KfhM4VKGU49R2y5NaR0B
         oNTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AB1V5oTeJ2WhmRUJ2GQVF15rRhUULVDZ8xbuGavAGZA=;
        b=jN8wRCw3b2OwyP6gj2OwWphA6qDZXiXJTVJ4+CH7i1LFoQL6hQlx66gU2a+Xq6gIVT
         UHPjec+KYndvSLVRiudaeJAbOmPI2oFLeDtibuTYGMZdHaC8wWSoUJtghO51QZF3G+gS
         lUpKrtlVMbjh7GXIGESezdgDTe8k089WpXYYKOid9ZZdL5DTr7HKle9tSoIuSAlE1yuO
         KrJXCpSVwTSZ8q9sx0E1uovv064dqm0yM+RlXBkDWVFT3I29NlA5gHADgMZaXOGr5EHK
         utkhPEwixrYudryPhjMmAb3GTlf+Iw2pnyqDYE7XmyPhJ3DzEMxd6PHhup/aVYWnDR+k
         qJYA==
X-Gm-Message-State: AOAM533Q6gzKxqfzuo+2NIUgU8bEngyrmOBRaX8mSCbWr47E0GaYvKM0
        ASWAzeV044qMD77DnjVsWG6SbrbwqpFDtnnFJUUcQz13CGDiMg==
X-Google-Smtp-Source: ABdhPJykOuvO+JF+ov+nYGOflfc88og8ntGA+7tM52OJQhzJrCmQGKukRAhEsqS2SSb9bsrTAuPydW4Pn7czvNa/p20=
X-Received: by 2002:ac2:46ed:: with SMTP id q13mr17241394lfo.543.1619550842376;
 Tue, 27 Apr 2021 12:14:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210427183755.2790654-1-trix@redhat.com>
In-Reply-To: <20210427183755.2790654-1-trix@redhat.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 27 Apr 2021 12:13:50 -0700
Message-ID: <CAKwvOdmj5YvWZZWwcq1G7JgRALwPbqwiROiedMeEbBst2sGeiQ@mail.gmail.com>
Subject: Re: [PATCH] samples/landlock: fix path_list memory leak
To:     Tom Rix <trix@redhat.com>
Cc:     mic@digikod.net, Nathan Chancellor <nathan@kernel.org>,
        linux-security-module@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Apr 27, 2021 at 11:38 AM <trix@redhat.com> wrote:
>
> From: Tom Rix <trix@redhat.com>
>
> Clang static analysis reports this error
>
> sandboxer.c:134:8: warning: Potential leak of memory
>   pointed to by 'path_list'
>         ret = 0;
>               ^
> path_list is allocated in parse_path() but never freed.
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  samples/landlock/sandboxer.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
> index 7a15910d2171..4629d011ed61 100644
> --- a/samples/landlock/sandboxer.c
> +++ b/samples/landlock/sandboxer.c
> @@ -134,6 +134,8 @@ static int populate_ruleset(
>         ret = 0;
>
>  out_free_name:
> +       if (path_list)
> +               free(path_list);

I don't think the conditional is even necessary? By our first `goto
out_free_name;`, `parse_path` has already been called/memory for
`path_list` has already been allocated. `parse_path` doesn't check
whether `malloc` has failed.

>         free(env_path_name);
>         return ret;
>  }
> --
> 2.26.3
>


-- 
Thanks,
~Nick Desaulniers
