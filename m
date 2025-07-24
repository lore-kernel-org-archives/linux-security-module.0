Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4732D77F1
	for <linux-security-module@vger.kernel.org>; Thu, 24 Jul 2025 13:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753363214; cv=none; b=Q3a/LsNUmC/MvmwN7Ux1v3ajh9qafG081O/ONYLFcPZVZpTec0oPNVKnbk4OxxhyIwozzF01ogQcCofT0eC2fCoU7t6iJWeuCgv45k6DV9cNAqI2SgddiF6kUVzBal9Et3/Hp1K2T6kI0aRhrz4FMY7agMPEy6wRoZ3lqN0lUTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753363214; c=relaxed/simple;
	bh=/9vFDBPGMRFWsmmc2G8vrgrFdHH30SptzmsK++WuB+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hDhV45p4/gOqikk/m6AKIKnj4aWExmMP2ndLDpdeWAdLoGXLtulLuf/ywnhX6i16iKv6soFg7aT8qN1zes/fMKKSYmDtet/MHrREVuCBpImH/YgJqXBSUsUDtqhI8gHghpZY44a6o0p16dfE4lKFLyodudF6kL7tY3khgFtDV58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=jrNFgvQw; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="jrNFgvQw"
From: Konstantin Andreev <andreev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1753362621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KxgI/jMP79/JDWegobrSDvfa7kaVU4yGIXj32r516UA=;
	b=jrNFgvQww4DN/JtxhoOAQMPbejwUNAL0SMLynfnJQBjBsbBb2BmX+sLkiPYRaqx7/RYD15
	LmZOttFaGGMvy5X0eJE9POGn14F5QmlXIE3XyeAjg7zr3gsXghrTwiNFpU5n+PMgsy8bVL
	EjKr2/WuhHZPE0JDFoO23Hn/Rwymct8=
To: casey@schaufler-ca.com
Cc: linux-security-module@vger.kernel.org
Subject: [PATCH 03/19] smack: fix bug: setting label-containing xattrs silently ignores input garbage
Date: Thu, 24 Jul 2025 16:09:36 +0300
Message-ID: <ae1100894499a1f6ce8e783727635388b3ac3af8.1753356770.git.andreev@swemel.ru>
In-Reply-To: <cover.1753356770.git.andreev@swemel.ru>
References: <cover.1753356770.git.andreev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following command:
    # setfattr -n security.SMACK64 -v foo/bar FILE

sets the label of FILE to 'foo' w/o indication
that label does not match input.

This happens due to the use of an unsuitable parsing
function: smk_import_entry(), which acquires only
that part from the beginning of the input
that looks like a label.

This is exactly the same issue as described in [1],
but it occurs with Smack label-containing xattrs
instead of /proc/PID/attr/smack/current.

Curiously,

    # setfattr -n security.SMACK64     -v foo/bar FILE
    # setfattr -n security.SMACK64EXEC -v fo2/ba2 FILE
    # setfattr -n security.SMACK64MMAP -v fo3/ba3 FILE
    # getfattr -hd -m - FILE
    security.SMACK64="foo"            // garbage ignored
    security.SMACK64EXEC="fo2/ba2"    // garbage taken?!
    security.SMACK64MMAP="fo3/ba3"    // garbage taken?!

It looks like label-containing xattrs SMACK64EXEC
and SMACK64MMAP can acquire invalid Smack label.

In fact, inode contains the labels `fo2' and `fo3',
but, due to another Smack bug [2] we do not see them -
instead we see the on-disk content of the SMACK64EXEC
and SMACK64MMAP xattrs, that is, indeed, `fo2/ba2'
and `fo3/ba3'

This change detects input garbage by adding a check:
   taken label length == input length
and indicates -EINVAL to the caller if they do not match

(2008-02-04 Casey Schaufler)
Fixes: e114e473771c ("Smack: Simplified Mandatory Access Control Kernel")

[1] 2025-06-17 andreev
commit 674e2b24791c ("smack: fix bug: setting task label
                      silently ignores input garbage")
Link: https://lore.kernel.org/linux-security-module/20250315015723.1357541-3-andreev@swemel.ru/

[2] 2025-07 andreev (forward reference)
commit ("smack: fix bug: getxattr() returns invalid SMACK64EXEC/MMAP")
Link: https://lore.kernel.org/linux-security-module/ba2af0356940d61d932af15d4b1a265a61e7d16c.1753356770.git.andreev@swemel.ru/

Signed-off-by: Konstantin Andreev <andreev@swemel.ru>
---
 security/smack/smack_lsm.c | 81 +++++++++++++++++++++++++++-----------
 1 file changed, 57 insertions(+), 24 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 5a159a2653a6..4ef6355c84c0 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -263,6 +263,49 @@ static int smk_bu_credfile(const struct cred *cred, struct file *file,
 #define smk_bu_credfile(cred, file, mode, RC) (RC)
 #endif
 
+/**
+ * smk_parse_label - check @string (not \0-terminated) is a valid Smack label
+ * @string: a string to check, not \0-terminated
+ * @string_len: the length of the @string
+ *
+ * Return: 0 or an error code
+ */
+static int
+smk_parse_label(const char *string, size_t string_len)
+{
+	int label_len;
+
+	if (unlikely(string == NULL || string_len == 0 ||
+		     string_len >= SMK_LONGLABEL))
+		return -EINVAL;
+
+	label_len = smk_parse_label_len(string, string_len);
+	if (label_len < 0 ||         /* invalid label */
+	    label_len != string_len) /* garbage after label */
+		return -EINVAL;
+
+	return 0;
+}
+
+/**
+ * smk_import_label - import a label, return the list entry
+ * @string: a text string that may be a valid Smack label, not \0-terminated
+ * @string_len: the length of the text string in the @string
+ *
+ * Contrast to smk_import_entry(), the full @string_len of the @string
+ * must constitute a valid Smack label to be imported.
+ *
+ * Return: see description of smk_import_entry()
+ */
+static struct smack_known *
+smk_import_label(const char *string, int string_len)
+{
+	if (smk_parse_label(string, string_len))
+		return ERR_PTR(-EINVAL);
+
+	return smk_import_valid_label(string, string_len, GFP_NOFS);
+}
+
 /**
  * smk_fetch - Fetch the smack label from a file.
  * @name: type of the label (attribute)
@@ -1343,14 +1386,11 @@ static int smack_inode_setxattr(struct mnt_idmap *idmap,
 				struct dentry *dentry, const char *name,
 				const void *value, size_t size, int flags)
 {
-	int check_import = 0;
+	bool label_inside = true;
 	int check_star = 0;
 	struct inode * const inode = d_backing_inode(dentry);
 	umode_t const i_mode = inode->i_mode;
 
-	/*
-	 * Check label validity here so import won't fail in post_setxattr
-	 */
 	if (strcmp(name, XATTR_NAME_SMACK) == 0) {
 		/*
 		 * inode of socket file descriptor (sockfs inode) and
@@ -1358,19 +1398,18 @@ static int smack_inode_setxattr(struct mnt_idmap *idmap,
 		 */
 		if (S_ISSOCK(i_mode))
 			return -EINVAL;
-		check_import = 1;
 	} else if (strcmp(name, XATTR_NAME_SMACKIPIN) == 0 ||
 		   strcmp(name, XATTR_NAME_SMACKIPOUT) == 0) {
-		check_import = 1;
+		;
 	} else if (strcmp(name, XATTR_NAME_SMACKEXEC) == 0 ||
 		   strcmp(name, XATTR_NAME_SMACKMMAP) == 0) {
-		check_import = 1;
 		check_star = 1;
 	} else if (strcmp(name, XATTR_NAME_SMACKTRANSMUTE) == 0) {
 		if (!S_ISDIR(i_mode) ||
 		    size != TRANS_TRUE_SIZE ||
 		    strncmp(value, TRANS_TRUE, TRANS_TRUE_SIZE) != 0)
 			return -EINVAL;
+		label_inside = false;
 	} else {
 		/*
 		 * treat other xattrs as labeled data
@@ -1387,13 +1426,13 @@ static int smack_inode_setxattr(struct mnt_idmap *idmap,
 	if (!smack_privileged(CAP_MAC_ADMIN))
 		return -EPERM;
 
-	if (check_import) {
-		const struct smack_known *skp;
+	/*
+	 * Import label now, so import won't fail in smack_inode_post_setxattr
+	 */
+	if (label_inside) {
+		const struct smack_known * const skp =
+			smk_import_label(value, size);
 
-		if (size == 0)
-			return -EINVAL;
-
-		skp = smk_import_entry(value, size);
 		if (IS_ERR(skp))
 			return PTR_ERR(skp);
 
@@ -3781,23 +3820,17 @@ static int do_setattr(unsigned int attr, void *value, size_t size)
 	struct task_smack *tsp = smack_cred(current_cred());
 	struct cred *new;
 	struct smack_known *skp;
-	int label_len;
 
 	/*
 	 * let unprivileged user validate input, check permissions later
 	 */
-	if (value == NULL || size == 0 || size >= SMK_LONGLABEL)
+	if (smk_parse_label(value, size))
 		return -EINVAL;
-
-	label_len = smk_parse_label_len(value, size);
-	if (label_len < 0 || label_len != size)
-		return -EINVAL;
-
 	/*
 	 * No process is ever allowed the web ("@") label
 	 * and the star ("*") label.
 	 */
-	if (label_len == 1 /* '@', '*' */) {
+	if (size == 1 /* '@', '*' */) {
 		const char c = *(const char *)value;
 
 		if (c == *smack_known_web.smk_known ||
@@ -3810,8 +3843,8 @@ static int do_setattr(unsigned int attr, void *value, size_t size)
 		list_for_each_entry(sklep, &tsp->smk_relabel, list) {
 			const char *cp = sklep->smk_label->smk_known;
 
-			if (strlen(cp) == label_len &&
-			    strncmp(cp, value, label_len) == 0)
+			if (strlen(cp) == size &&
+			    strncmp(cp, value, size) == 0)
 				goto in_relabel;
 		}
 		return -EPERM;
@@ -3819,7 +3852,7 @@ static int do_setattr(unsigned int attr, void *value, size_t size)
 		;
 	}
 
-	skp = smk_import_valid_label(value, label_len, GFP_KERNEL);
+	skp = smk_import_valid_label(value, size, GFP_KERNEL);
 	if (IS_ERR(skp))
 		return PTR_ERR(skp);
 
-- 
2.43.0

