Return-Path: <SRS0=pW3O=MX=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2260C43441
	for <linux-security-module@archiver.kernel.org>; Thu, 11 Oct 2018 00:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7990720841
	for <linux-security-module@archiver.kernel.org>; Thu, 11 Oct 2018 00:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HLor249i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7990720841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbeJKHnk (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 11 Oct 2018 03:43:40 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39844 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbeJKHnj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 11 Oct 2018 03:43:39 -0400
Received: by mail-pg1-f195.google.com with SMTP id r9-v6so3274953pgv.6
        for <linux-security-module@vger.kernel.org>; Wed, 10 Oct 2018 17:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yHtJ2wuDy6KMLinmeN4owhKSAddTYrZKj9GP/zJS5B4=;
        b=HLor249iQGUkqWngqbljMZtySuE21yUrEo0+FI/u0LOXzuv/6lTKBCef2FuTyuR/Pk
         nI/yxw0K6UCn5sJ8iCEHYlBak0gI1eLnwyyhNXEiyJSmo7+PUrYgoI2ol+beypahuyZ8
         X15efCIUr/3Uy25+Xasnz+S67i3LADfaF6thU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yHtJ2wuDy6KMLinmeN4owhKSAddTYrZKj9GP/zJS5B4=;
        b=Z8XfWXTXnAYRm91WjmkROxVxKNXi9WtbDch95GC+r5QMdLz9Knub4wArDuIcWYXtXf
         w3qpvuWRyTVPHVPGZzaTICYN3uLn/2tH2bKZbm5taQk3mmP1gz0Al6mtcc69xUcdMbW/
         BaOkJV4k+OHdd/in3HJGeqfqMIHs5mE75omOMGXbjt3zrdm/RUobnaO3b8laaH/2fFhF
         6i3FJEo2+JcH/tQToKUIwgsL/bYbYuwbUS8FZc3IbrMc6Us6rqsmD8AWI4Eax9tpc/Oe
         Q9tcje5hID6Z6QtrpDjTxHWX7Elv4xIUZ5uel7+mCwsfQGh+dfP8x3bAWvLu8iNdhy6J
         VSLQ==
X-Gm-Message-State: ABuFfogYqYI+3f2kIjMyZdJDLOMa7Su/kevx1hMFizapi13UOWqlRDfd
        67GQebpzraflVvK83+lG5nuiQQ==
X-Google-Smtp-Source: ACcGV610vd06UCWYQXRHpRCxKnvZYdjvbxPoXNFqhJTYaKgw2nLO/SdmzjE53vLw3NbcnCdeFqN3fQ==
X-Received: by 2002:a63:d40c:: with SMTP id a12-v6mr31304706pgh.394.1539217145485;
        Wed, 10 Oct 2018 17:19:05 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id b3-v6sm40544447pfc.178.2018.10.10.17.18.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 17:18:58 -0700 (PDT)
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
Subject: [PATCH security-next v5 11/30] LSM: Introduce LSM_FLAG_LEGACY_MAJOR
Date:   Wed, 10 Oct 2018 17:18:27 -0700
Message-Id: <20181011001846.30964-12-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181011001846.30964-1-keescook@chromium.org>
References: <20181011001846.30964-1-keescook@chromium.org>
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

