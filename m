Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C2D2C11DE
	for <linux-security-module@vger.kernel.org>; Sun, 21 Dec 2025 18:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766340101; cv=none; b=rj20iDjBHIjbQ4VcFaidkltAkOqn8oD+E9UFRTKQa0TNxCH2ZYLreXfKeT79wlXCa/K0LPdJ9YxvcTBXB4ayx+8/iJt3U76EWWHJ9N9tWCSxch/s7aSAd8/sc4EcjIVA0cCWAMZ4tvF69+Q7Mt9CtklvI44/nM+HE59bi+LDagg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766340101; c=relaxed/simple;
	bh=p23rTPaXB4iLA7mrqVNTAV0jfWyH932i0ckS/IM7+KU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M5AGPyCw6G5Nn46WEQYBidmKKi7Pn5htcPv/Sh0UuxxNPN2xRelQz8TUxST/H5aaJIGQZ4WbQ2TLCOzVYvC2hcohts5Ny9fkN1mzEh+dMJsjgO5gyY5nER4PxOZPDaETcVapootn3zlLcf2p5askM0a64VVXVzjQcuYtohwzDxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=e566HlGA; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="e566HlGA"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-455749af2e1so2641565b6e.1
        for <linux-security-module@vger.kernel.org>; Sun, 21 Dec 2025 10:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1766340098; x=1766944898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TMI4gJV+EmQW/dsAUXEtdv+529j/oGL1MY5pHnG4y5I=;
        b=e566HlGAqrYzNvk52bmuPebS4kNrgZyG6O2EqdISjvJ9oIMZ6xtpz6c4OzJ6hUbyIv
         6qSYD3QzJbaNzkexOAViVgu5iX/E7z/cu4YavvEOsRCfai7sx426gqRWuPDFo3gD1CrP
         pON2RzJJ3EvCWFlIvgaGMHgj9eCoS2O42VQToyHe429oCnteKNV9X7HZCJSwajhLDNnR
         jYlW302UW8uavwF8EpqAbNEiFuatl9pblgOdpSXPOOTHAjhN+niYa/5B1fdWCeL0O6iq
         FS+dlG4DwE8eWUm8fP+LGDDbz5dP1HD8Sv7HF4LXzSmDUPJQAQUwALDlKZFYg34terdW
         0qBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766340098; x=1766944898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TMI4gJV+EmQW/dsAUXEtdv+529j/oGL1MY5pHnG4y5I=;
        b=V3R8C46u0c/68z02KAab2DkJMYr0r9iMOhFc51xi3QbMX+TKZrF/pg4G0LYa07Tft1
         KsCH+joIG21/CqHqA7HjmWuQRHz1BU8VYyNY0Ax9FXUDtEn578JjEufZWS45rnpp+veh
         YIMUho5Z59AxQ7smeFNT28qTQPfkPsHrvBv4G+IZXTv2uoRZAWh+eKEtwWyGMP1L11OI
         981Mk9XB6cTXlA+8e4YH91YQsOsU8c8liVRtLX+x9noT97mcHebB8TACFa3eJj+LZH8V
         CrWoKDdmBiVdmTDe7woJR8FOtqPQFj5+vUAlId6/Y/NDMdwG/+TjydiPG2maOKkTCeIZ
         E+Vw==
X-Forwarded-Encrypted: i=1; AJvYcCW7mb4hseT6dxv9MeYGkX4wsG8tW91Ksve+1AUF3LxCdzwTbHLhZQi+P6a6ZI8h/zoBp/7SVZFtg1CojPdI3xVu5NmST+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeQZCgwdR0KvJi+gxQomJuZhTWUB7yRe3oBbqObvjgAT3Ke4AJ
	IxLG3+GlJh9ZpeyWAHgrb6d0H+EPgyBMz4v8Oem4wsYxDWIgg+89a5aEjOl0WHqlGrs=
X-Gm-Gg: AY/fxX5PiIFdcYGU2URbYzbE9fCvDzNP62c6MirW1/1dkaEwovcFw6bC8qHwXtwDIiC
	er+ShMV2fFo5odm6fJ0JuprkKM/8m8MY09+lszDDFb/SMSooWabz4EMjCCY5DVPdRykD2yDBazq
	7CcLiqJtuxyJhY7HlKjrO6DdHTgFG0cMy2GX3Sl8lLk+vpGFf31kgefxxp6tYiISy3Vy8kohTcL
	r1zmJmOZZ/t6K+otbM0WUKf1w0tgTHQCz/dWWSEnFkgkezvKBAyNFVuCfwu+7W5rHJ95FIKLdOC
	RJcS9+kTnRFvAjEldTwcB0wuaToDWWndVjW1Z47XMKGdwpDIUmxOzk48UuZizPHUZqY0T1oZ4xk
	q9MQfR3W/GzB63vCv4z/TfutdBGPt81Mb72iVcKuhxYyqavq3ZSY9cEdD+IrrQex5gxfcZsvI
X-Google-Smtp-Source: AGHT+IFtfgC7EtUhHlm9PN3fh8nc1zUg/yZTdIPC+ThEyW1/WWre3+6c5ZhabM4CkagZUusUsC8L3w==
X-Received: by 2002:a05:6808:1382:b0:450:f45e:f4ae with SMTP id 5614622812f47-457a28924ddmr5726915b6e.9.1766340097941;
        Sun, 21 Dec 2025 10:01:37 -0800 (PST)
Received: from 861G6M3.. ([2a09:bac1:76a0:258::281:ed])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3fdadbf8d97sm4868888fac.1.2025.12.21.10.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 10:01:36 -0800 (PST)
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
Subject: [PATCH v2] ima: Fix stack-out-of-bounds in is_bprm_creds_for_exec()
Date: Sun, 21 Dec 2025 12:01:23 -0600
Message-ID: <20251221180128.1026760-1-carges@cloudflare.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251219195456.912190-1-carges@cloudflare.com>
References: <20251219195456.912190-1-carges@cloudflare.com>
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

This is caused by using container_of on the *file pointer. This offset
calculation is what triggers the stack-out-of-bounds error.

In order to fix this, pass in a bprm_is_check boolean which can be set
depending on how process_measurement is called. If the caller has a
linux_binprm pointer and the function is BPRM_CHECK we can determine
is_check and set it then. Otherwise set it to false.

Fixes: 95b3cdafd7cb7 ("ima: instantiate the bprm_creds_for_exec() hook")

Signed-off-by: Chris J Arges <carges@cloudflare.com>
---
 security/integrity/ima/ima.h          |  4 ++--
 security/integrity/ima/ima_appraise.c | 15 ++-------------
 security/integrity/ima/ima_main.c     | 18 +++++++++---------
 3 files changed, 13 insertions(+), 24 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index e3d71d8d56e3..2c9e50c02634 100644
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
@@ -466,7 +466,7 @@ static inline int ima_appraise_measurement(enum ima_hooks func,
 					   const unsigned char *filename,
 					   struct evm_ima_xattr_data *xattr_value,
 					   int xattr_len,
-					   const struct modsig *modsig)
+					   const struct modsig *modsig, bool bprm_is_check)
 {
 	return INTEGRITY_UNKNOWN;
 }
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
index 5770cf691912..36ce07063dc7 100644
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
+				   0, MAY_EXEC, CREDS_CHECK, 0, false);
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

