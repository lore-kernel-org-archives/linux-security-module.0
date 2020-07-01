Return-Path: <SRS0=4lEG=AM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99640C433E0
	for <linux-security-module@archiver.kernel.org>; Wed,  1 Jul 2020 19:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77F6B2085B
	for <linux-security-module@archiver.kernel.org>; Wed,  1 Jul 2020 19:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593630611;
	bh=jLKz4rsOoFVw3/fsyO/V0r6Y1EZZJYT66gFiotM3VHY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=U6+lYHq5jOM0rAVN7l2d6D+JS9LGYQ3scDWzGDta6fptblbYMNy7BbS4V4LIUMAsA
	 p2NkaqU7gsG0AKLggEIABKBQdmlDDYQ7AYhgD6W1VPGsY0PICBPltAmoSFt4sZLCq4
	 Xv94p0eKAAf2CFtBHBPZxei/nkgIcG6xIP9eNqes=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgGATKL (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 1 Jul 2020 15:10:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:34726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725915AbgGATKK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 1 Jul 2020 15:10:10 -0400
Subject: Re: [GIT PULL] Security subsystem fixes for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593630610;
        bh=jLKz4rsOoFVw3/fsyO/V0r6Y1EZZJYT66gFiotM3VHY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ilQQJVGNgNK1FU6sAexneXWzBcUlg59aUZfEhG1Kdi+ixkbNfN36BrIhodsen29Vc
         fCpWY/BCzmC2AQsTSIRXPv2rIWnSVwRUTAx7yf8G/ZQbbK6Uxe+lXe3Kqkg8weAg6Q
         VH3yPAcoyhXuGb5CE4Wt7d/2ToEpS3W5RmHFIzrQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <alpine.LRH.2.21.2006300659080.10756@namei.org>
References: <alpine.LRH.2.21.2006300659080.10756@namei.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <alpine.LRH.2.21.2006300659080.10756@namei.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git
 tags/fixes-v5.8-rc3-a
X-PR-Tracked-Commit-Id: 23e390cdbe6f85827a43d38f9288dcd3066fa376
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 615bc218d628d90a3afebcfa772aa41865acd301
Message-Id: <159363061030.32760.2449826778122735864.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Jul 2020 19:10:10 +0000
To:     James Morris <jmorris@namei.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The pull request you sent on Tue, 30 Jun 2020 07:00:03 +1000 (AEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git tags/fixes-v5.8-rc3-a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/615bc218d628d90a3afebcfa772aa41865acd301

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
