Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6892B47B413;
	Fri, 27 Feb 2026 23:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772235606; cv=none; b=eLUJT5QVDuIYDVjT3hc6SPwo6hcv7+tVqQdIB857YjkU+H+rUGNZtb6THCN+hmR/o2K+K0ZbQ3rSZxAS0kNAxoYQbDHk6+JODOOQMNTenukaykeTvp7Cy0X0rbpB3/AY1kl3tbtreKnvAvy8TD5jW/iJD83DWJOv0NkuAkuJOwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772235606; c=relaxed/simple;
	bh=+BMgEghhmLZxyhLWMqAslCSi/KRH4Z8wRyogS3JwoRM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qo3+ST0h5OhDExyOiHc4rkonJtHZLgXHKth1Vg6bPV/EHudnpjrT9xd8FOWzVtHyu/YsDuQRIdxuPgaziIRdq1LA/u6yV5DoSSbkugNqzRdzXee6AUKrX6aNXQI7AfG6EtVWx1J/mBzhrhAm1SuRI/S2g44QN04M+b/4b0jKNTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=UnFjPttG; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UnFjPttG"
Received: from narnia.corp.microsoft.com (unknown [40.86.183.173])
	by linux.microsoft.com (Postfix) with ESMTPSA id D67B120B6F0A;
	Fri, 27 Feb 2026 15:39:50 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D67B120B6F0A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1772235592;
	bh=0VAiPXkzm4mcht4Y8ZrJotec/9MpVCGRTSLZj5v0JqM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=UnFjPttGZSFkM2vznJwpqMs2G5osq6+ZdFSQYnMt2KFF3M/pB/9E9GsyvlifDz+xE
	 SFordTsfcl50nD3oZa0emc+CDSw1Lk0RmPLnQvfm3mixMIlySFfP9BhCrSAB0SFWK2
	 Y+cGk/6O5bTx2zZiF2Tr+aiOueeCvt0oDfUVZoMA=
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
Subject: [PATCH v2 05/10] crypto: pkcs7: add tests for pkcs7_get_authattr
Date: Fri, 27 Feb 2026 15:38:34 -0800
Message-ID: <20260227233930.2418522-6-bboscaccy@linux.microsoft.com>
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

Add example code to the test module pkcs7_key_type.c that verifies a
message and then pulls out a known authenticated attribute.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Acked-by: David Howells <dhowells@redhat.com>
---
 crypto/asymmetric_keys/pkcs7_key_type.c | 42 ++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/crypto/asymmetric_keys/pkcs7_key_type.c b/crypto/asymmetric_keys/pkcs7_key_type.c
index b930d3bbf1af..5a1ecb5501b2 100644
--- a/crypto/asymmetric_keys/pkcs7_key_type.c
+++ b/crypto/asymmetric_keys/pkcs7_key_type.c
@@ -12,6 +12,7 @@
 #include <linux/verification.h>
 #include <linux/key-type.h>
 #include <keys/user-type.h>
+#include <crypto/pkcs7.h>
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("PKCS#7 testing key type");
@@ -51,16 +52,55 @@ static int pkcs7_view_content(void *ctx, const void *data, size_t len,
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
+	ret = validate_pkcs7_trust(pkcs7, VERIFY_USE_SECONDARY_KEYRING);
+	if (ret) {
+		pr_err("validate_pkcs7_trust failed!!\n");
+		goto out;
+	}
+	/* now we should find the OID */
+	ret = pkcs7_get_authattr(pkcs7, OID_messageDigest, &data, &len);
+	if (ret) {
+		pr_err("Failed to get message digest\n");
+		goto out;
+	}
+	pr_info("Correctly Got message hash, size=%ld\n", len);
+
+ out:
+	pkcs7_free_message(pkcs7);
+	return 0;
 }
 
 /*
-- 
2.52.0

