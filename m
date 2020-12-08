Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750CCC4361B
	for <linux-security-module@archiver.kernel.org>; Tue,  8 Dec 2020 10:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F10D217A0
	for <linux-security-module@archiver.kernel.org>; Tue,  8 Dec 2020 10:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbgLHKIf (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 8 Dec 2020 05:08:35 -0500
Received: from mga03.intel.com ([134.134.136.65]:7173 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727260AbgLHKIf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 8 Dec 2020 05:08:35 -0500
IronPort-SDR: cGXVqn3pMm1is2zyhSkoSNrV9soSL1SzAEGmVc+vzWhPbOcwARR3uVtSFgJJ7N9O+DFfydbhw2
 n9AuiML0QXLg==
X-IronPort-AV: E=McAfee;i="6000,8403,9828"; a="173979359"
X-IronPort-AV: E=Sophos;i="5.78,402,1599548400"; 
   d="scan'208";a="173979359"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 02:06:45 -0800
IronPort-SDR: DY/OKfubnP+etAUpBVSW0OIuB6mvZ6xrvC5sG9UaGtE1yXePkBZYeark2oJGKWrDCKFZ6dlW9k
 OUXG9MenEWWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,402,1599548400"; 
   d="scan'208";a="483579185"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 08 Dec 2020 02:06:44 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 471B516E; Tue,  8 Dec 2020 12:06:41 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn " <serge@hallyn.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] apparmor: Remove duplicate macro list_entry_is_head()
Date:   Tue,  8 Dec 2020 12:06:39 +0200
Message-Id: <20201208100639.88182-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Strangely I hadn't had noticed the existence of the list_entry_is_head() in
apparmor code when added the same one in the list.h. Luckily it's fully
identical and didn't break builds. In any case we don't need a duplicate
anymore, thus remove it from apparmor code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 security/apparmor/apparmorfs.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 5fd4a64e431f..f95c6bfa8b8e 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -2046,9 +2046,6 @@ int __aafs_ns_mkdir(struct aa_ns *ns, struct dentry *parent, const char *name,
 	return error;
 }
 
-
-#define list_entry_is_head(pos, head, member) (&pos->member == (head))
-
 /**
  * __next_ns - find the next namespace to list
  * @root: root namespace to stop search at (NOT NULL)
-- 
2.29.2

