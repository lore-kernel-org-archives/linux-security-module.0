Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DD2EB64DD
	for <linux-security-module@archiver.kernel.org>; Sun, 25 Jun 2023 01:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjFYBOL (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 24 Jun 2023 21:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjFYBN5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 24 Jun 2023 21:13:57 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5219EDD
        for <linux-security-module@vger.kernel.org>; Sat, 24 Jun 2023 18:13:54 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QpXwv2VfzztQSR;
        Sun, 25 Jun 2023 09:11:11 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 25 Jun 2023 09:13:51 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <john.johansen@canonical.com>, <paul@paul-moore.com>,
        <jmorris@namei.org>, <serge@hallyn.com>, <cuigaosheng1@huawei.com>
CC:     <apparmor@lists.ubuntu.com>,
        <linux-security-module@vger.kernel.org>
Subject: [PATCH -next 05/11] apparmor: Fix kernel-doc warnings in apparmor/label.c
Date:   Sun, 25 Jun 2023 09:13:43 +0800
Message-ID: <20230625011349.1457810-6-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230625011349.1457810-1-cuigaosheng1@huawei.com>
References: <20230625011349.1457810-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Fix kernel-doc warnings:

security/apparmor/label.c:166: warning: Excess function parameter
'n' description in 'vec_cmp'
security/apparmor/label.c:166: warning: Excess function parameter
'vec' description in 'vec_cmp'
security/apparmor/label.c:166: warning: Function parameter or member
'an' not described in 'vec_cmp'
security/apparmor/label.c:166: warning: Function parameter or member
'bn' not described in 'vec_cmp'
security/apparmor/label.c:166: warning: Function parameter or member
'b' not described in 'vec_cmp'
security/apparmor/label.c:2051: warning: Function parameter or member
'label' not described in '__label_update'
security/apparmor/label.c:266: warning: Function parameter or member
'flags' not described in 'aa_vec_unique'
security/apparmor/label.c:594: warning: Excess function parameter
'l' description in '__label_remove'
security/apparmor/label.c:594: warning: Function parameter or member
'label' not described in '__label_remove'
security/apparmor/label.c:929: warning: Function parameter or member
'label' not described in 'aa_label_insert'
security/apparmor/label.c:929: warning: Function parameter or member
'ls' not described in 'aa_label_insert'
security/apparmor/label.c:1221: warning: Excess function parameter
'ls' description in 'aa_label_merge'
security/apparmor/label.c:1302: warning: Excess function parameter
'start' description in 'label_compound_match'
security/apparmor/label.c:1302: warning: Function parameter or member
'rules' not described in 'label_compound_match'
security/apparmor/label.c:1302: warning: Function parameter or member
'state' not described in 'label_compound_match'
security/apparmor/label.c:2051: warning: Function parameter or member
'label' not described in '__label_update'

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 security/apparmor/label.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/security/apparmor/label.c b/security/apparmor/label.c
index 8a2af96f4da5..ce9c39102a93 100644
--- a/security/apparmor/label.c
+++ b/security/apparmor/label.c
@@ -154,9 +154,10 @@ static int profile_cmp(struct aa_profile *a, struct aa_profile *b)
 
 /**
  * vec_cmp - label comparison for set ordering
- * @a: label to compare (NOT NULL)
- * @vec: vector of profiles to compare (NOT NULL)
- * @n: length of @vec
+ * @a: aa_profile to compare (NOT NULL)
+ * @an: length of @a
+ * @b: aa_profile to compare (NOT NULL)
+ * @bn: length of @b
  *
  * Returns: <0  if a < vec
  *          ==0 if a == vec
@@ -256,6 +257,7 @@ static inline int unique(struct aa_profile **vec, int n)
  * aa_vec_unique - canonical sort and unique a list of profiles
  * @n: number of refcounted profiles in the list (@n > 0)
  * @vec: list of profiles to sort and merge
+ * @flags: null terminator flags of @vec
  *
  * Returns: the number of duplicates eliminated == references put
  *
@@ -584,7 +586,7 @@ bool aa_label_is_unconfined_subset(struct aa_label *set, struct aa_label *sub)
 
 /**
  * __label_remove - remove @label from the label set
- * @l: label to remove
+ * @label: label to remove
  * @new: label to redirect to
  *
  * Requires: labels_set(@label)->lock write_lock
@@ -917,8 +919,8 @@ struct aa_label *aa_label_find(struct aa_label *label)
 
 /**
  * aa_label_insert - insert label @label into @ls or return existing label
- * @ls - labelset to insert @label into
- * @label - label to insert
+ * @ls: labelset to insert @label into
+ * @label: label to insert
  *
  * Requires: caller to hold a valid ref on @label
  *
@@ -1204,7 +1206,6 @@ struct aa_label *aa_label_find_merge(struct aa_label *a, struct aa_label *b)
 
 /**
  * aa_label_merge - attempt to insert new merged label of @a and @b
- * @ls: set of labels to insert label into (NOT NULL)
  * @a: label to merge with @b  (NOT NULL)
  * @b: label to merge with @a  (NOT NULL)
  * @gfp: memory allocation type
@@ -1282,8 +1283,9 @@ static inline aa_state_t match_component(struct aa_profile *profile,
 /**
  * label_compound_match - find perms for full compound label
  * @profile: profile to find perms for
+ * @rules: ruleset to search
  * @label: label to check access permissions for
- * @start: state to start match in
+ * @state: state to start match in
  * @subns: whether to do permission checks on components in a subns
  * @request: permissions to request
  * @perms: perms struct to set
@@ -2037,7 +2039,7 @@ static struct aa_label *labelset_next_stale(struct aa_labelset *ls)
 
 /**
  * __label_update - insert updated version of @label into labelset
- * @label - the label to update/replace
+ * @label: the label to update/replace
  *
  * Returns: new label that is up to date
  *     else NULL on failure
-- 
2.25.1

