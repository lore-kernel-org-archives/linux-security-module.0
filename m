Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5EFC4332F
	for <linux-security-module@archiver.kernel.org>; Fri,  9 Dec 2022 16:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiLIQFD (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 9 Dec 2022 11:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiLIQFB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 9 Dec 2022 11:05:01 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D54D511F0
        for <linux-security-module@vger.kernel.org>; Fri,  9 Dec 2022 08:05:00 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id 130so3991294pfu.8
        for <linux-security-module@vger.kernel.org>; Fri, 09 Dec 2022 08:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ueWjZxTYbaDQuWzBrDeCTZV53qbvnkwWshi5C3odIuU=;
        b=EWSu99laS2GBJK/j/npVWxjB2fyUhNZIb5ap7uGNrpmhSjYdFN/R5KpVoxG7XCsT28
         eSKCiuIsD3XZsUYjZbzlb6EMTTSOe2j5irk0ak1/VsWmw5GdGbvIraYAA7d8py5Y9LVc
         gc+Rh7B/MQTSKEPQllLXMnkWdzW6pKuiXnL2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ueWjZxTYbaDQuWzBrDeCTZV53qbvnkwWshi5C3odIuU=;
        b=LyiZxH5nJVFx1BtKfQZgRqFJRfTqTTLTOxA4r8U4AevADsKhaui94feeTToT4b7AhA
         o7iZ4zjzuVjzs/CT0ZHQvqvKeJUeGCsJDtWRypzH7sFB9hW2Aaa5XxZqsxhrMox+tUTa
         M5l8MxVeP44kIXBAuoFNet5gzPVECO/mY66btOngdjZw34U0BKvkIlWORJcGzhU8HAho
         JTv+SkvCBeNQMq13NKYJWLldFFTRgndvEj0OOZZsxFoSJGqnBbM4qvDv+ypEZi8UTP4q
         B1mHLwzCYmyzxnUySdMR69YAtWnut4FxGa+2QHclXT9dyfGIreHpCfvG12Rfp4xnYXJH
         jcjw==
X-Gm-Message-State: ANoB5pm0vHsCqWAEhTqYeheoSDIkm2YhrSSouPV8fjDVOoJ/aLt3BEQp
        mDxv25Ux0H6lJ+0eg9rxLGFmdkmpwDhhOL06
X-Google-Smtp-Source: AA0mqf5i1xoBmEhRL9IDhhL+iKpEzBdOcNxUpPz5R22PuXbmHssMXjzHK5BBkv0qkIG7zHOA1PGhoA==
X-Received: by 2002:a62:87cc:0:b0:576:dc40:6db9 with SMTP id i195-20020a6287cc000000b00576dc406db9mr6237516pfe.13.1670601899690;
        Fri, 09 Dec 2022 08:04:59 -0800 (PST)
Received: from jeffxud.c.googlers.com.com (30.202.168.34.bc.googleusercontent.com. [34.168.202.30])
        by smtp.gmail.com with ESMTPSA id a15-20020aa795af000000b00576670cc170sm1460504pfk.93.2022.12.09.08.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 08:04:59 -0800 (PST)
From:   jeffxu@chromium.org
To:     skhan@linuxfoundation.org, keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v7 0/6] mm/memfd: introduce MFD_NOEXEC_SEAL and MFD_EXEC
Date:   Fri,  9 Dec 2022 16:04:47 +0000
Message-Id: <20221209160453.3246150-1-jeffxu@google.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Jeff Xu <jeffxu@google.com>

Since Linux introduced the memfd feature, memfd have always had their
execute bit set, and the memfd_create() syscall doesn't allow setting
it differently.

However, in a secure by default system, such as ChromeOS, (where all
executables should come from the rootfs, which is protected by Verified
boot), this executable nature of memfd opens a door for NoExec bypass
and enables “confused deputy attack”.  E.g, in VRP bug [1]: cros_vm
process created a memfd to share the content with an external process,
however the memfd is overwritten and used for executing arbitrary code
and root escalation. [2] lists more VRP in this kind.

On the other hand, executable memfd has its legit use, runc uses memfd’s
seal and executable feature to copy the contents of the binary then
execute them, for such system, we need a solution to differentiate runc's
use of  executable memfds and an attacker's [3].

To address those above, this set of patches add following:
1> Let memfd_create() set X bit at creation time.
2> Let memfd to be sealed for modifying X bit.
3> A new pid namespace sysctl: vm.memfd_noexec to control the behavior of
   X bit.For example, if a container has vm.memfd_noexec=2, then
   memfd_create() without MFD_NOEXEC_SEAL will be rejected.
4> A new security hook in memfd_create(). This make it possible to a new
LSM, which rejects or allows executable memfd based on its security policy.

Change history:
v7:
- patch 2/6: remove #ifdef and MAX_PATH (memfd_test.c).
- patch 3/6: check capability (CAP_SYS_ADMIN) from userns instead of
		global ns (pid_sysctl.h). Add a tab (pid_namespace.h).
- patch 5/6: remove #ifdef (memfd_test.c)
- patch 6/6: remove unneeded security_move_mount(security.c).

v6:https://lore.kernel.org/lkml/20221206150233.1963717-1-jeffxu@google.com/
- Address comment and move "#ifdef CONFIG_" from .c file to pid_sysctl.h

v5:https://lore.kernel.org/lkml/20221206152358.1966099-1-jeffxu@google.com/
- Pass vm.memfd_noexec from current ns to child ns.
- Fix build issue detected by kernel test robot.
- Add missing security.c

v3:https://lore.kernel.org/lkml/20221202013404.163143-1-jeffxu@google.com/
- Address API design comments in v2.
- Let memfd_create() to set X bit at creation time.
- A new pid namespace sysctl: vm.memfd_noexec to control behavior of X bit.
- A new security hook in memfd_create().

v2:https://lore.kernel.org/lkml/20220805222126.142525-1-jeffxu@google.com/
- address comments in V1.
- add sysctl (vm.mfd_noexec) to set the default file permissions of
  memfd_create to be non-executable.

v1:https://lwn.net/Articles/890096/

[1] https://crbug.com/1305411
[2] https://bugs.chromium.org/p/chromium/issues/list?q=type%3Dbug-security%20memfd%20escalation&can=1
[3] https://lwn.net/Articles/781013/

Daniel Verkamp (2):
  mm/memfd: add F_SEAL_EXEC
  selftests/memfd: add tests for F_SEAL_EXEC

Jeff Xu (4):
  mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC
  mm/memfd: Add write seals when apply SEAL_EXEC to executable memfd
  selftests/memfd: add tests for MFD_NOEXEC_SEAL MFD_EXEC
  mm/memfd: security hook for memfd_create

 include/linux/lsm_hook_defs.h              |   1 +
 include/linux/lsm_hooks.h                  |   4 +
 include/linux/pid_namespace.h              |  19 ++
 include/linux/security.h                   |   6 +
 include/uapi/linux/fcntl.h                 |   1 +
 include/uapi/linux/memfd.h                 |   4 +
 kernel/pid_namespace.c                     |   5 +
 kernel/pid_sysctl.h                        |  59 ++++
 mm/memfd.c                                 |  61 +++-
 mm/shmem.c                                 |   6 +
 security/security.c                        |   5 +
 tools/testing/selftests/memfd/fuse_test.c  |   1 +
 tools/testing/selftests/memfd/memfd_test.c | 341 ++++++++++++++++++++-
 13 files changed, 510 insertions(+), 3 deletions(-)
 create mode 100644 kernel/pid_sysctl.h


base-commit: eb7081409f94a9a8608593d0fb63a1aa3d6f95d8
-- 
2.39.0.rc1.256.g54fd8350bd-goog

