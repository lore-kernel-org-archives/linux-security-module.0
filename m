Return-Path: <SRS0=rJXW=IE=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E05C433E0
	for <linux-security-module@archiver.kernel.org>; Sat,  6 Mar 2021 13:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29BB565017
	for <linux-security-module@archiver.kernel.org>; Sat,  6 Mar 2021 13:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbhCFNFD (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 6 Mar 2021 08:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbhCFNEb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 6 Mar 2021 08:04:31 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C63C06174A;
        Sat,  6 Mar 2021 05:04:31 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id t9so708572pjl.5;
        Sat, 06 Mar 2021 05:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=borX0+mAA6MXIi2VKQDK1EmdcPRQFgjcerjvurRRsPU=;
        b=fF5KsTrRZNNqioYREGJjOWFqLIawNtTGnd9ajFDo0g8L4jfweC01MB9citNaM/RDya
         ftJ6R8LcK3hEFLLm8Qt76of7XX/QXod1l9Iqr/BQI08lXG/1j0C4aZNqlaY60Mtw4LQq
         TphwQFnMfebA31zUWlOkrTemW7OdImvbCzQmo9VcIMtPlT02XNIzAP0+fFSnEn8MbpWO
         DwHW/IA/7KyEPupbeOziZTIsgtCd4t0k3dkkfKtB5d6qe21YHeB0VpV8x1jD/BpwmUkU
         ujSyFp0c81gFco3nZSHNxULf9psrBQedOceiKI4QYlAeA+jnaMpoMYNnnDzLsxFJbOya
         nvzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=borX0+mAA6MXIi2VKQDK1EmdcPRQFgjcerjvurRRsPU=;
        b=QRxywzjae9l9h7E/olE/P64NiZcADkMWdo3k9HucdxgKxQ7+X0X+8S0SdupdAiuNUX
         xXCm903h+EW6n6hI4Wvjmny9uT0KUd7NVN+RLnbFdx+vX+b2hivl85HSqr+lLagpbCzI
         79lsJJcifDCAn+wPSgWo411aovUBxZlILFDe+npzVhDbh/sx0wLXNmGG41Q70yYtWX1N
         StN5rIx2qp/VbI6pnjG4bRshdYoP0SgKoDHcit0Uyd2a1amRdHmoAwpdFHw0Vt613OXy
         Hcw2rS9DF68xdMMVAqAAcnonh9YHtFodpIa0isR7+AIgMWrpH0f1yLimuv1H9n8f0+rU
         g94Q==
X-Gm-Message-State: AOAM533BSLigmqwkuKgCIChF5QHA4SqwhK6CwdML+wZS8CBet2h0cIdu
        lCdc0uRk4wYZKYT0PhFXg00=
X-Google-Smtp-Source: ABdhPJyMakaiaZfTkWnrtCOKlOW1DvAzRKNSS3tMltIg51Q/4RDaE5s2++f/axaubiQIT6oJF77AeQ==
X-Received: by 2002:a17:90a:5501:: with SMTP id b1mr15666224pji.57.1615035871079;
        Sat, 06 Mar 2021 05:04:31 -0800 (PST)
Received: from localhost.localdomain ([45.135.186.66])
        by smtp.gmail.com with ESMTPSA id j20sm5568570pjn.27.2021.03.06.05.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 05:04:30 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     takedakn@nttdata.co.jp, penguin-kernel@I-love.SAKURA.ne.jp,
        jmorris@namei.org, serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] security: tomoyo: fix error return code of tomoyo_update_domain()
Date:   Sat,  6 Mar 2021 05:03:46 -0800
Message-Id: <20210306130346.16296-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

When mutex_lock_interruptible() fails, the error return code of
tomoyo_update_domain() is not properly assigned.
To fix this bug, error is assigned with the return value of
mutex_lock_interruptible(), and then error is checked.

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 security/tomoyo/domain.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/tomoyo/domain.c b/security/tomoyo/domain.c
index 98d985895ec8..7b9f9664dbe3 100644
--- a/security/tomoyo/domain.c
+++ b/security/tomoyo/domain.c
@@ -118,7 +118,8 @@ int tomoyo_update_domain(struct tomoyo_acl_info *new_entry, const int size,
 		      ->perm == 1 << TOMOYO_TYPE_EXECUTE))
 			goto out;
 	}
-	if (mutex_lock_interruptible(&tomoyo_policy_lock))
+	error = mutex_lock_interruptible(&tomoyo_policy_lock);
+	if (error)
 		goto out;
 	list_for_each_entry_rcu(entry, list, list,
 				srcu_read_lock_held(&tomoyo_ss)) {
-- 
2.17.1

