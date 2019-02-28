Return-Path: <SRS0=r65R=RD=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725E6C43381
	for <linux-security-module@archiver.kernel.org>; Thu, 28 Feb 2019 21:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 275392084F
	for <linux-security-module@archiver.kernel.org>; Thu, 28 Feb 2019 21:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U6XmUlHD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbfB1V2z (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 28 Feb 2019 16:28:55 -0500
Received: from mail-it1-f172.google.com ([209.85.166.172]:56108 "EHLO
        mail-it1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbfB1V2z (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 28 Feb 2019 16:28:55 -0500
Received: by mail-it1-f172.google.com with SMTP id z131so16991339itf.5
        for <linux-security-module@vger.kernel.org>; Thu, 28 Feb 2019 13:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=lo/JvVTQE4I5wGCfn1vSplMk3xnMhXABB2NqHLEsaQA=;
        b=U6XmUlHDnLJfCGWgF07dSdGO071uAEjd33/xkwWOT1c9407Jc1lDOhN4sQ7d5YMebu
         ewTrnSzJsbd0J8Fem0bcH/R68GjBUeknJY5aeeMG0jdeoAAFGI/lgkpXFBSRegmI+mI+
         XI7k9cy2L1gx+tpq/F6cnzvq031ciUz9nEsyVf2XEmUrGlbUOHSxBkfBl6QLsGtz1NpG
         YAepPzkkDEdwsUgM+E1S3siWB1JIiho67SCv1AZJTfotaSEUzpJuG0xei77+d9kdTKa5
         yfqnPi49ta4thwL6FCHOXP3iMKuj5Zaq8ue2P7AqaQL3WlVO89kdOxyC6L+eO+kOam6/
         IQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=lo/JvVTQE4I5wGCfn1vSplMk3xnMhXABB2NqHLEsaQA=;
        b=g2o+HoLsqn0M9VZE518vFkgOwY4thgTTKmn868r2P1XQhN4p6w0c4197quDl/NjaWu
         7h6NnDKod+G0SiYjCYq1mOdapAMvSjYZ9sjmFQSaFmRLC0FLag1+cwwcP5mTndezRmYk
         Pqf/3yw2BnAdQn8As1cyv2zr28/Jlm1arvngmhmFQtX2UUDhP0fFQaimuzyDwvMVuEU8
         TdMa1hbmcwmTgdYQVCW3xFsu0WQvl8E4oQtqB6wsbIAVnoWLL9tWDLMGeGmHn1aWDRd6
         hVEbe6uMIzj6COCe4FmodjbpCKXPu+lYhpPXK2r2e+RdhE4N1fMDBZ7a461JZak7BJjw
         xjNA==
X-Gm-Message-State: APjAAAX23DAp6Wlne1zaNp6d4m0QEH0RNLkYq9SGg548tlcNl3/TAoAj
        Q8VyAf+bJ7xoN0btu+T4HPfGTb73z9FfnvPMzGwbAA==
X-Google-Smtp-Source: APXvYqwD47PgS6b+dGFhb1JFZ0sJhyWMuqb0pbU6TVL+b55jKYrpCep8BdWenTEZY9FYWHif14xL3FhKNvrONMRKyYg=
X-Received: by 2002:a24:7908:: with SMTP id z8mr1381172itc.16.1551389333486;
 Thu, 28 Feb 2019 13:28:53 -0800 (PST)
MIME-Version: 1.0
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 28 Feb 2019 13:28:42 -0800
Message-ID: <CACdnJuvW47m3JvEcuEX1bsr+L2Ht9LDn_iCuPbHLOoaohOFW4Q@mail.gmail.com>
Subject: [PULL REQUEST] Lock down patches
To:     jmorris@namei.org
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi James,

David is low on cycles at the moment, so I'm taking over for this time
round. This patchset introduces an optional kernel lockdown feature,
intended to strengthen the boundary between UID 0 and the kernel. When
enabled and active (by enabling the config option and passing the
"lockdown" option on the kernel command line), various pieces of
kernel functionality are restricted. Applications that rely on
low-level access to either hardware or the kernel may cease working as
a result - therefore this should not be enabled without appropriate
evaluation beforehand.

The majority of mainstream distributions have been carrying variants
of this patchset for many years now, so there's value in providing a
unified upstream implementation to reduce the delta. This PR probably
doesn't meet every distribution requirement, but gets us much closer
to not requiring external patches.

This PR is mostly the same as the previous attempt, but with the
following changes:

1) The integration between EFI secure boot and the lockdown state has
been removed
2) A new CONFIG_KERNEL_LOCK_DOWN_FORCE kconfig option has been added,
which will always enable lockdown regardless of the kernel command
line
3) The integration with IMA has been dropped for now. Requiring the
use of the IMA secure boot policy when lockdown is enabled isn't
practical for most distributions at the moment, as there's still not a
great deal of infrastructure for shipping packages with appropriate
IMA signatures, and it makes it complicated for end users to manage
custom IMA policies.

The following changes since commit a3b22b9f11d9fbc48b0291ea92259a5a810e9438:

  Linux 5.0-rc7 (2019-02-17 18:46:40 -0800)

are available in the Git repository at:

  https://github.com/mjg59/linux lock_down

for you to fetch changes up to 43e004ecae91bf9159b8e91cd1d613e58b8f63f8:

  lockdown: Print current->comm in restriction messages (2019-02-28
11:19:23 -0800)

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

Kyle McMartin (1):
      Add a SysRq option to lift kernel lockdown

Linn Crosetto (2):
      acpi: Disable ACPI table override if the kernel is locked down
      acpi: Disable APEI error injection if the kernel is locked down

Matthew Garrett (7):
      Restrict /dev/{mem,kmem,port} when the kernel is locked down
      kexec_load: Disable at runtime if the kernel is locked down
      uswsusp: Disable when the kernel is locked down
      PCI: Lock down BAR access when the kernel is locked down
      x86: Lock down IO port access when the kernel is locked down
      x86/msr: Restrict MSR access when the kernel is locked down
      ACPI: Limit access to custom_method when the kernel is locked down

 arch/x86/Kconfig                       |  20 ++++++++++++-----
 arch/x86/include/asm/setup.h           |   2 ++
 arch/x86/kernel/ioport.c               |   6 ++++--
 arch/x86/kernel/kexec-bzimage64.c      |   1 +
 arch/x86/kernel/msr.c                  |  10 +++++++++
 arch/x86/mm/testmmiotrace.c            |   3 +++
 crypto/asymmetric_keys/verify_pefile.c |   4 +++-
 drivers/acpi/apei/einj.c               |   3 +++
 drivers/acpi/custom_method.c           |   3 +++
 drivers/acpi/osl.c                     |   2 +-
 drivers/acpi/tables.c                  |   5 +++++
 drivers/char/mem.c                     |   2 ++
 drivers/input/misc/uinput.c            |   1 +
 drivers/pci/pci-sysfs.c                |   9 ++++++++
 drivers/pci/proc.c                     |   9 +++++++-
 drivers/pci/syscall.c                  |   3 ++-
 drivers/pcmcia/cistpl.c                |   3 +++
 drivers/tty/serial/serial_core.c       |   6 ++++++
 drivers/tty/sysrq.c                    |  19 +++++++++++------
 fs/debugfs/file.c                      |  28 ++++++++++++++++++++++++
 fs/debugfs/inode.c                     |  30 ++++++++++++++++++++++++--
 fs/proc/kcore.c                        |   2 ++
 include/linux/ima.h                    |   6 ++++++
 include/linux/input.h                  |   5 +++++
 include/linux/kernel.h                 |  17 +++++++++++++++
 include/linux/kexec.h                  |   4 ++--
 include/linux/security.h               |   9 +++++++-
 include/linux/sysrq.h                  |   8 ++++++-
 kernel/bpf/syscall.c                   |   3 +++
 kernel/debug/kdb/kdb_main.c            |   2 +-
 kernel/events/core.c                   |   5 +++++
 kernel/kexec.c                         |   7 ++++++
 kernel/kexec_file.c                    |  56
++++++++++++++++++++++++++++++++++++++++++------
 kernel/kprobes.c                       |   3 +++
 kernel/module.c                        |  56
++++++++++++++++++++++++++++++++++++------------
 kernel/params.c                        |  26 ++++++++++++++++++-----
 kernel/power/hibernate.c               |   2 +-
 kernel/power/user.c                    |   3 +++
 security/Kconfig                       |  24 +++++++++++++++++++++
 security/Makefile                      |   3 +++
 security/lock_down.c                   | 106
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 41 files changed, 466 insertions(+), 50 deletions(-)
 create mode 100644 security/lock_down.c
