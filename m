Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269D6C433EF
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Jul 2022 09:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiGLJdP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 12 Jul 2022 05:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiGLJdO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 12 Jul 2022 05:33:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D66009FE03
        for <linux-security-module@vger.kernel.org>; Tue, 12 Jul 2022 02:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657618392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=C8hxIj8W6IqTe1eGgWCKuGOk0xM/C1HXIo4o+0ApBic=;
        b=fbXGfrT6qoxXz+Ew+dnkfManLsfL5AlYVQlro2aP7eq+q7vjLpSElyPLCoUFdqY4lGFYAc
        CKvRA0ercB6/jp3ag7PmGyJjs+SMv6/zC/gAvUI6JRvII5GWG9DuzS28G6G7k1gyB2aKEt
        4tctt/Of9qhb10IA3jDwG1AjV3qVME0=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-215-9M8zyyWdPISlmUcOOrewNQ-1; Tue, 12 Jul 2022 05:33:12 -0400
X-MC-Unique: 9M8zyyWdPISlmUcOOrewNQ-1
Received: by mail-pj1-f72.google.com with SMTP id a2-20020a17090a740200b001efaae60a57so4739910pjg.8
        for <linux-security-module@vger.kernel.org>; Tue, 12 Jul 2022 02:33:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C8hxIj8W6IqTe1eGgWCKuGOk0xM/C1HXIo4o+0ApBic=;
        b=kMBapguJXofY9p9whkjf2iDCsXDSzh4prMyTTWPhPOB7EViPvRs6Fek3EbGuNxtRJ5
         hG3On71I/LNr1Neky6OGnLqoK15jtc5bPigRYy4Qo13BX4QNizXLvWeDN7suWaBgfO3c
         k/KvCbyvi+34rqUSnv9SRwyUQ2TPSNNpSUz8iiYMphZ8CtG+oK6bepr7iK8JKX+ikfeg
         SxXsxr92wI9Ts/ahXUllYYX+rPGmyQghJb7X63rM9vTn+RUkvBe2FfjdnJqMsrqApJ0h
         jBMFgsfB9FOt88l+HnXnSbh1ugu+tuPmRySII9dYRTUX35h/xO12qjt3zv4a1RjQeQYE
         uLAA==
X-Gm-Message-State: AJIora9bEWX/6ZXX5+ocEMmfOUCYbVPjLoE4zBszTwK/WTq1HVPFCdf4
        gTD/yGNjhmhTzGDfZITVYx+a8g2N+V8Zu+n4xxbaqPqY8Y5Kk06VscWFLySngN5VJHYLtf8sWFd
        UMv2i2KUBOWXU/WAaNVMgdBjjpuFRpYbKKYdN
X-Received: by 2002:a17:90b:3143:b0:1f0:3971:37ae with SMTP id ip3-20020a17090b314300b001f0397137aemr3053905pjb.223.1657618390968;
        Tue, 12 Jul 2022 02:33:10 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tOFdkJayybBuHE8OnzykQjiCZL0lFlbFjIsgPcu72kuqlDypFwfzh30+3NjLaon1pSkzF5jw==
X-Received: by 2002:a17:90b:3143:b0:1f0:3971:37ae with SMTP id ip3-20020a17090b314300b001f0397137aemr3053889pjb.223.1657618390754;
        Tue, 12 Jul 2022 02:33:10 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id y16-20020a17090264d000b0015e8d4eb26esm6247747pli.184.2022.07.12.02.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 02:33:09 -0700 (PDT)
From:   Coiby Xu <coxu@redhat.com>
To:     linux-integrity@vger.kernel.org
Cc:     kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        David Howells <dhowells@redhat.com>,
        Jiri Bohac <jbohac@suse.cz>,
        Matthew Garrett <mjg59@google.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH] ima: force signature verification when CONFIG_KEXEC_SIG is configured
Date:   Tue, 12 Jul 2022 17:33:01 +0800
Message-Id: <20220712093302.49490-1-coxu@redhat.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=coxu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Currently, an unsigned kernel could be kexec'ed when IMA arch specific
policy is configured unless lockdown is enabled. Enforce kernel
signature verification check in the kexec_file_load syscall when IMA
arch specific policy is configured.

Fixes: 99d5cadfde2b ("kexec_file: split KEXEC_VERIFY_SIG into KEXEC_SIG and KEXEC_SIG_FORCE")
Reported-by: Mimi Zohar <zohar@linux.ibm.com>
Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 include/linux/kexec.h            |  3 +++
 kernel/kexec_file.c              | 11 ++++++++++-
 security/integrity/ima/ima_efi.c |  3 +++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index ce6536f1d269..4b8e8d5bcea9 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -134,6 +134,9 @@ typedef int (kexec_cleanup_t)(void *loader_data);
 #ifdef CONFIG_KEXEC_SIG
 typedef int (kexec_verify_sig_t)(const char *kernel_buf,
 				 unsigned long kernel_len);
+void set_kexec_sig_enforced(void);
+#else
+static inline void set_kexec_sig_enforced(void) {}
 #endif
 
 struct kexec_file_ops {
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 145321a5e798..f9261c07b048 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -29,6 +29,15 @@
 #include <linux/vmalloc.h>
 #include "kexec_internal.h"
 
+#ifdef CONFIG_KEXEC_SIG
+static bool sig_enforce = IS_ENABLED(CONFIG_KEXEC_SIG_FORCE);
+
+void set_kexec_sig_enforced(void)
+{
+	sig_enforce = true;
+}
+#endif
+
 static int kexec_calculate_store_digests(struct kimage *image);
 
 /*
@@ -159,7 +168,7 @@ kimage_validate_signature(struct kimage *image)
 					   image->kernel_buf_len);
 	if (ret) {
 
-		if (IS_ENABLED(CONFIG_KEXEC_SIG_FORCE)) {
+		if (sig_enforce) {
 			pr_notice("Enforced kernel signature verification failed (%d).\n", ret);
 			return ret;
 		}
diff --git a/security/integrity/ima/ima_efi.c b/security/integrity/ima/ima_efi.c
index 71786d01946f..ae3fe4cb8d86 100644
--- a/security/integrity/ima/ima_efi.c
+++ b/security/integrity/ima/ima_efi.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2018 IBM Corporation
  */
 #include <linux/efi.h>
+#include <linux/kexec.h>
 #include <linux/module.h>
 #include <linux/ima.h>
 #include <asm/efi.h>
@@ -67,6 +68,8 @@ const char * const *arch_get_ima_policy(void)
 	if (IS_ENABLED(CONFIG_IMA_ARCH_POLICY) && arch_ima_get_secureboot()) {
 		if (IS_ENABLED(CONFIG_MODULE_SIG))
 			set_module_sig_enforced();
+		if (IS_ENABLED(CONFIG_KEXEC_SIG))
+			set_kexec_sig_enforced();
 		return sb_arch_rules;
 	}
 	return NULL;
-- 
2.35.3

