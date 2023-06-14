Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B25AEB64D8
	for <linux-security-module@archiver.kernel.org>; Wed, 14 Jun 2023 13:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244287AbjFNNCN (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 14 Jun 2023 09:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236045AbjFNNCM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 14 Jun 2023 09:02:12 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8C2A0
        for <linux-security-module@vger.kernel.org>; Wed, 14 Jun 2023 06:02:11 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f8cec6641bso7776995e9.1
        for <linux-security-module@vger.kernel.org>; Wed, 14 Jun 2023 06:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686747729; x=1689339729;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z7T3D+U9Tv7RD5rlwhyON4ZX6lWyCUG2JeI56Mpz4QY=;
        b=fiOcD3GIvmcxkkhumrwmL1Dx/vREL2TWO+wMhUCmVU2LjhZCa3T51wDWX8jSoB0yme
         /G9uDrfhR7hiVi0+dKt8qhukzdlZtaLikPRJ9nriGS0PJjtL3AD0Z1uhSjQNvCF5TCmh
         AXs8C/I/4CWWqLho94Vty4qntxnOjK/G7NdtyuQBrjD3/eO0X6+IlMO70aTfzX2Gh/v3
         NCaDHeThx+px5y9rBIgVyOSxFUF8wUkz3/0rbcEAj6cTQtUcleUv1KCwdGvdlQ3CJnOu
         38NLJQdfEgjNG5wobQVD8puPeoDH9HwpMIftbM5Sc14w0B0OKrM7mF17RV1WhXSU+JAI
         oJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686747729; x=1689339729;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z7T3D+U9Tv7RD5rlwhyON4ZX6lWyCUG2JeI56Mpz4QY=;
        b=DR6vOOkjnIqng/RImeGJYxcahH7hnv1v7l36f3sO7Bgr52m3+u6droEKWl1l3RgDom
         8apTT7+L6hUZh0MmAACFxqtBTfyLW+rolcSfqZYc9MjvdeMxEu6cLzXRLNPB4QGwBsVS
         OPfexLxPIV16h/0QB4IK3ygSpgxMWlecJ/Nj4UwBtVLxIEcQkjBm6ocjvWgNFABwgBsD
         T/gPPT9AlvHoxEpWrJn8Y+diGzMFkv3yoJ/JZzXkVcvDDUWBExCnvU74ASXjwTywXLz5
         kWAwnEjNyHaMp7mquyG3XCUZENbaDE3mUmqy7mzTc+nFJbsdBG0Ibv8W/vVpveYRactr
         ZlHQ==
X-Gm-Message-State: AC+VfDy4/WH0v3sviRmb/RdRF+5szVoe5/0W3WSnvlLTOR8/x21YUQ+B
        QWtJcbDCIOTo/1ldSSELmqdZzA==
X-Google-Smtp-Source: ACHHUZ6V6uwFBRhwQLKnYQL5hBOnhcEekAqbA/gVaO6DLEIlckv+ePm7LR9zaCegdOFXynCOex+zzQ==
X-Received: by 2002:a1c:6a18:0:b0:3f7:e34d:33c4 with SMTP id f24-20020a1c6a18000000b003f7e34d33c4mr11481733wmc.10.1686747729569;
        Wed, 14 Jun 2023 06:02:09 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id y22-20020a7bcd96000000b003f7f2a1484csm17493492wmj.5.2023.06.14.06.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 06:02:08 -0700 (PDT)
Date:   Wed, 14 Jun 2023 16:02:04 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     John Johansen <john.johansen@canonical.com>
Cc:     Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Jon Tourville <jontourville@me.com>, apparmor@lists.ubuntu.com,
        linux-security-module@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] apparmor: use passed in gfp flags in aa_alloc_null()
Message-ID: <bf35a5d2-db9f-47cb-a2f0-ea23e407f36d@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

These allocations should use the gfp flags from the caller instead of
GFP_KERNEL.  But from what I can see, all the callers pass in GFP_KERNEL
so this does not affect runtime.

Fixes: e31dd6e412f7 ("apparmor: fix: kzalloc perms tables for shared dfas")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 security/apparmor/policy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/apparmor/policy.c b/security/apparmor/policy.c
index b38f7b2a5e1d..715fe1b66d12 100644
--- a/security/apparmor/policy.c
+++ b/security/apparmor/policy.c
@@ -589,12 +589,12 @@ struct aa_profile *aa_alloc_null(struct aa_profile *parent, const char *name,
 	profile->label.flags |= FLAG_NULL;
 	rules = list_first_entry(&profile->rules, typeof(*rules), list);
 	rules->file.dfa = aa_get_dfa(nulldfa);
-	rules->file.perms = kcalloc(2, sizeof(struct aa_perms), GFP_KERNEL);
+	rules->file.perms = kcalloc(2, sizeof(struct aa_perms), gfp);
 	if (!rules->file.perms)
 		goto fail;
 	rules->file.size = 2;
 	rules->policy.dfa = aa_get_dfa(nulldfa);
-	rules->policy.perms = kcalloc(2, sizeof(struct aa_perms), GFP_KERNEL);
+	rules->policy.perms = kcalloc(2, sizeof(struct aa_perms), gfp);
 	if (!rules->policy.perms)
 		goto fail;
 	rules->policy.size = 2;
-- 
2.39.2

