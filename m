Return-Path: <SRS0=cN3+=7Q=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE3BC433E1
	for <linux-security-module@archiver.kernel.org>; Wed,  3 Jun 2020 01:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CBDF20663
	for <linux-security-module@archiver.kernel.org>; Wed,  3 Jun 2020 01:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591146611;
	bh=ZTQHt+zCCq3szqCcZ4aTjWGaCX3dob9j2wXUNRYrp8s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=0Qby0CNLOrBkC4tqehYpb4OQwshIoNThRXAPbIxmXYftk1BO04AbXfv9UM6XqjURJ
	 Y0MODrUtuzreoz3VIm68011Ozr191ahLyLX6ZxhO84P6aVOLSV7jNP9M3TXXZcuf/R
	 voI4QTCRTwxMiC8/dSGVORegirpz7+5a92C27lPI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbgFCBKK (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 2 Jun 2020 21:10:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:43984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgFCBKJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 2 Jun 2020 21:10:09 -0400
Subject: Re: [GIT PULL][Security] lockdown: Allow unprivileged users to see
 lockdown status
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591146609;
        bh=ZTQHt+zCCq3szqCcZ4aTjWGaCX3dob9j2wXUNRYrp8s=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=IoiZEjqqfonXQb/DIJNO+HBH4wnN8tjjFGsBdck4t7zDlHBMGaKjMSteQiuMHK5uC
         ZNAU7rdVI+4Jf1xYhNOyepyvPpcBn/+RltxEfFMscayGgRL3mP2PF054ruoJSw7KQj
         I+lX7i+d98UF3st2qjUTsHqh5ZIjrmikj3lQKyAE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <alpine.LRH.2.21.2006021212490.12446@namei.org>
References: <alpine.LRH.2.21.2006021212490.12446@namei.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <alpine.LRH.2.21.2006021212490.12446@namei.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git
 next-general
X-PR-Tracked-Commit-Id: 60cf7c5ed5f7087c4de87a7676b8c82d96fd166c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 56f2e3b7d819f4fa44857ba81aa6870f18714ea0
Message-Id: <159114660931.11472.12724747665819133584.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Jun 2020 01:10:09 +0000
To:     James Morris <jmorris@namei.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The pull request you sent on Tue, 2 Jun 2020 12:15:04 +1000 (AEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/56f2e3b7d819f4fa44857ba81aa6870f18714ea0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
