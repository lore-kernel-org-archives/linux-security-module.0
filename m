Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B725843DA3E;
	Fri, 27 Feb 2026 23:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772235591; cv=none; b=i4GAbowHk22GpQRhYsSpgfzcX5d7/lJ5K3JSI1hdJijpCj/0KvaDEA0X633oIIZUSXoOLlEH86xuv9btursgNTs1ECvp+ekz/z6MnRHn8z+Jai6Ta7S7WK8tPPg2d1bDi7+QKTFRPXjp9HWDoLBksS/6dJKyiSOvYREJpot96iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772235591; c=relaxed/simple;
	bh=efWQ3uwQ9TRgjJI5J0dzhCvyJQL1oXnhm6feNoZ+vhY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ka2tRozAuQiY62rMxPdw1Vj1yAdDQ+lX/BehUp2c6QHOhAtzorlVP39beg4HAr8pKl1uSKAKK4vNInlttXuPmLwkWt5oATTYasbRen9MNKQVf7mrT0aAi+CwpikQNuGHHya0BHAHqJ3gRE3ik1ESVUKCeS8/iIccL6F99AcNsv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VCj9Gs34; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VCj9Gs34"
Received: from narnia.corp.microsoft.com (unknown [40.86.183.173])
	by linux.microsoft.com (Postfix) with ESMTPSA id E383A20B6F04;
	Fri, 27 Feb 2026 15:39:46 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E383A20B6F04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1772235588;
	bh=Vcnjy1FVFqEfr+gPqq1dmSGVbAmjZA9nCoYY+v0aeg0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=VCj9Gs34T0bB7bJtJ23NdA7nq7gG0imNSRd+XsI4mqLoGo/ufJjThxibOZFwHrAwf
	 cBcIClNN+Goc7DFd6VksExyzjgPl4hpQiXZ2Bb1dSXYBaLk5EfgyeAGWzau4IsZnnF
	 yMZsO0EhMU6Pi0UPb3s0YOLxTGTyGnNhHmdkKu+Y=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	James.Bottomley@HansenPartnership.com,
	dhowells@redhat.com,
	Fan Wu <wufan@kernel.org>,
	Ryan Foster <foster.ryan.r@gmail.com>,
	linux-security-module@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v2 03/10] crypto: pkcs7: allow pkcs7_digest() to be called from pkcs7_trust
Date: Fri, 27 Feb 2026 15:38:32 -0800
Message-ID: <20260227233930.2418522-4-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260227233930.2418522-1-bboscaccy@linux.microsoft.com>
References: <20260227233930.2418522-1-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: James Bottomley <James.Bottomley@HansenPartnership.com>

Trying to run pkcs7_validate_trust() on something that parsed
correctly but is not verified doesn't work because the signature
digest hasn't been calculated.  Fix this by adding a digest calclation
in to pkcs7_validate_one().  This is almost a nop if the digest exists.

Additionally, the trust validation doesn't know the data payload, so
adjust the digest calculator to skip checking the data digest if
pkcs7->data is NULL.  A check is added in pkcs7_verify() for
pkcs7->data being null (returning -EBADMSG) to guard against someone
forgetting to supply data and getting an invalid success return.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 crypto/asymmetric_keys/pkcs7_parser.h |  3 +++
 crypto/asymmetric_keys/pkcs7_trust.c  |  8 ++++++++
 crypto/asymmetric_keys/pkcs7_verify.c | 13 +++++++++----
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/crypto/asymmetric_keys/pkcs7_parser.h b/crypto/asymmetric_keys/pkcs7_parser.h
index 203062a33def..cbe823aeac06 100644
--- a/crypto/asymmetric_keys/pkcs7_parser.h
+++ b/crypto/asymmetric_keys/pkcs7_parser.h
@@ -66,3 +66,6 @@ struct pkcs7_message {
 	size_t		data_hdrlen;	/* Length of Data ASN.1 header */
 	const void	*data;		/* Content Data (or 0) */
 };
+
+int pkcs7_digest(struct pkcs7_message *pkcs7,
+		 struct pkcs7_signed_info *sinfo);
diff --git a/crypto/asymmetric_keys/pkcs7_trust.c b/crypto/asymmetric_keys/pkcs7_trust.c
index 78ebfb6373b6..7cb0a6bc7b32 100644
--- a/crypto/asymmetric_keys/pkcs7_trust.c
+++ b/crypto/asymmetric_keys/pkcs7_trust.c
@@ -30,6 +30,14 @@ static int pkcs7_validate_trust_one(struct pkcs7_message *pkcs7,
 
 	kenter(",%u,", sinfo->index);
 
+	/*
+	 * if we're being called immediately after parse, the
+	 * signature won't have a calculated digest yet, so calculate
+	 * one.  This function returns immediately if a digest has
+	 * already been calculated
+	 */
+	pkcs7_digest(pkcs7, sinfo);
+
 	if (sinfo->unsupported_crypto) {
 		kleave(" = -ENOPKG [cached]");
 		return -ENOPKG;
diff --git a/crypto/asymmetric_keys/pkcs7_verify.c b/crypto/asymmetric_keys/pkcs7_verify.c
index 474e2c1ae21b..3080f0ec52e0 100644
--- a/crypto/asymmetric_keys/pkcs7_verify.c
+++ b/crypto/asymmetric_keys/pkcs7_verify.c
@@ -19,8 +19,8 @@
 /*
  * Digest the relevant parts of the PKCS#7 data
  */
-static int pkcs7_digest(struct pkcs7_message *pkcs7,
-			struct pkcs7_signed_info *sinfo)
+int pkcs7_digest(struct pkcs7_message *pkcs7,
+		 struct pkcs7_signed_info *sinfo)
 {
 	struct public_key_signature *sig = sinfo->sig;
 	struct crypto_shash *tfm;
@@ -93,8 +93,8 @@ static int pkcs7_digest(struct pkcs7_message *pkcs7,
 			goto error;
 		}
 
-		if (memcmp(sig->m, sinfo->msgdigest,
-			   sinfo->msgdigest_len) != 0) {
+		if (pkcs7->data && memcmp(sig->m, sinfo->msgdigest,
+					  sinfo->msgdigest_len) != 0) {
 			pr_warn("Sig %u: Message digest doesn't match\n",
 				sinfo->index);
 			ret = -EKEYREJECTED;
@@ -463,6 +463,11 @@ int pkcs7_verify(struct pkcs7_message *pkcs7,
 		return -EINVAL;
 	}
 
+	if (!pkcs7->data) {
+		pr_warn("Data not supplied to verify operation\n");
+		return -EBADMSG;
+	}
+
 	for (sinfo = pkcs7->signed_infos; sinfo; sinfo = sinfo->next) {
 		ret = pkcs7_verify_one(pkcs7, sinfo);
 		if (sinfo->blacklisted) {
-- 
2.52.0

