Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD19B47ECCC;
	Thu,  7 May 2026 19:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778181280; cv=none; b=mMKsSk+n+PwjnRd4ePB1biuv+h2YNVbsLrGvIHuRVZ1oIKOrKxEVQVAbGmtqNR4zbvWNf1sSxANHYVsfZvyBNrqJ/rkGBr7/MzdnrT59V+KM+ThIdFFGBAhhMX4VB87BkKKqAyWHTJo15a/VZaXlCP8zFPnUB6SmSUpWE5mzYyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778181280; c=relaxed/simple;
	bh=fYARcDBmPPcHO7t07Sr6HPEeL+UytBm9Oitq4eLFb94=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l0OpfATVbKt7ZQGnRVtLPwPuzi2UlKI98b3440vE3wPxLVWuPnDWsaGi9HI04j3L6Ryn5VK+L7w/hsnXd31Jc4IeTtK6s8Cwecrty+OsNKgf7pSyf8iMgUeFpX5k+jrDkDHNspL8uea0R80u+geDJXr0WgifFF8B4/rjRZoJvII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GfgmBchx; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GfgmBchx"
Received: from narnia.corp.microsoft.com (unknown [40.78.12.246])
	by linux.microsoft.com (Postfix) with ESMTPSA id AC4A720B7167;
	Thu,  7 May 2026 12:14:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AC4A720B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778181264;
	bh=TdoGL/WFRJu1LL991oi0llbx4SxP9bDplmkY7d0i3/c=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=GfgmBchxOZyuNw97yxdf+nROJ82h4Py2+McDKOeR7INQIQaKKeM46ojjCx8l9vWvR
	 HBjgzL5MMKi6at6XxRCFRcjI4ufFx5bLi8wWoBAtVUpQ4Zn8L8ghljcI6gMlH9nkbs
	 SEvu256ixMeTWl8Dw7Q6gWUfuiiGS48eTdaMNxWo=
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
Subject: [PATCH v7 01/10] crypto: pkcs7: add flag for validated trust on a signed info block
Date: Thu,  7 May 2026 12:13:55 -0700
Message-ID: <20260507191416.2984054-2-bboscaccy@linux.microsoft.com>
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

Allow consumers of struct pkcs7_message to tell if any of the sinfo
fields has passed a trust validation.  Note that this does not happen
in parsing, pkcs7_validate_trust() must be explicitly called or called
via validate_pkcs7_trust().  Since the way to get this trusted pkcs7
object is via verify_pkcs7_message_sig, export that so modules can use
it.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
---
 certs/system_keyring.c                | 1 +
 crypto/asymmetric_keys/pkcs7_parser.h | 1 +
 crypto/asymmetric_keys/pkcs7_trust.c  | 1 +
 3 files changed, 3 insertions(+)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index e0761436ec7f4..9bda49295bd02 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -380,6 +380,7 @@ int verify_pkcs7_message_sig(const void *data, size_t len,
 	pr_devel("<==%s() = %d\n", __func__, ret);
 	return ret;
 }
+EXPORT_SYMBOL(verify_pkcs7_message_sig);
 
 /**
  * verify_pkcs7_signature - Verify a PKCS#7-based signature on system data.
diff --git a/crypto/asymmetric_keys/pkcs7_parser.h b/crypto/asymmetric_keys/pkcs7_parser.h
index 6ef9f335bb17f..203062a33def6 100644
--- a/crypto/asymmetric_keys/pkcs7_parser.h
+++ b/crypto/asymmetric_keys/pkcs7_parser.h
@@ -20,6 +20,7 @@ struct pkcs7_signed_info {
 	unsigned	index;
 	bool		unsupported_crypto;	/* T if not usable due to missing crypto */
 	bool		blacklisted;
+	bool		verified; /* T if this signer has validated trust */
 
 	/* Message digest - the digest of the Content Data (or NULL) */
 	const void	*msgdigest;
diff --git a/crypto/asymmetric_keys/pkcs7_trust.c b/crypto/asymmetric_keys/pkcs7_trust.c
index 9a87c34ed1733..78ebfb6373b61 100644
--- a/crypto/asymmetric_keys/pkcs7_trust.c
+++ b/crypto/asymmetric_keys/pkcs7_trust.c
@@ -127,6 +127,7 @@ static int pkcs7_validate_trust_one(struct pkcs7_message *pkcs7,
 		for (p = sinfo->signer; p != x509; p = p->signer)
 			p->verified = true;
 	}
+	sinfo->verified = true;
 	kleave(" = 0");
 	return 0;
 }
-- 
2.53.0

