Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA55C433F5
	for <linux-security-module@archiver.kernel.org>; Thu,  2 Sep 2021 20:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EF9E61053
	for <linux-security-module@archiver.kernel.org>; Thu,  2 Sep 2021 20:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344052AbhIBUG0 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 2 Sep 2021 16:06:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:44130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235049AbhIBUGZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 2 Sep 2021 16:06:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 3416D61054;
        Thu,  2 Sep 2021 20:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630613126;
        bh=V6fA8n1tkGeTObPcl9Uio4xh8BnR2sBQsHVtVMdzqbI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=P2R+Co1co4+q0STUqKgHKdShMDy/CbMUQ1bFHj9Rx57u9DtV/T30CMuOMPqJvGsSk
         wYsDugNDozPxELkBvdaRlmOKRUO29/hQ6Xant32LRK9LvyMpreWay7931XinSrOvDD
         HJGTdU82Ze3dLViCQgjx5P5lZpbxOliTrmxl33BuMd2AroMeNBbU650aFtJ3tfR+pE
         QyFRQ1N9Qveafbjxz23bGQ1AKH7bW9qGd++cNYmm2z7h/uPEQ7rr+A4vxpQ2J6a4xD
         hog1Fv6qT8LsD2gakkw1h4eOKIKbAi6z8v/cMBke8x/ny+idp5Cnn64ANlsAvZiwY1
         eltEcDmHzKZ1A==
Subject: Re: [GIT PULL] hardening updates for v5.15-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202108301127.836C1F4D@keescook>
References: <202108301127.836C1F4D@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202108301127.836C1F4D@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v5.15-rc1
X-PR-Tracked-Commit-Id: a8fc576d4af2f23a87a586424252df97f0ad0b06
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b55060d796c5300ad7a410cb5faec36582925570
Message-Id: <163061312617.10011.2408180338296148205.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Sep 2021 20:05:26 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        clang-built-linux@googlegroups.com, glider@google.com,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-security-module@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The pull request you sent on Mon, 30 Aug 2021 11:27:55 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v5.15-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b55060d796c5300ad7a410cb5faec36582925570

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
