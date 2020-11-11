Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68DCEC388F9
	for <linux-security-module@archiver.kernel.org>; Wed, 11 Nov 2020 10:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE6362072C
	for <linux-security-module@archiver.kernel.org>; Wed, 11 Nov 2020 10:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyquzZeR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbgKKKoq (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 11 Nov 2020 05:44:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbgKKKoo (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 11 Nov 2020 05:44:44 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97466C0613D1;
        Wed, 11 Nov 2020 02:44:44 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id c9so1786116wml.5;
        Wed, 11 Nov 2020 02:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f3P67JjlLnFevaFsrc9hwaRhUH2HHQjCFT4cPJRYrZg=;
        b=JyquzZeRkjrEWkFRV5BUID/Ivs0H2/UHmS1YZqOLIVVj42Km2YhEH80guMMxyPPeqY
         dZeumzqWgTGGOf3Gg2xrPkb5Ew40eStmjWaznHVBoco2c8kHphV9JM4Ynvp0Mhg/1FZM
         lfF69ehej9pB7Mz6hVJ1D4ib2xT0JVwdJFHjNBH8s70bKeY+5LSErEM+uilFvA7+pabp
         Z2tp/Rgm3bTifAQpOvlKAjFXfWRcvZnfB6j4PNcwDnMf4PbfnwKznCQVeSK4mbTieoKx
         yhs4Qrf3pXCYXAnouuQeBd8rs/dzNMIE7dcBIzrJ4dALc2q53dBdclHULu9AysAE7NRw
         Fofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f3P67JjlLnFevaFsrc9hwaRhUH2HHQjCFT4cPJRYrZg=;
        b=oD2Ci9ORjrSdFch/mnuGwyyHTc+Gh1ltwjf5FeSVPGjWhqdFCh4cKOvSdz8Zrn2W3M
         lbRqE7TsEjpqAU81VrD0Q3pcupkuu5xZGJ046xPB/OquiOX1n1uBwhQh01Da/jTKWlPB
         UG45Fn5FKg/UECWkgIEF1i0oNCjMajF4+QqJ+Uwmw1t61e7k9FGa6FOvO+5gdyxno1cL
         3HvdjGHpkkLRAUT22wDc0EKTZrGgYC4+WqtWK9/RcbNnyrWx93PprJB3fix9m5wGMm3U
         /gbLkFwm810VAjoIBi181JFrLKBsJ40zu3DVW2eMm7QbYy1EUaND1c7fuZUY4ux/UDQQ
         A2nQ==
X-Gm-Message-State: AOAM530jZ5ZhBWIIqGiB4adS2IG6AGY9Vx4hzxlxNG9lfZSVnZyK2pnt
        o6AstDHoe575gMBiqunBWMUDWd5eBcU=
X-Google-Smtp-Source: ABdhPJxWSPRJv9ciEV/NVUNRQHcY5T//lr+Bq78/sIzzI7rVbje/wWGNSIiEPpqqbZSNTIdaW71f6w==
X-Received: by 2002:a1c:46c5:: with SMTP id t188mr3437075wma.68.1605091483382;
        Wed, 11 Nov 2020 02:44:43 -0800 (PST)
Received: from nogikh.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id u195sm2111549wmu.18.2020.11.11.02.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 02:44:42 -0800 (PST)
From:   Aleksandr Nogikh <a.nogikh@gmail.com>
To:     jmorris@namei.org, serge@hallyn.com, akinobu.mita@gmail.com
Cc:     andreyknvl@google.com, dvyukov@google.com, elver@google.com,
        glider@google.com, keescook@google.com, casey@schaufler-ca.com,
        penguin-kernel@i-love.sakura.ne.jp, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, mortonm@chromium.org,
        Aleksandr Nogikh <nogikh@google.com>
Subject: [PATCH v4 0/2] security: add fault injection to LSM hooks
Date:   Wed, 11 Nov 2020 10:44:07 +0000
Message-Id: <20201111104409.1530957-1-a.nogikh@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Aleksandr Nogikh <nogikh@google.com>

Fault injection capabilities[Documentation/fault-injection/fault-injection.rst]
facilitate testing of the stability of the Linux kernel by providing
means to force a number of kernel interfaces to return error
codes. This patch series proposes adding such fault injection
capability into LSM hooks.

The intent is to make it possible to test whether the existing kernel
code properly handles negative return values of LSM hooks. Syzbot
[https://github.com/google/syzkaller/blob/master/docs/syzbot.md] will
automatically do that with the aid of instrumentation tools once these
changes are merged.

Local fuzzing of a Linux kernel with this patch has almost instantly
led to two crashes. I'm not sure whether they correspond to actual
issues as this LSM fault injection implementation (and the concept
itself) can be wrong. Here they are:

1. "general protection fault in selinux_inode_free_security". This is
caused by executing security_inode_free() when a fault was injected to
inode_alloc_security() and therefore selinux_inode_alloc_security()
was not executed. In this case, the subsequent inode_free_security()
call executes list_del_init() on an uninitialized list. Theoretically,
this may happen if some other LSM precedes selinux in the hooks list
and its inode_alloc_security hook fails.

A fault was injected to this call_int_hook():
https://elixir.bootlin.com/linux/v5.9/source/security/security.c#L975

Below you can find a call trace for the subsequent crash.
__list_del_entry include/linux/list.h:132 [inline]
list_del_init include/linux/list.h:204 [inline]
inode_free_security security/selinux/hooks.c:337 [inline]
selinux_inode_free_security+0xf0/0x290 security/selinux/hooks.c:2839
security_inode_free+0x46/0xc0 security/security.c:1042
security_inode_alloc+0x161/0x1a0 security/security.c:1027
inode_init_always+0x5a7/0xd10 fs/inode.c:171
alloc_inode+0x82/0x230 fs/inode.c:239
new_inode_pseudo+0x14/0xe0 fs/inode.c:928
sock_alloc+0x3c/0x260 net/socket.c:573
__sock_create+0xb9/0x780 net/socket.c:1391
sock_create net/socket.c:1478 [inline]
__sys_socket+0xef/0x200 net/socket.c:1520
__do_sys_socket net/socket.c:1529 [inline]
__se_sys_socket net/socket.c:1527 [inline]
__x64_sys_socket+0x6f/0xb0 net/socket.c:1527
do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
entry_SYSCALL_64_after_hwframe+0x44/0xa9

2. BUG_ON inside security_skb_classify_flow(). Why is it needed there?
https://elixir.bootlin.com/linux/v5.9/source/security/security.c#L2426

---
v4:
* Changed retval debugfs file type - now it stores a signed integer.
* Made CONFIG_FAIL_LSM_HOOKS depend on CONFIG_SECURITY.

v3:
https://lkml.kernel.org/r/20201029183526.2131776-1-aleksandrnogikh@gmail.com
* Submitting this series without an "RFC" tag.
* Updated the cover letter.

v2:
https://lkml.kernel.org/r/20201026125227.54520-1-a.nogikh@gmail.com
* Renamed should_fail_lsm_hook() to lsm_hooks_inject_fail().
* Extended the documentation.

v1:
https://lkml.kernel.org/r/20201015104649.2104432-1-a.nogikh@gmail.com


Aleksandr Nogikh (2):
  security: add fault injection capability
  docs: add fail_lsm_hooks info to fault-injection.rst

 .../fault-injection/fault-injection.rst       |  6 ++
 lib/Kconfig.debug                             |  6 ++
 security/security.c                           | 69 ++++++++++++++++++-
 3 files changed, 78 insertions(+), 3 deletions(-)


base-commit: 3e14f70c05cda4794901ed8f976de3a88deebcc0
-- 
2.29.2.222.g5d2a92d10f8-goog

