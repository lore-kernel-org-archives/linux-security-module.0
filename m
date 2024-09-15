Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E83D198A03
	for <linux-security-module@vger.kernel.org>; Sun, 15 Sep 2024 09:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726391490; cv=none; b=Ywr8udDC+qraXyF2mED4DEDFoSJNZfs0+w9PGVqxNvWtRr789GX4az0zv45KoUGy1j/paFhhF3jDjTRuiOlkVmDyorZCv74z3UU2jY8mYI6buQUl39opCtKloETGEWPDWL9RGDmCFNIjbBvhmC+JSKsjlgTlHJJfOdLPhsg4Urc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726391490; c=relaxed/simple;
	bh=7MzWydgr8FUMwwcX/KIqLYo19bvtVD6wWq7YCvM3ZOs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tKdhzbgUtr+djqgbP6/Rv0a42PO3fUWrjYovgXwK+0EGabasL4OgOQamFo+/8tTLYQmWq1v0HWIp0YeP2ok2muNbdFqoPIgI0sxJbsA7Ccy2Vsp8N4GDDzNUCc9OMoKNl/W9tow8EDs6mWJDI+7qlOkShtl41DBMOCMuYG/limw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZU9Yfim; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZU9Yfim"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8a7596b7dfso512267766b.0
        for <linux-security-module@vger.kernel.org>; Sun, 15 Sep 2024 02:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726391486; x=1726996286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T53DfKpIULc696V+zFqyiFp1LKkmBasfhff9ZWRR4Yk=;
        b=HZU9YfimB/Z0X1K4Hg7vjpsEEJwOowbYutTdMU0nVPHZVF3YR2kTR0gwjY9NW4Dc5m
         N1L7o5WVbSdjnf5Kf/0BL/sfcNm53adeE2GrW5PZfvkWuDN08WjEloS6C5RbyDlZTN1d
         YWW6aHm7WZjB9rpfYGQxnLbyMXtGmCof7PDPjhCodRIBagIa3SA0AJLfFY3zNRZtM5HI
         q34F3vZTT5rRSZLZNdokQdNIKjJzil/zfvikbbrJDZtbTQHclIVLc8/8/KiYW/p2eRPT
         BJ1AWxgJ9iWVFVhbweOJbxPoKgmDIN7qqCxHtJdylCFSuGwk9oe1idFlxnHs5uRatcTb
         W3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726391486; x=1726996286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T53DfKpIULc696V+zFqyiFp1LKkmBasfhff9ZWRR4Yk=;
        b=p8VPfl4wDXAiE6ZMnNjGE3uox0IUekGpHx28slKvKt8HhPe2by70Darq5TAzLSk1yp
         bdUfgBEqNURaRfxBApjSU/rd1sCpufdRdr+Kgz2j6LwzCaq/uBbSBEOE3py2OMEm5Tof
         ZLOcyEod/oulh+M2xdNjuJOLv1UEx+W8EuuNQY8Cl9CTKf2cVi03Sql5XmsG/wKHV/jm
         bVlDkdTXR/jwje9P/6cCdk2JdXnbka+aiUo2nb6s/KOBPfUikC9rphzxc8xLzlKRs2P5
         TobiR7yUiaQ8gEMqGmm43s7ZkNErZLZVZOC9X1cZnppNRt9yN306sCQZ0GbwHM5o5wuL
         0JPw==
X-Gm-Message-State: AOJu0Yx0B+E474Rr1ZwWwjxhwf1I1ZZP88jaQFUR2s2uQ3B6lWq0Z2iZ
	6n+atl4pzgsPZUUv65WCodAtU1ragyOjU8sb1RaDNhyoDuYRcHZ2PVDcgROb
X-Google-Smtp-Source: AGHT+IEOC3S993QR/dt+xihab3lEW6d9+/98IWZ8BHnRsCC92InK7CJI8ZRIUxyW7rPvtqt75zeJmA==
X-Received: by 2002:a17:907:6d24:b0:a86:91a5:4d09 with SMTP id a640c23a62f3a-a902a8bc129mr1319092666b.26.1726391485762;
        Sun, 15 Sep 2024 02:11:25 -0700 (PDT)
Received: from localhost ([2001:871:213:da56:8414:8296:c4db:f217])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612df5afsm173530466b.162.2024.09.15.02.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 02:11:24 -0700 (PDT)
From: luca.boccassi@gmail.com
To: linux-security-module@vger.kernel.org
Cc: wufan@linux.microsoft.com,
	paul@paul-moore.com
Subject: [PATCH v2] ipe: allow secondary and platform keyrings to install/update policies
Date: Sun, 15 Sep 2024 11:11:19 +0200
Message-Id: <20240915091119.1916049-1-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240913234840.1318655-1-luca.boccassi@gmail.com>
References: <20240913234840.1318655-1-luca.boccassi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luca Boccassi <bluca@debian.org>

The current policy management makes it impossible to use IPE
in a general purpose distribution. In such cases the users are not
building the kernel, the distribution is, and access to the private
key included in the trusted keyring is, for obvious reason, not
available.
This means that users have no way to enable IPE, since there will
be no built-in generic policy, and no access to the key to sign
updates validated by the trusted keyring.

Just as we do for dm-verity, kernel modules and more, allow the
secondary and platform keyrings to also validate policies. This
allows users enrolling their own keys in UEFI db or MOK to also
sign policies, and enroll them. This makes it sensible to enable
IPE in general purpose distributions, as it becomes usable by
any user wishing to do so. Keys in these keyrings can already
load kernels and kernel modules, so there is no security
downgrade.

Add a kconfig each, like dm-verity does, but default to enabled if
the dependencies are available.

Signed-off-by: Luca Boccassi <bluca@debian.org>
---
v2: add Kconfig entries following the dm-verity model
    update documentation

 Documentation/admin-guide/LSM/ipe.rst |  5 ++++-
 security/ipe/Kconfig                  | 19 +++++++++++++++++++
 security/ipe/policy.c                 | 14 +++++++++++++-
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/LSM/ipe.rst b/Documentation/admin-guide/LSM/ipe.rst
index f38e641df0e9..47323494d119 100644
--- a/Documentation/admin-guide/LSM/ipe.rst
+++ b/Documentation/admin-guide/LSM/ipe.rst
@@ -223,7 +223,10 @@ are signed through the PKCS#7 message format to enforce some level of
 authorization of the policies (prohibiting an attacker from gaining
 unconstrained root, and deploying an "allow all" policy). These
 policies must be signed by a certificate that chains to the
-``SYSTEM_TRUSTED_KEYRING``. With openssl, the policy can be signed by::
+``SYSTEM_TRUSTED_KEYRING``, or to the secondary and/or platform keyrings if
+``CONFIG_IPE_POLICY_SIG_SECONDARY_KEYRING`` and/or
+``CONFIG_IPE_POLICY_SIG_PLATFORM_KEYRING`` are enabled, respectively.
+With openssl, the policy can be signed by::
 
    openssl smime -sign \
       -in "$MY_POLICY" \
diff --git a/security/ipe/Kconfig b/security/ipe/Kconfig
index 3ab582606ed2..ee6beca5494a 100644
--- a/security/ipe/Kconfig
+++ b/security/ipe/Kconfig
@@ -31,6 +31,25 @@ config IPE_BOOT_POLICY
 
 	  If unsure, leave blank.
 
+config IPE_POLICY_SIG_SECONDARY_KEYRING
+        bool "IPE policy update verification with secondary keyring"
+        default y
+        depends on SECONDARY_TRUSTED_KEYRING
+        help
+          Also allow the secondary trusted keyring to verify IPE policy
+		  updates.
+
+          If unsure, answer Y.
+
+config IPE_POLICY_SIG_PLATFORM_KEYRING
+        bool "IPE policy update verification with platform keyring"
+        default y
+        depends on INTEGRITY_PLATFORM_KEYRING
+        help
+          Also allow the platform keyring to verify IPE policy updates.
+
+          If unsure, answer Y.
+
 menu "IPE Trust Providers"
 
 config IPE_PROP_DM_VERITY
diff --git a/security/ipe/policy.c b/security/ipe/policy.c
index d8e7db857a2e..bf5aa97911e1 100644
--- a/security/ipe/policy.c
+++ b/security/ipe/policy.c
@@ -169,9 +169,21 @@ struct ipe_policy *ipe_new_policy(const char *text, size_t textlen,
 			goto err;
 		}
 
-		rc = verify_pkcs7_signature(NULL, 0, new->pkcs7, pkcs7len, NULL,
+		rc = verify_pkcs7_signature(NULL, 0, new->pkcs7, pkcs7len,
+#ifdef CONFIG_IPE_POLICY_SIG_SECONDARY_KEYRING
+					    VERIFY_USE_SECONDARY_KEYRING,
+#else
+					    NULL,
+#endif
 					    VERIFYING_UNSPECIFIED_SIGNATURE,
 					    set_pkcs7_data, new);
+#ifdef CONFIG_IPE_POLICY_SIG_PLATFORM_KEYRING
+		if (rc == -ENOKEY)
+			rc = verify_pkcs7_signature(NULL, 0, new->pkcs7, pkcs7len,
+						    VERIFY_USE_PLATFORM_KEYRING,
+						    VERIFYING_UNSPECIFIED_SIGNATURE,
+						    set_pkcs7_data, new);
+#endif
 		if (rc)
 			goto err;
 	} else {
-- 
2.39.5

