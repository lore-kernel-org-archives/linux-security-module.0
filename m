Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB058C0015E
	for <linux-security-module@archiver.kernel.org>; Tue, 25 Jul 2023 14:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjGYOOM (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 25 Jul 2023 10:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbjGYOOI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 25 Jul 2023 10:14:08 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BDC1FC9;
        Tue, 25 Jul 2023 07:14:03 -0700 (PDT)
Received: from dggpeml100024.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4R9JqL1f8mzLnwZ;
        Tue, 25 Jul 2023 22:11:26 +0800 (CST)
Received: from hulk-vt.huawei.com (10.67.174.26) by
 dggpeml100024.china.huawei.com (7.185.36.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 25 Jul 2023 22:14:00 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <john.johansen@canonical.com>, <paul@paul-moore.com>,
        <jmorris@namei.org>, <serge@hallyn.com>,
        <mike.salvatore@canonical.com>
CC:     <apparmor@lists.ubuntu.com>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] apparmor: cleanup unused declarations in policy.h
Date:   Tue, 25 Jul 2023 14:12:39 +0000
Message-ID: <20230725141239.233372-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.26]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml100024.china.huawei.com (7.185.36.115)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The implementions of these declarations do not exist, remove them all.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 security/apparmor/include/policy.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/security/apparmor/include/policy.h b/security/apparmor/include/policy.h
index 545f791cabda..6e5ec9c37b48 100644
--- a/security/apparmor/include/policy.h
+++ b/security/apparmor/include/policy.h
@@ -227,10 +227,6 @@ extern enum profile_mode aa_g_profile_mode;
 #define profiles_ns(P) ((P)->ns)
 #define name_is_shared(A, B) ((A)->hname && (A)->hname == (B)->hname)
 
-void aa_add_profile(struct aa_policy *common, struct aa_profile *profile);
-
-
-void aa_free_proxy_kref(struct kref *kref);
 struct aa_ruleset *aa_alloc_ruleset(gfp_t gfp);
 struct aa_profile *aa_alloc_profile(const char *name, struct aa_proxy *proxy,
 				    gfp_t gfp);
@@ -239,14 +235,12 @@ struct aa_profile *aa_alloc_null(struct aa_profile *parent, const char *name,
 struct aa_profile *aa_new_learning_profile(struct aa_profile *parent, bool hat,
 					   const char *base, gfp_t gfp);
 void aa_free_profile(struct aa_profile *profile);
-void aa_free_profile_kref(struct kref *kref);
 struct aa_profile *aa_find_child(struct aa_profile *parent, const char *name);
 struct aa_profile *aa_lookupn_profile(struct aa_ns *ns, const char *hname,
 				      size_t n);
 struct aa_profile *aa_lookup_profile(struct aa_ns *ns, const char *name);
 struct aa_profile *aa_fqlookupn_profile(struct aa_label *base,
 					const char *fqname, size_t n);
-struct aa_profile *aa_match_profile(struct aa_ns *ns, const char *name);
 
 ssize_t aa_replace_profiles(struct aa_ns *view, struct aa_label *label,
 			    u32 mask, struct aa_loaddata *udata);
-- 
2.34.1

