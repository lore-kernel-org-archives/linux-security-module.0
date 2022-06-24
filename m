Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F331ACCA473
	for <linux-security-module@archiver.kernel.org>; Fri, 24 Jun 2022 04:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbiFXEui (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 24 Jun 2022 00:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbiFXEsc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 24 Jun 2022 00:48:32 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1EC69988
        for <linux-security-module@vger.kernel.org>; Thu, 23 Jun 2022 21:48:30 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id r66so1369765pgr.2
        for <linux-security-module@vger.kernel.org>; Thu, 23 Jun 2022 21:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=4THMhvS8M5ZnFTHvTFejhkWhYsuAvg/ZgzsYmQOutl8=;
        b=jZ+UoLM3M7Aw8FzFUs4vfV0xGVF+Z1rgG06Q0g6ddvpteFSUct4m0aAnWG/UHlIHcy
         xDIWATlB0GGjs/hfRkxe6UQ1V4kDs2Fm3V/6fxpXi023MU/ojZBBXm7JW8wCFWafwRbY
         ZPHpdFFCz4HQaws9xVkBWt/pnD6GgEBKfUCt/XZPKwwH8Eji0UWJl8bjjLOYO2Km/VcU
         riLaGCyFAc2cIrl3N/VncOYPKf8urgmhHUYRlJWR81bCqV+fn5a5+P3hY9dVVfzj35qZ
         3V3zmkqcGPJtvORY1fF7FSMecx1wrSvXDD/7UYn08WWFqdnoryi8KMch/00RWyQK0gLR
         DpLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=4THMhvS8M5ZnFTHvTFejhkWhYsuAvg/ZgzsYmQOutl8=;
        b=RUg8K6/rHRaikskKxshlK00fcpyTXt5OzE1fZYBmfKQ12GHmDdiJlhsLTOIN2dv+0a
         CEzonHfHX0kimJGeIK4kZgKeoJ5wNeVWd/oGMF7IXKA9zMz1S9/FDCEoTaTzujYleAhn
         U/r8BSeJzbzzGLRBYs57OCQLZ1w8O0B1ndD8SIqWx/jbpe/FW+V5al/RMgvowey4F7Ep
         USGbtd39tbZNrK+R75/mQvFO+pwIZ3sU0IPUYbOz0Ji5Z2bx0njgJNYkw6be8wDtiDqH
         gGf0IyAX+Lg5VZS7zAVdlq4L0LUDH0aUFs6HzQMSsy6oQDd4zajCWph3zJjcWGANEH/I
         ueJw==
X-Gm-Message-State: AJIora8/V8YN+e6s3/B5twsqMXyoX1gSde5qkHN2k9JukDxP/SXoVAth
        07L8tWu3OqTIaFxR1aQKwSP8YQ==
X-Google-Smtp-Source: AGRyM1tjG9XTGQzrvxKP1b0oJm9GIdXwYRdfAbtw1YGd6ry6SLMEHPonI2hZnL7q9k/q2Z13VDkRjA==
X-Received: by 2002:aa7:9206:0:b0:525:1068:c026 with SMTP id 6-20020aa79206000000b005251068c026mr31366064pfo.52.1656046110313;
        Thu, 23 Jun 2022 21:48:30 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id k26-20020aa7821a000000b0052517150777sm555865pfi.41.2022.06.23.21.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 21:48:29 -0700 (PDT)
Subject: [PATCH v2 5/5] RISC-V: Allow kexec_file() on 32-bit platforms
Date:   Thu, 23 Jun 2022 21:48:11 -0700
Message-Id: <20220624044811.9682-6-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220624044811.9682-1-palmer@rivosinc.com>
References: <20220624044811.9682-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
            linux-security-module@vger.kernel.org,
            Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        linux-integrity@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

With the build issues now sorted out we can enable kexec_file() on
32-bit platforms as well.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 898052ff743e..a246f2fe60c2 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -388,7 +388,6 @@ config KEXEC_FILE
 	select KEXEC_CORE
 	select KEXEC_ELF
 	select HAVE_IMA_KEXEC if IMA
-	depends on 64BIT
 	help
 	  This is new version of kexec system call. This system call is
 	  file based and takes file descriptors as system call argument
-- 
2.34.1

