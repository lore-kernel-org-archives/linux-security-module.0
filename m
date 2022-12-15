Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810BEC001B2
	for <linux-security-module@archiver.kernel.org>; Thu, 15 Dec 2022 00:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiLOAOr (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 14 Dec 2022 19:14:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiLOANq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 14 Dec 2022 19:13:46 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761BC537C0
        for <linux-security-module@vger.kernel.org>; Wed, 14 Dec 2022 16:12:18 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id u5so8693770pjy.5
        for <linux-security-module@vger.kernel.org>; Wed, 14 Dec 2022 16:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZNFa0Som2cEXdyImA0PHzAPIxujgLNI2oeSKx5nHZI=;
        b=Mar/wnyOMbOk1+C6Q5uXoFrUdKfYUVRbk56ST4Cdpt8bBvB6kbwiHHlmlZHyoJqUXq
         0bC2mxcb4Aba4AQ7l5WLkMe1+FiheB82JTvBZg70Btv3MIEnYkyusR0jImZrs5zZt2R4
         WYPS2HBzWXj5LCp/LfNQb6K4VUdeyB2KhB+/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZNFa0Som2cEXdyImA0PHzAPIxujgLNI2oeSKx5nHZI=;
        b=2D7CpWcXqqWclI/KB/GhYwHBRIAVgMaB+E1uNSQlXCxUDaQe9hQSewInTa//5V3r8S
         +STorfHynp7QLXPBfCv9Di1HL86iHwEESlGIXQvG9k3yPkeAaZ5Uw8EbgtS9wLY8QL36
         vWkrDxRoh+GitVm3kt66nEUSql8O/GhEW4o9Y9JcfX2HcBa+h6t0R3F712j8dqtPXu4m
         EpfkRaiwEma1GlIToQXFGQ12p2hsuArpJKVcUk3ke31kWNBNOpzMU1EP64VUwuJilZXD
         wnB4hcGHmeen/5GF9sKBaHEQO1rsX3N8WIsHXYU/s2G2f6YuMA++CTsAkwfY/sNc8ATv
         YwMw==
X-Gm-Message-State: ANoB5pnp9y1kxIxMCXWGeZ3dTDiBIehWr3wxgTkqCqnLN3+LtRTqhFYw
        zXwc8H1NPoRhPGGGVMRFzxffJQ==
X-Google-Smtp-Source: AA0mqf6GJzrv+PwU1r/NMlYDtOak9TKNkI9c0zXY6nAVkp4XlqigEungkSMJ1qEv73IT1BAvIE/pQw==
X-Received: by 2002:a17:90a:7890:b0:221:4338:a6ae with SMTP id x16-20020a17090a789000b002214338a6aemr17461030pjk.33.1671063137955;
        Wed, 14 Dec 2022 16:12:17 -0800 (PST)
Received: from jeffxud.c.googlers.com.com (30.202.168.34.bc.googleusercontent.com. [34.168.202.30])
        by smtp.gmail.com with ESMTPSA id 3-20020a17090a08c300b0021937b2118bsm1845738pjn.54.2022.12.14.16.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 16:12:17 -0800 (PST)
From:   jeffxu@chromium.org
To:     skhan@linuxfoundation.org, keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v8 4/5] mm/memfd: Add write seals when apply SEAL_EXEC to executable memfd
Date:   Thu, 15 Dec 2022 00:12:04 +0000
Message-Id: <20221215001205.51969-5-jeffxu@google.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
In-Reply-To: <20221215001205.51969-1-jeffxu@google.com>
References: <20221215001205.51969-1-jeffxu@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Jeff Xu <jeffxu@google.com>

In order to avoid WX mappings, add F_SEAL_WRITE when apply
F_SEAL_EXEC to an executable memfd, so W^X from start.

This implys application need to fill the content of the memfd first,
after F_SEAL_EXEC is applied, application can no longer modify the
content of the memfd.

Typically, application seals the memfd right after writing to it.
For example:
1. memfd_create(MFD_EXEC).
2. write() code to the memfd.
3. fcntl(F_ADD_SEALS, F_SEAL_EXEC) to convert the memfd to W^X.
4. call exec() on the memfd.

Signed-off-by: Jeff Xu <jeffxu@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 mm/memfd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/memfd.c b/mm/memfd.c
index ec70675a7069..92f0a5765f7c 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -222,6 +222,12 @@ static int memfd_add_seals(struct file *file, unsigned int seals)
 		}
 	}
 
+	/*
+	 * SEAL_EXEC implys SEAL_WRITE, making W^X from the start.
+	 */
+	if (seals & F_SEAL_EXEC && inode->i_mode & 0111)
+		seals |= F_SEAL_SHRINK|F_SEAL_GROW|F_SEAL_WRITE|F_SEAL_FUTURE_WRITE;
+
 	*file_seals |= seals;
 	error = 0;
 
-- 
2.39.0.rc1.256.g54fd8350bd-goog

