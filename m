Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE27D32AAA8;
	Sat, 22 Aug 2026 08:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787387154; cv=none; b=YjioKquymiBo0oqjOjZJlUNSK7wWv3I5FEoWViU6/dH9a73L0IuROYolgQqH2/r1Qcr9EDqTGuv4sAqxLtIlreGoTF3cnDjgctKKvoq20hPLx1TdYiKDRsZfpBMn8MpFjn0kYKL7OqkKYd9OeyoSBSTjoUzk9fBarS8azI4QjV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787387154; c=relaxed/simple;
	bh=8SbYoHIqVUdJZchRflRs4wb7rNgWqL2Hq59V1mXAZZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KvPywM0FANaGTOUu2ntI+CbPsj85oou/ItoGp6NFsDSyMAAIMaVIzSsRYIGhBpfwG0vu5PFybKgu17Dd/CF36JK3Z4uQdcwaCgokh/LAuifjNClb3b4pz3L5U9YC/niuArfSHLVyy+kFAUTFzUvMmP2SEZ9LYzeiDEQEdVDruWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=nEL4/Noh; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="nEL4/Noh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uJ1ZUKxXbCTSIZD7Fsdft5wZqfjqJSQrTkWsgAqQh4c=; b=nEL4/NohMZmy0DVASmmR/Wu1FU
	pkZzSkrx+VgFjN7yfhXVWo8EHEWpOWFVOdnYk3W5pMiGG8xFVy8I+Bt8M+14F6TMIPiD/JW0ECqkc
	JLofoGQAqKyrKvXEsHPctohG+yEpWExaBoirGFpabFZPPSdlMvYlvuHS7dRuu9X8qFH6Xk8JVLsfr
	+OQbly8Wz7wkvQoEab5RITbuBEfwxVbPzLhp51ErWc0cOtc7BaUG+Du0Qdj1EPvBsHPP0Fo9wZnSc
	LR0daW0+a3CdlpUIYTjY0meBM8WifFUh12KnT80wWVVE6viQRTgv0PzvLbAuRR6s4Vz51kdDpnFmv
	xlUCdInA==;
Received: from [151.115.150.205] (port=43822 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1wxh2v-00000008PL2-125a;
	Sat, 22 Aug 2026 10:25:43 +0200
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
Subject: [PATCH] ima: reject modsig if detached data cannot be supplied
Date: Sat, 22 Aug 2026 08:24:35 +0000
Message-ID: <20260822082434.489470-2-Jeremy.Jean@oss.cyber.gouv.fr>
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

ima_collect_modsig() binds the file being appraised to the parsed PKCS#7
message with pkcs7_supply_detached_data().  If the message already contains
embedded data, the helper returns -EINVAL.  However, ima_collect_modsig()
silently returns because its return type is void.

ima_modsig_verify() subsequently calls verify_pkcs7_message_sig() with a
NULL data pointer.  That verifies the embedded PKCS#7 data instead of the
file being appraised.  An attacker can therefore take a valid
detached signature, insert the original signed bytes as embedded content
without the private key, and append the resulting message to an unrelated
file.  IMA accepts the unrelated file.

This bypasses the module authenticity boundary when an IMA modsig appraisal
rule is enforced while CONFIG_MODULE_SIG is disabled.

Return detached-data binding errors and stop measurement collection when
binding fails.  Keep digest extraction optional because algorithms such as
ML-DSA can verify the message directly.  Appraisal then rejects the file
rather than reaching verification with embedded content active.

Fixes: 15588227e086 ("ima: Collect modsig")
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Assisted-by: Codex:gpt-5
---
 security/integrity/ima/ima.h        |  7 ++++---
 security/integrity/ima/ima_api.c    |  7 +++++--
 security/integrity/ima/ima_modsig.c |  9 +++++++--
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 10214f73ca1e..ac1d593a42c1 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
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
index 122d127e108d..e2b167f24778 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -262,8 +262,11 @@ int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
 	 * the file digest without collecting the modsig in a previous
 	 * measurement rule.
 	 */
-	if (modsig)
-		ima_collect_modsig(modsig, buf, size);
+	if (modsig) {
+		result = ima_collect_modsig(modsig, buf, size);
+		if (result)
+			goto out;
+	}
 
 	if (iint->flags & IMA_COLLECTED)
 		goto out;
diff --git a/security/integrity/ima/ima_modsig.c b/security/integrity/ima/ima_modsig.c
index 632c746fd81e..57dc8dc43b55 100644
--- a/security/integrity/ima/ima_modsig.c
+++ b/security/integrity/ima/ima_modsig.c
@@ -96,8 +96,10 @@ int ima_read_modsig(enum ima_hooks func, const void *buf, loff_t buf_len,
  * Since the modsig is part of the file contents, the hash used in its signature
  * isn't the same one ordinarily calculated by IMA. Therefore PKCS7 code
  * calculates a separate one for signature verification.
+ *
+ * Return: 0 if the file data was supplied, error code otherwise.
  */
-void ima_collect_modsig(struct modsig *modsig, const void *buf, loff_t size)
+int ima_collect_modsig(struct modsig *modsig, const void *buf, loff_t size)
 {
 	int rc;
 
@@ -109,11 +111,14 @@ void ima_collect_modsig(struct modsig *modsig, const void *buf, loff_t size)
 		sizeof(struct module_signature);
 	rc = pkcs7_supply_detached_data(modsig->pkcs7_msg, buf, size);
 	if (rc)
-		return;
+		return rc;
 
 	/* Ask the PKCS7 code to calculate the file hash. */
 	rc = pkcs7_get_digest(modsig->pkcs7_msg, &modsig->digest,
 			      &modsig->digest_size, &modsig->hash_algo);
+
+	/* Some signature algorithms operate on the message without a digest. */
+	return 0;
 }
 
 int ima_modsig_verify(struct key *keyring, const struct modsig *modsig)
-- 
2.47.3
