Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6F2C433FE
	for <linux-security-module@archiver.kernel.org>; Fri, 17 Sep 2021 01:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14DE461209
	for <linux-security-module@archiver.kernel.org>; Fri, 17 Sep 2021 01:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242108AbhIQBQE (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 Sep 2021 21:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbhIQBQD (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Sep 2021 21:16:03 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC540C061574
        for <linux-security-module@vger.kernel.org>; Thu, 16 Sep 2021 18:14:41 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id v24so23544766eda.3
        for <linux-security-module@vger.kernel.org>; Thu, 16 Sep 2021 18:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=IXFsf3S9171kOXzWISnp8DFsZk0X/Mh7ZJmg0BQdCQk=;
        b=r4TxF3YEpviUO2twgwwb+fdOpaaknIzngsytydyLCSB43uahpXjJ32Er38rNBzGyQt
         cMZr1JW/MLIEw3a+o7m4VltqPBIYuRDvuX0t8RBKm1p4xEk8Ruopjvokfs1ycA48DQzF
         xH0r6OJsSdOZ2Sz4C3UxUkX6EROirV4q7cx/7R7y5ZrMSYfxa/bMJefIKsqXiU6bJffi
         WGCJTZkbvUlzxh/lfldmXVH1rfIQkgJHarX3Cn9hgRdrTiAymLZoP6L879N1VKgRYN4z
         Rd8yquQSFljS2vCErHA7eAA4SLEcThZmB1vU/FPecAQacz+7ujijo14qhuPHGpoBsnI3
         Z0FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=IXFsf3S9171kOXzWISnp8DFsZk0X/Mh7ZJmg0BQdCQk=;
        b=5p5IvAEeMne2IqY2meTpMJiu9B2RJ5s4CWeTKZLcRKTHu3qEh/sVUPuWIYdGOq9KGW
         fmUcpjZYMHydvzEsVkPXcpG9oSU22k1l9Ri6fhFcyq4WPcNec52AlL6pYAAGAK35+VS7
         ETkuvpoOsPKWe3XZn1sFSscEDkP6b27JT06fslczMfimraSFVxRkBFjl4GtObIWEV4Ps
         cR1kwYDtscsjKdUzfZfS/EU5eZenbnG/vzPFte1ZyWguLJ+tQFZB88DLiJelLmCSmn+E
         RDnm93imve5vni6CcEcjMkz1Nrs3wuhbBVzaZfyQJMdTxdQnoGUsjHqc0uDAvzhiisTK
         ylmA==
X-Gm-Message-State: AOAM530xcEogaTc35NSobQ//yAEWFv2HoD7AQWDPsKFTal5ATvh0Y7tC
        cveIO2ygRfa/qk0uaLpfc6q4F+j73uMm29JzFsRT
X-Google-Smtp-Source: ABdhPJyusCA6H13GGdcS+UZv7BjCthuQOqPKQMgEqQ5KVB+6zkTXePe9RtzKs9kWZXlk5OtBQ6GifKo2O6IwcmJnsxA=
X-Received: by 2002:a17:906:8cd:: with SMTP id o13mr9399031eje.341.1631841280249;
 Thu, 16 Sep 2021 18:14:40 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 16 Sep 2021 21:14:29 -0400
Message-ID: <CAHC9VhQcxm=Zhe2XEesx3UsBgr8H6H=BtJc92roqeF8o+DK+XQ@mail.gmail.com>
Subject: [GIT PULL] SELinux fixes for v5.15 (#1)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Linus,

A single patch to address some issues with the incorrect subject being
used in some of the SELinux lockdown access controls.  You saw, and
joined the discussion, earlier versions of this patch that included
the related BPF changes; the BPF changes have already been merged,
this patch has all the remainders.  Beyond that, the commit
description is pretty good so if you are interested in more detail I
would suggest reading that first.

Please merge for the next v5.15-rcX release, thank you.
-Paul

--
The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

 Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20210916

for you to fetch changes up to fdc9cbff7a764513a5e72a03b796087fcadb2fa3:

 lockdown,selinux: fix wrong subject in some SELinux lockdown checks
   (2021-09-16 21:04:44 -0400)

----------------------------------------------------------------
selinux/stable-5.15 PR 20210916

----------------------------------------------------------------
Ondrej Mosnacek (1):
     lockdown,selinux: fix wrong subject in some SELinux lockdown checks

arch/powerpc/xmon/xmon.c             |  4 ++--
arch/x86/kernel/ioport.c             |  4 ++--
arch/x86/kernel/msr.c                |  4 ++--
arch/x86/mm/testmmiotrace.c          |  2 +-
drivers/acpi/acpi_configfs.c         |  2 +-
drivers/acpi/custom_method.c         |  2 +-
drivers/acpi/osl.c                   |  3 ++-
drivers/acpi/tables.c                |  2 +-
drivers/char/mem.c                   |  2 +-
drivers/cxl/pci.c                    |  2 +-
drivers/firmware/efi/efi.c           |  2 +-
drivers/firmware/efi/test/efi_test.c |  2 +-
drivers/pci/pci-sysfs.c              |  6 +++---
drivers/pci/proc.c                   |  6 +++---
drivers/pci/syscall.c                |  2 +-
drivers/pcmcia/cistpl.c              |  2 +-
drivers/tty/serial/serial_core.c     |  2 +-
fs/debugfs/file.c                    |  2 +-
fs/debugfs/inode.c                   |  2 +-
fs/proc/kcore.c                      |  2 +-
fs/tracefs/inode.c                   |  2 +-
include/linux/lsm_hook_defs.h        |  2 +-
include/linux/lsm_hooks.h            |  1 +
include/linux/security.h             |  5 +++--
kernel/bpf/helpers.c                 | 10 ++++++----
kernel/events/core.c                 |  2 +-
kernel/kexec.c                       |  2 +-
kernel/kexec_file.c                  |  2 +-
kernel/module.c                      |  2 +-
kernel/params.c                      |  2 +-
kernel/power/hibernate.c             |  2 +-
kernel/trace/bpf_trace.c             | 25 +++++++++++++++----------
kernel/trace/ftrace.c                |  4 ++--
kernel/trace/ring_buffer.c           |  2 +-
kernel/trace/trace.c                 | 10 +++++-----
kernel/trace/trace_events.c          |  2 +-
kernel/trace/trace_events_hist.c     |  4 ++--
kernel/trace/trace_events_synth.c    |  2 +-
kernel/trace/trace_events_trigger.c  |  2 +-
kernel/trace/trace_kprobe.c          |  6 +++---
kernel/trace/trace_printk.c          |  2 +-
kernel/trace/trace_stack.c           |  2 +-
kernel/trace/trace_stat.c            |  2 +-
kernel/trace/trace_uprobe.c          |  4 ++--
net/xfrm/xfrm_user.c                 | 11 +++++++++--
security/lockdown/lockdown.c         |  3 ++-
security/security.c                  |  4 ++--
security/selinux/hooks.c             |  7 +++++--
48 files changed, 100 insertions(+), 79 deletions(-)

-- 
paul moore
www.paul-moore.com
