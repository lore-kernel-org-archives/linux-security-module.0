Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5D2C38145
	for <linux-security-module@archiver.kernel.org>; Thu,  8 Sep 2022 10:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiIHKkV (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 8 Sep 2022 06:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbiIHKkB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 8 Sep 2022 06:40:01 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4427D1EEE0;
        Thu,  8 Sep 2022 03:39:43 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MNb8v0YBXzZcMy;
        Thu,  8 Sep 2022 18:34:39 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 8 Sep 2022 18:39:09 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <casey@schaufler-ca.com>, <paul@paul-moore.com>,
        <jmorris@namei.org>, <serge@hallyn.com>
CC:     <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] smack: cleanup obsolete mount option flags
Date:   Thu, 8 Sep 2022 18:35:43 +0800
Message-ID: <20220908103543.194119-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

These mount option flags are obsolete since commit 12085b14a444 ("smack:
switch to private smack_mnt_opts"), remove them.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 security/smack/smack.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/security/smack/smack.h b/security/smack/smack.h
index fc837dcebf96..e2239be7bd60 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -180,15 +180,6 @@ struct smack_known_list_elem {
 	struct smack_known	*smk_label;
 };
 
-/* Super block security struct flags for mount options */
-#define FSDEFAULT_MNT	0x01
-#define FSFLOOR_MNT	0x02
-#define FSHAT_MNT	0x04
-#define FSROOT_MNT	0x08
-#define FSTRANS_MNT	0x10
-
-#define NUM_SMK_MNT_OPTS	5
-
 enum {
 	Opt_error = -1,
 	Opt_fsdefault = 0,
-- 
2.17.1

