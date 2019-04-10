Return-Path: <SRS0=my8L=SM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F001EC10F14
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 16:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B621920854
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 16:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XpXvL2K4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387711AbfDJQQh (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:16:37 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36606 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387703AbfDJQQU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Apr 2019 12:16:20 -0400
Received: by mail-pg1-f193.google.com with SMTP id 85so1851127pgc.3
        for <linux-security-module@vger.kernel.org>; Wed, 10 Apr 2019 09:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=x2KYJib3dOzOX8W30eA/GdsrFGJ1QDL/O1I+P3kYlwg=;
        b=XpXvL2K4TmeTB6apty/+7j6PaDGjBWukrD4XgOwH9jLi+UosDmIFjrCJSyhUPwI24r
         t9Qz8BPGmRFt3uOj8lrdM/YocFw48FOg9wQe5zN745/WR4lqDEAOREOVv818ht6yOHhw
         oaMsZGMubKVo6KkCHERJnTkhBjwwymhVBTj/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=x2KYJib3dOzOX8W30eA/GdsrFGJ1QDL/O1I+P3kYlwg=;
        b=U4xUAsPKNzHmbfPJdpaM4RJb2A6ESCZKTy2kBIaA1LDIH8prhfXnMyPFRWZC3R6ovU
         Lq9HZtr2iUrzZn4xffRF6fjxc4xh+8L4wdODtiG3Y+RvWdHCwz/VmYWh48kAc6pRkXrG
         lQ+FT4cOmZMQA86Dk4LVX7VN1H07wKw3Ga98/71H/rn3JV4XPCzP1ZCmO8FuEVaRf5Y0
         numf0AHLGIUcVP1nu6t8+RrTmiqQI1fBXdtNHuDj05OrmHS3XgcM9Q9ihBQ5jACbovh1
         fUu/nRf09wsR67EnyoW+nwlyn/nZGVQ8A8SEcCwFt/7TlU+ahvf/Sa5O57NtFaW8QO2E
         /jAA==
X-Gm-Message-State: APjAAAU8veV0zkL6pbxhniOsvcmkCxExwcu+FDT+NDpeAmcGKCZ9x4L6
        yTjfuz5R94TK8w07t3UMWEToQw==
X-Google-Smtp-Source: APXvYqxV7u4z3SP7rQZaoXm6DgmvlM21aDP/eOO6IxVz6Xq3ILyC5OTxhjHS1EiCzLNEbjzmkf0D4Q==
X-Received: by 2002:a65:6389:: with SMTP id h9mr42126678pgv.398.1554912979563;
        Wed, 10 Apr 2019 09:16:19 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id a12sm41025812pgq.21.2019.04.10.09.16.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Apr 2019 09:16:18 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sandeep Patil <sspatil@android.com>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Alexander Popov <alpopov@ptsecurity.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Emese Revfy <re.emese@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: [PATCH 0/3] Kconfig: Refactor memory initialization hardening
Date:   Wed, 10 Apr 2019 09:16:09 -0700
Message-Id: <20190410161612.18545-1-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This is a proposed alternative for the memory initialization series,
which refactoring the existing gcc plugins into a separate Kconfig
file and collects all the related options together with some more
language to describe their differences. The last patch adds the
Clang auto init option, as done by Alexander Potapenko.

Since there isn't really a good way to "select" with dependencies,
I've left out CONFIG_INIT_ALL_MEMORY for the moment...

-Kees

Kees Cook (3):
  Kconfig: Create "kernel hardening" config area
  kbuild: Move stackleak config to Kconfig.hardening
  kbuild: Implement Clang's stack initialization

 Makefile                    |   5 ++
 scripts/gcc-plugins/Kconfig | 121 +-------------------------
 security/Kconfig            |   2 +
 security/Kconfig.hardening  | 165 ++++++++++++++++++++++++++++++++++++
 4 files changed, 175 insertions(+), 118 deletions(-)
 create mode 100644 security/Kconfig.hardening

-- 
2.17.1

