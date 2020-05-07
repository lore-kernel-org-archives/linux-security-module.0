Return-Path: <SRS0=9z6D=6V=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D328EC28CBC
	for <linux-security-module@archiver.kernel.org>; Thu,  7 May 2020 03:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4C462068E
	for <linux-security-module@archiver.kernel.org>; Thu,  7 May 2020 03:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EDZcbDkr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbgEGDLY (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 6 May 2020 23:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728295AbgEGDLX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 6 May 2020 23:11:23 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4F3C061A41
        for <linux-security-module@vger.kernel.org>; Wed,  6 May 2020 20:11:23 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z8so4528937wrw.3
        for <linux-security-module@vger.kernel.org>; Wed, 06 May 2020 20:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/M4/DuBTGflvVuChw5Y25GaHL26QwHucGpDopq+uKKM=;
        b=EDZcbDkryNHUq+1LtvqavsxqGBJ2zTgq94L3okmprwpunnwTqR843h/HBRE9aU+gHJ
         V4HcsR9N0EJlXs7fC0Wt4d5cyP4EvYKBZDbJQ7xDwC74mBhV6Om8NAOKru6gJ1ylLOzI
         wE2MB+h/1AOPbbHBAdNE+XMuiBgywyQ60Mia14JbAEGLC+u7ZOLY/dhydgzotaUpF8uY
         QwnYAynKqDtPfZzajgUJo2uvhonRZF3QPRJ1e+E9RdcEmRGMFnbFw6dAtUCuCksgLmmn
         6JieoL6lt15z7QZ0COWZ8gB9QYLbTQg/F+92uVog9oKiv4936wfJgOmksAKdpwWjacWY
         YYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/M4/DuBTGflvVuChw5Y25GaHL26QwHucGpDopq+uKKM=;
        b=Zzkjz4/ABUpkFuc+O5ybDWashf+16t3ojLrMZvFw6zINHd3Thxw9bNokot9pm2T1zG
         vuTxqQUDabANjEFCIX9BA4l1m27F3+gtyFMijydb07fVNK2Sun+xffS8fHxOcOgHtato
         Yay8jjVmsqHGG8Pa49DPxNS2QGksmxHSr9KTk829IwiFCLBj/gWyaxVWb6lO6MkVOeK9
         AJ/5BQ1izv5oX/XNhZM2skdl9s2pktyYLpx7RG8JanyAvvr3lOIrVHmSWAij9V/uVHyT
         kmCZ2x6FwRKIUIsq28tgXfwRq6Fl5aVX317pFV0U8IG6RDs+4vTu5mxaPcwjZ+HS0vkN
         w7gA==
X-Gm-Message-State: AGi0PuYkvHblDFN7tl93NkblymM7f7n/RA/2pvBwR9KdfJgVmHsbZTy8
        b7waPYDSd8KLj/AnPqGGGV0WWRM1P9G3VRiasgFUDQ==
X-Google-Smtp-Source: APiQypLBDSZbDJjvDYDKUk2tG5mW4OE2larhjMHIL+GzojR08YDhbTwnOD8/jg18+7ituZ8OLmGHSBh19zzrRajSfq8=
X-Received: by 2002:adf:e34d:: with SMTP id n13mr1519574wrj.249.1588821081532;
 Wed, 06 May 2020 20:11:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200505102714.8023-1-anders.roxell@linaro.org>
In-Reply-To: <20200505102714.8023-1-anders.roxell@linaro.org>
From:   David Gow <davidgow@google.com>
Date:   Thu, 7 May 2020 11:11:10 +0800
Message-ID: <CABVgOSnxMd1ZdEQ3jHxtok1oQcMKh=UMtxZufeS9fv-q9C3-AQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] lib: Kconfig.debug: default KUNIT_* fragments to KUNIT_RUN_ALL
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        John Johansen <john.johansen@canonical.com>, jmorris@namei.org,
        serge@hallyn.com, "Theodore Ts'o" <tytso@mit.edu>,
        adilger.kernel@dilger.ca,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        =linux-kselftest@vger.kernel.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org, linux-security-module@vger.kernel.org,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, May 5, 2020 at 6:27 PM Anders Roxell <anders.roxell@linaro.org> wrote:
>
> This makes it easier to enable all KUnit fragments.
>
> Adding 'if !KUNIT_RUN_ALL' so individual test can be turned of if
> someone wants that even though KUNIT_RUN_ALL is enabled.
>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Reviewed-by: David Gow <davidgow@google.com>

Thanks!
-- David


> ---
>  lib/Kconfig.debug | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 21d9c5f6e7ec..d1a94ff56a87 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2064,8 +2064,9 @@ config TEST_SYSCTL
>           If unsure, say N.
>
>  config SYSCTL_KUNIT_TEST
> -       tristate "KUnit test for sysctl"
> +       tristate "KUnit test for sysctl" if !KUNIT_RUN_ALL
>         depends on KUNIT
> +       default KUNIT_RUN_ALL
>         help
>           This builds the proc sysctl unit test, which runs on boot.
>           Tests the API contract and implementation correctness of sysctl.
> @@ -2075,8 +2076,9 @@ config SYSCTL_KUNIT_TEST
>           If unsure, say N.
>
>  config LIST_KUNIT_TEST
> -       tristate "KUnit Test for Kernel Linked-list structures"
> +       tristate "KUnit Test for Kernel Linked-list structures" if !KUNIT_RUN_ALL
>         depends on KUNIT
> +       default KUNIT_RUN_ALL
>         help
>           This builds the linked list KUnit test suite.
>           It tests that the API and basic functionality of the list_head type
> --
> 2.20.1
>
