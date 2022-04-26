Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D94BC433FE
	for <linux-security-module@archiver.kernel.org>; Tue, 26 Apr 2022 21:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355494AbiDZVej (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 26 Apr 2022 17:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355467AbiDZVea (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 26 Apr 2022 17:34:30 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5742559B
        for <linux-security-module@vger.kernel.org>; Tue, 26 Apr 2022 14:31:21 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id bd19-20020a17090b0b9300b001d98af6dcd1so3290984pjb.4
        for <linux-security-module@vger.kernel.org>; Tue, 26 Apr 2022 14:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dWxaD7L0u/h0y2dhkzttG4l+Tb/Huddvi0NADO8Lp2s=;
        b=hdDvtXb8sW1W6Vb9Rl1EyT79gjqOgItMlyb6hUkULSIq7OBeaZAjDkb1GDFuCpTKwX
         6amgRPyb8H6us1ZLwhP5WU3wpLB5m68cphTpxGKy7UfE1WavorSBcGyJnSyAn86RhwM2
         rRm9wDZcuV4lvjKc/6RAtt7RcXFBuOMww+sFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dWxaD7L0u/h0y2dhkzttG4l+Tb/Huddvi0NADO8Lp2s=;
        b=x6iElOKRNQcwLOC/8e7/OJLKKNVICWadA6O9KEdKVpfKDjyNEuGB7iNeJWOhQkzIIl
         ve+q1njJo6ItG4wtcm3ZX0YxubfdsymjO7uZcYWJtMs/AYt3N4m9Enk23+PDinDrn6Rn
         SpDK7NFOeevj0MepBTEyohZ8gXTHYTFWlCXEw2wpDnhdGGR09rNyRW11G5BybaORjWsI
         ZSFjgewdbxPjbnHuIc7SXshyh5cdJLJRPvdC9jmEmwBJ1XKOlzMYWHD5k8V3cI1hXi9t
         RXXeRtx2KIz8hBdB+OwtcY13wQ2DUgmqUw1zYI/qXSt8VJjPc/zY6LP3++ryeNaAuEaO
         1wTg==
X-Gm-Message-State: AOAM530dtJZL7ckjk0GMVTXcg8HiQYaPnYxJvZYOg6WtiifmCv5tR/2T
        0d09bLd/Lbalq0ZHjFvYVBSjSA==
X-Google-Smtp-Source: ABdhPJy4R5XtqAI2AVSwm6Ahikus8xa0rabLRQflKyRJPiBg1OerZzxzHWDe8RqGJ2mAUYofsSzeJw==
X-Received: by 2002:a17:90b:2311:b0:1d9:277e:edad with SMTP id mt17-20020a17090b231100b001d9277eedadmr22722620pjb.190.1651008681490;
        Tue, 26 Apr 2022 14:31:21 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:eb63:4211:eb5d:f6b])
        by smtp.gmail.com with UTF8SMTPSA id z8-20020aa785c8000000b005060d2d7085sm16015202pfn.151.2022.04.26.14.31.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 14:31:21 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, dm-devel@redhat.com,
        linux-raid@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Song Liu <song@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2 3/3] dm: verity-loadpin: Use CONFIG_SECURITY_LOADPIN_VERITY for conditional compilation
Date:   Tue, 26 Apr 2022 14:31:10 -0700
Message-Id: <20220426143059.v2.3.I5aca2dcc3b06de4bf53696cd21329dce8272b8aa@changeid>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
In-Reply-To: <20220426213110.3572568-1-mka@chromium.org>
References: <20220426213110.3572568-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The verity glue for LoadPin is only needed when CONFIG_SECURITY_LOADPIN_VERITY
is set, use this option for conditional compilation instead of the combo of
CONFIG_DM_VERITY and CONFIG_SECURITY_LOADPIN.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

Changes in v2:
- none

 drivers/md/Makefile               | 7 +------
 include/linux/dm-verity-loadpin.h | 2 +-
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/md/Makefile b/drivers/md/Makefile
index e12cd004d375..a96441752ec7 100644
--- a/drivers/md/Makefile
+++ b/drivers/md/Makefile
@@ -83,6 +83,7 @@ obj-$(CONFIG_DM_LOG_WRITES)	+= dm-log-writes.o
 obj-$(CONFIG_DM_INTEGRITY)	+= dm-integrity.o
 obj-$(CONFIG_DM_ZONED)		+= dm-zoned.o
 obj-$(CONFIG_DM_WRITECACHE)	+= dm-writecache.o
+obj-$(CONFIG_SECURITY_LOADPIN_VERITY)	+= dm-verity-loadpin.o
 
 ifeq ($(CONFIG_DM_INIT),y)
 dm-mod-objs			+= dm-init.o
@@ -100,12 +101,6 @@ ifeq ($(CONFIG_IMA),y)
 dm-mod-objs			+= dm-ima.o
 endif
 
-ifeq ($(CONFIG_DM_VERITY),y)
-ifeq ($(CONFIG_SECURITY_LOADPIN),y)
-dm-mod-objs			+= dm-verity-loadpin.o
-endif
-endif
-
 ifeq ($(CONFIG_DM_VERITY_FEC),y)
 dm-verity-objs			+= dm-verity-fec.o
 endif
diff --git a/include/linux/dm-verity-loadpin.h b/include/linux/dm-verity-loadpin.h
index 12a86911d05a..be63ac76f98d 100644
--- a/include/linux/dm-verity-loadpin.h
+++ b/include/linux/dm-verity-loadpin.h
@@ -13,7 +13,7 @@ struct trusted_root_digest {
 	struct list_head node;
 };
 
-#if IS_ENABLED(CONFIG_SECURITY_LOADPIN) && IS_BUILTIN(CONFIG_DM_VERITY)
+#if IS_ENABLED(CONFIG_SECURITY_LOADPIN_VERITY)
 void dm_verity_loadpin_set_trusted_root_digests(struct list_head *digests);
 bool dm_verity_loadpin_is_md_trusted(struct mapped_device *md);
 #else
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

