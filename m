Return-Path: <SRS0=Tuew=EE=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766C9C4363A
	for <linux-security-module@archiver.kernel.org>; Thu, 29 Oct 2020 18:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B6FB20838
	for <linux-security-module@archiver.kernel.org>; Thu, 29 Oct 2020 18:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bP9CvNXO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725888AbgJ2Sfp (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 29 Oct 2020 14:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgJ2Sfo (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 29 Oct 2020 14:35:44 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55AF2C0613CF;
        Thu, 29 Oct 2020 11:35:44 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id n15so3904361wrq.2;
        Thu, 29 Oct 2020 11:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xhMMctdfvKPyqyYyPaG2fiUHUah7QBaQjVcecZR6Lv8=;
        b=bP9CvNXOQNkc0rw3nQ8m6aeeRzOwh/zxRNwQbbcXhnzuORsBy6Z/mQ0eJD2KFX50T4
         N05aTRwXvW8lS3VplG30F2MBYV8vdYfjzv2lcj67idlSK+uiJDffECfWD2dASvbI6xiE
         IdxQr8jEdojAsF0fVsWjXczNEcofllcA3Flu2pKE/6bjcTDuEKlzs+zqqhfkK8olECjL
         FMHX2MvyJ2x+88tVRaDlgFO/9mRljm5wnn54VlAtpcQWaJX1ko9hXNvvwMUVdaUrU/To
         Vl/twJELDEm59qiPJ45uKzAkQqIvYqfSo+atYZ8NKrDvsMas46neKOBfTuhOHWMQkzKz
         hNJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xhMMctdfvKPyqyYyPaG2fiUHUah7QBaQjVcecZR6Lv8=;
        b=HQax3qS0Sc08JPSauaiqZy3XzzDtkbU9KsNmwLYR1MXfkGV9f89UZ3lBNfcBUBydGn
         7ruju0IW7E5AHo8MErGc1qANDz+Mo9frYBNijHp8yIZMPQEDgHhyP28owmJglVpuKUrj
         /LPfdUYslxgDSbNsz3fqMzDxoX4IfGOLINu2dVZMpZrR8qQtXCOJQR9CiJ/FI7pBSSMV
         SqO/2uv2Tr6UcaoO8m6Km7jabcpWmacf9QNhtZotXDF7oAcWeVnUmqoW6WWINm4Oq0ii
         z/nUpzw+8UnLl/iyvJR5MjYC8Teot1ATA1NdEdm1fR0d3Cj434f/PPTzk+aen9M42YhO
         P+qQ==
X-Gm-Message-State: AOAM533ZeMNWnO6QiCo7ZTxhIXuwEE09mSxZVvgS5YkhPrHA2qPawR23
        TSOyT5BF5Zyjwwz9vwL+lTiiwOx9rC0H3w==
X-Google-Smtp-Source: ABdhPJzWXWekVLvb5lwbB79JujGUDMVYblDoz9+79Q06Xw2v1Ii3rTJivGupKie7M9sBDQJWmi8baQ==
X-Received: by 2002:adf:dd0b:: with SMTP id a11mr7761460wrm.41.1603996543054;
        Thu, 29 Oct 2020 11:35:43 -0700 (PDT)
Received: from nogikh.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id f4sm5800982wrq.54.2020.10.29.11.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 11:35:42 -0700 (PDT)
From:   Aleksandr Nogikh <aleksandrnogikh@gmail.com>
To:     jmorris@namei.org, serge@hallyn.com, akinobu.mita@gmail.com
Cc:     andreyknvl@google.com, dvyukov@google.com, elver@google.com,
        glider@google.com, keescook@google.com, casey@schaufler-ca.com,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Aleksandr Nogikh <nogikh@google.com>
Subject: [PATCH v3 0/2] security: add fault injection to LSM hooks
Date:   Thu, 29 Oct 2020 18:35:24 +0000
Message-Id: <20201029183526.2131776-1-aleksandrnogikh@gmail.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
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
v3:
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

 .../fault-injection/fault-injection.rst       |  6 +++
 lib/Kconfig.debug                             |  6 +++
 security/security.c                           | 53 +++++++++++++++++--
 3 files changed, 62 insertions(+), 3 deletions(-)


base-commit: 3f267ec60b922eff2a5c90d532357a39f155b730
-- 
2.29.1.341.ge80a0c044ae-goog

