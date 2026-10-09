Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065E74CC28B;
	Fri,  9 Oct 2026 11:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791545360; cv=none; b=ccWSd7KmJN9nJjVVrUao47dJslD/+bq1HnoVklrLbOc9tq4wRzPvu04IBDnQzMJ5cEv2AHigUimmcxAqftVB1dmdRGBtcxQ87Tm+QjnDynszEclxkB0hzUityTFOZTL0m1VV1XJ4TgwTm3DMKy00rWmA1jQoD8rPWCz7gssQlh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791545360; c=relaxed/simple;
	bh=MpHafslSgTuO3ufNGAeO92J7Egq7ohQAL0gYI/dZzXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FV8rzg7Fq8PSsTs/Z3RMfc4bGF+hDwKpJWJ7IzUEuJsQ6VROSqDssoMo942+C6eyhT4AxRqXFbauoZcZgmw9dL6/O9eev3kvy6BAq1dKOuBTuXlLc60LPQJOHyYcyH/W1a5YXOchC3bZGxiYPSusZJF3/93S/KyW6+bQteLtpRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.196])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTPS id 4j1PCG32VKzt5JN;
	Fri,  9 Oct 2026 19:04:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id D27E940491;
	Fri,  9 Oct 2026 19:12:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with UTF8SMTPA id GxC2BwAHNS0RzMhqBcK7AQ--.22919S2;
	Fri, 09 Oct 2026 12:12:26 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Hodges <git@danielhodges.dev>,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH] evm: check return values of crypto_shash functions
Date: Fri,  9 Oct 2026 13:12:12 +0200
Message-ID: <20261009111212.1516243-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwAHNS0RzMhqBcK7AQ--.22919S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKFWrXF45Kw15Aw13uw18AFb_yoWxJF1fpF
	W5WayDKr4DJa1UWFZaya1rZ34F9ay0yry7KrWUW34SvFn7Xr1Fqr4Iyw18uF98Gr45Jw1Y
	qr4S9w1Uuw4aq3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUF1v3UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQABBGrIkbkfWQABsJ

From: Daniel Hodges <git@danielhodges.dev>

The crypto_shash_update() and crypto_shash_final() functions can fail
and return error codes, but their return values were not being checked
in several places in security/integrity/evm/evm_crypto.c:

- hmac_add_misc() ignored returns from crypto_shash_update() and
  crypto_shash_final()
- evm_calc_hmac_or_hash() ignored returns from crypto_shash_update()
- evm_init_hmac() ignored returns from crypto_shash_update()

If these hash operations fail silently, the resulting HMAC could be
invalid or incomplete, which could weaken the integrity verification
security that EVM provides.

This patch converts hmac_add_misc() from void to int return type and
adds proper error checking and propagation for all crypto_shash_*
function calls. All callers are updated to handle the new return values.
Additionally, error messages are logged when cryptographic operations
fail to provide visibility into the failure rather than silently
returning error codes.

Fixes: 66dbc325afce ("evm: re-release")
Signed-off-by: Daniel Hodges <git@danielhodges.dev>
Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
Link: https://github.com/linux-integrity/linux/issues/17
[zohar@linux.ibm.com: fixed commit 0496fc9cdc38 merge conflict,
checkpatch.pl warnings]
[roberto.sassu@huawei.com: call hmac_add_misc() in evm_calc_hmac_or_hash()
 only if no previous error, to avoid overwriting -ENODATA, and jump to out
 only if hmac_add_misc() fails]
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/evm/evm_crypto.c | 69 ++++++++++++++++++++++-------
 1 file changed, 53 insertions(+), 16 deletions(-)

diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index 1c41af2f91a6..5eae8723f5f9 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -140,8 +140,8 @@ static struct shash_desc *init_desc(char type, uint8_t hash_algo)
  * (Additional directory/file metadata needs to be added for more complete
  * protection.)
  */
-static void hmac_add_misc(struct shash_desc *desc, struct inode *inode,
-			  char type, char *digest)
+static int hmac_add_misc(struct shash_desc *desc, struct inode *inode,
+			 char type, char *digest)
 {
 	struct h_misc {
 		/*
@@ -156,6 +156,7 @@ static void hmac_add_misc(struct shash_desc *desc, struct inode *inode,
 		gid_t gid;
 		umode_t mode;
 	} hmac_misc;
+	int error;
 
 	memset(&hmac_misc, 0, sizeof(hmac_misc));
 	/* Don't include the inode or generation number in portable
@@ -176,14 +177,30 @@ static void hmac_add_misc(struct shash_desc *desc, struct inode *inode,
 	hmac_misc.uid = from_kuid(&init_user_ns, inode->i_uid);
 	hmac_misc.gid = from_kgid(&init_user_ns, inode->i_gid);
 	hmac_misc.mode = inode->i_mode;
-	crypto_shash_update(desc, (const u8 *)&hmac_misc, sizeof(hmac_misc));
+	error = crypto_shash_update(desc, (const u8 *)&hmac_misc,
+				    sizeof(hmac_misc));
+	if (error) {
+		pr_err("crypto_shash_update() failed: %d\n", error);
+		return error;
+	}
 	if ((evm_hmac_attrs & EVM_ATTR_FSUUID) &&
-	    type != EVM_XATTR_PORTABLE_DIGSIG)
-		crypto_shash_update(desc, (u8 *)&inode->i_sb->s_uuid, UUID_SIZE);
-	crypto_shash_final(desc, digest);
+	    type != EVM_XATTR_PORTABLE_DIGSIG) {
+		error = crypto_shash_update(desc, (u8 *)&inode->i_sb->s_uuid,
+					    UUID_SIZE);
+		if (error) {
+			pr_err("crypto_shash_update() failed: %d\n", error);
+			return error;
+		}
+	}
+	error = crypto_shash_final(desc, digest);
+	if (error) {
+		pr_err("crypto_shash_final() failed: %d\n", error);
+		return error;
+	}
 
 	pr_debug("hmac_misc: (%zu) [%*phN]\n", sizeof(struct h_misc),
 		 (int)sizeof(struct h_misc), &hmac_misc);
+	return 0;
 }
 
 /*
@@ -267,9 +284,14 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
 
 		if ((req_xattr_name && req_xattr_value)
 		    && !strcmp(xattr->name, req_xattr_name)) {
-			error = 0;
-			crypto_shash_update(desc, (const u8 *)req_xattr_value,
-					     req_xattr_value_len);
+			error = crypto_shash_update(desc,
+						    (const u8 *)req_xattr_value,
+						    req_xattr_value_len);
+			if (error) {
+				pr_err("crypto_shash_update() failed: %d\n",
+				       error);
+				goto out;
+			}
 			if (is_ima)
 				ima_present = true;
 
@@ -293,15 +315,23 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
 			pr_debug("file %s: xattr %s size mismatch (kernel: %d, user: %d)\n",
 				 dentry->d_name.name, xattr->name, size,
 				 user_space_size);
-		error = 0;
 		xattr_size = size;
-		crypto_shash_update(desc, (const u8 *)xattr_value, xattr_size);
+		error = crypto_shash_update(desc, (const u8 *)xattr_value,
+					    xattr_size);
+		if (error) {
+			pr_err("crypto_shash_update() failed: %d\n", error);
+			goto out;
+		}
 		if (is_ima)
 			ima_present = true;
 
 		dump_security_xattr(xattr->name, xattr_value, xattr_size);
 	}
-	hmac_add_misc(desc, inode, type, data->digest);
+	if (!error) {
+		error = hmac_add_misc(desc, inode, type, data->digest);
+		if (error)
+			goto out;
+	}
 
 	if (inode != d_backing_inode(dentry) && iint) {
 		if (IS_I_VERSION(inode))
@@ -409,6 +439,7 @@ int evm_init_hmac(struct inode *inode, const struct xattr *xattrs,
 	struct shash_desc *desc;
 	const struct xattr *xattr;
 	struct xattr_list *xattr_entry;
+	int error;
 
 	desc = init_desc(EVM_XATTR_HMAC, HASH_ALGO_SHA1);
 	if (IS_ERR(desc)) {
@@ -423,14 +454,20 @@ int evm_init_hmac(struct inode *inode, const struct xattr *xattrs,
 				   XATTR_SECURITY_PREFIX_LEN, xattr->name) != 0)
 				continue;
 
-			crypto_shash_update(desc, xattr->value,
-					    xattr->value_len);
+			error = crypto_shash_update(desc, xattr->value,
+						    xattr->value_len);
+			if (error) {
+				pr_err("crypto_shash_update() failed: %d\n",
+				       error);
+				goto out;
+			}
 		}
 	}
 
-	hmac_add_misc(desc, inode, EVM_XATTR_HMAC, hmac_val);
+	error = hmac_add_misc(desc, inode, EVM_XATTR_HMAC, hmac_val);
+out:
 	kfree(desc);
-	return 0;
+	return error;
 }
 
 /*
-- 
2.43.0

