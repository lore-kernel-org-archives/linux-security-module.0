Return-Path: <SRS0=my8L=SM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FF6C10F11
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 13:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F9520830
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 13:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nEDIMake"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbfDJNSQ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 10 Apr 2019 09:18:16 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:52941 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727943AbfDJNSQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Apr 2019 09:18:16 -0400
Received: by mail-yb1-f201.google.com with SMTP id 10so1703852ybx.19
        for <linux-security-module@vger.kernel.org>; Wed, 10 Apr 2019 06:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=9/zlh/3sxPGKcfLIkzP+xBRpTq+NAnKSicEM/b1eERc=;
        b=nEDIMakefZ59hWgJSjJrBxVVAGOBIM9XdMIdJIkLpmMzwJULYzMLpiQFaj0EKyRhTZ
         MWtHj9ynvRau0B223C8S0MvM3OpSEm3BNoMXf4jHvXgM6dANp4vHj4rgZ2jKY3z32BT6
         tsqnSIVvaVuTskvpXlTG5lhLEoSmupOPwRsO+43Stk0BBBzjLnKfxy6z+AupmQpTnr3x
         vqG56gL+nPwxBwGx9puErENDt7eFK93CFyc1oh6xvEI2nkwk4VKnnSR4f/S7l2sNQDE1
         pU+UasSUFtquLV8OdGBz/YZlQuS0NoDAozMtY6SHuiBrurDpo8wsq9Yl0UjqcpSsyeWx
         aK6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=9/zlh/3sxPGKcfLIkzP+xBRpTq+NAnKSicEM/b1eERc=;
        b=q208FVoZSrq3bZ690UVgzDiPSNkXwENEA8R25yMvrf5Chl7kUg9l8DJjLPo2E75+tP
         f7TDbeYH4/1ab0DJJXR6Ch4CGlqB2ugsQdR8hLcZxcBHNKthCcwda+r+air+mkGDh3nk
         rhaMSVbqLUfsBPlIt+LVL/Vi8rAjUMBwPqIREPEmmvO4WQW1V49JSMRXX9f4auw9bBnR
         SBDvcKWlw8Qazg3RRzzf/9FKt/YX4fO4QqfTsvg2x6TAkdvtxUg5y2GmBcZVrEuwRrnd
         OT9VhbDsaviBg1lN9yRw+ve/s/+vBs9l5lcqL13z7EDRxpLrb1xRm1+xrsGkA+eF+RCB
         UoYw==
X-Gm-Message-State: APjAAAXg7IeYg62pHHKGyj+1YQkZy2SmCETLiL10uBmBPnLwazRr7xl7
        mqNKOHA4JujKk89POjC0HY2NvwnBPmQ=
X-Google-Smtp-Source: APXvYqzKOIC96pz5L6dtb2vR7YmWd1kjIM3HHWd3xhWA28i3pJp99Z1EzMyaik4NFVrPlp3qU0925IZvnTc=
X-Received: by 2002:a81:994d:: with SMTP id q74mr8139613ywg.18.1554902295333;
 Wed, 10 Apr 2019 06:18:15 -0700 (PDT)
Date:   Wed, 10 Apr 2019 15:17:23 +0200
Message-Id: <20190410131726.250295-1-glider@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v4 0/3] RFC: introduce CONFIG_INIT_ALL_MEMORY
From:   Alexander Potapenko <glider@google.com>
To:     yamada.masahiro@socionext.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kbuild@vger.kernel.org, ndesaulniers@google.com,
        kcc@google.com, dvyukov@google.com, keescook@chromium.org,
        sspatil@android.com, labbott@redhat.com,
        kernel-hardening@lists.openwall.com
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This patch is a part of a bigger initiative to allow initializing
heap/stack memory in the Linux kernels by default.
The rationale behind doing so is to reduce the severity of bugs caused
by using uninitialized memory.

Over the last two years KMSAN (https://github.com/google/kmsan/) has
found more than a hundred bugs running in a really moderate setup (orders
of magnitude less CPU/months than KASAN). Some of those bugs led to
information leaks if uninitialized memory was copied to the userspace,
other could cause DoS because of subverted control flow.
A lot more bugs remain uncovered, so we want to provide the distros and OS
vendors with a last resort measure to mitigate such bugs.

Our plan is to introduce configuration flags to force initialization of
stack and heap variables with a fixed pattern.
This is going to render information leaks inefficient (as we'll only leak
pattern data) and make uses of uninitialized values in conditions more
deterministic and discoverable.

The stack instrumentation part is based on Clang's -ftrivial-auto-var-init
(see https://reviews.llvm.org/D54604 ; there's also a GCC feature request
for a similar flag: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=87210)
or GCC's -fplugin-arg-structleak_plugin-byref-all
The heap initialization part is compiler-agnostic and is done in the
places that previously checked for __GFP_ZERO to initialize the newly
allocated memory.

Alexander Potapenko (3):
  initmem: introduce CONFIG_INIT_ALL_MEMORY and CONFIG_INIT_ALL_STACK
  initmem: introduce CONFIG_INIT_ALL_HEAP
  net: make sk_prot_alloc() work with CONFIG_INIT_ALL_HEAP

 Makefile                               | 10 ++++++
 arch/arm64/Kconfig                     |  1 +
 arch/arm64/include/asm/page.h          |  1 +
 arch/x86/Kconfig                       |  1 +
 arch/x86/include/asm/page_64.h         | 10 ++++++
 arch/x86/lib/clear_page_64.S           | 24 ++++++++++++++
 drivers/infiniband/core/uverbs_ioctl.c |  4 +--
 include/linux/gfp.h                    | 10 ++++++
 include/linux/highmem.h                |  8 +++++
 include/net/sock.h                     |  8 ++---
 kernel/kexec_core.c                    |  8 +++--
 mm/dmapool.c                           |  4 +--
 mm/page_alloc.c                        |  9 ++++--
 mm/slab.c                              | 19 ++++++++----
 mm/slub.c                              | 12 ++++---
 net/core/sock.c                        |  5 +--
 security/Kconfig                       |  1 +
 security/Kconfig.initmem               | 43 ++++++++++++++++++++++++++
 18 files changed, 154 insertions(+), 24 deletions(-)
 create mode 100644 security/Kconfig.initmem

-- 
2.21.0.392.gf8f6787159e-goog

