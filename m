Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605A93E49C1
	for <linux-security-module@vger.kernel.org>; Mon, 27 Jul 2026 22:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785190928; cv=none; b=Iu6qb/WweaXK50bqb5XjuyyCNjLOxd3Ldkk6Uuae3cEqLFEJY6z+4SzGrzaYwGb0z3SedHJKsXem99w/hT1iAJQAvKkeBktXbktcHPhAG55DAq+GLGjlNHLayZozJXhAI5Jnq70HVMEttKbj3z6bTmO6AYPilbkvqoKtDzVhX0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785190928; c=relaxed/simple;
	bh=YPTdSzanROZozGe9i9BwE7Cx3am54pJGkD8oBn02IPg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JATL8fjlvFUb4qcIB8iijBjtLL7GUjRpt62f2l2ulfZmpA5ES1Vl76xgAcQhqmoxOs254n7f+rlyOskgoS3qgwgAGXnnTSr2Z46ATW/jpVC/iQkFhqLt2AKG2cF3P5QLMB5n8MSDwqPJBNHbbHeygjtRnpwaskmYm9RVq7XsL/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=BwozebGZ; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="BwozebGZ"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-81dfdbd86d1so30329507b3.1
        for <linux-security-module@vger.kernel.org>; Mon, 27 Jul 2026 15:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1785190923; x=1785795723; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=92Xmg3P+IU8tVnyUZbvpaSDybm+0KynzgduttwHWSVY=;
        b=BwozebGZZOZIvp9lF/sGltVvuh9F4U+z42k5NWOe4E+iFPgcFiwSUA4+oycUB+Yizd
         ckHDXkzdOD9muewtWsgm32NDXfuNV5dcESmhK+oW6Fzl1jb/6RpW6If4OrxTAoNmkWtt
         z2n0jqRdhm/6th7Rzh1hpLiyL5QhlhhNbj6dYZOENsdHn071e4Zb4tNKpYn96/2rf62A
         xShM5nMaYqtIP01wbSvgBcMjU4uhf6wRTO+6vt+AYrZf2ALXcrdkXMPIsFKEqaa0Jusn
         6fVPppxliwqS+pV484ziUPqwnMLh8iMGc3lMjiCM1x2b8yr15CquTF8TOHcZ9Wl97Tha
         we8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785190923; x=1785795723;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=92Xmg3P+IU8tVnyUZbvpaSDybm+0KynzgduttwHWSVY=;
        b=rBGP/W/Vt7A0EaIDqqeRdahNvikGK6GF/S8OM+vJt6zyz3ByKfKFoLaS1u/RCnXx1l
         baeWDiEhwINh/uYg03WjiviLtfWHwFigzIAWgFgFVB7utV60BtzVx8AouRkLAcAHFdOb
         bwB2NF3BE2nxjXF+ff/kM98oGLSXedoiSwZUUNGDznsaf6TqFmBz5bB/UDFLQIF/iYnQ
         HHbLSl6P15Vf5ShlDDb4B203HVVjAmItAF/Lj1nIzOmvBL4TAUFaFgZeN70QM8pUriqI
         t52xvJ3Dp+foxKc/5CPWWA9ANN3BE0Ps1F3n9iJcY2fckxEKGBtEn25EA2bCAMaf8bvD
         dwOw==
X-Forwarded-Encrypted: i=1; AHgh+RoeNhhJHv/uiyN1RYsd0TmqoGIl19d7qkmuI2EuIPLeJWs4g2XR8iLifvsQEK6g6WbHInwFu09lKX9WEM87DSOVf6pDt8M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7ub3DhKDNDevmmVHsE/8MxRZlKd44M43Pj+lkSpL7ARHxnyAB
	q3fEW8A7kFaaZ765+obw38RXWYg8uEt/FtAnAyBmPywTVqUHiPgCCQSUslsvZ4ggFwg=
X-Gm-Gg: AR+sD12cnhKRE3kx1rsOAOnVOsBBvFA/a/7t8ou2XFc4J1melWkjmbSAh1r9dQ2b+iD
	bAGzy6CkQPJJKduJPOgFVYEZO2lRmT63a/W+MyNgR11Tzw/XbfHvCL6kOAObfJtzqiQcu5UrGI8
	cnENwpE2rgZRcSqpsTktbK7Xmy3Gm67E2X6w950Csz1V6YmNZ8uK/1KXSx8lR93yzl0rDeLgbk3
	GTMk10KEzyIHR5AVQ/nVwDz7KZYZQb1PtYHs5LOnu3+4bq6Y/bgR21y+nY6tE3ZTtjBo60qOVb/
	Pl82CLRJ72isJa47X5Xgx7O+NkCMvITiAg7x73gWcjbF44MG51RSBHdvNptDuWVDFaaf/IEImK5
	OSzAd+HnLWCW2a/fY97T+HnrIWl9IhI1MA4Z6lHvvOGTNj2AFIGYKTEjOT8SvEH1buyycXiLP
X-Received: by 2002:a05:690c:6f0c:b0:81e:776b:ba51 with SMTP id 00721157ae682-81f69e6fc59mr36628687b3.58.1785190923235;
        Mon, 27 Jul 2026 15:22:03 -0700 (PDT)
Received: from [127.0.1.1] ([2a09:bac6:947f:3af::5e:7e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f65774b02sm38756017b3.5.2026.07.27.15.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 15:22:02 -0700 (PDT)
From: Frederick Lawler <fred@cloudflare.com>
Date: Mon, 27 Jul 2026 17:21:49 -0500
Subject: [PATCH v2 3/3] integrity: Report error code in
 integrity_audit_message() call sites
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-report-hash-error-v2-3-30e394f524fc@cloudflare.com>
References: <20260727-report-hash-error-v2-0-30e394f524fc@cloudflare.com>
In-Reply-To: <20260727-report-hash-error-v2-0-30e394f524fc@cloudflare.com>
To: Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-team@cloudflare.com, 
 Frederick Lawler <fred@cloudflare.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10477; i=fred@cloudflare.com;
 h=from:subject:message-id; bh=YPTdSzanROZozGe9i9BwE7Cx3am54pJGkD8oBn02IPg=;
 b=owEBbQKS/ZANAwAKAasltHYDktNtAcsmYgBqZ9oEF3QC4Rn8kbwi4llZPGbFNaZdPYqpWDeSx
 pdDWHIo726JAjMEAAEKAB0WIQTLNBqMVmu1PHvjOe2rJbR2A5LTbQUCamfaBAAKCRCrJbR2A5LT
 bSbSEACJRUS9kJTx+UjeuBvDTszWUmxVPzaF2P0EEsQXres2dc6aWHCXx2U+FX3yeR38fH3FDdC
 nPiKYZbSpoTHd2wz2h6ooBILwGLYoM7XsNXgdDaTsvayGXKxxPdsddi5HbQbkxQQLAs8QxCki+b
 wtZFB0Ov3WFjRLD4IMlt5PPcvEYW9EfbCdlhef5AgjQjyxryrJ4Wynx7tRCnLOShs54AaHuvsq3
 1pV1/tujQmLVPDHaWVuW97VrorcY39NwEsz6Jjm2EkygE6a1CNuTn5wgoMelM68Wbf9D1/pPQWr
 csgBJ+5WpE7Y4EXFBnZvBHyS5UqAL2Kwc4k93GCKX3U1z4h4NIvWgMZVLmnNGVTqj/gEQtVArKI
 3i209lR2BfMOq9vujmQh9SIGPg/HAx9k9NJ+XnVd3Q3dT0y+3QCc8hpxZSmPs23FxFG7vfASq+7
 MKGjtCrhhSA1wA6s9VMu6z3PuBWVzbeWjAjs8mQBw5xIZ17rt+ZoTIyx/rCVXliKiVg+we8s2q5
 kXUO0koSq83p3qzYNrEwVcfmXzMbW/xigm4pOkzCv4LkhZCJoZjIimremCCCRLlYDbvz/+NIMsW
 gr8kys7FgSrBa7Qc9gQILYUouF/p1jEZDFcsWil5bdmqKq0X0NLUPfSGC7DUOSaiBkH5GDIKXnX
 +qmxl53owrPyoSw==
X-Developer-Key: i=fred@cloudflare.com; a=openpgp;
 fpr=CB341A8C566BB53C7BE339EDAB25B4760392D36D

Most IMA functions return a error code reported with a log message, or
depend on a error code from a callee in prior code paths. When inspecting
audit logs, it's not always clear a message was produced in the first
place because the cause may not expose the underlying reason. Since
integrity_audit_message() can take a error code, expose these where
it makes sense.

Signed-off-by: Frederick Lawler <fred@cloudflare.com>
---
 security/integrity/evm/evm_main.c         |  8 ++++----
 security/integrity/ima/ima_api.c          |  8 ++++----
 security/integrity/ima/ima_appraise.c     |  6 +++---
 security/integrity/ima/ima_fs.c           |  2 +-
 security/integrity/ima/ima_init.c         |  2 +-
 security/integrity/ima/ima_main.c         |  6 +++---
 security/integrity/ima/ima_policy.c       | 10 +++++-----
 security/integrity/ima/ima_queue.c        |  2 +-
 security/integrity/ima/ima_template_lib.c |  2 +-
 9 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index a32c98089b055fcf84f1a33dd016a51f57693d36..ba5c0dc4a8c131165aee688be68b27462489bd12 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -563,7 +563,7 @@ static int evm_protect_xattr(struct mnt_idmap *idmap,
 					dentry->d_inode, dentry->d_name.name,
 					"update_metadata",
 					integrity_status_msg[evm_status],
-					-EPERM, 0, 0);
+					-EPERM, 0, -EPERM);
 	}
 out:
 	/* Exception if the HMAC is not going to be calculated. */
@@ -590,7 +590,7 @@ static int evm_protect_xattr(struct mnt_idmap *idmap,
 					dentry->d_name.name,
 					"appraise_metadata",
 					integrity_status_msg[evm_status],
-					-EPERM, 0, 0);
+					-EPERM, 0, -EPERM);
 	return evm_status == INTEGRITY_PASS ? 0 : -EPERM;
 }
 
@@ -733,7 +733,7 @@ static int evm_inode_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 					dentry->d_name.name,
 					"appraise_metadata",
 					integrity_status_msg[evm_status],
-					-EPERM, 0, 0);
+					-EPERM, 0, -EPERM);
 	return -EPERM;
 }
 
@@ -998,7 +998,7 @@ static int evm_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 				d_backing_inode(dentry), dentry->d_name.name,
 				"appraise_metadata",
 				integrity_status_msg[evm_status], -EPERM, 0,
-				0);
+				-EPERM);
 	return -EPERM;
 }
 
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 8c37dd4c9bb805213fb62e597a70189eca12b897..1c40fea4b9a7d990ffe2c1a5ce54cec94f9cb7ef 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -116,7 +116,7 @@ int ima_store_template(struct ima_template_entry *entry,
 		if (result < 0) {
 			integrity_audit_message(AUDIT_INTEGRITY_PCR, inode,
 						template_name, op, audit_cause,
-						result, 0, 0);
+						result, 0, result);
 			return result;
 		}
 	}
@@ -159,7 +159,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
 		ima_free_template_entry(entry);
 err_out:
 	integrity_audit_message(AUDIT_INTEGRITY_PCR, inode, filename, op,
-				cause, result, 0, 0);
+				cause, result, 0, result);
 }
 
 /**
@@ -330,7 +330,7 @@ int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
 
 		integrity_audit_message(AUDIT_INTEGRITY_DATA, inode,
 					filename.name.name, "collect_data",
-					audit_cause, result, 0, 0);
+					audit_cause, result, 0, result);
 
 		release_dentry_name_snapshot(&filename);
 	}
@@ -383,7 +383,7 @@ void ima_store_measurement(struct ima_iint_cache *iint, struct file *file,
 	result = ima_alloc_init_template(&event_data, &entry, template_desc);
 	if (result < 0) {
 		integrity_audit_message(AUDIT_INTEGRITY_PCR, inode, filename,
-					op, audit_cause, result, 0, 0);
+					op, audit_cause, result, 0, result);
 		return;
 	}
 
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index cc88e3add5b7028d4901e284ef920b324645e719..6c9c1e04669a700c0558639a6f06bd759de60aef 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -559,7 +559,7 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 		status = INTEGRITY_FAIL;
 		cause = "unverifiable-signature";
 		integrity_audit_message(audit_msgno, inode, filename,
-					op, cause, rc, 0, 0);
+					op, cause, rc, 0, rc);
 	} else if (status != INTEGRITY_PASS) {
 		/* Fix mode, but don't replace file signatures. */
 		if ((ima_appraise & IMA_APPRAISE_FIX) && !try_modsig &&
@@ -584,7 +584,7 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 		}
 
 		integrity_audit_message(audit_msgno, inode, filename,
-					op, cause, rc, 0, 0);
+					op, cause, rc, 0, rc);
 	} else {
 		ima_cache_flags(iint, func);
 	}
@@ -745,7 +745,7 @@ static int validate_hash_algo(struct dentry *dentry,
 	path = dentry_path(dentry, pathbuf, PATH_MAX);
 
 	integrity_audit_message(AUDIT_INTEGRITY_DATA, d_inode(dentry), path,
-				"set_data", errmsg, -EACCES, 0, 0);
+				"set_data", errmsg, -EACCES, 0, -EACCES);
 
 	kfree(pathbuf);
 
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index a0c1a6dd6a750220b529cc3f77c2ae5673188e11..deadc946af641811928b7e65d53de3515126e85a 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -596,7 +596,7 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
 		integrity_audit_message(AUDIT_INTEGRITY_STATUS, NULL, NULL,
 					"policy_update",
 					"signed policy required",
-					result, 0, 0);
+					result, 0, result);
 		result = -EACCES;
 	} else {
 		ima_measure_raw_policy(data, datalen);
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index def350f7d6a0c58f119f2c74f26ea365471fb1c7..ca53a19911dab46b7bfd34fba2fc1380da872b14 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -103,7 +103,7 @@ static int __init ima_add_boot_aggregate(void)
 	return 0;
 err_out:
 	integrity_audit_message(AUDIT_INTEGRITY_PCR, NULL, filename, op,
-				audit_cause, result, 0, 0);
+				audit_cause, result, 0, result);
 	return result;
 }
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 22d649fa19b334674b8e81dd537033cebf569699..1d2a2ab2ff89e92f34b58e4b7c651f1d21daf7e2 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -120,7 +120,7 @@ static int mmap_violation_check(enum ima_hooks func, struct file *file,
 					       filename);
 		integrity_audit_message(AUDIT_INTEGRITY_DATA, inode, *pathname,
 					"mmap_file", "mmapped_writers", rc, 0,
-					0);
+					rc);
 	}
 	return rc;
 }
@@ -467,7 +467,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 
 		integrity_audit_message(AUDIT_INTEGRITY_DATA, file_inode(file),
 					pathname, "collect_data",
-					"denied-hash-algorithm", rc, 0, 0);
+					"denied-hash-algorithm", rc, 0, rc);
 	}
 out_locked:
 	if ((mask & MAY_WRITE) && test_bit(IMA_DIGSIG, &iint->atomic_flags) &&
@@ -581,7 +581,7 @@ static int ima_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
 	pathname = ima_d_path(&file->f_path, &pathbuf, filename);
 	integrity_audit_message(AUDIT_INTEGRITY_DATA, inode, pathname,
 				"collect_data", "failed-mprotect", result, 0,
-				0);
+				result);
 	if (pathbuf)
 		__putname(pathbuf);
 
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 4f0ebc02de4eb4cf48633f3e87362a20ece3a689..3961f0b99d0672efdb4cd225ab86a54c2a75df5b 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1988,7 +1988,7 @@ ssize_t ima_parse_add_rule(char *rule)
 	if (!entry) {
 		integrity_audit_message(AUDIT_INTEGRITY_STATUS, NULL,
 					NULL, op, "-ENOMEM", -ENOMEM,
-					audit_info, 0);
+					audit_info, -ENOMEM);
 		return -ENOMEM;
 	}
 
@@ -1999,7 +1999,7 @@ ssize_t ima_parse_add_rule(char *rule)
 		ima_free_rule(entry);
 		integrity_audit_message(AUDIT_INTEGRITY_STATUS, NULL,
 					NULL, op, "invalid-policy", result,
-					audit_info, 0);
+					audit_info, result);
 		return result;
 	}
 
@@ -2417,7 +2417,7 @@ void ima_measure_loaded_policy(void)
 	rule = kmalloc(rule_len, GFP_KERNEL);
 	if (!rule) {
 		integrity_audit_message(AUDIT_INTEGRITY_PCR, NULL, event_name,
-					op, "ENOMEM", result, 0, 0);
+					op, "ENOMEM", result, 0, result);
 		return;
 	}
 
@@ -2436,7 +2436,7 @@ void ima_measure_loaded_policy(void)
 			result = -E2BIG;
 			integrity_audit_message(AUDIT_INTEGRITY_PCR, NULL,
 						event_name, op, "rule_length",
-						result, 0, 0);
+						result, 0, result);
 			rcu_read_unlock();
 			goto free_rule;
 		}
@@ -2450,7 +2450,7 @@ void ima_measure_loaded_policy(void)
 	file.buf = kmalloc(file_len, GFP_KERNEL);
 	if (!file.buf) {
 		integrity_audit_message(AUDIT_INTEGRITY_PCR, NULL, event_name,
-					op, "ENOMEM", result, 0, 0);
+					op, "ENOMEM", result, 0, result);
 		goto free_rule;
 	}
 
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index e7b4df6b2ca299c38976012ac6eaaffcc5100e51..3b898930dea66ae6362160d0b47a320e16453280 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -292,7 +292,7 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
 out:
 	mutex_unlock(&ima_extend_list_mutex);
 	integrity_audit_message(AUDIT_INTEGRITY_PCR, inode, filename, op,
-				audit_cause, result, audit_info, 0);
+				audit_cause, result, audit_info, result);
 	return result;
 }
 
diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index c87dcbe67820266149da6ad7d4f2f7061ff3c5c1..6d163312fb4c47ce256766e997aac5f7375088a8 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -392,7 +392,7 @@ int ima_eventdigest_init(struct ima_event_data *event_data,
 	if (result) {
 		integrity_audit_message(AUDIT_INTEGRITY_DATA, inode,
 					event_data->filename, "collect_data",
-					"failed", result, 0, 0);
+					"failed", result, 0, result);
 		return result;
 	}
 	cur_digest = hash_hdr->digest;

-- 
2.43.0

