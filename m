Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B615C433EF
	for <linux-security-module@archiver.kernel.org>; Thu, 12 May 2022 02:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242107AbiELCe0 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 11 May 2022 22:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242330AbiELCeY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 11 May 2022 22:34:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C17C7135680
        for <linux-security-module@vger.kernel.org>; Wed, 11 May 2022 19:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652322861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sd8cjBSOdeaVjyH4f3lxl+0xYw15nzSjwpJw6bzSgLk=;
        b=eW/WXFsONWaCXGf47nxy8+6ULaKuwwgxNhN6zaZDIHM1aQfZ+H3kCE2oczc4HQsl73LnHx
        QauzWCZbubfD1B+elr3HiU4rD44Ps+xxONKKpaKKzh7s9LGMNGl3CZ7lRfcxtZxIYpSOvM
        g11qPzhb9YncynlwlfrIDvTZEoAcrVQ=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-658-hQZQkWvdNTGnkKUhm8lKYQ-1; Wed, 11 May 2022 22:34:20 -0400
X-MC-Unique: hQZQkWvdNTGnkKUhm8lKYQ-1
Received: by mail-pl1-f199.google.com with SMTP id b10-20020a170902bd4a00b0015e7ee90842so2004667plx.8
        for <linux-security-module@vger.kernel.org>; Wed, 11 May 2022 19:34:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sd8cjBSOdeaVjyH4f3lxl+0xYw15nzSjwpJw6bzSgLk=;
        b=qHByabBpUNnlSN4KlmU5bH89xVkL1/fVJ+Gttj8PkGrDm8guqPLE7GF1naLl2WEJjm
         mlLIW1gHwRZrwbIrtLSVVv+xmYwtsBd3+OQfWIh7Inlmw6on9J7ZxicX7sEgBUVNrux+
         hk9oRD1XgicbnnMUVTHKeqnxGG5FSiZDfLrAvP6GvqkSyC/tLMdXS28cROhS/zF282Cs
         1Wx7y4r5rnYyx6Ct6hmRiFY+HKvcbqIv3i5rAOMJorHCO3HCoIxzUqdMBHgBtzz7uOEI
         LLtqwSgYEOpgRMvTcPhpCCc0e2Z1bQu1j5PZKrUO7shbwu55MGZxvV8ziSjaV3KjXl67
         rXjA==
X-Gm-Message-State: AOAM531+rdjaTAt+9e0F+JCl+Xj6wf7Ak90uAYSDVvPeJyQoM5/sVtR5
        s4/ZoSNs5wb1/iSDpDJFX0Vi9P8cRrthaQJNuOcSa76GoD5eRlGnMt06ybjlRp0iCVAHB+AdCCx
        Jn0ApA1C68pDQx7QKFCcsnPyLExt3Lsx/uC4U
X-Received: by 2002:a17:902:a988:b0:158:9877:6c2c with SMTP id bh8-20020a170902a98800b0015898776c2cmr28267065plb.80.1652322859736;
        Wed, 11 May 2022 19:34:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyH1llvd8fk2D0SYmSmCKYC9uAr2o+Ctxa0UAZPqI0TRSxNPoWV0eswyAEUVKhnU6msW55asw==
X-Received: by 2002:a17:902:a988:b0:158:9877:6c2c with SMTP id bh8-20020a170902a98800b0015898776c2cmr28267045plb.80.1652322859494;
        Wed, 11 May 2022 19:34:19 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id b15-20020aa7810f000000b0050dc762812dsm2464432pfi.7.2022.05.11.19.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 19:34:19 -0700 (PDT)
From:   Coiby Xu <coxu@redhat.com>
To:     kexec@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Michal Suchanek <msuchanek@suse.de>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Mimi Zohar <zohar@linux.ibm.com>, Chun-Yi Lee <jlee@suse.com>,
        stable@vger.kernel.org, Philipp Rudo <prudo@linux.ibm.com>,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-s390@vger.kernel.org (open list:S390),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v7 4/4] kexec, KEYS, s390: Make use of built-in and secondary keyring for signature verification
Date:   Thu, 12 May 2022 10:34:02 +0800
Message-Id: <20220512023402.9913-5-coxu@redhat.com>
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

From: Michal Suchanek <msuchanek@suse.de>

commit e23a8020ce4e ("s390/kexec_file: Signature verification prototype")
adds support for KEXEC_SIG verification with keys from platform keyring
but the built-in keys and secondary keyring are not used.

Add support for the built-in keys and secondary keyring as x86 does.

Fixes: e23a8020ce4e ("s390/kexec_file: Signature verification prototype")
Cc: stable@vger.kernel.org
Cc: Philipp Rudo <prudo@linux.ibm.com>
Cc: kexec@lists.infradead.org
Cc: keyrings@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>
Acked-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 arch/s390/kernel/machine_kexec_file.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
index 8f43575a4dd3..fc6d5f58debe 100644
--- a/arch/s390/kernel/machine_kexec_file.c
+++ b/arch/s390/kernel/machine_kexec_file.c
@@ -31,6 +31,7 @@ int s390_verify_sig(const char *kernel, unsigned long kernel_len)
 	const unsigned long marker_len = sizeof(MODULE_SIG_STRING) - 1;
 	struct module_signature *ms;
 	unsigned long sig_len;
+	int ret;
 
 	/* Skip signature verification when not secure IPLed. */
 	if (!ipl_secure_flag)
@@ -65,11 +66,18 @@ int s390_verify_sig(const char *kernel, unsigned long kernel_len)
 		return -EBADMSG;
 	}
 
-	return verify_pkcs7_signature(kernel, kernel_len,
-				      kernel + kernel_len, sig_len,
-				      VERIFY_USE_PLATFORM_KEYRING,
-				      VERIFYING_MODULE_SIGNATURE,
-				      NULL, NULL);
+	ret = verify_pkcs7_signature(kernel, kernel_len,
+				     kernel + kernel_len, sig_len,
+				     VERIFY_USE_SECONDARY_KEYRING,
+				     VERIFYING_MODULE_SIGNATURE,
+				     NULL, NULL);
+	if (ret == -ENOKEY && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING))
+		ret = verify_pkcs7_signature(kernel, kernel_len,
+					     kernel + kernel_len, sig_len,
+					     VERIFY_USE_PLATFORM_KEYRING,
+					     VERIFYING_MODULE_SIGNATURE,
+					     NULL, NULL);
+	return ret;
 }
 #endif /* CONFIG_KEXEC_SIG */
 
-- 
2.35.3

