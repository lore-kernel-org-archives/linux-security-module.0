Return-Path: <SRS0=mR5W=EB=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4403C4363A
	for <linux-security-module@archiver.kernel.org>; Mon, 26 Oct 2020 12:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B9D924640
	for <linux-security-module@archiver.kernel.org>; Mon, 26 Oct 2020 12:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1rGedWj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1775673AbgJZMwk (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 26 Oct 2020 08:52:40 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35169 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1775666AbgJZMwj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 26 Oct 2020 08:52:39 -0400
Received: by mail-wr1-f68.google.com with SMTP id n15so12398330wrq.2;
        Mon, 26 Oct 2020 05:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SJHGLhZvy94WcA+VjI8D5ZopjjY0MdjndnUVjDz37Ks=;
        b=m1rGedWjIF9HoBQqqiH7KLY5qBc8rEQeUZEYUoyrc+ygUe//E3I5sUBhfLyz6ztlyN
         SKzIgnDeEhY3w2YL7gCxwMQMWxkdN+VWTWJRUDLMxgtiQLjWFRGq4iStfWbw4b/iEwe9
         QXtK+UfRzuyv2+y1en+F4KCgKYv2+2cgv+1WOiwluCfiZVI8rIZ2cYRWX0o+istIXGQM
         ILisTSl3ceMD62AKOYT0jHXs8Ws6y/+HLBgVJCSaP3tJNaPJyN+YjYPnGik5k1uQK3y5
         pBvZ0t3wGBrqKcIZOh6CzHOS36eFTWcR+Db+q7wCziGjd0HZoy9fNi+HBGekhADOPt8J
         OJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SJHGLhZvy94WcA+VjI8D5ZopjjY0MdjndnUVjDz37Ks=;
        b=BjqURpjHvLs2A5TLBCcwKCv2sxPl8P7aIxy/JyI03fiIsHSoEBxf8kvKFBRKjaKddJ
         CBnP/gMxnLktTJinZd9DTSiMgjgceD8imngTpZHA4eBgk9/VxYalTlqt2X4NYQDSRj0K
         FgTWNzS4Zl/5sYfe+i02MjplEdQR2opnyd3pfkoJlcYGPPhovCyYDoW8pa3rvQRE0DtM
         RjidDaO8ZCTZRNwDswR1rAVmjv5XRrh8tx/fKmSVYbS69jGXtNhkEXrjGqz2hAHsy8VI
         F7uVwvJVp8MtEedyeF3Th9OwT4Mc0HIXEtMfVqcdTdDgLUWW4gmlrV+G/YllVH4TX62N
         ekfw==
X-Gm-Message-State: AOAM531LAs5twBYGhZ7UU4JuCnxwJ0RNFq5pZc5YqxTyqwxOX+Tfnytt
        MeNYGlJ99RRinZ1v0JLaRhc=
X-Google-Smtp-Source: ABdhPJxAt2n2wH+0DloibyeWjgzXrU0ZFO9u6R9k74Gz2/tBKHlrJJvBW7lC0ohi3KEWpDCp/YO8fg==
X-Received: by 2002:adf:fe48:: with SMTP id m8mr17520787wrs.127.1603716757123;
        Mon, 26 Oct 2020 05:52:37 -0700 (PDT)
Received: from nogikh.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id a3sm23551139wrh.94.2020.10.26.05.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 05:52:36 -0700 (PDT)
From:   Aleksandr Nogikh <a.nogikh@gmail.com>
To:     jmorris@namei.org, serge@hallyn.com, akinobu.mita@gmail.com
Cc:     andreyknvl@google.com, dvyukov@google.com, elver@google.com,
        glider@google.com, keescook@google.com,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Aleksandr Nogikh <nogikh@google.com>
Subject: [RFC PATCH v2 0/2] security: add fault injection to LSM hooks
Date:   Mon, 26 Oct 2020 12:52:25 +0000
Message-Id: <20201026125227.54520-1-a.nogikh@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
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

---
v2:
* Renamed should_fail_lsm_hook() to should_fail_lsm_hook().
* Extended the documentation.

Aleksandr Nogikh (2):
  security: add fault injection capability
  docs: add fail_lsm_hooks info to fault-injection.rst

 .../fault-injection/fault-injection.rst       |  6 +++
 lib/Kconfig.debug                             |  6 +++
 security/security.c                           | 53 +++++++++++++++++--
 3 files changed, 62 insertions(+), 3 deletions(-)


base-commit: 2ef991b5fdbe828dc8fb8af473dab160729570ed
-- 
2.29.0.rc1.297.gfa9743e501-goog

