Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729D6C43217
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Oct 2022 18:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiJDSTH (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 4 Oct 2022 14:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiJDSTC (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 4 Oct 2022 14:19:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA912716D;
        Tue,  4 Oct 2022 11:19:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ECA75B81B5D;
        Tue,  4 Oct 2022 18:18:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A1C91C433D7;
        Tue,  4 Oct 2022 18:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664907538;
        bh=AIrUoDqg/M9+tdmX5ufBdihZXWm/+zf2ByElhwq5NDE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mE0c5ZwS6nRD64EennuevaW3U1NvrFa1/KhgtLsv6NwoTL9WxAMepL/1NmqV7sgDx
         q8GKC14x7UoCiL8EWDvvi13ibjEMC0ghgq1zKUmvzf0DfBosNg7u+cNKmI1gsdHnbk
         2zs/yZe8CE8Fq3ctozOiW1pFiH2CyzbTkKlRiO85sUDCgHX1qfzn3mEQzNYRLZQ2p9
         HPTNfR1tS+FwBPzoni+xBzn72aiWnAMX5u+d5+Fm2e4qhiNqkYoK7JXWbGRxnDtVRg
         Z/Fl+Yyzse6aUkk18Rdk5y6YibEo/3VtgJJuvqhv/hYZyp92thuY5y5zHOEi6G3yNF
         p8kL0I8O0OCVA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 90903E21ED6;
        Tue,  4 Oct 2022 18:18:58 +0000 (UTC)
Subject: Re: [GIT PULL] Landlock updates for v6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221004171414.974585-1-mic@digikod.net>
References: <20221004171414.974585-1-mic@digikod.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221004171414.974585-1-mic@digikod.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.1-rc1
X-PR-Tracked-Commit-Id: 2fff00c81d4c37a037cf704d2d219fbcb45aea3c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 522667b24f08009591c90e75bfe2ffb67f555498
Message-Id: <166490753858.15936.847758454163279583.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Oct 2022 18:18:58 +0000
To:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The pull request you sent on Tue,  4 Oct 2022 19:14:14 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/522667b24f08009591c90e75bfe2ffb67f555498

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
