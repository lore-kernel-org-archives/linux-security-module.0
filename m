Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70704C4320A
	for <linux-security-module@archiver.kernel.org>; Fri,  6 Aug 2021 07:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50D0D61176
	for <linux-security-module@archiver.kernel.org>; Fri,  6 Aug 2021 07:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243542AbhHFHL6 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 6 Aug 2021 03:11:58 -0400
Received: from mail.astralinux.ru ([217.74.38.119]:49298 "EHLO
        mail.astralinux.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239010AbhHFHL5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 6 Aug 2021 03:11:57 -0400
X-Greylist: delayed 499 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Aug 2021 03:11:57 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id DD4862F62F8A;
        Fri,  6 Aug 2021 10:03:19 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id wYPhscJ5BwPK; Fri,  6 Aug 2021 10:03:18 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 1FFFC2F62F87;
        Fri,  6 Aug 2021 10:03:18 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qNl7VpyTGJ2b; Fri,  6 Aug 2021 10:03:18 +0300 (MSK)
Received: from mastykin.cct.rbt (unknown [192.168.32.67])
        by mail.astralinux.ru (Postfix) with ESMTPSA id 010AD2F62ED8;
        Fri,  6 Aug 2021 10:03:17 +0300 (MSK)
From:   Dmitry Mastykin <dmastykin@astralinux.ru>
To:     casey@schaufler-ca.com, linux-security-module@vger.kernel.org
Cc:     dmastykin@astralinux.ru, akovalenko@astralinux.ru
Subject: [PATCH 3/3] kernel/auditsc: use correct blob for files in security_audit_rule_match call
Date:   Fri,  6 Aug 2021 10:02:45 +0300
Message-Id: <20210806070245.26338-4-dmastykin@astralinux.ru>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210806070245.26338-1-dmastykin@astralinux.ru>
References: <20210806070245.26338-1-dmastykin@astralinux.ru>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

File audit didn't work. Uninitialized local structure was passed
to security_audit_rule_match instead of audit_names oblob.

Signed-off-by: Dmitry Mastykin <dmastykin@astralinux.ru>
---
 kernel/auditsc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index c314533dd220..3b1afdb5cda4 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -689,14 +689,14 @@ static int audit_filter_rules(struct task_struct *tsk,
 				/* Find files that match */
 				if (name) {
 					result = security_audit_rule_match(
-								&blob,
+								&name->oblob,
 								f->type,
 								f->op,
 								f->lsm_rules);
 				} else if (ctx) {
 					list_for_each_entry(n, &ctx->names_list, list) {
 						if (security_audit_rule_match(
-								&blob,
+								&n->oblob,
 								f->type,
 								f->op,
 								f->lsm_rules)) {
-- 
2.11.0

