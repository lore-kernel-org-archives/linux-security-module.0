Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792834776;
	b=ok9+ZWdzi5GR6EK/yoFbClBk4EmF0h1rVMXpF1TaA4D5N8EMI162YT2s3Fe49HJRSIqC
	 lEibK/ELkzsvu3aG+0rHAyHS0XgZsuKAbeGjn17MO6ppGwjF+lrWgNc6lHL9YBduUjgg7
	 IdoNUQIAKNyzIDQuaYYPx5lKB1VSMhstwi0fLA/OJAJP5f7vd/5VhmPqefZH8FV3aptUX
	 s24SZFGazU8qc2CeYHu4S7TPRsGo9KYtfEmbamFaXPtk9EVNA9LPb11qree7nVeiGdq0R
	 WbbLclI2u35dLSbsyt+uC6qV3zNFHiZZTcwWC4ydNpNV2P5YsAXbYvB3in/k2yr0NEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792834776;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=VwZdnRv+9bwc7qE5kV38zE5Hy3K1/gB/HzhVDeGqX9U=;
	b=Xs5LggtFTibQrytRwCSBhng3/TwPXIYw9XxyVchtjfedrxGWxSYTLy3ZSw889Fv/0YuV
	 8vYcuODVNrVM/hP5nrgnMpAS33REEkYZnlFilYMEYiR0ypZ1+3CRvmFK/KrIylcTc31b+
	 BmxzVyHNU1P4QL7PTuJy1xRlkifHnVAe9zxgeuTOrhyAWeHaV5bGo3s9gOzPKdRx+W9Tk
	 Lh2OZvM2SSQHEQRr8GSEsy+UBaHDStDq3515om7qwixqlly5lTpxj4vG5GCzhzWBQYf+o
	 g5yuKk3fdZGEAbQBJdzQCaplwcZX6pfiT3fO85u6N8RNAZO+GY83TFMBTCpkaPkjUEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=N4fRBm6g;
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD98606A31A;
	Sat, 24 Oct 2026 09:39:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FD98606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=N4fRBm6g
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=VwZdnRv+9bwc7qE5kV38zE5Hy3K1/gB/HzhVDeGqX9U=; b=N4fRBm6gGfDWEH78SM4YfDzLJm
	Xk7rjyW9rpdfhwkqc3emAL2XaeLtVMbiSYKDlQ2TgD6RVJeXdcdifYozL54RST+qnVyxZvy41cjkN
	ViRTjCYIvzjitcbYE+kzSDEOBANcgxn1cxrKjs7zW024czIYO1HFJA3Ct6WwETh04T78IZ+EaY/n5
	qiEt5aTPUaLmCuSNxMZjth5wiqgGYjagnmba4MZHLN5DgLuDACokDYII+OuQugN7bL2Vq9sRudOP0
	tvgexUE2tgUFGXglX/89AEp6f9+dJyIO/svtmARX25rB4xo2ZPmzEHeHsMLlhPiXSbHe6iM0WmmJG
	MTZ7qRjA==;
Received: from [151.115.150.205] (port=36518 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xKYDp-0000000FNZU-0SCh;
	Sat, 24 Oct 2026 11:39:27 +0200
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
Subject: [PATCH v4 2/2] ima: audit failure to supply detached data for modsig
Date: Sat, 24 Oct 2026 09:39:18 +0000
Message-ID: <20261024093918.2929374-3-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261024093918.2929374-1-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261024093918.2929374-1-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
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

ima_collect_measurement() discards a modsig when detached data cannot be
supplied, but the reason is lost.

Return the pkcs7_supply_detached_data() error from ima_collect_modsig()
and emit a separate failed-modsig audit record. Keep ordinary collection
errors on their existing audit path so both causes are reported when they
happen together.

Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 security/integrity/ima/ima.h        |  8 ++++----
 security/integrity/ima/ima_api.c    | 25 +++++++++++++++++--------
 security/integrity/ima/ima_modsig.c |  8 ++++----
 3 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 6280d7ec23326..a3670a479d095 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -559,7 +559,7 @@ static inline void __init init_ima_appraise_lsm(const struct lsm_id *lsmid)
 #ifdef CONFIG_IMA_APPRAISE_MODSIG
 int ima_read_modsig(enum ima_hooks func, const void *buf, loff_t buf_len,
 		    struct modsig **modsig);
-bool ima_collect_modsig(struct modsig *modsig, const void *buf, loff_t size);
+int ima_collect_modsig(struct modsig *modsig, const void *buf, loff_t size);
 int ima_get_modsig_digest(const struct modsig *modsig, enum hash_algo *algo,
 			  const u8 **digest, u32 *digest_size);
 int ima_get_raw_modsig(const struct modsig *modsig, const void **data,
@@ -572,10 +572,10 @@ static inline int ima_read_modsig(enum ima_hooks func, const void *buf,
 	return -EOPNOTSUPP;
 }
 
-static inline bool ima_collect_modsig(struct modsig *modsig, const void *buf,
-				      loff_t size)
+static inline int ima_collect_modsig(struct modsig *modsig, const void *buf,
+				     loff_t size)
 {
-	return false;
+	return -EOPNOTSUPP;
 }
 
 static inline int ima_get_modsig_digest(const struct modsig *modsig,
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 7859c9d1a27f5..5f6178948eb3e 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -254,7 +254,7 @@ int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
 						struct ima_digest_data, hdr);
 	struct name_snapshot filename;
 	struct kstat stat;
-	int result = 0;
+	int result = 0, modsig_result = 0;
 	int length;
 	void *tmpbuf;
 	u64 i_version = 0;
@@ -264,9 +264,12 @@ int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
 	 * the file digest without collecting the modsig in a previous
 	 * measurement rule.
 	 */
-	if (modsig && *modsig && !ima_collect_modsig(*modsig, buf, size)) {
-		ima_free_modsig(*modsig);
-		*modsig = NULL;
+	if (modsig && *modsig) {
+		modsig_result = ima_collect_modsig(*modsig, buf, size);
+		if (modsig_result) {
+			ima_free_modsig(*modsig);
+			*modsig = NULL;
+		}
 	}
 
 	if (iint->flags & IMA_COLLECTED)
@@ -326,15 +329,21 @@ int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
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
-				    audit_cause, result, 0, result);
+		if (modsig_result)
+			integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode,
+					    filename.name.name, "collect_data",
+					    "failed-modsig", modsig_result, 0,
+					    modsig_result);
+		if (result)
+			integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode,
+					    filename.name.name, "collect_data",
+					    audit_cause, result, 0, result);
 
 		release_dentry_name_snapshot(&filename);
 	}
diff --git a/security/integrity/ima/ima_modsig.c b/security/integrity/ima/ima_modsig.c
index e640a9a53508e..c5bd4770298a1 100644
--- a/security/integrity/ima/ima_modsig.c
+++ b/security/integrity/ima/ima_modsig.c
@@ -99,9 +99,9 @@ int ima_read_modsig(enum ima_hooks func, const void *buf, loff_t buf_len,
  *
  * Digest export is best-effort; not all signatures expose a single digest.
  *
- * Return: true if the file data was supplied, false otherwise.
+ * Return: 0 if the file data was supplied, error code otherwise.
  */
-bool ima_collect_modsig(struct modsig *modsig, const void *buf, loff_t size)
+int ima_collect_modsig(struct modsig *modsig, const void *buf, loff_t size)
 {
 	int rc;
 
@@ -113,13 +113,13 @@ bool ima_collect_modsig(struct modsig *modsig, const void *buf, loff_t size)
 		sizeof(struct module_signature);
 	rc = pkcs7_supply_detached_data(modsig->pkcs7_msg, buf, size);
 	if (rc)
-		return false;
+		return rc;
 
 	/* Ask the PKCS7 code to calculate the file hash. */
 	rc = pkcs7_get_digest(modsig->pkcs7_msg, &modsig->digest,
 			      &modsig->digest_size, &modsig->hash_algo);
 
-	return true;
+	return 0;
 }
 
 int ima_modsig_verify(struct key *keyring, const struct modsig *modsig)
-- 
2.47.3

