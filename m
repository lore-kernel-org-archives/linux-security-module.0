Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C070C433FE
	for <linux-security-module@archiver.kernel.org>; Mon, 23 May 2022 21:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiEWVO3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 23 May 2022 17:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbiEWVOJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 23 May 2022 17:14:09 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B507DE08
        for <linux-security-module@vger.kernel.org>; Mon, 23 May 2022 14:14:08 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 137so14717653pgb.5
        for <linux-security-module@vger.kernel.org>; Mon, 23 May 2022 14:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7sQ9oR+xbg8R35wvoreY201E08AeVxeiXWdeAF7cXRM=;
        b=iNUjyOKjFHBZM89PlCmEcdOGkthobgiSyYUS457qK0QaLGGsWpcgsGmcklWVDWuzmI
         KqTv3dF1RgTfgEThOWi4q26pvTJeVo4ejWLwnmJ56VsIl0HRjxD2PvQphSv7alg9+vrg
         idzlpqgNvFzuYyIGn7F56jBsDWN1CAUUn0bY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7sQ9oR+xbg8R35wvoreY201E08AeVxeiXWdeAF7cXRM=;
        b=KZprtqj5La3KmmRnUgtf4lqzXAHmi4A8qdKQ2OojUhCESkMlcKMY7VedqhxH58oV79
         wqSpUpdCzwysSNK1QQQe78TsIyb9sMLsbDwMSMVIcuWWE/j6IMLIcyX6P7OhzdRZ4jK9
         gckPRyQQ6itReaogbemzO4olp0wR5s65uq7zlxy1xQuda0b6Fdu/jM+sZ7qiXKqLHvoF
         wuN6tLVR20ssBX76E7q57DniO2JdAzngOu3HyWUN4YLmySkz71hFwrjXS1UlbO1xLtd7
         SR4/tpq1vZqeJ4LvM6sv+UT9iP95cjG472l9/TBC2ZJ/6WJwJU+wA4bDS0dt1cn8prQT
         sJ9w==
X-Gm-Message-State: AOAM532AzfES7pmq7q50JO1sYmqwUk+BfNYXg99hN+TSWRdpkII8mMm8
        N/F4A8iyJ/gGIpOCmxl+/CN4dQ==
X-Google-Smtp-Source: ABdhPJwjJqrTLcWA+nZYZEnU+6VaXKXbwTOJORpnOZ2WXLEU4bYD4BuxvIye0UbjX4g50uxPfvLoDg==
X-Received: by 2002:a63:82c7:0:b0:3f9:e153:6a54 with SMTP id w190-20020a6382c7000000b003f9e1536a54mr12840592pgd.409.1653340448097;
        Mon, 23 May 2022 14:14:08 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:d9e2:8472:9ac:8532])
        by smtp.gmail.com with UTF8SMTPSA id s17-20020a170903215100b0015e8d4eb1b7sm5571230ple.1.2022.05.23.14.14.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 14:14:07 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     Milan Broz <gmazyland@gmail.com>, dm-devel@redhat.com,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        Song Liu <song@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-security-module@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v6 3/3] dm: verity-loadpin: Use CONFIG_SECURITY_LOADPIN_VERITY for conditional compilation
Date:   Mon, 23 May 2022 14:14:00 -0700
Message-Id: <20220523141325.v6.3.I5aca2dcc3b06de4bf53696cd21329dce8272b8aa@changeid>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
In-Reply-To: <20220523211400.290537-1-mka@chromium.org>
References: <20220523211400.290537-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The verity glue for LoadPin is only needed when CONFIG_SECURITY_LOADPIN_VERITY
is set, use this option for conditional compilation instead of the combo of
CONFIG_DM_VERITY and CONFIG_SECURITY_LOADPIN.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Acked-by: Kees Cook <keescook@chromium.org>
---

Changes in v6:
- none

Changes in v5:
- added 'Acked-by' tag from Kees

Changes in v4:
- none

Changes in v3:
- none

Changes in v2:
- none

 drivers/md/Makefile               | 7 +------
 include/linux/dm-verity-loadpin.h | 2 +-
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/md/Makefile b/drivers/md/Makefile
index 71771901c823..a96441752ec7 100644
--- a/drivers/md/Makefile
+++ b/drivers/md/Makefile
@@ -83,6 +83,7 @@ obj-$(CONFIG_DM_LOG_WRITES)	+= dm-log-writes.o
 obj-$(CONFIG_DM_INTEGRITY)	+= dm-integrity.o
 obj-$(CONFIG_DM_ZONED)		+= dm-zoned.o
 obj-$(CONFIG_DM_WRITECACHE)	+= dm-writecache.o
+obj-$(CONFIG_SECURITY_LOADPIN_VERITY)	+= dm-verity-loadpin.o
 
 ifeq ($(CONFIG_DM_INIT),y)
 dm-mod-objs			+= dm-init.o
@@ -108,12 +109,6 @@ ifeq ($(CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG),y)
 dm-verity-objs			+= dm-verity-verify-sig.o
 endif
 
-ifeq ($(CONFIG_DM_VERITY),y)
-ifeq ($(CONFIG_SECURITY_LOADPIN),y)
-dm-verity-objs			+= dm-verity-loadpin.o
-endif
-endif
-
 ifeq ($(CONFIG_DM_AUDIT),y)
 dm-mod-objs			+= dm-audit.o
 endif
diff --git a/include/linux/dm-verity-loadpin.h b/include/linux/dm-verity-loadpin.h
index fb695ecaa5d5..552b817ab102 100644
--- a/include/linux/dm-verity-loadpin.h
+++ b/include/linux/dm-verity-loadpin.h
@@ -15,7 +15,7 @@ struct dm_verity_loadpin_trusted_root_digest {
 	u8 data[];
 };
 
-#if IS_ENABLED(CONFIG_SECURITY_LOADPIN) && IS_BUILTIN(CONFIG_DM_VERITY)
+#if IS_ENABLED(CONFIG_SECURITY_LOADPIN_VERITY)
 bool dm_verity_loadpin_is_bdev_trusted(struct block_device *bdev);
 #else
 static inline bool dm_verity_loadpin_is_bdev_trusted(struct block_device *bdev)
-- 
2.36.1.124.g0e6072fb45-goog

