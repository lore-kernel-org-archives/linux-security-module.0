Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591DFC00140
	for <linux-security-module@archiver.kernel.org>; Tue,  2 Aug 2022 22:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236220AbiHBW32 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 2 Aug 2022 18:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234980AbiHBW31 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 2 Aug 2022 18:29:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F11A54CA0;
        Tue,  2 Aug 2022 15:29:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0ACE2B8211E;
        Tue,  2 Aug 2022 22:29:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C7CF0C433D7;
        Tue,  2 Aug 2022 22:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659479363;
        bh=F95IkCPOLNoTqLButUmAf+0kTUUUrPlbxHDwIVZwUCU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tx4EI5USngVnMWRxZGAM9W8r/TyDlxQ0SUB2/MyD12ItegU6yzeAKSAyTvEZMnwbR
         S0Wu7hUe/ruAx0j/tgD0BxHuwDapBJS9IG4qFp7NhkG6H6vuNc0MncPiJon6Q0VbAR
         WweO0gDoaxaTtfTefWgutIBCWGh8PA2Far65fDrPsp9cRSGkOiE3ePG8I8frKUl4x6
         UsEpJivvv+WICJhzXAabhFEfM7R8Slm6m70V3rUpx/yyP4dLbjvcp+lK98K05M698U
         VFqq9ju5X3SgPWnkOrqZ6F9RgaoaYViiDISq7tdSRvzXJCtWeYClcN5gPIcK7per/s
         P5M822XQsHS6g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B67B7C43142;
        Tue,  2 Aug 2022 22:29:23 +0000 (UTC)
Subject: Re: [GIT PULL] Smack patches for v6.0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <827a0fe0-03a3-b5ca-db34-daff17095b8f@schaufler-ca.com>
References: <827a0fe0-03a3-b5ca-db34-daff17095b8f.ref@schaufler-ca.com> <827a0fe0-03a3-b5ca-db34-daff17095b8f@schaufler-ca.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <827a0fe0-03a3-b5ca-db34-daff17095b8f@schaufler-ca.com>
X-PR-Tracked-Remote: https://github.com/cschaufler/smack-next tags/Smack-for-6.0
X-PR-Tracked-Commit-Id: aa16fb4b9e7e1057008d999138e7ae68a40bf167
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ea7099d5229c0fe9f9302b03a246e15e78b87011
Message-Id: <165947936374.5634.1750839233707969269.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Aug 2022 22:29:23 +0000
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     torvalds@linux-foundation.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        casey@schaufler-ca.com
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The pull request you sent on Mon, 1 Aug 2022 13:13:20 -0700:

> https://github.com/cschaufler/smack-next tags/Smack-for-6.0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ea7099d5229c0fe9f9302b03a246e15e78b87011

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
