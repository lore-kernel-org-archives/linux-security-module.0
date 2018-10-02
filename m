Return-Path: <SRS0=hMH8=MO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0657EC00449
	for <linux-security-module@archiver.kernel.org>; Tue,  2 Oct 2018 00:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE65421471
	for <linux-security-module@archiver.kernel.org>; Tue,  2 Oct 2018 00:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fz8BZfZa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE65421471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbeJBHgb (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 2 Oct 2018 03:36:31 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37610 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbeJBHfw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 2 Oct 2018 03:35:52 -0400
Received: by mail-io1-f66.google.com with SMTP id v14-v6so258851iob.4
        for <linux-security-module@vger.kernel.org>; Mon, 01 Oct 2018 17:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yHtJ2wuDy6KMLinmeN4owhKSAddTYrZKj9GP/zJS5B4=;
        b=fz8BZfZa7kysx36t19lEgnIlujgOgkFa0SDeAA5Kck4pL7Ilj1O+THG/QtOHonUxiY
         K70+JPGMU6Z08jJJPSPlPqluwt7rz2qA09NyJpRkKyYymVeI3WgPSLcNkbK+u9fAEX5p
         Lzj6gStUL6mvA/WCs1BVRY4bwyJe9Ev3pxMoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yHtJ2wuDy6KMLinmeN4owhKSAddTYrZKj9GP/zJS5B4=;
        b=msqVXgZcl267E6RweF36e95Q0XpCFdvKilDyvTgTyKvkEYQ7HH6cptflhyjv80SwLy
         DBw7GWXD9qju3aefUMQ7Et7HBaV1j7LzaOEGAOQ+wg/6uCA36DchP+p2TmPDsXJCNI1x
         fFNC8ReMRqLtB3ca6PAfJVHO215EGdvHCzSwy6vQQkAL+IiA6crVXoGTq1h6sBep6EoH
         Z6uUEGIvZ6Rk27r35IU1fTdsIs0fgzoMF+eMdopvfUHgtSLsGRlrl64jsyyUDBILTN6G
         zO6UoRGToHHmOKSNRA8AIrPwjfeqyujzYpuAjppcS/Ujkjm4oB+KZpuFpT6cAWUnhUBt
         xeBA==
X-Gm-Message-State: ABuFfogezKSZByBcqsAyZBGNw77JFM0pbdVmBFNvJuk3y4TSZ2EIH4KH
        VRc3y7tCB4xcGgguWK5M25gDbw==
X-Google-Smtp-Source: ACcGV62sI07MEVw1999TfYH0C4ErRRB1buRpcbCehCsIoxwtmnl3SUI6q6A9fqcJzUv2zCyVS1b6gQ==
X-Received: by 2002:a62:6f43:: with SMTP id k64-v6mr13593168pfc.87.1538441723543;
        Mon, 01 Oct 2018 17:55:23 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id k13-v6sm13784231pff.30.2018.10.01.17.55.13
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
Subject: [PATCH security-next v4 11/32] LSM: Introduce LSM_FLAG_LEGACY_MAJOR
Date:   Mon,  1 Oct 2018 17:54:44 -0700
Message-Id: <20181002005505.6112-12-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181002005505.6112-1-keescook@chromium.org>
References: <20181002005505.6112-1-keescook@chromium.org>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This adds a flag for the current "major" LSMs to distinguish them when
we have a universal method for ordering all LSMs. It's called "legacy"
since the distinction of "major" will go away in the blob-sharing world.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johansen@canonical.com>
---
 include/linux/lsm_hooks.h  | 3 +++
 security/apparmor/lsm.c    | 1 +
 security/selinux/hooks.c   | 1 +
 security/smack/smack_lsm.c | 1 +
 security/tomoyo/tomoyo.c   | 1 +
 5 files changed, 7 insertions(+)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index ae159b02f3ab..531e219a49b9 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2039,8 +2039,11 @@ extern char *lsm_names;
 extern void security_add_hooks(struct security_hook_list *hooks, int count,
 				char *lsm);
 
+#define LSM_FLAG_LEGACY_MAJOR	BIT(0)
+
 struct lsm_info {
 	const char *name;	/* Required. */
+	unsigned long flags;	/* Optional: flags describing LSM */
 	int (*init)(void);	/* Required. */
 };
 
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index dca4b7dbf368..768cb539fb6c 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1608,5 +1608,6 @@ static int __init apparmor_init(void)
 
 DEFINE_LSM(apparmor) = {
 	.name = "apparmor",
+	.flags = LSM_FLAG_LEGACY_MAJOR,
 	.init = apparmor_init,
 };
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 9651bccae270..020886895819 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7204,6 +7204,7 @@ void selinux_complete_init(void)
    all processes and objects when they are created. */
 DEFINE_LSM(selinux) = {
 	.name = "selinux",
+	.flags = LSM_FLAG_LEGACY_MAJOR,
 	.init = selinux_init,
 };
 
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 2fb56bcf1316..db8bc6b6d8b0 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4884,5 +4884,6 @@ static __init int smack_init(void)
  */
 DEFINE_LSM(smack) = {
 	.name = "smack",
+	.flags = LSM_FLAG_LEGACY_MAJOR,
 	.init = smack_init,
 };
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 1b5b5097efd7..09f7af130d3a 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -552,5 +552,6 @@ static int __init tomoyo_init(void)
 
 DEFINE_LSM(tomoyo) = {
 	.name = "tomoyo",
+	.flags = LSM_FLAG_LEGACY_MAJOR,
 	.init = tomoyo_init,
 };
-- 
2.17.1

