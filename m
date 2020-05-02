Return-Path: <SRS0=MZfy=6Q=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025F7C47254
	for <linux-security-module@archiver.kernel.org>; Sat,  2 May 2020 02:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D51852192A
	for <linux-security-module@archiver.kernel.org>; Sat,  2 May 2020 02:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GoAOXqYv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgEBCL3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 1 May 2020 22:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgEBCL2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 1 May 2020 22:11:28 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AC2C08E934
        for <linux-security-module@vger.kernel.org>; Fri,  1 May 2020 19:11:28 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id v8so10954618wma.0
        for <linux-security-module@vger.kernel.org>; Fri, 01 May 2020 19:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DxgeZ4dWQbsgxzC3vr4Uf0z6ga9GPtUvmnQ6rfH9mnw=;
        b=GoAOXqYvnqNaHnqw0sl6wxaUTEEROMaaJ5wtFkTK5JBEL5n2G2yvGvhs3s05djne9u
         Z0Nm572hdR8ZAqHgELOeTbhCxmoiHUC726/03InwwU0piYRV48UG/j+BM16uSqBf7VFT
         3/4Bks7Dn7b3YYiGicAkJq043PppsvbGx0CWk1jV7TbiQ2eZ698CTHttNGU9GMA+gSlD
         yy5AuwsFaLV1/DF+ulL0gMVwg0fBWYh58QliUQqii9fRHedY1IHl5AtDR8kM7dLRpvvV
         Geu2ui5FWXP3BSoTCYRcP8EFX/JKjNL7AXTEBtblQXJ+7oX2W9r8tZjBd+6ylNmZDSNY
         yEWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DxgeZ4dWQbsgxzC3vr4Uf0z6ga9GPtUvmnQ6rfH9mnw=;
        b=da1MlnW+9j39GjMo3weO9gmx1WDYIzFGH86tUzMUN3oiRAlQzsHXOgX1NozKmOcXDR
         oOSq3mDU6e//jVw0Cge3cDonHNHsKCiDLJPFZ5q9LRX/RuIu508Q7A8JhZpKznX7lzA1
         62Z9giLKpLMzkRkAogYAoBEup3KbOcakuldA0syQE58x7ml67pYEqBGawtKRJSJiD624
         gKUxN64zYUk9BMgP9sOdmRF6UX7SNTc1UtAyhNrproqKb+Ppsf46EeRog50EadiXqq8G
         12Y+qzzObr66ZQoAzOpvgARsJWCq2ROZkkWzIaHgb0YU90X7/91UNZHLrnE54/7LF8gO
         cevQ==
X-Gm-Message-State: AGi0PuY3/NE/XoPMc7PNSOWZPD0SxoEqCPKfnu0eC1Q+8GUougSrFNQN
        cpLCfHzeb0hN0buaU4xi/u3hem2YZfQvGWt+MaAz3Q==
X-Google-Smtp-Source: APiQypLDIvRbUKevZsGcEO30n6w7WQseNzEj38FrNcXYHjaeCNVPqKzvEB/q8lL2AFg/XGQTwq2/IwPCqTdYBakWPhw=
X-Received: by 2002:a1c:dd8a:: with SMTP id u132mr2195716wmg.87.1588385486740;
 Fri, 01 May 2020 19:11:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200501083510.1413-1-anders.roxell@linaro.org> <CAFd5g45C98_70Utp=QBWg_tKxaUMJ-ArQvjWbG9q6=dixfHBxw@mail.gmail.com>
In-Reply-To: <CAFd5g45C98_70Utp=QBWg_tKxaUMJ-ArQvjWbG9q6=dixfHBxw@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 2 May 2020 10:11:15 +0800
Message-ID: <CABVgOSkAAb7tyjhdqFZmyKyknaxz_sM_o3=bK6cL6Ld4wFxkRQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: Kconfig: enable a KUNIT_RUN_ALL fragment
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        Marco Elver <elver@google.com>,
        John Johansen <john.johansen@canonical.com>, jmorris@namei.org,
        serge@hallyn.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org, kasan-dev <kasan-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, May 2, 2020 at 4:31 AM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Fri, May 1, 2020 at 1:35 AM Anders Roxell <anders.roxell@linaro.org> wrote:
> >
> > Make it easier to enable all KUnit fragments.  This is needed for kernel
> > test-systems, so its easy to get all KUnit tests enabled and if new gets
> > added they will be enabled as well.  Fragments that has to be builtin
> > will be missed if CONFIG_KUNIT_RUN_ALL is set as a module.
> >
> > Adding 'if !KUNIT_RUN_ALL' so individual test can be turned of if
> > someone wants that even though KUNIT_RUN_ALL is enabled.
>
> I would LOVE IT, if you could make this work! I have been trying to
> figure out the best way to run all KUnit tests for a long time now.
>
> That being said, I am a bit skeptical that this approach will be much
> more successful than just using allyesconfig. Either way, there are
> tests coming down the pipeline that are incompatible with each other
> (the KASAN test and the KCSAN test will be incompatible). Even so,
> tests like the apparmor test require a lot of non-default
> configuration to compile. In the end, I am not sure how many tests we
> will really be able to turn on this way.
>
> Thoughts?

I think there's still some value in this which the allyesconfig option
doesn't provide. As you point out, it's not possible to have a generic
"run all tests" option due to potential conflicting dependencies, but
this does provide a way to run all tests for things enabled in the
current config. This could be really useful for downstream developers
who want a way of running all tests relevant to their config without
the overhead of running irrelevant tests (e.g., for drivers they don't
build). Using allyesconfig doesn't make that distinction.

Ultimately, we'll probably still want something which enables a
broader set of tests for upstream development: whether that's based on
this, allyesconfig, or something else entirely remains to be seen, I
think. I suspect we're going to end up with something
subsystem-specific (having a kunitconfig per subsystem, or a testing
line in MAINTAINERS or similar are ideas which have been brought up in
the past).

This is a great looking tool to have in the toolbox, though.

-- David
