Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560FFC43381
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Feb 2021 01:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F70C64F09
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Feb 2021 01:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbhBVBVf (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 21 Feb 2021 20:21:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:54840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230186AbhBVBVc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 21 Feb 2021 20:21:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id E015C64ED6;
        Mon, 22 Feb 2021 01:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613956851;
        bh=GHzQgAZYqyh+zIBNuWaiu+W+uV9SXp/fN01OGtvmryQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=u/iuagqLphNQLM05hdL4UMK7jQ1tD03l7EBjaHEoqtHRfPgTRfb1+KlV5GZp27xqt
         JrtAhS5oBQQAKF0IF8uExMwO4PjQIxOLhfN/Atm+mIgtR54IlDFsFLvrOON4UQW+HR
         JIhdPjZAoDVU4dx+RUoN5bOwGjw0r6IpG90m7+gAuW9fBvuBg5GXGxmr86l1+1GcAO
         dz3wrDccSEcnY1IRPfE02Wylt1w66cGnw+xOXZcNhhHr/vKMyQY49fmmRagcVegSH+
         GG12CxFGRHk8ybVZjrsKuMwsu2rWuDUGjuL0HZ69TJlgPJsey1ZJMDbbzJ+i+Tkgx3
         6W/pqFMslv6Cg==
Subject: Re: [GIT PULL] Smack patches for v5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <7fc1be79-b611-24e9-f2fb-282dd061d755@schaufler-ca.com>
References: <7fc1be79-b611-24e9-f2fb-282dd061d755.ref@schaufler-ca.com> <7fc1be79-b611-24e9-f2fb-282dd061d755@schaufler-ca.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <7fc1be79-b611-24e9-f2fb-282dd061d755@schaufler-ca.com>
X-PR-Tracked-Remote: https://github.com/cschaufler/smack-next tags/Smack-for-v5.12
X-PR-Tracked-Commit-Id: 7ef4c19d245f3dc233fd4be5acea436edd1d83d8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 92ae63c07b8fba40f960c7286403bbdc90e46655
Message-Id: <161395685188.836.16504244911447964533.pr-tracker-bot@kernel.org>
Date:   Mon, 22 Feb 2021 01:20:51 +0000
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The pull request you sent on Tue, 16 Feb 2021 14:06:51 -0800:

> https://github.com/cschaufler/smack-next tags/Smack-for-v5.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/92ae63c07b8fba40f960c7286403bbdc90e46655

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
