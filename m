Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A04C43460
	for <linux-security-module@archiver.kernel.org>; Wed,  5 May 2021 20:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2FF9613E3
	for <linux-security-module@archiver.kernel.org>; Wed,  5 May 2021 20:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhEEUuT (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 5 May 2021 16:50:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:59624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230009AbhEEUuQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 5 May 2021 16:50:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id BCACD613ED;
        Wed,  5 May 2021 20:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620247759;
        bh=aRGoPiNdZDbJUjhYfqJ0RTBYlAMNcp+GVNgQfxE2Sbc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IkjNDHHOpXmFqpGbTXyZ1USYd0Cu3fbRjXD12p3rsIu2cvrvc+K6BikE4tNfVgeTU
         m2bBNTh8LkTPaaKqRW+kK0XeJBgudPEeuvdk/L2zmQtBzwNUc3D2XTZGUfFzpqBJWC
         RIIW+62pu0sZbcWvUH9lfwnF+ts4SQXAE/Oparc4+nZKQeiGV5jjBkXdLBdB24RogG
         wJaYFSGa/PPBsunWEz6+Rz6kSCg8EmbLCI3F7yXzuHPvp1f/IAWWvyNBLaUIEQ/oDv
         VVFhy58GAOOG2cyUL6K916Jv03jWiYcPMPiJHrV31p0sygColP2C6SacmXKiDe2OjE
         TTncGdjQAp0jg==
Subject: Re: [GIT PULL] SafeSetID changes for v5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJ-EccOdLW1+8xx8=PRHzSjy4kVaVOUave0pAXF5b=cD4w3=pg@mail.gmail.com>
References: <CAJ-EccOdLW1+8xx8=PRHzSjy4kVaVOUave0pAXF5b=cD4w3=pg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJ-EccOdLW1+8xx8=PRHzSjy4kVaVOUave0pAXF5b=cD4w3=pg@mail.gmail.com>
X-PR-Tracked-Remote: https://github.com/micah-morton/linux.git tags/safesetid-5.13
X-PR-Tracked-Commit-Id: 1ca86ac1ec8d201478e9616565d4df5d51595cfc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d29c9bb0108eedfc8f8b46f225f9539190c50d45
Message-Id: <162024775974.12235.11953358196306474920.pr-tracker-bot@kernel.org>
Date:   Wed, 05 May 2021 20:49:19 +0000
To:     Micah Morton <mortonm@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The pull request you sent on Mon, 3 May 2021 11:42:13 -1000:

> https://github.com/micah-morton/linux.git tags/safesetid-5.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d29c9bb0108eedfc8f8b46f225f9539190c50d45

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
