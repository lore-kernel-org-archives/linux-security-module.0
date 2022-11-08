Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE21C433FE
	for <linux-security-module@archiver.kernel.org>; Tue,  8 Nov 2022 20:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiKHUs7 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 8 Nov 2022 15:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiKHUs6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 8 Nov 2022 15:48:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8508F17A87;
        Tue,  8 Nov 2022 12:48:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3EE05B81C62;
        Tue,  8 Nov 2022 20:48:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E1639C433D6;
        Tue,  8 Nov 2022 20:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667940534;
        bh=3ZRq1GS1VAJ0yvS9EZeTnGTtjfCdgqKeb//rR//qb68=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=l1x/MnjfNe6FJwJmvQ3kIsQ71rq/aCAkzhEAEyV+K+tzNR4j+aJHfAjLEciOdbE3a
         NsGfJxeu2BY7Vu/+mO5wd2vAhI54qWYtxsV5HDXCxTHr/XLF2M1DSXDyCSFIArtNfU
         M06wHAmkesT1SeSO+9cvGN6WMyRlnbwoO8fOwAip9kfPJvFqTEJasIMn8PaqmEl3et
         p+WeUDWdPdS/xyhdYDwO54W7W0j1/NhYozR1GPD2QUOFPFgB8Rq3iRt97LLDwG/eQ7
         VuFq2C+UDz19jYTddoPw4bUAQNXGuIQ1Rz3Jv2A6xDQFc7xIYmSROzeNdQfScjEzZS
         kNOMMjz7JqxWg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CBEF3C4166D;
        Tue,  8 Nov 2022 20:48:54 +0000 (UTC)
Subject: Re: [GIT PULL] LSM fixes for v6.1 (#2)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhSbLE-Uw7X9oYpqewgVWLsqBE0xeRPgwvE=0B4O6Yne_A@mail.gmail.com>
References: <CAHC9VhSbLE-Uw7X9oYpqewgVWLsqBE0xeRPgwvE=0B4O6Yne_A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhSbLE-Uw7X9oYpqewgVWLsqBE0xeRPgwvE=0B4O6Yne_A@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20221107
X-PR-Tracked-Commit-Id: 46653972e3ea64f79e7f8ae3aa41a4d3fdb70a13
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f49b2d89fb10ef5fa5fa1993f648ec5daa884bef
Message-Id: <166794053482.22160.771710189801377197.pr-tracker-bot@kernel.org>
Date:   Tue, 08 Nov 2022 20:48:54 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The pull request you sent on Mon, 7 Nov 2022 18:10:13 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20221107

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f49b2d89fb10ef5fa5fa1993f648ec5daa884bef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
