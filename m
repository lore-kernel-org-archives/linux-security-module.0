Return-Path: <SRS0=pW3O=MX=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD52DC43441
	for <linux-security-module@archiver.kernel.org>; Thu, 11 Oct 2018 00:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 842AB20841
	for <linux-security-module@archiver.kernel.org>; Thu, 11 Oct 2018 00:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mhtBdzE+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 842AB20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbeJKHoR (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 11 Oct 2018 03:44:17 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39848 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727277AbeJKHnm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 11 Oct 2018 03:43:42 -0400
Received: by mail-pg1-f196.google.com with SMTP id r9-v6so3274991pgv.6
        for <linux-security-module@vger.kernel.org>; Wed, 10 Oct 2018 17:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GuIJ8XJ4isc39j9FCpw3e0aw5+nW65wvPHXUlrmcc7Y=;
        b=mhtBdzE+++HD8ZlJoh9Sh0lv152Wzv0XGlfdoeoVj/D32O41aK7MS3Rnda2A+qODA4
         Qrtnl5zHcJjkVY0W3YVUHVY6xRjOu9KcQX0A9xYhnJ/gGZTbh0I5BYOJHFqBeSSiV/fs
         A2G5p2YQxlN9jUuRqSEWvuI/VAQoq+e1ylRS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GuIJ8XJ4isc39j9FCpw3e0aw5+nW65wvPHXUlrmcc7Y=;
        b=cZ7DD1xFMWL6yKSDagByOUXsjpslX0IX0LN8jEtctsMGFirg+EN8CQii5iohvAubt4
         eACzfMloe7CHUdtX0Nw4k28RmHU/I9kSs31Nq+kB5E7WoBCUXqrqE/mRcIQtIdfadwu+
         mU+sX9Ib5ooOFyrxumcua1QWG6cQ+JUTHmid8Mn0rWaujKwb8WfcamU0beFlU9hOva7s
         usDy+Z6M6/1iI8rgJuEBwO8mUqqledVb7NV1t47tEZv+IpQad+8BKg40g/5HGX0M8wSf
         bFsKKUTkN24PFTX6blnmSNEyyTaRQ6HNN0+nKUfocaLEqDi9nw9hsE+CJ2SHORx3rCQd
         BHVQ==
X-Gm-Message-State: ABuFfojLmgwFN+nP5ea2iZ01wp2L6Hmcl1Rx/9zTgRBWm5bfwNrI6ZBt
        m/uBc+jkrkMhGekUFROrlvblYg==
X-Google-Smtp-Source: ACcGV627jaDsqj2WS45TJpj57mDCEEoEjxz2qpKKlMB5C0fElqT6SNaIE4E9x/uZC/smsv9yjDYbMw==
X-Received: by 2002:a62:c80d:: with SMTP id z13-v6mr36366057pff.176.1539217147856;
        Wed, 10 Oct 2018 17:19:07 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id y185-v6sm26488288pgd.8.2018.10.10.17.18.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 17:19:06 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     James Morris <jmorris@namei.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jordan Glover <Golden_Miller83@protonmail.ch>,
        LSM <linux-security-module@vger.kernel.org>,
        linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH security-next v5 14/30] LSM: Plumb visibility into optional "enabled" state
Date:   Wed, 10 Oct 2018 17:18:30 -0700
Message-Id: <20181011001846.30964-15-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181011001846.30964-1-keescook@chromium.org>
References: <20181011001846.30964-1-keescook@chromium.org>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

In preparation for lifting the "is this LSM enabled?" logic out of the
individual LSMs, pass in any special enabled state tracking (as needed
for SELinux, AppArmor, and LoadPin). This should be an "int" to include
handling any future cases where "enabled" is exposed via sysctl which
has no "bool" type.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johansen@canonical.com>
---
 include/linux/lsm_hooks.h | 1 +
 security/apparmor/lsm.c   | 5 +++--
 security/selinux/hooks.c  | 1 +
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 531e219a49b9..6ec5a0266f21 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2044,6 +2044,7 @@ extern void security_add_hooks(struct security_hook_list *hooks, int count,
 struct lsm_info {
 	const char *name;	/* Required. */
 	unsigned long flags;	/* Optional: flags describing LSM */
+	int *enabled;		/* Optional: NULL means enabled. */
 	int (*init)(void);	/* Required. */
 };
 
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 768cb539fb6c..6ace45704cb6 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1303,8 +1303,8 @@ bool aa_g_paranoid_load = true;
 module_param_named(paranoid_load, aa_g_paranoid_load, aabool, S_IRUGO);
 
 /* Boot time disable flag */
-static bool apparmor_enabled = CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE;
-module_param_named(enabled, apparmor_enabled, bool, S_IRUGO);
+static int apparmor_enabled = CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE;
+module_param_named(enabled, apparmor_enabled, int, 0444);
 
 static int __init apparmor_enabled_setup(char *str)
 {
@@ -1609,5 +1609,6 @@ static int __init apparmor_init(void)
 DEFINE_LSM(apparmor) = {
 	.name = "apparmor",
 	.flags = LSM_FLAG_LEGACY_MAJOR,
+	.enabled = &apparmor_enabled,
 	.init = apparmor_init,
 };
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 020886895819..e8da99550b67 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7205,6 +7205,7 @@ void selinux_complete_init(void)
 DEFINE_LSM(selinux) = {
 	.name = "selinux",
 	.flags = LSM_FLAG_LEGACY_MAJOR,
+	.enabled = &selinux_enabled,
 	.init = selinux_init,
 };
 
-- 
2.17.1

