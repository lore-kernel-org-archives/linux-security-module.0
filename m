Return-Path: <SRS0=8q/C=DX=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815BEC433E7
	for <linux-security-module@archiver.kernel.org>; Fri, 16 Oct 2020 07:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08F5220848
	for <linux-security-module@archiver.kernel.org>; Fri, 16 Oct 2020 07:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lM2A1SkJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404332AbgJPHAg (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 16 Oct 2020 03:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404330AbgJPHAg (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 16 Oct 2020 03:00:36 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330B1C061755;
        Fri, 16 Oct 2020 00:00:36 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id u19so2557997ion.3;
        Fri, 16 Oct 2020 00:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jLX4tjetRKA0PHysqPRRicfLzPtIoW91Ix3UaAsDkAQ=;
        b=lM2A1SkJeHKn/589JN7Rcy6DLmtQ22uuUWp7ZKgzrST+0Ay3G5BLs68yMx8YTLxVdD
         ksoUhGKLlbAdV370+mkh2N4C42rWKHKH57UOgXNyiqCOLbX4B7vKQCLKBXJCqaj2Pd/+
         LIkp+D0Ly+DDN0UN/qg4HRlFX/A9ukomIqWLvkilCLg6jtJJOe4xbtEjPZJ3ckcu43uG
         vd+W2+2+H30W3qAZ5xFVPbFd713k1DprkJZ0dvuDKwvyMK8v9Tx9cOMUWjax6VkuDpM1
         S3oLs0l8+TEeKPbn6RroedX9CTS5yzqjMXU4hNLRQSD+uDdZMzuxS97REkO/cF3DNzvT
         4jVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jLX4tjetRKA0PHysqPRRicfLzPtIoW91Ix3UaAsDkAQ=;
        b=ndc1zJdX3PGo4fIhzw32tTbsC3crYmBbKM9oNdJPXVlDHY49bsVm6HrDg9D/+BZokS
         GbYHTrsW6OKEDD0UkR22SPjNjcGLrLwEnzmNR2lRxE2NgRWZuWxclNiVsmLNZAAthSJ6
         j+ce8J2F3zi0LRbaTJuKE0sv8LNFRmLrMQn4VSxNX04svtCIMp6++CaDCA8SNpNUGVnm
         Kdp+DNAYUbvRYuVBie0yBtKRtjyNUXea6ki5va2IfKf5XxEUoDgf6+PoK+R+JF0lpYhG
         PuUDSdImH/XKu260n1RAWnyBHgL7QYU/hFi+Q1BvCf/jmUY1V+Ywc7mVYG/VY17+TVGS
         EKig==
X-Gm-Message-State: AOAM533P2cPkDz8rP/EC78II9Po7nuMSUv4nkwi9UaK0jgWaSVCLuQS8
        Em6V13dEjHv9upASAuIpU8z2yGTSS+9VBjPOPKg=
X-Google-Smtp-Source: ABdhPJyC+ZT0LhfpxJkVNKRfWURve8qq2+TPFnG/9acZvbeoYoUUWhR0dm1V+hqHw6E97nrueuLJ/rWyk1/AOl2WuBc=
X-Received: by 2002:a5d:8487:: with SMTP id t7mr1402987iom.35.1602831635544;
 Fri, 16 Oct 2020 00:00:35 -0700 (PDT)
MIME-Version: 1.0
References: <20201015104649.2104432-1-a.nogikh@gmail.com> <20201015104649.2104432-2-a.nogikh@gmail.com>
 <20201015153009.GA26517@mail.hallyn.com>
In-Reply-To: <20201015153009.GA26517@mail.hallyn.com>
From:   Aleksandr Nogikh <a.nogikh@gmail.com>
Date:   Fri, 16 Oct 2020 10:00:25 +0300
Message-ID: <CADpXja-oWx7K4Zcsv57boUhg08-JhxzSYiVpWSNh9DfpxKTXjA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] security: add fault injection capability
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     jmorris@namei.org, akinobu.mita@gmail.com,
        Andrey Konovalov <andreyknvl@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        Aleksandr Nogikh <nogikh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, 15 Oct 2020 at 18:30, Serge E. Hallyn <serge@hallyn.com> wrote:
[...]
> seeing 'should_fail' here, kind of out of context, would be confusing to
> thousands of ppl reading the code and wondering why it should fail.  maybe
> "inject_fail_lsm_hook()" ?

Sounds reasonable, thank you for the suggestion. I'll rename this
function in v2.
