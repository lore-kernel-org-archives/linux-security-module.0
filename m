Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74165C4332F
	for <linux-security-module@archiver.kernel.org>; Thu,  2 Nov 2023 01:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235174AbjKBByL (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 1 Nov 2023 21:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbjKBByK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 1 Nov 2023 21:54:10 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D4311B
        for <linux-security-module@vger.kernel.org>; Wed,  1 Nov 2023 18:54:03 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-7788db95652so24430985a.2
        for <linux-security-module@vger.kernel.org>; Wed, 01 Nov 2023 18:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1698890042; x=1699494842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hV60jLgzlqM8t++zfI1vUAES7I4ZPWWzMUumH8m3dGk=;
        b=XC+U2Lkb4MQiE1CFHVWPh900/346m0mMXeQQVoglyg1fK/7VFkQnUkzTjdIjRvYuKT
         hInCSj8+zJOGF5af9Y6ereEhDSxEfRwcZoMeIpR7jRNWco9nDbbx/YiAz0aPYNZFpb01
         CO0fZ96OMKyjx4xgPAszbBIYXDZACx8WiN2ldEFVrEl4+MRcT+ulbb8xjFhJ/h5AOCzC
         lDoQ+BFFcOD1Q5by48JSzZEQ8REuDmvrJeiAsf3ArJuEg40Q32xxIRJBk50hRd/IQHam
         K4T0ZETZbi2dA8NYzD+6LSI4lyE/aI+3tjb6H/IO1+Di+xArP9llFSQTOHAt3NRykJ7M
         it9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698890042; x=1699494842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hV60jLgzlqM8t++zfI1vUAES7I4ZPWWzMUumH8m3dGk=;
        b=W27vbZqWuK82xB1Db96DbbrtFfXQudGYsHFj8heawiwJTshao9xZ+L1MFx3B4iHUyy
         qeUzg3OP2XsgSIG5qBPddcpOTRsHVOBBmfiOWvSc5GdIAFPJ/UjPpx6lVVjdK/FBc/xK
         v5kGL2tIyhja+erLMhCXyp3izacoehF2SitxYvK3jtqVqB1PBXXXVJHoJlfaWydxp2WG
         s7a5jOUOUMsnY0z3lL30gVImnwFTRdMv2r5Sq2ev9JWdkD7qbXfneN0pA9Y04WbqYovf
         0/wOvCOfgD9AlTwQPwcAA2a5ChGI/qqhpsqa/1Fif0s9mj0SIUHIqApT46/PLVmC3nfc
         rCBA==
X-Gm-Message-State: AOJu0Yzs14GRWhaIII7Ovad9tg0EXppWIg5CxvIM1uMyvG6uzjiX+aRx
        xpzMAgrd6nFGrWxagbGDH3CwcJg5dDG0/BRPrg==
X-Google-Smtp-Source: AGHT+IFf4F+d0zXZ4UpPQNvQCGmf5T1gRECEOPHhAg8Map5webTauwm8azMYTKlaG8XhlDO4WfQBig==
X-Received: by 2002:a05:620a:d8a:b0:76d:4252:95d2 with SMTP id q10-20020a05620a0d8a00b0076d425295d2mr19691414qkl.39.1698890042410;
        Wed, 01 Nov 2023 18:54:02 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id x7-20020ae9f807000000b007749dc7881dsm1949572qkh.48.2023.11.01.18.54.02
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 18:54:02 -0700 (PDT)
From:   Paul Moore <paul@paul-moore.com>
To:     linux-security-module@vger.kernel.org
Subject: [PATCH] lsm: convert security_setselfattr() to use memdup_user()
Date:   Wed,  1 Nov 2023 21:53:55 -0400
Message-ID: <20231102015354.511078-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1077; i=paul@paul-moore.com; h=from:subject; bh=eyess0EqyW5zgjGi9HssZd1CdAf63RN0SVJ9wPBQORg=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBlQwEy7WFtDIzz38EfuJXH8+QLXKiXIvmzjtJB5 ItepVjwi0mJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZUMBMgAKCRDqIPLalzeJ c4IZEACozUqIXoxzlzZkXtOQ3Mnrk22hkTbZCvR4v1DfnMXL0ONfqFS0RPoyu/BiPK8/Sb0crLC pqLkiiv+RUU99lu1yQC3V+W8wpVKirPXPq9sak2iFg9C/w4FE9SQx4NHSgbrljKCD7HFDdXV9QP 78W93Dy2XgOyFvzoFeOqupDB1oTAhtPUzKRToF2fsaH7Cq/22qLT4lxgb3uKYTJd8LjA3sABQQ9 E7hlCClFUfmUw8PvFVCYDAiEB6suk2sp+wJOq7qxdNX1gex/NyVv31re8XNryjpwegBGCwN4QSY DU/HMzoZkP9gPC/l/uYFl3U59+Ei4T5yivzKg5KVT1XHI7pUIhymyryLKzBfynd0i9+ix5XYSe9 FsAv3lc7E/X6XoF5bhKxZhjMV5biPa1PZbZZ9SzxjHbyf1ZHEeeWJy1gS+1qQ/e7af4F8zYE5S/ PZndXfXURpaHr0E3SnIc0You7GN3XjzA1kkkJI7I+ARpbJD6RS0EEb9BjsH2U1ZOB0uw4LaXYlz zxcdYS5h2Lc/wgOp5X3Cy6ouZd37+ZNCUYgOqXRdqvU4p0wbwniC1At7iZgpk03jnvr0vUHzH8x vCEGklk2U/bu3zSda8GheJWXokpdIgzTWujdqCwI1Pr9FJdtpImgTXFLA+5MJiBUmvLYRwQ0U85 GX1MEV8CnZEH90Q==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

As suggested by the kernel test robot, memdup_user() is a better
option than the combo of kmalloc()/copy_from_user().

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310270805.2ArE52i5-lkp@intel.com/
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/security.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/security/security.c b/security/security.c
index a808fd5eba6d..d7b15ea67c3f 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4011,14 +4011,9 @@ int security_setselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
 	if (size > PAGE_SIZE)
 		return -E2BIG;
 
-	lctx = kmalloc(size, GFP_KERNEL);
-	if (lctx == NULL)
-		return -ENOMEM;
-
-	if (copy_from_user(lctx, uctx, size)) {
-		rc = -EFAULT;
-		goto free_out;
-	}
+	lctx = memdup_user(uctx, size);
+	if (IS_ERR(lctx))
+		return PTR_ERR(lctx);
 
 	if (size < lctx->len || size < lctx->ctx_len + sizeof(*lctx) ||
 	    lctx->len < lctx->ctx_len + sizeof(*lctx)) {
-- 
2.42.0

