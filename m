Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2741C6FA8B
	for <linux-security-module@archiver.kernel.org>; Wed, 21 Sep 2022 18:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiIUSyk (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 21 Sep 2022 14:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiIUSyi (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 21 Sep 2022 14:54:38 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AD2E0E
        for <linux-security-module@vger.kernel.org>; Wed, 21 Sep 2022 11:54:36 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id y136so6880109pfb.3
        for <linux-security-module@vger.kernel.org>; Wed, 21 Sep 2022 11:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=jK3cCVvYXVI3ziFoo3EnFyFkXzLIrWQrqxs895hv1a0=;
        b=enOyzQ57e3A4O3wLFNumC5C3eaGRcZ2mr9Xnr8o8EnfnJcICXF2gJbK1NuOGJxs5AF
         hw+//bWGllgqXjhMwpLuyfpFd6dPvIqS9rg2Fa0NkQiMVkLzhxgRN9mrrIqTK4fuYWtx
         uZyzBWdaJENupy9wgGjqJtJOxoXoEa1IODhkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=jK3cCVvYXVI3ziFoo3EnFyFkXzLIrWQrqxs895hv1a0=;
        b=S6oxQffEqly6EkHa1BEchcMqeV3aIdjbHSbDLT4EI58w0jMp1v2RMTwoSW2PAZh+MN
         s1pm1AJNgDOHQckDWVTX/WSRvqXP4QLZ/wBHgHSIL7/3aZNfsWP+BkQ5SEskuibosSrb
         bIBPWBhBZrWL8PjzfQJopYqbH4r33bi7wa3LkMJU1Vrq0NWyHjBaSc5Q0vVm755YNOQv
         hbUdOBYB2HZVi5b33LPYbT7T3mNU1eLRUN9/ZBBHMOIWAE1nxy/c+q4LJdjz/h46ns4W
         aB+/ZMMsScExmPaJbJkoC0+hOC3volP3wtoCgnUxKZbvDOCtraM4ilkyzDr26WqENqUv
         XwXQ==
X-Gm-Message-State: ACrzQf3UNwFd196Qrf0jXzV8QSuGnZPpWUTknbPAVqQiiuxlLJkUdw6V
        /oMv9P/QxshdtajV/0psT6VIdg==
X-Google-Smtp-Source: AMsMyM7wqemWkHF+78kACyh88D7dVH7iHJPj/P/LlUZ6ljXIIz30E+nf8XsuY9M3NkSHxS7v1U90EA==
X-Received: by 2002:a05:6a00:23d3:b0:548:45c:4f9f with SMTP id g19-20020a056a0023d300b00548045c4f9fmr30381509pfc.62.1663786476347;
        Wed, 21 Sep 2022 11:54:36 -0700 (PDT)
Received: from jeffxud.c.googlers.com.com (30.202.168.34.bc.googleusercontent.com. [34.168.202.30])
        by smtp.gmail.com with ESMTPSA id y6-20020a17090322c600b0016ed8af2ec0sm2430838plg.29.2022.09.21.11.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 11:54:36 -0700 (PDT)
From:   jeffxu@chromium.org
To:     selinux@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org, jorgelo@chromium.org,
        groeck@chromium.org, Jeff Xu <jeffxu@chromium.org>,
        Luis Hector Chavez <lhchavez@google.com>,
        Luis Hector Chavez <lhchavez@chromium.org>
Subject: [PATCH 1/1] Add CONFIG_SECURITY_SELINUX_PERMISSIVE_DONTAUDIT
Date:   Wed, 21 Sep 2022 18:54:26 +0000
Message-Id: <20220921185426.1663357-2-jeffxu@chromium.org>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
In-Reply-To: <20220921185426.1663357-1-jeffxu@chromium.org>
References: <20220921185426.1663357-1-jeffxu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Jeff Xu <jeffxu@chromium.org>

When SECURITY_SELINUX_DEVELOP=y and the system is running in permissive
mode, it is useful to disable logging from permissive domain, so audit
log does not get spamed.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
Signed-off-by: Luis Hector Chavez <lhchavez@google.com>
Tested-by: Luis Hector Chavez <lhchavez@chromium.org>
Tested-by: Jeff Xu<jeffxu@chromium.org>
---
 security/selinux/Kconfig | 10 ++++++++++
 security/selinux/avc.c   |  9 +++++++++
 2 files changed, 19 insertions(+)

diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
index 9e921fc72538..99b8b88abc3d 100644
--- a/security/selinux/Kconfig
+++ b/security/selinux/Kconfig
@@ -61,6 +61,16 @@ config SECURITY_SELINUX_DEVELOP
 	  permissive mode (if permitted by the policy) via
 	  /sys/fs/selinux/enforce.
 
+config SECURITY_SELINUX_PERMISSIVE_DONTAUDIT
+	bool "NSA SELinux don't audit permissive"
+	depends on SECURITY_SELINUX
+	default n
+	help
+	  This prevents logging when permissive=1.  If unsure, say N.  With
+	  this option enabled, any avc logs that would occur on a permissive
+	  domain won't be logged.  This can prevent a significant amount of
+	  logspam.
+
 config SECURITY_SELINUX_AVC_STATS
 	bool "NSA SELinux AVC Statistics"
 	depends on SECURITY_SELINUX
diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 9a43af0ebd7d..2f0a49d7c714 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -777,6 +777,15 @@ noinline int slow_avc_audit(struct selinux_state *state,
 	if (WARN_ON(!tclass || tclass >= ARRAY_SIZE(secclass_map)))
 		return -EINVAL;
 
+	/*
+	 * Avoid logging permissive=1 messages for
+	 * SECURITY_SELINUX_PERMISSIVE_DONTAUDIT.
+	 */
+	if (IS_ENABLED(CONFIG_SECURITY_SELINUX_PERMISSIVE_DONTAUDIT) && denied
+	    && !result) {
+		return 0;
+	}
+
 	if (!a) {
 		a = &stack_data;
 		a->type = LSM_AUDIT_DATA_NONE;
-- 
2.37.3.968.ga6b4b080e4-goog

