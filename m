Return-Path: <SRS0=q+Rt=R4=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E81C43381
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Mar 2019 22:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66675206C0
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Mar 2019 22:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tuxR87J9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730545AbfCYWJ7 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:09:59 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:54660 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729681AbfCYWJ7 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 25 Mar 2019 18:09:59 -0400
Received: by mail-pl1-f202.google.com with SMTP id o61so768015pld.21
        for <linux-security-module@vger.kernel.org>; Mon, 25 Mar 2019 15:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=pjR7XJ1OmZTtPJuTlRY67FxbWdfau1kaTCZsV7dUOy0=;
        b=tuxR87J9eko5+/swYDPa7REUCxy/XSGQWj7oH+FPB4sAx8wGeFKkBbB5280wXw2XLv
         sxK+BIRPlaEpyBRJPFGHwJASfP4iipvLj9KiVxANN9eyxfswDWDCH5lLVtzdCyTQ2eU7
         7k5VtCJM0OkRsQpozwz6qcL++p4aTFWmUOCtvBTBFUdWCThfDi3YbdjEr4+CkY45fulY
         trztmkZrZoeesBhU5FLbw4tgsinqIXZ0O23A1L3X3w8wQn8W/epsfVMgXO5KfZfEsiaG
         czbKxlaqpS5/UoZgleX5GljpWVNMxR0e4oM0qJ/Jt7K3NfrxctPEBCsQfcFParX0fkp+
         2JYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=pjR7XJ1OmZTtPJuTlRY67FxbWdfau1kaTCZsV7dUOy0=;
        b=VizAIri9M7LYlBP5weYwhIwh62sg2UeXRUEq0OJWMbTR+RW7hOTQUTirf+3BXNGfbh
         ugce0VQ5pmhix/JEkwx10vVCf9piz+pNAjvA+Evv0egN1di8lWu49ZwZcMUhomU40R2g
         BtiJb+sWfzNhnJ07wRRkrw4dTPXRi9n4T1MfS2BrAlXTWJ5kL6bmLxCRPUwiBvGiB7/c
         ZjR/nCK3Yj1FnLTkaJ/28ib/Re8r1fFAh73AhhzJXWVn2LljThOWf3HPio0bZTa2VUnb
         ExVscDI0ptdwdNOeBtnokt9LyP8W7XAZ97FmrINcN/hXeFocVlAdAFSpYbKIyvyVuMhG
         27fQ==
X-Gm-Message-State: APjAAAXJAsC5joxhGINoBv8z4LfxSAm01KRx1xbHrXnhqKD0A1D6qQNw
        b7G9BxsBYwRYEm5CP8ditjm0eWj0XtxL00HNDs8aKQ==
X-Google-Smtp-Source: APXvYqzp7oGGkdO08lKfxZ3iui0OKnsZFCoKpHEmSjGqdkxJSssavU4ToTdO3E4p1p+hNLLwXobbZPbmJpEFeR5iOzG7Pw==
X-Received: by 2002:a63:dc50:: with SMTP id f16mr1767198pgj.396.1553551798234;
 Mon, 25 Mar 2019 15:09:58 -0700 (PDT)
Date:   Mon, 25 Mar 2019 15:09:27 -0700
Message-Id: <20190325220954.29054-1-matthewgarrett@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PULL REQUEST] Lockdown patches for 5.2
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The following changes since commit 468e91cecb3218afd684b8c422490dfebe0691bb:

  keys: fix missing __user in KEYCTL_PKEY_QUERY (2019-03-04 15:48:37 -0800)

are available in the Git repository at:

  https://github.com/mjg59/linux lock_down

for you to fetch changes up to 1c57935ab108280aa79fe4420d4bc13e19bd38e2:

  kexec: Allow kexec_file() with appropriate IMA policy when locked down (2019-03-25 15:00:35 -0700)

This version replaces the original IMA integration with a new approach
tied to IMA architecture policy. It also drops the sysrq patch for now,
since that primarily makes sense in the context of lockdown policy being
automatically enabled based on boot state.

----------------------------------------------------------------
Dave Young (1):
      Copy secure_boot flag in boot params across kexec reboot

David Howells (12):
      Add the ability to lock down access to the running kernel image
      Enforce module signatures if the kernel is locked down
      Prohibit PCMCIA CIS storage when the kernel is locked down
      Lock down TIOCSSERIAL
      Lock down module params that specify hardware parameters (eg. ioport)
      x86/mmiotrace: Lock down the testmmiotrace module
      Lock down /proc/kcore
      Lock down kprobes
      bpf: Restrict kernel image access functions when the kernel is locked down
      Lock down perf
      debugfs: Restrict debugfs when the kernel is locked down
      lockdown: Print current->comm in restriction messages

Jiri Bohac (2):
      kexec_file: split KEXEC_VERIFY_SIG into KEXEC_SIG and KEXEC_SIG_FORCE
      kexec_file: Restrict at runtime if the kernel is locked down

Josh Boyer (2):
      hibernate: Disable when the kernel is locked down
      acpi: Ignore acpi_rsdp kernel param when the kernel has been locked down

Linn Crosetto (2):
      acpi: Disable ACPI table override if the kernel is locked down
      acpi: Disable APEI error injection if the kernel is locked down

Matthew Garrett (8):
      Restrict /dev/{mem,kmem,port} when the kernel is locked down
      kexec_load: Disable at runtime if the kernel is locked down
      uswsusp: Disable when the kernel is locked down
      PCI: Lock down BAR access when the kernel is locked down
      x86: Lock down IO port access when the kernel is locked down
      x86/msr: Restrict MSR access when the kernel is locked down
      ACPI: Limit access to custom_method when the kernel is locked down
      kexec: Allow kexec_file() with appropriate IMA policy when locked down

 arch/x86/Kconfig                       | 20 +++++++++---
 arch/x86/kernel/ioport.c               |  6 ++--
 arch/x86/kernel/kexec-bzimage64.c      |  1 +
 arch/x86/kernel/msr.c                  | 10 ++++++
 arch/x86/mm/testmmiotrace.c            |  3 ++
 crypto/asymmetric_keys/verify_pefile.c |  4 ++-
 drivers/acpi/apei/einj.c               |  3 ++
 drivers/acpi/custom_method.c           |  3 ++
 drivers/acpi/osl.c                     |  2 +-
 drivers/acpi/tables.c                  |  5 +++
 drivers/char/mem.c                     |  2 ++
 drivers/pci/pci-sysfs.c                |  9 +++++
 drivers/pci/proc.c                     |  9 ++++-
 drivers/pci/syscall.c                  |  3 +-
 drivers/pcmcia/cistpl.c                |  3 ++
 drivers/tty/serial/serial_core.c       |  6 ++++
 fs/debugfs/file.c                      | 28 ++++++++++++++++
 fs/debugfs/inode.c                     | 30 +++++++++++++++--
 fs/proc/kcore.c                        |  2 ++
 include/linux/ima.h                    |  9 +++++
 include/linux/kernel.h                 | 17 ++++++++++
 include/linux/kexec.h                  |  4 +--
 include/linux/security.h               |  9 ++++-
 kernel/bpf/syscall.c                   |  3 ++
 kernel/events/core.c                   |  5 +++
 kernel/kexec.c                         |  7 ++++
 kernel/kexec_file.c                    | 59 +++++++++++++++++++++++++++++----
 kernel/kprobes.c                       |  3 ++
 kernel/module.c                        | 39 ++++++++++++++++++----
 kernel/params.c                        | 26 ++++++++++++---
 kernel/power/hibernate.c               |  2 +-
 kernel/power/user.c                    |  3 ++
 security/Kconfig                       | 15 +++++++++
 security/Makefile                      |  3 ++
 security/integrity/ima/ima.h           |  2 ++
 security/integrity/ima/ima_main.c      |  2 +-
 security/integrity/ima/ima_policy.c    | 50 ++++++++++++++++++++++++++++
 security/lock_down.c                   | 60 ++++++++++++++++++++++++++++++++++
 38 files changed, 430 insertions(+), 37 deletions(-)
 create mode 100644 security/lock_down.c


