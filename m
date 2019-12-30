Return-Path: <SRS0=GMo7=2U=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4B4C2D0C2
	for <linux-security-module@archiver.kernel.org>; Mon, 30 Dec 2019 11:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3127206E4
	for <linux-security-module@archiver.kernel.org>; Mon, 30 Dec 2019 11:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbfL3LcB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 30 Dec 2019 06:32:01 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:63646 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbfL3LcA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 30 Dec 2019 06:32:00 -0500
Received: from fsav106.sakura.ne.jp (fsav106.sakura.ne.jp [27.133.134.233])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id xBUBVvMg085384;
        Mon, 30 Dec 2019 20:31:57 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav106.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav106.sakura.ne.jp);
 Mon, 30 Dec 2019 20:31:57 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav106.sakura.ne.jp)
Received: from [192.168.1.9] (softbank126040062084.bbtec.net [126.40.62.84])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id xBUBVfZE085132
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 30 Dec 2019 20:31:57 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-security-module <linux-security-module@vger.kernel.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: [GIT PULL] tomoyo fixes for 5.5
Message-ID: <8483f2c2-626d-382f-3994-ee29daebff75@i-love.sakura.ne.jp>
Date:   Mon, 30 Dec 2019 20:31:40 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello Linus,

This is my first time for sending pull requests. It seems that most people
create a tag signed with GPG key but a few people send pull requests on
master branch without signing with GPG key. Did I follow necessary steps?
---
The following changes since commit 6794862a16ef41f753abd75c03a152836e4c8028:

  Merge tag 'for-5.5-rc1-kconfig-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux (2019-12-09 12:14:31 -0800)

are available in the git repository at:

  git://git.osdn.net/gitroot/tomoyo/tomoyo-test1.git master

for you to fetch changes up to 6bd5ce6089b561f5392460bfb654dea89356ab1b:

  tomoyo: Suppress RCU warning at list_for_each_entry_rcu(). (2019-12-16 23:02:27 +0900)

----------------------------------------------------------------
Tetsuo Handa (2):
      tomoyo: Don't use nifty names on sockets.
      tomoyo: Suppress RCU warning at list_for_each_entry_rcu().

 security/tomoyo/common.c   |  9 ++++++---
 security/tomoyo/domain.c   | 15 ++++++++++-----
 security/tomoyo/group.c    |  9 ++++++---
 security/tomoyo/realpath.c | 32 +-------------------------------
 security/tomoyo/util.c     |  6 ++++--
 5 files changed, 27 insertions(+), 44 deletions(-)
