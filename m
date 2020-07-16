Return-Path: <SRS0=RuUe=A3=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481ADC433F4
	for <linux-security-module@archiver.kernel.org>; Thu, 16 Jul 2020 10:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21FB22074B
	for <linux-security-module@archiver.kernel.org>; Thu, 16 Jul 2020 10:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1T6r4G7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgGPKTg (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 Jul 2020 06:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbgGPKTg (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Jul 2020 06:19:36 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B751BC061755
        for <linux-security-module@vger.kernel.org>; Thu, 16 Jul 2020 03:19:35 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id r12so6390529wrj.13
        for <linux-security-module@vger.kernel.org>; Thu, 16 Jul 2020 03:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q7nrzKhEx+ExyWTwvGOL5rHVm6h72RsBmFQBL97mcHQ=;
        b=d1T6r4G7cXv6kd3vakUzOlS3HIo5WyOjcLAag+DgXJ0iAvxMOc6yJ8qm7T+STElZBd
         l0KR3Xx6RcueTTd4vvfY2Xb5wrEkDe/3+SFe9r+p1uhGtssohYOQxj0LZQT0IgwG2gcw
         dX39wxh4FWtTqtCn2xoQBB/wPhTJ7YWX1uKEVNXptm46FLOwxYdF+2GzyQpEakwFnpIs
         piOo818H+VdH4kQ91aVdmaNnXpppsQIrsxN3fV7hNsiE4k7rFJata6nkGH6HwLqlQTcq
         0GUbBlevhIOQJCmSDkBxjtvx4CXFa8B0iVn8slaoWm8JAfnYsHpwCMShYadqfX8Ywql5
         7yQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q7nrzKhEx+ExyWTwvGOL5rHVm6h72RsBmFQBL97mcHQ=;
        b=EkIOayxiLPQYJwZE7wdXV6P9yJbQyERtqcE+sLfL6lcetD8FZTehdhTO5DKLwm3Kn6
         uLvoEVGl2Sq2KD44a1hJ34fYdNKFaPxxRVUcJ9uaA7nJSgbO0pHm5Nvt/s+2w/1vPwZs
         stNcxs3AMpjHxG7JayloKu6nOOGEeBMhn5tEkiuDGO8DjmenJ+k6KOCIxQBfn3tSUkjD
         PJfHghTNR1Q1IG3ZxnyXCc6uJPDPmNTcFW6nlMZH9nHMhjzQoF7mkaPEI2xQisAs6/aU
         6shCW8x6yHhLqrQf1skhDx0a6SEs85hML7og6V0BCH1FC/ow8WbpY0OD75K5KnpzywX/
         DVyg==
X-Gm-Message-State: AOAM5319Y3jckhfgpISHKFanIgPWic2DUg54vpKL1MPs8LNfMzpijvM0
        sUmtpb69nFumT7r20okTLMT8cMkc
X-Google-Smtp-Source: ABdhPJxDDXMkm4Ia4MIKo9WV0a4PpIJb18pIzHMdu5JpJSi+udCpfGTbCNmCBBd8ciEK66Mj7i0mCw==
X-Received: by 2002:adf:f452:: with SMTP id f18mr4366456wrp.78.1594894774391;
        Thu, 16 Jul 2020 03:19:34 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:3adb:8201:9649:88f:51f8:6a21])
        by smtp.gmail.com with ESMTPSA id x18sm8341093wrq.13.2020.07.16.03.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 03:19:34 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, "Andrew G . Morgan" <morgan@kernel.org>
Cc:     linux-security-module@vger.kernel.org
Subject: [PATCH 15/16] Various source files: spelling fixes on comments
Date:   Thu, 16 Jul 2020 12:18:26 +0200
Message-Id: <20200716101827.162793-15-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200716101827.162793-1-mtk.manpages@gmail.com>
References: <20200716101827.162793-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 libcap/cap_proc.c                      | 6 +++---
 libcap/include/uapi/linux/capability.h | 2 +-
 libcap/include/uapi/linux/securebits.h | 2 +-
 psx/include/sys/psx_syscall.h          | 2 +-
 psx/psx.c                              | 6 +++---
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/libcap/cap_proc.c b/libcap/cap_proc.c
index 1c97beb..3929f66 100644
--- a/libcap/cap_proc.c
+++ b/libcap/cap_proc.c
@@ -75,7 +75,7 @@ static struct syscaller_s singlethread = {
 static int _libcap_overrode_syscalls = 1;
 
 /*
- * psx_load_syscalls() is weakly defined so we can have it overriden
+ * psx_load_syscalls() is weakly defined so we can have it overridden
  * by libpsx if that library is linked. Specifically, when libcap
  * calls psx_load_sycalls() it is prepared to override the default
  * values for the syscalls that libcap uses to change security state.
@@ -238,7 +238,7 @@ cap_t cap_get_pid(pid_t pid)
 
 /*
  * set the caps on a specific process/pg etc.. The kernel has long
- * since deprecated this asynchronus interface. DON'T EXPECT THIS TO
+ * since deprecated this asynchronous interface. DON'T EXPECT THIS TO
  * EVER WORK AGAIN.
  */
 
@@ -468,7 +468,7 @@ static int _cap_set_mode(struct syscaller_s *sc, cap_mode_t flavor)
  * set, these modes cannot be undone by the affected process tree and
  * can only be done by "cap_setpcap" permitted processes. Note, a side
  * effect of this function, whether it succeeds or fails, is to clear
- * atleast the CAP_EFFECTIVE flags for the current process.
+ * at least the CAP_EFFECTIVE flags for the current process.
  */
 int cap_set_mode(cap_mode_t flavor)
 {
diff --git a/libcap/include/uapi/linux/capability.h b/libcap/include/uapi/linux/capability.h
index 3281e73..b9ae18b 100644
--- a/libcap/include/uapi/linux/capability.h
+++ b/libcap/include/uapi/linux/capability.h
@@ -368,7 +368,7 @@ struct vfs_ns_cap_data {
 
 #define CAP_AUDIT_READ       37
 
-/* Alow system performace and observability privileged opeations using
+/* Alow system performance and observability privileged operations using
  * perf_events, i915_perf and other kernel subsystems. */
 
 #define CAP_PERFMON	     38
diff --git a/libcap/include/uapi/linux/securebits.h b/libcap/include/uapi/linux/securebits.h
index 6dae4e9..e9b1309 100644
--- a/libcap/include/uapi/linux/securebits.h
+++ b/libcap/include/uapi/linux/securebits.h
@@ -22,7 +22,7 @@
 #define SECBIT_NOROOT_LOCKED	(issecure_mask(SECURE_NOROOT_LOCKED))
 
 /* When set, setuid to/from uid 0 does not trigger capability-"fixup".
-   When unset, to provide compatiblility with old programs relying on
+   When unset, to provide compatibility with old programs relying on
    set*uid to gain/lose privilege, transitions to/from uid 0 cause
    capabilities to be gained/lost. */
 #define SECURE_NO_SETUID_FIXUP		2
diff --git a/psx/include/sys/psx_syscall.h b/psx/include/sys/psx_syscall.h
index c089a88..8044fbd 100644
--- a/psx/include/sys/psx_syscall.h
+++ b/psx/include/sys/psx_syscall.h
@@ -35,7 +35,7 @@ int __real_pthread_create(pthread_t *thread, const pthread_attr_t *attr,
 
 /*
  * psx_syscall performs the specified syscall on all psx registered
- * threads. The mecanism by which this occurs is much less efficient
+ * threads. The mechanism by which this occurs is much less efficient
  * than a standard system call on Linux, so it should only be used
  * when POSIX semantics are required to change process relevant
  * security state.
diff --git a/psx/psx.c b/psx/psx.c
index cabd342..b494072 100644
--- a/psx/psx.c
+++ b/psx/psx.c
@@ -29,7 +29,7 @@
 #include <sys/syscall.h>
 
 /*
- * psx_load_syscalls() is weakly defined so we can have it overriden
+ * psx_load_syscalls() is weakly defined so we can have it overridden
  * by libpsx if it is linked. Specifically, when libcap calls
  * psx_load_sycalls it will override their defaut values. As can be
  * seen here this present function is a no-op. However, if libpsx is
@@ -272,7 +272,7 @@ static void _psx_forked_child(void) {
      * The only way we can get here is if state is _PSX_INFORK and was
      * previously _PSX_IDLE. However, none of the registered threads
      * exist in this newly minted child process, so we have to reset
-     * the tracking structure to avoid any confusion. We also skuttle
+     * the tracking structure to avoid any confusion. We also scuttle
      * any chance of the PSX API working on more than one thread in
      * the child by leaving the state as _PSX_INFORK. We do support
      * all psx_syscall()s by reverting to them being direct in the
@@ -343,7 +343,7 @@ static void _psx_exiting(void *node) {
 }
 
 /*
- * _psx_start_fn is a trampolene for the intended start function, it
+ * _psx_start_fn is a trampoline for the intended start function, it
  * is called blocked (_PSX_CREATE), but releases the block before
  * calling starter->fn. Before releasing the block, the TLS specific
  * attributes are initialized for use by the interrupt handler under
-- 
2.26.2

