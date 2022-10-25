Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05AA7C38A2D
	for <linux-security-module@archiver.kernel.org>; Tue, 25 Oct 2022 06:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiJYGEB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 25 Oct 2022 02:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiJYGEA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 25 Oct 2022 02:04:00 -0400
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9620C10692D;
        Mon, 24 Oct 2022 23:03:57 -0700 (PDT)
Received: from ([60.208.111.195])
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id TGC00050;
        Tue, 25 Oct 2022 14:03:50 +0800
Received: from localhost.localdomain (10.200.104.97) by
 jtjnmail201608.home.langchao.com (10.100.2.8) with Microsoft SMTP Server id
 15.1.2507.12; Tue, 25 Oct 2022 14:03:44 +0800
From:   Bo Liu <liubo03@inspur.com>
To:     <paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>
CC:     <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Bo Liu <liubo03@inspur.com>
Subject: [PATCH] audit: Fix some kernel-doc warnings
Date:   Tue, 25 Oct 2022 02:03:33 -0400
Message-ID: <20221025060333.4295-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.200.104.97]
tUid:   2022102514035055d23a6c1e63b313281baf30bfa3057f
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The current code provokes some kernel-doc warnings:
    security/lsm_audit.c:198: warning: Function parameter or member 'ab' not described in 'dump_common_audit_data'

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 security/lsm_audit.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/lsm_audit.c b/security/lsm_audit.c
index 75cc3f8d2a42..ea5d35dce674 100644
--- a/security/lsm_audit.c
+++ b/security/lsm_audit.c
@@ -190,6 +190,7 @@ static inline void print_ipv4_addr(struct audit_buffer *ab, __be32 addr,
 
 /**
  * dump_common_audit_data - helper to dump common audit data
+ * @ab : the audit data to fill
  * @a : common audit data
  *
  */
-- 
2.27.0

