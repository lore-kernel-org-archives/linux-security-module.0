Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363C2C433F5
	for <linux-security-module@archiver.kernel.org>; Fri, 20 May 2022 15:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351100AbiETPpm (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 20 May 2022 11:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349477AbiETPpk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 20 May 2022 11:45:40 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4917179949
        for <linux-security-module@vger.kernel.org>; Fri, 20 May 2022 08:45:24 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id h186so8055095pgc.3
        for <linux-security-module@vger.kernel.org>; Fri, 20 May 2022 08:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=avELjSEfO4YwxdS1hy2OFqCYNIZpTM4Eec2OkZMhhf8=;
        b=uzwPDcC0XNDiwV+Mifx3alyGqhvqonpDCfcELm9PIplNCWzW/NqPcz7dO5AZvP9aD/
         9DftJ2uI7dj8WLDMyULQL9Mzmc1Sw3yvKBYHDYFq5mmlt9/FBMk4iD2EQWZueEc2SOPY
         XVhWu4TTcLkAOsWufKOvZedwA75506ErlcRUoG/dg5Yzf/7w2VdM2e5A3R0RG/jQrebr
         WUB0GKOJ4kmaKKnMV38ouro+kV5lD5ureu3IhSzvLXkIPBO/tOcRZZnJcLQKaOJ4pIFD
         ivVBRmb/1LPO2IfDj8CG9AXLvr+6Wf30+Cf7gop/trMMi003rY5ezCy3QBoYTgXe1rFB
         h7JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=avELjSEfO4YwxdS1hy2OFqCYNIZpTM4Eec2OkZMhhf8=;
        b=xLwk1VMfRo4OA+PBeSdxIvzB4dcQrgGia05FuoSdjqCgW5qyDwmDk9XB9krlav5usT
         0Ir5usz9WUjOy/+OVGrZR6bzP4386qmNDP43L+t9CAgJE7jLuFosyhL1zDLm1tN4qcZ0
         lS2TLrgxdGr9vE097i054MDnfmNj8yL7Lc9pnq4DdG7tIu765Fu9owjuNWSVg25Jn0L/
         em10EFMIREqaGlT7A1MN/3qwNA2LmznJqBRrbXxCrfMv8jiosnjRS4dmHCJzdGfjK8VL
         TXIR8SoCs9BBFJPr/3xzX4a0f37bcKrsEUGJ3KEHNqiHCXAdqd2zVNcN4jMcjabnd8nN
         g/7w==
X-Gm-Message-State: AOAM5337nw+uybwlWyCwmAyiWRNEyUdjh3xQAiCilxEMlOfEFWAoppAU
        Z5U1RhA9FnTXZK+BqacJ5zH0zw==
X-Google-Smtp-Source: ABdhPJy0cSSVWa5pAf0mHY5fITaZVq1V36HgsUtNvAxSOP+5C4C+/tqwdW6Q0EnMt1H6wgdEVX6jxQ==
X-Received: by 2002:a62:1413:0:b0:518:4259:200e with SMTP id 19-20020a621413000000b005184259200emr8368526pfu.41.1653061524395;
        Fri, 20 May 2022 08:45:24 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id t10-20020a17090340ca00b0015e8d4eb29esm5596985pld.232.2022.05.20.08.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 08:45:24 -0700 (PDT)
Subject: [PATCH v1 1/5] drivers: of: kexec ima: Support 32-bit platforms
Date:   Fri, 20 May 2022 08:44:27 -0700
Message-Id: <20220520154430.18593-2-palmer@rivosinc.com>
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

RISC-V recently added kexec_file() support, which uses enables kexec
IMA.  We're the first 32-bit platform to support this, so we found a
build bug.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 drivers/of/kexec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
index b9bd1cff1793..ed3451ec2b24 100644
--- a/drivers/of/kexec.c
+++ b/drivers/of/kexec.c
@@ -236,8 +236,8 @@ static int setup_ima_buffer(const struct kimage *image, void *fdt,
 	if (ret)
 		return -EINVAL;
 
-	pr_debug("IMA buffer at 0x%llx, size = 0x%zx\n",
-		 image->ima_buffer_addr, image->ima_buffer_size);
+	pr_debug("IMA buffer at 0x%pa, size = 0x%zx\n",
+		 &image->ima_buffer_addr, image->ima_buffer_size);
 
 	return 0;
 }
-- 
2.34.1

