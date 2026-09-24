Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56715440A08;
	Thu, 24 Sep 2026 08:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790240193; cv=none; b=tRqrBj2IL91PIUy6Nj8JAFRlVycjxHUloEfWarXH4s1FxAerC5EqYRobhDeKAXb0H69Ax29lgMVGjQCIzvR7evD+J16QUkYLhrdtFO0t+kekuTxLyZ6TnFFEJXrqjSM/Y8Ia7Iyg7TJLJWFmq3LqFYrClMxOgl6sXAXkS1lBis4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790240193; c=relaxed/simple;
	bh=5Tb1PpG7s7cy+Fj9Yxcg/TPJIFLc3vf8o0k+Qpm2+NI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PHh8g2760ThOXPyrjtqDR4SfI+gg+2gjl+zv5nlR3L1ecLVW5wl6F8vHfNH8KxZg70yCYLpAk/YvD9tfFIZagrymgBB2H58CZz+xWv6e4RBM5znLr56CkJMUnYD99mKB9B7IbcMvesdl1qc7iU8xhZ+2Ehc20YUr03qysQ9Sxso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=GXBi5pPl; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="GXBi5pPl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=SMrgD3GPe1YVF3mBroS7akFN9xo97CboF/VKhjeZqdU=; b=GXBi5pPlaB3eosFIwtdISjpoxi
	nxQf3F5SW0Z1uOlwXPz78UrfPadeid3Ictxam7EflTt9FNlMXA4En5LXWkLRivSnZ5ETYBZ0F4PA6
	dxDv6f2q2WDHtQ35DZKDhOsoSzLWMnmthchOBMRsMz4Kaans++M4UFiligRSNxsfR3KznGi5tE4Dc
	swhoYMm48WJNQgivS0YBxFiF6eSLfCCPggq6mrFqj4Rkbz+oQGDc86y7FO9qlmtawOFd3tjBA1iR7
	Sg/gJvg8TUGAbLiEQ7BJ6Yx317z+IO9OZfOUYlC1wkqmHJ40BFTReDQE3lpbopKE9UroWT5bptRmb
	5RGMykwA==;
Received: from [151.115.150.205] (port=58504 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1x9fFj-00000001F00-1Yay;
	Thu, 24 Sep 2026 10:56:27 +0200
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
Subject: [PATCH v2] ima: discard modsig on detached-data binding failure
Date: Thu, 24 Sep 2026 08:55:17 +0000
Message-ID: <20260924085516.3111521-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

ima_collect_modsig() supplies the file contents to the parsed PKCS#7
message as detached data. If the message already contains embedded data,
pkcs7_supply_detached_data() returns -EINVAL, but IMA discards the error.
ima_modsig_verify() subsequently verifies that embedded data instead of
the file being appraised.

Return binding errors and discard the modsig on failure, preserving
ordinary hashing and security.ima appraisal. Keep digest export optional:
ML-DSA and multiple-signer messages can still verify without it. Leave
d-modsig empty when unavailable instead of dropping the measurement.
Audit binding errors separately so O_DIRECT does not hide their cause.

Fixes: 15588227e086 ("ima: Collect modsig")
Assisted-by: LLM
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
Changes in v2:
- If binding fails, discard the modsig but continue hashing and 
  xattr appraisal.
- Keep signatures without exported digests; leave d-modsig empty.
- Audit binding failures separately, even with O_DIRECT.

v1: https://lore.kernel.org/all/20260822082434.489470-2-Jeremy.Jean@oss.cyber.gouv.fr/

 Documentation/security/IMA-templates.rst  |  3 ++-
 security/integrity/ima/ima.h              |  9 ++++----
 security/integrity/ima/ima_api.c          | 28 ++++++++++++++++-------
 security/integrity/ima/ima_main.c         |  2 +-
 security/integrity/ima/ima_modsig.c       | 16 +++++++++----
 security/integrity/ima/ima_template_lib.c |  4 ++--
 6 files changed, 41 insertions(+), 21 deletions(-)

diff --git a/Documentation/security/IMA-templates.rst b/Documentation/security/IMA-templates.rst
index 15b4add..de7a3df 100644
--- a/Documentation/security/IMA-templates.rst
+++ b/Documentation/security/IMA-templates.rst
@@ -69,7 +69,8 @@ descriptors by adding their identifier to the format string
    algorithm (field format: <hash algo>:digest);
  - 'd-ngv2': same as d-ng, but prefixed with the "ima" or "verity" digest type
    (field format: <digest type>:<hash algo>:digest);
- - 'd-modsig': the digest of the event without the appended modsig;
+ - 'd-modsig': the digest of the event without the appended modsig, empty
+   when no signature digest can be exported;
  - 'n-ng': the name of the event, without size limitations;
  - 'sig': the file signature, based on either the file's/fsverity's digest[1],
    or the EVM portable signature, if 'security.ima' contains a file hash.
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 10214f7..a899a81 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -431,7 +431,7 @@ int ima_get_action(struct mnt_idmap *idmap, struct inode *inode,
 int ima_must_measure(struct inode *inode, int mask, enum ima_hooks func);
 int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
 			    void *buf, loff_t size, enum hash_algo algo,
-			    struct modsig *modsig);
+			    struct modsig **modsig);
 void ima_store_measurement(struct ima_iint_cache *iint, struct file *file,
 			   const unsigned char *filename,
 			   struct evm_ima_xattr_data *xattr_value,
@@ -559,7 +559,7 @@ static inline void __init init_ima_appraise_lsm(const struct lsm_id *lsmid)
 #ifdef CONFIG_IMA_APPRAISE_MODSIG
 int ima_read_modsig(enum ima_hooks func, const void *buf, loff_t buf_len,
 		    struct modsig **modsig);
-void ima_collect_modsig(struct modsig *modsig, const void *buf, loff_t size);
+int ima_collect_modsig(struct modsig *modsig, const void *buf, loff_t size);
 int ima_get_modsig_digest(const struct modsig *modsig, enum hash_algo *algo,
 			  const u8 **digest, u32 *digest_size);
 int ima_get_raw_modsig(const struct modsig *modsig, const void **data,
@@ -572,9 +572,10 @@ static inline int ima_read_modsig(enum ima_hooks func, const void *buf,
 	return -EOPNOTSUPP;
 }
 
-static inline void ima_collect_modsig(struct modsig *modsig, const void *buf,
-				      loff_t size)
+static inline int ima_collect_modsig(struct modsig *modsig, const void *buf,
+				     loff_t size)
 {
+	return -EOPNOTSUPP;
 }
 
 static inline int ima_get_modsig_digest(const struct modsig *modsig,
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 122d127..466eea5 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -235,6 +235,8 @@ static bool ima_get_verity_digest(struct ima_iint_cache *iint,
  *
  * Calculate the file hash, if it doesn't already exist,
  * storing the measurement and i_version in the iint.
+ * If modsig is provided, bind it to the file data or discard it on failure
+ * so ordinary measurement and xattr appraisal can proceed.
  *
  * Must be called with iint->mutex held.
  *
@@ -242,7 +244,7 @@ static bool ima_get_verity_digest(struct ima_iint_cache *iint,
  */
 int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
 			    void *buf, loff_t size, enum hash_algo algo,
-			    struct modsig *modsig)
+			    struct modsig **modsig)
 {
 	const char *audit_cause = "failed";
 	struct inode *inode = file_inode(file);
@@ -252,7 +254,7 @@ int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
 						struct ima_digest_data, hdr);
 	struct name_snapshot filename;
 	struct kstat stat;
-	int result = 0;
+	int result = 0, modsig_result = 0;
 	int length;
 	void *tmpbuf;
 	u64 i_version = 0;
@@ -262,8 +264,13 @@ int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
 	 * the file digest without collecting the modsig in a previous
 	 * measurement rule.
 	 */
-	if (modsig)
-		ima_collect_modsig(modsig, buf, size);
+	if (modsig && *modsig) {
+		modsig_result = ima_collect_modsig(*modsig, buf, size);
+		if (modsig_result) {
+			ima_free_modsig(*modsig);
+			*modsig = NULL;
+		}
+	}
 
 	if (iint->flags & IMA_COLLECTED)
 		goto out;
@@ -322,15 +329,20 @@ int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
 	if (!result)
 		iint->flags |= IMA_COLLECTED;
 out:
-	if (result) {
+	if (result || modsig_result) {
 		if (file->f_flags & O_DIRECT)
 			audit_cause = "failed(directio)";
 
 		take_dentry_name_snapshot(&filename, file->f_path.dentry);
 
-		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode,
-				    filename.name.name, "collect_data",
-				    audit_cause, result, 0);
+		if (modsig_result)
+			integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode,
+					    filename.name.name, "collect_data",
+					    "failed-modsig", modsig_result, 0);
+		if (result)
+			integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode,
+					    filename.name.name, "collect_data",
+					    audit_cause, result, 0);
 
 		release_dentry_name_snapshot(&filename);
 	}
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index ab1e53b..561fbd9 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -422,7 +422,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 
 	hash_algo = ima_get_hash_algo(xattr_value, xattr_len);
 
-	rc = ima_collect_measurement(iint, file, buf, size, hash_algo, modsig);
+	rc = ima_collect_measurement(iint, file, buf, size, hash_algo, &modsig);
 	if (rc != 0 && rc != -EBADF && rc != -EINVAL)
 		goto out_locked;
 
diff --git a/security/integrity/ima/ima_modsig.c b/security/integrity/ima/ima_modsig.c
index 632c746..8bc42ed 100644
--- a/security/integrity/ima/ima_modsig.c
+++ b/security/integrity/ima/ima_modsig.c
@@ -96,8 +96,12 @@ int ima_read_modsig(enum ima_hooks func, const void *buf, loff_t buf_len,
  * Since the modsig is part of the file contents, the hash used in its signature
  * isn't the same one ordinarily calculated by IMA. Therefore PKCS7 code
  * calculates a separate one for signature verification.
+ *
+ * Digest export is best-effort; not all signatures expose a single digest.
+ *
+ * Return: 0 if the file data was supplied, error code otherwise.
  */
-void ima_collect_modsig(struct modsig *modsig, const void *buf, loff_t size)
+int ima_collect_modsig(struct modsig *modsig, const void *buf, loff_t size)
 {
 	int rc;
 
@@ -109,11 +113,13 @@ void ima_collect_modsig(struct modsig *modsig, const void *buf, loff_t size)
 		sizeof(struct module_signature);
 	rc = pkcs7_supply_detached_data(modsig->pkcs7_msg, buf, size);
 	if (rc)
-		return;
+		return rc;
+
+	/* Digest export failure does not preclude signature verification. */
+	pkcs7_get_digest(modsig->pkcs7_msg, &modsig->digest,
+			 &modsig->digest_size, &modsig->hash_algo);
 
-	/* Ask the PKCS7 code to calculate the file hash. */
-	rc = pkcs7_get_digest(modsig->pkcs7_msg, &modsig->digest,
-			      &modsig->digest_size, &modsig->hash_algo);
+	return 0;
 }
 
 int ima_modsig_verify(struct key *keyring, const struct modsig *modsig)
diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index 8a89236..1be7861 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -478,8 +478,8 @@ int ima_eventdigest_modsig_init(struct ima_event_data *event_data,
 		if (rc)
 			return rc;
 		else if (hash_algo == HASH_ALGO__LAST || cur_digestsize == 0)
-			/* There was some error collecting the digest. */
-			return -EINVAL;
+			/* Keep the ordinary measurement without an exported digest. */
+			return 0;
 	}
 
 	return ima_eventdigest_init_common(cur_digest, cur_digestsize,
-- 
2.47.3
