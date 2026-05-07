Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C77481AA3;
	Thu,  7 May 2026 19:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778181282; cv=none; b=irRSeeIQ72GC9/rRFTV4SSdQRVn+eKlPYj2RnID759UQ7skEuduFdur/6vRQZ/Yx963jTIOYMhWbI7tqjrTSKZuGBZMjemNuqp9iLlaK5H2DCib1/TEecfWYR/Yrcg/CIGsyGMOoCaOUgregANOlk4Ve/SvkxHjbwtAdSid8dHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778181282; c=relaxed/simple;
	bh=AzWlhO19VpuGg5nZz3+D71Jy4Fjph/CriKJF5JAlOOU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CW+hsep/0ViZAQaaqQLimcCgVkcOYMRUBGhcgsLn8spTTBYaE/lYp3pdLaECqCtlEeTxZke5zGcCI8RrXrypyYEsILlnnHkitFqO8Rh5Ue5lFIth+eINPkhk3YxKLUgxd5Y/90DPxuzkxpmIcHEW+J7hpKdcYgO1i+iA1dZ4uZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ojOxSqo9; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ojOxSqo9"
Received: from narnia.corp.microsoft.com (unknown [40.78.12.246])
	by linux.microsoft.com (Postfix) with ESMTPSA id C505420B7169;
	Thu,  7 May 2026 12:14:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C505420B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778181269;
	bh=EVhnJ7wpgbA7sp8Fr92qnAkJ63wmwYjrDe6dMMlvu1U=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ojOxSqo9ymy6EUnCgooV6JY5ajxTWgDJucgvAJ/iBl+d8yUkPz2Jf8n0ubyI2XiDU
	 wBTtefH0lPvYJt6w61Z6kPOD4poQCsqrU2Trbv3XGoTYFEGAjmSYMr7ZWGZih79OKH
	 Wtipgtnl/W2AmooHoxx41/qPjZNv8bZi2w9FCTfo=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: "Blaise Boscaccy" <bboscaccy@linux.microsoft.com>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Paul Moore" <paul@paul-moore.com>,
	"James Morris" <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	James.Bottomley@HansenPartnership.com,
	dhowells@redhat.com,
	"Fan Wu" <wufan@kernel.org>,
	"Ryan Foster" <foster.ryan.r@gmail.com>,
	"Randy Dunlap" <rdunlap@infradead.org>,
	linux-security-module@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	"Song Liu" <song@kernel.org>
Subject: [PATCH v7 03/10] crypto: pkcs7: add tests for pkcs7_get_authattr
Date: Thu,  7 May 2026 12:13:57 -0700
Message-ID: <20260507191416.2984054-4-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507191416.2984054-1-bboscaccy@linux.microsoft.com>
References: <20260507191416.2984054-1-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: James Bottomley <James.Bottomley@HansenPartnership.com>

Add example code to the test module pkcs7_key_type.c that verifies a
message and then pulls out a known authenticated attribute.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Acked-by: David Howells <dhowells@redhat.com>
---
 crypto/asymmetric_keys/pkcs7_key_type.c | 44 ++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/crypto/asymmetric_keys/pkcs7_key_type.c b/crypto/asymmetric_keys/pkcs7_key_type.c
index b930d3bbf1af5..e0b1ce0202f6d 100644
--- a/crypto/asymmetric_keys/pkcs7_key_type.c
+++ b/crypto/asymmetric_keys/pkcs7_key_type.c
@@ -12,6 +12,7 @@
 #include <linux/verification.h>
 #include <linux/key-type.h>
 #include <keys/user-type.h>
+#include <crypto/pkcs7.h>
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("PKCS#7 testing key type");
@@ -51,16 +52,57 @@ static int pkcs7_view_content(void *ctx, const void *data, size_t len,
 static int pkcs7_preparse(struct key_preparsed_payload *prep)
 {
 	enum key_being_used_for usage = pkcs7_usage;
+	int ret;
+	struct pkcs7_message *pkcs7;
+	const void *data;
+	size_t len;
 
 	if (usage >= NR__KEY_BEING_USED_FOR) {
 		pr_err("Invalid usage type %d\n", usage);
 		return -EINVAL;
 	}
 
-	return verify_pkcs7_signature(NULL, 0,
+	ret = verify_pkcs7_signature(NULL, 0,
 				      prep->data, prep->datalen,
 				      VERIFY_USE_SECONDARY_KEYRING, usage,
 				      pkcs7_view_content, prep);
+	if (ret)
+		return ret;
+
+	pkcs7 = pkcs7_parse_message(prep->data, prep->datalen);
+	if (IS_ERR(pkcs7)) {
+		pr_err("pkcs7 parse error\n");
+		return PTR_ERR(pkcs7);
+	}
+
+	/*
+	 * the parsed message has no trusted signer, so nothing should
+	 * be returned here
+	 */
+	ret = pkcs7_get_authattr(pkcs7, OID_messageDigest, &data, &len);
+	if (ret == 0) {
+		pr_err("OID returned when no trust in signer\n");
+		goto out;
+	}
+	/* add trust and check again */
+	ret = verify_pkcs7_message_sig(NULL, 0, pkcs7,
+				       VERIFY_USE_SECONDARY_KEYRING, usage,
+				       NULL, NULL);
+	if (ret) {
+		pr_err("verify_pkcs7_message_sig failed!!\n");
+		goto out;
+	}
+	/* now we should find the OID */
+	ret = pkcs7_get_authattr(pkcs7, OID_messageDigest, &data, &len);
+	if (ret) {
+		pr_err("Failed to get message digest\n");
+		goto out;
+	}
+	pr_info("Correctly Got message hash, size=%zu\n", len);
+
+ out:
+	pkcs7_free_message(pkcs7);
+	return 0;
 }
 
 /*
-- 
2.53.0

