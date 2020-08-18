Return-Path: <SRS0=wQ8B=B4=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF137C433DF
	for <linux-security-module@archiver.kernel.org>; Tue, 18 Aug 2020 15:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1D8D206DA
	for <linux-security-module@archiver.kernel.org>; Tue, 18 Aug 2020 15:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbgHRP03 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 18 Aug 2020 11:26:29 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2631 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728101AbgHRP00 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 18 Aug 2020 11:26:26 -0400
Received: from lhreml722-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id CFC71144517D897E9DA3;
        Tue, 18 Aug 2020 16:26:24 +0100 (IST)
Received: from kstruczy-linux-box (10.204.65.138) by
 lhreml722-chm.china.huawei.com (10.201.108.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 18 Aug 2020 16:26:22 +0100
Received: by kstruczy-linux-box (sSMTP sendmail emulation); Tue, 18 Aug 2020 17:26:25 +0200
From:   <krzysztof.struczynski@huawei.com>
To:     <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <containers@lists.linux-foundation.org>,
        <linux-security-module@vger.kernel.org>
CC:     Krzysztof Struczynski <krzysztof.struczynski@huawei.com>,
        <zohar@linux.ibm.com>, <stefanb@linux.vnet.ibm.com>,
        <sunyuqiong1988@gmail.com>, <mkayaalp@cs.binghamton.edu>,
        <dmitry.kasatkin@gmail.com>, <serge@hallyn.com>,
        <jmorris@namei.org>, <christian@brauner.io>,
        <silviu.vlasceanu@huawei.com>, <roberto.sassu@huawei.com>
Subject: [RFC PATCH 08/30] ima: Add integrity inode related data to the ima namespace
Date:   Tue, 18 Aug 2020 17:20:15 +0200
Message-ID: <20200818152037.11869-9-krzysztof.struczynski@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200818152037.11869-1-krzysztof.struczynski@huawei.com>
References: <N>
 <20200818152037.11869-1-krzysztof.struczynski@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.65.138]
X-ClientProxiedBy: fraeml707-chm.china.huawei.com (10.206.15.35) To
 lhreml722-chm.china.huawei.com (10.201.108.73)
X-CFilter-Loop: Reflected
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>

Add an iint tree to the ima namespace. Each namespace should track
operations on its objects separately. Per namespace iint tree is not
yet used, it will be done in the following patches.

Signed-off-by: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
---
 include/linux/ima.h               |  1 +
 security/integrity/ima/ima_init.c |  1 +
 security/integrity/ima/ima_ns.c   | 17 +++++++++++++++--
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 3fd3746a0dee..9069aafd905f 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -190,6 +190,7 @@ struct ima_namespace {
 	atomic_t inactive; /* set only when ns is added to the cleanup list */
 	bool frozen;
 	struct ima_policy_data *policy_data;
+	struct integrity_iint_tree *iint_tree;
 } __randomize_layout;
 
 extern struct ima_namespace init_ima_ns;
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index ea5ff42eb7fe..be1afc42fdf5 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -34,6 +34,7 @@ struct ima_namespace init_ima_ns = {
 #endif
 	.frozen = true,
 	.policy_data = &init_policy_data,
+	.iint_tree = &init_iint_tree,
 };
 EXPORT_SYMBOL(init_ima_ns);
 
diff --git a/security/integrity/ima/ima_ns.c b/security/integrity/ima/ima_ns.c
index 1aeb9cfeb3a2..226a53279f71 100644
--- a/security/integrity/ima/ima_ns.c
+++ b/security/integrity/ima/ima_ns.c
@@ -56,11 +56,18 @@ static struct ima_namespace *ima_ns_alloc(void)
 	ima_ns->policy_data = kzalloc(sizeof(struct ima_policy_data),
 				      GFP_KERNEL);
 	if (!ima_ns->policy_data)
-		goto out_free;
+		goto ns_free;
+
+	ima_ns->iint_tree = kzalloc(sizeof(struct integrity_iint_tree),
+				    GFP_KERNEL);
+	if (!ima_ns->iint_tree)
+		goto policy_free;
 
 	return ima_ns;
 
-out_free:
+policy_free:
+	kfree(ima_ns->policy_data);
+ns_free:
 	kfree(ima_ns);
 out:
 	return NULL;
@@ -120,6 +127,9 @@ static struct ima_namespace *clone_ima_ns(struct user_namespace *user_ns,
 	ns->ucounts = ucounts;
 	ns->frozen = false;
 
+	rwlock_init(&ns->iint_tree->lock);
+	ns->iint_tree->root = RB_ROOT;
+
 	INIT_LIST_HEAD(&ns->policy_data->ima_default_rules);
 	INIT_LIST_HEAD(&ns->policy_data->ima_policy_rules);
 	INIT_LIST_HEAD(&ns->policy_data->ima_temp_rules);
@@ -127,6 +137,7 @@ static struct ima_namespace *clone_ima_ns(struct user_namespace *user_ns,
 	return ns;
 
 fail_free:
+	kfree(ns->iint_tree);
 	kfree(ns->policy_data);
 	kfree(ns);
 fail_dec:
@@ -173,6 +184,8 @@ static void destroy_ima_ns(struct ima_namespace *ns)
 	dec_ima_namespaces(ns->ucounts);
 	put_user_ns(ns->user_ns);
 	ns_free_inum(&ns->ns);
+	integrity_iint_tree_free(ns->iint_tree);
+	kfree(ns->iint_tree);
 	kfree(ns->policy_data);
 	kfree(ns);
 }
-- 
2.20.1

