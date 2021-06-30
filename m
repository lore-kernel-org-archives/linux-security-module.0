Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16B9C11F66
	for <linux-security-module@archiver.kernel.org>; Wed, 30 Jun 2021 22:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A41E461492
	for <linux-security-module@archiver.kernel.org>; Wed, 30 Jun 2021 22:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbhF3Wgh (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 30 Jun 2021 18:36:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:57764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232712AbhF3Wge (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 30 Jun 2021 18:36:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 3A2406147D;
        Wed, 30 Jun 2021 22:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625092445;
        bh=e8qzDSR2h+AxI9ym7gjBOTs32Om5AQ41n4r+2ZxA4cc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VqFhKFllqPOqnWnD69xMKwDkgRx2h39NeIRAB2ob9JvovcqS+SL9MHrMhROVJUZ37
         KpWLcz3xyyXwE6dhWtCIK6zcwyWgLbN1gocCfy3RGBnevclG68W5swsCJ7gQmaZC05
         DZLO7zyYxf7UC7B3r5S6J6MczeuheP3NRYK5uTKoKKtIDXSYOEHm05/aCLb4gRNHha
         dNXJYhdaN3YtWvooBQr1rDujw1M8A7vwxZfY5G0AjFsUPXcQy7eqm1v49N743lJYsH
         F4rw2PnqTHDOSOBrC4e/pioN82ISKIlPvq5Z6ncfVD1StQSeY2gHg+BVE1S+PoDVXt
         Z1bRzZOHEW61g==
Subject: Re: [GIT PULL] Smack patches for v5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ababec69-d997-c647-4ac2-2e79dfb3aa40@schaufler-ca.com>
References: <ababec69-d997-c647-4ac2-2e79dfb3aa40.ref@schaufler-ca.com> <ababec69-d997-c647-4ac2-2e79dfb3aa40@schaufler-ca.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <ababec69-d997-c647-4ac2-2e79dfb3aa40@schaufler-ca.com>
X-PR-Tracked-Remote: https://github.com/cschaufler/smack-next tags/Smack-for-5.14
X-PR-Tracked-Commit-Id: fe6bde732be8c4711a878b11491d9a2749b03909
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5c874a5b29c264f88fafb323e8df7da7b214b6a9
Message-Id: <162509244520.2480.5526358065938351629.pr-tracker-bot@kernel.org>
Date:   Wed, 30 Jun 2021 22:34:05 +0000
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        ChenXiaoSong <chenxiaosong2@huawei.com>,
        Jens Axboe <axboe@kernel.dk>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Xiong Zhenwu <xiong.zhenwu@zte.com.cn>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The pull request you sent on Tue, 29 Jun 2021 16:40:31 -0700:

> https://github.com/cschaufler/smack-next tags/Smack-for-5.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5c874a5b29c264f88fafb323e8df7da7b214b6a9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
