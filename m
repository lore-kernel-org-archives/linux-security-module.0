Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C96EC001B1
	for <linux-security-module@archiver.kernel.org>; Wed, 28 Jun 2023 01:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjF1BBZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 27 Jun 2023 21:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjF1BBW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 27 Jun 2023 21:01:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9702979;
        Tue, 27 Jun 2023 18:01:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BF5A611AC;
        Wed, 28 Jun 2023 01:01:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CCB30C433C0;
        Wed, 28 Jun 2023 01:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687914080;
        bh=I5Xb/mwRB/GnGtdRUnGBqdofwHSdUBVG6ZOL+Qs6zZs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=iVVc5PzJqGhv9DPaPlN0bsXbD3oZUXes3YuxejwPAjZSIX7v/UkgvIq2HQWG6w38M
         qxBJTxRXOA4uQFusgvEY7cMgBGZLq4efVuotbI0W/Orc734WYSoQfquaXOA5gIwujQ
         FdqHOJw2k+nooFmKG9vZr73HBi1pbm8vVhwQbOGWnjzNikhjlKbFGG2EjKhYuKCpLe
         OMzwpUvbovkIQgJH/+dX/yJfYBdxt6spP8rDyZ1EVYP185ccnOEWq0kpF+w8h+RvhW
         7G+8BaL+n+hHdMtaTVPlTSLzdM8l7NI/EuZ2ibQ0sw5iaJbGUwWcWe97cOgb85X3Jp
         1YKN5HwMd7J4A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B8CAEC0C40E;
        Wed, 28 Jun 2023 01:01:20 +0000 (UTC)
Subject: Re: [GIT PULL] LSM patches for v6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhRdEE58-hOXFGQmO5BV5gCNv0+bLx-GrLogR8uVAhaUqg@mail.gmail.com>
References: <CAHC9VhRdEE58-hOXFGQmO5BV5gCNv0+bLx-GrLogR8uVAhaUqg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhRdEE58-hOXFGQmO5BV5gCNv0+bLx-GrLogR8uVAhaUqg@mail.gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20230626
X-PR-Tracked-Commit-Id: 4be22f16a4a1a1667e79b52b56cca2c64b3747e2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 21953eb16c2a6ebc039126d63acf84b286a58a02
Message-Id: <168791408075.14121.17412159960071817434.pr-tracker-bot@kernel.org>
Date:   Wed, 28 Jun 2023 01:01:20 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The pull request you sent on Mon, 26 Jun 2023 20:47:01 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20230626

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/21953eb16c2a6ebc039126d63acf84b286a58a02

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
