Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1991BC0018C
	for <linux-security-module@archiver.kernel.org>; Wed, 16 Dec 2020 19:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5E562311F
	for <linux-security-module@archiver.kernel.org>; Wed, 16 Dec 2020 19:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbgLPTpg (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 16 Dec 2020 14:45:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:59160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbgLPTpf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 16 Dec 2020 14:45:35 -0500
Subject: Re: [GIT PULL] Smack patches for v5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608147895;
        bh=mVyWZxsjm+HNnAuVLATXz+GwSsxZ3qZHdKXgvD1ygjA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=rwC+SdofeTt/6FyhPM+1Pr+FUcO+6/5RLyc8iYZCLhaws2C8jE9h3HymD/mmNgD9Y
         olTgjJ36fAfIoG88atjDXt5HPlC3Od5l1O7GKGfJ+9VDnSYoztDVUw3JpCjKpuGkXS
         6oYFnT0vauRb2GLYus0PJIqBn8Yzk/+RCrFomRjFOAT+lMPMItkY8Y/MfKxGrZnr1t
         Aue/YdCAOifwUOyiwaX/T5N6OGLk5YHYcSMrjZHiSeaee/5RXDMXVxYwMYLXG6wylR
         p64aFZe/bKIHQVxa9jRKUQxkLbNTleTyESNVTMD0I2A2HlQfjWGKLddK2EzHVNg6Uv
         uCtAA1s1yiGqg==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <7bb1c722-0a4f-2799-6421-5c3741e7c106@schaufler-ca.com>
References: <7bb1c722-0a4f-2799-6421-5c3741e7c106.ref@schaufler-ca.com> <7bb1c722-0a4f-2799-6421-5c3741e7c106@schaufler-ca.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <7bb1c722-0a4f-2799-6421-5c3741e7c106@schaufler-ca.com>
X-PR-Tracked-Remote: https://github.com/cschaufler/smack-next tags/Smack-for-5.11
X-PR-Tracked-Commit-Id: 9b0072e2b2b588ad75c94f2c6e6c52c8f4bd2657
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8bda68d68b21cb9881dcc7159fd9db1b6f95ac15
Message-Id: <160814789495.14944.8509071490382248333.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Dec 2020 19:44:54 +0000
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        lkML <linux-kernel@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The pull request you sent on Tue, 15 Dec 2020 11:02:53 -0800:

> https://github.com/cschaufler/smack-next tags/Smack-for-5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8bda68d68b21cb9881dcc7159fd9db1b6f95ac15

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
