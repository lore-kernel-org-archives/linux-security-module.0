Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A38FC15504
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Mar 2021 00:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BA8B64EC0
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Mar 2021 00:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbhCCX7t (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 3 Mar 2021 18:59:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237296AbhCCQWd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 3 Mar 2021 11:22:33 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A353C061760
        for <linux-security-module@vger.kernel.org>; Wed,  3 Mar 2021 08:20:58 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id l12so30731542edt.3
        for <linux-security-module@vger.kernel.org>; Wed, 03 Mar 2021 08:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7oMQzTqAOm2hnQffsTaCOfeTj0G+JUHHCY8d/eydSSY=;
        b=z/W60i9vbwd/cA3kpfvw5073LOzVMbCldbbkRoUuapoRS/tBfyqr/PwXedDrSIthHc
         b4Da17NVABWXlzLU71V4fhM4bcApBUhA0cerpZkRraT8hlzq7dnNVL86rhn35IDDZvM7
         uwM59m8FyOpgHu6PU5eqTaaDRqPmhB76X3lEpicTWV7U+eq/pbKrRiYHWGHKO4caPvGj
         L0q5RpCNgRmvkIbcZcBQeBcp8VPh2yWtGyOypXdVnfXLNs1Vu5q5yrrgyWkv5NmqK2y2
         OSWEKg+WfcidFJ2uLdGucUQw+T3RgWPffmT3AzspSOHQugsHCPrq3A1UjHAp7hQqz2CL
         1OHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7oMQzTqAOm2hnQffsTaCOfeTj0G+JUHHCY8d/eydSSY=;
        b=qUtRmvoJOqLV/wx8KhCtffEZtWZtLRmSW3jUT2KSYDn8bR7BlY6V7EDQj1OX0qkM1w
         1LK4U6IeuByFCUfgFhLpvmpeVJ4Hxrt7Mgj39MmhoiWYw0TctDe4CuAPVzdZc11AvUTm
         7f/cCKDKoRuaR/0tOcxOzFus8fVkvUOuefODRF4WjXEVO7BNyEXQdt+PI9CgYve8S5Vn
         u0acVZu2M8Ds1ig6H7a6xTqFq3XlgWwiCQFe3x9D8Nidffp6g50sjBbLb3gSwL+3wNMX
         ZLWG3uxc3G/ojbmzGQ4+rgB2C5nKAfGkjKr4jyd3awtQwN8aw0QZo2KM7zVxHzBmtMk4
         Btfw==
X-Gm-Message-State: AOAM533dqeh+ftNYbBn+x6EStwUsUZg1r7Qdr+SiJN0BA6rm0kRPWbDD
        S3k4LJp+wvmwmHRSuRuUJFoDxU7RUxR/cgmUXbg5
X-Google-Smtp-Source: ABdhPJzU43PvP/dKWjNdyFxXOAyjlNYOQrGgrKdkykxmaK2LCh0f1pMajRbc0LraMTOAnpzVkoO04VSwZUj38qXEBas=
X-Received: by 2002:aa7:db4f:: with SMTP id n15mr77541edt.12.1614788457018;
 Wed, 03 Mar 2021 08:20:57 -0800 (PST)
MIME-Version: 1.0
References: <000000000000f022ff05bca3d9a3@google.com>
In-Reply-To: <000000000000f022ff05bca3d9a3@google.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 3 Mar 2021 11:20:45 -0500
Message-ID: <CAHC9VhT5DJzk9MVRHJtO7kR1RVkGW+WRx8xt_xGS01H3HLm3RA@mail.gmail.com>
Subject: Re: KASAN: use-after-free Write in cipso_v4_doi_putdef
To:     syzbot <syzbot+521772a90166b3fca21f@syzkaller.appspotmail.com>
Cc:     davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Mar 3, 2021 at 10:53 AM syzbot
<syzbot+521772a90166b3fca21f@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    7a7fd0de Merge branch 'kmap-conversion-for-5.12' of git://..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=164a74dad00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=779a2568b654c1c6
> dashboard link: https://syzkaller.appspot.com/bug?extid=521772a90166b3fca21f
> compiler:       Debian clang version 11.0.1-2
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+521772a90166b3fca21f@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KASAN: use-after-free in instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
> BUG: KASAN: use-after-free in atomic_fetch_sub_release include/asm-generic/atomic-instrumented.h:220 [inline]
> BUG: KASAN: use-after-free in __refcount_sub_and_test include/linux/refcount.h:272 [inline]
> BUG: KASAN: use-after-free in __refcount_dec_and_test include/linux/refcount.h:315 [inline]
> BUG: KASAN: use-after-free in refcount_dec_and_test include/linux/refcount.h:333 [inline]
> BUG: KASAN: use-after-free in cipso_v4_doi_putdef+0x2d/0x190 net/ipv4/cipso_ipv4.c:586
> Write of size 4 at addr ffff8880179ecb18 by task syz-executor.5/20110

Almost surely the same problem as the others, I'm currently chasing
down a few remaining spots to make sure the fix I'm working on is
correct.

-- 
paul moore
www.paul-moore.com
