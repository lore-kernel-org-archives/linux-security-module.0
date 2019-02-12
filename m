Return-Path: <SRS0=n6I0=QT=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF16DC282C4
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Feb 2019 07:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7815206BA
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Feb 2019 07:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbfBLHoi (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 12 Feb 2019 02:44:38 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:51068 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728085AbfBLHoi (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 12 Feb 2019 02:44:38 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id F155BA36A7BBF9BCEDE5;
        Tue, 12 Feb 2019 15:44:33 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.408.0; Tue, 12 Feb 2019 15:44:24 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Micah Morton <mortonm@chromium.org>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-security-module@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] LSM: fix return value check in safesetid_init_securityfs()
Date:   Tue, 12 Feb 2019 07:58:31 +0000
Message-ID: <20190212075831.114668-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

In case of error, the function securityfs_create_dir() returns ERR_PTR()
and never returns NULL. The NULL test in the return value check should
be replaced with IS_ERR().

Fixes: aeca4e2ca65c ("LSM: add SafeSetID module that gates setid calls")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 security/safesetid/securityfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/safesetid/securityfs.c b/security/safesetid/securityfs.c
index 61be4ee459cc..2c6c829be044 100644
--- a/security/safesetid/securityfs.c
+++ b/security/safesetid/securityfs.c
@@ -167,7 +167,7 @@ static int __init safesetid_init_securityfs(void)
 		return 0;
 
 	safesetid_policy_dir = securityfs_create_dir("safesetid", NULL);
-	if (!safesetid_policy_dir) {
+	if (IS_ERR(safesetid_policy_dir)) {
 		ret = PTR_ERR(safesetid_policy_dir);
 		goto error;
 	}



