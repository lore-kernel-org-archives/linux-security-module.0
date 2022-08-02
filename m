Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60028C00140
	for <linux-security-module@archiver.kernel.org>; Tue,  2 Aug 2022 22:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237129AbiHBW3q (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 2 Aug 2022 18:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236874AbiHBW3f (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 2 Aug 2022 18:29:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439E95509B
        for <linux-security-module@vger.kernel.org>; Tue,  2 Aug 2022 15:29:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C070CB81F38
        for <linux-security-module@vger.kernel.org>; Tue,  2 Aug 2022 22:29:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 640C2C433C1;
        Tue,  2 Aug 2022 22:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659479370;
        bh=KGsB+dO+87Pz0dNtx11WxMiqsjRwknV3YYjT6QUEu/E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=YfXGnxO2ykNwt77FTPynltGMj1LaE9rZKqkzcCu6UJaWYDIKfDYAIGZUfgh0U6p2Z
         8s+x2Tp+SiFXdaKFBDbCB6ey4LWqabgt79U+jWdWsvuGxR6oZxMRYuO2I24fy5Z7Xz
         /zjodAfqCeuXydszz4GFzjIKpmSSNFwVz4vB17ULJRknMwVTtZz6BhHbVLPTDr3JZv
         RXAVyysLIKZMVZdC78uE8VzmIpFad4KeLsR8jMXLg7XkEsrn9mJ9iPCUmsL/iDAxKD
         wEWJgvvmiviltSXvFvAxOgRz/moCik4I34+eCQI6pqKSThuHzLoVGsmoxBOaaSCwYy
         vBztoeP2jiAJA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 540B4C43142;
        Tue,  2 Aug 2022 22:29:30 +0000 (UTC)
Subject: Re: [GIT PULL] LSM patches for v6.0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhRS+4oUSeThUghGt7wYuEG3ro1kP5zbxz0DeERz1wDK_Q@mail.gmail.com>
References: <CAHC9VhRS+4oUSeThUghGt7wYuEG3ro1kP5zbxz0DeERz1wDK_Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhRS+4oUSeThUghGt7wYuEG3ro1kP5zbxz0DeERz1wDK_Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20220801
X-PR-Tracked-Commit-Id: ed56f4b5173efba00e3dcd736c18bce43255cf7a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1b6cf909647e64617958e6799c6e5bae413c7d0e
Message-Id: <165947937033.5634.10865360146383392669.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Aug 2022 22:29:30 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        James Morris <jmorris@namei.org>,
        James Morris <jamorris@linux.microsoft.com>,
        linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The pull request you sent on Mon, 1 Aug 2022 15:57:26 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20220801

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1b6cf909647e64617958e6799c6e5bae413c7d0e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
