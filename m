Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC395C3DA79
	for <linux-security-module@archiver.kernel.org>; Fri, 23 Dec 2022 18:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbiLWSK0 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 23 Dec 2022 13:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbiLWSK0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 23 Dec 2022 13:10:26 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9B61D0FB
        for <linux-security-module@vger.kernel.org>; Fri, 23 Dec 2022 10:10:21 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id v23so5606647pju.3
        for <linux-security-module@vger.kernel.org>; Fri, 23 Dec 2022 10:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3+W6znzYikgthIHqAsodQzTODii43I4pz6o86CSVkKY=;
        b=NlxFzFp6oxhdJwdm+cyc7GSZ5WJfeNogbUly2rKcbycHh9aBY/vO1gIiMTnoRjQ8xQ
         JjKiW2lody/8COOPqjoaDGWHHbuYINcwBh0xKkEF3DZUBwDExEwlSdbgjnYRt3M8Tuvg
         2DFn9Rk2qE9RSyWXqO003OUNPjC74700ZcM1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3+W6znzYikgthIHqAsodQzTODii43I4pz6o86CSVkKY=;
        b=Wwh4qgKPcMjtUm9S2ZWSUIJQJ6IPYllP0xDPQA1vAqOnNnkWyVqEYXSdyzmjBKyz5N
         xwq1LkHWXd8cb2t9Bn6VFDZ6iKmQpfAskWhFc2WNRWrB8zsHrJmVnYdp0LTD8SpcrSjb
         A4mEiXKL3YYTcOQU7zZ3gukZ1E8pKFlMFDia1oL3sAzOmBsHmj27+vf4yPAXdnweFYp5
         c1LLD8RpoQX+S52eTB/AWdwDRnFU53Bz6WG/mwoqDV0E+4DDfDRpZyedbDtb/a6H3NTu
         5s6VVxegMgNEaIUAQH/ispDtBVW5SrcmQm7K13H5EA5NpwNbOf2plBDhC67hJYgTYpcM
         T8Yg==
X-Gm-Message-State: AFqh2kpY34OXMYURZm0dWWYnz6Izc9T+OJzTAtuZOQWdW84vRalkh94d
        BzdH1qPZOlvl1VbCE6yal2gwSg==
X-Google-Smtp-Source: AMrXdXuNZNPYkACiKVfKc6KMMM98DCtIMH4HjpMg1lJrM6gl1VxbK+WW95O+/CAFdZNlRfCRFMjh9A==
X-Received: by 2002:a17:902:7488:b0:189:f708:9b67 with SMTP id h8-20020a170902748800b00189f7089b67mr11585591pll.46.1671819020829;
        Fri, 23 Dec 2022 10:10:20 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n2-20020a170902e54200b001887e30b9ddsm2633377plf.257.2022.12.23.10.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 10:10:20 -0800 (PST)
Date:   Fri, 23 Dec 2022 10:10:19 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        tangmeng <tangmeng@uniontech.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: [GIT PULL] kernel hardening fixes for v6.1-rc1
Message-ID: <202212231009.EC864645D8@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Linus,

Please pull these kernel hardening fixes for v6.1-rc1, collected over the
last week.

Thanks!

-Kees

The following changes since commit d272e01fa0a2f15c5c331a37cd99c6875c7b7186:

  ksmbd: replace one-element arrays with flexible-array members (2022-12-02 13:14:29 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.1-rc1-fixes

for you to fetch changes up to cf8016408d880afe9c5dc495af40dc2932874e77:

  cfi: Fix CFI failure with KASAN (2022-12-23 10:04:31 -0800)

----------------------------------------------------------------
kernel hardening fixes for v6.1-rc1

- Fix CFI failure with KASAN (Sami Tolvanen)

- Fix LKDTM + CFI under GCC 7 and 8 (Kristina Martsenko)

- Limit CONFIG_ZERO_CALL_USED_REGS to Clang > 15.0.6 (Nathan Chancellor)

- Ignore "contents" argument in LoadPin's LSM hook handling

- Fix paste-o in /sys/kernel/warn_count API docs

- Use READ_ONCE() consistently for oops/warn limit reading

----------------------------------------------------------------
Kees Cook (3):
      LoadPin: Ignore the "contents" argument of the LSM hooks
      docs: Fix path paste-o for /sys/kernel/warn_count
      exit: Use READ_ONCE() for all oops/warn limit reads

Kristina Martsenko (1):
      lkdtm: cfi: Make PAC test work with GCC 7 and 8

Nathan Chancellor (1):
      security: Restrict CONFIG_ZERO_CALL_USED_REGS to gcc or clang > 15.0.6

Sami Tolvanen (1):
      cfi: Fix CFI failure with KASAN

 Documentation/ABI/testing/sysfs-kernel-warn_count |  2 +-
 drivers/misc/lkdtm/cfi.c                          |  6 ++++-
 kernel/Makefile                                   |  3 ---
 kernel/exit.c                                     |  6 +++--
 kernel/panic.c                                    |  7 ++++--
 security/Kconfig.hardening                        |  3 +++
 security/loadpin/loadpin.c                        | 30 ++++++++++++++---------
 7 files changed, 36 insertions(+), 21 deletions(-)

-- 
Kees Cook
