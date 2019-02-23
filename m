Return-Path: <SRS0=Scw7=Q6=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965A8C10F00
	for <linux-security-module@archiver.kernel.org>; Sat, 23 Feb 2019 02:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 675D72070D
	for <linux-security-module@archiver.kernel.org>; Sat, 23 Feb 2019 02:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550888116;
	bh=+EG43ON9RT15ipniQUJVICuyZMDlTJ2jd392Fa+81+Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=wWXiBlyVTChlxBvFtB7zitFOvJHf70f0uH2ytw2rbNEYV0/tegIuIsurW8JEJO2Ds
	 qb/8EvRnpoEXhJAk9DV34fcxyE+MbBt1TaRt1okXLtf88oLRi7o+Ip5RxUgffDj5FS
	 mGbaAuyH87xeozrwg2YaUk//NnFVmU8E4yZ8Uadw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbfBWCPD (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 22 Feb 2019 21:15:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:53882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbfBWCPC (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 22 Feb 2019 21:15:02 -0500
Subject: Re: [GIT PULL] More key subsystem fixes for 5.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550888102;
        bh=+EG43ON9RT15ipniQUJVICuyZMDlTJ2jd392Fa+81+Y=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=DoHWTeF3ZYi1V55P3zrLLK0y9tZftVtfWaNECyb0iZnpjl7H+9j6oYIJLn1jNXM1u
         l+yoCFlvmVt655tVyD26vOGDw88za8+sz6w4pRiiLmxfna005TM/Ob5twQbYH8ZD/m
         VUrBnh5pz24gf2eUZP/sR+jNN0PaCnLSER8ySINA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <alpine.LRH.2.21.1902230513480.27514@namei.org>
References: <alpine.LRH.2.21.1902230513480.27514@namei.org>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <alpine.LRH.2.21.1902230513480.27514@namei.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git
 fixes-v5.0-rc7
X-PR-Tracked-Commit-Id: ede0fa98a900e657d1fcd80b50920efc896c1a4c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cb268d806972c76c34e5d74343fb6064cd722c7c
Message-Id: <155088810226.21150.8724253668115827807.pr-tracker-bot@kernel.org>
Date:   Sat, 23 Feb 2019 02:15:02 +0000
To:     James Morris <jmorris@namei.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-security-module@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Eric Biggers <ebiggers@google.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The pull request you sent on Sat, 23 Feb 2019 05:15:11 +1100 (AEDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git fixes-v5.0-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cb268d806972c76c34e5d74343fb6064cd722c7c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
