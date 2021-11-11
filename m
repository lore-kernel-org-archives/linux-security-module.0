Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43145C433F5
	for <linux-security-module@archiver.kernel.org>; Thu, 11 Nov 2021 23:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B71C61179
	for <linux-security-module@archiver.kernel.org>; Thu, 11 Nov 2021 23:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbhKKXMP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 11 Nov 2021 18:12:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:37058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234524AbhKKXMI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 11 Nov 2021 18:12:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 1C77061179;
        Thu, 11 Nov 2021 23:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636672159;
        bh=Xm5ZLkxbi8t6dvqYpz1O+nCNi3Gh1zo2srZF/JYZC+E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kjWHGYLa0KOwvZmxHHZl+sxbflHC+FvU1UrlrJI12Ou1Qe2i/CDdhr9TcGcwMJ1IE
         u3dKGU/PTV2NTdQV0Shb9cEPnHBk3/POdPpHLZe17k1kkj46lIlaWjO0yMn72BXi98
         dJZlPq7n0Pr5JezdJxW1kGynBse5xWvY/TtoaVXngW2FsOqnf3LIBbgIIguz+tVixk
         FKLQyY5ZHRpsm26JdMC+SwfanBSurT1jVdJodC6rhsAqqYPGPLkm/fRH/3f4jUjK4F
         mi6CHP4MeouublRLvKCgVCI78ZF4KG9tlCfjMWLdEXN9JSuONYp6Jh7+mRPfvN5TyR
         fY4liK4UV/5OQ==
Subject: Re: [GIT PULL] apparmor changes for 5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <92f2d63e-02ac-0990-672d-43a646c2c42a@canonical.com>
References: <92f2d63e-02ac-0990-672d-43a646c2c42a@canonical.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <92f2d63e-02ac-0990-672d-43a646c2c42a@canonical.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/apparmor-pr-2021-11-10
X-PR-Tracked-Commit-Id: 582122f1d73af28407234321c94711e09aa3fd04
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5593a733f968521444df84902901902233c17d8f
Message-Id: <163667215908.13198.15561124807009017786.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Nov 2021 23:09:19 +0000
To:     John Johansen <john.johansen@canonical.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKLM <linux-kernel@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The pull request you sent on Wed, 10 Nov 2021 13:45:25 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/apparmor-pr-2021-11-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5593a733f968521444df84902901902233c17d8f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
