Return-Path: <SRS0=lUlZ=7R=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244D9C433E0
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Jun 2020 17:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0735D20897
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Jun 2020 17:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591292112;
	bh=CBelD9E3n1Uw8g07+kLe/ZsPxXXQ8+K/HGUPGCDgvEg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=OEbN46bNlAZlAd1nyzYgiMZIrtpSKK+ukUkji786imkW5dRDSgGG88vcbdhS7bA7o
	 n/moUIVGujGmWdN0Yjv+WhuMDyUVPjfaMwxUDfwGtIwoXuxPwnzZ1Zd1bCn9HuuB5S
	 KW2QH81gRY3zLBEzMF3YVWLT50D52bCcPhoVVxEs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730297AbgFDRfL (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 4 Jun 2020 13:35:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:46238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729998AbgFDRfJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 4 Jun 2020 13:35:09 -0400
Subject: Re: [GIT PULL] Smack patches for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591292109;
        bh=CBelD9E3n1Uw8g07+kLe/ZsPxXXQ8+K/HGUPGCDgvEg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=yMRVgMsl/xos9nOC2e1YjTzaeKsLuTgnOSbk2pFsTTsc4+hQ9BxK4ow9vailnSVC+
         TTHcGG2y/wSrj6bijGj1EOJ2d2hDTabwIQVS0WKOnaJLaUCCeED47JQLSIgyzGyWET
         lRA3/v6AZ0yl+Ozo26izmK8955SUE2zZaJifXh20=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <02d3f22f-340b-d51b-6dd5-c2011651a145@schaufler-ca.com>
References: <02d3f22f-340b-d51b-6dd5-c2011651a145.ref@schaufler-ca.com>
 <02d3f22f-340b-d51b-6dd5-c2011651a145@schaufler-ca.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <02d3f22f-340b-d51b-6dd5-c2011651a145@schaufler-ca.com>
X-PR-Tracked-Remote: https://github.com/cschaufler/smack-next
 tags/Smack-for-5.8
X-PR-Tracked-Commit-Id: ef26650a201fbbb4ba90b63a82bf7950f2699a82
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: acf25aa66371359f542d14e8d993b530fe25d7ac
Message-Id: <159129210947.22790.2316140173855199853.pr-tracker-bot@kernel.org>
Date:   Thu, 04 Jun 2020 17:35:09 +0000
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Maninder Singh <maninder1.s@samsung.com>,
        YueHaibing <yuehaibing@huawei.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The pull request you sent on Tue, 2 Jun 2020 13:38:04 -0700:

> https://github.com/cschaufler/smack-next tags/Smack-for-5.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/acf25aa66371359f542d14e8d993b530fe25d7ac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
