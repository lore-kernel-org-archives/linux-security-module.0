Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (unknown [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE40C433C1
	for <linux-security-module@archiver.kernel.org>; Sun, 21 Mar 2021 03:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4423619B2
	for <linux-security-module@archiver.kernel.org>; Sun, 21 Mar 2021 03:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhCUDt2 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 20 Mar 2021 23:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbhCUDs5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 20 Mar 2021 23:48:57 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D09EC061574;
        Sat, 20 Mar 2021 20:48:57 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id y2so7510290qtw.13;
        Sat, 20 Mar 2021 20:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RyB7Cj5ghAs4zslIymp809ee3iouAj8eNfXiQ4STLI4=;
        b=KWAzdrZL+s51E7Ah72wUko6U8y/SsBrYU7jCFtItfCQTZO7FeZUkPjgDhBvNLfNOVc
         fLQ4mIt7Iv53957EGgve4IlvEmayUKPou3ggkxFX8voH90TkogUwnCDZzIKJsbWqrPo8
         5vV59x4DxNeFSei0gj9i59XmLzXdV5lrwYfxDP7YAGZGggD08iYMX0wCj7vypez/aVIL
         nOUxKrT7rRK42eQGngSFcvhZzXy4bun7k7iRjcJl0khh/bC51qlH/NG9FmdR7GdMJWgb
         rEROKBhbyAoImfNqXh/qHnZ/TqG0SxSk8l4uzOx4Gk5MfPs5UE92Jr9xk9MuiFs+u0JN
         kC/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RyB7Cj5ghAs4zslIymp809ee3iouAj8eNfXiQ4STLI4=;
        b=YWcnCCDs13NZBZNY3We639XY/xhR9/sIVSrGHPfvBzCA26il3a2WkV/QGyN8Sa+OXM
         d4uxOq5F61X55Om4lErCAbMg3a6VSoeEKN4jOh5eW3JPvl4tuC40w1oUrV85qUMf4UTu
         YDgtv0KwmHXYhzJyHT+JzMbgpMzsZyxrg5vXn6JnQLP/Glo9UaadRklRQCVNW55i6Cbj
         VOFy8caV2N/dJ+Vjy96luS1GUhshDIOp9+tB7POOI29IsQf386HRHHjDlgECvd6J0HZQ
         2Q6mJ3r90wrUBpT6vDB8InD431pBpPa9gWjMq14xBF9sHMRMpH93FxW9Vcf01+f1pLL1
         8mnA==
X-Gm-Message-State: AOAM5304BAkWmpN1+4bEXpo57PQRIyDsTatoaFIprcFgw/ZBKwC4K2Fg
        aihB8x9mnFgo9JDZDY4kwBI=
X-Google-Smtp-Source: ABdhPJwFNr0x0BqjXjmYSJ/MGzJzhwtj4XVbBKRYdXbf3qpyBsfXIORj3VhNeBl7Px90Mi9VjdYxOw==
X-Received: by 2002:ac8:7b4b:: with SMTP id m11mr5021176qtu.276.1616298536394;
        Sat, 20 Mar 2021 20:48:56 -0700 (PDT)
Received: from localhost.localdomain ([156.146.54.26])
        by smtp.gmail.com with ESMTPSA id k126sm8217938qkb.4.2021.03.20.20.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 20:48:55 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] security: A typo fix
Date:   Sun, 21 Mar 2021 09:18:44 +0530
Message-Id: <20210321034844.28316-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

s/acessed/accessed/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
  Two comment block delimiter automatically delete themselve and created
  themselves ..wondering..I hope that won't be problem,is it?
 security/device_cgroup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/device_cgroup.c b/security/device_cgroup.c
index 04375df52fc9..c2c052512472 100644
--- a/security/device_cgroup.c
+++ b/security/device_cgroup.c
@@ -404,14 +404,14 @@ static bool verify_new_ex(struct dev_cgroup *dev_cgroup,
 			/*
 			 * new exception in the child doesn't matter, only
 			 * adding extra restrictions
-			 */
+			 */
 			return true;
 		} else {
 			/*
 			 * new exception in the child will add more devices
-			 * that can be acessed, so it can't match any of
+			 * that can be accessed, so it can't match any of
 			 * parent's exceptions, even slightly
-			 */
+			 */
 			match = match_exception_partial(&dev_cgroup->exceptions,
 							refex->type,
 							refex->major,
--
2.20.1

