Return-Path: <SRS0=y+58=VG=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E1EC606B0
	for <linux-security-module@archiver.kernel.org>; Tue,  9 Jul 2019 03:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ADC921743
	for <linux-security-module@archiver.kernel.org>; Tue,  9 Jul 2019 03:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562642109;
	bh=UD5AJS0o2Oz7QrHl8e7s76+5e1eQEf5QyFJ2MnmL0CA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=DIZjJh5b85oPTmQCuNCtXy90b3+IIGIfhJw0W51Jyk3qGBXmnNt+fWBNt65x+Yw9p
	 1nxCUzjq7oHeO2XrPKB3/9J4O7SfiODUQGItzQw3WBhu8WPwgrap5QVNkSDlK2zB8+
	 coMdWMXOrTJ9IXJM7Pq7l1RRyJsNCINCVTn8T2CM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfGIDPI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 8 Jul 2019 23:15:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:60996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726928AbfGIDPI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 8 Jul 2019 23:15:08 -0400
Subject: Re: [GIT PULL] SELinux patches for v5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562642107;
        bh=UD5AJS0o2Oz7QrHl8e7s76+5e1eQEf5QyFJ2MnmL0CA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=DWfVoGXzUVMKNBZTmBaiUGKhpSXceQelJPsoHlWhm7a7HiAqBV0vkoULqB8fyG+2P
         j1d6TtJLcBC1dRZ+iwt5cnbodvvVvquzwiZB14mY7UrO7OvlaFIqjVjfbPSvGl5z8M
         MIS8ZVmwNT7abZKl1zRnBWx6m8wbnj8OdLx5LPO4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhSERNCM2d42y8fBT236D62mco=B_ZM_vytEoBP1qicvCA@mail.gmail.com>
References: <CAHC9VhSERNCM2d42y8fBT236D62mco=B_ZM_vytEoBP1qicvCA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhSERNCM2d42y8fBT236D62mco=B_ZM_vytEoBP1qicvCA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
 tags/selinux-pr-20190702
X-PR-Tracked-Commit-Id: ea74a685ad819aeed316a9bae3d2a5bf762da82d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7c0f89634892693fc0b46f25e0a6d57bd6dd5698
Message-Id: <156264210736.2709.1861861527088813337.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Jul 2019 03:15:07 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The pull request you sent on Tue, 2 Jul 2019 13:28:37 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20190702

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7c0f89634892693fc0b46f25e0a6d57bd6dd5698

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
