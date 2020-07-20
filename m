Return-Path: <SRS0=MEX0=A7=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584C8C433E2
	for <linux-security-module@archiver.kernel.org>; Mon, 20 Jul 2020 18:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37B6222B51
	for <linux-security-module@archiver.kernel.org>; Mon, 20 Jul 2020 18:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jV/hkphv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731902AbgGTSMB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 20 Jul 2020 14:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728448AbgGTSMB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 20 Jul 2020 14:12:01 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0007CC061794
        for <linux-security-module@vger.kernel.org>; Mon, 20 Jul 2020 11:12:00 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id s26so9421728pfm.4
        for <linux-security-module@vger.kernel.org>; Mon, 20 Jul 2020 11:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RuJih62bXRWoRB6apXCaAk21wCZ6FWz4m8qssefCGJA=;
        b=jV/hkphvlfQyM3D6lQIR0w0L0LLNBGi7jskS/9Y6a3+dVS26YECjtteYfr/Mralof1
         6ljx5wGfJisqbUYVW1VwINju8OKtVNMvBc/NKXMi4eIrEplCkOmHudqLOVvue3K1PwAV
         h4GQGZqkMq5RL6PyRAeIfVF8csF7hM6Gc81Rk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RuJih62bXRWoRB6apXCaAk21wCZ6FWz4m8qssefCGJA=;
        b=hlLcK6wl7gBtY/N/RiXAcWM0YqG/9LNawFZp51bFCFRtMnkEm8ViBVSljiSPFfGsO0
         YJ+UR2U3jCIfruP1xamF1x4ito9y3ALzZ+Er5suXuq1cGJcIRuNp08vjxLPLLBeJopIv
         PSPfR5SrKGdNTj+13BbmyQLKv4hIB50x52pZQomIQgnQ3cXiu0XF1Wxv4jcO8z1mPPYM
         uw37Pru9IinX9rJ9HoRvzHzJuB9gx34pbdEEtCBKpv/3PdsfJi959iVXEEva7bHUseK8
         yDIkTI1sevul1lg9y2tB72p4uRTlY+cW9EzskR4Ln702D+8E6pZv2bA0wRZJvYqdSSG/
         HN7w==
X-Gm-Message-State: AOAM531pm2F0KRp4Z4zSck6leVxfVHwXz/sOCnTsz5fPaM8N4P+Uzuao
        mvkj6yT3pZPoJgrbHLcPngFFm8pTKIE=
X-Google-Smtp-Source: ABdhPJyTNooUtowhQbPUdsmtVV8+5cX2XZ/EYKpKDBikn19x7yDtsCXpfydLc5EqdtPhfBN0XlYuFw==
X-Received: by 2002:a63:6ca:: with SMTP id 193mr19974684pgg.269.1595268719987;
        Mon, 20 Jul 2020 11:11:59 -0700 (PDT)
Received: from localhost ([2620:15c:202:200:42b0:34ff:fe3d:589e])
        by smtp.gmail.com with ESMTPSA id u26sm16194287pgo.71.2020.07.20.11.11.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2020 11:11:59 -0700 (PDT)
From:   Micah Morton <mortonm@chromium.org>
To:     linux-security-module@vger.kernel.org
Cc:     keescook@chromium.org, casey@schaufler-ca.com, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, serge@hallyn.com,
        jmorris@namei.org, Thomas Cedeno <thomascedeno@google.com>,
        Micah Morton <mortonm@chromium.org>
Subject: [PATCH 1/2] LSM: Signal to SafeSetID when in set*gid syscall
Date:   Mon, 20 Jul 2020 11:11:56 -0700
Message-Id: <20200720181156.1461461-1-mortonm@chromium.org>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
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

Signed-off-by: Thomas Cedeno <thomascedeno@google.com>
Signed-off-by: Micah Morton <mortonm@chromium.org>
---
 kernel/sys.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

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
2.28.0.rc0.105.gf9edc3c819-goog
