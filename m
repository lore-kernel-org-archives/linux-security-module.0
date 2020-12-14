Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33880C4361B
	for <linux-security-module@archiver.kernel.org>; Mon, 14 Dec 2020 21:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E928C22525
	for <linux-security-module@archiver.kernel.org>; Mon, 14 Dec 2020 21:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503513AbgLNVIW (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 14 Dec 2020 16:08:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:37222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503485AbgLNU5J (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 14 Dec 2020 15:57:09 -0500
Subject: Re: [GIT PULL] tomoyo fixes for v5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607979388;
        bh=kLFFK1ZHJidGH9KCKilV9SIi7DT6yMU4JJ9b7W41MMc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=m+TaJWL+Hachl7uR0VEmlwlMB19te3H/ozzwtPbkTrbyQEQfMFVcqamf4ZXG3Oa2S
         p6jgaLKhEkPC+Qdn4rj3h8IcUORt0AYrBLH34z4+K8l5GPo4em85uei9fYb7vpwojd
         mp4nGN6Sz8Mn9dxs8367ZVM+im9GxpCRxNhp2AWhbJUWqzaIovLgBB1l+Hx0F4/PGn
         zCuJkGKSWRskRBAmpIc7+esD/Y1Bby7PZYn9sQRDQf06vVFmAf8bw8rgAlbxYvaTms
         wfQevmIrMNqcA4FXwP6U2iLotDi170m+qKiND8/2qRVf9AQLEr+mc7eqO5nrI0iRNZ
         C7+M7x2aAVyAw==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <85aa37f5-3fca-fde2-068d-b1888de51457@i-love.sakura.ne.jp>
References: <85aa37f5-3fca-fde2-068d-b1888de51457@i-love.sakura.ne.jp>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <85aa37f5-3fca-fde2-068d-b1888de51457@i-love.sakura.ne.jp>
X-PR-Tracked-Remote: git://git.osdn.net/gitroot/tomoyo/tomoyo-test1.git tags/tomoyo-pr-20201214
X-PR-Tracked-Commit-Id: 15269fb193108ba8a3774507d0bbd70949ab610d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: da0628559871475b482f015dc24c9bef372936e4
Message-Id: <160797938881.26822.11631150602977685105.pr-tracker-bot@kernel.org>
Date:   Mon, 14 Dec 2020 20:56:28 +0000
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The pull request you sent on Mon, 14 Dec 2020 13:21:46 +0900:

> git://git.osdn.net/gitroot/tomoyo/tomoyo-test1.git tags/tomoyo-pr-20201214

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/da0628559871475b482f015dc24c9bef372936e4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
