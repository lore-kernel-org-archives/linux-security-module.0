Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675B6CDB47E
	for <linux-security-module@archiver.kernel.org>; Wed, 18 Oct 2023 21:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjJRVun (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 18 Oct 2023 17:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjJRVum (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 18 Oct 2023 17:50:42 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7E7EA
        for <linux-security-module@vger.kernel.org>; Wed, 18 Oct 2023 14:50:40 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-7b6f67c708eso248613241.1
        for <linux-security-module@vger.kernel.org>; Wed, 18 Oct 2023 14:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1697665839; x=1698270639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=12ZNiADi9ssycDc+bEPaWkSEvy1cOSFuVIyjqybmu+o=;
        b=HXedCzt7sjj0Uvg71jVr0TPB+kCLGpfdZv2guCIE9QCizpzf5NxtQ1EK5ZykfQ+bJr
         MT3HFcgOQ22cxytQ1ZFtYSTTOPCF90X4qXVwyG1Jry1/zaDXs65gBvRcYKwgi+H4JByp
         WiettwTmuoIUjYTU+YJKuDhVJOa0uWFCTvil6DlS5Gz56Iru0eFNC95n7hJeQZ7+fhYV
         uNR3GAanAINni7LP0HoZeUGxeHW5ZweO6gy8kXYs3yjiN5gleTnvrvcvOGoYXXWBwaWc
         7OOqfAbFX5iUP87DJVvtTXhP9S2E6e9YIWNPLA16AVYK/Vhl1VLFqvH5NWqs8MARAFil
         LWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697665839; x=1698270639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=12ZNiADi9ssycDc+bEPaWkSEvy1cOSFuVIyjqybmu+o=;
        b=VlM84hKZ/FNOUYIYVMFMEwZgZmtUDMvLXAkxKc/ZfXfJ48H+2y4cYDPZNJ97oqaSOY
         asWq/MHKF4aE0eaEnyUFwpyYOQ606sm2yKBKQSwxkriz9SQ44gugyY9S0FjTSLDDuncK
         aIYq7uMYrGV592rTRxcXcC0+tBxtyeXHvUepagR9lqsGmj//18Q/uPzNed41m2WQwDfE
         I/Y1aKtVgN8B33QwUGnmceWz1oKG1vg2bL7ZOqyut33WUxVC/kfcuM4FI2aKLyI9gKSy
         u8/iO9fcO730Gmu7ICNVlZbFg51RBdeh/ZFNbFeZZTb31DGlfI8P0HDpnltj5RQPvyny
         ETHA==
X-Gm-Message-State: AOJu0YyuUb4ka0tClfjUcmWia2efFfk+Jfkm9PAM5QObdgDt4M96aBDh
        w/nHC2/sEd6aieh+XmEeDHIaoiLljxZkZIqJdA==
X-Google-Smtp-Source: AGHT+IFcnhlYvlKc17O51i9NmbkjiAPpNhS4zHkGLvXtoBkCKNKpykALrDpJOPxlLIRSOdFEPmVXsw==
X-Received: by 2002:a67:a406:0:b0:457:bc5f:b4a8 with SMTP id n6-20020a67a406000000b00457bc5fb4a8mr292269vse.28.1697665839210;
        Wed, 18 Oct 2023 14:50:39 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id kq11-20020ac8618b000000b00419b094537esm255833qtb.59.2023.10.18.14.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 14:50:38 -0700 (PDT)
From:   Paul Moore <paul@paul-moore.com>
To:     linux-security-module@vger.kernel.org
Cc:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH] lsm: drop LSM_ID_IMA
Date:   Wed, 18 Oct 2023 17:50:33 -0400
Message-ID: <20231018215032.348429-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1173; i=paul@paul-moore.com; h=from:subject; bh=XJE3jNOfcjc5EO090HhJGrkcvGkKQP/Whdd/3qhf1FQ=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBlMFMoiYtUYkaNz1u3iH2zVCjBpR+JD4JLEMCve 7IkUeUX2Y6JAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZTBTKAAKCRDqIPLalzeJ c8ggD/9koF+7//2pdtYUBDdBXvpXSn53ItP6uLqTuI5hEV2mJVsZ9b16q4JYtkxC8IhtUxnUwvm Z4RZP2HWRiz6M8BtCoqB2me09drjW6NL8nnDNr8r/PXRz1phBmbPtEsvSE090e83D+Y2IUh2Zv9 0BASHlF6jOsV9bvxD4L4Jn6UYD0pzEAuvqQCe+Ge2lAn6K8bjeKa7mkcMgcAFoshMLR+nIu/x7k a2cfH3al1P1PJCFb3ab1OIUvtnvpncW2ul342zsZjTjt5puv9TE/THpVlskYo+vwD42t17XlfGx XmERwdF/x88fLVmMkTRsVoyHLIDEI4LQU/yNMPBY8Q2N9r3KXDU+98WIcSqIsfYb9dk2oTtilVk 2+WkOrspINmA+YEqUNFepiVznutopJd5ihIBNsy8lQt4WgYRrxHT7voVG8rPV4fjw3rArdPxSIv gwgH8vPQf0fsxGtyezGYFo7cEEIcjwc6uQ17dQgyeS2OU2zDLoajsRaF18Erh9e1//h6hSP2KEd pNtHi1xgcIrKYdB/kSRLQRpGOL7+K+cnKttb25r/gkzvQC4B45Iqd74V5nnPxh5nCH5x1tI1Gk4 pIAR9tevOllkk1FtwWqVm/wQCOGPp3cjcg+rI1rPZCmUEsK4GBQphwFasXNuNNUW3hZEmfXywya 9upGlaCk22XsPmA==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

When IMA becomes a proper LSM we will reintroduce an appropriate
LSM ID, but drop it from the userspace API for now in an effort
to put an end to debates around the naming of the LSM ID macro.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 include/uapi/linux/lsm.h | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
index eeda59a77c02..f0386880a78e 100644
--- a/include/uapi/linux/lsm.h
+++ b/include/uapi/linux/lsm.h
@@ -54,14 +54,13 @@ struct lsm_ctx {
 #define LSM_ID_SELINUX		101
 #define LSM_ID_SMACK		102
 #define LSM_ID_TOMOYO		103
-#define LSM_ID_IMA		104
-#define LSM_ID_APPARMOR		105
-#define LSM_ID_YAMA		106
-#define LSM_ID_LOADPIN		107
-#define LSM_ID_SAFESETID	108
-#define LSM_ID_LOCKDOWN		109
-#define LSM_ID_BPF		110
-#define LSM_ID_LANDLOCK		111
+#define LSM_ID_APPARMOR		104
+#define LSM_ID_YAMA		105
+#define LSM_ID_LOADPIN		106
+#define LSM_ID_SAFESETID	107
+#define LSM_ID_LOCKDOWN		108
+#define LSM_ID_BPF		109
+#define LSM_ID_LANDLOCK		110
 
 /*
  * LSM_ATTR_XXX definitions identify different LSM attributes
-- 
2.42.0

