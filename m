Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058ABC433ED
	for <linux-security-module@archiver.kernel.org>; Wed, 28 Apr 2021 02:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9F9B60FF1
	for <linux-security-module@archiver.kernel.org>; Wed, 28 Apr 2021 02:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235839AbhD1Co2 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 27 Apr 2021 22:44:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:40480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235422AbhD1Co1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 27 Apr 2021 22:44:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 94EF2613BF;
        Wed, 28 Apr 2021 02:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619577823;
        bh=sHYjtFfEQNiXpCeTMcprDBstLSJOrWLBqhGEntxJohw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XnwOiJxnNMZgYF789KQ8ngoNCJuuhcDrZ1MPOQ6vjMB5mlHjMZc1RKA/m6pw29+P+
         nwK/V07VFUh+Oh1M53SYsnjw14Xht1OjURGfdSPV+j/VjypfxpsEsi7UOaOkod8X4i
         1E7OnomCRIF61+bro6iDW4S9FvPgHDF9sBHV7UOIsraZ+cNpdVD5xyGStb/Y5Sk0KW
         voq2zexyx7F3PvNbRIYddTTPIOJIwK5sNuuRPQ9ZQBPVARUjKXIDyTVFgm6W6XJtty
         VQgrup2jeLKpTtwHBdYgLzp2uR3zVA+radnoH+y3cjXDVPaxPHha31/JqGrOLBIJRX
         djK5lL8jZigSQ==
Subject: Re: [GIT PULL][Security Subsystem] Fixes for v5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <bed5f880-9651-5ee1-c3c2-713c1ac194f0@namei.org>
References: <bed5f880-9651-5ee1-c3c2-713c1ac194f0@namei.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <bed5f880-9651-5ee1-c3c2-713c1ac194f0@namei.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git tags/fixes-v5.13
X-PR-Tracked-Commit-Id: 049ae601f3fb3d5b1c1efdb434499770c96237f6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: acd3d28594536e9096c1ea76c5867d8a68babef6
Message-Id: <161957782350.6484.6716461834501073563.pr-tracker-bot@kernel.org>
Date:   Wed, 28 Apr 2021 02:43:43 +0000
To:     James Morris <jmorris@namei.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The pull request you sent on Wed, 28 Apr 2021 09:16:37 +1000 (AEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git tags/fixes-v5.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/acd3d28594536e9096c1ea76c5867d8a68babef6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
