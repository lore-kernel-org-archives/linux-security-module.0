Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FA1C43334
	for <linux-security-module@archiver.kernel.org>; Thu, 14 Jul 2022 13:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239824AbiGNNlI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 14 Jul 2022 09:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238596AbiGNNlH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 14 Jul 2022 09:41:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA362606B4
        for <linux-security-module@vger.kernel.org>; Thu, 14 Jul 2022 06:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657806065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nYaKoPGAE5GuTNjUTcyk/8OnPeCKT4Q4LTaKkZkFBRE=;
        b=ABx94QTbAN3lL+mvdsyqt90WrVygEPn8YEi41HyiIJBOpKlZwyhBkq+DqO6KukzbQN4uPK
        2OMVf2Yuxlw6Ny8GzZ8ovg3mAzmKCWkbH+Hnu8RDU8wQJoRmY8a1ZUhtVS5TVnpoS9yDA3
        WTLUVTL4/s3k4XeXPB0looosoRNeV3U=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-427-CpOQEZPzPm-V8NuWuPK87g-1; Thu, 14 Jul 2022 09:41:03 -0400
X-MC-Unique: CpOQEZPzPm-V8NuWuPK87g-1
Received: by mail-pf1-f200.google.com with SMTP id 5-20020a620605000000b00527ca01f8a3so1214154pfg.19
        for <linux-security-module@vger.kernel.org>; Thu, 14 Jul 2022 06:41:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nYaKoPGAE5GuTNjUTcyk/8OnPeCKT4Q4LTaKkZkFBRE=;
        b=WULd/diAwub0iW2vgPHPZaubbM3Ws8pfDSa1d+nm2yvI1bHkKweLh2XnzJUdn92XXz
         lTU5Nz3PsHFhG9an0OTCxw2uJgcS3znKF05IkySct2TvAg6wyX4rXiBKhUFwBO9PS0/v
         OHEoQJ3J3uN0jDPCR0BcFfkt2jhARqqQQCP4AdndFkGfoMKsu3+C3UQB3CVSaa1PEYOg
         2Qk5V/ENL+YSA5/kHeLl1MfiGNO2DYQeM8NWqGrxmT77Vf4a9M730kUdMwI2/RAbvqle
         eMcBccm53GIldy9HqTr/ignFj67jftsYM5q0XcaSmKuExn9Rn16c54RNU8tRp8OIkr9G
         Qa6Q==
X-Gm-Message-State: AJIora/Y1r7lMNXJVNeTso6ddGn1+KCRghtuGggjqZv3IQICB+xtX9qG
        l1LrIDBkC6S5KSTjRMA1LlMe3r8Sl0Y7NVoogvlwvf5oE8/mBkgMNEdvFtG1Agr/h/+dL5bCEkq
        eTYKbGhlbQiAW8tKi0wkrdyG/BUNFAq5InrzY
X-Received: by 2002:a17:90b:3c07:b0:1f0:eab4:79e4 with SMTP id pb7-20020a17090b3c0700b001f0eab479e4mr1116960pjb.186.1657806062499;
        Thu, 14 Jul 2022 06:41:02 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sPB4AJHTz7fd94myeXuSf8getkOgYveQhJicFIsXMd+oF8xCeEgRFuBRRxo5JHCdTOoHv9uw==
X-Received: by 2002:a17:90b:3c07:b0:1f0:eab4:79e4 with SMTP id pb7-20020a17090b3c0700b001f0eab479e4mr1116928pjb.186.1657806062264;
        Thu, 14 Jul 2022 06:41:02 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j31-20020a63fc1f000000b00419ab8f8d2csm1342551pgi.20.2022.07.14.06.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 06:41:01 -0700 (PDT)
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
        James Morse <james.morse@arm.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v10 3/4] arm64: kexec_file: use more system keyrings to verify kernel image signature
Date:   Thu, 14 Jul 2022 21:40:26 +0800
Message-Id: <20220714134027.394370-4-coxu@redhat.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220714134027.394370-1-coxu@redhat.com>
References: <20220714134027.394370-1-coxu@redhat.com>
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
Cc: stable@vger.kernel.org # 105e10e2cf1c: kexec_file: drop weak attribute from functions
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

