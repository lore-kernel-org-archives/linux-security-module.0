Return-Path: <SRS0=s83O=N2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319C6C43441
	for <linux-security-module@archiver.kernel.org>; Thu, 15 Nov 2018 00:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1776208E7
	for <linux-security-module@archiver.kernel.org>; Thu, 15 Nov 2018 00:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/FXYg74"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1776208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbeKOK67 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 15 Nov 2018 05:58:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:57822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726169AbeKOK67 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 15 Nov 2018 05:58:59 -0500
Received: from ebiggers.mtv.corp.google.com (unknown [104.132.1.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0E72208E7;
        Thu, 15 Nov 2018 00:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542243202;
        bh=6ltg2a/mEOUGeovcBcjnAzX8Oeurk8mI8Ki533OPUkM=;
        h=From:To:Cc:Subject:Date:From;
        b=a/FXYg74qCt+dKN84+oFzTsZ7kt1zxTz33AuRyCzBc5PwXlhZDs8SMFvt/qKW/nHh
         MXPub6ac9IUqkHAacjhiQtC4TSSw3PsvejBhyfZSyq0e3/5dvdLbcE+t4jOa9L3pCu
         zQ+U6/6nIf/C8/tBCvfTXRZy6vqmePYcxnky3yXk=
From:   Eric Biggers <ebiggers@kernel.org>
To:     keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Cc:     linux-security-module@vger.kernel.org
Subject: [PATCH RESEND] KEYS: remove CONFIG_KEYS_COMPAT
Date:   Wed, 14 Nov 2018 16:52:38 -0800
Message-Id: <20181115005238.70971-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

KEYS_COMPAT now always takes the value of COMPAT && KEYS.  But the
security/keys/ directory is only compiled if KEYS is enabled, so in
practice KEYS_COMPAT is the same as COMPAT.  Therefore, remove the
unnecessary KEYS_COMPAT and just use COMPAT directly.

(Also remove an outdated comment from compat.c.)

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 security/keys/Kconfig    | 4 ----
 security/keys/Makefile   | 2 +-
 security/keys/compat.c   | 5 -----
 security/keys/internal.h | 4 ++--
 4 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/security/keys/Kconfig b/security/keys/Kconfig
index 6462e6654ccf4..e115d691d9776 100644
--- a/security/keys/Kconfig
+++ b/security/keys/Kconfig
@@ -20,10 +20,6 @@ config KEYS
 
 	  If you are unsure as to whether this is required, answer N.
 
-config KEYS_COMPAT
-	def_bool y
-	depends on COMPAT && KEYS
-
 config PERSISTENT_KEYRINGS
 	bool "Enable register of persistent per-UID keyrings"
 	depends on KEYS
diff --git a/security/keys/Makefile b/security/keys/Makefile
index 9cef54064f608..c694458d9a46c 100644
--- a/security/keys/Makefile
+++ b/security/keys/Makefile
@@ -17,7 +17,7 @@ obj-y := \
 	request_key_auth.o \
 	user_defined.o
 compat-obj-$(CONFIG_KEY_DH_OPERATIONS) += compat_dh.o
-obj-$(CONFIG_KEYS_COMPAT) += compat.o $(compat-obj-y)
+obj-$(CONFIG_COMPAT) += compat.o $(compat-obj-y)
 obj-$(CONFIG_PROC_FS) += proc.o
 obj-$(CONFIG_SYSCTL) += sysctl.o
 obj-$(CONFIG_PERSISTENT_KEYRINGS) += persistent.o
diff --git a/security/keys/compat.c b/security/keys/compat.c
index 9482df601dc33..f22527e88e3d5 100644
--- a/security/keys/compat.c
+++ b/security/keys/compat.c
@@ -50,11 +50,6 @@ static long compat_keyctl_instantiate_key_iov(
 
 /*
  * The key control system call, 32-bit compatibility version for 64-bit archs
- *
- * This should only be called if the 64-bit arch uses weird pointers in 32-bit
- * mode or doesn't guarantee that the top 32-bits of the argument registers on
- * taking a 32-bit syscall are zero.  If you can, you should call sys_keyctl()
- * directly.
  */
 COMPAT_SYSCALL_DEFINE5(keyctl, u32, option,
 		       u32, arg2, u32, arg3, u32, arg4, u32, arg5)
diff --git a/security/keys/internal.h b/security/keys/internal.h
index 74cb0ff42fedb..d1836e5d670cb 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -272,7 +272,7 @@ extern long keyctl_dh_compute(struct keyctl_dh_params __user *, char __user *,
 			      size_t, struct keyctl_kdf_params __user *);
 extern long __keyctl_dh_compute(struct keyctl_dh_params __user *, char __user *,
 				size_t, struct keyctl_kdf_params *);
-#ifdef CONFIG_KEYS_COMPAT
+#ifdef CONFIG_COMPAT
 extern long compat_keyctl_dh_compute(struct keyctl_dh_params __user *params,
 				char __user *buffer, size_t buflen,
 				struct compat_keyctl_kdf_params __user *kdf);
@@ -287,7 +287,7 @@ static inline long keyctl_dh_compute(struct keyctl_dh_params __user *params,
 	return -EOPNOTSUPP;
 }
 
-#ifdef CONFIG_KEYS_COMPAT
+#ifdef CONFIG_COMPAT
 static inline long compat_keyctl_dh_compute(
 				struct keyctl_dh_params __user *params,
 				char __user *buffer, size_t buflen,
-- 
2.19.1.930.g4563a0d9d0-goog

