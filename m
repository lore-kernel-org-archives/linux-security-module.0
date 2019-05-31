Return-Path: <SRS0=N7Ha=T7=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCE8C04AB6
	for <linux-security-module@archiver.kernel.org>; Fri, 31 May 2019 18:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB32A26DB6
	for <linux-security-module@archiver.kernel.org>; Fri, 31 May 2019 18:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559326507;
	bh=miVy6T5Q7i/rolHgV0TbLQRGG93LLzQrR/BO8b8Tybg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=zHNF4A5NDyUbg5HzxeyW/kcL0v/2AuCnuL5y5GuNKPos+y1L7nH2BMsRJL7/toPdW
	 Ifx7w3JA+kKQdBUuqzPYrlXqo1xeB5G6wFyv4v/6+oBokWHwaU8dQlegAIYG5EV0uk
	 uuMnuVHgL5spggzjaJ3vrmM+0PjvDRDO50mE5dpA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfEaSPD (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 31 May 2019 14:15:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:45584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726985AbfEaSPD (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 31 May 2019 14:15:03 -0400
Subject: Re: [GIT PULL] integrity subsystem fixes for v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559326502;
        bh=miVy6T5Q7i/rolHgV0TbLQRGG93LLzQrR/BO8b8Tybg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=YBVOA42Gy7k/c0AjTD+8Nspdt+aMEb1NPTF54ypMyaD82N9B2JvJ2pwN03W6MJIyJ
         xIMWYeHKdgt2aXHKRhgnkOSXGr7qvALDPECBoMtfonUMfwyvBakYm5IPFkRKXKHysD
         3WpSZL04A2AqvA+8c/aed5iS7acDoDrvuQgrmmak=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1559318325.4280.13.camel@linux.ibm.com>
References: <1559318325.4280.13.camel@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <1559318325.4280.13.camel@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
 next-fixes-for-5.2-rc
X-PR-Tracked-Commit-Id: 8cdc23a3d9ec0944000ad43bad588e36afdc38cd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d266b3f5cac09434eb624af202f9a31307b34a88
Message-Id: <155932650259.23368.672260544274164977.pr-tracker-bot@kernel.org>
Date:   Fri, 31 May 2019 18:15:02 +0000
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The pull request you sent on Fri, 31 May 2019 11:58:45 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-fixes-for-5.2-rc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d266b3f5cac09434eb624af202f9a31307b34a88

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
