Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5B3221542
	for <linux-security-module@vger.kernel.org>; Fri, 19 Dec 2025 19:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766174155; cv=none; b=o/LGGFavjUiEFmCq4c7SaCq0NqHVxGqYlyt947iygy4AiJKu7ijGBGu5qA0Yo/ww0/1jGzDNXAXID9pZRhp8itjjs3V7PgEdgxM2OHT+2SktMBEnjZOyJh9+uyJBbiK6zXTTyhkSQSZ51OBbpLgEX8yo+e8CtLH/IUaYX8zOjzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766174155; c=relaxed/simple;
	bh=Izr+0B/kidUR6kFgGzijhtufQOYwDySylQrmdDOiNK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jn+8eR9bmzuO6UmU09VJabM2kJ1pKLN76Jnu2h0Qn8XakrN/Ua5U6CaBYcxnMChi4qVsyVTAj7G6qcTKNj1NtPqu1F/kUW9iEl1v/hzBObq4+jZCD1qkrXHTPvFSxRTgn0/wTN78S0fFcuFwDxj/VWC54r5QHjVuDhmn/Fpjwtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=QQV7v4yV; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="QQV7v4yV"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-3ec41466a30so1655026fac.0
        for <linux-security-module@vger.kernel.org>; Fri, 19 Dec 2025 11:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1766174151; x=1766778951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N5F126y8if8LIRdkatntytj2kts1EA3ylByzLwVAd7s=;
        b=QQV7v4yVGhZrDpD4C/qdVBG0V8kPtG8fkN4DEKnoiTNCd6GMldYkmEmNtGwum2HAuK
         i1h/9rZn7rnrQhG8sbHQDsKHZEO+L6p3XXm2deTIV4P/QdSfplv8Xa8+YkoL/rVoNhfr
         XRJp11L16okwZyR5rWkXuvyWBLt0aFcQ9r/QbrOU+ZHmojom557CrdcrBP+Ak8BkyPMc
         0J9eeKSZUA+l6Ax1hJeon2lHR5BpQhwcx51OOZjyRxYzJdU+LqX/ZXRyZKV0GX2pbrDi
         VypAw9YKjkUGEFEYGtFpb4i0aty2+qY5sM54OTg3VhSli2wu/J9qh0N0M8MLd9J/BaB1
         Dw/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766174151; x=1766778951;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N5F126y8if8LIRdkatntytj2kts1EA3ylByzLwVAd7s=;
        b=TXzk5G9cEaojHnSvqtAyrJzUKRGQGRY44WGKVr4riTeqOncKKWS32CMklgQZjAfaI4
         czK6JNyTAtmtZ9cp/R5AFKftzgNmFFCDH5z5dUSYvbLpy0LqHL4bMWd38uS+6cDpIt3d
         4UgHrwBPfzS62tV9tIzrRoZSIsDkjWYI8Qzlui7k/FyClfI4u1hQZbNIEZhwIsewszD6
         taYbENT2l2mlUHkudUyqNWDh33DSedVfjdxEPDCCgcChrHDQ2CEkTrOOzO5AJCO33/kR
         8Zf5R4EzXIJ12pgi+kMsleu2H04qDKj0M3McbgBLnbEmLxngt/QWJxPPMa62PmzME3ag
         YhuA==
X-Forwarded-Encrypted: i=1; AJvYcCU1baGMSGbL0REZjyh5AjeGiqhnpgqd8gAVSvAYkOWXlzzE+nSq4ZaOA2/znikqe3COuhsjct+laOB6462AWfAdtn5WZhc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7NvIRApzkXpPorAdqYyMCoDjugPLprwMH4mTJNr5VIA/7FcoX
	1yjjjD/6cddt3svCM6M9theTffXtZSEcUJRtvw9+CskMrSFzbbJov74TOBI+hDyfglc=
X-Gm-Gg: AY/fxX5yv/DsNi0ZxDG9yK4BHgUijRuTxlRy7YcyBPGlf6jiLu6fscNK+9C4FMwSjCv
	k329fo/P1XWQNWFfxdbpeF9YZ5fBaLSbydPRqAe93VoHhmE9pUcAB452LCpJfs/ByYWhun4FsYt
	oNtD1eXOZ687WBMHEdiCQgT1/bYVnP/NSsLayS+I2oNCEmiGuEECOYU7PxhPOk2zkejoiSORWrh
	AWwGhqRQV6Fs69BnkE6cE52D9WZInzxuft+vVsCeGxT/gKeGeEeb8GLrs2mOhL/f1tVO1xm47z0
	uSDKe71/qgv8VMnG27LGFjCvFi4IhLNei1esCaIFh0hTd7ugFb8Mpv0lvHvfieyv+ZjC/xeQDwY
	sx6xQ9KshQLFWhlmPDv9DWcYg4fL1oGA2jL2abEmOFYxY7ccYz5yVZtCfLEWS2YtDX5CSlLg=
X-Google-Smtp-Source: AGHT+IGUJKnpVTtWN1QzetKvQAGqiGpbky9oCmNtRbx1YI2Uk2HdWm3JOrxGMx7ehZyvsljs/LyvvQ==
X-Received: by 2002:a05:6870:a106:b0:3ec:2fc8:979a with SMTP id 586e51a60fabf-3fda5411600mr2171361fac.19.1766174151433;
        Fri, 19 Dec 2025 11:55:51 -0800 (PST)
Received: from 861G6M3.. ([2a09:bac1:76a0:540::f:338])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3fdaab65749sm1965280fac.11.2025.12.19.11.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 11:55:50 -0800 (PST)
From: Chris J Arges <carges@cloudflare.com>
To: zohar@linux.ibm.com,
	roberto.sassu@huawei.com
Cc: kernel-team@cloudflare.com,
	Chris J Arges <carges@cloudflare.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Kees Cook <kees@kernel.org>,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ima: Fix stack-out-of-bounds in is_bprm_creds_for_exec()
Date: Fri, 19 Dec 2025 13:54:41 -0600
Message-ID: <20251219195456.912190-1-carges@cloudflare.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KASAN reported a stack-out-of-bounds access in ima_appraise_measurement
from is_bprm_creds_for_exec:

BUG: KASAN: stack-out-of-bounds in ima_appraise_measurement+0x12dc/0x16a0
 Read of size 1 at addr ffffc9000160f940 by task sudo/550
The buggy address belongs to stack of task sudo/550
and is located at offset 24 in frame:
  ima_appraise_measurement+0x0/0x16a0
This frame has 2 objects:
  [48, 56) 'file'
  [80, 148) 'hash'

This is caused by using container_of on the *file pointer which by the time
this function is called is actually a stack variable.

In order to fix this pass in a bprm_is_check boolean which can be set
depending on how process_measurement is called. If the caller has a
linux_binprm pointer we can determine is_check and set it then. Otherwise
set it to false.

Fixes: 95b3cdafd7cb7 ("ima: instantiate the bprm_creds_for_exec() hook")

Signed-off-by: Chris J Arges <carges@cloudflare.com>
---
 security/integrity/ima/ima.h          |  2 +-
 security/integrity/ima/ima_appraise.c | 15 ++-------------
 security/integrity/ima/ima_main.c     | 18 +++++++++---------
 3 files changed, 12 insertions(+), 23 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index e3d71d8d56e3..5c9f244ed1d6 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -441,7 +441,7 @@ int ima_check_blacklist(struct ima_iint_cache *iint,
 int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 			     struct file *file, const unsigned char *filename,
 			     struct evm_ima_xattr_data *xattr_value,
-			     int xattr_len, const struct modsig *modsig);
+			     int xattr_len, const struct modsig *modsig, bool bprm_is_check);
 int ima_must_appraise(struct mnt_idmap *idmap, struct inode *inode,
 		      int mask, enum ima_hooks func);
 void ima_update_xattr(struct ima_iint_cache *iint, struct file *file);
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 5149ff4fd50d..ea2079417318 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -470,17 +470,6 @@ int ima_check_blacklist(struct ima_iint_cache *iint,
 	return rc;
 }
 
-static bool is_bprm_creds_for_exec(enum ima_hooks func, struct file *file)
-{
-	struct linux_binprm *bprm;
-
-	if (func == BPRM_CHECK) {
-		bprm = container_of(&file, struct linux_binprm, file);
-		return bprm->is_check;
-	}
-	return false;
-}
-
 /*
  * ima_appraise_measurement - appraise file measurement
  *
@@ -492,7 +481,7 @@ static bool is_bprm_creds_for_exec(enum ima_hooks func, struct file *file)
 int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 			     struct file *file, const unsigned char *filename,
 			     struct evm_ima_xattr_data *xattr_value,
-			     int xattr_len, const struct modsig *modsig)
+			     int xattr_len, const struct modsig *modsig, bool bprm_is_check)
 {
 	static const char op[] = "appraise_data";
 	int audit_msgno = AUDIT_INTEGRITY_DATA;
@@ -514,7 +503,7 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 	 * of the script interpreter(userspace). Differentiate kernel and
 	 * userspace enforced integrity audit messages.
 	 */
-	if (is_bprm_creds_for_exec(func, file))
+	if (bprm_is_check)
 		audit_msgno = AUDIT_INTEGRITY_USERSPACE;
 
 	/* If reading the xattr failed and there's no modsig, error out. */
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 5770cf691912..955dbaa42f4a 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -236,7 +236,7 @@ static void ima_file_free(struct file *file)
 static int process_measurement(struct file *file, const struct cred *cred,
 			       struct lsm_prop *prop, char *buf, loff_t size,
 			       int mask, enum ima_hooks func,
-			       enum kernel_read_file_id read_id)
+			       enum kernel_read_file_id read_id, bool bprm_is_check)
 {
 	struct inode *real_inode, *inode = file_inode(file);
 	struct ima_iint_cache *iint = NULL;
@@ -426,7 +426,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 			inode_lock(inode);
 			rc = ima_appraise_measurement(func, iint, file,
 						      pathname, xattr_value,
-						      xattr_len, modsig);
+						      xattr_len, modsig, bprm_is_check);
 			inode_unlock(inode);
 		}
 		if (!rc)
@@ -493,14 +493,14 @@ static int ima_file_mmap(struct file *file, unsigned long reqprot,
 
 	if (reqprot & PROT_EXEC) {
 		ret = process_measurement(file, current_cred(), &prop, NULL,
-					  0, MAY_EXEC, MMAP_CHECK_REQPROT, 0);
+					  0, MAY_EXEC, MMAP_CHECK_REQPROT, 0, false);
 		if (ret)
 			return ret;
 	}
 
 	if (prot & PROT_EXEC)
 		return process_measurement(file, current_cred(), &prop, NULL,
-					   0, MAY_EXEC, MMAP_CHECK, 0);
+					   0, MAY_EXEC, MMAP_CHECK, 0, false);
 
 	return 0;
 }
@@ -584,7 +584,7 @@ static int ima_bprm_check(struct linux_binprm *bprm)
 
 	security_current_getlsmprop_subj(&prop);
 	return process_measurement(bprm->file, current_cred(),
-				   &prop, NULL, 0, MAY_EXEC, BPRM_CHECK, 0);
+				   &prop, NULL, 0, MAY_EXEC, BPRM_CHECK, 0, bprm->is_check);
 }
 
 /**
@@ -614,7 +614,7 @@ static int ima_creds_check(struct linux_binprm *bprm, const struct file *file)
 
 	security_current_getlsmprop_subj(&prop);
 	return process_measurement((struct file *)file, bprm->cred, &prop, NULL,
-				   0, MAY_EXEC, CREDS_CHECK, 0);
+				   0, MAY_EXEC, CREDS_CHECK, 0, bprm->is_check);
 }
 
 /**
@@ -662,7 +662,7 @@ static int ima_file_check(struct file *file, int mask)
 	security_current_getlsmprop_subj(&prop);
 	return process_measurement(file, current_cred(), &prop, NULL, 0,
 				   mask & (MAY_READ | MAY_WRITE | MAY_EXEC |
-					   MAY_APPEND), FILE_CHECK, 0);
+					   MAY_APPEND), FILE_CHECK, 0, false);
 }
 
 static int __ima_inode_hash(struct inode *inode, struct file *file, char *buf,
@@ -881,7 +881,7 @@ static int ima_read_file(struct file *file, enum kernel_read_file_id read_id,
 	func = read_idmap[read_id] ?: FILE_CHECK;
 	security_current_getlsmprop_subj(&prop);
 	return process_measurement(file, current_cred(), &prop, NULL, 0,
-				   MAY_READ, func, 0);
+				   MAY_READ, func, 0, false);
 }
 
 const int read_idmap[READING_MAX_ID] = {
@@ -925,7 +925,7 @@ static int ima_post_read_file(struct file *file, char *buf, loff_t size,
 	func = read_idmap[read_id] ?: FILE_CHECK;
 	security_current_getlsmprop_subj(&prop);
 	return process_measurement(file, current_cred(), &prop, buf, size,
-				   MAY_READ, func, read_id);
+				   MAY_READ, func, read_id, false);
 }
 
 /**
-- 
2.43.0

