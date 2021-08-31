Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D9EC4320E
	for <linux-security-module@archiver.kernel.org>; Tue, 31 Aug 2021 20:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27ADB610A1
	for <linux-security-module@archiver.kernel.org>; Tue, 31 Aug 2021 20:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238068AbhHaUHd (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 31 Aug 2021 16:07:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:40336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234644AbhHaUHc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 31 Aug 2021 16:07:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 2583D61090;
        Tue, 31 Aug 2021 20:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630440397;
        bh=FsiV2TIEKY8AjegL1FyQcE6DAj9tM1hrR/FqtmPZywQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bgO/KEdZpdH7LMX5Vh69lnKewcgRm9DZ9+0LSNSZ/Eb3pKoRyVWYNPAWcAwp3Gefi
         6aUqsiN3iTlzwPeoAG9kizDVvosyIXNFrYNJ1CG4J+RyYBOJ/9b5cp6DLNa5eaRPtI
         uJu0BKmDEvbeFNGLdHJk+DXHzred3ZfrDed51mKbYoZAUxT9q1fZPHGP8EsIrlv94/
         9+7cFlUmsTM+/Rh7viFwbF9ky4G1rFAINmW806m8BvM5eyQ4W4G5w9NGjZ7MOhJaNN
         caDt4mHd66UCsIPO+P0eUdWaqcY0i4XlUNh1BRhRM3Rs0Dy9aPqf2H2Slq6AZ+e7JG
         jPQcJ71FAR/lQ==
Subject: Re: [GIT PULL] Smack patches for v5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ff60d9aa-28b9-9c6d-f318-94dd51a95abd@schaufler-ca.com>
References: <ff60d9aa-28b9-9c6d-f318-94dd51a95abd.ref@schaufler-ca.com> <ff60d9aa-28b9-9c6d-f318-94dd51a95abd@schaufler-ca.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ff60d9aa-28b9-9c6d-f318-94dd51a95abd@schaufler-ca.com>
X-PR-Tracked-Remote: https://github.com/cschaufler/smack-next tags/Smack-for-5.15
X-PR-Tracked-Commit-Id: bfc3cac0c76126995737f1b858d2cdb476be5b1d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9b2eacd8f04625c6cb2dd82469972a3bba3a783a
Message-Id: <163044039712.15638.7972995060301060275.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Aug 2021 20:06:37 +0000
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Austin Kim <austindh.kim@gmail.com>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The pull request you sent on Tue, 31 Aug 2021 11:53:12 -0700:

> https://github.com/cschaufler/smack-next tags/Smack-for-5.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9b2eacd8f04625c6cb2dd82469972a3bba3a783a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
