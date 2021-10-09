Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D257CC433EF
	for <linux-security-module@archiver.kernel.org>; Sat,  9 Oct 2021 06:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0FB060F70
	for <linux-security-module@archiver.kernel.org>; Sat,  9 Oct 2021 06:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbhJIGas (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 9 Oct 2021 02:30:48 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:23357 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbhJIGar (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 9 Oct 2021 02:30:47 -0400
Received: from dggeme762-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HRFQJ0Wl2zYdZv;
        Sat,  9 Oct 2021 14:24:24 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.44) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Sat, 9 Oct 2021 14:28:48 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <jmorris@namei.org>, <serge@hallyn.com>
CC:     <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <xiujianfeng@huawei.com>,
        <wangweiyang2@huawei.com>
Subject: [PATCH -next] integrity: return early if audit_log_start return NULL
Date:   Sat, 9 Oct 2021 14:30:53 +0800
Message-ID: <20211009063053.187953-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.44]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

audit_log_start() may return NULL in below cases:
  - when audit is not initialized.
  - when audit backlog limit exceeds.

After the call to audit_log_start() is made and then possible NULL audit
buffer argument is passed to audit_log_*() functions, audit_log_*()
functions return immediately in case of a NULL audit buffer argument.

It is not necessary for audit_log_*() functions to be called with
NULL audit buffer argument, so return early when audit_log_start()
returns NULL.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 security/integrity/integrity_audit.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/integrity/integrity_audit.c b/security/integrity/integrity_audit.c
index 29220056207f..fbc032185d72 100644
--- a/security/integrity/integrity_audit.c
+++ b/security/integrity/integrity_audit.c
@@ -45,6 +45,8 @@ void integrity_audit_message(int audit_msgno, struct inode *inode,
 		return;
 
 	ab = audit_log_start(audit_context(), GFP_KERNEL, audit_msgno);
+	if (unlikely(!ab))
+		return;
 	audit_log_format(ab, "pid=%d uid=%u auid=%u ses=%u",
 			 task_pid_nr(current),
 			 from_kuid(&init_user_ns, current_uid()),
-- 
2.30.0

