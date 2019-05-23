Return-Path: <SRS0=z3Bq=TX=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9F6C282DD
	for <linux-security-module@archiver.kernel.org>; Thu, 23 May 2019 12:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3877F21019
	for <linux-security-module@archiver.kernel.org>; Thu, 23 May 2019 12:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ertiE0SB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729962AbfEWMmZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 23 May 2019 08:42:25 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:38541 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729361AbfEWMmZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 23 May 2019 08:42:25 -0400
Received: by mail-yb1-f201.google.com with SMTP id a13so5107901ybm.5
        for <linux-security-module@vger.kernel.org>; Thu, 23 May 2019 05:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=JQ1oCxUU1IPVRVLwTDKqVi9a5cWuQ5HVxcskTOhO4aM=;
        b=ertiE0SB+mfT4MEk0SFpNz/YKadHtLe1893I517U4tFeM8uM4swKr9G/SikceY0rCZ
         UDv4kifx0Bx26JjS24LlGhSYfY5dn5hLUvIS+argIdWCUpj1zPlvl2vgcVT7VlYsMIBc
         TbZHChjMXWT1nZTF2UxhG3QQeuTGjHcBqomUaPOhXB56N+mygLlEEWcHWhxicHOP9S1B
         5KxHPYzkoVGX7YeFgoThDuFVkgEJqn+ZZYDjNKrKzE9PsO+fkj2QIaVmmjg9RyHD6UE+
         GLNEbVFhskq2fbM3GBHi68kjqbHgC7bL3loysl7MiurRFJlygTNNkqpkXQbKQ7K1eIxr
         EB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=JQ1oCxUU1IPVRVLwTDKqVi9a5cWuQ5HVxcskTOhO4aM=;
        b=QyFGe+lW0Iw3HxQlul5QvQRNRWDkvtBqq0POwJze1+v2Ih48I2topdXK/RGrT8XZnd
         4eB68US+425OBJKr9dJLqu1yF/h7FrsRieV5/zU3MkghTPnDva2zcFGDCucugDlY225n
         EenhgzVnHj+G2dyWPHwTUofy28FMjMPfNb1kw3aaJMVaaxs1yf1Kzx/htXTc+RxgosX/
         sEbIWXu1MnaSCP/pe6Kly5cyFaLmR1lGwF06dApL3RuzW9/lpwsPS27o21dDH4EIk6O3
         GqHSDjEPlckMBGDcx8F68Gg5OaLQ8OsmJdftP5AWhOCOt9XtJOtBnkPdzxZHGA+TJNfa
         Febw==
X-Gm-Message-State: APjAAAXhUa9cXOfhFzkCO7L8ozOthqzf8mUc75MeFGHiPeCQm5xkTuvA
        QGDgLn+PBvnYb08wrwHdLR+i5AlJ020=
X-Google-Smtp-Source: APXvYqybh08sHeGZRRlBZ+rEKGpK9UKViuwmqgzYonb7VhrGAa6y78I0qkN7CYW3hhy3qjCkZr902YQaq1s=
X-Received: by 2002:a81:5987:: with SMTP id n129mr46582349ywb.193.1558615344476;
 Thu, 23 May 2019 05:42:24 -0700 (PDT)
Date:   Thu, 23 May 2019 14:42:13 +0200
Message-Id: <20190523124216.40208-1-glider@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH v3 0/3] RFC: add init_on_alloc/init_on_free boot options
From:   Alexander Potapenko <glider@google.com>
To:     akpm@linux-foundation.org, cl@linux.com, keescook@chromium.org
Cc:     kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Provide init_on_alloc and init_on_free boot options.

These are aimed at preventing possible information leaks and making the
control-flow bugs that depend on uninitialized values more deterministic.

Enabling either of the options guarantees that the memory returned by the
page allocator and SL[AOU]B is initialized with zeroes.

Enabling init_on_free also guarantees that pages and heap objects are
initialized right after they're freed, so it won't be possible to access
stale data by using a dangling pointer.

As suggested by Michal Hocko, right now we don't let the heap users to
disable initialization for certain allocations. There's not enough
evidence that doing so can speed up real-life cases, and introducing
ways to opt-out may result in things going out of control.

Alexander Potapenko (3):
  mm: security: introduce init_on_alloc=1 and init_on_free=1 boot
    options
  mm: init: report memory auto-initialization features at boot time
  lib: introduce test_meminit module

 .../admin-guide/kernel-parameters.txt         |   8 +
 drivers/infiniband/core/uverbs_ioctl.c        |   2 +-
 include/linux/mm.h                            |  22 ++
 init/main.c                                   |  24 ++
 kernel/kexec_core.c                           |   2 +-
 lib/Kconfig.debug                             |   8 +
 lib/Makefile                                  |   1 +
 lib/test_meminit.c                            | 208 ++++++++++++++++++
 mm/dmapool.c                                  |   2 +-
 mm/page_alloc.c                               |  63 +++++-
 mm/slab.c                                     |  16 +-
 mm/slab.h                                     |  16 ++
 mm/slob.c                                     |  22 +-
 mm/slub.c                                     |  27 ++-
 net/core/sock.c                               |   2 +-
 security/Kconfig.hardening                    |  14 ++
 16 files changed, 416 insertions(+), 21 deletions(-)
 create mode 100644 lib/test_meminit.c
---
 v3: dropped __GFP_NO_AUTOINIT patches

-- 
2.21.0.1020.gf2820cf01a-goog

