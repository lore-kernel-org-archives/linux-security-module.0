Return-Path: <SRS0=3ULx=DW=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06209C433E7
	for <linux-security-module@archiver.kernel.org>; Thu, 15 Oct 2020 10:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 921592225F
	for <linux-security-module@archiver.kernel.org>; Thu, 15 Oct 2020 10:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oid2pL6t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgJOKq6 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 15 Oct 2020 06:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgJOKq5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 15 Oct 2020 06:46:57 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDAEC061755;
        Thu, 15 Oct 2020 03:46:57 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id h7so2865312wre.4;
        Thu, 15 Oct 2020 03:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ISmuKJc+PCSw3Nkr+H1YT9y5xRTwpnR8B7X0bYrHLdI=;
        b=Oid2pL6tJotw2EbU++SIV4NHxRI5lJOUD7R/6hBKALaX4Ihq+eokpCkGKIP46z6M6I
         P8/ngzeFtjXl/FEqETIQwUS6sVLo1zjiId/9tnTlznhPoFZHzfTOd6RVEiMUX0W6kGWV
         RIikN2zgpRiJSLB7Fd9eeOcMEdzf1TehcFVI+6ObaVKd/0tMxpWnG2BpIu+7C2bkuGKz
         lhvL6Dd6sOPp8UNBgWDvH8VCyx7EdjtXFmpVApwVJILgjVx9Fx2lONXQDT2st0HGjKcK
         smk6DAtZPXMTn9VB1qviCEACEAaGkd6aVpOcnsZQbAxGv9rWZscNX7fCkQ0u2y4bDRtV
         1u7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ISmuKJc+PCSw3Nkr+H1YT9y5xRTwpnR8B7X0bYrHLdI=;
        b=OAzW0SI56PrevEpcg28Awe3igiWRSM10lx3iN6UdpNOvg3gZ18U0gyAjAdS7I16HFJ
         YKaD+JssbrwtXnMnZacic+GncAaOq/WhXAfl2xDWNLeQbYVyTjwYygOObtdIppO4acD+
         gclM5qEIXXJrA13IHIIWKQLmcTAO0XW+huYn2L61WwKpEnOFvTCKPuQPrRZU2IuXsdxH
         DU4CeK+qvu7ZPKNIT7PP5lFd2/QVte+9qcGA4z9AHeHTCUekje/C0DtI7jCm1iJ3U3KE
         VgtOfzV2L0RPksz/SKwDuj4trwPxpvJQOsoD1fDhujwOn6eIcUpHPVy0wAKqL1Z6KFbI
         Pixg==
X-Gm-Message-State: AOAM5305awqBfJF6qthlTOC+1zNUL7GmB6gNuo1BYy2o+2Z4M86IvKpu
        A+L7IMBxYPmqD7KCJdM71Zc=
X-Google-Smtp-Source: ABdhPJwUsXey/kqCk1hSfBL7+hP1RWq6KFdFzxjEPKmcz4efsns2YSi/pgNMTQ9f00BrcdKtHdsSpw==
X-Received: by 2002:adf:c3cd:: with SMTP id d13mr3552291wrg.15.1602758816149;
        Thu, 15 Oct 2020 03:46:56 -0700 (PDT)
Received: from nogikh.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id c132sm3671249wmf.25.2020.10.15.03.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 03:46:55 -0700 (PDT)
From:   Aleksandr Nogikh <a.nogikh@gmail.com>
To:     jmorris@namei.org, serge@hallyn.com, akinobu.mita@gmail.com
Cc:     andreyknvl@google.com, dvyukov@google.com, elver@google.com,
        glider@google.com, keescook@google.com,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Aleksandr Nogikh <nogikh@google.com>
Subject: [RFC PATCH 0/1] security: add fault injection to LSM hooks
Date:   Thu, 15 Oct 2020 10:46:48 +0000
Message-Id: <20201015104649.2104432-1-a.nogikh@gmail.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Aleksandr Nogikh <nogikh@google.com>

Fault injection capabilities[Documentation/fault-injection/fault-injection.rst]
facilitate testing of the stability of the Linux kernel by providing
means to force a number of kernel interfaces to return error
codes. This RFC proposes adding such fault injection capability into
LSM hooks.

The intent is to make it possible to test whether the existing kernel
code properly handles negative return values of LSM hooks. Syzbot
[https://github.com/google/syzkaller/blob/master/docs/syzbot.md] will
automatically do that with the aid of instrumentation tools once these
changes are merged.

Is the attached implementation consistent with the ideas behind LSM
stacking in its current state? In particular, is it reasonable to
expect the existing LSMs to operate normally when they are active and
such fault injection happens?

Local fuzzing of a Linux kernel with this patch has almost instantly
led to two crashes. I'm not sure whether they correspond to actual
issues as the LSM fault injection implementation (and the concept
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

Aleksandr Nogikh (1):
  security: add fault injection capability

 lib/Kconfig.debug   |  6 +++++
 security/security.c | 53 ++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 56 insertions(+), 3 deletions(-)


base-commit: f2fb1afc57304f9dd68c20a08270e287470af2eb
-- 
2.28.0.1011.ga647a8990f-goog

