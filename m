Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE42C433ED
	for <linux-security-module@archiver.kernel.org>; Sun,  2 May 2021 02:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ED1F61450
	for <linux-security-module@archiver.kernel.org>; Sun,  2 May 2021 02:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbhEBCDs (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 1 May 2021 22:03:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:35218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231266AbhEBCDs (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 1 May 2021 22:03:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 6B0E1613CA;
        Sun,  2 May 2021 02:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619920977;
        bh=FTM5/bhIGPlSl7GVJA/Pko7LgpLiF+PNLgYJsrlgrpk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lJCYtJxHcW8cKX9IV5fuO52fjp3X+AQpjHdVhd6vaf6tbN24Y7fmO+5t6ED3dYVNj
         ueZC3w7uAT7Ticwey/pYzP4HOv53gH77hKbrRkqjIvEu0O72HND3k3rYM0w7guiewk
         Yf6DwjPkDFqyaH05JD0A5ORp6EPyfBPUyioFNrdR+T5hSpyyBU12PbZ1iV+sXL2lRv
         dt/SCz33ykVh9k+DdIyeNSsAs+CjcBoQjsQ7p+k5vTGGFP7phwhuDmJCoawYFcoRas
         0kzoE6PlQhF/v3DpPSx+aILnel8lpaeQNSbMRn57mpJ9gLVuaxkcUdZvru+tdkuopv
         tb7vm0F8x4S5Q==
Subject: Re: [GIT PULL][Security] Add new Landlock LSM
From:   pr-tracker-bot@kernel.org
In-Reply-To: <11a1adfd-d2e8-2181-81a-529792e4b6e5@namei.org>
References: <11a1adfd-d2e8-2181-81a-529792e4b6e5@namei.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <11a1adfd-d2e8-2181-81a-529792e4b6e5@namei.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git tags/landlock_v34
X-PR-Tracked-Commit-Id: 3532b0b4352ce79400b0aa68414f1a0fc422b920
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 17ae69aba89dbfa2139b7f8024b757ab3cc42f59
Message-Id: <161992097730.25025.14142306394400248363.pr-tracker-bot@kernel.org>
Date:   Sun, 02 May 2021 02:02:57 +0000
To:     James Morris <jmorris@namei.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?ISO-8859-15?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>,
        Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The pull request you sent on Wed, 28 Apr 2021 12:54:22 +1000 (AEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git tags/landlock_v34

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/17ae69aba89dbfa2139b7f8024b757ab3cc42f59

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
