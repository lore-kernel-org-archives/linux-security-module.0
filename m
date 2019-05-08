Return-Path: <SRS0=Yqxb=TI=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9944C04A6B
	for <linux-security-module@archiver.kernel.org>; Wed,  8 May 2019 15:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77FCE20656
	for <linux-security-module@archiver.kernel.org>; Wed,  8 May 2019 15:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GFN6F1CF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfEHPiK (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 8 May 2019 11:38:10 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:43349 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbfEHPiJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 8 May 2019 11:38:09 -0400
Received: by mail-qt1-f201.google.com with SMTP id q32so10353212qtk.10
        for <linux-security-module@vger.kernel.org>; Wed, 08 May 2019 08:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=jQTDk5zUQiu0jSAANSS6F2tKehHuyoJNILpoLlCvpOE=;
        b=GFN6F1CFAn8rem5iUDqLjf1tfi+RrhFiRNeh/0F2po0axneRlVapHhrppUL/61zKqa
         fqziisUOusgcNBy3YbprB/0BuVtDJreqKdohUPF1WERb9r4bJ3xZCcu4ADVbVfVB6f31
         F84NdwY+v3XeVNLpl7AvM3G0VguBxS7GRXu8APDPhsMHavQ2PJ8+w+3zWDJS+PLRRpI7
         MxxjitSgkHRhSyhrDMur3ihTXAk0Ftgs1r521FXCwSoQzNtSD2nAihFYWbdWXr7fx4yF
         Imhr3H9U682NR/6wHUZ2sy0nXTUp9qrTit0Sb4OCZM0m8HJEcpSQjyQYjKYB1xsIZJFE
         IfCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=jQTDk5zUQiu0jSAANSS6F2tKehHuyoJNILpoLlCvpOE=;
        b=HK4HZ+PbX5MoJ0f6vQ6pwCc1uBcMg2llFZS/LEQC0ry161rv9IM+K/xFHpZm+/ofjl
         HBt0zwfDWjW0R5CudU/NYdDmi+7pnd2gEApjJvWdLqj/Q74HNOzurvkYdjHPcnA1rQkO
         1Wf7S+oJBhdBAKK5bQKU5bUAkpO3q2ioC5EjQ2XmjmD/cVqc/pzUta6rEj1d0+D4ou+d
         BMU1W6L0eT8Vga/o12L3Y296ho05csBU8lFrF9tCiUHNgGkOa/3lDscQA/AD8nZu7aBy
         pyDcuvSe1gpFX2ezW1oRBo5pcKV6y0eYad8GhVvIt/nNLpeFrEndliek1z0v8vslJgh7
         X9Xg==
X-Gm-Message-State: APjAAAVvRU2I4svreSaBvWYryGVbuNVku0Vlnzptou8cfS5eZX6wSpCa
        F9WI/pfQZeWpa0H8RXwLAXLCoCAQuOM=
X-Google-Smtp-Source: APXvYqwB6BG1aUc84ClZ+1GOpENtD9vu+DWDbF6HSE0y1Oiy+N+VdKRxD9HjOVUJUdCXtfed6Q5q6eop53c=
X-Received: by 2002:ac8:3fe3:: with SMTP id v32mr31243311qtk.307.1557329888814;
 Wed, 08 May 2019 08:38:08 -0700 (PDT)
Date:   Wed,  8 May 2019 17:37:32 +0200
Message-Id: <20190508153736.256401-1-glider@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH 0/4] RFC: add init_on_alloc/init_on_free boot options
From:   Alexander Potapenko <glider@google.com>
To:     akpm@linux-foundation.org, cl@linux.com, keescook@chromium.org,
        labbott@redhat.com
Cc:     linux-mm@kvack.org, linux-security-module@vger.kernel.org,
        kernel-hardening@lists.openwall.com, yamada.masahiro@socionext.com,
        jmorris@namei.org, serge@hallyn.com, ndesaulniers@google.com,
        kcc@google.com, dvyukov@google.com, sspatil@android.com,
        rdunlap@infradead.org, jannh@google.com, mark.rutland@arm.com
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

Alexander Potapenko (4):
  mm: security: introduce init_on_alloc=1 and init_on_free=1 boot
    options
  lib: introduce test_meminit module
  gfp: mm: introduce __GFP_NOINIT
  net: apply __GFP_NOINIT to AF_UNIX sk_buff allocations

 .../admin-guide/kernel-parameters.txt         |   8 +
 drivers/infiniband/core/uverbs_ioctl.c        |   2 +-
 include/linux/gfp.h                           |   6 +-
 include/linux/mm.h                            |  22 ++
 include/net/sock.h                            |   5 +
 kernel/kexec_core.c                           |   4 +-
 lib/Kconfig.debug                             |   8 +
 lib/Makefile                                  |   1 +
 lib/test_meminit.c                            | 205 ++++++++++++++++++
 mm/dmapool.c                                  |   2 +-
 mm/page_alloc.c                               |  62 +++++-
 mm/slab.c                                     |  18 +-
 mm/slab.h                                     |  16 ++
 mm/slob.c                                     |  23 +-
 mm/slub.c                                     |  28 ++-
 net/core/sock.c                               |  31 ++-
 net/unix/af_unix.c                            |  13 +-
 security/Kconfig.hardening                    |  16 ++
 18 files changed, 439 insertions(+), 31 deletions(-)
 create mode 100644 lib/test_meminit.c

-- 
2.21.0.1020.gf2820cf01a-goog

