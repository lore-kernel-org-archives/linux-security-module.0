Return-Path: <SRS0=04rW=UQ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BA5C31E5D
	for <linux-security-module@archiver.kernel.org>; Mon, 17 Jun 2019 15:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EE33208C4
	for <linux-security-module@archiver.kernel.org>; Mon, 17 Jun 2019 15:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k9NH+beY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbfFQPK6 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 17 Jun 2019 11:10:58 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:39977 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfFQPK5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 17 Jun 2019 11:10:57 -0400
Received: by mail-qt1-f201.google.com with SMTP id z6so9496776qtj.7
        for <linux-security-module@vger.kernel.org>; Mon, 17 Jun 2019 08:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=AhzC1dqcXRssy7fdMkEhLgspqOslOvHdcVPRsk5zXZU=;
        b=k9NH+beY5eMjDnOaINDvVrgGcEx78KmzHeEJfkQN6Y9SX45KinI1QUz8a2DhSnPwty
         5kjZ5RuuasqO5gIcAhgkZUnJ5GT0kppbEhM9rHxo2vvxQJfsWk6uJ4QrX+Ea29xmQPeD
         8IsCVrYuEabNYcOitK3k+G1bBip5g5n1lG48JTDn/EqwzSUI5z4Uorhrr88udI3d+o6j
         RHT5IKO45+CRt1jDmPgvxO/tI9sYeKgKoAmcXlnkwutt1ZNFR12l5mPkKMTD0nu4F7YS
         SatuKTASkGkk2OrjCE5YEdnhVkD2b7xX5FLEHPbTJVQQpwuOyfkmjlwOpBT95MleK+pU
         LE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=AhzC1dqcXRssy7fdMkEhLgspqOslOvHdcVPRsk5zXZU=;
        b=hfuK3gQyyjmJvms4J+3pdo/fMowVYwZJYMgndGRTWB0SKcLy0n8llnWR6nPka9BDK6
         dJWEUDmIL+K00kikwG6oVh2y/kqc8GUYbfOU/m3uf6h3J4QmudoGgInqJvOYQm+jvBK4
         UDycvKLOhXHxqeJ+5y940IXJCDaY8xq4Z4WTJVe7zabdR1u0lDfNobcg2Vp3oY5LwfWV
         lWOrHDWD8fJ0oZKLHhmMIc+xcgRK3QqmWp8Elg8Ms3OgtT4HRj6fL+8eYUEdmwRPjZj7
         6FnwK5OjvEei+wKykQ/DkFJH4vYN+TN9uszA7yyDCTDADkqcHBAXfqWaEFTWWY/le73S
         oRdw==
X-Gm-Message-State: APjAAAV/jbydxVLpA/8fVEknFO78uHg0JFFInq8jbNPhkgdGahqCcsaa
        UntO9WKF0Y8eU5YOdg4NZuXBboyjdQM=
X-Google-Smtp-Source: APXvYqzSP5di/cDRVpILC8IiiOlVU005dHmsxZFgo+MqF+Qnmu099tvbtAFfTxug3VjFm5DpzWKfL/u7hSk=
X-Received: by 2002:ac8:2a69:: with SMTP id l38mr27804097qtl.212.1560784256777;
 Mon, 17 Jun 2019 08:10:56 -0700 (PDT)
Date:   Mon, 17 Jun 2019 17:10:48 +0200
Message-Id: <20190617151050.92663-1-glider@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v7 0/3] add init_on_alloc/init_on_free boot options
From:   Alexander Potapenko <glider@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Hocko <mhocko@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sandeep Patil <sspatil@android.com>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jann Horn <jannh@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marco Elver <elver@google.com>, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Provide init_on_alloc and init_on_free boot options.

These are aimed at preventing possible information leaks and making the
control-flow bugs that depend on uninitialized values more deterministic.

Enabling either of the options guarantees that the memory returned by the
page allocator and SL[AU]B is initialized with zeroes.
SLOB allocator isn't supported at the moment, as its emulation of kmem
caches complicates handling of SLAB_TYPESAFE_BY_RCU caches correctly.

Enabling init_on_free also guarantees that pages and heap objects are
initialized right after they're freed, so it won't be possible to access
stale data by using a dangling pointer.

As suggested by Michal Hocko, right now we don't let the heap users to
disable initialization for certain allocations. There's not enough
evidence that doing so can speed up real-life cases, and introducing
ways to opt-out may result in things going out of control.

To: Andrew Morton <akpm@linux-foundation.org>
To: Christoph Lameter <cl@linux.com>
To: Kees Cook <keescook@chromium.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Kostya Serebryany <kcc@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Sandeep Patil <sspatil@android.com>
Cc: Laura Abbott <labbott@redhat.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Jann Horn <jannh@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Marco Elver <elver@google.com>
Cc: linux-mm@kvack.org
Cc: linux-security-module@vger.kernel.org
Cc: kernel-hardening@lists.openwall.com

Alexander Potapenko (2):
  mm: security: introduce init_on_alloc=1 and init_on_free=1 boot
    options
  mm: init: report memory auto-initialization features at boot time

 .../admin-guide/kernel-parameters.txt         |  9 +++
 drivers/infiniband/core/uverbs_ioctl.c        |  2 +-
 include/linux/mm.h                            | 22 +++++++
 init/main.c                                   | 24 +++++++
 kernel/kexec_core.c                           |  2 +-
 mm/dmapool.c                                  |  2 +-
 mm/page_alloc.c                               | 63 ++++++++++++++++---
 mm/slab.c                                     | 16 ++++-
 mm/slab.h                                     | 19 ++++++
 mm/slub.c                                     | 33 ++++++++--
 net/core/sock.c                               |  2 +-
 security/Kconfig.hardening                    | 29 +++++++++
 12 files changed, 204 insertions(+), 19 deletions(-)
---
 v3: dropped __GFP_NO_AUTOINIT patches
 v5: dropped support for SLOB allocator, handle SLAB_TYPESAFE_BY_RCU
 v6: changed wording in boot-time message
 v7: dropped the test_meminit.c patch (picked by Andrew Morton already),
     minor wording changes
-- 
2.22.0.410.gd8fdbe21b5-goog

