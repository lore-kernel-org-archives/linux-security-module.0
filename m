Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D59C4332F
	for <linux-security-module@archiver.kernel.org>; Thu, 12 May 2022 02:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242259AbiELCe0 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 11 May 2022 22:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242107AbiELCeW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 11 May 2022 22:34:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 470D4134E36
        for <linux-security-module@vger.kernel.org>; Wed, 11 May 2022 19:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652322860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mevjy/DGPy4eqIk5EbdLPFrJaGfCXH1nWhTn6iIdPnc=;
        b=EccvHimqK0C4FusVH33Z31yi2qJ5tuFJ/3caMapRtB86i/eqlY1uia6KRtXGqek1inXIRy
        YOyl4K6NdQ9g36yeL2eVZ4FVBGfJ6D9I0DgtTRGvDjFvU8wK84H528bVl2Wr3XY/sqFVaN
        r2Ty5Kbqx8XvjtHJsPce9DCmfxh5mXY=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-534-ZAUuL_ejMpam__QtOXOEpg-1; Wed, 11 May 2022 22:34:17 -0400
X-MC-Unique: ZAUuL_ejMpam__QtOXOEpg-1
Received: by mail-pg1-f199.google.com with SMTP id 16-20020a630010000000b003c5e4be54b2so1897775pga.2
        for <linux-security-module@vger.kernel.org>; Wed, 11 May 2022 19:34:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mevjy/DGPy4eqIk5EbdLPFrJaGfCXH1nWhTn6iIdPnc=;
        b=qkKfHwKRTzu1fapx0pQ9RuGHgZDN1Ow6ZVimf9fZTUUOkJzt4IT9eJZXXRbA0CWgeb
         y+vaCvOCsJgA8vAIIQ45zIVvTU7KOGJ0bkNQn+dXEFzOPKuq/1C5uKw/R63jINZYLu7o
         O4YD13OCdxuu7iueS/i4HYyI3Gx6b71Nrh12gsR7Ne3zKSC7DU534dVI0U5blELUxqin
         hspKW5G1z+hM1SzQZ+MRFO4FJs8j3qEZol209NNdVOR72ZLpb1Z5ocHKvOdCmvDvGcs/
         bhDsSl10QAfrmrThJhtD6HYer3hA+oN0sDAA3kod+Z6DZy3ksgbQnwwlnkSYMw6VPONY
         GyfA==
X-Gm-Message-State: AOAM530ClGYALI+v8Z5LGqzKV0G4RG9qBfPX9vdTuMt+aCncQYsELs2X
        I0odWttztJGqPdq/PkJVfXEoowZO/zS4CSVlxY1VSeujv238JVR8gOhR3hgn5KotODggcBez+JV
        wRUMSfWzobU7RU3pH8LkbQGj9ts5JvW/FV/X1
X-Received: by 2002:a17:902:e2d3:b0:15f:249c:2002 with SMTP id l19-20020a170902e2d300b0015f249c2002mr11088907plc.159.1652322856314;
        Wed, 11 May 2022 19:34:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9LkeoNzgkhvJe2G/nNW6B61+lIVcB9AUrQUpNwSPTqFnrd5nuO38SjXptMGMSRgAnNekqVQ==
X-Received: by 2002:a17:902:e2d3:b0:15f:249c:2002 with SMTP id l19-20020a170902e2d300b0015f249c2002mr11088880plc.159.1652322856077;
        Wed, 11 May 2022 19:34:16 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id q10-20020a170902f34a00b0015e8d4eb1d8sm2551452ple.34.2022.05.11.19.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 19:34:15 -0700 (PDT)
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
Subject: [PATCH v7 3/4] arm64: kexec_file: use more system keyrings to verify kernel image signature
Date:   Thu, 12 May 2022 10:34:01 +0800
Message-Id: <20220512023402.9913-4-coxu@redhat.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220512023402.9913-1-coxu@redhat.com>
References: <20220512023402.9913-1-coxu@redhat.com>
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

