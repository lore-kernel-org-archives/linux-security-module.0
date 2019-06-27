Return-Path: <SRS0=lnE7=U2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC0FC48BD6
	for <linux-security-module@archiver.kernel.org>; Thu, 27 Jun 2019 13:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CF942053B
	for <linux-security-module@archiver.kernel.org>; Thu, 27 Jun 2019 13:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iBxY0ZFg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfF0NDZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 27 Jun 2019 09:03:25 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:36917 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbfF0NDY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 27 Jun 2019 09:03:24 -0400
Received: by mail-qt1-f201.google.com with SMTP id g56so2304443qte.4
        for <linux-security-module@vger.kernel.org>; Thu, 27 Jun 2019 06:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=nkuGlh1b+gHriNiPX/Ra1Bh+mzhPWQ4oquwmkvO30T4=;
        b=iBxY0ZFgO84nGjeC4loAOGtpGOs9Yd+fQ6I8SutqbHSeU1rnf5JzTtlDWjLJJd0/Nr
         zxHj+IuFkHMyvyWAC33SPbFZGoTK8algV818k/Q71cVpkVHuMBWJKC2ksgxr8pUJEAaP
         dutE+V9ZPEuAoDr2MSkkEBS313KEVD9qNR/3caN6hxA6tFWKop/qr1X7z/Lboo8tZQwW
         I254YFH5T0q6XJAe0Tm+VeVcDZaaB1k/+ZUj+rUz7ui9QpYJ0gGlpps4Mr8zWe3VA6HN
         icTzVRARAhzNdo2Mw8haBEcLFFm82kBhXJPRKv+9+EU9hoEDndfPYq5OKewAgDwKnu5l
         kK2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=nkuGlh1b+gHriNiPX/Ra1Bh+mzhPWQ4oquwmkvO30T4=;
        b=q0QXpyD99ZhEK07SQv1LMzf2+f+lqIqsWADSQ2RRKvd5/WglofC3MeqSPw520ivlRI
         X8uMaFLZZsvLSPCVep+yfl/79paGID8jH2xtIRycF6LhmnFAC/BLP92cAHIhTBrpa5VO
         MlBGAUlwgx/m7Xd1Cr8DxbZrHR8aGZTJZLwE5/039RWmhluCo1Lz+P+UqeEQZZK/aKcg
         yKPwbYDrS3Bmtpt7FpMDRDxzIMNSsObQ+jRzqP2f95C1wWfkbJdOGxl435BmHUHOB2yk
         qsLKVp92SpJvOXg6SkRSZrs7rgE4U/9gmg8kUeIDpti1AA2PmV3MQIITrVrZrKWya73Z
         sruQ==
X-Gm-Message-State: APjAAAUVTL1N11WbcKyHv2ZdwwIcXqGVsXyN7LzChbQ4jiDdbH+jmLVZ
        St8YO/mZ+YBhgFzTh0qArP+4CMSB5N4=
X-Google-Smtp-Source: APXvYqyb2fwdKxY/0wj7U997eReOnW8Kj1pQxO+Xnu7fYid+NvlrsgBAglMJ1qJ5NwkNSnI/uio1IDG6JGY=
X-Received: by 2002:a05:620a:35e:: with SMTP id t30mr3084826qkm.1.1561640603625;
 Thu, 27 Jun 2019 06:03:23 -0700 (PDT)
Date:   Thu, 27 Jun 2019 15:03:14 +0200
Message-Id: <20190627130316.254309-1-glider@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v9 0/3] add init_on_alloc/init_on_free boot options
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
 include/linux/mm.h                            | 24 +++++++
 init/main.c                                   | 24 +++++++
 mm/dmapool.c                                  |  4 +-
 mm/page_alloc.c                               | 71 +++++++++++++++++--
 mm/slab.c                                     | 16 ++++-
 mm/slab.h                                     | 20 ++++++
 mm/slub.c                                     | 41 +++++++++--
 net/core/sock.c                               |  2 +-
 security/Kconfig.hardening                    | 29 ++++++++
 11 files changed, 224 insertions(+), 18 deletions(-)
---
 v3: dropped __GFP_NO_AUTOINIT patches
 v5: dropped support for SLOB allocator, handle SLAB_TYPESAFE_BY_RCU
 v6: changed wording in boot-time message
 v7: dropped the test_meminit.c patch (picked by Andrew Morton already),
     minor wording changes
 v8: fixes for interoperability with other heap debugging features
 v9: added support for page/slab poisoning
-- 
2.22.0.410.gd8fdbe21b5-goog

