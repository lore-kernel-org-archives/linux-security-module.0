Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136C3C4338F
	for <linux-security-module@archiver.kernel.org>; Fri,  6 Aug 2021 07:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0E3461176
	for <linux-security-module@archiver.kernel.org>; Fri,  6 Aug 2021 07:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243545AbhHFHL6 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 6 Aug 2021 03:11:58 -0400
Received: from mail.astralinux.ru ([217.74.38.119]:49302 "EHLO
        mail.astralinux.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243542AbhHFHL5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 6 Aug 2021 03:11:57 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id D9A362F62F83;
        Fri,  6 Aug 2021 10:03:18 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id n8TIdoc5DHCY; Fri,  6 Aug 2021 10:03:18 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 1260E2F62F85;
        Fri,  6 Aug 2021 10:03:18 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id O-ZwCh5THrgZ; Fri,  6 Aug 2021 10:03:17 +0300 (MSK)
Received: from mastykin.cct.rbt (unknown [192.168.32.67])
        by mail.astralinux.ru (Postfix) with ESMTPSA id CB8442F62EDA;
        Fri,  6 Aug 2021 10:03:17 +0300 (MSK)
From:   Dmitry Mastykin <dmastykin@astralinux.ru>
To:     casey@schaufler-ca.com, linux-security-module@vger.kernel.org
Cc:     dmastykin@astralinux.ru, akovalenko@astralinux.ru
Subject: [PATCH 1/3] security/security: remove extra address-of in hook.audit_rule_match call
Date:   Fri,  6 Aug 2021 10:02:43 +0300
Message-Id: <20210806070245.26338-2-dmastykin@astralinux.ru>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210806070245.26338-1-dmastykin@astralinux.ru>
References: <20210806070245.26338-1-dmastykin@astralinux.ru>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Wrong address was passed to audit_rule_match hooks instead of
rule's address.

Signed-off-by: Dmitry Mastykin <dmastykin@astralinux.ru>
---
 security/security.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/security.c b/security/security.c
index e33c8ccc06a0..fd14064e9106 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2934,7 +2934,7 @@ int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
 			continue;
 		rc = hp->hook.audit_rule_match(blob->secid[hp->lsmid->slot],
 					       field, op,
-					       &lsmrule[hp->lsmid->slot]);
+					       lsmrule[hp->lsmid->slot]);
 		if (rc)
 			return rc;
 	}
-- 
2.11.0

