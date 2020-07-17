Return-Path: <SRS0=cbB2=A4=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25C1C433E0
	for <linux-security-module@archiver.kernel.org>; Fri, 17 Jul 2020 23:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBDA92074B
	for <linux-security-module@archiver.kernel.org>; Fri, 17 Jul 2020 23:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m7fQ2ZJF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbgGQXgr (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 17 Jul 2020 19:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgGQXgq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 17 Jul 2020 19:36:46 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D5CC0619D2;
        Fri, 17 Jul 2020 16:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:To:Subject:From:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=mkX/ah17OVLRBacoUS3nKdwkxsYUYiMcrZQmci/tyWQ=; b=m7fQ2ZJFqMp++APxnsBJQ19V8j
        WfwNMmHWEDN0t9Enf1XfEW9zpX/bIImLlMSh/vmIVQutcRT6SJaptqF2NMHt9tjzyh/MIhbZylH7x
        4G4CUCh6G0U4ymKImtoCeZDi4KH6fVUQTInt8CmVMDSCBPiMzRZVWujjhor3RkiTzfk0FLrvns1VS
        dVy7l9TT8nHuwq9zqvKKkWHEwHAJeU/dxEBc+j4KFXJ0EoFJRv1CcBkiLhC9yNvXCkErD5vnuaazg
        pfJDeugaXsqZmJhaZ4Oq08MDjMVZl18DRMkjDm+xKcmOo4F1RAx8bzJvN4ksVIW/BTbDhy5FUznN/
        0Uh76lnw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwZuG-0006XN-40; Fri, 17 Jul 2020 23:36:44 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] LSM: drop duplicated words in header file comments
To:     LKML <linux-kernel@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module <linux-security-module@vger.kernel.org>
Message-ID: <9299abf4-75e3-6d73-a8b8-c2617208a990@infradead.org>
Date:   Fri, 17 Jul 2020 16:36:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Randy Dunlap <rdunlap@infradead.org>

Drop the doubled words "the" and "and" in comments.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org
---
 include/linux/lsm_hook_defs.h |    2 +-
 include/linux/lsm_hooks.h     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20200714.orig/include/linux/lsm_hook_defs.h
+++ linux-next-20200714/include/linux/lsm_hook_defs.h
@@ -15,7 +15,7 @@
  */
 
 /*
- * The macro LSM_HOOK is used to define the data structures required by the
+ * The macro LSM_HOOK is used to define the data structures required by
  * the LSM framework using the pattern:
  *
  *	LSM_HOOK(<return_type>, <default_value>, <hook_name>, args...)
--- linux-next-20200714.orig/include/linux/lsm_hooks.h
+++ linux-next-20200714/include/linux/lsm_hooks.h
@@ -822,7 +822,7 @@
  *	structure. Note that the security field was not added directly to the
  *	socket structure, but rather, the socket security information is stored
  *	in the associated inode.  Typically, the inode alloc_security hook will
- *	allocate and and attach security information to
+ *	allocate and attach security information to
  *	SOCK_INODE(sock)->i_security.  This hook may be used to update the
  *	SOCK_INODE(sock)->i_security field with additional information that
  *	wasn't available when the inode was allocated.


