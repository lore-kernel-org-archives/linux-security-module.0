Return-Path: <SRS0=hMH8=MO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BD4C00449
	for <linux-security-module@archiver.kernel.org>; Tue,  2 Oct 2018 00:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9744221473
	for <linux-security-module@archiver.kernel.org>; Tue,  2 Oct 2018 00:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GAcR6tP9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9744221473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbeJBHhe (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 2 Oct 2018 03:37:34 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:56116 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbeJBHfl (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 2 Oct 2018 03:35:41 -0400
Received: by mail-it1-f196.google.com with SMTP id c23-v6so960818itd.5
        for <linux-security-module@vger.kernel.org>; Mon, 01 Oct 2018 17:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bDWn21iauCiQfJ3Cfx0b4/V/Z6uec1GQQMOYX0nkvvY=;
        b=GAcR6tP9URv886m1xLxqEkbz7YdEIPtmlOXupq5g2EXLl32Y9kAajKKDmJnKpSlbBV
         rLEBx20E5RrgQhPahPVvIDZNhfmaScUj9mX/sjntvnTzTNHuAHznGA7psqHqUnYdsXf9
         7S4K20h9JonYDs+o+8wdIfvtkRVU8XCaqZInk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bDWn21iauCiQfJ3Cfx0b4/V/Z6uec1GQQMOYX0nkvvY=;
        b=YaOWjydvuzGY10svW2Bjy6jCvrC8qYb198qkaneshg80eIoFnQ9QWwzs3sKDNuB3Kk
         HDfV3I3VgEsu0kR887wSVIxFFWHCKq/46SgJxXpFtFrn2BykKpob57AMWw30m3tXnCsP
         c/SZkx2ROcBLxK0ZwHehBkwOD+ohwFy3ZYkF5TLHUXHhmM+9vGrVTF/3DvZSr6sqcUwZ
         pxNX2QiZt0ShaPd6uYoFvth05HW8zmEC8L3jzMZHF0zMfsmL/nWyPfn3Y/t0Wfor2jG4
         jv2FTV1Mm2VKItmBzo4UVnXhUHITw1+uTgbFJUe90lrM2xOYuy9jv82GysLxMaNxI++V
         7Lig==
X-Gm-Message-State: ABuFfoh3kQxK3zKhW79SGg6Vxxkm5Ee0awN9DjAKRkldwLN5Sc00lAbE
        LxfCDjiBTiD1UJIQqBVwHIOtlA==
X-Google-Smtp-Source: ACcGV61AqGxKtv9I9HjmCYv04cw6b4KEf5MttqybCinUm3ePWLIaBa+yoUlDm4hJymYZNebTGzkDIg==
X-Received: by 2002:a63:9712:: with SMTP id n18-v6mr12323822pge.69.1538441712326;
        Mon, 01 Oct 2018 17:55:12 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id c79-v6sm12054717pfb.147.2018.10.01.17.55.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 17:55:08 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     James Morris <jmorris@namei.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH security-next v4 02/32] vmlinux.lds.h: Avoid copy/paste of security_init section
Date:   Mon,  1 Oct 2018 17:54:35 -0700
Message-Id: <20181002005505.6112-3-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181002005505.6112-1-keescook@chromium.org>
References: <20181002005505.6112-1-keescook@chromium.org>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Avoid copy/paste by defining SECURITY_INIT in terms of SECURITY_INITCALL.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: James Morris <james.morris@microsoft.com>
Reviewed-by: John Johansen <john.johansen@canonical.com>
---
 include/asm-generic/vmlinux.lds.h | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 7b75ff6e2fce..934a45395547 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -473,13 +473,6 @@
 #define RODATA          RO_DATA_SECTION(4096)
 #define RO_DATA(align)  RO_DATA_SECTION(align)
 
-#define SECURITY_INIT							\
-	.security_initcall.init : AT(ADDR(.security_initcall.init) - LOAD_OFFSET) { \
-		__security_initcall_start = .;				\
-		KEEP(*(.security_initcall.init))			\
-		__security_initcall_end = .;				\
-	}
-
 /*
  * .text section. Map to function alignment to avoid address changes
  * during second ld run in second ld pass when generating System.map
@@ -798,6 +791,12 @@
 		KEEP(*(.security_initcall.init))			\
 		__security_initcall_end = .;
 
+/* Older linker script style for security init. */
+#define SECURITY_INIT							\
+	.security_initcall.init : AT(ADDR(.security_initcall.init) - LOAD_OFFSET) { \
+		SECURITY_INITCALL					\
+	}
+
 #ifdef CONFIG_BLK_DEV_INITRD
 #define INIT_RAM_FS							\
 	. = ALIGN(4);							\
-- 
2.17.1

