Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD44337160
	for <linux-security-module@vger.kernel.org>; Mon, 16 Jun 2025 01:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750036080; cv=none; b=Bo5a5r6kn/+vRSq9WJ1NfijFGhQ9W6Z9FxOeBlYK9+THa5jR9wTT2UlY1J9zAMOGbwAkTiMFSObSl/3Jn7mgaeWjMzky1d1xDnFSDqF9Hp5knMEErybo7353PT0WsoWbBY4st8AYuzbjTuEo1+TT8Fd4NCPrMclBsFve3iEqk9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750036080; c=relaxed/simple;
	bh=sC6FiVEJ2TVruBHSBzqXhmq9SbkuOFbh3z9dDXDurSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QUihBPoqQEKQMiAziGpAKp9pa5HIAL25GtUy5wKrN/CU9+OOIoAReRDkQyqa2TVsNXzORC5TdCb1Y8p7TO260sf2rgLwMB/0Lc0pqwtvUwW2GPcjawMcAGfLH+vuQkQK7QumEBfssRQO8h5QPYlBIoGLL1CK4l82eVgdB1mi6MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=OtenMro+; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="OtenMro+"
From: Konstantin Andreev <andreev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1750036068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+aIjKd6u0k44UngjZD5pe8eQFSTQye28hGDMq3xjmls=;
	b=OtenMro+Qk+P6Zx3DMsiQohbzhMVHOfJydrb6/d6h1AWKNPRhjEWGkPYpXiEVRQM4ZtWUl
	bepTQteUIpRSggEAMbJXgTUkzo1zsyZ2usQfI9OlRh0yHQtXJY++Mccg2Ipj7ecuvMkjTK
	hJMA9PVH+Bo7RxpzixiKvxz0tVMplR0=
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org
Subject: [PATCH 1/5] smack: deduplicate "does access rule request transmutation"
Date: Mon, 16 Jun 2025 04:07:28 +0300
Message-ID: <20250616010745.800386-2-andreev@swemel.ru>
In-Reply-To: <20250616010745.800386-1-andreev@swemel.ru>
References: <20250616010745.800386-1-andreev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Konstantin Andreev <andreev@swemel.ru>
---
 security/smack/smack_lsm.c | 57 +++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 25 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 99833168604e..a7292d286f7c 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -963,6 +963,24 @@ static int smack_inode_alloc_security(struct inode *inode)
 	return 0;
 }
 
+/**
+ * smk_rule_transmutes - does access rule for (subject,object) contain 't'?
+ * @subject: a pointer to the subject's Smack label entry
+ * @object: a pointer to the object's Smack label entry
+ */
+static bool
+smk_rule_transmutes(struct smack_known *subject,
+	      const struct smack_known *object)
+{
+	int may;
+
+	rcu_read_lock();
+	may = smk_access_entry(subject->smk_known, object->smk_known,
+			       &subject->smk_rules);
+	rcu_read_unlock();
+	return (may > 0) && (may & MAY_TRANSMUTE);
+}
+
 /**
  * smack_inode_init_security - copy out the smack from an inode
  * @inode: the newly created inode
@@ -978,23 +996,19 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 				     struct xattr *xattrs, int *xattr_count)
 {
 	struct task_smack *tsp = smack_cred(current_cred());
-	struct inode_smack *issp = smack_inode(inode);
-	struct smack_known *skp = smk_of_task(tsp);
-	struct smack_known *isp = smk_of_inode(inode);
+	struct inode_smack * const issp = smack_inode(inode);
 	struct smack_known *dsp = smk_of_inode(dir);
 	struct xattr *xattr = lsm_get_xattr_slot(xattrs, xattr_count);
-	int may;
+	bool trans_cred;
+	bool trans_rule;
 
 	/*
 	 * If equal, transmuting already occurred in
 	 * smack_dentry_create_files_as(). No need to check again.
 	 */
-	if (tsp->smk_task != tsp->smk_transmuted) {
-		rcu_read_lock();
-		may = smk_access_entry(skp->smk_known, dsp->smk_known,
-				       &skp->smk_rules);
-		rcu_read_unlock();
-	}
+	trans_cred = (tsp->smk_task == tsp->smk_transmuted);
+	if (!trans_cred)
+		trans_rule = smk_rule_transmutes(smk_of_task(tsp), dsp);
 
 	/*
 	 * In addition to having smk_task equal to smk_transmuted,
@@ -1002,9 +1016,7 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 	 * requests transmutation then by all means transmute.
 	 * Mark the inode as changed.
 	 */
-	if ((tsp->smk_task == tsp->smk_transmuted) ||
-	    (may > 0 && ((may & MAY_TRANSMUTE) != 0) &&
-	     smk_inode_transmutable(dir))) {
+	if (trans_cred || (trans_rule && smk_inode_transmutable(dir))) {
 		struct xattr *xattr_transmute;
 
 		/*
@@ -1013,8 +1025,8 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 		 * inode label was already set correctly in
 		 * smack_inode_alloc_security().
 		 */
-		if (tsp->smk_task != tsp->smk_transmuted)
-			isp = issp->smk_inode = dsp;
+		if (!trans_cred)
+			issp->smk_inode = dsp;
 
 		issp->smk_flags |= SMK_INODE_TRANSMUTE;
 		xattr_transmute = lsm_get_xattr_slot(xattrs,
@@ -1034,11 +1046,13 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 	issp->smk_flags |= SMK_INODE_INSTANT;
 
 	if (xattr) {
-		xattr->value = kstrdup(isp->smk_known, GFP_NOFS);
+		const char *inode_label = issp->smk_inode->smk_known;
+
+		xattr->value = kstrdup(inode_label, GFP_NOFS);
 		if (!xattr->value)
 			return -ENOMEM;
 
-		xattr->value_len = strlen(isp->smk_known);
+		xattr->value_len = strlen(inode_label);
 		xattr->name = XATTR_SMACK_SUFFIX;
 	}
 
@@ -4922,7 +4936,6 @@ static int smack_dentry_create_files_as(struct dentry *dentry, int mode,
 	struct task_smack *otsp = smack_cred(old);
 	struct task_smack *ntsp = smack_cred(new);
 	struct inode_smack *isp;
-	int may;
 
 	/*
 	 * Use the process credential unless all of
@@ -4936,18 +4949,12 @@ static int smack_dentry_create_files_as(struct dentry *dentry, int mode,
 	isp = smack_inode(d_inode(dentry->d_parent));
 
 	if (isp->smk_flags & SMK_INODE_TRANSMUTE) {
-		rcu_read_lock();
-		may = smk_access_entry(otsp->smk_task->smk_known,
-				       isp->smk_inode->smk_known,
-				       &otsp->smk_task->smk_rules);
-		rcu_read_unlock();
-
 		/*
 		 * If the directory is transmuting and the rule
 		 * providing access is transmuting use the containing
 		 * directory label instead of the process label.
 		 */
-		if (may > 0 && (may & MAY_TRANSMUTE)) {
+		if (smk_rule_transmutes(otsp->smk_task, isp->smk_inode)) {
 			ntsp->smk_task = isp->smk_inode;
 			ntsp->smk_transmuted = ntsp->smk_task;
 		}
-- 
2.43.0

