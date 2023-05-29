Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79E6C77B7E
	for <linux-security-module@archiver.kernel.org>; Mon, 29 May 2023 22:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjE2Wyu (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 29 May 2023 18:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjE2Wyq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 29 May 2023 18:54:46 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7ACA7;
        Mon, 29 May 2023 15:54:45 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-64d30ab1f89so2520752b3a.3;
        Mon, 29 May 2023 15:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685400885; x=1687992885;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1LAlH2NU9fm2kbMS3sSlFfb7MPx4bChAyPnV1Ii59IE=;
        b=aOy0BBZ+TBgy6dOkGhaBGVSj9YhSOy0BHIMbmnXZ55ISaaJP974hPPAk6P1Q4a78F2
         +0d7EibN/BuAG8B2ohkggJRy0Nr23ctL9cbJQm2BOmWJvJjcszWkaFDPVkeeemJwdsbw
         SXM8cpPqPZsPzKY5lbJPT9eHxBl0eEBQij5VkLRbKviUNyED/ZZS6JYdinNfDn+HjnNc
         7eoiPjXb38a8j2uT9x7YCuMLNEhlpvPqDu88cyNRJez3nJS49But0HS3s+DuSLYK9yAx
         fOArXQtSt2AVkUenQF3b1Pp28q6dNCCBqVRur/GZi1M0N0QGQso6zSvn++low4MhjTih
         D9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685400885; x=1687992885;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1LAlH2NU9fm2kbMS3sSlFfb7MPx4bChAyPnV1Ii59IE=;
        b=VwXaAB4stH3B98Duo4c9w1fbzWe1MEb5ZVllKoP+DkZecfXZgp6zS703YrPvPGtqxn
         Ednob7a+1vDF4g8NXNYAgX3+sL/08P3JZNvSo2MhEC1wvgGw+LwObX1UsU4ZvEUL/+h7
         OxBKdEHTdfXbjucgwOt+Uu4r2ijRM+euBt0rI5tEplVsVtwKIpxBacwV2dKI2PO7oMm3
         fPEPwmdauM3dLif9Rv/JhK7p3YfUNxmYxQtn9RvW1u3RMtLkDN9gQW4GwNOUV1GUw4/F
         Fy+A0D4o5u2+j1BKknafYDiBnV1CqtTnHwcLaY7WQqkt69dcziO0xlJ4OI3y7CahJGfq
         77XQ==
X-Gm-Message-State: AC+VfDxHPFw6CYMPKlDcg03lzRb5lfTAutkWyNWmyjwnhrkkS/HHtVec
        TJKyW0bxVp68I27QvS8kZIs=
X-Google-Smtp-Source: ACHHUZ5evijTnyaR0aFCQe0IcqdJhq4dfmPWNMuu35WWfOi5BLIMIYt9Ukg7fclOZMk10dT+ovtwNQ==
X-Received: by 2002:a05:6a00:18a9:b0:64d:b0d8:a396 with SMTP id x41-20020a056a0018a900b0064db0d8a396mr206123pfh.7.1685400885103;
        Mon, 29 May 2023 15:54:45 -0700 (PDT)
Received: from ubuntu777.domain.name (36-228-85-240.dynamic-ip.hinet.net. [36.228.85.240])
        by smtp.gmail.com with ESMTPSA id c26-20020aa78e1a000000b0064d681c753csm445191pfr.40.2023.05.29.15.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 15:54:44 -0700 (PDT)
From:   Min-Hua Chen <minhuadotchen@gmail.com>
To:     Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>
Cc:     Min-Hua Chen <minhuadotchen@gmail.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] capabilities: use logical OR
Date:   Tue, 30 May 2023 06:54:39 +0800
Message-Id: <20230529225440.7315-1-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Use logical OR to fix the following sparse warnings:

security/commoncap.c:1358:41: sparse: warning: dubious: !x | y

No functional changes intended.

Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
---
 security/commoncap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index 0b3fc2f3afe7..b8e34f6204b2 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -1355,7 +1355,7 @@ int cap_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			return commit_creds(new);
 		}
 
-		if (((!cap_valid(arg3)) | arg4 | arg5))
+		if (((!cap_valid(arg3)) || arg4 || arg5))
 			return -EINVAL;
 
 		if (arg2 == PR_CAP_AMBIENT_IS_SET) {
-- 
2.34.1

