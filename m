Return-Path: <SRS0=B0YM=BO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F12FC433E3
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Aug 2020 21:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB21A22B42
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Aug 2020 21:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OUBntpn4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbgHDVNk (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 4 Aug 2020 17:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbgHDVNj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 4 Aug 2020 17:13:39 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A727C06174A
        for <linux-security-module@vger.kernel.org>; Tue,  4 Aug 2020 14:13:39 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d1so24022132plr.8
        for <linux-security-module@vger.kernel.org>; Tue, 04 Aug 2020 14:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+GZWySK+c/FpckC7o8txfG3xJNA+g1GR4Gb26XQtvEY=;
        b=OUBntpn4bJ3qmlqkquhIO4wXoOEpaK4pFqL8u8jDAiN67w1srVaA//KD/DngKzlHO6
         TXEL5T1FfR5TQz4qWH7b3Kc9xWnLpqdBZwbl6rdpIpj/ftcSVTyXuyh3PZyII76dM310
         ZNabmiSmSyfpsUQCD5H52gnIcoT7Jc5ascsjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+GZWySK+c/FpckC7o8txfG3xJNA+g1GR4Gb26XQtvEY=;
        b=To3yFfdseMFh/uU/heSaYh86w9sQVkYbnNoHEL6X+wPszRbDkPrWTH3svcYr6K23Y1
         Y9JNLo+mOvQJaw2wNza94HeH3fyst03ZHznybsbEoT+iEv5aSZ7sRXERJqs25OtmHmxU
         hxoWTJZj2NRKglC9BGnhzjzHTUZl1DXPkGcrbgf5hvKUHmmftbmsyat0S6jiz8Ae4nwt
         RU6mlYVkqe2+imE8ihiO5B/RUvPpluAHtrRHYUkJYLgq7HsFoUTDSzHCN9+SzRY7rufi
         gZjR9AVATQS5z4mtUy0q4D2B/mMcO9dThsV369OUN8t4TKsDVT9UCNR+J7O6HgtGL092
         3UMQ==
X-Gm-Message-State: AOAM5339cYKFj2wz/TfwM8r9KxQdhAzjTYLzHnzQ1pNlVuFwAJKgmbOE
        4L+7MoCnfpvgetmR6+o6vqhQW3gM0pU=
X-Google-Smtp-Source: ABdhPJzUBxTx3lDJePIX/crEfoBdEguT/fCnIWYu78hLnHZZDvxPU+1jVcnZ+rrMEiEUsgZFa3x4JQ==
X-Received: by 2002:a17:90a:e64b:: with SMTP id ep11mr104426pjb.86.1596575618729;
        Tue, 04 Aug 2020 14:13:38 -0700 (PDT)
Received: from localhost ([2620:15c:202:200:42b0:34ff:fe3d:589e])
        by smtp.gmail.com with ESMTPSA id x28sm18090163pfj.73.2020.08.04.14.13.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2020 14:13:38 -0700 (PDT)
From:   Micah Morton <mortonm@chromium.org>
To:     linux-security-module@vger.kernel.org
Cc:     keescook@chromium.org, casey@schaufler-ca.com, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, serge@hallyn.com,
        jmorris@namei.org, Thomas Cedeno <thomascedeno@google.com>,
        Micah Morton <mortonm@chromium.org>
Subject: [PATCH v2 1/2] LSM: Signal to SafeSetID when setting group IDs
Date:   Tue,  4 Aug 2020 14:13:31 -0700
Message-Id: <20200804211331.2898420-1-mortonm@chromium.org>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <alpine.LRH.2.21.2007280444060.18670@namei.org>
References: <alpine.LRH.2.21.2007280444060.18670@namei.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Thomas Cedeno <thomascedeno@google.com>

For SafeSetID to properly gate set*gid() calls, it needs to know whether
ns_capable() is being called from within a sys_set*gid() function or is
being called from elsewhere in the kernel. This allows SafeSetID to deny
CAP_SETGID to restricted groups when they are attempting to use the
capability for code paths other than updating GIDs (e.g. setting up
userns GID mappings). This is the identical approach to what is
currently done for CAP_SETUID.

NOTE: We also add signaling to SafeSetID from the setgroups() syscall,
as we have future plans to restrict a process' ability to set
supplementary groups in addition to what is added in this series for
restricting setting of the primary group.

Signed-off-by: Thomas Cedeno <thomascedeno@google.com>
Signed-off-by: Micah Morton <mortonm@chromium.org>
---
Change since last patch: signal from setgroups() syscall as well as
set*gid() syscalls.
 kernel/capability.c |  2 +-
 kernel/groups.c     |  2 +-
 kernel/sys.c        | 10 +++++-----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/capability.c b/kernel/capability.c
index 1444f3954d75..6cfbfba65b9b 100644
--- a/kernel/capability.c
+++ b/kernel/capability.c
@@ -418,7 +418,7 @@ EXPORT_SYMBOL(ns_capable_noaudit);
 /**
  * ns_capable_setid - Determine if the current task has a superior capability
  * in effect, while signalling that this check is being done from within a
- * setid syscall.
+ * setid or setgroups syscall.
  * @ns:  The usernamespace we want the capability in
  * @cap: The capability to be tested for
  *
diff --git a/kernel/groups.c b/kernel/groups.c
index 6ee6691f6839..fe7e6385530e 100644
--- a/kernel/groups.c
+++ b/kernel/groups.c
@@ -178,7 +178,7 @@ bool may_setgroups(void)
 {
 	struct user_namespace *user_ns = current_user_ns();
 
-	return ns_capable(user_ns, CAP_SETGID) &&
+	return ns_capable_setid(user_ns, CAP_SETGID) &&
 		userns_may_setgroups(user_ns);
 }
 
diff --git a/kernel/sys.c b/kernel/sys.c
index 00a96746e28a..55e0c86772ab 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -373,7 +373,7 @@ long __sys_setregid(gid_t rgid, gid_t egid)
 	if (rgid != (gid_t) -1) {
 		if (gid_eq(old->gid, krgid) ||
 		    gid_eq(old->egid, krgid) ||
-		    ns_capable(old->user_ns, CAP_SETGID))
+		    ns_capable_setid(old->user_ns, CAP_SETGID))
 			new->gid = krgid;
 		else
 			goto error;
@@ -382,7 +382,7 @@ long __sys_setregid(gid_t rgid, gid_t egid)
 		if (gid_eq(old->gid, kegid) ||
 		    gid_eq(old->egid, kegid) ||
 		    gid_eq(old->sgid, kegid) ||
-		    ns_capable(old->user_ns, CAP_SETGID))
+		    ns_capable_setid(old->user_ns, CAP_SETGID))
 			new->egid = kegid;
 		else
 			goto error;
@@ -432,7 +432,7 @@ long __sys_setgid(gid_t gid)
 	old = current_cred();
 
 	retval = -EPERM;
-	if (ns_capable(old->user_ns, CAP_SETGID))
+	if (ns_capable_setid(old->user_ns, CAP_SETGID))
 		new->gid = new->egid = new->sgid = new->fsgid = kgid;
 	else if (gid_eq(kgid, old->gid) || gid_eq(kgid, old->sgid))
 		new->egid = new->fsgid = kgid;
@@ -744,7 +744,7 @@ long __sys_setresgid(gid_t rgid, gid_t egid, gid_t sgid)
 	old = current_cred();
 
 	retval = -EPERM;
-	if (!ns_capable(old->user_ns, CAP_SETGID)) {
+	if (!ns_capable_setid(old->user_ns, CAP_SETGID)) {
 		if (rgid != (gid_t) -1        && !gid_eq(krgid, old->gid) &&
 		    !gid_eq(krgid, old->egid) && !gid_eq(krgid, old->sgid))
 			goto error;
@@ -871,7 +871,7 @@ long __sys_setfsgid(gid_t gid)
 
 	if (gid_eq(kgid, old->gid)  || gid_eq(kgid, old->egid)  ||
 	    gid_eq(kgid, old->sgid) || gid_eq(kgid, old->fsgid) ||
-	    ns_capable(old->user_ns, CAP_SETGID)) {
+	    ns_capable_setid(old->user_ns, CAP_SETGID)) {
 		if (!gid_eq(kgid, old->fsgid)) {
 			new->fsgid = kgid;
 			if (security_task_fix_setgid(new,old,LSM_SETID_FS) == 0)
-- 
2.28.0.163.g6104cc2f0b6-goog

