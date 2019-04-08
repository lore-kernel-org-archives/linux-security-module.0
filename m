Return-Path: <SRS0=KU/V=SK=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981BFC10F13
	for <linux-security-module@archiver.kernel.org>; Mon,  8 Apr 2019 17:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 682AF20880
	for <linux-security-module@archiver.kernel.org>; Mon,  8 Apr 2019 17:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YqzP19dH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbfDHREX (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 8 Apr 2019 13:04:23 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:34743 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfDHREX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 8 Apr 2019 13:04:23 -0400
Received: by mail-qk1-f201.google.com with SMTP id s70so12193122qka.1
        for <linux-security-module@vger.kernel.org>; Mon, 08 Apr 2019 10:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=gJ3i63zTqGOr5CNiCKsCMRuhMkPExPtND8GkfCcQS2Q=;
        b=YqzP19dHuQebbAYxe2mou1n0zxSnH06cAOlwbvW8kTSCKCgsN1WWn+EvRRQvYZRLdq
         UCuoIQKHN/4S6Cb0Oy4me/hV7eTDR5eOfalQDYOtJbQ8dpyN2jFDN9o9hz9RC5FuIfiH
         LuMOYAaB+Z/2GcxW/Oqut/dHgYYGYIdsHufYHOshnik8A7w0xKEuG99r0fqXZQ5o1fta
         DKsSmsFI0ALEgLi6gsBrLCoFHSdjJhdeJBE1NbPROnAIhj8W5lzXelM7c2tLk9vYXdpe
         p3EY01Sxnil0YZu1Ra90f4m91LbkKy4H1XxacVXl+ZC65ooINSZb4YF9Zuam14D+TCaE
         sGGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=gJ3i63zTqGOr5CNiCKsCMRuhMkPExPtND8GkfCcQS2Q=;
        b=cbnPZphsTLtoeWqg3PkxK5gkq19I0z5n00tX8F2bcqhjWIXWAA5eXasdDxGPaYJnvL
         SQt/lviNodMJMbfi1/8ecg5dkZhj3zTuREH/7jzDTusMNsCtyZaODlsxMH517d/2QOsp
         Eryc3bO5N37ydkedWpc7ePxpHINzW58aW7zbHXp3TEfDStkvcdT6Nd3qhc43NqRI1C5S
         e/ge6ac9FwyoL6DOVu5gsA9GLFBz0+sstgNEwyX/kcgwxJYTje2bwnUUNL8ZqotobAaS
         EeB8+crB6Eq/KsEDS0H+/V2Pph1quCsxsna9mL9JWQxieFWoDDhstzROAoc/p2ozTgpo
         IXLA==
X-Gm-Message-State: APjAAAVc7lLA+FnjtTBhNE2VxR2tcvkVzUCAm47DKW5AFKF6fqQqz2JN
        /HKqWajfRwDrMnp2YOWu3qQAcMxz4Yo=
X-Google-Smtp-Source: APXvYqx4BCl069ZIbi878+ZaIUqcQL1mhPGU0o5zACT1AzSsYBxz94b80Lelh1NbqvxY+K6hRYA4amz28DU=
X-Received: by 2002:a37:945:: with SMTP id 66mr3615697qkj.60.1554743062602;
 Mon, 08 Apr 2019 10:04:22 -0700 (PDT)
Date:   Mon,  8 Apr 2019 19:04:16 +0200
Message-Id: <20190408170418.148554-1-glider@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v3 0/2] RFC: introduce CONFIG_INIT_ALL_MEMORY
From:   Alexander Potapenko <glider@google.com>
To:     yamada.masahiro@socionext.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kbuild@vger.kernel.org, ndesaulniers@google.com,
        kcc@google.com, dvyukov@google.com, keescook@chromium.org,
        sspatil@android.com, kernel-hardening@lists.openwall.com
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
The heap initialization part is compiler-agnostic and is based on the
existing CONFIG_SLUB_DEBUG and CONFIG_PAGE_POISONING.

Alexander Potapenko (2):
  initmem: introduce CONFIG_INIT_ALL_MEMORY and CONFIG_INIT_ALL_STACK
  initmem: introduce CONFIG_INIT_ALL_HEAP

 Makefile                 |  3 ++-
 mm/page_poison.c         |  5 +++++
 mm/slub.c                |  2 ++
 scripts/Makefile.initmem | 10 ++++++++++
 security/Kconfig         |  1 +
 security/Kconfig.initmem | 40 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 60 insertions(+), 1 deletion(-)
 create mode 100644 scripts/Makefile.initmem
 create mode 100644 security/Kconfig.initmem

-- 
2.21.0.392.gf8f6787159e-goog

