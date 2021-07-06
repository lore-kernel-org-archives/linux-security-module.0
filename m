Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D36C07E96
	for <linux-security-module@archiver.kernel.org>; Tue,  6 Jul 2021 18:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47B8C613C8
	for <linux-security-module@archiver.kernel.org>; Tue,  6 Jul 2021 18:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbhGFSZu (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 6 Jul 2021 14:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbhGFSZt (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 6 Jul 2021 14:25:49 -0400
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [IPv6:2001:1600:4:17::42aa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798AFC061762
        for <linux-security-module@vger.kernel.org>; Tue,  6 Jul 2021 11:23:10 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4GK9sR1QF9zMpngS;
        Tue,  6 Jul 2021 20:23:07 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4GK9sQ2SgFzlmrrX;
        Tue,  6 Jul 2021 20:23:06 +0200 (CEST)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     Alejandro Colomar <alx.manpages@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        landlock@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-man@vger.kernel.org, linux-security-module@vger.kernel.org,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>
Subject: [PATCH v1 0/4] Add Landlock man pages
Date:   Tue,  6 Jul 2021 20:22:13 +0200
Message-Id: <20210706182217.32338-1-mic@digikod.net>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Mickaël Salaün <mic@linux.microsoft.com>

Hi,

These four documents give a global overview of Landlock and explain each
system calls.  This is mainly a formatting of the current kernel
documentation with some new additional details.

Regards,

Mickaël Salaün (4):
  landlock.7: Add a new page to introduce Landlock
  landlock_create_ruleset.2: Document new syscall
  landlock_add_rule.2: Document new syscall
  landlock_restrict_self.2: Document new syscall

 man2/landlock_add_rule.2       | 139 +++++++++++++
 man2/landlock_create_ruleset.2 | 134 +++++++++++++
 man2/landlock_restrict_self.2  | 125 ++++++++++++
 man7/landlock.7                | 354 +++++++++++++++++++++++++++++++++
 4 files changed, 752 insertions(+)
 create mode 100644 man2/landlock_add_rule.2
 create mode 100644 man2/landlock_create_ruleset.2
 create mode 100644 man2/landlock_restrict_self.2
 create mode 100644 man7/landlock.7


base-commit: 33248cfe50ebb8762208e7ef3264676dad71b016
-- 
2.32.0

