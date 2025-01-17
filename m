Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B83B198851
	for <linux-security-module@vger.kernel.org>; Fri, 17 Jan 2025 21:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737150456; cv=none; b=uWQYcAsWrLGd9ezA25/Fcdwoj90Mvnn2ygEx8w2sTUavr8wIkJBt7vw0Jn4g3bJyHFItHzQtPDm6EpV7H8FEt1WIjAK81PkAcHMwSsY3rlMavEhX3385mqIa1iHSj3LTcOwsp0ddAdTBRwTTD16btlKNHMDM0eTuf+7SmZ3G5Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737150456; c=relaxed/simple;
	bh=y9XAaYTcH9ICAiaXGpw2HSb4hslx2GjSHGCioSR23Ig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZOQ93osHvdKIYfVrLVIMW1YDCN4Vpe9HBAS4Uz5YwSu7Y9hwyj6jJfYPx1tkEwBxEQeiq9PEJVRmLfrW5c3VsaLLd3m6AbNgrdTjSd+H8Yt8lWNP4mV5SilzbDNIwTnr8TbjqP5BRQiP4HtgXeLiYvsSlMMzCi9+jkiDZMDWTNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=mBd/MrNX; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="mBd/MrNX"
From: Konstantin Andreev <andreev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1737150447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tdvkVlGgCvTLQjR/+ApAyaRxOqmIpJHKXwa7/WSzdTY=;
	b=mBd/MrNXFhJGBbqRogy+vNkHGj4tOfdaOeUjGtFezmaAEfpjj3lzp0CL80gWT8ZhbxwiBK
	SZbL1gYCOQ9myYgI79riEZXSBttbPrJhYitRbb2Y4Y14TK4/1bfp0FUYKly6lQIxT4aetz
	fV6fAwV2eYYRrseoiOo+dBQoXvKpGio=
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org
Subject: [PATCH] smack: remove /smack/logging if audit is not configured
Date: Sat, 18 Jan 2025 00:46:46 +0300
Message-ID: <20250117214655.3138888-1-andreev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If CONFIG_AUDIT is not set then
SMACK does not generate audit messages,
however, keeps audit control file, /smack/logging,
while there is no entity to control.
This change removes audit control file /smack/logging
when audit is not configured in the kernel

Signed-off-by: Konstantin Andreev <andreev@swemel.ru>
---
 security/smack/smack.h        | 12 ++++++------
 security/smack/smack_access.c |  2 ++
 security/smack/smackfs.c      |  6 ++++++
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/security/smack/smack.h b/security/smack/smack.h
index c4d998972ba5..1fb6957545b5 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -432,6 +432,12 @@ static inline struct smack_known *smk_of_current(void)
 	return smk_of_task(smack_cred(current_cred()));
 }
 
+void smack_log(char *subject_label, char *object_label,
+		int request,
+		int result, struct smk_audit_info *auditdata);
+
+#ifdef CONFIG_AUDIT
+
 /*
  * logging functions
  */
@@ -439,12 +445,6 @@ static inline struct smack_known *smk_of_current(void)
 #define SMACK_AUDIT_ACCEPT 0x2
 extern int log_policy;
 
-void smack_log(char *subject_label, char *object_label,
-		int request,
-		int result, struct smk_audit_info *auditdata);
-
-#ifdef CONFIG_AUDIT
-
 /*
  * some inline functions to set up audit data
  * they do nothing if CONFIG_AUDIT is not set
diff --git a/security/smack/smack_access.c b/security/smack/smack_access.c
index 3727379623e2..606cb340e819 100644
--- a/security/smack/smack_access.c
+++ b/security/smack/smack_access.c
@@ -45,11 +45,13 @@ LIST_HEAD(smack_known_list);
  */
 static u32 smack_next_secid = 10;
 
+#ifdef CONFIG_AUDIT
 /*
  * what events do we log
  * can be overwritten at run-time by /smack/logging
  */
 int log_policy = SMACK_AUDIT_DENIED;
+#endif /* CONFIG_AUDIT */
 
 /**
  * smk_access_entry - look up matching access rule
diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index a7886cfc9dc3..c28188bc2bc8 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -41,7 +41,9 @@ enum smk_inos {
 	SMK_AMBIENT	= 7,	/* internet ambient label */
 	SMK_NET4ADDR	= 8,	/* single label hosts */
 	SMK_ONLYCAP	= 9,	/* the only "capable" label */
+#ifdef CONFIG_AUDIT
 	SMK_LOGGING	= 10,	/* logging */
+#endif /* CONFIG_AUDIT */
 	SMK_LOAD_SELF	= 11,	/* task specific rules */
 	SMK_ACCESSES	= 12,	/* access policy */
 	SMK_MAPPED	= 13,	/* CIPSO level indicating mapped label */
@@ -2126,6 +2128,7 @@ static const struct file_operations smk_unconfined_ops = {
 };
 #endif /* CONFIG_SECURITY_SMACK_BRINGUP */
 
+#ifdef CONFIG_AUDIT
 /**
  * smk_read_logging - read() for /smack/logging
  * @filp: file pointer, not actually used
@@ -2190,6 +2193,7 @@ static const struct file_operations smk_logging_ops = {
 	.write		= smk_write_logging,
 	.llseek		= default_llseek,
 };
+#endif /* CONFIG_AUDIT */
 
 /*
  * Seq_file read operations for /smack/load-self
@@ -2876,8 +2880,10 @@ static int smk_fill_super(struct super_block *sb, struct fs_context *fc)
 			"netlabel", &smk_net4addr_ops, S_IRUGO|S_IWUSR},
 		[SMK_ONLYCAP] = {
 			"onlycap", &smk_onlycap_ops, S_IRUGO|S_IWUSR},
+#ifdef CONFIG_AUDIT
 		[SMK_LOGGING] = {
 			"logging", &smk_logging_ops, S_IRUGO|S_IWUSR},
+#endif /* CONFIG_AUDIT */
 		[SMK_LOAD_SELF] = {
 			"load-self", &smk_load_self_ops, S_IRUGO|S_IWUGO},
 		[SMK_ACCESSES] = {
-- 
2.43.0

