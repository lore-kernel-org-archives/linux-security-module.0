Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F9C38837B
	for <linux-security-module@vger.kernel.org>; Wed, 15 Apr 2026 20:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776285646; cv=none; b=JsjzKJ4n+SeGs9sNFGlrWjgFRVF8TfoCmJBL872B96DG42ZHt0BgbGl5owzom/Ahe6Jqy58wVs1bsCnJbkPbTYlQpdN2DsarECGlE4vHZFAlvVx9XyoDuKrEpRLaNLvQWlbKV3CJ6SKAf3btqpumj/O+rIxpiRYbN5vqRkfk0SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776285646; c=relaxed/simple;
	bh=PL+CgPqPyNnjf7gBFemSf1QF6zWNuC2OalLgIdp7xuw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ThNpjlb27iUWNuryh6zOCwTz9P2mQL5uOAnEDCNe2bIl3oWb0G9QbuHKnamNTdCvjm7XJyOklFGwqBDIX1N5OewxC0il/0gFdZeMy+8BUH8s6huOYbWNdWlCBtdaE1i2ERmOYzqraM9XdeqtqwuBKB2hMYJA5ZaJ1l7MmiPPxWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=code406.com; spf=pass smtp.mailfrom=code406.com; dkim=pass (1024-bit key) header.d=code406.com header.i=@code406.com header.b=gp3T3WMo; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=code406.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=code406.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=code406.com header.i=@code406.com header.b="gp3T3WMo"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2b6b0500e06so13783860eec.1
        for <linux-security-module@vger.kernel.org>; Wed, 15 Apr 2026 13:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=code406.com; s=google; t=1776285643; x=1776890443; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cbsjcA0Wtc42+WgruHSL9U8A4+1Yi6KUpTr2Kkr/Yn0=;
        b=gp3T3WMoIW0+sDChfN/YAbShLGV6tvdPH9qjxI5br4JR1wonXFpSVGipiNIBcgIHRF
         oPOsYl9690KZ5lLy9Oa+lan+tsKaGFoBoZzhXQfgkgaYbsA0au0gyskdkKEJSbTobSAg
         z9z3EHxbzMCer/Vfxc2NLoap+8wyVmee+wlrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776285643; x=1776890443;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbsjcA0Wtc42+WgruHSL9U8A4+1Yi6KUpTr2Kkr/Yn0=;
        b=OV62hLZWsM2VwXbWw3+3EPuNjfq8rZ9JO/9b6Fi9wpajK0yLWHP+TCaSx81sHHCBLw
         sCWPF9gV0DKdyhgoLllmtNkSgbR2I6wCRgGzGKIlrX8tsx1soZI7BsZBIphBDdckjgfi
         fo7be8m6i3Dd6O/tOumBD+ogRrzqdHJa4MIWHrLZL65VKZWt6Atw3mzEYK68SKT1FTuj
         42BnvC3kgAYk1ec3iBAq353vL7639bgW55InVZ1SPqF+KkVyo/XAEkeuTlXZMark2LQR
         JxrZmryxq/Ao7w8cWIutnGL242x1D+My5w7BHOaB6vjS86d4pLUPGXfC+5lNIGJYPEMV
         u7yg==
X-Forwarded-Encrypted: i=1; AFNElJ+uhOumIRpnePunx3ZJRe7ZY8p02pYy9IF+9lUuF3aY+e1g0JDBhi6gKx4NMPzE//JwJSrOjLo08yuLmeu2nCYuA4jZs6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR1ebHY51Ho7nW/Y0UE7JK+ACLAJ4aPUus8iKwNBUUKXrKbjmh
	Kae3fhxRiLPh+L5tjDzjONxEs2JTZUmPDzaeNihqq/9POSpr1S3iljOsntL8rA+gtg==
X-Gm-Gg: AeBDieujrjoAZw6g7FZQ83FIEd1rzBxZQnA8ZMtf+064mobZ8epBPs+dGBaN4+ivMMO
	x7pIe8CbeNubwulYbVy9HnQzwcRtG9tQMXRsCehMmR6yB0U6S7G1fOxPgFXoVjSHBBwMjOMsXxc
	VCebKDzoG33k7S32QXUFOL8+j7ZQJRrkdi8eEZwQhlAZYt9OBc+rE4Fl0WKyTzxIwSyx/xxk8TV
	DS/HRuEjIlY9vVhF+lmt9S+Ejfy48gIHdrknhwMCsZFeogcuuZQy2WnDtzT1/2VTMtyM55rbOel
	93UKDVsBq9dgiai5yE9TZz2IxY4fThO2zPnFRUjNPbywlQq925tcbRAkXExQ/76jIEo5ZU/29Hc
	zDp9qWkKGlFmaEqXJ+YUsSOiUn9UQQZUDW+g0sOTGgvTpdX1RZHdWTmbBxOVuLMn3lgWcfwWvEV
	gSEuus06dGhEMNFncZFfTJV/yEclSknvFwIm6WmcMo5pHtvlfwGbTyOrdrNskm3hs8IBs1BLopT
	qxEcXYUFloO4sVd4rpwVo1h47ONr6w+l95Gin+r9M3d
X-Received: by 2002:a05:7022:fa04:b0:12b:ebb9:1c0b with SMTP id a92af1059eb24-12c34ef8f1cmr13538669c88.31.1776285642621;
        Wed, 15 Apr 2026 13:40:42 -0700 (PDT)
Received: from localhost ([2601:645:8a00:6e44:a6e4:945f:db92:a0c3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8c606222sm5403860eec.8.2026.04.15.13.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 13:40:42 -0700 (PDT)
From: Josh Snyder <josh@code406.com>
Date: Wed, 15 Apr 2026 13:40:40 -0700
Subject: [PATCH v2] trusted-keys: move pr_fmt out of trusted-type.h
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-trusted-key-header-v2-1-5244f9ef0d09@code406.com>
X-B4-Tracking: v=1; b=H4sIAMf332kC/32NQQ6CMBBFr0Jm7Zi2GTS48h6GRekMUo3UtIVIC
 HcXcO/yJe+/P0OS6CXBpZghyuiTD/0K5lCA62x/F/S8MhhlToq0xhyHlIXxKRN2Ylki2pLIUqu
 pYgPr8B2l9Z89eqt/nIbmIS5vpc3ofMohTvvrqDfv78GoUSOpszOOq5K4ubrAQup0dOEF9bIsX
 2Pd7C7IAAAA
X-Change-ID: 20260411-trusted-key-header-a544a4f149d2
To: James Bottomley <James.Bottomley@HansenPartnership.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, 
 David Howells <dhowells@redhat.com>, Ahmad Fatoum <a.fatoum@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, David Gstir <david@sigma-star.at>, 
 sigma star Kernel Team <upstream+dcp@sigma-star.at>, 
 Srish Srinivasan <ssrish@linux.ibm.com>, Nayna Jain <nayna@linux.ibm.com>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
 Josh Snyder <josh@code406.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776285641; l=4657;
 i=josh@code406.com; s=20260402; h=from:subject:message-id;
 bh=PL+CgPqPyNnjf7gBFemSf1QF6zWNuC2OalLgIdp7xuw=;
 b=6UB4xFpTx/1kQsSZ4hXcjkipxPZWe750cz4gLWaMxo1QghaHejOqrj6z1FeMcxvqCjoV8jdM1
 DVFq/0lBw+HC+C78H9vJXgAR49Hdf27J9eWM2z2/kiJVEQBgrTcJXKV
X-Developer-Key: i=josh@code406.com; a=ed25519;
 pk=J60jemVD5rPt9HnGvw/AAQ6RPciMTW8aAgWykCCnCXg=

Defining pr_fmt in a widely-included header leaks the "trusted_key: "
prefix into every translation unit that transitively includes
<keys/trusted-type.h>. dm-crypt, for example, ends up printing

    trusted_key: device-mapper: crypt: dm-10: INTEGRITY AEAD ERROR ...

dm-crypt began including <keys/trusted-type.h> in commit 363880c4eb36
("dm crypt: support using trusted keys"), which predates the pr_fmt
addition, so the regression has been live from the moment the header
gained its own pr_fmt definition.

Move the pr_fmt definition into the trusted-keys source files that
actually want the prefix, with specific prefixes for each key type.

Fixes: 5d0682be3189 ("KEYS: trusted: Add generic trusted keys framework")
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Josh Snyder <josh@code406.com>
---
Changes in v2:
- specific pr_fmt based on trusted key type
---
 include/keys/trusted-type.h               | 6 ------
 security/keys/trusted-keys/trusted_caam.c | 2 ++
 security/keys/trusted-keys/trusted_core.c | 2 ++
 security/keys/trusted-keys/trusted_dcp.c  | 2 ++
 security/keys/trusted-keys/trusted_pkwm.c | 2 ++
 security/keys/trusted-keys/trusted_tpm1.c | 2 ++
 security/keys/trusted-keys/trusted_tpm2.c | 2 ++
 7 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/keys/trusted-type.h b/include/keys/trusted-type.h
index 03527162613f7..54da1f174aeab 100644
--- a/include/keys/trusted-type.h
+++ b/include/keys/trusted-type.h
@@ -11,12 +11,6 @@
 #include <linux/rcupdate.h>
 #include <linux/tpm.h>
 
-#ifdef pr_fmt
-#undef pr_fmt
-#endif
-
-#define pr_fmt(fmt) "trusted_key: " fmt
-
 #define MIN_KEY_SIZE			32
 #define MAX_KEY_SIZE			128
 #if IS_ENABLED(CONFIG_TRUSTED_KEYS_PKWM)
diff --git a/security/keys/trusted-keys/trusted_caam.c b/security/keys/trusted-keys/trusted_caam.c
index 601943ce0d60f..71c173bb2f727 100644
--- a/security/keys/trusted-keys/trusted_caam.c
+++ b/security/keys/trusted-keys/trusted_caam.c
@@ -4,6 +4,8 @@
  * Copyright 2025 NXP
  */
 
+#define pr_fmt(fmt) "trusted_key: caam: " fmt
+
 #include <keys/trusted_caam.h>
 #include <keys/trusted-type.h>
 #include <linux/build_bug.h>
diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
index 0b142d941cd2e..159af9dcfc774 100644
--- a/security/keys/trusted-keys/trusted_core.c
+++ b/security/keys/trusted-keys/trusted_core.c
@@ -6,6 +6,8 @@
  * See Documentation/security/keys/trusted-encrypted.rst
  */
 
+#define pr_fmt(fmt) "trusted_key: " fmt
+
 #include <keys/user-type.h>
 #include <keys/trusted-type.h>
 #include <keys/trusted_tee.h>
diff --git a/security/keys/trusted-keys/trusted_dcp.c b/security/keys/trusted-keys/trusted_dcp.c
index 7b6eb655df0cb..41a23e2f30891 100644
--- a/security/keys/trusted-keys/trusted_dcp.c
+++ b/security/keys/trusted-keys/trusted_dcp.c
@@ -3,6 +3,8 @@
  * Copyright (C) 2021 sigma star gmbh
  */
 
+#define pr_fmt(fmt) "trusted_key: dcp: " fmt
+
 #include <crypto/aead.h>
 #include <crypto/aes.h>
 #include <crypto/algapi.h>
diff --git a/security/keys/trusted-keys/trusted_pkwm.c b/security/keys/trusted-keys/trusted_pkwm.c
index bf42c6679245a..108db105b639f 100644
--- a/security/keys/trusted-keys/trusted_pkwm.c
+++ b/security/keys/trusted-keys/trusted_pkwm.c
@@ -3,6 +3,8 @@
  * Copyright (C) 2025 IBM Corporation, Srish Srinivasan <ssrish@linux.ibm.com>
  */
 
+#define pr_fmt(fmt) "trusted_key: pwkm: " fmt
+
 #include <keys/trusted_pkwm.h>
 #include <keys/trusted-type.h>
 #include <linux/build_bug.h>
diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index 6ea728f1eae6f..207be849796ed 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -6,6 +6,8 @@
  * See Documentation/security/keys/trusted-encrypted.rst
  */
 
+#define pr_fmt(fmt) "trusted_key: tpm1: " fmt
+
 #include <crypto/hash_info.h>
 #include <crypto/sha1.h>
 #include <crypto/utils.h>
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 6340823f8b53c..2a540b1af0b33 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -4,6 +4,8 @@
  * Copyright (C) 2014 Intel Corporation
  */
 
+#define pr_fmt(fmt) "trusted_key: tpm2: " fmt
+
 #include <linux/asn1_encoder.h>
 #include <linux/oid_registry.h>
 #include <linux/string.h>

---
base-commit: 66672af7a095d89f082c5327f3b15bc2f93d558e
change-id: 20260411-trusted-key-header-a544a4f149d2

Best regards,
--  
Josh

