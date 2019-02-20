Return-Path: <SRS0=vYSA=Q3=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4B3C43381
	for <linux-security-module@archiver.kernel.org>; Wed, 20 Feb 2019 17:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 039DB218C3
	for <linux-security-module@archiver.kernel.org>; Wed, 20 Feb 2019 17:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550685008;
	bh=shRZHkeTXe0MkKQ3os+LoYsWbPepiIh94YlnBfSKA04=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=FQ4LZNdgeJOCYBry1m3PhTdHBRIDPv1Wg46XDllKdECzUhivGdwqhOc5//N4YS6yQ
	 bPIcg+ZCWtWOFESkDmnEz6IrUafROt2ihrTvzVF1SjWSVPttT/eSkqJgbLd9kGQ6cZ
	 J6nM3JdU6nb+PSj+/wQZMKraPeCdJYcslPs56ao0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfBTRuG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 20 Feb 2019 12:50:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:45216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbfBTRuF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 20 Feb 2019 12:50:05 -0500
Subject: Re: [GIT PULL] KEYS: fixes for v5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550685004;
        bh=shRZHkeTXe0MkKQ3os+LoYsWbPepiIh94YlnBfSKA04=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Cut7+eCVKBQQaJx6xJTL3PiyekfkWtHOoCPtYAg1wlOXtkZcc+BbKS0kRDmmYK9Kk
         IsSKC4+3Zl8IwuBCtW5sYshpmLL5TbMIKKoiVY1WfEJlHGSWw3Wzs0FiUW5bkuM6YQ
         6juesU1zupfPsUBOH7n4vjvTGLP8lVqbDOQxGdpI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <alpine.LRH.2.21.1902160914180.4453@namei.org>
References: <alpine.LRH.2.21.1902160914180.4453@namei.org>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <alpine.LRH.2.21.1902160914180.4453@namei.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git
 fixes-v5.1-rc6
X-PR-Tracked-Commit-Id: 7c1857bdbdf1e4c541e45eab477ee23ed4333ea4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1f5a018c5b15c2e3e519ae8ca9bfb03a00384448
Message-Id: <155068500468.4632.4370506737605640381.pr-tracker-bot@kernel.org>
Date:   Wed, 20 Feb 2019 17:50:04 +0000
To:     James Morris <jmorris@namei.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-security-module@vger.kernel.org,
        David Howells <dhowells@redhat.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The pull request you sent on Sat, 16 Feb 2019 09:16:00 +1100 (AEDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git fixes-v5.1-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1f5a018c5b15c2e3e519ae8ca9bfb03a00384448

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
