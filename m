Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4811C468BF
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Mar 2021 00:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A95B64EC0
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Mar 2021 00:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbhCCX7u (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 3 Mar 2021 18:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391878AbhCCW6B (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 3 Mar 2021 17:58:01 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFDCC0613DA
        for <linux-security-module@vger.kernel.org>; Wed,  3 Mar 2021 14:55:17 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id t1so2312016eds.7
        for <linux-security-module@vger.kernel.org>; Wed, 03 Mar 2021 14:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nNfmdMd0q/KJcPW/Pt2XOjgMWmsyCvOwypPBu+510F8=;
        b=di36/4MerspWPQL3Hcu11fHLk90w33FzG8F9I72a+ih/Ph3wO5+iwcfG3gZdc1wx2K
         4N7YuZdmj3W7dzyLiBk0pBPcxPKCgtuNNqjdUtMF4o30UBYDekj6LORZa2ywnCMOPsfd
         Xtt2ySEJ4cByLi4V4gF8u7b024EixIKviB9vAHLgrKKgc1k6VSKXe5hdvHLsRMuVGuaC
         qNRJ6N1CIaBAKSXBADNi7J/xkgxQaOtxVeDmgo9S2A5KnUhlJkuQ7LLMajiy8Wu0GMLt
         iNYfAWEBtp2sPir90BDuUDCNcGnmsuv5xBlg3qazp2XfH7E1HqkWosB0ulNgTqX67JdV
         qtPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nNfmdMd0q/KJcPW/Pt2XOjgMWmsyCvOwypPBu+510F8=;
        b=fBMKxBVYfnxwEWE7V60kkehde5/V2FUGP8dYnsLIIevSuaDQOiwKtg7AHgb26Th9/D
         smmlDNU0l9cAvORLw6bXsJSHNknrgKY/zP+HPVDrWXSlRuTUXzaMXWG55/dRr9C6Jrc4
         14/+0JSEiPqsH5Bfntkv0rWllFiCNAeyTIiYByFyx3OYZIcqmJnAcG6qqvMyazEWduhQ
         ZYZngQdLOXDPE1RMMse+k/Aq2Zk2/4o8wWQXruvSqcsP/qgpp8Sw6xCVm4Dc0bqhRdYQ
         dHa++ZeXGKfhmpy1SPm8Vi4oFdFSFoxJquIdThdsmntZJV0OCIm6ZXkXXjrRtB1tZtp3
         TOeQ==
X-Gm-Message-State: AOAM532iPHyTZngTwm5+Q3s8mlq7ZZov1W7+JZiWDouQJ1IjPDVptL06
        i1raBpSivTspbkJz/1O3puxr6LxPMD4hXRz5HOTD
X-Google-Smtp-Source: ABdhPJyPKOFDLP4ZDIj9l7E7eyd/qGHvPBYKaGfRVFgSPGmbB0dG8m09mNyz2IEVAM1sB+qKVD0k1rI7v/yVQXju5D4=
X-Received: by 2002:a50:ee05:: with SMTP id g5mr1412810eds.164.1614812115906;
 Wed, 03 Mar 2021 14:55:15 -0800 (PST)
MIME-Version: 1.0
References: <000000000000f022ff05bca3d9a3@google.com> <CAHC9VhT5DJzk9MVRHJtO7kR1RVkGW+WRx8xt_xGS01H3HLm3RA@mail.gmail.com>
In-Reply-To: <CAHC9VhT5DJzk9MVRHJtO7kR1RVkGW+WRx8xt_xGS01H3HLm3RA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 3 Mar 2021 17:55:04 -0500
Message-ID: <CAHC9VhQrwHhi_ODP2zC5FrF2LvVMctp57hJ3JqmQ09Ej3nSpVg@mail.gmail.com>
Subject: Re: KASAN: use-after-free Write in cipso_v4_doi_putdef
To:     syzbot <syzbot+521772a90166b3fca21f@syzkaller.appspotmail.com>
Cc:     davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Mar 3, 2021 at 11:20 AM Paul Moore <paul@paul-moore.com> wrote:
> On Wed, Mar 3, 2021 at 10:53 AM syzbot
> <syzbot+521772a90166b3fca21f@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    7a7fd0de Merge branch 'kmap-conversion-for-5.12' of git://..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=164a74dad00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=779a2568b654c1c6
> > dashboard link: https://syzkaller.appspot.com/bug?extid=521772a90166b3fca21f
> > compiler:       Debian clang version 11.0.1-2
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+521772a90166b3fca21f@syzkaller.appspotmail.com
> >
> > ==================================================================
> > BUG: KASAN: use-after-free in instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
> > BUG: KASAN: use-after-free in atomic_fetch_sub_release include/asm-generic/atomic-instrumented.h:220 [inline]
> > BUG: KASAN: use-after-free in __refcount_sub_and_test include/linux/refcount.h:272 [inline]
> > BUG: KASAN: use-after-free in __refcount_dec_and_test include/linux/refcount.h:315 [inline]
> > BUG: KASAN: use-after-free in refcount_dec_and_test include/linux/refcount.h:333 [inline]
> > BUG: KASAN: use-after-free in cipso_v4_doi_putdef+0x2d/0x190 net/ipv4/cipso_ipv4.c:586
> > Write of size 4 at addr ffff8880179ecb18 by task syz-executor.5/20110
>
> Almost surely the same problem as the others, I'm currently chasing
> down a few remaining spots to make sure the fix I'm working on is
> correct.

I think I've now managed to convince myself that the patch I've got
here is reasonable.  I'm looping over a series of tests right now and
plan to let it continue overnight; assuming everything still looks
good in the morning I'll post it.

Thanks for your help.

-- 
paul moore
www.paul-moore.com
