Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2BAEB64DA
	for <linux-security-module@archiver.kernel.org>; Fri,  7 Jul 2023 17:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjGGRLA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 7 Jul 2023 13:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbjGGRK7 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 7 Jul 2023 13:10:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF84196;
        Fri,  7 Jul 2023 10:10:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8DE1619FF;
        Fri,  7 Jul 2023 17:10:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45EB1C433C8;
        Fri,  7 Jul 2023 17:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688749858;
        bh=2XM3DgStlRihDswsxs2EfVLFjMIV0Vf2lumRbN18c2Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JnCTdyN+0JiUJ9M+H/tIhNsRU8LM8n26I7wtS1LGWTsmzUxGXT1XafibIus01akGb
         L7bRUqZsFScbksIwSSgzMaUN/Q/UG9gt9dQtqyiR/vlmy9k5D+0cSGEKK68vo2OQUq
         OYSMcrIDldLpexUUXA71K8SO57qMx9lq/S1HJAlo+DDWJ9iae1o8UAR46++GGbm9hA
         o0qFXsxHtSEi0SjdAC28OUpHy9mzdp5PSLO8yeA5qXkg8/AQqAi1wu3rk1CzMe0n6b
         xz22wwDkE9ZN/DEzN/3s84AgE23zt9oVLFd2QGgnQNu2fQhwCk6c9oWYwSEhuK8Lej
         aP1O8YoSaATGA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 31A82E537FC;
        Fri,  7 Jul 2023 17:10:58 +0000 (UTC)
Subject: Re: [GIT PULL] apparmor bug fixes for 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <b68ad9e0-2ce1-50d5-4856-e4d8fe97fc82@canonical.com>
References: <b68ad9e0-2ce1-50d5-4856-e4d8fe97fc82@canonical.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <b68ad9e0-2ce1-50d5-4856-e4d8fe97fc82@canonical.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/apparmor-pr-2023-07-06
X-PR-Tracked-Commit-Id: 3f069c4c643225f2b96b4b3f8c30e4445f079d2e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 70806ee18a871140a73a2524a29865e1d904348c
Message-Id: <168874985818.21562.3365504880709774749.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Jul 2023 17:10:58 +0000
To:     John Johansen <john.johansen@canonical.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKLM <linux-kernel@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The pull request you sent on Thu, 6 Jul 2023 11:28:17 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/apparmor-pr-2023-07-06

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/70806ee18a871140a73a2524a29865e1d904348c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
