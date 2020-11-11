Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CF1C56202
	for <linux-security-module@archiver.kernel.org>; Wed, 11 Nov 2020 21:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD64F216C4
	for <linux-security-module@archiver.kernel.org>; Wed, 11 Nov 2020 21:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgKKVew (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 11 Nov 2020 16:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbgKKVev (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 11 Nov 2020 16:34:51 -0500
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [IPv6:2001:1600:3:17::42ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A55C0613D1
        for <linux-security-module@vger.kernel.org>; Wed, 11 Nov 2020 13:34:50 -0800 (PST)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4CWdKx0gBtzlhGL9;
        Wed, 11 Nov 2020 22:34:45 +0100 (CET)
Received: from localhost (unknown [94.23.54.103])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4CWdKw4jtzzlh8T5;
        Wed, 11 Nov 2020 22:34:44 +0100 (CET)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v1 0/9] Landlock fixes
Date:   Wed, 11 Nov 2020 22:34:33 +0100
Message-Id: <20201111213442.434639-1-mic@digikod.net>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi,

This patch series fixes some issues and makes the Landlock filesystem
access-control more consistent and deterministic when stacking multiple
rulesets.  This is checked by current and new tests.  I also extended
documentation and example to help users.

This series can be applied on top of
https://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git/log/?h=landlock_lsm

Regards,

Mickaël Salaün (9):
  landlock: Fix memory allocation error handling
  landlock: Cosmetic fixes for filesystem management
  landlock: Enforce deterministic interleaved path rules
  landlock: Always intersect access rights
  landlock: Add extra checks when inserting a rule
  selftests/landlock: Extend layout1.inherit_superset
  landlock: Clean up get_ruleset_from_fd()
  landlock: Add help to enable Landlock as a stacked LSM
  landlock: Extend documentation about limitations

 Documentation/userspace-api/landlock.rst   |  17 +++
 samples/landlock/sandboxer.c               |  21 +++-
 security/landlock/Kconfig                  |   4 +-
 security/landlock/fs.c                     |  67 +++++-----
 security/landlock/object.c                 |   5 +-
 security/landlock/ruleset.c                |  34 ++---
 security/landlock/syscall.c                |  24 ++--
 tools/testing/selftests/landlock/fs_test.c | 140 +++++++++++++++++++--
 8 files changed, 239 insertions(+), 73 deletions(-)


base-commit: 96b3198c4025c11347651700b77e45a686d78553
-- 
2.29.2

