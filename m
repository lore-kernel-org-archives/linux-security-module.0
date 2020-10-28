Return-Path: <SRS0=ebHT=ED=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68F1C388F7
	for <linux-security-module@archiver.kernel.org>; Wed, 28 Oct 2020 23:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C39C207E8
	for <linux-security-module@archiver.kernel.org>; Wed, 28 Oct 2020 23:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K1alOVg7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725979AbgJ1Xil (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 28 Oct 2020 19:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390565AbgJ1Xhi (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 28 Oct 2020 19:37:38 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9C6C0613CF
        for <linux-security-module@vger.kernel.org>; Wed, 28 Oct 2020 16:37:38 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b18so630902qkc.9
        for <linux-security-module@vger.kernel.org>; Wed, 28 Oct 2020 16:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a6vE6h4Lrq3PfD6ZhI4bffn/VCoz5p+kVa9GnDZBqBg=;
        b=K1alOVg7BbsaWoIzM3EPt/XFxBj6CfPzSYGObFnKmJp7VbMWXtUo2wEub9s1GDaGHk
         lxopwSHtCrI5rbwcViDOKa7z7exOSdV8ylieshQIkI490N7n3HqHk5KCpFK6JRRNHLB9
         56qGofT5bOcT1aUgH4aQIAILIIM3qjkChzQL7xSefwfbrA/5wrlPyn/zyWV6NgJcMrqq
         c4gxYGkhThcN0gedsthpRzw7BxnfOcilw1snStWwIkeoRHuF7DEzT3zEC4pNAYOnL5tg
         hRSNj6YRCY3J7n/iMsCrY78y942DN0Wi6x+DA1NUcEmjlov4n9/PkkaC+g1wFrR6A3ge
         sjJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a6vE6h4Lrq3PfD6ZhI4bffn/VCoz5p+kVa9GnDZBqBg=;
        b=N6O7tW5YjEgbxY2idgz5JEVbuEgFgbJ9vyr94qFxhx/JypblC2WcQHDprYgpxWwX18
         9DKsqp9TpahzKK2dcmHe2HHZ04GbfDt1QZJDzaEKVpKfOPLxZmVvy/OamaG7BuYROt78
         qRJ7xoSdQA1TNGtzgJIjUhmSUn239BXSkPgI9JlFTtPTc7VnuIAMwgdyiXR04RQOGjy1
         CWXx71jp/fsF3Yk8MXe9z85HsU/eBLsu0xkXiuFHI6y/qKnVmdGqWPi/eIE8Akjb1ELJ
         B+Yvs6lXxnktnjwL8zwR1kbQPppAgQ+wOzSyDmvuiTrtVWoga9b5xaioIHU/PDSxlMc1
         gKvA==
X-Gm-Message-State: AOAM532uYkRxJLMbMLh0LCQx0mhKagmCnPvdz3ik+IyCV25BA/5sy9XO
        HRmo17jaKHT9Mip8/XpqU1FYBcr765OTzktEmHzIfrMSBvVFAw==
X-Google-Smtp-Source: ABdhPJzGlSt5aAv1ZLGB7xNjiUUvxmmxT2DKA0N0WRSAio1BCjdgbKuaIweZa1+5o4vyE+PoaK/loQrgkpTt4gNbQmg=
X-Received: by 2002:ac8:6c54:: with SMTP id z20mr5877605qtu.337.1603878075857;
 Wed, 28 Oct 2020 02:41:15 -0700 (PDT)
MIME-Version: 1.0
References: <20201026125227.54520-1-a.nogikh@gmail.com> <20201026125227.54520-3-a.nogikh@gmail.com>
 <CAC5umyjZn+gtO=u8GhptVggzodbY-vnk9NNTOqyZyUW2up2ASQ@mail.gmail.com> <CANp29Y7sDaxrw+0wEVU0vo56AhKFRvbQSGeRc168gs6S8iK_-g@mail.gmail.com>
In-Reply-To: <CANp29Y7sDaxrw+0wEVU0vo56AhKFRvbQSGeRc168gs6S8iK_-g@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 28 Oct 2020 10:41:04 +0100
Message-ID: <CACT4Y+ZX=FjO0Ohoxnyjb3RqaTdGDpYs-Z4pJyiTo2TYY_ROqQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/2] docs: add fail_lsm_hooks info to fault-injection.rst
To:     Aleksandr Nogikh <nogikh@google.com>
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Aleksandr Nogikh <a.nogikh@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Oct 27, 2020 at 6:34 PM Aleksandr Nogikh <nogikh@google.com> wrote:
> [...]
> > In addition to this global one, what do you think about per-hook fault
> > injection,
> > i.e. /sys/kernel/debug/fail_lsm_hooks/<FUNC>/retval ?
>
> I was thinking about this, but decided to begin with a simple version
> that could definitely be useful in practice (for syzbot/syzkaller it is just
> necessary to have a fault injection capability that will be triggered via
> fail-nth). If per-hook fault injection can also be useful to someone, I
> can try to add it as well.

Yes, before we add it, it would be useful to have a clear use case
(otherwise we can add an unused thing, or implement it in a way that
slightly misses the use case).
Note that fail-nth allows to fail a single concrete site for testing,
though it's not super convenient for this as one would need to figure
out the right N first. But as a one-off test it should do.


> > In this case, we need a fault_attr for each hook. (Maybe, we can use the same
> > technique that is used to define security_hook_heads).
>
> Yes, that technique should help to implement the feature in a very concise
> way. Thanks for the suggestion.
