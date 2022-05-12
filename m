Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98467C43217
	for <linux-security-module@archiver.kernel.org>; Thu, 12 May 2022 07:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348909AbiELHBx (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 12 May 2022 03:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344884AbiELHBo (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 12 May 2022 03:01:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B2B6F4833C
        for <linux-security-module@vger.kernel.org>; Thu, 12 May 2022 00:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652338897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mevjy/DGPy4eqIk5EbdLPFrJaGfCXH1nWhTn6iIdPnc=;
        b=SCW2AM2tmSftmkTgtFTb5LspwHKyHh95H+8PGvr11wXl9GFYtHvn/NGldFEDhM5Z50+8f5
        ndJBOYsd8jBr/dV3FVuGzjnBmBZDOGBe0951gwcSAMWK/FYAtOs6tVB7+zB16T4m5MPL8o
        REJaA+t+jVj3bfH9mk3vMg6tMo210xc=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-111-kwsy2QjEMHaxF_6FfTZtGw-1; Thu, 12 May 2022 03:01:36 -0400
X-MC-Unique: kwsy2QjEMHaxF_6FfTZtGw-1
Received: by mail-pf1-f199.google.com with SMTP id h19-20020aa796d3000000b0050d3c025470so2244387pfq.0
        for <linux-security-module@vger.kernel.org>; Thu, 12 May 2022 00:01:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mevjy/DGPy4eqIk5EbdLPFrJaGfCXH1nWhTn6iIdPnc=;
        b=TWj4P2yG5XHGCbHsEHOSarJ25XAui3ZeFJ/JJhKq9H0qG1kd9ugRf+LU7OdS4EDUkk
         D5czRoA4JKnkBMTLJiMWY+3eLcz2mhgc4idINhIgkUJGEv4e6L1gRa/Rv3WVETOuiTT9
         sTBRNm3qGXsQUvW5cGGTUs3Ijg28D3G+LiI71qyAqFzgshkAQkXZ8R0W7TlCgOMiy0M+
         fnmci/f2HxSu34ZZo+DciQ5z+EG6gMQ3y6gebAyWe0KTYWGF/QMM93Utctkn2uCI7vGc
         snUVnN91Rq2S61he2FFzsp9syBOIoZHHQ+m9VJ5F+Mir2n5P0fa3F04awTBRl6DIf3cS
         RAzQ==
X-Gm-Message-State: AOAM532fyHec+VQc2GFbc1wQAK2vR57cK2A7OgbeIv4RjxGi4ozPiJju
        zajAaSVj4w3iweJAFy+kOOem21nGnHGN9ma8d9T5R5qHTbtlsut1rkZdrKUdcTroP+MUz9RaUn4
        s2HJmdyK+rc1q0XtGvKtF3+G+iD7Xw6dM3V8A
X-Received: by 2002:a17:90b:50b:b0:1dc:a0b1:c783 with SMTP id r11-20020a17090b050b00b001dca0b1c783mr9496052pjz.49.1652338895889;
        Thu, 12 May 2022 00:01:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyL7dbJyojSNiYp6yhVPBLmJfJDRySqPe4tUcXYdPqOzrvmcXE2jXe5MahLEz2xxAmrohNavg==
X-Received: by 2002:a17:90b:50b:b0:1dc:a0b1:c783 with SMTP id r11-20020a17090b050b00b001dca0b1c783mr9496032pjz.49.1652338895671;
        Thu, 12 May 2022 00:01:35 -0700 (PDT)
Received: from localhost ([240e:3a1:2e9:efa0:e73c:e550:ac9e:58fd])
        by smtp.gmail.com with ESMTPSA id gn21-20020a17090ac79500b001d903861194sm1082640pjb.30.2022.05.12.00.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 00:01:35 -0700 (PDT)
From:   Coiby Xu <coxu@redhat.com>
To:     kexec@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Michal Suchanek <msuchanek@suse.de>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Mimi Zohar <zohar@linux.ibm.com>, Chun-Yi Lee <jlee@suse.com>,
        stable@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v8 3/4] arm64: kexec_file: use more system keyrings to verify kernel image signature
Date:   Thu, 12 May 2022 15:01:22 +0800
Message-Id: <20220512070123.29486-4-coxu@redhat.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220512070123.29486-1-coxu@redhat.com>
References: <20220512070123.29486-1-coxu@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=coxu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Currently, a problem faced by arm64 is if a kernel image is signed by a
MOK key, loading it via the kexec_file_load() system call would be
rejected with the error "Lockdown: kexec: kexec of unsigned images is
restricted; see man kernel_lockdown.7".

This happens because image_verify_sig uses only the primary keyring that
contains only kernel built-in keys to verify the kexec image.

This patch allows to verify arm64 kernel image signature using not only
.builtin_trusted_keys but also .platform and .secondary_trusted_keys
keyring.

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

