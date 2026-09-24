Received: from mail-oo2-f7.google.com (mail-oo2-f7.google.com [74.125.231.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2068341D4F1
	for <linux-security-module@vger.kernel.org>; Thu, 24 Sep 2026 20:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790282121; cv=none; b=IdRvoO7+taW93/LY+QUlzm5BjGpRFNE1V5TQ7A4KYRyvtRvinDEptHxR5ozsauJUN2zOekME062OTfXLjVmAasyyowOsgYH5GknaZjlBqLIfP+zwgt4w83jd7vp7CncH5JiSPXKDqTEBlEB4AVKKiZ9rp6Ub/6QBCGhT+6j6s9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790282121; c=relaxed/simple;
	bh=kv4E/vrBNL66Zx8E/D5qbn+5NCQZtRHWjF+mgsWDLDM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gz+L2ejc98vRofdf0qmnl51B7jt8r7+kSo//K8cIKhUzE5qOf1ckJ7XiibvxEEFc39mnsUdoRPSMX/zq2NmphtbtKP6NoPw9NxSSB1e6jxQXVFBM9qWN8i0F64IjDsOUhREKpz8pCrAd5bQx8TUVT4qsfBoF0kP1YvuA4z+7/60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=PAHyprJa; arc=none smtp.client-ip=74.125.231.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="PAHyprJa"
Received: by mail-oo2-f7.google.com with SMTP id 006d021491bc7-6c1ba2091cbso89299eaf.1
        for <linux-security-module@vger.kernel.org>; Thu, 24 Sep 2026 13:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1790282113; x=1790886913; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IiDuodgS3SR9GcCiq5RQZfN0N3aP810HG8lRqCBF0Gs=;
        b=PAHyprJagsf6EADg78bhSzvCq4GAcu8zc/GPsCPI19GdP7rOFqxXIitO8D49GDmGOz
         aerD5sG8UTbB5wkZ2oHqGbgRtt1NwnUhaMSihHWtYlU4a8yP2CKNKkUlhVlsmltNWvK3
         M1UgdpkUtQ+mFV8uWPf4updu4j1fW8RFfnheGpqxVDLmECxktQTnSl2eqYTnHNMsYhDY
         +xc2g4O3JUKk9Of7kHD8iptr25FhrH0WRD8wrU3H2hOrDPKcA426aMg+c6sxXati7h2Q
         RgYXUBcc4omw2YSsGtQpv4Cj6rgiBpiV8c6fyDvcMAMe0Qlu/4N+Lw5MbFvsMXTCI7AU
         LNUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790282113; x=1790886913;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IiDuodgS3SR9GcCiq5RQZfN0N3aP810HG8lRqCBF0Gs=;
        b=YPFv9t3u7GOJDTrF+acHauji/rSjpSjq4f/5XnrwdMftxGB30R3VTxLMDQo4exzi6d
         GxsVbv1Rx5OrTKxnr7jT6JLtWSe5E76wr63KyBK6COuSi81VYMStKS36qzLgpDdZ3P+j
         SK/Q4Go0VKH167EtKGILKQtA4oGHgkFa/4bd4pnSRwsOPu56J1daJ26quXZZURkWBWcp
         c+00GazXtBjYC7LhG0MeOKtIATsuJJsGzAuGpFqLMW5W9stQfmhaJXJfXMp432T92k9N
         EKTDyiY07MSJhq9EbDqFXz5jHm4Xlnr2WALpcdInYzuTGqKT9qfCfvlaoJ51kKZt3M4S
         lFxg==
X-Forwarded-Encrypted: i=1; AKwUvBzAnKSg85qWDRyEBRTC6U4HAF/6T5Ld2dnyiTMfRLzgefq4Qu3z58fTnpu09UrNWR3rnXk2+3oO+JV+8YQ372C0tHn1pkQ=@vger.kernel.org
X-Gm-Message-State: AFuF++ncRe+REJ1tibntnubY6yFK9JQR14fmV1B7e3ktn17vlWW5jxg0
	dXLsjSVLoOhn9vYP0iBhyEzpfG8SahzQjq6J3eoGD8mWZvkUXh6Uvb2cZNneHjXcjeM=
X-Gm-Gg: AYBFou1Qlw3TXLjHGmMGry7Y6IbNM6hPvdPtXAkeV89AAFiIZB0f/Xm2m1mQAi/WmNK
	orSXoyFDogxEpDvCwMQ8IWEFnm+6EYBQy517vrj/oydbmAO66ykTiMyb078u0wVoZOWSfOiivAc
	UNBXRy1tBqHTUPbOBsY02ypZpqlDfCGrpMv+qlIG48+PKS6a8EvwInFHfTkVLYw+jUixVUcERk9
	CmCQNJsm0tHRfFu+QFPlNADLfyoqmnpGQtjAIKmG3N1/N/aWGYdgCj3JipLbwiabOCwxqeuuMcF
	a1yQnrCLrqZuL92hKNaJgJRe33sH6tblbVzFZ+JKEpMMj9TfpoGpmWVtntaYNGwUAS0fo/81dZb
	rCHegPnoTbwsWilvu0s54mP22vTxEzKLdfYNrYUsHjK020nnZnpPrjqV0YcYvOlQag88xnEeew6
	jxR94qKU+QKorFhnkijpuQSZR2TMVF5947sJeKnzi7fcLRT5uhYzfJMUcs
X-Received: by 2002:a05:6820:4d03:b0:6cd:3fec:de7f with SMTP id 006d021491bc7-6d441d73f44mr3877614eaf.85.1790282113406;
        Thu, 24 Sep 2026 13:35:13 -0700 (PDT)
Received: from [127.0.1.1] ([2a09:bac6:947f:1cd2::2df:f])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-49335011458sm254515fac.4.2026.09.24.13.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 13:35:12 -0700 (PDT)
From: Frederick Lawler <fred@cloudflare.com>
Date: Thu, 24 Sep 2026 15:34:58 -0500
Subject: [PATCH v4 1/2] integrity: Report error code in
 integrity_audit_msg() call sites
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-report-hash-error-v4-1-196ca6350619@cloudflare.com>
References: <20260924-report-hash-error-v4-0-196ca6350619@cloudflare.com>
In-Reply-To: <20260924-report-hash-error-v4-0-196ca6350619@cloudflare.com>
To: Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-team@cloudflare.com, 
 Enrico Bravi <enrico.bravi@polito.it>, 
 Frederick Lawler <fred@cloudflare.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=13759; i=fred@cloudflare.com;
 h=from:subject:message-id; bh=kv4E/vrBNL66Zx8E/D5qbn+5NCQZtRHWjF+mgsWDLDM=;
 b=owEBbQKS/ZANAwAKAasltHYDktNtAcsmYgBqtYl7UD6ovqBUvg8P8YRkclLxAcN6TzvdQeiON
 MQcuxl2YRGJAjMEAAEKAB0WIQTLNBqMVmu1PHvjOe2rJbR2A5LTbQUCarWJewAKCRCrJbR2A5LT
 bXX1EACVqNyd8UHWxTF66kAwbJ8q0l7Q+/oc0Ac0v239mnouUjW4k1c6jdh8E3NIMj86t7WwgYT
 fIngS46g9vpWcHfjXtQkljHOoUwvH7Pp48xROQEJdljyJcx6KZ9J1FD8QGJts7rJXCN2KlOXZtk
 6jZh13uEUIMJkH2OSmOoq0wPGlFhtiHLwa+dQfykC9W9QwL1VcTgyb01O9kLJounb0Re1nMLRLd
 KoKSGzFHaGr/Bil4gtAnlcqmgKgepdcX4XO18K3JbyJShd6dJnse1Luo0yDtOdKALhkLf4uJyCJ
 YNyc/XuRrFt9Zn0cGG8ut8CrJsyTcORmoc2o5iIpfOdG5HkEhaK1hn7uHB0ThbI8V2r/Rb4sHT0
 ixvuV0C6+BzsD63RpFQO1Ue8rcDMGZfi5Ckwi7AX3UpSENxWpYW1oTz/6IVEYwlJYf1INsTcDLZ
 TQm/TemEXbq/zM2IHfXMJU3mmEAgwniAh+G3vHTXLA/H1uzNHcPtbPs7NP1M/k1Oboo65YpCuC5
 ob92i87kcKyqycCq6rSsqh5Y7nH4U9iJ4KeLNDoZIQvP+sMHfDq/s9LC46oE4twtsY1dj4bQJNF
 g9857gvKwqVQ8OC12JqaHqjVLLybjLwkfDhqjWMAtxjnSM3uTUnCZeNmuS3BTH3AUbjr/fFdZLd
 RQO+Fv2Ub4wKRzw==
X-Developer-Key: i=fred@cloudflare.com; a=openpgp;
 fpr=CB341A8C566BB53C7BE339EDAB25B4760392D36D

integrity_audit_msg() hides error codes by wrapping
integrity_audit_message() which obfuscates the underlying reason for the
failure.

Update integrity_audit_msg() to take a errno argument, and pass that
through to integrity_audit_message(). Then update call sites to
take caller's respective error codes.

ima_appraise_measurement() stores xattr_len as the return code, but
can replace it with a error code later. Therefore conditionally use
a code if rc < 0, otherwise report zero. Lastly, conditionally use
-EINVAL for ima_release_policy().

Signed-off-by: Frederick Lawler <fred@cloudflare.com>
---
 security/integrity/evm/evm_main.c         |  9 +++++----
 security/integrity/ima/ima_api.c          |  8 ++++----
 security/integrity/ima/ima_appraise.c     |  6 +++---
 security/integrity/ima/ima_fs.c           |  7 ++++---
 security/integrity/ima/ima_init.c         |  2 +-
 security/integrity/ima/ima_main.c         |  7 ++++---
 security/integrity/ima/ima_policy.c       | 11 ++++++-----
 security/integrity/ima/ima_queue.c        |  2 +-
 security/integrity/ima/ima_template_lib.c |  2 +-
 security/integrity/integrity.h            |  5 +++--
 security/integrity/integrity_audit.c      |  5 +++--
 11 files changed, 35 insertions(+), 29 deletions(-)

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
index b280488e15fcb0b6f8a8a0caaab93c7d511e4a40..84c4dee2323cf7352cccd8e4c9291d0fb6eed8e1 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -564,7 +564,7 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 		status = INTEGRITY_FAIL;
 		cause = "unverifiable-signature";
 		integrity_audit_msg(audit_msgno, inode, filename,
-				    op, cause, rc, 0);
+				    op, cause, rc, 0, rc < 0 ? rc : 0);
 	} else if (status != INTEGRITY_PASS) {
 		/* Fix mode, but don't replace file signatures. */
 		if ((ima_appraise & IMA_APPRAISE_FIX) && !try_modsig &&
@@ -589,7 +589,7 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 		}
 
 		integrity_audit_msg(audit_msgno, inode, filename,
-				    op, cause, rc, 0);
+				    op, cause, rc, 0, rc < 0 ? rc : 0);
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
index 2a0bca5543161912abe2a0236c9fcae7055e62bc..3b8174a91a3451128c0b182e852875d5b73d3efb 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -592,11 +592,11 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
 	if (data[0] == '/') {
 		result = ima_read_policy(data);
 	} else if (ima_appraise & IMA_APPRAISE_POLICY) {
+		result = -EACCES;
 		pr_err("signed policy file (specified as an absolute pathname) required\n");
 		integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL, NULL,
 				    "policy_update", "signed policy required",
-				    1, 0);
-		result = -EACCES;
+				    result, 0, result);
 	} else {
 		ima_measure_raw_policy(data, datalen);
 		result = ima_parse_add_rule(data);
@@ -745,7 +745,8 @@ static int ima_release_policy(struct inode *inode, struct file *file)
 
 	pr_info("policy update %s\n", cause);
 	integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL, NULL,
-			    "policy_update", cause, !valid_policy, 0);
+			    "policy_update", cause, !valid_policy, 0,
+			    !valid_policy ? -EINVAL : 0);
 
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

