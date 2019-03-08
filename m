Return-Path: <SRS0=RbId=RL=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A22EC43381
	for <linux-security-module@archiver.kernel.org>; Fri,  8 Mar 2019 13:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 272262087C
	for <linux-security-module@archiver.kernel.org>; Fri,  8 Mar 2019 13:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uHJY6Dx3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbfCHN1H (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 8 Mar 2019 08:27:07 -0500
Received: from mail-yw1-f74.google.com ([209.85.161.74]:56569 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfCHN1H (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 8 Mar 2019 08:27:07 -0500
Received: by mail-yw1-f74.google.com with SMTP id a199so27520875ywe.23
        for <linux-security-module@vger.kernel.org>; Fri, 08 Mar 2019 05:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ITxJ4DVi5/l/txR4/Ov/77/J0tyE1RyIZzC1WnI2dps=;
        b=uHJY6Dx3zxq51iFiZHcMLg6tWrh4gI9uXR3vNUXhIUVJXFuPx6b5TB8isN30eVgr1Q
         OT8xLTTXFNaGKMmrRD+SUINlCtA62ws/W5hGZbkO8ZpSIyz74sPTfGcVAYJRLJtb7j+T
         KJwu481nN4rIBM5KAsoXxlAqcvkQfEkvzSVeXG+byK4UjvQssQydkB+bIUQ1WRCbO/Al
         gLjKHjW3CQC/fr9fKyAut9Yh1hDUNc34ylGXBsHzx8BKKZM9bo77s++4yT6GZerNVpQo
         WHbof3h6mTE1is7OtRv+xfCG1L17D0c5HjuhK0BX0hWPItiDKeNmRT/A7c8SKEA1D4th
         4Ipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ITxJ4DVi5/l/txR4/Ov/77/J0tyE1RyIZzC1WnI2dps=;
        b=JoU8WtbVYUwqbMavwMECp7VGOMNU3WIA5c7kLY7repBme3XZkbVHhH6yrfQb5alfH6
         po1MltVQxjTB3h/MNMGwejVAefyaNUbk1pnM5+UmnkgfpBrLx7FOykKts601NdnB6rTW
         shY2RPdjn5wVg2cu/OzzqNXzXZ5wLKVVvJ3i2mVplQCQRlGKsMx3zcnNFUxXgfaunUTd
         Q+v7rsSYBZNlLYs7A+kDxmb8BvnvddRD8TNMG/6YIFkmoQE67oDtII5QEKXOczj/pKpM
         6BSi0AMs1DDdUrSVrr9E1D73DVBpFO+4sZXOVavSLoYqHvat8A5yvmU8LzHKS3QYht9O
         FazQ==
X-Gm-Message-State: APjAAAW1/iH4slpn68zyrla+K0X7anAV0YnadoUnZ6WIa9TX0M12lXIw
        hWFxXUOgoO2qSA+/egkfc2nyQ6wkbnM=
X-Google-Smtp-Source: APXvYqywMqhV9eMkPfFNzDOrgKegMbyDfouE8Wd+4w50Y8ZyTFSbINYzxSrtswQw8TGuZFu4DI8s+oQ7PBk=
X-Received: by 2002:a25:8b0f:: with SMTP id i15mr9074047ybl.32.1552051626130;
 Fri, 08 Mar 2019 05:27:06 -0800 (PST)
Date:   Fri,  8 Mar 2019 14:26:59 +0100
Message-Id: <20190308132701.133598-1-glider@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
Subject: [PATCH v2 0/2] RFC: introduce CONFIG_INIT_ALL_MEMORY
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
 scripts/Makefile.lib     |  6 ++++++
 security/Kconfig         |  1 +
 security/Kconfig.initmem | 40 ++++++++++++++++++++++++++++++++++++++++
 7 files changed, 66 insertions(+), 1 deletion(-)
 create mode 100644 scripts/Makefile.initmem
 create mode 100644 security/Kconfig.initmem

-- 
2.21.0.360.g471c308f928-goog

