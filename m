Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682CBC433DB
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Mar 2021 01:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2267E619A1
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Mar 2021 01:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbhCWBeH (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 22 Mar 2021 21:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbhCWBdk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 Mar 2021 21:33:40 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58AD0C061574;
        Mon, 22 Mar 2021 18:33:40 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id u19so10093852pgh.10;
        Mon, 22 Mar 2021 18:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qiLpwxPjK3YlrcimrTkNb9ZY7dWb+03A9YHQCUOSfQM=;
        b=YWBETTwFuZSjRMjn/jEwQwYr7Wi37lw5iU9f4tmGbmAFXv0A9/1W9D6PYDHqTmJ9id
         p22dYhltzQa/TZd2B1aw1ci7eWlnj9aOmGeimDWafCboUTsdjJKERjMJ+TJAX968sphB
         vOZ0UnKUKy7jdLreOJAenY10LbK5tFSuJRPTQTqfzRTKubKlGTPljO/Q8Zo4feok7BvC
         q434FpmJjCakyZjosx4zxsLpNdEJ0LPxsCdaGt2MpnoDjhxycjA58Dg18Hd+1xSahPvu
         wPaVrhWpjWYXXd1nLshsY3piYQ1mzNgBDqqQT3RhGlSQwNQ2sexSfrfoQQ6wBayFiqTn
         5WeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qiLpwxPjK3YlrcimrTkNb9ZY7dWb+03A9YHQCUOSfQM=;
        b=ESSUvz0fHcsYRnnpeGK/zzjns+hsRNFBg3BuGnOFz/a74mdQ4ImeGY5YatLksEAtue
         f4RjfhHRf6/SOYVihpqCRTTPaFPkTH4Tjr3tUiSx5+bhdQe+R6hjGFUEap+QHxLOu+V+
         STpvYUsqL0NiMb99dMQUXjiPKVyOVKkmmjdfdRCAx1/Apo6mPCkj7tGyvNpd3EezmQOj
         ZwUuPxy2Zz0PoNHSYm+kzSGqaeR51XHZizeii/AQVCLSoc6iM33PZyLsC02Wng8503Sj
         hkSNOHgFHZAtmc8ExFJhOQc33bRAhjLVRPho4SWG8R2Z5ZQhio/Gp0tUPpjNGyzqYe6p
         fsIw==
X-Gm-Message-State: AOAM5318DQzyrRITrRFxnnJMAk7UxtBUt1B38OHFrO6z0VfXwI6BJ1H2
        FOZuUqEd4WXXX8iDs4qkN0c=
X-Google-Smtp-Source: ABdhPJzxu9KP57zznqjvE/9DQXCKLdF0/eqrBsL4BO7SnNrrpNxl8+TRqhoOsR7e5UhkSFlXywTaJQ==
X-Received: by 2002:a17:902:eb11:b029:e4:a5c3:4328 with SMTP id l17-20020a170902eb11b02900e4a5c34328mr2496472plb.7.1616463219963;
        Mon, 22 Mar 2021 18:33:39 -0700 (PDT)
Received: from localhost.localdomain ([103.114.158.1])
        by smtp.gmail.com with ESMTPSA id i1sm14998509pfo.160.2021.03.22.18.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 18:33:39 -0700 (PDT)
From:   Jiele Zhao <unclexiaole@gmail.com>
To:     serge@hallyn.com, jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiele Zhao <unclexiaole@gmail.com>
Subject: [PATCH] integrity/ima: Add declarations to init_once void arguments.
Date:   Tue, 23 Mar 2021 01:33:18 +0000
Message-Id: <20210323013318.296993-1-unclexiaole@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

init_once is a callback to kmem_cache_create. The parameter
type of this function is void *, so it's better to give a
explicit cast here.

Signed-off-by: Jiele Zhao <unclexiaole@gmail.com>
---
 security/integrity/iint.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index 1d20003243c3..5f3f2de997e1 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -152,7 +152,7 @@ void integrity_inode_free(struct inode *inode)
 
 static void init_once(void *foo)
 {
-	struct integrity_iint_cache *iint = foo;
+	struct integrity_iint_cache *iint = (struct integrity_iint_cache *)foo;
 
 	memset(iint, 0, sizeof(*iint));
 	iint->ima_file_status = INTEGRITY_UNKNOWN;
-- 
2.25.1

