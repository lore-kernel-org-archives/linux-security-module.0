Return-Path: <SRS0=Z1sm=7J=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0D5C433E0
	for <linux-security-module@archiver.kernel.org>; Wed, 27 May 2020 11:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4447C20873
	for <linux-security-module@archiver.kernel.org>; Wed, 27 May 2020 11:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dZ2EO3Ld"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbgE0Ltd (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 27 May 2020 07:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbgE0Lt3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 27 May 2020 07:49:29 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AE1C03E97A
        for <linux-security-module@vger.kernel.org>; Wed, 27 May 2020 04:49:29 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id h188so14296998lfd.7
        for <linux-security-module@vger.kernel.org>; Wed, 27 May 2020 04:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1eb8hhRgWhldc6gNCY/BHu4k6Mc3ON849X4b3k08UMU=;
        b=dZ2EO3LdRXmW0rb/PbGBy5/ATbLPpBSpne2iHWL8g4cHa5pFCH5GCbOAD7jC3Kzi3S
         MISYPGpgS2exm9jQV0gLr3s2v7seE3tyMVMGbhwvcq5KWBC2lbp4WRogLsHJmD56dSoF
         SaGqBkdQFcT/Q8+h09FriRhyy32nZ8Qbam2ia6qehADmirwsw9FzofuUIssUXiEf/O1M
         PNKyMGSEEuXIahADQmZbrbIFZkk9iuRkEcQbQIaG2M4cssRD0uw+ZxOkNkqohemuxYe7
         g5KMFqDZR/29AuHUIPPzijSDWnAEbdNVWRVRrdnecAjUZPqBYLoGLUucygRKxHZITQJs
         lRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1eb8hhRgWhldc6gNCY/BHu4k6Mc3ON849X4b3k08UMU=;
        b=LHFBSBULCOWaUZiaxxoMLZbYU/zH6FYgH/SQKDjBbj8X11w90GzFEX0Nxfb2QRS9Hc
         83CigOLFYiVWG1AACM95Knbfn/baqyyaZkQ7fjVzalRAJ2K62d6wDslNUBS/PRBc52OY
         rHcaMgckqLqXriivYaojBSKU2Oyjf8uBS7e2AXipvBQJJhxVfcbYRjjWx73VUgt2fMc6
         fCanoiws0aBa9yYYXvXGjUQ/Mb4QmC2omDnFw/Gqiki61YdD2FN9+QC6PBYMc3t5aZ/h
         Cja8RAUdX0YybgvcX4y4Qdyg5qa7WRllQGIR5xkgefY4RxVafQHO7PJ/essivNVWEjw6
         uF8g==
X-Gm-Message-State: AOAM530sqWPp+9e1+2YLUUB3pdYgambwP+TbJusopO+9UyI1K/o5mhzh
        SPs9+L1591i7QAHnrpXIDE+XwThEgDB37gYDpdYXAQ==
X-Google-Smtp-Source: ABdhPJxtfHGgD1x+0sGWQDtxJJeB9uCl6Feg/5utDqmnhP3TYYxI7kATndRbmt63ldid6mOZbKhfx/ZSXQlPvqovUXQ=
X-Received: by 2002:a05:6512:1051:: with SMTP id c17mr2908078lfb.206.1590580167403;
 Wed, 27 May 2020 04:49:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200511131350.29638-1-anders.roxell@linaro.org>
In-Reply-To: <20200511131350.29638-1-anders.roxell@linaro.org>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Wed, 27 May 2020 13:49:16 +0200
Message-ID: <CADYN=9LkA2h6dANREfPQq4iDvVEJX1wAdxjv31mpVBkaM_g0ZQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Enable as many KUnit tests as possible
To:     Brendan Higgins <brendanhiggins@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Marco Elver <elver@google.com>, David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi all,

Friendly ping: who can take this?

Cheers,
Anders

On Mon, 11 May 2020 at 15:14, Anders Roxell <anders.roxell@linaro.org> wrote:
>
> Hi,
>
> This patchset will try to enable as many KUnit test fragments as
> possible for the current .config file.
> This will make it easier for both developers that tests their specific
> feature and also for test-systems that would like to get as much as
> possible for their current .config file.
>
> I will send a separate KCSAN KUnit patch after this patchset since that
> isn't in mainline yet.
>
> Since v2:
> Fixed David's comments. KUNIT_RUN_ALL -> KUNIT_ALL_TESTS, and he
> suggested a great help text.
>
> Since v1:
> Marco commented to split up the patches, and change a "." to a ",".
>
>
> Cheers,
> Anders
>
> Anders Roxell (6):
>   kunit: Kconfig: enable a KUNIT_ALL_TESTS fragment
>   kunit: default KUNIT_* fragments to KUNIT_ALL_TESTS
>   lib: Kconfig.debug: default KUNIT_* fragments to KUNIT_ALL_TESTS
>   drivers: base: default KUNIT_* fragments to KUNIT_ALL_TESTS
>   fs: ext4: default KUNIT_* fragments to KUNIT_ALL_TESTS
>   security: apparmor: default KUNIT_* fragments to KUNIT_ALL_TESTS
>
>  drivers/base/Kconfig      |  3 ++-
>  drivers/base/test/Kconfig |  3 ++-
>  fs/ext4/Kconfig           |  3 ++-
>  lib/Kconfig.debug         |  6 ++++--
>  lib/kunit/Kconfig         | 23 ++++++++++++++++++++---
>  security/apparmor/Kconfig |  3 ++-
>  6 files changed, 32 insertions(+), 9 deletions(-)
>
> --
> 2.20.1
>
