Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B46AEB64D9
	for <linux-security-module@archiver.kernel.org>; Wed, 28 Jun 2023 01:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjF1BBZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 27 Jun 2023 21:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjF1BBW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 27 Jun 2023 21:01:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303F3297A;
        Tue, 27 Jun 2023 18:01:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 890346123F;
        Wed, 28 Jun 2023 01:01:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EEB88C433CA;
        Wed, 28 Jun 2023 01:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687914081;
        bh=s8TuhGgCWpwhVVNsNOJ3ANfg789tncO30W5ezzx9ToI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jIKMKAUmG9E0VxXHZqEZHva87pt25vxyjAToOzfbWQOUckm9RyY192+OKgSMWM8qR
         4+NYIX08wKVWGGjKyJu4xjH91j8u43PKTyHNWog8ObO6xaIDPu2RD0KC+cCDJZo5DD
         bjFL67hINeWnCEk8GIsrZuCX4A4iy/VrsUKsJMGNA8RMzXT/MSsZhpVbE4ej26Is7y
         lXdUKeUM4wKWtv34cLNuQSFAIuXYifF/FO66sGsyK8ZWIhXKpoQIqMWD2OYLE2LQsI
         RXQsLUrVLHfe6Elozh7G1zfaK/j+83OClk+vTKZhXnOZgQFbS8LcHmP0/itPD1jiog
         jUTocSxQw5XLg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D96AEE53807;
        Wed, 28 Jun 2023 01:01:20 +0000 (UTC)
Subject: Re: [GIT PULL] Smack patches for 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <3b1107c2-77c1-28ce-3413-bec589eae083@schaufler-ca.com>
References: <3b1107c2-77c1-28ce-3413-bec589eae083.ref@schaufler-ca.com> <3b1107c2-77c1-28ce-3413-bec589eae083@schaufler-ca.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <3b1107c2-77c1-28ce-3413-bec589eae083@schaufler-ca.com>
X-PR-Tracked-Remote: https://github.com/cschaufler/smack-next tags/Smack-for-6.5
X-PR-Tracked-Commit-Id: 2c085f3a8f23c9b444e8b99d93c15d7ce870fc4e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 98be618ad03010b1173fc3c35f6cbb4447ee2b07
Message-Id: <168791408088.14121.6264904620933008086.pr-tracker-bot@kernel.org>
Date:   Wed, 28 Jun 2023 01:01:20 +0000
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The pull request you sent on Tue, 27 Jun 2023 08:01:44 -0700:

> https://github.com/cschaufler/smack-next tags/Smack-for-6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/98be618ad03010b1173fc3c35f6cbb4447ee2b07

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
