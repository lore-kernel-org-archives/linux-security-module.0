Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7DFC4361B
	for <linux-security-module@archiver.kernel.org>; Mon, 14 Dec 2020 04:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BC582076A
	for <linux-security-module@archiver.kernel.org>; Mon, 14 Dec 2020 04:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438579AbgLNEWe (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 13 Dec 2020 23:22:34 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:61644 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgLNEWe (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 13 Dec 2020 23:22:34 -0500
Received: from fsav301.sakura.ne.jp (fsav301.sakura.ne.jp [153.120.85.132])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 0BE4LmO7078312;
        Mon, 14 Dec 2020 13:21:48 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav301.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav301.sakura.ne.jp);
 Mon, 14 Dec 2020 13:21:48 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav301.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 0BE4LlxG078307
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 14 Dec 2020 13:21:48 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-security-module <linux-security-module@vger.kernel.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: [GIT PULL] tomoyo fixes for v5.11
Message-ID: <85aa37f5-3fca-fde2-068d-b1888de51457@i-love.sakura.ne.jp>
Date:   Mon, 14 Dec 2020 13:21:46 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The following changes since commit 15269fb193108ba8a3774507d0bbd70949ab610d:

  tomoyo: Fix typo in comments. (2020-12-06 13:44:57 +0900)

are available in the git repository at:

  git://git.osdn.net/gitroot/tomoyo/tomoyo-test1.git tags/tomoyo-pr-20201214

for you to fetch changes up to 15269fb193108ba8a3774507d0bbd70949ab610d:

  tomoyo: Fix typo in comments. (2020-12-06 13:44:57 +0900)

----------------------------------------------------------------
Limit recursion depth, fix clang warning, fix comment typo, and
silence memory allocation failure warning.

tomoyo: fix clang pointer arithmetic warning
tomoyo: Limit wildcard recursion depth.
tomoyo: Fix null pointer check
tomoyo: Fix typo in comments.

 security/tomoyo/audit.c         |    2 -
 security/tomoyo/common.c        |    8 ++---
 security/tomoyo/condition.c     |    2 -
 security/tomoyo/domain.c        |    6 +---
 security/tomoyo/gc.c            |    2 -
 security/tomoyo/memory.c        |    4 +-
 security/tomoyo/securityfs_if.c |    6 ++--
 security/tomoyo/util.c          |   55 +++++++++++++++++++++-------------------
 8 files changed, 44 insertions(+), 41 deletions(-)

----------------------------------------------------------------
