Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C6D8C433EF
	for <linux-security-module@archiver.kernel.org>; Fri, 20 May 2022 15:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351067AbiETPpv (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 20 May 2022 11:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351053AbiETPpk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 20 May 2022 11:45:40 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A6617995C
        for <linux-security-module@vger.kernel.org>; Fri, 20 May 2022 08:45:26 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id a23-20020a17090acb9700b001df4e9f4870so8209680pju.1
        for <linux-security-module@vger.kernel.org>; Fri, 20 May 2022 08:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=5TWBcQL6wNB9LxLHrCP8/TqxtjURhSYJy0/t361wYQU=;
        b=c4yOuQVg7fx9koZWMZRlxpoboAwjwiDzPiwKBiWegfHXXsuU2piqdAdZvKOlVL3wY3
         UyMVdqIEVjbV1MmgqqqPhWFWRYk+bwhWi3TkpDv7o5K0YMkwc2c02fWRsbHrFdFzgmc/
         DLCeupy+iNJUpjyqYR4JeQBFPDjmxJXZ6WuV96Z/KK2rf4fz8KRM7VUPEfZqSILfpstt
         Q93Pbbx+e/CkwcfH5kHA9LYQWUOunWsskcKvraNycowPS7MwBNFLKoTqCaCh2XphgH0+
         vJzeQDisWHO7I9qWBsQtNc8D/rVzeLhSaBVt5S0CGzQ2juEt6+b5bBLTQFftgGxZVBOb
         xF9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=5TWBcQL6wNB9LxLHrCP8/TqxtjURhSYJy0/t361wYQU=;
        b=glLn81ks0EtqZthZm44aagKcHnFXMOc7qgqQP9JFGNAPYDKLbOdbF7iq1ImCFrpPfb
         kwAFCh/KVMt11QD6so7K6HfYaD/uJOndjEr2zHIkPbHD06qW7HlxC4cMyHP0zVajTMcv
         kFQ9qoOKXrD/g2WPA/hCDs1tmOJML6B6qWKPU+kxnUClhONTFjIRsE1kUNacV07/uoUJ
         MKJICDBYGlYesIWiQ8fYeATJo9ctm0VrZFAwCCOxBOo/ZHwr1x7PGJ7kQHILVcuPvz8c
         qrAtwLH0OrbA+DLXQlBKJkP+msebByqPJOTKVfHybaL1V6u+2wkwKj0lXPTyZU29vhx6
         YW3w==
X-Gm-Message-State: AOAM530uVKs4CvrahetGIeTUm81tlpy8+Sg+MjsCZEszeM/6BqTZourD
        rvhh+6Nhka6yCRu63/9fSmErBA==
X-Google-Smtp-Source: ABdhPJyPOaFhKw7lv1sn4i4AHPP0QtokVuzUJUfKGEWZJSnPqbVu1QCImrf5yMwt/D4DDEzAf6OhTw==
X-Received: by 2002:a17:903:108c:b0:161:e5a5:e387 with SMTP id u12-20020a170903108c00b00161e5a5e387mr6866867pld.108.1653061525601;
        Fri, 20 May 2022 08:45:25 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id l17-20020a170902eb1100b0015e8d4eb239sm5936919plb.131.2022.05.20.08.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 08:45:25 -0700 (PDT)
Subject: [PATCH v1 2/5] ima: Fix a build issue on 32-bit platforms
Date:   Fri, 20 May 2022 08:44:28 -0700
Message-Id: <20220520154430.18593-3-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220520154430.18593-1-palmer@rivosinc.com>
References: <20220520154430.18593-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        robh+dt@kernel.org, frowand.list@gmail.com, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        liaochang1@huawei.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux@rivosinc.com,
        Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     lizhengyu3@huawei.com
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Palmer Dabbelt <palmer@rivosinc.com>

ima_dump_measurement_list() took an "unsigned long *", but was passed a
size_t.  This triggers build warnings on 32-bit RISC-V.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 security/integrity/ima/ima_kexec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 13753136f03f..f2a94ec3002a 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -15,7 +15,7 @@
 #include "ima.h"
 
 #ifdef CONFIG_IMA_KEXEC
-static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
+static int ima_dump_measurement_list(size_t *buffer_size, void **buffer,
 				     unsigned long segment_size)
 {
 	struct ima_queue_entry *qe;
-- 
2.34.1

