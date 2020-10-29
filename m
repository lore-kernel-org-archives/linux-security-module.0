Return-Path: <SRS0=Tuew=EE=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBB9C4363A
	for <linux-security-module@archiver.kernel.org>; Thu, 29 Oct 2020 18:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 192292087E
	for <linux-security-module@archiver.kernel.org>; Thu, 29 Oct 2020 18:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pn0Q8NqB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbgJ2Sf4 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 29 Oct 2020 14:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbgJ2Sfy (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 29 Oct 2020 14:35:54 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B836C0613CF;
        Thu, 29 Oct 2020 11:35:53 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id b8so3918156wrn.0;
        Thu, 29 Oct 2020 11:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XBVdT16KbfHWRwy5uoPg+dPDIbhzWcWjtjwaDApZzko=;
        b=pn0Q8NqBI7hhMfQ4mVkAJUHqR2bomvUWrQS9SNsqmE5BwK8gkSJwO24vTTm+PXUwNi
         4IaAC0lhwWqcRMl2D4VSxcU3Co+K5exvzGKsZVAuttifjaw6uyIYjY+eAyGXx/pi97No
         zIyqGtxL91Wxyg0Zw8sCVMW8YaCs05yFUg4VjxZ5Vy7AXHVLTgIPTqmICpHMBXZF6wVh
         CXUV9CCjZC9r5oUYnNDF8cGVERDdqtRsKLExJH8mxGpYXkqt1OZEa6GkzQuaUvFgx+C6
         nyUZEiuFWzRWhgmFeiBjpGOnskGbe5lJMP6HXz8ar5l8vjhKrfnwAIwOIWZfID8WXiAN
         95PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XBVdT16KbfHWRwy5uoPg+dPDIbhzWcWjtjwaDApZzko=;
        b=dFtuFni8PLHxHHdjtl5cnykq9BrPBf0RbYSOjWyf5K1fVkxTY8pSBvThAXYggyplKU
         5Ddm2kYc5iEoeWny6llzwmNZK+ALIwEXqonSm76zcYFycuSH2cZ3rFs++AxLgqcUw49u
         ALcZ2WCKLUaqNcJl8xEbzwVChwhwHFekm5Qs3T8Uph8EHGfwkWilSsOZJ4kR6qSBMlOC
         vopVv3vx8l6Xl8oW1thuIgYM2FAqOqqV1Q0H6AH6mSDD/kA5NbiaRQYa9XKgsw0ivETp
         0nbiAA7uTHMHlfEyi6gS153396gJkehpudacEFe1uRexzXtnXwcpxamPBH5kHWuVjv/7
         8Adg==
X-Gm-Message-State: AOAM531eaB3YpykdoApQ0V11oMap5/1D3+fLvrDwUOnq+5BWWTARQKZi
        5Z67ojwnjZnSEvyR3PxoL/g=
X-Google-Smtp-Source: ABdhPJw7U+G+XB3uj5ELnYxxOhtaDScAY18U9fxXxB6cO33we7FfsB3z8aeSRt4gPDvdjpeU32sSxQ==
X-Received: by 2002:adf:ed92:: with SMTP id c18mr3518748wro.363.1603996552070;
        Thu, 29 Oct 2020 11:35:52 -0700 (PDT)
Received: from nogikh.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id f4sm5800982wrq.54.2020.10.29.11.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 11:35:51 -0700 (PDT)
From:   Aleksandr Nogikh <aleksandrnogikh@gmail.com>
To:     jmorris@namei.org, serge@hallyn.com, akinobu.mita@gmail.com
Cc:     andreyknvl@google.com, dvyukov@google.com, elver@google.com,
        glider@google.com, keescook@google.com, casey@schaufler-ca.com,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Aleksandr Nogikh <nogikh@google.com>
Subject: [PATCH v3 2/2] docs: add fail_lsm_hooks info to fault-injection.rst
Date:   Thu, 29 Oct 2020 18:35:26 +0000
Message-Id: <20201029183526.2131776-3-aleksandrnogikh@gmail.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201029183526.2131776-1-aleksandrnogikh@gmail.com>
References: <20201029183526.2131776-1-aleksandrnogikh@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Aleksandr Nogikh <nogikh@google.com>

Describe fail_lsm_hooks fault injection capability.

Signed-off-by: Aleksandr Nogikh <nogikh@google.com>
---
v2:
- Added this commit.
---
 Documentation/fault-injection/fault-injection.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/fault-injection/fault-injection.rst b/Documentation/fault-injection/fault-injection.rst
index 31ecfe44e5b4..48705adfbc18 100644
--- a/Documentation/fault-injection/fault-injection.rst
+++ b/Documentation/fault-injection/fault-injection.rst
@@ -48,6 +48,12 @@ Available fault injection capabilities
   status code is NVME_SC_INVALID_OPCODE with no retry. The status code and
   retry flag can be set via the debugfs.
 
+- fail_lsm_hooks
+
+  injects failures into LSM hooks. When a fault is injected, actual hooks
+  are not executed and a code from /sys/kernel/debug/fail_lsm_hooks/retval
+  is returned (the default value is -EACCES).
+
 
 Configure fault-injection capabilities behavior
 -----------------------------------------------
-- 
2.29.1.341.ge80a0c044ae-goog

