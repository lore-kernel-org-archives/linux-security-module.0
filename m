Return-Path: <SRS0=QYhf=SU=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09476C10F0E
	for <linux-security-module@archiver.kernel.org>; Thu, 18 Apr 2019 15:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA36A2083D
	for <linux-security-module@archiver.kernel.org>; Thu, 18 Apr 2019 15:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AR5AIo/F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388070AbfDRPm1 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 18 Apr 2019 11:42:27 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:39305 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387519AbfDRPm0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 18 Apr 2019 11:42:26 -0400
Received: by mail-pg1-f202.google.com with SMTP id m35so1580908pgl.6
        for <linux-security-module@vger.kernel.org>; Thu, 18 Apr 2019 08:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=c6cte1GA0N3UXNBho2QutaVeM3bmO26Ex5C2Za+9lAo=;
        b=AR5AIo/FYzzbLDe/+9fNlgTRd1JlWeeO5nMeBPeV46W1GkksSc+qaMrdyXrh5Do9QE
         JrAtIvsVVJYnQicJlXhQWt6iN8wTEm+Zqyxz68lkMJv3246rOgmqdPmxWUZ3jloUjdIm
         1+UN9Hq82jsq3ts0wfHArPjrYSr916UnXKE1cST6NOrZaHvJUxwdwq9X4Pw9HAeX+fbT
         s2IWr2t82RK50Pd/YxBLEWUZI18RibVNAJ98YbilJoXUdXr/aLXfT+cZ3in1fV5ZC3fE
         POKFx+4dSkY2PAvonxY4ahEyxLlH7ueLjdZnRhhaZbB3BNqsWAYxHqkgeEMvFGkVGFnC
         t8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=c6cte1GA0N3UXNBho2QutaVeM3bmO26Ex5C2Za+9lAo=;
        b=fHT/vCaVP907Zfntqw2sFTbQ+dDZPXhSxfXI8Fndd6T30L8fzJLQ0UOxUEc34xMrBK
         Khbw/P/BTqD/iqQuhHuDIXIWTm3TbYqqQRMVcggdff2BvRGVWRtKIM8bkzBK8BGFW2ut
         gdwoKGxyVGrOBT3XO1+SzX4hg0AGlOjyn5+AMDCasqfakcksv7ckUq9p5R1VyBxGseB6
         3vIB2K1N17MmkqaMGjvG/euB+Kb2aseNTGwBjzelwGhcrpNxwj7GI4pAMmHOTLHxXHIf
         8jrdMJBwgxkjkpQK2eAuCSROC9ugdIucxoly3Izo5Zvy6x7zYEPZaFBPHVFinDmWckU+
         dtLQ==
X-Gm-Message-State: APjAAAUB0AHFU+bnzmyYUbvsk+j9Av4/J9Sa94eVyUatdt7H6T0knVvt
        wg+VCZ5P0jYIsdAme+ZfQx8+m9VOk6o=
X-Google-Smtp-Source: APXvYqzlWFUlYk1TyzNFNdkmxacEV9kEkpY+WAHWzfS82vhaZYY6jgkKpDzAz2ONekaghvjOar/WrEYb+3w=
X-Received: by 2002:a63:170d:: with SMTP id x13mr90021965pgl.169.1555602145919;
 Thu, 18 Apr 2019 08:42:25 -0700 (PDT)
Date:   Thu, 18 Apr 2019 17:42:05 +0200
Message-Id: <20190418154208.131118-1-glider@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH 0/3] RFC: add init_allocations=1 boot option
From:   Alexander Potapenko <glider@google.com>
To:     akpm@linux-foundation.org, cl@linux.com, dvyukov@google.com,
        keescook@chromium.org, labbott@redhat.com
Cc:     linux-mm@kvack.org, linux-security-module@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Following the recent discussions here's another take at initializing
pages and heap objects with zeroes. This is needed to prevent possible
information leaks and make the control-flow bugs that depend on
uninitialized values more deterministic.

The patchset introduces a new boot option, init_allocations, which
makes page allocator and SL[AOU]B initialize newly allocated memory.
init_allocations=0 doesn't (hopefully) add any overhead to the
allocation fast path (no noticeable slowdown on hackbench).

With only the the first of the proposed patches the slowdown numbers are:
 - 1.1% (stdev 0.2%) sys time slowdown building Linux kernel
 - 3.1% (stdev 0.3%) sys time slowdown on af_inet_loopback benchmark
 - 9.4% (stdev 0.5%) sys time slowdown on hackbench

The second patch introduces a GFP flag that allows to disable
initialization for certain allocations. The third page is an example of
applying it to af_unix.c, which helps hackbench greatly.

Slowdown numbers for the whole patchset are:
 - 1.8% (stdev 0.8%) on kernel build
 - 6.5% (stdev 0.2%) on af_inet_loopback
 - 0.12% (stdev 0.6%) on hackbench


Alexander Potapenko (3):
  mm: security: introduce the init_allocations=1 boot option
  gfp: mm: introduce __GFP_NOINIT
  net: apply __GFP_NOINIT to AF_UNIX sk_buff allocations

 drivers/infiniband/core/uverbs_ioctl.c |  2 +-
 include/linux/gfp.h                    |  6 ++++-
 include/linux/mm.h                     |  8 +++++++
 include/linux/slab_def.h               |  1 +
 include/linux/slub_def.h               |  1 +
 include/net/sock.h                     |  5 +++++
 kernel/kexec_core.c                    |  4 ++--
 mm/dmapool.c                           |  2 +-
 mm/page_alloc.c                        | 18 ++++++++++++++-
 mm/slab.c                              | 14 ++++++------
 mm/slab.h                              |  1 +
 mm/slab_common.c                       | 15 +++++++++++++
 mm/slob.c                              |  3 ++-
 mm/slub.c                              |  9 ++++----
 net/core/sock.c                        | 31 +++++++++++++++++++++-----
 net/unix/af_unix.c                     | 13 ++++++-----
 16 files changed, 104 insertions(+), 29 deletions(-)

-- 
2.21.0.392.gf8f6787159e-goog

