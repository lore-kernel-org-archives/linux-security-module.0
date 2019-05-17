Return-Path: <SRS0=DuHk=TR=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC287C04AB4
	for <linux-security-module@archiver.kernel.org>; Fri, 17 May 2019 16:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DECD2082E
	for <linux-security-module@archiver.kernel.org>; Fri, 17 May 2019 16:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VsbWyvJh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfEQQhq (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 17 May 2019 12:37:46 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35234 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbfEQQhp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 17 May 2019 12:37:45 -0400
Received: by mail-pg1-f194.google.com with SMTP id t1so2126024pgc.2
        for <linux-security-module@vger.kernel.org>; Fri, 17 May 2019 09:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VgMR8fw/3btcfeCqUg+SAAzIGGZgPBuWMbQyEv64ZSw=;
        b=VsbWyvJhK63OLyZtQo8OaklsBhS46OZmNozcVmNGar+obQPJhvlUBVqOtwGNUSk1eg
         XQLDrD2d4ySpIj+jC/9WTu8arAVvxo1JKc+nmnC7ij3hJEvOBgk1CqWeKXnT7VCYKeoC
         VGVRU6vvl7th23Ka2qGEjSEJ0XcL1IbV/xwEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VgMR8fw/3btcfeCqUg+SAAzIGGZgPBuWMbQyEv64ZSw=;
        b=SO0ERb6cylfNLzysHFB0nx7qqnj9tSAxweMl7MXyFT+yhNtTyvfnj794HLHcttAeyo
         7vtNDALOficNMxXbZrBfXoBu4phsv6yLzqxc5OD3PC7S3EYCuZlfHKeWqcnBAZh1JZeg
         mS8x7JEumELbjofBF5tlRpHk9RT7y/3jbAeXYTjie3cLMc+9GU6Y0mEWdxEmuw2dgZ3D
         /wDZBz0R9nfrgGU74YP9/ZwYB+hn94iBEBUIdEUNNEPMPQPQBBC29c5tNQwCwGwOH9E2
         eQ65YLpE+SLX+KIYKgLYJ8owjcAhMSojux2pe95OAms/T3/pfMfcnKnWiizVQg8Z3Ie/
         bdag==
X-Gm-Message-State: APjAAAXjrpHL3cMt+kZBeABmX8AZ1GyspwmAO8uUYxUzRdgfYXuxL1ZR
        ohFMxGumWP3SOqh8qTWCuJ4l+g==
X-Google-Smtp-Source: APXvYqwFidnBAPTL+woN/ou51mJsyoX35Z9berovyuDT4vsLcTEwjuG1xg0yIHCeu2pFUSIcHbV0oQ==
X-Received: by 2002:a63:4342:: with SMTP id q63mr57175169pga.435.1558111065442;
        Fri, 17 May 2019 09:37:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s137sm15534495pfc.119.2019.05.17.09.37.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 May 2019 09:37:44 -0700 (PDT)
Date:   Fri, 17 May 2019 09:37:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sandeep Patil <sspatil@android.com>,
        Laura Abbott <labbott@redhat.com>,
        Jann Horn <jannh@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] lib: introduce test_meminit module
Message-ID: <201905170937.7A1E646F61@keescook>
References: <20190514143537.10435-1-glider@google.com>
 <20190514143537.10435-3-glider@google.com>
 <201905151752.2BD430A@keescook>
 <CAG_fn=VVZ1FBygbAeTbdo2U2d2Zga6Z7wVitkqZB0YffCKYzag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=VVZ1FBygbAeTbdo2U2d2Zga6Z7wVitkqZB0YffCKYzag@mail.gmail.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, May 17, 2019 at 05:51:17PM +0200, Alexander Potapenko wrote:
> On Thu, May 16, 2019 at 3:02 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Tue, May 14, 2019 at 04:35:35PM +0200, Alexander Potapenko wrote:
> > > Add tests for heap and pagealloc initialization.
> > > These can be used to check init_on_alloc and init_on_free implementations
> > > as well as other approaches to initialization.
> >
> > This is nice! Easy way to test the results. It might be helpful to show
> > here what to expect when loading this module:
>
> Do you want me to add the expected output to the patch description?

Yes, I think it's worth having, as a way to show people what to expect
when running the test, without having to actually enable, build, and
run it themselves.

-- 
Kees Cook
