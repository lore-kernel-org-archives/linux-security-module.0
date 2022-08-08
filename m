Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28ECDC48BE4
	for <linux-security-module@archiver.kernel.org>; Mon,  8 Aug 2022 17:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243995AbiHHR4X (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 8 Aug 2022 13:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236279AbiHHR4W (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 8 Aug 2022 13:56:22 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89888175AD
        for <linux-security-module@vger.kernel.org>; Mon,  8 Aug 2022 10:56:21 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3231401769dso84287817b3.10
        for <linux-security-module@vger.kernel.org>; Mon, 08 Aug 2022 10:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=Cc9MnKZgg+ibpM+8ko+H6oPbsb5pSszzVfc8aWAiJho=;
        b=CuZZbvD5Zahb/IdAJlGMq6TjrBJztj0YEMjFy1GDqtnvIuRgcS3v68E3duGOAKy9ZI
         G8RZ8aO4qjpoPamGGTX/yXwZtJYZA9tE2+zu1lpZzgJxyGqaROdcTNy6KDYH/gn8GlBl
         OK9P5YQmRNSF8mnTNiXxrL6tZMZBYYI43OYaNzyUfaJ8SbRAZ1NY5BdMWxwJQ8KOXh7g
         vLGH9Rt8pKH/LbwuCSLIvldly2jpYP8B1ol4S0ku18YHUYKAvixREO0RHydd6liWSMOF
         nO8BjEvRkW65PhcVRIInf5oIayFp0HeIrIGy890JIh4JKojBBx6cUnqO6hlVkr6N5mlG
         +v1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=Cc9MnKZgg+ibpM+8ko+H6oPbsb5pSszzVfc8aWAiJho=;
        b=3cR9aTKupBT3smJaa1usQ75tOF5XcKItmK+iZIQcgz4D4vssuOgLb9ZkBfIf04IRt4
         W7sUJ5vN6TFWGdya0jDG9jKiroGHWSHQGgtBILZkADHQabLW2ZSuXAWPCGwN/pnWgZ3J
         MEqFZP2hJxYO71T3Ge5PS0JeXdw2bRINBcTTM5yePwTrRjs0L4J3W5Q3Mt+lhEK2fDqL
         jJGi6l+6SbZukFX4lzrwXjAZaC5JKgepTdHzq/Vgj82ZJfkAyTxuEGOzR/WL8wgnffRA
         qqFuZLaloqgqzIsFU7Up8YHrpooYQ207J2+oEsOpLJ+jBoksDbzq267S7xSSkOXKO/dK
         ifKA==
X-Gm-Message-State: ACgBeo2sJOYPwPJ9QySU+sFse9wLCb+HSNoQRmLXttax2bmCee8hAwFk
        gJA0LLalHmmVVjra6svFwqrjOIHCyJ0y336A5IuF
X-Google-Smtp-Source: AA6agR5ZeAOTjT1MgizrsRrqipaGPwGw1lTbPlW+A4euRXqJ+TiAsxPXTDq8OQCto6H+3SZ+teGzadIyEt2uvg0SCG6F
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2d4:203:7a2a:3bb5:f3a0:3bbc])
 (user=axelrasmussen job=sendgmr) by 2002:a81:5946:0:b0:31f:4ec0:17af with
 SMTP id n67-20020a815946000000b0031f4ec017afmr19660191ywb.217.1659981380782;
 Mon, 08 Aug 2022 10:56:20 -0700 (PDT)
Date:   Mon,  8 Aug 2022 10:56:09 -0700
Message-Id: <20220808175614.3885028-1-axelrasmussen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v5 0/5] userfaultfd: add /dev/userfaultfd for fine grained
 access control
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, zhangyi <yi.zhang@huawei.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This series is based on torvalds/master.

The series is split up like so:
- Patch 1 is a simple fixup which we should take in any case (even by itself).
- Patches 2-5 add the feature, configurable selftest support, and docs.

Why not ...?
============

- Why not /proc/[pid]/userfaultfd? Two main points (additional discussion [1]):

    - /proc/[pid]/* files are all owned by the user/group of the process, and
      they don't really support chmod/chown. So, without extending procfs it
      doesn't solve the problem this series is trying to solve.

    - The main argument *for* this was to support creating UFFDs for remote
      processes. But, that use case clearly calls for CAP_SYS_PTRACE, so to
      support this we could just use the UFFD syscall as-is.

- Why not use a syscall? Access to syscalls is generally controlled by
  capabilities. We don't have a capability which is used for userfaultfd access
  without also granting more / other permissions as well, and adding a new
  capability was rejected [2].

    - It's possible a LSM could be used to control access instead, but I have
      some concerns. I don't think this approach would be as easy to use,
      particularly if we were to try to solve this with something heavyweight
      like SELinux. Maybe we could pursue adding a new LSM specifically for
      this user case, but it may be too narrow of a case to justify that.

Changelog
=========

v4->v5:
  - Call userfaultfd_syscall_allowed() directly in the syscall, so we don't
    have to plumb a flag into new_userfaultfd(). [Nadav]
  - Refactored run_vmtests.sh to loop over UFFD test mods. [Nadav]
  - Reworded cover letter.
  - Picked up some Acked-by's.

v3->v4:
  - Picked up an Acked-by on 5/5.
  - Updated cover letter to cover "why not ...".
  - Refactored userfaultfd_allowed() into userfaultfd_syscall_allowed(). [Peter]
  - Removed obsolete comment from a previous version. [Peter]
  - Refactored userfaultfd_open() in selftest. [Peter]
  - Reworded admin-guide documentation. [Mike, Peter]
  - Squashed 2 commits adding /dev/userfaultfd to selftest and making selftest
    configurable. [Peter]
  - Added "syscall" test modifier (the default behavior) to selftest. [Peter]

v2->v3:
  - Rebased onto linux-next/akpm-base, in order to be based on top of the
    run_vmtests.sh refactor which was merged previously.
  - Picked up some Reviewed-by's.
  - Fixed ioctl definition (_IO instead of _IOWR), and stopped using
    compat_ptr_ioctl since it is unneeded for ioctls which don't take a pointer.
  - Removed the "handle_kernel_faults" bool, simplifying the code. The result is
    logically equivalent, but simpler.
  - Fixed userfaultfd selftest so it returns KSFT_SKIP appropriately.
  - Reworded documentation per Shuah's feedback on v2.
  - Improved example usage for userfaultfd selftest.

v1->v2:
  - Add documentation update.
  - Test *both* userfaultfd(2) and /dev/userfaultfd via the selftest.

[1]: https://patchwork.kernel.org/project/linux-mm/cover/20220719195628.3415852-1-axelrasmussen@google.com/
[2]: https://lore.kernel.org/lkml/686276b9-4530-2045-6bd8-170e5943abe4@schaufler-ca.com/T/

Axel Rasmussen (5):
  selftests: vm: add hugetlb_shared userfaultfd test to run_vmtests.sh
  userfaultfd: add /dev/userfaultfd for fine grained access control
  userfaultfd: selftests: modify selftest to use /dev/userfaultfd
  userfaultfd: update documentation to describe /dev/userfaultfd
  selftests: vm: add /dev/userfaultfd test cases to run_vmtests.sh

 Documentation/admin-guide/mm/userfaultfd.rst | 41 ++++++++++-
 Documentation/admin-guide/sysctl/vm.rst      |  3 +
 fs/userfaultfd.c                             | 73 +++++++++++++++-----
 include/uapi/linux/userfaultfd.h             |  4 ++
 tools/testing/selftests/vm/run_vmtests.sh    | 15 ++--
 tools/testing/selftests/vm/userfaultfd.c     | 69 +++++++++++++++---
 6 files changed, 172 insertions(+), 33 deletions(-)

--
2.37.1.559.g78731f0fdb-goog

