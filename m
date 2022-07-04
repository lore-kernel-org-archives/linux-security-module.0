Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D6CCCA473
	for <linux-security-module@archiver.kernel.org>; Mon,  4 Jul 2022 01:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbiGDBxD (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 3 Jul 2022 21:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbiGDBwv (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 3 Jul 2022 21:52:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6ABCC63BE
        for <linux-security-module@vger.kernel.org>; Sun,  3 Jul 2022 18:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656899567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EE8ReJL35xooYMRcL0aldhKZVhFpWy3F9pc1cYwfnGA=;
        b=GaZgby1b4wzEbeutmrcHXSdq/a7Kui1peUS3Wd8R4k3Dx84nQC8w1ZT2ePa33gOVJ/t9N1
        OWnn03W5wrykZQhXaEuZ6gxKA3Ejma23NjII9TU4ggPOZ6w2qQqV2YXJ9wgrBWjjvH3tzw
        hGO402LzH66J4g49epP6DkCpAv2vIBk=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-321-BxgUw3ZwOBWjpivvGryiVA-1; Sun, 03 Jul 2022 21:52:46 -0400
X-MC-Unique: BxgUw3ZwOBWjpivvGryiVA-1
Received: by mail-pl1-f199.google.com with SMTP id q8-20020a17090311c800b0016a125c933fso4297076plh.4
        for <linux-security-module@vger.kernel.org>; Sun, 03 Jul 2022 18:52:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EE8ReJL35xooYMRcL0aldhKZVhFpWy3F9pc1cYwfnGA=;
        b=2oxl+0SMVr7efEbeAP92qwJgsnzBy710qLvY2BFP8AesUXxh0fENt57QWvUQQJ3O7d
         v4HHfB0RCr0zr7GbhjZLubyDF57TMuZG0WUOxheefSIcyAxRc8ZRLNz/unDUra74LYXn
         pQB17FYZx11KQBat9W/zFwQvys2kRlgUSZKqqzixp8k4jl4XMbviiSCki1m5zJu8aNAM
         91F7/G81xWi+Fewx6jCbfujc7InMc5da9aL2ltuz/8Mkdjg802QFe9nkMq/b+oG/1IBb
         gpFFDzU59zo1+wW0NlBBrZeXegMvMuXaJsj3qqdaqGHoBcuYgKi1DcSVYKyjDNST18bn
         P8tQ==
X-Gm-Message-State: AJIora+jJ1fyeBACNdDDtC7DKkZpz9Ef7+Qe/1ZGCa9pY2X+IHoJxsqA
        VKHYaobPZcSWkJ8R+0R4HCITF1F3WoDYqohr53SfibGD0kOyhJKnNcPTU4OkTv5uUTQoor5UVR0
        YBDMniHnzQJewVIAaNmINn7E//qdl7TqUMwZR
X-Received: by 2002:a17:90b:4d01:b0:1ef:54e4:f840 with SMTP id mw1-20020a17090b4d0100b001ef54e4f840mr19512602pjb.216.1656899565264;
        Sun, 03 Jul 2022 18:52:45 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vccVgOsoxySyE6jc8B09IaJFFIALoQ7zprfH6mR3bc+DIDyQRm0eLU55vBwyS03zmcKniWuQ==
X-Received: by 2002:a17:90b:4d01:b0:1ef:54e4:f840 with SMTP id mw1-20020a17090b4d0100b001ef54e4f840mr19512561pjb.216.1656899564976;
        Sun, 03 Jul 2022 18:52:44 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id c12-20020a621c0c000000b0050dc7628178sm19752005pfc.82.2022.07.03.18.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 18:52:44 -0700 (PDT)
From:   Coiby Xu <coxu@redhat.com>
To:     kexec@lists.infradead.org, linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        linux-arm-kernel@lists.infradead.org,
        Michal Suchanek <msuchanek@suse.de>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Chun-Yi Lee <jlee@suse.com>, stable@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v9 3/4] arm64: kexec_file: use more system keyrings to verify kernel image signature
Date:   Mon,  4 Jul 2022 09:52:00 +0800
Message-Id: <20220704015201.59744-4-coxu@redhat.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220704015201.59744-1-coxu@redhat.com>
References: <20220704015201.59744-1-coxu@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=coxu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Currently, when loading a kernel image via the kexec_file_load() system
call, arm64 can only use the .builtin_trusted_keys keyring to verify
a signature whereas x86 can use three more keyrings i.e.
.secondary_trusted_keys, .machine and .platform keyrings. For example,
one resulting problem is kexec'ing a kernel image  would be rejected
with the error "Lockdown: kexec: kexec of unsigned images is restricted;
see man kernel_lockdown.7".

This patch set enables arm64 to make use of the same keyrings as x86 to
verify the signature kexec'ed kernel image.

Fixes: 732b7b93d849 ("arm64: kexec_file: add kernel signature verification support")
Cc: stable@vger.kernel.org # 34d5960af253: kexec: clean up arch_kexec_kernel_verify_sig
Cc: stable@vger.kernel.org # 83b7bb2d49ae: kexec, KEYS: make the code in bzImage64_verify_sig generic
Acked-by: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org
Cc: keyrings@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Co-developed-by: Michal Suchanek <msuchanek@suse.de>
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 arch/arm64/kernel/kexec_image.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
index 9ec34690e255..5ed6a585f21f 100644
--- a/arch/arm64/kernel/kexec_image.c
+++ b/arch/arm64/kernel/kexec_image.c
@@ -14,7 +14,6 @@
 #include <linux/kexec.h>
 #include <linux/pe.h>
 #include <linux/string.h>
-#include <linux/verification.h>
 #include <asm/byteorder.h>
 #include <asm/cpufeature.h>
 #include <asm/image.h>
@@ -130,18 +129,10 @@ static void *image_load(struct kimage *image,
 	return NULL;
 }
 
-#ifdef CONFIG_KEXEC_IMAGE_VERIFY_SIG
-static int image_verify_sig(const char *kernel, unsigned long kernel_len)
-{
-	return verify_pefile_signature(kernel, kernel_len, NULL,
-				       VERIFYING_KEXEC_PE_SIGNATURE);
-}
-#endif
-
 const struct kexec_file_ops kexec_image_ops = {
 	.probe = image_probe,
 	.load = image_load,
 #ifdef CONFIG_KEXEC_IMAGE_VERIFY_SIG
-	.verify_sig = image_verify_sig,
+	.verify_sig = kexec_kernel_verify_pe_sig,
 #endif
 };
-- 
2.35.3

