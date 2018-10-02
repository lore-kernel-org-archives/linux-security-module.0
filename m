Return-Path: <SRS0=hMH8=MO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B9FC64EB5
	for <linux-security-module@archiver.kernel.org>; Tue,  2 Oct 2018 00:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D47B21473
	for <linux-security-module@archiver.kernel.org>; Tue,  2 Oct 2018 00:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CuxSHfsD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D47B21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbeJBHfy (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 2 Oct 2018 03:35:54 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:38933 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbeJBHfx (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 2 Oct 2018 03:35:53 -0400
Received: by mail-it1-f196.google.com with SMTP id w200-v6so1058469itc.4
        for <linux-security-module@vger.kernel.org>; Mon, 01 Oct 2018 17:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GuIJ8XJ4isc39j9FCpw3e0aw5+nW65wvPHXUlrmcc7Y=;
        b=CuxSHfsD1cK63yfLs77GsspgNj1Sjqx+pqe1wm82ZI4DW+MB+RvKdmazurfvixfZjD
         usFNIZJ+i3hD1VgwaEpzWSXfBMgSbLuexR2i7RAR/Wm7hy945lR2SgzWrtWLJKpcFfGG
         63/PDDWthnmD8+q2ebNMqF7yTSbz6UYababf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GuIJ8XJ4isc39j9FCpw3e0aw5+nW65wvPHXUlrmcc7Y=;
        b=aj1jBM7MSNqd3b4wW6ggvN4YzDiYiT5a49fq+FEydDJAjFP8x8OykpSAOeuQ1BA6dl
         Tvz7Bu9IgahSmCyZkzaH8GGi/4eSmFhpexR19xCLUbuj/aco/jO+cLP3E0ffM6oe74yd
         zQFqiSMe37AyXIrIFzqO7ZPLFQ9ZkwOEj3OgKcIUFyMJ7hSwYK/yffwATZz6+iGGexjr
         PrE+MwIyUt0rvcHUMLZ8hRNLZGrBIAjZMqUBHJSH7mFY5nxm5bhcMRMJZ1WWJfcNjSTe
         4AR2uQD/U3BEhqWZ3NxN7kyKCygjkTpITVVM3E9w4ujiuI+M3eyK7a1BbHAcisCaaVDk
         Wmbw==
X-Gm-Message-State: ABuFfoi6kwNrmI94x5e1c7taUpZ7nU9bWCyT1Fi/7YiA/4+42AZUjLoJ
        jCmiIuXPzYTN12Es2c8UqyFm7w==
X-Google-Smtp-Source: ACcGV63rHsPCCi0ZOzevwrITA+//cgllt92R0mGqT5UZTBwzMO4V1Ca8XO1r/Muhiz1Hm9frCk5z2w==
X-Received: by 2002:a65:48cc:: with SMTP id o12-v6mr12066432pgs.22.1538441724471;
        Mon, 01 Oct 2018 17:55:24 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id 70-v6sm22142717pfz.27.2018.10.01.17.55.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 17:55:19 -0700 (PDT)
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
Subject: [PATCH security-next v4 14/32] LSM: Plumb visibility into optional "enabled" state
Date:   Mon,  1 Oct 2018 17:54:47 -0700
Message-Id: <20181002005505.6112-15-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181002005505.6112-1-keescook@chromium.org>
References: <20181002005505.6112-1-keescook@chromium.org>
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

