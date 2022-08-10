Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB1FC00140
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Aug 2022 18:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbiHJSdh (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 10 Aug 2022 14:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbiHJSdf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Aug 2022 14:33:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A977C1A3;
        Wed, 10 Aug 2022 11:33:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01B546145A;
        Wed, 10 Aug 2022 18:33:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5CEE8C433D6;
        Wed, 10 Aug 2022 18:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660156413;
        bh=D19PBfwAbILfrAJ4e9YsCKnRJIu9jYWXcH95v4mOsYQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=j86uRzgiptrIjcG0yXhFK7fczl+KPvK2HqMhPlYsg2FKcAQUmtC1qhkbzmUs+K7Fe
         HU1blg8181F8P4W5iugwoLyQrRXoicIEEkTpjivovPBtHHBI7Jrx4gISGiDfBF9DR9
         OhAdbEHv8GUACA5rGb0pEnnnRxRbHcgly9mp+i5XFDmatw6OClbo1e2qtLKrCLqyU+
         CuYmUBa991YJNnSqW7ZfTaecCAtYNkAHc0nVIpmpVFAtKJoV71bE46BEQK9ojGVGF0
         anM3HJ+6l/9XNYICX7PHGstdE4Xb7p5BlsFIFopvQFhOVjYPZNIGaL8I+RNtmj+1RF
         LIX/ajIbaysEA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4C4DAC43142;
        Wed, 10 Aug 2022 18:33:33 +0000 (UTC)
Subject: Re: [GIT PULL] apparmor changes for v5.20
From:   pr-tracker-bot@kernel.org
In-Reply-To: <8009201e-be46-a237-c6b1-e133dbc84137@canonical.com>
References: <8009201e-be46-a237-c6b1-e133dbc84137@canonical.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <8009201e-be46-a237-c6b1-e133dbc84137@canonical.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/apparmor-pr-2022-08-08
X-PR-Tracked-Commit-Id: c269fca7b37a08b7eec6f6b79a0abf1d0a245acb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 00aa9d0bbfec91dcf191dd7899a65ab28b6cc76d
Message-Id: <166015641330.32353.2643261231802451855.pr-tracker-bot@kernel.org>
Date:   Wed, 10 Aug 2022 18:33:33 +0000
To:     John Johansen <john.johansen@canonical.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKLM <linux-kernel@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The pull request you sent on Tue, 9 Aug 2022 10:53:33 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/apparmor-pr-2022-08-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/00aa9d0bbfec91dcf191dd7899a65ab28b6cc76d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
