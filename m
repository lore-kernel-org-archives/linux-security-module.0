Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DCC3CCA473
	for <linux-security-module@archiver.kernel.org>; Mon,  4 Jul 2022 01:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbiGDBxP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 3 Jul 2022 21:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiGDBxD (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 3 Jul 2022 21:53:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E6C964FD
        for <linux-security-module@vger.kernel.org>; Sun,  3 Jul 2022 18:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656899576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sd8cjBSOdeaVjyH4f3lxl+0xYw15nzSjwpJw6bzSgLk=;
        b=RSFnfqS9sfBO3KyufXMdhkgYE6J/y0DKoBoeurHoCal5oubM35VrEP5Rl80BdkTNtKtdJp
        hO4Sw7zFgeuYZNmgX+8j6xJkOcAXYKMSUcuxvwP9z2sWibS8Yeb9psr6QiavjhPi9iDwFh
        RELl+2ZyiCx2hNWt0DF4rPBrFf5dmeA=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-414-E_KfRV6bONKSUr3m-8mCuQ-1; Sun, 03 Jul 2022 21:52:55 -0400
X-MC-Unique: E_KfRV6bONKSUr3m-8mCuQ-1
Received: by mail-pj1-f69.google.com with SMTP id q4-20020a17090aa00400b001ef76cb4749so2820956pjp.3
        for <linux-security-module@vger.kernel.org>; Sun, 03 Jul 2022 18:52:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sd8cjBSOdeaVjyH4f3lxl+0xYw15nzSjwpJw6bzSgLk=;
        b=vQBE6XWaQDUfZdHBSs/46bgSV3baZM650lP4u8f/qtQhwyHVWg5JZQqWBvBxclpJOb
         i4SqJdWFmDaMVYxmiJmQXH3rB5VaH7SyDWHb5oKlApDxpX5vT0ZnlYfkFANvSPiiKzvy
         s19mmgb2KbJspNMGeybvWn89N79gMmZDLb48EzOhLwvkUZOm4ZPZpD4DwIJvZrhd7maQ
         zGL+DKJ+bHOlAnz/j2D5dww7yHkBKxamHMgzHBTHFRVBucY9mwcUWYWLEh0/P3y6WcmM
         7TLo7wxkeqAV7dL1Q9ubZ1913m33J8hCIp1Jd1AU2s6k7njdNoVnG9Uk/aa7F60G9x+W
         402g==
X-Gm-Message-State: AJIora/c2oVq3uYahiGAkcb4jN+t+ZjRrVhwWQapWCiETz2GIMovPcGJ
        l+4sAJFtSx7IvfoiuTOWu9BSEb6P9RQOTjt7b5hbqx4y1IGElXg+gMIaK58mz+tLvD+rUN1SiyG
        1HeyhtDgNpg07C6FJk2tot0IgVoiA9Ln4gK+C
X-Received: by 2002:a17:90a:1485:b0:1ec:788e:a053 with SMTP id k5-20020a17090a148500b001ec788ea053mr31016130pja.16.1656899573984;
        Sun, 03 Jul 2022 18:52:53 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u8Sm73HYl29mcEbEmk3Z6a37A8y2OdP5f3idLICxDPGrBoxyTSHxhDRsHAFrxMwDkh5wCuzQ==
X-Received: by 2002:a17:90a:1485:b0:1ec:788e:a053 with SMTP id k5-20020a17090a148500b001ec788ea053mr31016116pja.16.1656899573776;
        Sun, 03 Jul 2022 18:52:53 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id p2-20020a1709027ec200b00168f08d0d12sm16841927plb.89.2022.07.03.18.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 18:52:53 -0700 (PDT)
From:   Coiby Xu <coxu@redhat.com>
To:     kexec@lists.infradead.org, linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        linux-arm-kernel@lists.infradead.org,
        Michal Suchanek <msuchanek@suse.de>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Chun-Yi Lee <jlee@suse.com>, stable@vger.kernel.org,
        Philipp Rudo <prudo@linux.ibm.com>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-s390@vger.kernel.org (open list:S390),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v9 4/4] kexec, KEYS, s390: Make use of built-in and secondary keyring for signature verification
Date:   Mon,  4 Jul 2022 09:52:01 +0800
Message-Id: <20220704015201.59744-5-coxu@redhat.com>
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

