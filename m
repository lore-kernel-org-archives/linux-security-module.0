Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65028C433DB
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Feb 2021 01:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CCB164E56
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Feb 2021 01:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbhBOBk2 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 14 Feb 2021 20:40:28 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:59450 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhBOBk1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 14 Feb 2021 20:40:27 -0500
Received: from fsav404.sakura.ne.jp (fsav404.sakura.ne.jp [133.242.250.103])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 11F1dhDY060940;
        Mon, 15 Feb 2021 10:39:44 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav404.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav404.sakura.ne.jp);
 Mon, 15 Feb 2021 10:39:43 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav404.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 11F1df3a060932
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 15 Feb 2021 10:39:43 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-security-module <linux-security-module@vger.kernel.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: [GIT PULL] tomoyo fixes for v5.12
Message-ID: <1616df1b-0d97-2bdd-9d89-d4393fc837a0@i-love.sakura.ne.jp>
Date:   Mon, 15 Feb 2021 10:39:36 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The following changes since commit 9c83465f3245c2faa82ffeb7016f40f02bfaa0ad:

  tomoyo: recognize kernel threads correctly (2021-02-01 11:53:05 +0900)

are available in the git repository at:

  git://git.osdn.net/gitroot/tomoyo/tomoyo-test1.git tags/tomoyo-pr-20210215

for you to fetch changes up to 9c83465f3245c2faa82ffeb7016f40f02bfaa0ad:

  tomoyo: recognize kernel threads correctly (2021-02-01 11:53:05 +0900)

----------------------------------------------------------------
Detect kernel thread correctly, and ignore harmless data race.

  tomoyo: recognize kernel threads correctly
  tomoyo: ignore data race while checking quota

 security/tomoyo/file.c    |   16 ++++++++--------
 security/tomoyo/network.c |   10 +++++-----
 security/tomoyo/util.c    |   24 ++++++++++++------------
 3 files changed, 25 insertions(+), 25 deletions(-)

----------------------------------------------------------------
