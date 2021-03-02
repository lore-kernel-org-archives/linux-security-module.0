Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CFBC433E0
	for <linux-security-module@archiver.kernel.org>; Wed,  3 Mar 2021 03:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EB5464EA4
	for <linux-security-module@archiver.kernel.org>; Wed,  3 Mar 2021 03:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbhCCCux (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 2 Mar 2021 21:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244351AbhCBS06 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 2 Mar 2021 13:26:58 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA815C061788
        for <linux-security-module@vger.kernel.org>; Tue,  2 Mar 2021 08:10:27 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id bm21so17428458ejb.4
        for <linux-security-module@vger.kernel.org>; Tue, 02 Mar 2021 08:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vJDGGYw7tvcK+titjb5UUUKjKogKFbuBWfwBQn8pnpY=;
        b=BlJkHpJ9gb2T6xH4d7E6DsfDVr0uh9W/Z84RVzgIuhv/Qy8ZfKayi3gWppMi4kMSXj
         LErYX2rZn36FwdYsyG3kZGhKii9OoE6QpO+PUmmCSk5lI0YW5riJfIK1VIJMyxoFUqoG
         379zxil7FtYzj0JPDQ2/87FgaXDypPkhU6TdwiaOl1WwN7NDqt+HBSgJOKFX9abjwpm+
         cmJg9XDLYsaLp3xMOouOx7bqSBYoOvemqiKQ9XQXF+QPWZWPgXYG8shXQT06TnlRZRY4
         x1zbduD4zPKj1TxcyaFrvvER8rnfiuu4G4X+MFT1K2gnsJTkZqi8JDtf5Sb59DPOWwEh
         pHFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vJDGGYw7tvcK+titjb5UUUKjKogKFbuBWfwBQn8pnpY=;
        b=gZ/qv0FMiMlpvkdZ5n4J81X3yHiOa2/QPNxa6nDNBQTr1t51BaZqn/1iIwlDjbxP1b
         HyCFoy+0xm69QSYrlu9KVqoq712ywaKSIz4lBmm9IOZwU4EFWG7SbykNySEd4TSpS4Nc
         PSf2ufuERrDz1BMjUSLnlYQz6oFXwl5LYj3ofAFBsRrb9hm67Rseiwd98P15sHvztkfC
         o216C5EeYcoyPIeCxf9vKh7lYFWvHzJP+QJXjRS0icXHvsM2SBsWncCqUzLYJaL3fD4o
         fLwtjaRaPnF5KCKngmthZIsQBs03Cm9aAtCnn92hYUyf86+/MTVnmDxV5A0KkrsXafSA
         WxOw==
X-Gm-Message-State: AOAM533aQnCxTs0kUgzOOYop5DQZl4qyV1rk+KjScH3GiWSsHRYwim9+
        KaVtvgrAr/9TUuk6tVP3rPg5EzcLR+vSzNb6lHyJSai/WydS
X-Google-Smtp-Source: ABdhPJx8PQFaZgOM2xUwSD8DpzvBCZqhortPrXsbuQRmYKE4KenPCbP0EoVbTKZ9wj1YIut8Zj0gMSbUKh7l4apxoGg=
X-Received: by 2002:a17:906:7056:: with SMTP id r22mr6639665ejj.106.1614701426386;
 Tue, 02 Mar 2021 08:10:26 -0800 (PST)
MIME-Version: 1.0
References: <0000000000006305c005bc8ba7f0@google.com> <CACT4Y+YFtUHzWcU3VBvxsdq-V_4hN_ZDs4riZiHPt4f0cy8ryA@mail.gmail.com>
In-Reply-To: <CACT4Y+YFtUHzWcU3VBvxsdq-V_4hN_ZDs4riZiHPt4f0cy8ryA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 2 Mar 2021 11:10:15 -0500
Message-ID: <CAHC9VhTxrGgBDW_439HeSP=_F9Jt2_cYrrQ7DtAXtKG4evGb9g@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in cipso_v4_genopt
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+9ec037722d2603a9f52e@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>, dsahern@kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Mar 2, 2021 at 6:03 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>

...

> Besides these 2 crashes, we've also seen one on a 4.19 based kernel, see below.
> Based on the reports with mismatching stacks, it looks like
> cipso_v4_genopt is doing some kind of wild pointer access (uninit
> pointer?).

Hmm, interesting.  Looking quickly at the stack dump, it appears that
the problem occurs (at least in the recent kernel) when accessing the
cipso_v4_doi.tags[] array which is embedded in the cipso_v4_doi
struct.  Based on the code in cipso_v4_genopt() it doesn't appear that
we are shooting past the end of the array/struct and the cipso_v4_doi
struct appears to be refcounted correctly in cipso_v4_doi_getdef() and
cipso_v4_doi_putdef().  I'll look at it some more today to see if
something jumps out at me, but obviously a reproducer would be very
helpful if you are able to find one.

It's also worth adding that this code really hasn't changed much in a
*long* time, not that this means it isn't broken, just that it might
also be worth looking at other odd memory bugs to see if there is
chance they are wandering around and stomping on memory ...

-- 
paul moore
www.paul-moore.com
