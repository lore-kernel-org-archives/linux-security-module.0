Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775772F363E
	for <linux-security-module@vger.kernel.org>; Sat, 11 Apr 2026 20:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775938339; cv=none; b=QFp/iI66jMzb5T/i91hbIgLzsIlhIuSYIeEuJBBVids5t77xNepl4+EQxb4DdvLOB3iSYzeit3ItB2uVldAKrKmSxXIofXnC8hBlk3dbznDxuXf80bkRhPtjWQhM7qYO/sOqLvy4u0iWer6dREutbRlialBF0X5ne3b7z5xDiMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775938339; c=relaxed/simple;
	bh=0zKbvspdxhnZRPxYXPH+dPdWs7eab1kfHTzyuRZUC6w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=W1BiqgClTPIhTMcBlGhoJpFxRmCvevg3gRF2JM7pAhbJz1SENgx6qcy2ovWE5M1c2gysrlPmgSYz0zJZfk0MNg6yDfK/gNAAU3t/4Ei3d1taFtPq8MltV2XCfCi4QiQ8Pf3A28iZ/johpiAV8HewQqRmnqmBc5ThT9vrZKgSHao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=code406.com; spf=pass smtp.mailfrom=code406.com; dkim=pass (1024-bit key) header.d=code406.com header.i=@code406.com header.b=LEqfPkgC; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=code406.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=code406.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=code406.com header.i=@code406.com header.b="LEqfPkgC"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2d64c756111so2358610eec.1
        for <linux-security-module@vger.kernel.org>; Sat, 11 Apr 2026 13:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=code406.com; s=google; t=1775938338; x=1776543138; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DTeoisoiiauq+nU3eIYTKPhuzuwv2vdodHFeSvzRcgI=;
        b=LEqfPkgCtQRfGEXQcFuBMZivIMvEF8HdZn8xmJZtm1e1W9xCDcrQBZ8lfDyaiQhgqP
         ileunZNC08wqYXONZgEZORyHZ5CeVAIEpWcUqm70VfkYajsAp6MlV6C55II4hMJv3jJE
         WwW0rOhPDJ3kgvhwpjNvsY+5oOA2B2PBK8gPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775938338; x=1776543138;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTeoisoiiauq+nU3eIYTKPhuzuwv2vdodHFeSvzRcgI=;
        b=KH1HPeEv3T/Djkzn0TZaf1znMMNCzp03WCBhiCDFboID2eupVWNhjskpbR9t5g7k7y
         3WdzH7XoPxB0XaIVanmHUxD5shpSSc105owychMS6jMmzom7d1eKIOezkIaXK920UWlt
         rCczjQq4rRN7BtvqZewcSEemWo6QdFQm1A0pfl0WuaDLj9y35HMm9/Q5AslLjrPFmcvb
         UbhdtZsuttfHlhLs4RKKs5m7Pvymk/yNXORcQVkhWsz94zaiimHoPOwmkcyFVLM6F0o7
         yXaeT2MyoROYCjjIxKRc5bewS4wgeP5PAFd+iykuLes+IwrUjDK5oAoY4Ph49GtZZpJ7
         CV3w==
X-Forwarded-Encrypted: i=1; AFNElJ876e7uh9mzM2j55KNkYO1k5Zv+j10x9vVwL73PfL5ZCdm4dJQN+Xb0X4Ajss0XZ29dMr+hVj6NfJbbFMMA93lW/Z4vj8U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywoq1QYNtNpcUw39QpQpC2D7aPflCResvsT+iI936ZW8jQEeb4I
	SbT1tpTYy7YJQABIJQdFaNIzoo3fjH2iPOVT/M2jj6X29+ZhHJ7GAnfUsByEDUSe5Q==
X-Gm-Gg: AeBDiesi3/jx16ZO5vNxWjxhqlESwbx4clK9zFKNRsblm9ZfyrJuOrpljca7l9EhLpX
	pDOZ9d5rN0TB17WMFZe9NgTA5991tPFOQ4azXt78qpZyTeQQMCb7Rp6D5ZHtF0bx6NoUN/Fs1+9
	0oWqAByY2PaumnXPmdANE26hVtnMgen7LAQ8K3Hau9+l/Glxcybu44jmee9rDEK0gUdiy444BkK
	4ypRam6MJGDBB0joZjGJ/qa/8BJrvRyZQ7cM+Kb6PPN6a4Ohr6EZWRPvmda575rtKFeWd6bxqTH
	eVoMMeg9YU5TGdTtE+tAUkKBUB7KZcqRNrRqhTlmo36dNn5hQnPAtDQ3haFdy6DU6Kneh13hJns
	+lMTspvpssKU7r9GWC9xW8OqU5IrD1YDTuF4IzdjSwLiBXa9XKhgWOBp9LDwIyh9e0kn1J229p4
	ufO5XLd/FVRI3FnJvE5Xv4jHeGeKNUpMN2BWWkVtsgVNTeZn+uWx/M23dStp2pFAU+M8jxN4IZl
	LODA44F4rhH2AX5JCaBcXveanZpU6udHg==
X-Received: by 2002:a05:7301:1e91:b0:2c8:7172:3b7b with SMTP id 5a478bee46e88-2d5881ace9amr5276521eec.18.1775938337531;
        Sat, 11 Apr 2026 13:12:17 -0700 (PDT)
Received: from localhost ([2601:645:8a00:6e44:21b5:a2d0:e6aa:2a9a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d80b1ab811sm981968eec.17.2026.04.11.13.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 13:12:17 -0700 (PDT)
From: Josh Snyder <josh@code406.com>
Date: Sat, 11 Apr 2026 13:12:07 -0700
Subject: [PATCH] trusted-keys: move pr_fmt out of trusted-type.h
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260411-trusted-key-header-v1-1-407c2cd954db@code406.com>
X-B4-Tracking: v=1; b=H4sIABar2mkC/yXMQQrCQAxG4auUrA10hijoVcTF2Plro1AlmUpL6
 d0ddfkt3lvJYQqnU7OS4a2uz7Ei7BrqhjTewJqrKbbx0EoIXGzygswPLDwgZRinvUiSPsgxR6r
 hy9Dr/JueL3/7dL2jK98TbdsHR5oq33YAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775938336; l=4520;
 i=josh@code406.com; s=20260402; h=from:subject:message-id;
 bh=0zKbvspdxhnZRPxYXPH+dPdWs7eab1kfHTzyuRZUC6w=;
 b=8ME3VvZlnGV3qfIXrxUIyhjayTPM52XaGbk0ulcHhGoB+hs5C4gmQaQPldN9RNU+sp9dyjEGl
 xaR52USeUkuB8Vacb0TweRQMH/Eh4Q1e7IlZ7a23TjsEQV7UTgWXbLZ
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
actually want the prefix.

Fixes: 5d0682be3189 ("KEYS: trusted: Add generic trusted keys framework")
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Josh Snyder <josh@code406.com>
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
index 601943ce0d60f..a31fd89c0e5c5 100644
--- a/security/keys/trusted-keys/trusted_caam.c
+++ b/security/keys/trusted-keys/trusted_caam.c
@@ -4,6 +4,8 @@
  * Copyright 2025 NXP
  */
 
+#define pr_fmt(fmt) "trusted_key: " fmt
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
index 7b6eb655df0cb..f15ec400848ce 100644
--- a/security/keys/trusted-keys/trusted_dcp.c
+++ b/security/keys/trusted-keys/trusted_dcp.c
@@ -3,6 +3,8 @@
  * Copyright (C) 2021 sigma star gmbh
  */
 
+#define pr_fmt(fmt) "trusted_key: " fmt
+
 #include <crypto/aead.h>
 #include <crypto/aes.h>
 #include <crypto/algapi.h>
diff --git a/security/keys/trusted-keys/trusted_pkwm.c b/security/keys/trusted-keys/trusted_pkwm.c
index bf42c6679245a..94c92b90d88da 100644
--- a/security/keys/trusted-keys/trusted_pkwm.c
+++ b/security/keys/trusted-keys/trusted_pkwm.c
@@ -3,6 +3,8 @@
  * Copyright (C) 2025 IBM Corporation, Srish Srinivasan <ssrish@linux.ibm.com>
  */
 
+#define pr_fmt(fmt) "trusted_key: " fmt
+
 #include <keys/trusted_pkwm.h>
 #include <keys/trusted-type.h>
 #include <linux/build_bug.h>
diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index 6ea728f1eae6f..69dac20e4bf23 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -6,6 +6,8 @@
  * See Documentation/security/keys/trusted-encrypted.rst
  */
 
+#define pr_fmt(fmt) "trusted_key: " fmt
+
 #include <crypto/hash_info.h>
 #include <crypto/sha1.h>
 #include <crypto/utils.h>
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 6340823f8b53c..f47ae952a0e7c 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -4,6 +4,8 @@
  * Copyright (C) 2014 Intel Corporation
  */
 
+#define pr_fmt(fmt) "trusted_key: " fmt
+
 #include <linux/asn1_encoder.h>
 #include <linux/oid_registry.h>
 #include <linux/string.h>

---
base-commit: cc13002a9f984d37906e9476f3e532a8cdd126f5
change-id: 20260411-trusted-key-header-a544a4f149d2

Best regards,
--  
Josh

