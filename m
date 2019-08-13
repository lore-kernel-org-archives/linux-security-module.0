Return-Path: <SRS0=o9Ra=WJ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5871C433FF
	for <linux-security-module@archiver.kernel.org>; Tue, 13 Aug 2019 19:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 733B9205F4
	for <linux-security-module@archiver.kernel.org>; Tue, 13 Aug 2019 19:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qGTpf9It"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbfHMTVo (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 13 Aug 2019 15:21:44 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:37781 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfHMTVn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 13 Aug 2019 15:21:43 -0400
Received: by mail-pf1-f201.google.com with SMTP id w30so5184256pfj.4
        for <linux-security-module@vger.kernel.org>; Tue, 13 Aug 2019 12:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=A861+1mOmVyR5QtRNmHzFupjzHAlW0OufyD2KNhRCsU=;
        b=qGTpf9ItxHzf6+9tdPoih4KXW55BTSF6RC4GhTOrVzZ6yP69WiqCJUjFIm0i6xt5HE
         9C4qm9ZDe6B0T9nYCOaXc+EvvgbgPUKjkRTo+H7P2LQR60avQvcmw7Qt9yqCrCXTzX+B
         JAbmep3g4kbotkADp9IR6N/tasP3NwLDzZZCtBXPDDNEdY+QB3OvYkAJU5qSrFPxpIqR
         MgvpdvvESpK+N3obomWckpclcssqUKxQ+cQfL3/dHOVnMJsRXz8T8jqYo09xGuQFoHWn
         p1idYvPuDGaoYyIgXGl78fGh1HhgDSt8BJoQio6JvEBgzHmo7S8TZf7HTlR9MQy7dzWe
         m7OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=A861+1mOmVyR5QtRNmHzFupjzHAlW0OufyD2KNhRCsU=;
        b=H2hb68SI7svvwjJM68ftb+URLHbF0DDe+cP8qLDIl6tRaLVVupUV1deXUFdCzw5K5t
         Eu/lnXY6doLQk9MucZqx5924JODiGAeccuKmDXaKTYqYfScPlg3jbrKVNx5LiRmirV3q
         59zqVeogys0hPLa7+jStxt1BZND2Em+PtJXKQvti83jboWpzlQHGgicNtR4tMf2jfaJz
         FfCKSBcy4I6kYxh10fpJI13qPTG1U+7s7o6HcN/v17lUX+kppPPMe+p1j+HV3CVGURx4
         7x7X7n/QJ8WIO7e5k/dRPhbYHI9g9ewWx1LFfCTvWy5TWHAHV091l3PBeCu3UxaaqbmN
         ZEsw==
X-Gm-Message-State: APjAAAW9oZ4pKylR7Uab3NSVg6UCwzYqiEFGuvaHh2hTvR1Gl+2t7UUG
        /m3TP7JLqTIDtACX3dRsMNdj6W0l0138IhjsTDPzXw==
X-Google-Smtp-Source: APXvYqx+uyk/BN4iocnWHUWpq4kPpgWhHMCQdGRzciS9fcuSNyYID+GolWVWCEfjw120xbkMmfq6LEPSEXNTFMA1PtA6OA==
X-Received: by 2002:a63:61cd:: with SMTP id v196mr36280640pgb.263.1565724102774;
 Tue, 13 Aug 2019 12:21:42 -0700 (PDT)
Date:   Tue, 13 Aug 2019 12:21:25 -0700
In-Reply-To: <20190813192126.122370-1-matthewgarrett@google.com>
Message-Id: <20190813192126.122370-6-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190813192126.122370-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH 5/6] kexec: s/KEXEC_VERIFY_SIG/KEXEC_SIG/ for consistency
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

47b88836 ("kexec_file: split KEXEC_VERIFY_SIG into KEXEC_SIG and
KEXEC_SIG_FORCE") removed CONFIG_KEXEC_VERIFY_SIG, but it's still present
in other architectures and we end up with build breakage as a result.
Make this consistent across architectures.

Fixes: 47b88836 ("kexec_file: split KEXEC_VERIFY_SIG into KEXEC_SIG and KEXEC_SIG_FORCE")
Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 arch/arm64/Kconfig                      | 6 +++---
 arch/s390/Kconfig                       | 2 +-
 arch/s390/configs/debug_defconfig       | 2 +-
 arch/s390/configs/defconfig             | 2 +-
 arch/s390/configs/performance_defconfig | 2 +-
 arch/s390/kernel/kexec_elf.c            | 4 ++--
 arch/s390/kernel/kexec_image.c          | 4 ++--
 arch/s390/kernel/machine_kexec_file.c   | 4 ++--
 arch/x86/kernel/ima_arch.c              | 4 ++--
 security/integrity/ima/Kconfig          | 2 +-
 security/integrity/ima/ima_main.c       | 2 +-
 11 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 697ea0510729..f940500a941b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -961,7 +961,7 @@ config KEXEC_FILE
 	  for kernel and initramfs as opposed to list of segments as
 	  accepted by previous system call.
 
-config KEXEC_VERIFY_SIG
+config KEXEC_SIG
 	bool "Verify kernel signature during kexec_file_load() syscall"
 	depends on KEXEC_FILE
 	help
@@ -976,13 +976,13 @@ config KEXEC_VERIFY_SIG
 config KEXEC_IMAGE_VERIFY_SIG
 	bool "Enable Image signature verification support"
 	default y
-	depends on KEXEC_VERIFY_SIG
+	depends on KEXEC_SIG
 	depends on EFI && SIGNED_PE_FILE_VERIFICATION
 	help
 	  Enable Image signature verification support.
 
 comment "Support for PE file signature verification disabled"
-	depends on KEXEC_VERIFY_SIG
+	depends on KEXEC_SIG
 	depends on !EFI || !SIGNED_PE_FILE_VERIFICATION
 
 config CRASH_DUMP
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 109243fdb6ec..c4a423f30d49 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -555,7 +555,7 @@ config ARCH_HAS_KEXEC_PURGATORY
 	def_bool y
 	depends on KEXEC_FILE
 
-config KEXEC_VERIFY_SIG
+config KEXEC_SIG
 	bool "Verify kernel signature during kexec_file_load() syscall"
 	depends on KEXEC_FILE && SYSTEM_DATA_VERIFICATION
 	help
diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index b0920b35f87b..525e0a6addb9 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -64,7 +64,7 @@ CONFIG_NUMA=y
 CONFIG_PREEMPT=y
 CONFIG_HZ_100=y
 CONFIG_KEXEC_FILE=y
-CONFIG_KEXEC_VERIFY_SIG=y
+CONFIG_KEXEC_SIG=y
 CONFIG_EXPOLINE=y
 CONFIG_EXPOLINE_AUTO=y
 CONFIG_MEMORY_HOTPLUG=y
diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index c59b922cb6c5..4c37279acdb4 100644
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -39,7 +39,7 @@ CONFIG_NR_CPUS=256
 CONFIG_NUMA=y
 CONFIG_HZ_100=y
 CONFIG_KEXEC_FILE=y
-CONFIG_KEXEC_VERIFY_SIG=y
+CONFIG_KEXEC_SIG=y
 CONFIG_CRASH_DUMP=y
 CONFIG_HIBERNATION=y
 CONFIG_PM_DEBUG=y
diff --git a/arch/s390/configs/performance_defconfig b/arch/s390/configs/performance_defconfig
index 09aa5cb14873..158ad0f0d433 100644
--- a/arch/s390/configs/performance_defconfig
+++ b/arch/s390/configs/performance_defconfig
@@ -65,7 +65,7 @@ CONFIG_NR_CPUS=512
 CONFIG_NUMA=y
 CONFIG_HZ_100=y
 CONFIG_KEXEC_FILE=y
-CONFIG_KEXEC_VERIFY_SIG=y
+CONFIG_KEXEC_SIG=y
 CONFIG_EXPOLINE=y
 CONFIG_EXPOLINE_AUTO=y
 CONFIG_MEMORY_HOTPLUG=y
diff --git a/arch/s390/kernel/kexec_elf.c b/arch/s390/kernel/kexec_elf.c
index 6d0635ceddd0..9b4f37a4edf1 100644
--- a/arch/s390/kernel/kexec_elf.c
+++ b/arch/s390/kernel/kexec_elf.c
@@ -130,7 +130,7 @@ static int s390_elf_probe(const char *buf, unsigned long len)
 const struct kexec_file_ops s390_kexec_elf_ops = {
 	.probe = s390_elf_probe,
 	.load = s390_elf_load,
-#ifdef CONFIG_KEXEC_VERIFY_SIG
+#ifdef CONFIG_KEXEC__SIG
 	.verify_sig = s390_verify_sig,
-#endif /* CONFIG_KEXEC_VERIFY_SIG */
+#endif /* CONFIG_KEXEC_SIG */
 };
diff --git a/arch/s390/kernel/kexec_image.c b/arch/s390/kernel/kexec_image.c
index 58318bf89fd9..af23eff5774d 100644
--- a/arch/s390/kernel/kexec_image.c
+++ b/arch/s390/kernel/kexec_image.c
@@ -59,7 +59,7 @@ static int s390_image_probe(const char *buf, unsigned long len)
 const struct kexec_file_ops s390_kexec_image_ops = {
 	.probe = s390_image_probe,
 	.load = s390_image_load,
-#ifdef CONFIG_KEXEC_VERIFY_SIG
+#ifdef CONFIG_KEXEC_SIG
 	.verify_sig = s390_verify_sig,
-#endif /* CONFIG_KEXEC_VERIFY_SIG */
+#endif /* CONFIG_KEXEC_SIG */
 };
diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
index fbdd3ea73667..c0f33ba49a9a 100644
--- a/arch/s390/kernel/machine_kexec_file.c
+++ b/arch/s390/kernel/machine_kexec_file.c
@@ -22,7 +22,7 @@ const struct kexec_file_ops * const kexec_file_loaders[] = {
 	NULL,
 };
 
-#ifdef CONFIG_KEXEC_VERIFY_SIG
+#ifdef CONFIG_KEXEC_SIG
 /*
  * Module signature information block.
  *
@@ -90,7 +90,7 @@ int s390_verify_sig(const char *kernel, unsigned long kernel_len)
 				      VERIFYING_MODULE_SIGNATURE,
 				      NULL, NULL);
 }
-#endif /* CONFIG_KEXEC_VERIFY_SIG */
+#endif /* CONFIG_KEXEC_SIG */
 
 static int kexec_file_update_purgatory(struct kimage *image,
 				       struct s390_load_data *data)
diff --git a/arch/x86/kernel/ima_arch.c b/arch/x86/kernel/ima_arch.c
index 64b973f0e985..b98890894731 100644
--- a/arch/x86/kernel/ima_arch.c
+++ b/arch/x86/kernel/ima_arch.c
@@ -66,9 +66,9 @@ bool arch_ima_get_secureboot(void)
 
 /* secureboot arch rules */
 static const char * const sb_arch_rules[] = {
-#if !IS_ENABLED(CONFIG_KEXEC_VERIFY_SIG)
+#if !IS_ENABLED(CONFIG_KEXEC_SIG)
 	"appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig",
-#endif /* CONFIG_KEXEC_VERIFY_SIG */
+#endif /* CONFIG_KEXEC_SIG */
 	"measure func=KEXEC_KERNEL_CHECK",
 #if !IS_ENABLED(CONFIG_MODULE_SIG)
 	"appraise func=MODULE_CHECK appraise_type=imasig",
diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 2692c7358c2c..32cd25fa44a5 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -160,7 +160,7 @@ config IMA_APPRAISE
 
 config IMA_ARCH_POLICY
         bool "Enable loading an IMA architecture specific policy"
-        depends on KEXEC_VERIFY_SIG || IMA_APPRAISE && INTEGRITY_ASYMMETRIC_KEYS
+        depends on KEXEC_SIG || IMA_APPRAISE && INTEGRITY_ASYMMETRIC_KEYS
         default n
         help
           This option enables loading an IMA architecture specific policy
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index f302cbc387f8..1747bc7bcb60 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -541,7 +541,7 @@ int ima_load_data(enum kernel_load_data_id id)
 
 	switch (id) {
 	case LOADING_KEXEC_IMAGE:
-		if (IS_ENABLED(CONFIG_KEXEC_VERIFY_SIG)
+		if (IS_ENABLED(CONFIG_KEXEC_SIG)
 		    && arch_ima_get_secureboot()) {
 			pr_err("impossible to appraise a kernel image without a file descriptor; try using kexec_file_load syscall.\n");
 			return -EACCES;
-- 
2.23.0.rc1.153.gdeed80330f-goog

