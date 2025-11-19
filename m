Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CFA2F5A3C
	for <linux-security-module@vger.kernel.org>; Wed, 19 Nov 2025 14:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763561024; cv=none; b=bUZ2DZtHak7d/2rxO1i4wKcCZNH5hzvv1Mdbra/hgWxCvFJJ4nGQyqQduzU9/YxDzfGravHoUQXWKVe3f9bVo1I3NBoweaoOtrcWnzBprHJ90ic/3iVH/LVTEe6rs3/roKwusjii1khiT1AR7PVd4PldDz1MhvVB6iss6iT1pcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763561024; c=relaxed/simple;
	bh=sMM0Td1pTUZfgcV1XQAs8U+6FRC5Dx7pl1U5YG27aiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=djQBwB0VsT51yUGJgpsvF2OyQvmJJ4xrzhRZi1e+xalB8Biu53LTXItnTYYDoOca8gK4sp0FZEoXMFkDareGJ8KWw9XRqM9AU661xjy8GfYj8hEaFRvilh1fL7S81cxe5kaoneybQJFFtgIdMJbmS2I3GJAAU/SFzD110p8kOhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fn16pdfv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fn16pdfv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763561021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=43huBOvLkP9Orb60esyoQoOyuL+2DOEyrVCLCaUwMJA=;
	b=fn16pdfvN08OptvhE3LLk4J1031VfRKwUkcFiQMPU9KZQmvZCuTnutG5SwcvDOfJ+seI7D
	CPBrqh8j7lvGbUpzeUpaQ6wLwBvs51MjGmDOD9ExruoC0vlameKVCQTNgGzETj3E9V4C9u
	HUqFssb3lGSQnFpaQapEOvmH9U1CXts=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-igQfZT0mNcCPfUWuNOvWyQ-1; Wed, 19 Nov 2025 09:03:37 -0500
X-MC-Unique: igQfZT0mNcCPfUWuNOvWyQ-1
X-Mimecast-MFC-AGG-ID: igQfZT0mNcCPfUWuNOvWyQ_1763561015
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3437f0760daso17580270a91.1
        for <linux-security-module@vger.kernel.org>; Wed, 19 Nov 2025 06:03:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763561014; x=1764165814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=43huBOvLkP9Orb60esyoQoOyuL+2DOEyrVCLCaUwMJA=;
        b=opVizL+/hA/Cot1o1Pb53zUfdoWHf/3R7zvZIOiyimkU1UrXNiMD2b/CF5RuU4qp5r
         YdEhZaH4Cmivhm3e+/mVBhTWHSlD2lLLIQSOquoeTGTV7LzmWJEfGjfjyoaQt7ZBbSAP
         Dq7f7neig03inQiySEKHVRwTP7IyzRMD9PAc/GtjSGk2cUD7uxkrLwwg3QQW6eFXB7Um
         3oOVKPJCArCZyU5oDC8h2+IEwHD9qSSCiRXVPWi5QcDmV7qcWr7LuJFKfkYQUiwPNmcn
         Wc9G3RfXBS7IEpJoGG+9c70TfQRRMx1O0ccym6CBO/D5QiuPIBgERW6xCyGBlQBiB2lj
         9TAw==
X-Forwarded-Encrypted: i=1; AJvYcCXlnEI04C5ojub+PhrAoOSKVG8Wah26Dg2VWAPHNdnI+O2WjSle4EBEmDXzlvZfaevBiRE49JGMLRhzbGKwHWbCBgfUOyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFiDXyShLc1ijQkr9IuxmUPlsRjco+RZ/2fBcmJvaoczJMyfo+
	BVxgK/Zxn71JLt0jOIyrSWASmQ1ZOJrEvTgLQlfrVDQSKZ4xLyormrsymoUPa+VhFp1eX6S1/N/
	v+2OkcnQyGTV2kSSgcBjCvYcr838c2YYDm0PFkWztiusWdvTdkw2nDaxgU/xcSkMebRG+SG6Ym9
	gCHQ==
X-Gm-Gg: ASbGnctHt1zTd+77uLCtGc82xvVLqkI4U77UW6aTKjn9Zdrq+jUpjDwd7CGTA2vGp7h
	jFb1IsyHvTpFMEGY9mxx/RmZ5K7kugJ/miODbO+FHeA821YdbaBe+iAj+9qVrP9DThqVWc0o28Z
	/pF3w+51G0PiiM2Ae+IHILPiAs43HPHYm4OVJoeSnMs5gNtdeXybHodlnIWHSh9xySGFOslvwVn
	z6o6GE5evv/vTWZtXwUG7XXOZCbZuD7f+MZ8YOwGdLzEbcP5Lko2dUgjS79A63PDbpPt8J/I/Nv
	8DcjkTqMc5qurcsw7oovihrlT14GCbBpaHEMrhSjA49II6aXfoCTjD32K06NdszZShe3vWDO8+G
	G
X-Received: by 2002:a17:903:2a8c:b0:297:c889:ba37 with SMTP id d9443c01a7336-2986a755422mr235982795ad.41.1763561012846;
        Wed, 19 Nov 2025 06:03:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5JYdLW6VkCpjZEiTrP+h9ubU8Y8eKrRTH5BmmnLLCtVlJCYiAx2FQsMZqrDxFZTIQ2fSm5A==
X-Received: by 2002:a17:903:2a8c:b0:297:c889:ba37 with SMTP id d9443c01a7336-2986a755422mr235980775ad.41.1763561010932;
        Wed, 19 Nov 2025 06:03:30 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b11bfsm210101215ad.53.2025.11.19.06.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 06:03:30 -0800 (PST)
From: Coiby Xu <coxu@redhat.com>
To: linux-integrity@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>
Cc: Karel Srot <ksrot@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Fan Wu <wufan@kernel.org>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-modules@vger.kernel.org (open list:MODULE SUPPORT),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	selinux@vger.kernel.org (open list:SELINUX SECURITY MODULE)
Subject: [PATCH v4] ima: Access decompressed kernel module to verify appended signature
Date: Wed, 19 Nov 2025 22:03:25 +0800
Message-ID: <20251119140326.787451-1-coxu@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251031074016.1975356-1-coxu@redhat.com>
References: <20251031074016.1975356-1-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yyXmoibStWZgNJRE7GViCngKzn_6UeDWi23Do8He6Qg_1763561015
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Currently, when in-kernel module decompression (CONFIG_MODULE_DECOMPRESS)
is enabled, IMA has no way to verify the appended module signature as it
can't decompress the module.

Define a new kernel_read_file_id enumerate READING_MODULE_COMPRESSED so
IMA can calculate the compressed kernel module data hash on
READING_MODULE_COMPRESSED and defer appraising/measuring it until on
READING_MODULE when the module has been decompressed.

Before enabling in-kernel module decompression, a kernel module in
initramfs can still be loaded with ima_policy=secure_boot. So adjust the
kernel module rule in secure_boot policy to allow either an IMA
signature OR an appended signature i.e. to use
"appraise func=MODULE_CHECK appraise_type=imasig|modsig".

Reported-by: Karel Srot <ksrot@redhat.com>
Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Suggested-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 include/linux/kernel_read_file.h    |  1 +
 kernel/module/main.c                | 17 ++++++++++++++---
 security/integrity/ima/ima_main.c   | 24 ++++++++++++++++--------
 security/integrity/ima/ima_policy.c |  3 ++-
 security/ipe/hooks.c                |  1 +
 security/selinux/hooks.c            |  5 +++--
 6 files changed, 37 insertions(+), 14 deletions(-)

diff --git a/include/linux/kernel_read_file.h b/include/linux/kernel_read_file.h
index 90451e2e12bd..d613a7b4dd35 100644
--- a/include/linux/kernel_read_file.h
+++ b/include/linux/kernel_read_file.h
@@ -14,6 +14,7 @@
 	id(KEXEC_INITRAMFS, kexec-initramfs)	\
 	id(POLICY, security-policy)		\
 	id(X509_CERTIFICATE, x509-certificate)	\
+	id(MODULE_COMPRESSED, kernel-module-compressed) \
 	id(MAX_ID, )
 
 #define __fid_enumify(ENUM, dummy) READING_ ## ENUM,
diff --git a/kernel/module/main.c b/kernel/module/main.c
index c66b26184936..7b3ec2fa6e7c 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3675,24 +3675,35 @@ static int idempotent_wait_for_completion(struct idempotent *u)
 
 static int init_module_from_file(struct file *f, const char __user * uargs, int flags)
 {
+	bool compressed = !!(flags & MODULE_INIT_COMPRESSED_FILE);
 	struct load_info info = { };
 	void *buf = NULL;
 	int len;
+	int err;
 
-	len = kernel_read_file(f, 0, &buf, INT_MAX, NULL, READING_MODULE);
+	len = kernel_read_file(f, 0, &buf, INT_MAX, NULL,
+			       compressed ? READING_MODULE_COMPRESSED :
+					    READING_MODULE);
 	if (len < 0) {
 		mod_stat_inc(&failed_kreads);
 		return len;
 	}
 
-	if (flags & MODULE_INIT_COMPRESSED_FILE) {
-		int err = module_decompress(&info, buf, len);
+	if (compressed) {
+		err = module_decompress(&info, buf, len);
 		vfree(buf); /* compressed data is no longer needed */
 		if (err) {
 			mod_stat_inc(&failed_decompress);
 			mod_stat_add_long(len, &invalid_decompress_bytes);
 			return err;
 		}
+		err = security_kernel_post_read_file(f, (char *)info.hdr, info.len,
+						     READING_MODULE);
+		if (err) {
+			mod_stat_inc(&failed_kreads);
+			free_copy(&info, flags);
+			return err;
+		}
 	} else {
 		info.hdr = buf;
 		info.len = len;
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index ebaebccfbe9a..edd0fd3d77a0 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -235,7 +235,8 @@ static void ima_file_free(struct file *file)
 
 static int process_measurement(struct file *file, const struct cred *cred,
 			       struct lsm_prop *prop, char *buf, loff_t size,
-			       int mask, enum ima_hooks func)
+			       int mask, enum ima_hooks func,
+			       enum kernel_read_file_id read_id)
 {
 	struct inode *real_inode, *inode = file_inode(file);
 	struct ima_iint_cache *iint = NULL;
@@ -406,6 +407,12 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	if (rc != 0 && rc != -EBADF && rc != -EINVAL)
 		goto out_locked;
 
+	/* Defer measuring/appraising kernel modules to READING_MODULE */
+	if (read_id == READING_MODULE_COMPRESSED) {
+		must_appraise = 0;
+		goto out_locked;
+	}
+
 	if (!pathbuf)	/* ima_rdwr_violation possibly pre-fetched */
 		pathname = ima_d_path(&file->f_path, &pathbuf, filename);
 
@@ -486,14 +493,14 @@ static int ima_file_mmap(struct file *file, unsigned long reqprot,
 
 	if (reqprot & PROT_EXEC) {
 		ret = process_measurement(file, current_cred(), &prop, NULL,
-					  0, MAY_EXEC, MMAP_CHECK_REQPROT);
+					  0, MAY_EXEC, MMAP_CHECK_REQPROT, 0);
 		if (ret)
 			return ret;
 	}
 
 	if (prot & PROT_EXEC)
 		return process_measurement(file, current_cred(), &prop, NULL,
-					   0, MAY_EXEC, MMAP_CHECK);
+					   0, MAY_EXEC, MMAP_CHECK, 0);
 
 	return 0;
 }
@@ -577,7 +584,7 @@ static int ima_bprm_check(struct linux_binprm *bprm)
 
 	security_current_getlsmprop_subj(&prop);
 	return process_measurement(bprm->file, current_cred(),
-				   &prop, NULL, 0, MAY_EXEC, BPRM_CHECK);
+				   &prop, NULL, 0, MAY_EXEC, BPRM_CHECK, 0);
 }
 
 /**
@@ -607,7 +614,7 @@ static int ima_creds_check(struct linux_binprm *bprm, const struct file *file)
 
 	security_current_getlsmprop_subj(&prop);
 	return process_measurement((struct file *)file, bprm->cred, &prop, NULL,
-				   0, MAY_EXEC, CREDS_CHECK);
+				   0, MAY_EXEC, CREDS_CHECK, 0);
 }
 
 /**
@@ -655,7 +662,7 @@ static int ima_file_check(struct file *file, int mask)
 	security_current_getlsmprop_subj(&prop);
 	return process_measurement(file, current_cred(), &prop, NULL, 0,
 				   mask & (MAY_READ | MAY_WRITE | MAY_EXEC |
-					   MAY_APPEND), FILE_CHECK);
+					   MAY_APPEND), FILE_CHECK, 0);
 }
 
 static int __ima_inode_hash(struct inode *inode, struct file *file, char *buf,
@@ -874,12 +881,13 @@ static int ima_read_file(struct file *file, enum kernel_read_file_id read_id,
 	func = read_idmap[read_id] ?: FILE_CHECK;
 	security_current_getlsmprop_subj(&prop);
 	return process_measurement(file, current_cred(), &prop, NULL, 0,
-				   MAY_READ, func);
+				   MAY_READ, func, 0);
 }
 
 const int read_idmap[READING_MAX_ID] = {
 	[READING_FIRMWARE] = FIRMWARE_CHECK,
 	[READING_MODULE] = MODULE_CHECK,
+	[READING_MODULE_COMPRESSED] = MODULE_CHECK,
 	[READING_KEXEC_IMAGE] = KEXEC_KERNEL_CHECK,
 	[READING_KEXEC_INITRAMFS] = KEXEC_INITRAMFS_CHECK,
 	[READING_POLICY] = POLICY_CHECK
@@ -917,7 +925,7 @@ static int ima_post_read_file(struct file *file, char *buf, loff_t size,
 	func = read_idmap[read_id] ?: FILE_CHECK;
 	security_current_getlsmprop_subj(&prop);
 	return process_measurement(file, current_cred(), &prop, buf, size,
-				   MAY_READ, func);
+				   MAY_READ, func, read_id);
 }
 
 /**
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 164d62832f8e..7468afaab686 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -244,7 +244,8 @@ static struct ima_rule_entry build_appraise_rules[] __ro_after_init = {
 
 static struct ima_rule_entry secure_boot_rules[] __ro_after_init = {
 	{.action = APPRAISE, .func = MODULE_CHECK,
-	 .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
+	 .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED | IMA_MODSIG_ALLOWED |
+		  IMA_CHECK_BLACKLIST},
 	{.action = APPRAISE, .func = FIRMWARE_CHECK,
 	 .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
 	{.action = APPRAISE, .func = KEXEC_KERNEL_CHECK,
diff --git a/security/ipe/hooks.c b/security/ipe/hooks.c
index d0323b81cd8f..1053a4acf589 100644
--- a/security/ipe/hooks.c
+++ b/security/ipe/hooks.c
@@ -118,6 +118,7 @@ int ipe_kernel_read_file(struct file *file, enum kernel_read_file_id id,
 		op = IPE_OP_FIRMWARE;
 		break;
 	case READING_MODULE:
+	case READING_MODULE_COMPRESSED:
 		op = IPE_OP_KERNEL_MODULE;
 		break;
 	case READING_KEXEC_INITRAMFS:
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index dfc22da42f30..c1ff69d5d76e 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4275,7 +4275,7 @@ static int selinux_kernel_read_file(struct file *file,
 {
 	int rc = 0;
 
-	BUILD_BUG_ON_MSG(READING_MAX_ID > 7,
+	BUILD_BUG_ON_MSG(READING_MAX_ID > 8,
 			 "New kernel_read_file_id introduced; update SELinux!");
 
 	switch (id) {
@@ -4283,6 +4283,7 @@ static int selinux_kernel_read_file(struct file *file,
 		rc = selinux_kernel_load_from_file(file, SYSTEM__FIRMWARE_LOAD);
 		break;
 	case READING_MODULE:
+	case READING_MODULE_COMPRESSED:
 		rc = selinux_kernel_load_from_file(file, SYSTEM__MODULE_LOAD);
 		break;
 	case READING_KEXEC_IMAGE:
@@ -4311,7 +4312,7 @@ static int selinux_kernel_load_data(enum kernel_load_data_id id, bool contents)
 {
 	int rc = 0;
 
-	BUILD_BUG_ON_MSG(LOADING_MAX_ID > 7,
+	BUILD_BUG_ON_MSG(LOADING_MAX_ID > 8,
 			 "New kernel_load_data_id introduced; update SELinux!");
 
 	switch (id) {

base-commit: 43369273518f57b7d56c1cf12d636a809b7bd81b
-- 
2.51.1

