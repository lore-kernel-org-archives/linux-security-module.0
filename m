Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5540C433EF
	for <linux-security-module@archiver.kernel.org>; Tue,  2 Nov 2021 00:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 908436052B
	for <linux-security-module@archiver.kernel.org>; Tue,  2 Nov 2021 00:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbhKBAxp (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 1 Nov 2021 20:53:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:49014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232110AbhKBAxn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 1 Nov 2021 20:53:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 3419D610A2;
        Tue,  2 Nov 2021 00:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635814269;
        bh=iyikkkz2A2r7CSvjVAiKuF/JkR9kzyfN9m+fGUf6/kI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=V3gqdICELSTQkC4Xvd2y2svQkNkp1+IKZ0lVutzG6fU1JQCRXW/eiHrEBvx/iuyT5
         l/yEcNeJKTr8s14sT943arOlY3AoOV52dhRgLvpYxIDppNjPqnY3rWG5zfTsyJHPNP
         t8GZ43Lz5Mpv3j1WF6GF4CUqVoZoDTbCi2beh28jvRwxqANMgQbM9mPCxqPDikup37
         wHAJ8PTpuiVz6DYFTnzSqWxz3JvNNyhdhhPPh/GFFJY7cXMGpLvRU0ycB2hD7YSA4c
         h6vPwSllr57An4ef/iCcndtuNhDxOtMeUVy/xYkv4wMrPyoo57Ati8JeGgUXpaHTB8
         gpH1fKN7arprw==
Subject: Re: [GIT PULL] Smack patches for v5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <b3e4f10f-b065-68fc-957d-92c65a5c7193@schaufler-ca.com>
References: <f34e40a9-e4ba-ce9f-fdf8-1faaf73c69d2.ref@schaufler-ca.com> <b3e4f10f-b065-68fc-957d-92c65a5c7193@schaufler-ca.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <b3e4f10f-b065-68fc-957d-92c65a5c7193@schaufler-ca.com>
X-PR-Tracked-Remote: https://github.com/cschaufler/smack-next tags/Smack-for-5.16
X-PR-Tracked-Commit-Id: 0934ad42bb2c5df90a1b9de690f93de735b622fe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6f2b76a4a384e05ac8d3349831f29dff5de1e1e2
Message-Id: <163581426917.14115.5005306427550289866.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Nov 2021 00:51:09 +0000
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     torvalds@linux-foundation.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Florian Westphal <fw@strlen.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        casey@schaufler-ca.com
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The pull request you sent on Mon, 1 Nov 2021 15:46:54 -0700:

> https://github.com/cschaufler/smack-next tags/Smack-for-5.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6f2b76a4a384e05ac8d3349831f29dff5de1e1e2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
