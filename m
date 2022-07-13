Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB929C43334
	for <linux-security-module@archiver.kernel.org>; Wed, 13 Jul 2022 07:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbiGMHVT (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 13 Jul 2022 03:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbiGMHVT (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 13 Jul 2022 03:21:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 52448BA157
        for <linux-security-module@vger.kernel.org>; Wed, 13 Jul 2022 00:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657696877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1bzHcA1yQj57CCPYm74jUoouv+RLrdBI+n61plkR9Go=;
        b=fWTpltsm1iqS3wzQgbrtwSjjKer/CGQAlaUY3KMO+qbD+MDq/VL7hm0X9Y+3S1uJQzgHpu
        CQ5SYQWzW2v7Xb9zz9PDQMyb5DfSIgcNKZPg4YQgc/oLPtMhKMCM8BZ2e8l+VSMM3dnH68
        mkciMmi1EcWjiSpj/JPMxPJwE91ffO4=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-142-JL1G7sssMZSZJxxXclY7Vg-1; Wed, 13 Jul 2022 03:21:16 -0400
X-MC-Unique: JL1G7sssMZSZJxxXclY7Vg-1
Received: by mail-pj1-f72.google.com with SMTP id o8-20020a17090ab88800b001ef81869167so1028771pjr.2
        for <linux-security-module@vger.kernel.org>; Wed, 13 Jul 2022 00:21:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1bzHcA1yQj57CCPYm74jUoouv+RLrdBI+n61plkR9Go=;
        b=uPvPH56i4yJD1WfWdR4nWJNvYAmRiKKvsTm1R8Y8glmKLLa2X48gHi8SbqCMoESMzF
         zSUBk75cd+LRDG5Bbog4dxYZC0nBkoPD0O4q5zsYSNfgM7Xtu5cFLMCEDljBFR61gVPb
         4Zl8DNz1g99JesL5wXFohWnIKpEg6B7HCzxuD7//zt4NNl8+ZPIsRFpe1R9ZlGxJWbuO
         DKn87uwHAF7MxzI76mD3bLgzbpBIgOHNgFytUCmg/rNfBKDb0F3lGbC5E+a3YfwPoIsv
         DdR+Skn0CX01/V+wHvT/aH633Ph2qvWbLki1x+sX9k1o4MygtNOLfDHcR5EXgc6o+fNK
         skJw==
X-Gm-Message-State: AJIora/VzwRxG7OetDxnAi9YJxiYWuN6jBdyCpZ8ZkwcmJwoPUyw5y/i
        FdcOegRmteN6QXWdtA938syviXFWe8dQqrMKzLd7k2w5jlC/jfKSYw91rP9XDliDFiFGttSyHx6
        Y9/q7G1yGJDQ444ejia1a6RItw8x4gJV7ktAp
X-Received: by 2002:a17:902:e153:b0:16b:dccf:5a89 with SMTP id d19-20020a170902e15300b0016bdccf5a89mr2137314pla.69.1657696874948;
        Wed, 13 Jul 2022 00:21:14 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vBQYf48YTRO3J0cXEwN13e016x/uaZqgH8q/LrUIWqrRZZ1fxgfGwjni6KBVsTw3wzYIRdGg==
X-Received: by 2002:a17:902:e153:b0:16b:dccf:5a89 with SMTP id d19-20020a170902e15300b0016bdccf5a89mr2137291pla.69.1657696874696;
        Wed, 13 Jul 2022 00:21:14 -0700 (PDT)
Received: from localhost ([240e:3a1:31b:3d30:c711:d753:abde:647d])
        by smtp.gmail.com with ESMTPSA id jj14-20020a170903048e00b0016c5b2a16ffsm2912305plb.142.2022.07.13.00.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 00:21:14 -0700 (PDT)
From:   Coiby Xu <coxu@redhat.com>
To:     linux-integrity@vger.kernel.org
Cc:     kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jiri Bohac <jbohac@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH v2] ima: force signature verification when CONFIG_KEXEC_SIG is configured
Date:   Wed, 13 Jul 2022 15:21:11 +0800
Message-Id: <20220713072111.230333-1-coxu@redhat.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220712093302.49490-1-coxu@redhat.com>
References: <20220712093302.49490-1-coxu@redhat.com>
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
v2
 - don't include linux/kexec.h since it's already been included in
   linux/ima.h
 - fix build errors when KEXEC_FILE/KEXEC_CORE is disable as caught by
   kernel test robot <lkp@intel.com>

---
 include/linux/kexec.h            |  6 ++++++
 kernel/kexec_file.c              | 11 ++++++++++-
 security/integrity/ima/ima_efi.c |  2 ++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index ce6536f1d269..475683cd67f1 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -452,6 +452,12 @@ static inline int kexec_crash_loaded(void) { return 0; }
 #define kexec_in_progress false
 #endif /* CONFIG_KEXEC_CORE */
 
+#ifdef CONFIG_KEXEC_SIG
+void set_kexec_sig_enforced(void);
+#else
+static inline void set_kexec_sig_enforced(void) {}
+#endif
+
 #endif /* !defined(__ASSEBMLY__) */
 
 #endif /* LINUX_KEXEC_H */
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
index 71786d01946f..9db66fe310d4 100644
--- a/security/integrity/ima/ima_efi.c
+++ b/security/integrity/ima/ima_efi.c
@@ -67,6 +67,8 @@ const char * const *arch_get_ima_policy(void)
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

