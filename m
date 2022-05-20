Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D54DC433FE
	for <linux-security-module@archiver.kernel.org>; Fri, 20 May 2022 15:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351079AbiETPpt (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 20 May 2022 11:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351031AbiETPpl (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 20 May 2022 11:45:41 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447D717996F
        for <linux-security-module@vger.kernel.org>; Fri, 20 May 2022 08:45:28 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id c2so7699711plh.2
        for <linux-security-module@vger.kernel.org>; Fri, 20 May 2022 08:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=U/MW6rSbN5zBgusIBhKQzePh9cnp8uaNotWlLIHTUsY=;
        b=JQyzbPvORX1IKsTlWc0qkUHSKntueefkGU8dfB3thfUfkSYRjG91vooo6vChrw9Bf7
         9Z5XY/rjVuwzsrlkQA5pcgEYx+QnJKtt5nmCn9DhLAdeLEqucw8pOG8J12o96ngdNp5g
         itgIArPjfmV3PmE0JpQd4a+cAR95KxK2BRwn0m7OypbO/75j+MGw0tQDgXO551FebRyN
         04wS/DqNscTUoNHtWgoitV/Yu0wzpeaqdS7LdRbwE65wXveDL69cHyxRiC2N2xewmWjM
         UTbLdEVcVlOT/o6zIiNUwcdDEW8akpNDod5tvoD9ZEXINE7/RJScDiChs8rEREGK9MC4
         rYKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=U/MW6rSbN5zBgusIBhKQzePh9cnp8uaNotWlLIHTUsY=;
        b=Dr1VZKbYlKW0JGAS0q5s9L3r8b9uegeCLylz49zYPVgLprGgoTKiNBndrMZCtXlxTs
         5CgG1VBZhtukebuMPm4MY6mvIU73oUcwxHJNf2K6XzdMpkWbp356B3jI/iqJIu5uJgPP
         XkOldkoMav7kDFY7S6XoTrbCvMLijE0QDTlxdR8uHmFFu+VcjK5W2z62iVSTauP6p1hr
         SAzjR+qqWUW5WnfY9VTk/bkbH9WeXs4hycpftNIhdWpJwLbqhTWUTjb7eMzv2eGaRVR+
         4+RFjSK7MU6/pWPaE7+O7Doa3AANLdkk7+LnEtFUkYJ5RTQo9er4OkqPoSO99n0D2Y9J
         r8DQ==
X-Gm-Message-State: AOAM531wXFRnLV1CSB1Eccka2RCWow73wYlDvDn7Kyuj20L8e2N8Wd4P
        soUov3cCJLH1Qk8ybGhX2HiZYA==
X-Google-Smtp-Source: ABdhPJxcVY/NCwkycro4XerYgWAVjh079yzImy34/DKN8DSXqYHS1KYB9wqnCW7AFPycA9lFB2mEsg==
X-Received: by 2002:a17:902:7788:b0:15e:ec55:2cfd with SMTP id o8-20020a170902778800b0015eec552cfdmr10405450pll.113.1653061527803;
        Fri, 20 May 2022 08:45:27 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id p11-20020a17090a4f0b00b001df78f27c10sm2091006pjh.42.2022.05.20.08.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 08:45:27 -0700 (PDT)
Subject: [PATCH v1 4/5] RISC-V: purgatory: Use XLEN-length loads to support rv32
Date:   Fri, 20 May 2022 08:44:30 -0700
Message-Id: <20220520154430.18593-5-palmer@rivosinc.com>
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

This uses an explicit "ld" to load up target address, which dosn't work
on rv32.  Convert it to a REG_L macro, like everywhere else.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/purgatory/entry.S | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/purgatory/entry.S b/arch/riscv/purgatory/entry.S
index 0194f4554130..71c50fef051c 100644
--- a/arch/riscv/purgatory/entry.S
+++ b/arch/riscv/purgatory/entry.S
@@ -8,6 +8,8 @@
  *
  */
 
+#include <asm/asm.h>
+
 .macro	size, sym:req
 	.size \sym, . - \sym
 .endm
@@ -26,7 +28,7 @@ purgatory_start:
 	/* Start new image. */
 	mv	a0, s0
 	mv	a1, s1
-	ld	a2, riscv_kernel_entry
+	REG_L	a2, riscv_kernel_entry
 	jr	a2
 
 size purgatory_start
@@ -41,7 +43,7 @@ size purgatory_start
 
 .globl riscv_kernel_entry
 riscv_kernel_entry:
-	.quad	0
+	REG_ASM	0
 size riscv_kernel_entry
 
 .end
-- 
2.34.1

