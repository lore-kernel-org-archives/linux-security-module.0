Return-Path: <SRS0=nZex=6M=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D16C83000
	for <linux-security-module@archiver.kernel.org>; Tue, 28 Apr 2020 11:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 526B4206D7
	for <linux-security-module@archiver.kernel.org>; Tue, 28 Apr 2020 11:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgD1LqW (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 28 Apr 2020 07:46:22 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3325 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726285AbgD1LqW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 28 Apr 2020 07:46:22 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BF27A4D8058AFB411182;
        Tue, 28 Apr 2020 19:46:16 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Tue, 28 Apr 2020 19:46:07 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <john.johansen@canonical.com>, <jmorris@namei.org>,
        <serge@hallyn.com>
CC:     <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] apparmor: Use true and false for bool variable
Date:   Tue, 28 Apr 2020 19:52:21 +0800
Message-ID: <1588074741-73393-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Fixes coccicheck warnings:

security/apparmor/file.c:162:9-10: WARNING: return of 0/1 in function 'is_deleted' with return type bool
security/apparmor/file.c:362:9-10: WARNING: return of 0/1 in function 'xindex_is_subset' with return type bool
security/apparmor/policy_unpack.c:246:9-10: WARNING: return of 0/1 in function 'unpack_X' with return type bool
security/apparmor/policy_unpack.c:292:9-10: WARNING: return of 0/1 in function 'unpack_nameX' with return type bool
security/apparmor/policy_unpack.c:646:8-9: WARNING: return of 0/1 in function 'unpack_rlimits' with return type bool
security/apparmor/policy_unpack.c:604:8-9: WARNING: return of 0/1 in function 'unpack_secmark' with return type bool
security/apparmor/policy_unpack.c:538:8-9: WARNING: return of 0/1 in function 'unpack_trans_table' with return type bool
security/apparmor/policy_unpack.c:327:9-10: WARNING: return of 0/1 in function 'unpack_u32' with return type bool
security/apparmor/policy_unpack.c:345:9-10: WARNING: return of 0/1 in function 'unpack_u64' with return type bool
security/apparmor/policy_unpack.c:309:9-10: WARNING: return of 0/1 in function 'unpack_u8' with return type bool
security/apparmor/policy_unpack.c:568:8-9: WARNING: return of 0/1 in function 'unpack_xattrs' with return type bool
security/apparmor/policy_unpack.c:1007:10-11: WARNING: return of 0/1 in function 'verify_dfa_xindex' with return type bool
security/apparmor/policy_unpack.c:997:9-10: WARNING: return of 0/1 in function 'verify_xindex' with return type bool

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 security/apparmor/file.c          | 12 ++++-----
 security/apparmor/policy_unpack.c | 54 +++++++++++++++++++--------------------
 2 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/security/apparmor/file.c b/security/apparmor/file.c
index f1caf36..9a2d14b 100644
--- a/security/apparmor/file.c
+++ b/security/apparmor/file.c
@@ -154,13 +154,13 @@ int aa_audit_file(struct aa_profile *profile, struct aa_perms *perms,
  * is_deleted - test if a file has been completely unlinked
  * @dentry: dentry of file to test for deletion  (NOT NULL)
  *
- * Returns: %1 if deleted else %0
+ * Returns: true if deleted else false
  */
 static inline bool is_deleted(struct dentry *dentry)
 {
 	if (d_unlinked(dentry) && d_backing_inode(dentry)->i_nlink == 0)
-		return 1;
-	return 0;
+		return true;
+	return false;
 }
 
 static int path_name(const char *op, struct aa_label *label,
@@ -353,15 +353,15 @@ int aa_path_perm(const char *op, struct aa_label *label,
  * this is done as part of the subset test, where a hardlink must have
  * a subset of permissions that the target has.
  *
- * Returns: %1 if subset else %0
+ * Returns: true if subset else false
  */
 static inline bool xindex_is_subset(u32 link, u32 target)
 {
 	if (((link & ~AA_X_UNSAFE) != (target & ~AA_X_UNSAFE)) ||
 	    ((link & AA_X_UNSAFE) && !(target & AA_X_UNSAFE)))
-		return 0;
+		return false;
 
-	return 1;
+	return true;
 }
 
 static int profile_path_link(struct aa_profile *profile,
diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index 2dfe078..b67322a 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -243,11 +243,11 @@ static size_t unpack_u16_chunk(struct aa_ext *e, char **chunk)
 static bool unpack_X(struct aa_ext *e, enum aa_code code)
 {
 	if (!inbounds(e, 1))
-		return 0;
+		return false;
 	if (*(u8 *) e->pos != code)
-		return 0;
+		return false;
 	e->pos++;
-	return 1;
+	return true;
 }
 
 /**
@@ -261,10 +261,10 @@ static bool unpack_X(struct aa_ext *e, enum aa_code code)
  * name element in the stream.  If @name is NULL any name element will be
  * skipped and only the typecode will be tested.
  *
- * Returns 1 on success (both type code and name tests match) and the read
+ * Returns true on success (both type code and name tests match) and the read
  * head is advanced past the headers
  *
- * Returns: 0 if either match fails, the read head does not move
+ * Returns: false if either match fails, the read head does not move
  */
 static bool unpack_nameX(struct aa_ext *e, enum aa_code code, const char *name)
 {
@@ -289,11 +289,11 @@ static bool unpack_nameX(struct aa_ext *e, enum aa_code code, const char *name)
 
 	/* now check if type code matches */
 	if (unpack_X(e, code))
-		return 1;
+		return true;
 
 fail:
 	e->pos = pos;
-	return 0;
+	return false;
 }
 
 static bool unpack_u8(struct aa_ext *e, u8 *data, const char *name)
@@ -306,12 +306,12 @@ static bool unpack_u8(struct aa_ext *e, u8 *data, const char *name)
 		if (data)
 			*data = get_unaligned((u8 *)e->pos);
 		e->pos += sizeof(u8);
-		return 1;
+		return true;
 	}
 
 fail:
 	e->pos = pos;
-	return 0;
+	return false;
 }
 
 static bool unpack_u32(struct aa_ext *e, u32 *data, const char *name)
@@ -324,12 +324,12 @@ static bool unpack_u32(struct aa_ext *e, u32 *data, const char *name)
 		if (data)
 			*data = le32_to_cpu(get_unaligned((__le32 *) e->pos));
 		e->pos += sizeof(u32);
-		return 1;
+		return true;
 	}
 
 fail:
 	e->pos = pos;
-	return 0;
+	return false;
 }
 
 static bool unpack_u64(struct aa_ext *e, u64 *data, const char *name)
@@ -342,12 +342,12 @@ static bool unpack_u64(struct aa_ext *e, u64 *data, const char *name)
 		if (data)
 			*data = le64_to_cpu(get_unaligned((__le64 *) e->pos));
 		e->pos += sizeof(u64);
-		return 1;
+		return true;
 	}
 
 fail:
 	e->pos = pos;
-	return 0;
+	return false;
 }
 
 static size_t unpack_array(struct aa_ext *e, const char *name)
@@ -472,7 +472,7 @@ static struct aa_dfa *unpack_dfa(struct aa_ext *e)
  * @e: serialized data extent information  (NOT NULL)
  * @profile: profile to add the accept table to (NOT NULL)
  *
- * Returns: 1 if table successfully unpacked
+ * Returns: true if table successfully unpacked
  */
 static bool unpack_trans_table(struct aa_ext *e, struct aa_profile *profile)
 {
@@ -535,12 +535,12 @@ static bool unpack_trans_table(struct aa_ext *e, struct aa_profile *profile)
 		if (!unpack_nameX(e, AA_STRUCTEND, NULL))
 			goto fail;
 	}
-	return 1;
+	return true;
 
 fail:
 	aa_free_domain_entries(&profile->file.trans);
 	e->pos = saved_pos;
-	return 0;
+	return false;
 }
 
 static bool unpack_xattrs(struct aa_ext *e, struct aa_profile *profile)
@@ -565,11 +565,11 @@ static bool unpack_xattrs(struct aa_ext *e, struct aa_profile *profile)
 			goto fail;
 	}
 
-	return 1;
+	return true;
 
 fail:
 	e->pos = pos;
-	return 0;
+	return false;
 }
 
 static bool unpack_secmark(struct aa_ext *e, struct aa_profile *profile)
@@ -601,7 +601,7 @@ static bool unpack_secmark(struct aa_ext *e, struct aa_profile *profile)
 			goto fail;
 	}
 
-	return 1;
+	return true;
 
 fail:
 	if (profile->secmark) {
@@ -613,7 +613,7 @@ static bool unpack_secmark(struct aa_ext *e, struct aa_profile *profile)
 	}
 
 	e->pos = pos;
-	return 0;
+	return false;
 }
 
 static bool unpack_rlimits(struct aa_ext *e, struct aa_profile *profile)
@@ -643,11 +643,11 @@ static bool unpack_rlimits(struct aa_ext *e, struct aa_profile *profile)
 		if (!unpack_nameX(e, AA_STRUCTEND, NULL))
 			goto fail;
 	}
-	return 1;
+	return true;
 
 fail:
 	e->pos = pos;
-	return 0;
+	return false;
 }
 
 static u32 strhash(const void *data, u32 len, u32 seed)
@@ -994,8 +994,8 @@ static bool verify_xindex(int xindex, int table_size)
 	xtype = xindex & AA_X_TYPE_MASK;
 	index = xindex & AA_X_INDEX_MASK;
 	if (xtype == AA_X_TABLE && index >= table_size)
-		return 0;
-	return 1;
+		return false;
+	return true;
 }
 
 /* verify dfa xindexes are in range of transition tables */
@@ -1004,11 +1004,11 @@ static bool verify_dfa_xindex(struct aa_dfa *dfa, int table_size)
 	int i;
 	for (i = 0; i < dfa->tables[YYTD_ID_ACCEPT]->td_lolen; i++) {
 		if (!verify_xindex(dfa_user_xindex(dfa, i), table_size))
-			return 0;
+			return false;
 		if (!verify_xindex(dfa_other_xindex(dfa, i), table_size))
-			return 0;
+			return false;
 	}
-	return 1;
+	return true;
 }
 
 /**
-- 
2.6.2

