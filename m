Return-Path: <SRS0=O5tY=3S=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27447C33C9E
	for <linux-security-module@archiver.kernel.org>; Wed, 29 Jan 2020 03:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F008822522
	for <linux-security-module@archiver.kernel.org>; Wed, 29 Jan 2020 03:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580266808;
	bh=vOteYWEDtD7H1bk32wm6DK9/CgGgBbcxEFBlO/NbsRI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=KPBs+lAWCoHa/T0v+YkxUE2FJ26OJL+lfRHaeUIMninu8md6rrPvX+1tHrlX93ykZ
	 JqIXhSqKrljwdMaDtKZsc9y70+NtMGEyO+tbHpmQOeluRoSOWqU+gwxVg/U3hzmHu1
	 xRoJunBTSyd5hpVa0FcJpusUevhQ3X0nFyirsHxg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgA2DAH (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 28 Jan 2020 22:00:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:42302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726556AbgA2DAH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 28 Jan 2020 22:00:07 -0500
Subject: Re: [GIT PULL] Security subsystem changes for v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580266806;
        bh=vOteYWEDtD7H1bk32wm6DK9/CgGgBbcxEFBlO/NbsRI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=j6tEI8NF3L0ILY+n/abPe5yuN0GQboqBnmotmsnzt9yQ4rJBG2xllgyegHHygD481
         COZLRZ4qdcssw/WNjNztVN/QU41roO78YnjQklSRPtvPAt/Z4AOmQ61jCWntmYvl5Q
         TV9GrZV99JwI/mZ9jc+o2z3okt/JlrIuZ6Mwhf3M=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <alpine.LRH.2.21.2001290823510.4816@namei.org>
References: <alpine.LRH.2.21.2001290823510.4816@namei.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <alpine.LRH.2.21.2001290823510.4816@namei.org>
X-PR-Tracked-Remote: git://git.kernel.org:/pub/scm/linux/kernel/git/jmorris/linux-security
 for-v5.6
X-PR-Tracked-Commit-Id: 10c2d111c906599942efd13109061885631c4a0c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b3a6082223369203d7e7db7e81253ac761377644
Message-Id: <158026680672.3354.17400298883326710353.pr-tracker-bot@kernel.org>
Date:   Wed, 29 Jan 2020 03:00:06 +0000
To:     James Morris <jmorris@namei.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The pull request you sent on Wed, 29 Jan 2020 08:24:55 +1100 (AEDT):

> git://git.kernel.org:/pub/scm/linux/kernel/git/jmorris/linux-security for-v5.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b3a6082223369203d7e7db7e81253ac761377644

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
