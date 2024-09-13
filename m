Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C781BC2A
	for <linux-security-module@vger.kernel.org>; Fri, 13 Sep 2024 14:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726238882; cv=none; b=dDhk1HgA3O3S2pPd25t/+5xr6oGP75G0LLa9TkLORFEWrpNmUAZ5YFJ04GwaQ2fK+tcxK0UNFtFT/OO3Vj9VeLLh1n4MYBUFixyoziSoUtpRJpaI9P+L3dYnUli4gAbOaDsuRSEtolw4P4UmEHxJPWEGYcNPGRKrMrXrxOGEEHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726238882; c=relaxed/simple;
	bh=CDzCnWJIOxO58o+gnF33MDxrMuwCUyWEFqlaeAG8r/A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jqrWpqHukmwpQrf3Mg5sF5oox7BmsJKk1bTIYcA9O50Ae0ZfwyX8/vd4EQ0kAGadzxQfScVGRXMgmkrWI0GNegH5GG4xryGF+hOhf7tN0UvfSXLwU3xGBLESfWeX86QItnLgwcIz/qh2Kc716JQqnQBrkAcqZfEVGfPBIpO9PUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=lhuyG8RQ; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="lhuyG8RQ"
From: Konstantin Andreev <andreev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1726238873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4v5ueY6qFnnYS4l3w+3s5oMamcYBPXiRUvZg9TC3CjY=;
	b=lhuyG8RQNpasJJ58M5/zZKqhwzbf+X2N9tdyviBSTSjjEvuOtrp62CgcaXNH0AbY4/UOcs
	U27B4QhPDoY4cBP9p9XVmCGfSYW7hv8D7qFbw+LyyFgtzjOJPx58mr7ezZ8+5LOScmHinC
	1yPXMO+5x1qMOiBG4UkwPZhhFtIzbek=
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org
Subject: [PATCH] smack: deduplicate access to string conversion
Date: Fri, 13 Sep 2024 17:46:59 +0300
Message-ID: <20240913144727.1839137-1-andreev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Konstantin Andreev <andreev@swemel.ru>
---
Currently, access bitfield is converted to string in 3 different places.
This patch consolidates conversion in one place.
The patch is against `next' branch at https://github.com/cschaufler/smack-next
The patch does not hurt `Smack kernel test suite' https://github.com/smack-team/smack-testsuite.git

 security/smack/smack.h        |  1 +
 security/smack/smack_access.c | 10 ++++++++--
 security/smack/smack_lsm.c    | 18 +-----------------
 security/smack/smackfs.c      | 26 +++++---------------------
 4 files changed, 15 insertions(+), 40 deletions(-)

diff --git a/security/smack/smack.h b/security/smack/smack.h
index 041688e5a77a..9e17e813fd1f 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -280,6 +280,7 @@ int smk_access(struct smack_known *, struct smack_known *,
 int smk_tskacc(struct task_smack *, struct smack_known *,
 	       u32, struct smk_audit_info *);
 int smk_curacc(struct smack_known *, u32, struct smk_audit_info *);
+int smack_str_from_perm(char *string, int access);
 struct smack_known *smack_from_secid(const u32);
 char *smk_parse_smack(const char *string, int len);
 int smk_netlbl_mls(int, char *, struct netlbl_lsm_secattr *, int);
diff --git a/security/smack/smack_access.c b/security/smack/smack_access.c
index 585e5e35710b..3727379623e2 100644
--- a/security/smack/smack_access.c
+++ b/security/smack/smack_access.c
@@ -275,7 +275,6 @@ int smk_curacc(struct smack_known *obj_known,
 	return smk_tskacc(tsp, obj_known, mode, a);
 }
 
-#ifdef CONFIG_AUDIT
 /**
  * smack_str_from_perm : helper to transalate an int to a
  * readable string
@@ -283,7 +282,7 @@ int smk_curacc(struct smack_known *obj_known,
  * @access : the int
  *
  */
-static inline void smack_str_from_perm(char *string, int access)
+int smack_str_from_perm(char *string, int access)
 {
 	int i = 0;
 
@@ -299,8 +298,15 @@ static inline void smack_str_from_perm(char *string, int access)
 		string[i++] = 't';
 	if (access & MAY_LOCK)
 		string[i++] = 'l';
+	if (access & MAY_BRINGUP)
+		string[i++] = 'b';
+	if (i == 0)
+		string[i++] = '-';
 	string[i] = '\0';
+	return i;
 }
+
+#ifdef CONFIG_AUDIT
 /**
  * smack_log_callback - SMACK specific information
  * will be called by generic audit code
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 4164699cd4f6..e0c2a2c6add3 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -107,23 +107,7 @@ static char *smk_bu_mess[] = {
 
 static void smk_bu_mode(int mode, char *s)
 {
-	int i = 0;
-
-	if (mode & MAY_READ)
-		s[i++] = 'r';
-	if (mode & MAY_WRITE)
-		s[i++] = 'w';
-	if (mode & MAY_EXEC)
-		s[i++] = 'x';
-	if (mode & MAY_APPEND)
-		s[i++] = 'a';
-	if (mode & MAY_TRANSMUTE)
-		s[i++] = 't';
-	if (mode & MAY_LOCK)
-		s[i++] = 'l';
-	if (i == 0)
-		s[i++] = '-';
-	s[i] = '\0';
+	smack_str_from_perm(s, mode);
 }
 #endif
 
diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index 5dd1e164f9b1..cd5327253d1c 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -564,6 +564,7 @@ static void smk_seq_stop(struct seq_file *s, void *v)
 
 static void smk_rule_show(struct seq_file *s, struct smack_rule *srp, int max)
 {
+	char acc[SMK_NUM_ACCESS_TYPE + 1];
 	/*
 	 * Don't show any rules with label names too long for
 	 * interface file (/smack/load or /smack/load2)
@@ -577,28 +578,11 @@ static void smk_rule_show(struct seq_file *s, struct smack_rule *srp, int max)
 	if (srp->smk_access == 0)
 		return;
 
-	seq_printf(s, "%s %s",
+	smack_str_from_perm(acc, srp->smk_access);
+	seq_printf(s, "%s %s %s\n",
 		   srp->smk_subject->smk_known,
-		   srp->smk_object->smk_known);
-
-	seq_putc(s, ' ');
-
-	if (srp->smk_access & MAY_READ)
-		seq_putc(s, 'r');
-	if (srp->smk_access & MAY_WRITE)
-		seq_putc(s, 'w');
-	if (srp->smk_access & MAY_EXEC)
-		seq_putc(s, 'x');
-	if (srp->smk_access & MAY_APPEND)
-		seq_putc(s, 'a');
-	if (srp->smk_access & MAY_TRANSMUTE)
-		seq_putc(s, 't');
-	if (srp->smk_access & MAY_LOCK)
-		seq_putc(s, 'l');
-	if (srp->smk_access & MAY_BRINGUP)
-		seq_putc(s, 'b');
-
-	seq_putc(s, '\n');
+		   srp->smk_object->smk_known,
+		   acc);
 }
 
 /*
-- 
2.43.0

