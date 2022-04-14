Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DE9C433EF
	for <linux-security-module@archiver.kernel.org>; Thu, 14 Apr 2022 01:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239472AbiDNBqi (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 13 Apr 2022 21:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbiDNBqh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 13 Apr 2022 21:46:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F8E721E1D
        for <linux-security-module@vger.kernel.org>; Wed, 13 Apr 2022 18:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649900653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vd6dGinkDQ+ERZGbhh7LGheOUAL1/G4cOFfIvwcXv0w=;
        b=W634x9OUMI4pFJwRhzkgARo3uvyFsRKlFRazZWtGbvcqCZykYmYT8mHudZp3Ly2tzN4AM/
        OAp+LFbRWRTqfc5N67JgBVrxEY0pttg7t563e16KXC1Zb66YTMyu2QG7V5Rnq2T3/lBVZy
        Da+WWtHCA4QkUgl/QLBfEZOlsn+5tzU=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-470-o5gJsC8nO_KbD2v6LzjoDA-1; Wed, 13 Apr 2022 21:44:12 -0400
X-MC-Unique: o5gJsC8nO_KbD2v6LzjoDA-1
Received: by mail-pl1-f197.google.com with SMTP id l3-20020a170903244300b001570540beb6so1969145pls.16
        for <linux-security-module@vger.kernel.org>; Wed, 13 Apr 2022 18:44:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vd6dGinkDQ+ERZGbhh7LGheOUAL1/G4cOFfIvwcXv0w=;
        b=UU9D+73XUbmawEJXUsb3gXeJyxaXJlOHyB071Mkc5TlxA7mAA6APuGKLvO/EJjQgEq
         y791RB+do5Sg8/Dpj2W0DfI4kmMOxbJsqIsrs94y8cnEJ4v9wO0dwsMcnIMtFp7KCWtt
         +KP1BCl+Fk/4EnDX2nQFcdGHsXFbS3eyr0h9a85fEi+8jEvsJnNts4RjDiZ6qGD57Own
         d4YLmFGELTkarevOrz3ixP0YDMjFoZto0JvdvbyvZuOF0Cn+4AXqvLVOerQ16sVkMrbn
         D6IVFnEc53Ot0JdtRIm+DTtj/l9yJiwipwMQ29jyG03JJJEIU2mKbXE0fcYGJkuAtEx3
         KAtw==
X-Gm-Message-State: AOAM530H0yIqqA73kVKE+Yv+dc8QrGRyWWVf0ykaIAMMbq2C/CE3dbtD
        Q5WBfv+Qol6cn/72Y8r4Teb2Lg/ivEh9wDeEA2W81ka68FzjrAf++GIdWMrv675Z6EfS/6svDYa
        X3qZ/pzilKCa9ipTW8Kb+soH14wu1cfknlk1P
X-Received: by 2002:a17:903:124a:b0:154:c7a4:9375 with SMTP id u10-20020a170903124a00b00154c7a49375mr44981238plh.0.1649900651073;
        Wed, 13 Apr 2022 18:44:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxSgcCqZWhETgn3SMmtU4LkqvxAQAdH4WIMasH4oGV8IV/wkQ4upyzvRDsL1mE0nxbO0jb+sg==
X-Received: by 2002:a17:903:124a:b0:154:c7a4:9375 with SMTP id u10-20020a170903124a00b00154c7a49375mr44981222plh.0.1649900650830;
        Wed, 13 Apr 2022 18:44:10 -0700 (PDT)
Received: from localhost ([240e:3a1:31c:360:52fc:c968:cb41:efbc])
        by smtp.gmail.com with ESMTPSA id b12-20020a17090aa58c00b001ca977b49d5sm295456pjq.31.2022.04.13.18.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 18:44:10 -0700 (PDT)
From:   Coiby Xu <coxu@redhat.com>
To:     kexec@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Michal Suchanek <msuchanek@suse.de>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Mimi Zohar <zohar@linux.ibm.com>, Chun-Yi Lee <jlee@suse.com>,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        stable@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>, Kairui Song <kasong@redhat.com>,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [PATCH v6 2/4] kexec, KEYS: make the code in bzImage64_verify_sig generic
Date:   Thu, 14 Apr 2022 09:43:42 +0800
Message-Id: <20220414014344.228523-3-coxu@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220414014344.228523-1-coxu@redhat.com>
References: <20220414014344.228523-1-coxu@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=coxu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

commit 278311e417be ("kexec, KEYS: Make use of platform keyring for
signature verify") adds platform keyring support on x86 kexec but not
arm64.

The code in bzImage64_verify_sig makes use of system keyrings including
.buitin_trusted_keys, .secondary_trusted_keys and .platform keyring to
verify signed kernel image as PE file. Make it generic so both x86_64
and arm64 can use it.

Fixes: 278311e417be ("kexec, KEYS: Make use of platform keyring for signature verify")
Cc: kexec@lists.infradead.org
Cc: keyrings@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Cc: stable@kernel.org
Reviewed-by: Michal Suchanek <msuchanek@suse.de>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 arch/x86/kernel/kexec-bzimage64.c | 20 +-------------------
 include/linux/kexec.h             |  7 +++++++
 kernel/kexec_file.c               | 17 +++++++++++++++++
 3 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 170d0fd68b1f..f299b48f9c9f 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -17,7 +17,6 @@
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/efi.h>
-#include <linux/verification.h>
 
 #include <asm/bootparam.h>
 #include <asm/setup.h>
@@ -528,28 +527,11 @@ static int bzImage64_cleanup(void *loader_data)
 	return 0;
 }
 
-#ifdef CONFIG_KEXEC_BZIMAGE_VERIFY_SIG
-static int bzImage64_verify_sig(const char *kernel, unsigned long kernel_len)
-{
-	int ret;
-
-	ret = verify_pefile_signature(kernel, kernel_len,
-				      VERIFY_USE_SECONDARY_KEYRING,
-				      VERIFYING_KEXEC_PE_SIGNATURE);
-	if (ret == -ENOKEY && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING)) {
-		ret = verify_pefile_signature(kernel, kernel_len,
-					      VERIFY_USE_PLATFORM_KEYRING,
-					      VERIFYING_KEXEC_PE_SIGNATURE);
-	}
-	return ret;
-}
-#endif
-
 const struct kexec_file_ops kexec_bzImage64_ops = {
 	.probe = bzImage64_probe,
 	.load = bzImage64_load,
 	.cleanup = bzImage64_cleanup,
 #ifdef CONFIG_KEXEC_BZIMAGE_VERIFY_SIG
-	.verify_sig = bzImage64_verify_sig,
+	.verify_sig = kexec_kernel_verify_pe_sig,
 #endif
 };
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 413235c6c797..da83abfc628b 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -19,6 +19,7 @@
 #include <asm/io.h>
 
 #include <uapi/linux/kexec.h>
+#include <linux/verification.h>
 
 /* Location of a reserved region to hold the crash kernel.
  */
@@ -202,6 +203,12 @@ int arch_kexec_apply_relocations(struct purgatory_info *pi,
 				 const Elf_Shdr *relsec,
 				 const Elf_Shdr *symtab);
 int arch_kimage_file_post_load_cleanup(struct kimage *image);
+#ifdef CONFIG_KEXEC_SIG
+#ifdef CONFIG_SIGNED_PE_FILE_VERIFICATION
+int kexec_kernel_verify_pe_sig(const char *kernel,
+				    unsigned long kernel_len);
+#endif
+#endif
 int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf);
 
 extern int kexec_add_buffer(struct kexec_buf *kbuf);
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 3720435807eb..754885b96aab 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -165,6 +165,23 @@ void kimage_file_post_load_cleanup(struct kimage *image)
 }
 
 #ifdef CONFIG_KEXEC_SIG
+#ifdef CONFIG_SIGNED_PE_FILE_VERIFICATION
+int kexec_kernel_verify_pe_sig(const char *kernel, unsigned long kernel_len)
+{
+	int ret;
+
+	ret = verify_pefile_signature(kernel, kernel_len,
+				      VERIFY_USE_SECONDARY_KEYRING,
+				      VERIFYING_KEXEC_PE_SIGNATURE);
+	if (ret == -ENOKEY && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING)) {
+		ret = verify_pefile_signature(kernel, kernel_len,
+					      VERIFY_USE_PLATFORM_KEYRING,
+					      VERIFYING_KEXEC_PE_SIGNATURE);
+	}
+	return ret;
+}
+#endif
+
 static int kexec_image_verify_sig(struct kimage *image, void *buf,
 		unsigned long buf_len)
 {
-- 
2.34.1

