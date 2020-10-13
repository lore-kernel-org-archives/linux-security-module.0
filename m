Return-Path: <SRS0=uW8r=DU=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FE7C35269
	for <linux-security-module@archiver.kernel.org>; Tue, 13 Oct 2020 23:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3313421D7B
	for <linux-security-module@archiver.kernel.org>; Tue, 13 Oct 2020 23:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602633208;
	bh=robIOznjhws5yrbwysRtTJAc7dN5cL986q3XIlHzI5c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=vFthkoc4baX0kpb5vCH5p18Xav8NiULc2vO/uvgkB6gvteKIEWpUJFgzA8YzQFI8E
	 zCDwFRe9qHiZE8/VJJOahhMxqYEVVvM0pjXMXEw/RG4N/gV3kmTQe2BEI9UwVpzluM
	 yetIyzNC7dUk8fVlcy5JGdfKgeVkA21IoGc622qY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgJMXx1 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 13 Oct 2020 19:53:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:32870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729950AbgJMXtO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 13 Oct 2020 19:49:14 -0400
Subject: Re: [GIT PULL] Smack patches for v5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602632954;
        bh=robIOznjhws5yrbwysRtTJAc7dN5cL986q3XIlHzI5c=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=tV/fEOm9U/MbiLJ9XHTRGUZXGp6wNg9WHxbVDbBcm9JvA/Ce+s5Gd2TSY4I1xf0x5
         ziMgwJ6P4x4fqvd4UqR9b0PwozfKIu+MdIEwfojwTtkwHjFnZBIkWPJD+E6hhTv+bo
         k7HgXIvi1JOc82o0ZrOzG4Rtj2A8EroKWQdMNPns=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <efb97951-c946-8511-a6c3-b8aa340ebf8f@schaufler-ca.com>
References: <efb97951-c946-8511-a6c3-b8aa340ebf8f.ref@schaufler-ca.com> <efb97951-c946-8511-a6c3-b8aa340ebf8f@schaufler-ca.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <efb97951-c946-8511-a6c3-b8aa340ebf8f@schaufler-ca.com>
X-PR-Tracked-Remote: https://github.com/cschaufler/smack-next tags/Smack-for-5.10
X-PR-Tracked-Commit-Id: edd615371b668404d06699c04f5f90c4f438814a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 99a6740f88e9438cd220096d3d96eb6ba8d5c6f0
Message-Id: <160263295401.20088.2867586814685847355.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Oct 2020 23:49:14 +0000
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The pull request you sent on Mon, 12 Oct 2020 11:13:01 -0700:

> https://github.com/cschaufler/smack-next tags/Smack-for-5.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/99a6740f88e9438cd220096d3d96eb6ba8d5c6f0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
