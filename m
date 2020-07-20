Return-Path: <SRS0=MEX0=A7=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C7DC433EA
	for <linux-security-module@archiver.kernel.org>; Mon, 20 Jul 2020 09:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6009D21775
	for <linux-security-module@archiver.kernel.org>; Mon, 20 Jul 2020 09:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQOdvQc0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbgGTJOq (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 20 Jul 2020 05:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728069AbgGTJOq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 20 Jul 2020 05:14:46 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E00AC061794
        for <linux-security-module@vger.kernel.org>; Mon, 20 Jul 2020 02:14:45 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id c80so21524207wme.0
        for <linux-security-module@vger.kernel.org>; Mon, 20 Jul 2020 02:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fiStrsNp0Nn8CO2onfVP2auDZ4lB9LnkFmz5jiXy/SM=;
        b=gQOdvQc0/Cssvayo3Ym3kvrz9uXGhBbrG9Qb0iJv4zyywxgFqXg0CJS4CJad+PzOV8
         Dx7Njm35IBUbeHglAtUJqN6slwdlolh8dg4Q15NyiKIJzELWYMAHOp0hKaanekVdcjH4
         vGCFrQm0JXxlKez1gzPw58P8XynkxTuXAarwj145QdXuPEnYc1o03h3xUM3pu4SKyaV0
         WJhuhkga5lXQVwZtD6FgvZ2nAtgu+YZyJ8t10uZSp1MepPTPiKzZKbSTWAyXZ2sw4EVr
         jpBr1MRic7Q92fa3MuMzFQXfyH6mT01gyEXvP7wjaJOlZI602zqjbCO0lasJfqVwCYE3
         LXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fiStrsNp0Nn8CO2onfVP2auDZ4lB9LnkFmz5jiXy/SM=;
        b=B7QdJI0nqW3Ll89fRV5RPDHIcozwnnrok2zfkxaqZRBO4JwBHai0TgQXf7oe/ZtjyT
         0SzWvDWWoHmhpbajqgupNpBkwexVPYBcPgOkNI/Z6LHRi/N7HcuQWD7hKqJxkaD4ca32
         403OR6g5jkfZtELJRbgNBB8boCWtFPWoUUgWy74pp65UL8zUH6tbglbcWF+C+g8hvpse
         e40gF5PdccY2E0AU3q/W0yE2uuApmb4KcAcCBTDPcNPlf7TVm3N6c8pNugs35fZrG5aB
         x/cllDerA9hqkbYcaI3ApLaoXlSB3hhzT3Qd3HZWrOjTSXBhVysnOwnq3pWZML05eota
         3PNA==
X-Gm-Message-State: AOAM5328MoqiGZMI+oRTd9ig2hEOT/dbAx+gFQPqXP7r79BAzkmpmjI8
        hVmAy4JNUkhV2iHPM/TAX10=
X-Google-Smtp-Source: ABdhPJx9G1vCJbWN6Frd58VfvUTQxw+5ImAKfmh4vWcnb8LQ1T4ArKg7vivUGSh9bDTEW4+Y1CSsbw==
X-Received: by 2002:a05:600c:21cb:: with SMTP id x11mr19595289wmj.141.1595236484297;
        Mon, 20 Jul 2020 02:14:44 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:3adb:8201:9649:88f:51f8:6a21])
        by smtp.gmail.com with ESMTPSA id w16sm34375905wrg.95.2020.07.20.02.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 02:14:43 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Andrew Morgan <morgan@kernel.org>
Cc:     linux-security-module@vger.kernel.org
Subject: [PATCH 13/15] Manual pages: cap_get_proc.3: Update description of capsetp()
Date:   Mon, 20 Jul 2020 11:13:26 +0200
Message-Id: <20200720091328.290336-14-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200720091328.290336-1-mtk.manpages@gmail.com>
References: <20200720091328.290336-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The details currently provided for capsetp() were current before 2008,
but ceased to be accurate with the 2008 addition of VFS file
capabilities in 2008. Update the text accordingly.

At the same time, add a subheading, a few paragraph breaks, and a few
other wording tweaks to make the description of capgetp() and capsetp()
more readable.

Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 doc/cap_get_proc.3 | 40 +++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/doc/cap_get_proc.3 b/doc/cap_get_proc.3
index fce8f59..40475fd 100644
--- a/doc/cap_get_proc.3
+++ b/doc/cap_get_proc.3
@@ -251,7 +251,7 @@ or,
 When linked this way, due to linker magic, libcap uses
 .BR psx_syscall "(3) and " psx_syscall6 (3)
 to perform state setting system calls.
-.PP
+.SS capgetp() and capsetp()
 The library also supports the deprecated functions:
 .PP
 .BI "int capgetp(pid_t " pid ", cap_t " cap_d );
@@ -264,14 +264,20 @@ capabilities in a pre-allocated
 .IR cap_d .
 See
 .BR cap_init ()
-for information on allocating an empty capability set. This function,
-.BR capgetp (),
-is deprecated, you should use
+for information on allocating an empty capability set. This function
+is deprecated; you should use
 .BR cap_get_pid ().
 .PP
 .BR capsetp ()
-attempts to set the capabilities of some other process(es),
-.IR pid . 
+attempts to set the capabilities of the calling porcess or of
+some other process(es),
+.IR pid .
+Note that setting capabilities of another process is only possible on older
+kernels that do not provide VFS support for setting file capabilities.
+See
+.BR capset (2)
+for information on which kernels provide such support.
+.PP
 If
 .I pid
 is positive it refers to a specific process;  if it is zero, it refers
@@ -280,29 +286,37 @@ calling process and process '1' (typically
 .BR init (8));
 other negative values refer to the
 .I \-pid
-process group.  In order to use this function, the kernel must support
+process group.
+.PP
+In order to use this function, the kernel must support
 it and the calling process must have
 .B CAP_SETPCAP
 raised in its Effective capability set. The capabilities set in the
 target process(es) are those contained in
 .IR cap_d .
+.PP
 Kernels that support filesystem capabilities redefine the semantics of
 .B CAP_SETPCAP
-and on such systems this function will always fail for any target not
+and on such systems,
+.BR capsetp ()
+will always fail for any target not
 equal to the calling process.
 .BR capsetp ()
 returns zero for success, and \-1 on failure.
-
-Where supported by the kernel, the function
+.PP
+On kernels where it is (was) supported,
 .BR capsetp ()
 should be used with care.  It existed, primarily, to overcome an early
 lack of support for capabilities in the filesystems supported by
-Linux.  Note that, by default, the only processes that have
+Linux.  Note that on older kernels where
+.BR capsetp ()
+could be used to set the capabilities of another process,
+the only processes that had
 .B CAP_SETPCAP
-available to them are processes started as a kernel thread.
+available to them by default were processes started as kernel threads.
 (Typically this includes
 .BR init (8),
-kflushd and kswapd.) You will need to recompile the kernel to modify
+kflushd and kswapd.) A kernel recompilation was needed to modify
 this default.
 .SH EXAMPLE
 The code segment below raises the
-- 
2.26.2

