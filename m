Return-Path: <SRS0=axxp=AS=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81022C433E3
	for <linux-security-module@archiver.kernel.org>; Tue,  7 Jul 2020 08:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61211206C3
	for <linux-security-module@archiver.kernel.org>; Tue,  7 Jul 2020 08:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d2fuJhBs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbgGGITi (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 7 Jul 2020 04:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728150AbgGGITd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 7 Jul 2020 04:19:33 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C26C08C5DB
        for <linux-security-module@vger.kernel.org>; Tue,  7 Jul 2020 01:19:33 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id j19so12793869pgm.11
        for <linux-security-module@vger.kernel.org>; Tue, 07 Jul 2020 01:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8LzHvhyH79XNraI64aGNs932IW1tYhCTGhfJh2lEVIw=;
        b=d2fuJhBs1yWbjePYoqvJWYZe1SRSJgbjp553u56FFd31yWYbHWdQauk74RXaM6QK5Z
         6wtktQwojSEogkmCtIrko7hYiDkU9vh+r9y+G9YbC23l+ldCh74l7x4YprTb5e1AAhlW
         wDajPTrKHOXyHe/oURDusoQV86iqeDJZ91LRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8LzHvhyH79XNraI64aGNs932IW1tYhCTGhfJh2lEVIw=;
        b=cH3Qf2rw9LKRBYc/RlEXT8XxGYtVEtXPmFoT5GBLxfkJcd5c5ciVt+iz7R0tNjn3VX
         nYsr5yig+RhKOE3XJ/pjyk4iHoI9rwF6HZY1NAOj1u/2bcf5adYCqAAWGPXf6yslJY0s
         cO3r8X3KvgIqP5eO5R7rU2J/w+GToPRSqbJDE35uHZzF9PfGb5v8Dbbw1Ue0b8W60QOk
         avqCVFOY9GlrBVpODo4cGJNYY2EMZC7zRcexXRqn10e3wT0hl0oVt+/R15HNfUGdwf0o
         vc1WG0WxR3hzRVksHr0iGfhc2fHCJhXoR+In8wYcxzJkOrZceQoJNwRmfnVLqiYQ6S80
         kwug==
X-Gm-Message-State: AOAM5333qPcyXlES5EXIbVrlFCcv3CV93OVRMEZDdqe8ed0ukxgvfeA4
        yzMInURroSFSkodGDhxtSJxCqw==
X-Google-Smtp-Source: ABdhPJwlmQnAhT5yC6LPH3rR/m0Ap5gtjZUGRRbIWoOIwPOnnsVXMjkjdE7a5NAxP236CA/vqMmsAw==
X-Received: by 2002:a63:2b93:: with SMTP id r141mr43550710pgr.171.1594109973034;
        Tue, 07 Jul 2020 01:19:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s10sm1821622pjl.41.2020.07.07.01.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 01:19:30 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     James Morris <jmorris@namei.org>
Cc:     Kees Cook <keescook@chromium.org>, stable@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jessica Yu <jeyu@kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        KP Singh <kpsingh@google.com>, Dave Olsthoorn <dave@bewaar.me>,
        Hans de Goede <hdegoede@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Boyd <stephen.boyd@linaro.org>,
        Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH 1/4] firmware_loader: EFI firmware loader must handle pre-allocated buffer
Date:   Tue,  7 Jul 2020 01:19:23 -0700
Message-Id: <20200707081926.3688096-2-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707081926.3688096-1-keescook@chromium.org>
References: <20200707081926.3688096-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The EFI platform firmware fallback would clobber any pre-allocated
buffers. Instead, correctly refuse to reallocate when too small (as
already done in the sysfs fallback), or perform allocation normally
when needed.

Fixes: e4c2c0ff00ec ("firmware: Add new platform fallback mechanism and firm ware_request_platform()")
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/base/firmware_loader/fallback_platform.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/base/firmware_loader/fallback_platform.c b/drivers/base/firmware_loader/fallback_platform.c
index cdd2c9a9f38a..685edb7dd05a 100644
--- a/drivers/base/firmware_loader/fallback_platform.c
+++ b/drivers/base/firmware_loader/fallback_platform.c
@@ -25,7 +25,10 @@ int firmware_fallback_platform(struct fw_priv *fw_priv, u32 opt_flags)
 	if (rc)
 		return rc; /* rc == -ENOENT when the fw was not found */
 
-	fw_priv->data = vmalloc(size);
+	if (fw_priv->data && size > fw_priv->allocated_size)
+		return -ENOMEM;
+	if (!fw_priv->data)
+		fw_priv->data = vmalloc(size);
 	if (!fw_priv->data)
 		return -ENOMEM;
 
-- 
2.25.1

