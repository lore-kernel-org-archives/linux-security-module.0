Return-Path: <SRS0=9+Rk=PY=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55ABFC43612
	for <linux-security-module@archiver.kernel.org>; Wed, 16 Jan 2019 06:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24BFC20859
	for <linux-security-module@archiver.kernel.org>; Wed, 16 Jan 2019 06:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547618403;
	bh=UxpPFcg8quuJKampHUxj7fYMcATihsz78UiYaLUAYjI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=uU+DcCqAomH8cv/7aas0oWSocWlfk8qhBjbDZinMMqM/vdsl3nid3wG7/kiUmZoxh
	 SDBBQAmNYQZhjVeAh2b/8a723sOVzpG2JWEKrlb/C4Z4+GTnpad2eGgVoS+RRPLA1Y
	 N8TCD/gAvSC2osMfI7MVLqAVR7KEMpDMT3X4MktU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732931AbfAPGAC (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 16 Jan 2019 01:00:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:50154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732578AbfAPGAC (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 16 Jan 2019 01:00:02 -0500
Subject: Re: [GIT PULL] SELinux fixes for v5.0 (#1)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547618401;
        bh=UxpPFcg8quuJKampHUxj7fYMcATihsz78UiYaLUAYjI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=v0VzdBzQXf+CyT2AxtgSNiRce3ljT0odNyW4O5XvGhVNIoh3vapqGUxk5+NLwFxbf
         CTq6o4KuCo89hR93UZPnVaUA/PBpf8VNgSSEuUd+82PCzgkQs55IsgVi+oohOtjAWF
         mQt+yHdWuRq+dyl+ZJdtY0IAj+gzuqy+Y7hcMudo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhSOqYnEPUJhcXTg4yAMw3c1+EOt9CE77JoJkdcz1MJNsA@mail.gmail.com>
References: <CAHC9VhSOqYnEPUJhcXTg4yAMw3c1+EOt9CE77JoJkdcz1MJNsA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhSOqYnEPUJhcXTg4yAMw3c1+EOt9CE77JoJkdcz1MJNsA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
 tags/selinux-pr-20190115
X-PR-Tracked-Commit-Id: 5b0e7310a2a33c06edc7eb81ffc521af9b2c5610
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 47bfa6d9dc8c060bf56554a465c9031e286d2f80
Message-Id: <154761840177.28714.17165635207206358246.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Jan 2019 06:00:01 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The pull request you sent on Tue, 15 Jan 2019 17:24:58 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20190115

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/47bfa6d9dc8c060bf56554a465c9031e286d2f80

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
