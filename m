Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D891FA3741
	for <linux-security-module@archiver.kernel.org>; Sat, 29 Oct 2022 01:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiJ2B21 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 28 Oct 2022 21:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiJ2B20 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 28 Oct 2022 21:28:26 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325B013F87;
        Fri, 28 Oct 2022 18:28:26 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MzhYp6j8DzFqRp;
        Sat, 29 Oct 2022 09:25:34 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 29 Oct 2022 09:28:24 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <john.johansen@canonical.com>, <paul@paul-moore.com>,
        <jmorris@namei.org>, <serge@hallyn.com>
CC:     <apparmor@lists.ubuntu.com>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] apparmor: Add __init annotation to aa_{setup/teardown}_dfa_engine()
Date:   Sat, 29 Oct 2022 09:25:05 +0800
Message-ID: <20221029012505.227136-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The aa_setup_dfa_engine() and aa_teardown_dfa_engine() is only called in
apparmor_init(), so let us add __init annotation to them.

Fixes: 11c236b89d7c ("apparmor: add a default null dfa")
Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 security/apparmor/match.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/apparmor/match.c b/security/apparmor/match.c
index 5095c26ca683..b97ef5e1db73 100644
--- a/security/apparmor/match.c
+++ b/security/apparmor/match.c
@@ -31,7 +31,7 @@ static char stacksplitdfa_src[] = {
 };
 struct aa_dfa *stacksplitdfa;
 
-int aa_setup_dfa_engine(void)
+int __init aa_setup_dfa_engine(void)
 {
 	int error;
 
@@ -59,7 +59,7 @@ int aa_setup_dfa_engine(void)
 	return 0;
 }
 
-void aa_teardown_dfa_engine(void)
+void __init aa_teardown_dfa_engine(void)
 {
 	aa_put_dfa(stacksplitdfa);
 	aa_put_dfa(nulldfa);
-- 
2.17.1

