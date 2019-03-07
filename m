Return-Path: <SRS0=bVIv=RK=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69DFC43381
	for <linux-security-module@archiver.kernel.org>; Thu,  7 Mar 2019 13:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1438620684
	for <linux-security-module@archiver.kernel.org>; Thu,  7 Mar 2019 13:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ofh+iche"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbfCGNfb (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 7 Mar 2019 08:35:31 -0500
Received: from mail-yw1-f73.google.com ([209.85.161.73]:51185 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfCGNfb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 7 Mar 2019 08:35:31 -0500
Received: by mail-yw1-f73.google.com with SMTP id d64so8314525ywa.17
        for <linux-security-module@vger.kernel.org>; Thu, 07 Mar 2019 05:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=w0b66eCSHjA7yamgYjvLonTEgGkPBNVznOaKmQu3z+s=;
        b=Ofh+iche2kwqRbt+0K5SR5UtYVDKjSc4sqIPihTj0UlzHLQbkhO/E+0FLjMdQOS02k
         Ly9N17g42Nq4tdCnS8RQOTrlH0kOkYzpS8HY7Ftv0rzfYbcsBcu84iD2t4K9OgBFybjL
         YuDDc3k49DTe36vPxNG6kXnk+IBrd3gtjxq+oAOV9sHLWpeFZ8cRcu9+RPvVjgiuddOI
         UGIw/RlLPIwL1rFZGo9WDcTbsDLdX9QJZr2wwypjtx0Qt6iDD52tHVpuyTcBkIgjoT3t
         wN8ztR3mBw2biJLdCsUoM5u+ygHwlu7X66mw725tKCw0JsCweF8Us67LrSfY87UBoPJf
         tbRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=w0b66eCSHjA7yamgYjvLonTEgGkPBNVznOaKmQu3z+s=;
        b=FpRjOXliO5o5X/KEmYPzBoNIXIsz856ruO9+1chCrUcP9fM5CB5PnzwhtJkudUR0Un
         2/DnakaBWWJZNvKyggcdY4/IvB1KWx5QKQYY900N0B6ngxYFc8/7uDzEDVoEQJN+1LP1
         ceH99gbbWQUSHtNPtJRYY/Tdd+ffnsAPQsio3/d+h4chiuZaL5J0eA2k9t/6HWhXjx0S
         yzWXiVrToGxb2xi8c0BQqmpBniazW2zLzpHsyn3FPgEnSr6yaDqY3ptK3SS4FUP75loY
         DuDAE/HYYLhElCN0ShuRkZ9NgrqXOhRcPiQCVHnR/A6GVxsS61AxOU+asTQle2OPLZQk
         y1gQ==
X-Gm-Message-State: APjAAAVGX5Nax1XKajvq0LOchbsM68jJ6VIP3MzRF8YtCxMo4r7F5Be9
        q7B59IgLTgyJx/w+BW3LwD5RrGtskNg=
X-Google-Smtp-Source: APXvYqz34kwCm8PvgLlTDHnT+DQzQk/DXfDnxnyjGHtSUSuyfgx9OkBJOCczxqZHWNCAhZ5AAV1bN6EuCHY=
X-Received: by 2002:a81:480f:: with SMTP id v15mr5705367ywa.22.1551965730157;
 Thu, 07 Mar 2019 05:35:30 -0800 (PST)
Date:   Thu,  7 Mar 2019 14:35:13 +0100
Message-Id: <20190307133514.44378-1-glider@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH 0/1] RFC: introduce CONFIG_INIT_ALL_MEMORY
From:   Alexander Potapenko <glider@google.com>
To:     yamada.masahiro@socionext.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kbuild@vger.kernel.org, ndesaulniers@google.com,
        kcc@google.com, dvyukov@google.com, keescook@chromium.org,
        sspatil@android.com
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

The stack instrumentation part is only implemented in Clang at the moment
(see https://reviews.llvm.org/D54604 ; there's also a GCC feature request
for a similar flag: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=87210).
The heap initialization part (still work in progress) is going to be
compiler-agnostic.

It'll be possible to opt-out from stack initalization by annotating local
variables as knowingly initialized, or by disabling the feature for a
single translation unit.
Opting out for a heap allocation will be done using a special GFP flag.

Alexander Potapenko (1):
  initmem: introduce CONFIG_INIT_ALL_MEMORY and CONFIG_INIT_ALL_STACK

 Makefile                 |  3 ++-
 scripts/Makefile.initmem | 17 +++++++++++++++++
 scripts/Makefile.lib     |  6 ++++++
 security/Kconfig         |  1 +
 security/Kconfig.initmem | 22 ++++++++++++++++++++++
 5 files changed, 48 insertions(+), 1 deletion(-)
 create mode 100644 scripts/Makefile.initmem
 create mode 100644 security/Kconfig.initmem

-- 
2.21.0.352.gf09ad66450-goog

