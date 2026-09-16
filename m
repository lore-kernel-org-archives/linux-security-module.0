Received: from mail-oo2-f11.google.com (mail-oo2-f11.google.com [74.125.231.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9A8495059
	for <linux-security-module@vger.kernel.org>; Wed, 16 Sep 2026 21:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789594618; cv=none; b=gFnpGAQHkE/po4zamNtjR/daO1pNTCRNOkpo5ennPxFn6BHv4oNf5v3olVWX016tYq27qbdsvnd3gp8jvNkTCZk0/kz72YXLxqBj2q13Z+2aJWUn40ASHiF199oOAKD0JR9ns7gnFl0Q1qLLAvURAJ6UqLnw6MiAO49yJbAUjzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789594618; c=relaxed/simple;
	bh=RL6d5yJ4xvBQVtGW2C14rmIuGcHh9YfAg4SyplggSlY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XgKEcVvBh8BktS4lE0H75LrSBS2ld4Sm0zdZSVzqEbni3bot25niR9LNNKWEFGY2Jj3mj4zmdl/WThAZofWRiWY8khNmY+USOxbQ1+Tvj1m1P6hkaJ8SZzRs0gwXPCbwLiAV1R0xQDAGMceggnCjg90PHeIUo6ElRjVrmVX5Ezw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=d5kvQoHc; arc=none smtp.client-ip=74.125.231.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="d5kvQoHc"
Received: by mail-oo2-f11.google.com with SMTP id 006d021491bc7-6aaf6076546so52173eaf.1
        for <linux-security-module@vger.kernel.org>; Wed, 16 Sep 2026 14:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1789594610; x=1790199410; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7Ib5zIg2tnxSHGaebhRb862QbIfTb5vHZO64N2/hUdQ=;
        b=d5kvQoHc9y+uNmyuMPQ3B23qZVj/xl++y1w2nojuHcPLBMIwp93hnWvfZNfs7WhHlV
         mVL25r9vaqqWld5kaxMTafhn7pmDLNYFyJNSWm5SrfjsIwqpZdlKmdL2kmH3OhMp3etG
         K5xKfuVHVVTrMVRh3hqZsBYPTpMNIXMnEDcz01pEdUKwoCxJdc+Tu90EDXiCjZF+wRfj
         gOxj2aCkUP9CRHnKxl+SAnmYNWYDhh2zSbUqqsYNPqf3chYvriOSgnv95F99pDNRSkLG
         av3y7FNGf0XqkWH/ENXU5xAPpcq0DwVf/vi7chcHAsDkwsXEU81HFdn4FR0NWZHbK3W8
         whfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789594610; x=1790199410;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7Ib5zIg2tnxSHGaebhRb862QbIfTb5vHZO64N2/hUdQ=;
        b=FMkV+5z2eFXvWsYeNMvjwhDABJRRGmKJ3/mWaOzpSlfUy67QuJUFRFPB9fTrb0tsuB
         S/bdqJdA7IZ9STJNMtgRn//dWgGAJTRo9kEOpBcHr3Ej3ytdULKYd/IOZu4+uQroZVl4
         HpozwdeUW+Nt5hrMp9wNJ2+RYl0wpxqcg+kw6nSXAPuTSi6PVe300mx0s1dEIL1Q6lGP
         toGw6JTX0eYuSbH0lYErJm38worWZQqbgUgOxLbsJnNxRzefiyC/dKHC6O+4uyHT8IHn
         I9k5J+KX+MOrjV73l+O//HYMVmFJYo6IcRvQZirhvmrqCKPZi8TS9hnTNowFMdzV+bww
         ioQQ==
X-Forwarded-Encrypted: i=1; AKwUvBxxLFSM/PWG+BetRSyToWcnG0VayTry1R9I913irHqH7B3J9B+yWcGPyEwl7KzGbTauRrny9SNOUIeqDhQ5ThteNvhoM9M=@vger.kernel.org
X-Gm-Message-State: AFuF++ksaMBw7PCvriamBo0HqNOkijrLaAj1JE114Sds9JVSEofpXwZG
	3xZ/oCBEFUq5QnLiTpPT3s9um/zcmcC+jvj0TBPTHfDS5dBGCeulNd9Qrb3ZvGrYyyI=
X-Gm-Gg: AYBFou3ez65GKLVP8GixF6L2KmKnhnfDrZjXU6gkPqVHwkTClRUOBMHogXzHMJ2S+Mj
	2kYQK876epL2qn2TCe9LMtGfyNuwz3zV+BLKUYpq5Wq1JteOj512u36+fudKMOIMa+5XHcDEMf1
	Wwn9AvM99XQUwW3IkrxuIgKdncTHZEvHfdr7TM1esBi0dQvf9agu49FWbP2wwHi5edICYaB95MY
	8rvuwzAAwm7XW+rXHPSoU4Gi59XLUT9M81voZ7AUXtUSmO+G0+xCJRNPy7xxORq91g8SCXcSylE
	hr4PIb7m4BaffIlVZLqM1K4ZHmNW9EOJCOWFt5UHpwHjEp1lfOQsIm8w21QTvOMsBONBZNBsXSM
	rRvMpvB5yLW1aqZ6TGTAQFBqCmvuLr4kAl0igIg14YdF5LvVpUnwAnapQ9/Vneu2LmoF793AupA
	7aQ/fWenX4uBLwxQ6p5gc3b6TvKmW4iqGB412B+dFbAIdgTvLiq+HF6pOOIEGnuDAML+iu
X-Received: by 2002:a05:6820:4b85:b0:6c2:6f93:389f with SMTP id 006d021491bc7-6c7d3ee590amr4801414eaf.37.1789594610117;
        Wed, 16 Sep 2026 14:36:50 -0700 (PDT)
Received: from [127.0.1.1] ([2a09:bac6:947f:31f5::4fa:4b])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4842a23e310sm3387557fac.12.2026.09.16.14.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 14:36:48 -0700 (PDT)
From: Frederick Lawler <fred@cloudflare.com>
Date: Wed, 16 Sep 2026 16:36:37 -0500
Subject: [PATCH v3 1/2] integrity: Report error code in
 integrity_audit_msg() call sites
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-report-hash-error-v3-1-73e5d95e9efe@cloudflare.com>
References: <20260916-report-hash-error-v3-0-73e5d95e9efe@cloudflare.com>
In-Reply-To: <20260916-report-hash-error-v3-0-73e5d95e9efe@cloudflare.com>
To: Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-team@cloudflare.com, 
 Frederick Lawler <fred@cloudflare.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=13219; i=fred@cloudflare.com;
 h=from:subject:message-id; bh=RL6d5yJ4xvBQVtGW2C14rmIuGcHh9YfAg4SyplggSlY=;
 b=owEBbQKS/ZANAwAKAasltHYDktNtAcsmYgBqqwvqu4hysntayZHQPkWEgBw9J7yFxXp6nn6rq
 iCj6kme4fWJAjMEAAEKAB0WIQTLNBqMVmu1PHvjOe2rJbR2A5LTbQUCaqsL6gAKCRCrJbR2A5LT
 bfhUEACROyLNm0fsVvUnDVxc07m+lEvRMUb0jcMLxhV/vOwcAWf5+6s/chdh2Wk8crwREtr81FR
 4vmuUbj8ukf9hUHWpV3LuZ926SQhbAgvudoPU8cG9e9BjQB5qelIZCzTABwXzF30KV4jPIvmyjz
 ivJ2Ce5F+Sl8wPAb3lLuMZD145qAuB20B/1IagG35+GH9y4MxPSkL86d6UeYiNxgjzv85OUswuJ
 JnS9RJOidkCWkUkwDuFeZmmV1fhxpdwcHtPnxo3ri/JdUWaL42+dIz3v2mpvliweM2LDtWOD2o2
 Q5/TCcCCd4y09RW98FO+EnT++2nUmyPZx4pgj7tVXfsPdj92qqOfMFFt1QgdzwnCWWh8fKBsIgV
 SYPSCYgVRDYd7JpBhisKoJhf833eR++rI8YM3xeQ18jq5eAalPra6IdK6W5tBiR8mBttTMrYpOY
 stGr8Vv520mpmVROrszmr+AKOCE0PN5o1GOk8UiqStsH7ghXsqxII1wVkAp/xRBIceUmdkJdh4x
 2E5rWZgEmYAlRWyIOMF8+95QNWF9nkvTSsZa+jj/A7QwIZUJIEHBHrplzofxkQArJHFaXQlSIMi
 rk9DGCf3Sktk36ohoIAOSX8aeqdkyyyuimpUqh4SitwqPJLMIGUPky51S7HcDGx9N2Fr6V6wavQ
 Pf7m8Tbq20nYC9A==
X-Developer-Key: i=fred@cloudflare.com; a=openpgp;
 fpr=CB341A8C566BB53C7BE339EDAB25B4760392D36D

integrity_audit_msg() hides error codes by wrapping
integrity_audit_message() which obfuscates the underlying reason for the
failure.

Update integrity_audit_msg() call sites to take an error code and report
errors the same as integrity_audit_message().

Signed-off-by: Frederick Lawler <fred@cloudflare.com>
---
 security/integrity/evm/evm_main.c         |  9 +++++----
 security/integrity/ima/ima_api.c          |  8 ++++----
 security/integrity/ima/ima_appraise.c     |  6 +++---
 security/integrity/ima/ima_fs.c           |  4 ++--
 security/integrity/ima/ima_init.c         |  2 +-
 security/integrity/ima/ima_main.c         |  7 ++++---
 security/integrity/ima/ima_policy.c       | 11 ++++++-----
 security/integrity/ima/ima_queue.c        |  2 +-
 security/integrity/ima/ima_template_lib.c |  2 +-
 security/integrity/integrity.h            |  5 +++--
 security/integrity/integrity_audit.c      |  5 +++--
 11 files changed, 33 insertions(+), 28 deletions(-)

diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index b59e3f121b8a89edb14d811351ec393a69de8ff7..5be9349afcd09b47b78d1126ffc1fe341264ae6e 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -563,7 +563,7 @@ static int evm_protect_xattr(struct mnt_idmap *idmap,
 				    dentry->d_inode, dentry->d_name.name,
 				    "update_metadata",
 				    integrity_status_msg[evm_status],
-				    -EPERM, 0);
+				    -EPERM, 0, -EPERM);
 	}
 out:
 	/* Exception if the HMAC is not going to be calculated. */
@@ -588,7 +588,7 @@ static int evm_protect_xattr(struct mnt_idmap *idmap,
 		integrity_audit_msg(AUDIT_INTEGRITY_METADATA, d_backing_inode(dentry),
 				    dentry->d_name.name, "appraise_metadata",
 				    integrity_status_msg[evm_status],
-				    -EPERM, 0);
+				    -EPERM, 0, -EPERM);
 	return evm_status == INTEGRITY_PASS ? 0 : -EPERM;
 }
 
@@ -729,7 +729,7 @@ static int evm_inode_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		integrity_audit_msg(AUDIT_INTEGRITY_METADATA, d_backing_inode(dentry),
 				    dentry->d_name.name, "appraise_metadata",
 				    integrity_status_msg[evm_status],
-				    -EPERM, 0);
+				    -EPERM, 0, -EPERM);
 	return -EPERM;
 }
 
@@ -992,7 +992,8 @@ static int evm_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 
 	integrity_audit_msg(AUDIT_INTEGRITY_METADATA, d_backing_inode(dentry),
 			    dentry->d_name.name, "appraise_metadata",
-			    integrity_status_msg[evm_status], -EPERM, 0);
+			    integrity_status_msg[evm_status], -EPERM, 0,
+			    -EPERM);
 	return -EPERM;
 }
 
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 122d127e108dcca8ddae6575c908144859783fb6..f765bfe5db68d0847cfe5b47f81b64018083f65a 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -116,7 +116,7 @@ int ima_store_template(struct ima_template_entry *entry,
 		if (result < 0) {
 			integrity_audit_msg(AUDIT_INTEGRITY_PCR, inode,
 					    template_name, op,
-					    audit_cause, result, 0);
+					    audit_cause, result, 0, result);
 			return result;
 		}
 	}
@@ -159,7 +159,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
 		ima_free_template_entry(entry);
 err_out:
 	integrity_audit_msg(AUDIT_INTEGRITY_PCR, inode, filename,
-			    op, cause, result, 0);
+			    op, cause, result, 0, result);
 }
 
 /**
@@ -330,7 +330,7 @@ int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
 
 		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode,
 				    filename.name.name, "collect_data",
-				    audit_cause, result, 0);
+				    audit_cause, result, 0, result);
 
 		release_dentry_name_snapshot(&filename);
 	}
@@ -383,7 +383,7 @@ void ima_store_measurement(struct ima_iint_cache *iint, struct file *file,
 	result = ima_alloc_init_template(&event_data, &entry, template_desc);
 	if (result < 0) {
 		integrity_audit_msg(AUDIT_INTEGRITY_PCR, inode, filename,
-				    op, audit_cause, result, 0);
+				    op, audit_cause, result, 0, result);
 		return;
 	}
 
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index b280488e15fcb0b6f8a8a0caaab93c7d511e4a40..6dc712f430f44ee18c3418a6bf4cd4da49758b98 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -564,7 +564,7 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 		status = INTEGRITY_FAIL;
 		cause = "unverifiable-signature";
 		integrity_audit_msg(audit_msgno, inode, filename,
-				    op, cause, rc, 0);
+				    op, cause, rc, 0, rc);
 	} else if (status != INTEGRITY_PASS) {
 		/* Fix mode, but don't replace file signatures. */
 		if ((ima_appraise & IMA_APPRAISE_FIX) && !try_modsig &&
@@ -589,7 +589,7 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 		}
 
 		integrity_audit_msg(audit_msgno, inode, filename,
-				    op, cause, rc, 0);
+				    op, cause, rc, 0, rc);
 	} else {
 		ima_cache_flags(iint, func);
 	}
@@ -752,7 +752,7 @@ static int validate_hash_algo(struct dentry *dentry,
 		path = NULL;
 
 	integrity_audit_msg(AUDIT_INTEGRITY_DATA, d_inode(dentry), path,
-			    "set_data", errmsg, -EACCES, 0);
+			    "set_data", errmsg, -EACCES, 0, -EACCES);
 
 	kfree(pathbuf);
 
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 2a0bca5543161912abe2a0236c9fcae7055e62bc..6d2ef44b21f8d40b4981a6a441cf7c3d69f94dee 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -595,7 +595,7 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
 		pr_err("signed policy file (specified as an absolute pathname) required\n");
 		integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL, NULL,
 				    "policy_update", "signed policy required",
-				    1, 0);
+				    1, 0, -EINVAL);
 		result = -EACCES;
 	} else {
 		ima_measure_raw_policy(data, datalen);
@@ -745,7 +745,7 @@ static int ima_release_policy(struct inode *inode, struct file *file)
 
 	pr_info("policy update %s\n", cause);
 	integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL, NULL,
-			    "policy_update", cause, !valid_policy, 0);
+			    "policy_update", cause, !valid_policy, 0, 0);
 
 	if (!valid_policy) {
 		ima_delete_rules();
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index d53f4d89a53e56d7ebb31950c10b37fc89782753..7a76e2686267482b10bf854a76829c60ef9f1e1b 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -103,7 +103,7 @@ static int __init ima_add_boot_aggregate(void)
 	return 0;
 err_out:
 	integrity_audit_msg(AUDIT_INTEGRITY_PCR, NULL, filename, op,
-			    audit_cause, result, 0);
+			    audit_cause, result, 0, result);
 	return result;
 }
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index ab1e53b3210d3a4d3f91d65f7db19e6a2a2d401c..9e80f40680d7be08d14d26ba48ed334d4e4ab10c 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -119,7 +119,7 @@ static int mmap_violation_check(enum ima_hooks func, struct file *file,
 			*pathname = ima_d_path(&file->f_path, pathbuf,
 					       filename);
 		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, *pathname,
-				    "mmap_file", "mmapped_writers", rc, 0);
+				    "mmap_file", "mmapped_writers", rc, 0, rc);
 	}
 	return rc;
 }
@@ -466,7 +466,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 
 		integrity_audit_msg(AUDIT_INTEGRITY_DATA, file_inode(file),
 				    pathname, "collect_data",
-				    "denied-hash-algorithm", rc, 0);
+				    "denied-hash-algorithm", rc, 0, rc);
 	}
 out_locked:
 	if ((mask & MAY_WRITE) && test_bit(IMA_DIGSIG, &iint->atomic_flags) &&
@@ -579,7 +579,8 @@ static int ima_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
 	file = vma->vm_file;
 	pathname = ima_d_path(&file->f_path, &pathbuf, filename);
 	integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, pathname,
-			    "collect_data", "failed-mprotect", result, 0);
+			    "collect_data", "failed-mprotect", result, 0,
+			    result);
 	if (pathbuf)
 		__putname(pathbuf);
 
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 68d9a5e6c232ea0678e9f51f105cebecccccb43e..9013c962dc0bfd6184948230ad6746e71f6e82f5 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1992,7 +1992,8 @@ ssize_t ima_parse_add_rule(char *rule)
 	entry = kzalloc_obj(*entry);
 	if (!entry) {
 		integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL,
-				    NULL, op, "-ENOMEM", -ENOMEM, audit_info);
+				    NULL, op, "-ENOMEM", -ENOMEM, audit_info,
+				    -ENOMEM);
 		return -ENOMEM;
 	}
 
@@ -2003,7 +2004,7 @@ ssize_t ima_parse_add_rule(char *rule)
 		ima_free_rule(entry);
 		integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL,
 				    NULL, op, "invalid-policy", result,
-				    audit_info);
+				    audit_info, result);
 		return result;
 	}
 
@@ -2421,7 +2422,7 @@ void ima_measure_loaded_policy(void)
 	rule = kmalloc(rule_len, GFP_KERNEL);
 	if (!rule) {
 		integrity_audit_msg(AUDIT_INTEGRITY_PCR, NULL, event_name,
-				    op, "ENOMEM", result, 0);
+				    op, "ENOMEM", result, 0, result);
 		return;
 	}
 
@@ -2440,7 +2441,7 @@ void ima_measure_loaded_policy(void)
 			result = -E2BIG;
 			integrity_audit_msg(AUDIT_INTEGRITY_PCR, NULL,
 					    event_name, op, "rule_length",
-					    result, 0);
+					    result, 0, result);
 			rcu_read_unlock();
 			goto free_rule;
 		}
@@ -2454,7 +2455,7 @@ void ima_measure_loaded_policy(void)
 	file.buf = kmalloc(file_len, GFP_KERNEL);
 	if (!file.buf) {
 		integrity_audit_msg(AUDIT_INTEGRITY_PCR, NULL, event_name,
-				    op, "ENOMEM", result, 0);
+				    op, "ENOMEM", result, 0, result);
 		goto free_rule;
 	}
 
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index f89f0ca3d4edf16a7147b3c23d25fc2cf18044c6..8d3282ff7da4131ae4389bf832442285e500542d 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -292,7 +292,7 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
 out:
 	mutex_unlock(&ima_extend_list_mutex);
 	integrity_audit_msg(AUDIT_INTEGRITY_PCR, inode, filename,
-			    op, audit_cause, result, audit_info);
+			    op, audit_cause, result, audit_info, result);
 	return result;
 }
 
diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index 8a89236f926c10af0dd2b2ef08fbe59bd8a78b66..9bd80ca1159a2fe24b3ea3308a118f6beea733cb 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -392,7 +392,7 @@ int ima_eventdigest_init(struct ima_event_data *event_data,
 	if (result) {
 		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode,
 				    event_data->filename, "collect_data",
-				    "failed", result, 0);
+				    "failed", result, 0, result);
 		return result;
 	}
 	cur_digest = hash_hdr->digest;
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 0c581c03c5da72d80e9c352a7adff1fb89628644..2ab6b7e34e7ee2dd29ae03ae1fb45fa26d9c032a 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -218,7 +218,8 @@ static inline void evm_load_x509(void)
 /* declarations */
 void integrity_audit_msg(int audit_msgno, struct inode *inode,
 			 const unsigned char *fname, const char *op,
-			 const char *cause, int result, int info);
+			 const char *cause, int result, int info,
+			 int errno);
 
 void integrity_audit_message(int audit_msgno, struct inode *inode,
 			     const unsigned char *fname, const char *op,
@@ -235,7 +236,7 @@ integrity_audit_log_start(struct audit_context *ctx, gfp_t gfp_mask, int type)
 static inline void integrity_audit_msg(int audit_msgno, struct inode *inode,
 				       const unsigned char *fname,
 				       const char *op, const char *cause,
-				       int result, int info)
+				       int result, int info, int errno)
 {
 }
 
diff --git a/security/integrity/integrity_audit.c b/security/integrity/integrity_audit.c
index d8d9e5ff1cd22b091f462d1e83d28d2d6bd983e9..2dd2d7e3916e7bf35c753450315ff22e2d0292b7 100644
--- a/security/integrity/integrity_audit.c
+++ b/security/integrity/integrity_audit.c
@@ -27,10 +27,11 @@ __setup("integrity_audit=", integrity_audit_setup);
 
 void integrity_audit_msg(int audit_msgno, struct inode *inode,
 			 const unsigned char *fname, const char *op,
-			 const char *cause, int result, int audit_info)
+			 const char *cause, int result, int audit_info,
+			 int errno)
 {
 	integrity_audit_message(audit_msgno, inode, fname, op, cause,
-				result, audit_info, 0);
+				result, audit_info, errno);
 }
 
 void integrity_audit_message(int audit_msgno, struct inode *inode,

-- 
2.43.0

