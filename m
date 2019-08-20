Return-Path: <SRS0=y35J=WQ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F926C3A5A0
	for <linux-security-module@archiver.kernel.org>; Tue, 20 Aug 2019 00:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55D2D22CF8
	for <linux-security-module@archiver.kernel.org>; Tue, 20 Aug 2019 00:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s+DzVRUa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbfHTASj (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 19 Aug 2019 20:18:39 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:48837 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728985AbfHTASh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 19 Aug 2019 20:18:37 -0400
Received: by mail-pf1-f202.google.com with SMTP id t14so3521446pfq.15
        for <linux-security-module@vger.kernel.org>; Mon, 19 Aug 2019 17:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dNVh2iEH8Vj5QaP2UTGBHWYWiLKLUyALWKFvKJ3rNPk=;
        b=s+DzVRUaCC07PkCzszpSdYfvTDGl8hxUTCDu/FpF5b4WNQAmCbk6BOrwtJXUoFR6Uz
         qKm/vW6UcajgcQNbuCy/wUqoTzb68lOw8pytLYFdDjt3L0bszBv6MJlhpX/W5PUC9TpY
         8AX7s/PxVrj8PbsOCZi0M6Dwr0BexH+KjnuS/B9q0DCyAkJ9k9Og7T4oCTwqUM3loX8X
         APyKduoOLI+CQCWk+EDINB1/1Sy/dGLCuGyBGFyMwA8wNU1tWivpS7m1mJNEdM/ahsl+
         888b9JvYy2AlusJGjtmnpS9xM8sUy6qm69rS3ahSS5Hw/shTovUguhjEUiK5vOG3eo0m
         1c+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dNVh2iEH8Vj5QaP2UTGBHWYWiLKLUyALWKFvKJ3rNPk=;
        b=q5gNimmkXC0vEaIektxpXuOFmL954kLsvngtz+twsf8CVPLNSDI0UJpFm5dVpjLK6g
         XZGX/L4bVdLbr2O3qr/+a8ZIfoivOK/ymJuOkjh6PtIWAROjS73+jBJ7VSplXMmAg6fW
         vjdvz4Ecly43WMa5IcqzuETgb1RhQQKTBsBSyzMXlBA2hkcZwBbVfuNys4xUrLBtbHmN
         rpa1uz5sly5kgjkGx4kUdmskhM0BUhwstXzTBYYdLPUfYkxdpQC5N9M2T7VHB+8YeKTL
         tXcBq9boz5PUO9/8sn0DFS1ZxrYdjWZDvK7Tb/lsvSLs29XL9VuI7h0whrfXAracMYcE
         l1FA==
X-Gm-Message-State: APjAAAWf4DQGZRItCCfdC46BPV3PWGwBcwHg74OE609Vz4DIDgCoMjEQ
        fpEs1X/iJWEKToVNspvrSoVheqSkXiVfXTbXHz41ng==
X-Google-Smtp-Source: APXvYqw50UpcJtkF5rTCGf6S95KEpqO+4K8LOnMXigUv6lRcqmdRjDrchpQ3c4/aZXcS0zPEWytHlafdl8iJSlsaMVhMZg==
X-Received: by 2002:a63:e48:: with SMTP id 8mr21980312pgo.389.1566260316132;
 Mon, 19 Aug 2019 17:18:36 -0700 (PDT)
Date:   Mon, 19 Aug 2019 17:17:46 -0700
In-Reply-To: <20190820001805.241928-1-matthewgarrett@google.com>
Message-Id: <20190820001805.241928-11-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190820001805.241928-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH V40 10/29] hibernate: Disable when the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Josh Boyer <jwboyer@fedoraproject.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>, rjw@rjwysocki.net,
        pavel@ucw.cz, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Josh Boyer <jwboyer@fedoraproject.org>

There is currently no way to verify the resume image when returning
from hibernate.  This might compromise the signed modules trust model,
so until we can work with signed hibernate images we disable it when the
kernel is locked down.

Signed-off-by: Josh Boyer <jwboyer@fedoraproject.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: rjw@rjwysocki.net
Cc: pavel@ucw.cz
cc: linux-pm@vger.kernel.org
Signed-off-by: James Morris <jmorris@namei.org>
---
 include/linux/security.h     | 1 +
 kernel/power/hibernate.c     | 3 ++-
 security/lockdown/lockdown.c | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index b607a8ac97fe..80ac7fb27aa9 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -106,6 +106,7 @@ enum lockdown_reason {
 	LOCKDOWN_MODULE_SIGNATURE,
 	LOCKDOWN_DEV_MEM,
 	LOCKDOWN_KEXEC,
+	LOCKDOWN_HIBERNATION,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index cd7434e6000d..3c0a5a8170b0 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -30,6 +30,7 @@
 #include <linux/ctype.h>
 #include <linux/genhd.h>
 #include <linux/ktime.h>
+#include <linux/security.h>
 #include <trace/events/power.h>
 
 #include "power.h"
@@ -68,7 +69,7 @@ static const struct platform_hibernation_ops *hibernation_ops;
 
 bool hibernation_available(void)
 {
-	return (nohibernate == 0);
+	return nohibernate == 0 && !security_locked_down(LOCKDOWN_HIBERNATION);
 }
 
 /**
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index aaf30ad351f9..3462f7edcaac 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -21,6 +21,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_MODULE_SIGNATURE] = "unsigned module loading",
 	[LOCKDOWN_DEV_MEM] = "/dev/mem,kmem,port",
 	[LOCKDOWN_KEXEC] = "kexec of unsigned images",
+	[LOCKDOWN_HIBERNATION] = "hibernation",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.23.0.rc1.153.gdeed80330f-goog

