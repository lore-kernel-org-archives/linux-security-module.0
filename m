Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D977AC38A2D
	for <linux-security-module@archiver.kernel.org>; Wed, 26 Oct 2022 00:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbiJZA6M (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 25 Oct 2022 20:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbiJZA6K (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 25 Oct 2022 20:58:10 -0400
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49597B56F5;
        Tue, 25 Oct 2022 17:58:07 -0700 (PDT)
Received: from ([60.208.111.195])
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id UAG00101;
        Wed, 26 Oct 2022 08:58:01 +0800
Received: from localhost.localdomain (10.200.104.97) by
 jtjnmail201601.home.langchao.com (10.100.2.1) with Microsoft SMTP Server id
 15.1.2507.12; Wed, 26 Oct 2022 08:58:01 +0800
From:   Bo Liu <liubo03@inspur.com>
To:     <paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>
CC:     <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Deming Wang <wangdeming@inspur.com>
Subject: [PATCH v2 1/1] audit: Fix some kernel-doc warnings
Date:   Tue, 25 Oct 2022 20:57:58 -0400
Message-ID: <20221026005758.2698-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.200.104.97]
tUid:   202210260858018d64d7d084e4d114d7ecf05d3f8b92d6
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Deming Wang <wangdeming@inspur.com>

The current code provokes some kernel-doc warnings:
    security/lsm_audit.c:198: warning: Function parameter or member 'ab' not described in 'dump_common_audit_data'

Signed-off-by: Deming Wang <wangdeming@inspur.com>
---
 security/lsm_audit.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/lsm_audit.c b/security/lsm_audit.c
index 75cc3f8d2a42..a7355b4b9bb8 100644
--- a/security/lsm_audit.c
+++ b/security/lsm_audit.c
@@ -190,6 +190,7 @@ static inline void print_ipv4_addr(struct audit_buffer *ab, __be32 addr,
 
 /**
  * dump_common_audit_data - helper to dump common audit data
+ * @ab : the audit buffer
  * @a : common audit data
  *
  */
-- 
2.27.0

