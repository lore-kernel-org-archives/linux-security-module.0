Return-Path: <SRS0=MGza=UZ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057C4C48BD6
	for <linux-security-module@archiver.kernel.org>; Wed, 26 Jun 2019 12:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D023220663
	for <linux-security-module@archiver.kernel.org>; Wed, 26 Jun 2019 12:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h8oRe74w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbfFZMTt (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 26 Jun 2019 08:19:49 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:45808 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbfFZMTt (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 26 Jun 2019 08:19:49 -0400
Received: by mail-qt1-f201.google.com with SMTP id k8so2593967qtb.12
        for <linux-security-module@vger.kernel.org>; Wed, 26 Jun 2019 05:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=2Fq0HjbifmsdupktcfAuEl6sSbOWTKpMU8wUfFApIcI=;
        b=h8oRe74wvAhFNxCVSSLhgtaf8DdDRcvv2LUELZFKlhxIfMWHkB06yNG7SNT3CIncbO
         xrYAcYPkEKjnBbVe2WkkxpRSyACn/8q3L802S7S92zdmpj8B19KqEVJcOM2de/TNEknR
         +94Tt3chS1BA9EQxdCUwN45Wrz3UQ2wxYNt9NaVvGQq71AgKto3OiuqHn7RxyjdL02P3
         kTB2Ww3CiDQVdnviX+kBmfbmKcALIJ+dol51U9jzsfedTnn6SYA/TwGSVoVw9zlhWnSb
         4EeKQMkev9uTpqQzluNSwGkO5ukTgZfcxz/SaVb7HtKHx/CIH57gzcebuKUlYjgHmyus
         M3AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=2Fq0HjbifmsdupktcfAuEl6sSbOWTKpMU8wUfFApIcI=;
        b=bjJucStM7CdbWVVegPck2aSvfTWDZ5wk1v5R3LjtABY2waf+kCmp790GUOQ5sNb5S6
         7AHtmdoJdoKMTSFn8/U5PO/LDlEgcFYuSl5NHe4/BwAqg0AFIaB1AoIZK/SpbVkpZUWg
         PlbW4Tr/e5yBIs3y5b3k0HtbTDKMeRamq7G8ar4h+6MxB1kzxz2xIT0T+miQ4v7/TAcq
         Imt+KImgTDQMuEl5AzPrEpVu1QnPonje359lRM+sJ96tJ7O9MKCXuQAryd8uEoJ6xrLm
         qsPbja4y7Kp0MVej3q1lk8ywu+1ESljN/tTPoVxsVNzuXJcLFnv1Yq1t483RReuIIBR2
         XW2w==
X-Gm-Message-State: APjAAAXnHaJ1d9EY/MLn5w9yxX5Tjt6fPWsNDmc0qH9lhIZvdYbgiJZQ
        WZ0NgaoVW1Ftca4ZK2TwzuSrShVD9/4=
X-Google-Smtp-Source: APXvYqwCAtzX9p5b1vV/t1GUdeUyS8l0gHd33EslOH8hxFCkdYOBd6HFsLdwDix1xDg/zZ5Qa9VT7wjTypQ=
X-Received: by 2002:a0c:d249:: with SMTP id o9mr3328284qvh.196.1561551587948;
 Wed, 26 Jun 2019 05:19:47 -0700 (PDT)
Date:   Wed, 26 Jun 2019 14:19:41 +0200
Message-Id: <20190626121943.131390-1-glider@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v8 0/3] add init_on_alloc/init_on_free boot options
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
        Marco Elver <elver@google.com>, Qian Cai <cai@lca.pw>,
        linux-mm@kvack.org, linux-security-module@vger.kernel.org,
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
Cc: Qian Cai <cai@lca.pw>
Cc: linux-mm@kvack.org
Cc: linux-security-module@vger.kernel.org
Cc: kernel-hardening@lists.openwall.com

Alexander Potapenko (2):
  mm: security: introduce init_on_alloc=1 and init_on_free=1 boot
    options
  mm: init: report memory auto-initialization features at boot time

 .../admin-guide/kernel-parameters.txt         |  9 +++
 drivers/infiniband/core/uverbs_ioctl.c        |  2 +-
 include/linux/mm.h                            | 22 ++++++
 init/main.c                                   | 24 +++++++
 mm/dmapool.c                                  |  4 +-
 mm/page_alloc.c                               | 71 +++++++++++++++++--
 mm/slab.c                                     | 16 ++++-
 mm/slab.h                                     | 19 +++++
 mm/slub.c                                     | 43 +++++++++--
 net/core/sock.c                               |  2 +-
 security/Kconfig.hardening                    | 29 +++++++++
 12 files changed, 204 insertions(+), 19 deletions(-)
---
 v3: dropped __GFP_NO_AUTOINIT patches
 v5: dropped support for SLOB allocator, handle SLAB_TYPESAFE_BY_RCU
 v6: changed wording in boot-time message
 v7: dropped the test_meminit.c patch (picked by Andrew Morton already),
     minor wording changes
 v8: fixes for interoperability with other heap debugging features
-- 
2.22.0.410.gd8fdbe21b5-goog

