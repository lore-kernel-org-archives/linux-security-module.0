Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7ECC433EF
	for <linux-security-module@archiver.kernel.org>; Thu, 14 Apr 2022 01:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239489AbiDNBrE (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 13 Apr 2022 21:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239491AbiDNBq6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 13 Apr 2022 21:46:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 84DB3B840
        for <linux-security-module@vger.kernel.org>; Wed, 13 Apr 2022 18:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649900671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jXalVENl364WLU242Jde+1X/Q2QKLGjlQWD5km644gM=;
        b=dHkS40RNFUzOrPrb7w93W/sr/DkTsTDKocCkA+naT5lWAuFlcrDg3uVUBz2HB77CZjAekG
        YDfVJSYeqTZQN3Gtt0YtSGsxzqh/I1FpiTwLf6SUt7NUuMYh1llxaAk8Ii9zziRt5B0Oe5
        QwC0DvKyV8Tj06KnkXVLJnvavkjt+Kw=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-383-XtN-GDZJMryQKNdoGiOqUQ-1; Wed, 13 Apr 2022 21:44:28 -0400
X-MC-Unique: XtN-GDZJMryQKNdoGiOqUQ-1
Received: by mail-pl1-f200.google.com with SMTP id w14-20020a1709027b8e00b0015386056d2bso1992313pll.5
        for <linux-security-module@vger.kernel.org>; Wed, 13 Apr 2022 18:44:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jXalVENl364WLU242Jde+1X/Q2QKLGjlQWD5km644gM=;
        b=pdWBxjpVv07HIEwu3RTwBfeZK2LSw2NEbLke8Pn/RFXDjLRt4gZWkB6hKQIWnQsTWF
         NR5WXL9tDtYXhqPB7IoPVhJ+C2Y91fIzc5XrHnQ4Jpcp4v6Rf++Ol0fCvVtmrMRDPmdS
         i1QFv30Izdb/3wFADamWhR0IiDOcA7Dba4i7z5wdCb5czGCNNHM2UEuKOFiIM9GR/aVM
         leKjoM4mDAG51qTD4YkkGihG1sMcZ/X+JDBySRYumaVKKRnkfEpua+vi9SiZpoGqfGAe
         R2vxTx01gbzMjOFlolmc4IRxWrY6VOvJX4tqx//Nj13y2yqADUWvog3q9CbiSXWIQi52
         PUwQ==
X-Gm-Message-State: AOAM533D/zAVfM9dU5QHEHgTPy4C6XSGDic/9zXt3V9JutLaje8GF5Y6
        PlDtX0NvTtFwW9gkvgirkCdWNvDRwNTVoZDXYiTDrL4eFsexZYj4JmSIHBqPeniHocXN/y3nZ4m
        f/shx9PeLw+mqVVppwiNkLwid7C1r+zHRxG0k
X-Received: by 2002:a17:90a:1d0e:b0:1cb:50ec:27f with SMTP id c14-20020a17090a1d0e00b001cb50ec027fmr1691266pjd.195.1649900667474;
        Wed, 13 Apr 2022 18:44:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7lvJcRtRvT6UTIGdqLIQ5fotL6BdwS5zyMoazeF5Hq+0VgXvKq4yRZVC76yYSbM5z2e4jXA==
X-Received: by 2002:a17:90a:1d0e:b0:1cb:50ec:27f with SMTP id c14-20020a17090a1d0e00b001cb50ec027fmr1691236pjd.195.1649900667213;
        Wed, 13 Apr 2022 18:44:27 -0700 (PDT)
Received: from localhost ([240e:3a1:31c:360:52fc:c968:cb41:efbc])
        by smtp.gmail.com with ESMTPSA id k25-20020aa790d9000000b00508232aecedsm332618pfk.67.2022.04.13.18.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 18:44:26 -0700 (PDT)
From:   Coiby Xu <coxu@redhat.com>
To:     kexec@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Michal Suchanek <msuchanek@suse.de>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Mimi Zohar <zohar@linux.ibm.com>, Chun-Yi Lee <jlee@suse.com>,
        Philipp Rudo <prudo@linux.ibm.com>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, stable@kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-s390@vger.kernel.org (open list:S390),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 4/4] kexec, KEYS, s390: Make use of built-in and secondary keyring for signature verification
Date:   Thu, 14 Apr 2022 09:43:44 +0800
Message-Id: <20220414014344.228523-5-coxu@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220414014344.228523-1-coxu@redhat.com>
References: <20220414014344.228523-1-coxu@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=coxu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: application/octet-stream; x-default=true
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Michal Suchanek <msuchanek@suse.de>

commit e23a8020ce4e ("s390/kexec_file: Signature verification prototype")
adds support for KEXEC_SIG verification with keys from platform keyring
but the built-in keys and secondary keyring are not used.

Add support for the built-in keys and secondary keyring as x86 does.

Fixes: e23a8020ce4e ("s390/kexec_file: Signature verification prototype")
Cc: Philipp Rudo <prudo@linux.ibm.com>
Cc: kexec@lists.infradead.org
Cc: keyrings@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Cc: stable@kernel.org
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>
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
2.34.1

