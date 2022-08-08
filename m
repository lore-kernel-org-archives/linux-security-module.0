Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8FCC00140
	for <linux-security-module@archiver.kernel.org>; Mon,  8 Aug 2022 17:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiHHR5O (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 8 Aug 2022 13:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244144AbiHHR4i (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 8 Aug 2022 13:56:38 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A665918341
        for <linux-security-module@vger.kernel.org>; Mon,  8 Aug 2022 10:56:31 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id j144-20020a25d296000000b0067ba828624fso6133805ybg.16
        for <linux-security-module@vger.kernel.org>; Mon, 08 Aug 2022 10:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=yr7nZVaG6KnPFzU0GkO8LDPXim3Y8RycylsE6e+KYS8=;
        b=XTaOh2Emx3RzjrAPUqBKn7IkMuMVZE1sNV0UiYrdi4ST+a2W2wVmMRWlnckX47kh8Z
         3pwWPZdwO8GQdIoktR8SRLEK3dSAejavjjUTWBsMyR+Lp5qe4E/lj1k5E4pudhXvTlU1
         vWnmtqMlJJxhIo/oHFLmarz9DbuZqb7BY/Hq5+m69WpRoZFozOBzbmm16L/QQMNwNYDw
         /zjQVMRUVK3zklQ5u/E8z49CYBhRyjzy5hwdW98+CYPELiPv45DHhqY4YhFMqJv/CvHY
         fo3mzTiobWlSpgKtmrAIQxHOldOvv7ws6xTPxVwYC1JWlOe8DXo3TZGLvcyRrvwKcC6H
         hdPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=yr7nZVaG6KnPFzU0GkO8LDPXim3Y8RycylsE6e+KYS8=;
        b=KSTSB6gDRHzZFhk51He/0uKOnIHb8U5S+4Tty7lGHNspNhjSWzLRsn0123GX6a77A1
         e5O3V5AlgwCphkJWrGLNf+ev7wEuT+3iH2hbJJHJIPQk787UiXGPdHwomfAl5TLvm3Oc
         30i+TsGdVMEwtsw5FxXMeFqt3tuBGPaJv5bXzpIvWdTN08sbRda5gSq0oVM6K+pfnYbJ
         9jaYRIg8Q3jKSEs0dLZ70SJAzHaB0tzq0LujYpueDfOVLxezDgaNZp6IdiORqq03aOph
         PWcQtOT6nrljutwNcd8eKHaYZrxxmJBRlGsGrA8snNLgzAc6qiQMUHv0OlwMUOsqMP5m
         kTRg==
X-Gm-Message-State: ACgBeo12RrjKRLgYxdRajMbvzqRVGULCfwyC+f+vRC+Ax0BUydzM0MHG
        kobo1lJIpD3rYF40qFo8e+rvDMDsTHtZt2cXqvda
X-Google-Smtp-Source: AA6agR5OFChi2bWVcsCQV2S7ZdR7lgDMmRJT1bj1DNJoylej7bIRyUqOMr7NzN7+osLysSkQ7f1ZEMtCfU38FTFoNzeM
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2d4:203:7a2a:3bb5:f3a0:3bbc])
 (user=axelrasmussen job=sendgmr) by 2002:a25:25d8:0:b0:671:80a8:2d73 with
 SMTP id l207-20020a2525d8000000b0067180a82d73mr16769495ybl.125.1659981390656;
 Mon, 08 Aug 2022 10:56:30 -0700 (PDT)
Date:   Mon,  8 Aug 2022 10:56:13 -0700
In-Reply-To: <20220808175614.3885028-1-axelrasmussen@google.com>
Message-Id: <20220808175614.3885028-5-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20220808175614.3885028-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v5 4/5] userfaultfd: update documentation to describe /dev/userfaultfd
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

Explain the different ways to create a new userfaultfd, and how access
control works for each way.

Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 Documentation/admin-guide/mm/userfaultfd.rst | 41 ++++++++++++++++++--
 Documentation/admin-guide/sysctl/vm.rst      |  3 ++
 2 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/mm/userfaultfd.rst b/Documentation/admin-guide/mm/userfaultfd.rst
index 6528036093e1..a76c9dc1865b 100644
--- a/Documentation/admin-guide/mm/userfaultfd.rst
+++ b/Documentation/admin-guide/mm/userfaultfd.rst
@@ -17,7 +17,10 @@ of the ``PROT_NONE+SIGSEGV`` trick.
 Design
 ======
 
-Userfaults are delivered and resolved through the ``userfaultfd`` syscall.
+Userspace creates a new userfaultfd, initializes it, and registers one or more
+regions of virtual memory with it. Then, any page faults which occur within the
+region(s) result in a message being delivered to the userfaultfd, notifying
+userspace of the fault.
 
 The ``userfaultfd`` (aside from registering and unregistering virtual
 memory ranges) provides two primary functionalities:
@@ -34,12 +37,11 @@ The real advantage of userfaults if compared to regular virtual memory
 management of mremap/mprotect is that the userfaults in all their
 operations never involve heavyweight structures like vmas (in fact the
 ``userfaultfd`` runtime load never takes the mmap_lock for writing).
-
 Vmas are not suitable for page- (or hugepage) granular fault tracking
 when dealing with virtual address spaces that could span
 Terabytes. Too many vmas would be needed for that.
 
-The ``userfaultfd`` once opened by invoking the syscall, can also be
+The ``userfaultfd``, once created, can also be
 passed using unix domain sockets to a manager process, so the same
 manager process could handle the userfaults of a multitude of
 different processes without them being aware about what is going on
@@ -50,6 +52,39 @@ is a corner case that would currently return ``-EBUSY``).
 API
 ===
 
+Creating a userfaultfd
+----------------------
+
+There are two ways to create a new userfaultfd, each of which provide ways to
+restrict access to this functionality (since historically userfaultfds which
+handle kernel page faults have been a useful tool for exploiting the kernel).
+
+The first way, supported since userfaultfd was introduced, is the
+userfaultfd(2) syscall. Access to this is controlled in several ways:
+
+- Any user can always create a userfaultfd which traps userspace page faults
+  only. Such a userfaultfd can be created using the userfaultfd(2) syscall
+  with the flag UFFD_USER_MODE_ONLY.
+
+- In order to also trap kernel page faults for the address space, then either
+  the process needs the CAP_SYS_PTRACE capability, or the system must have
+  vm.unprivileged_userfaultfd set to 1. By default, vm.unprivileged_userfaultfd
+  is set to 0.
+
+The second way, added to the kernel more recently, is by opening and issuing a
+USERFAULTFD_IOC_NEW ioctl to /dev/userfaultfd. This method yields equivalent
+userfaultfds to the userfaultfd(2) syscall.
+
+Unlike userfaultfd(2), access to /dev/userfaultfd is controlled via normal
+filesystem permissions (user/group/mode), which gives fine grained access to
+userfaultfd specifically, without also granting other unrelated privileges at
+the same time (as e.g. granting CAP_SYS_PTRACE would do). Users who have access
+to /dev/userfaultfd can always create userfaultfds that trap kernel page faults;
+vm.unprivileged_userfaultfd is not considered.
+
+Initializing a userfaultfd
+--------------------------
+
 When first opened the ``userfaultfd`` must be enabled invoking the
 ``UFFDIO_API`` ioctl specifying a ``uffdio_api.api`` value set to ``UFFD_API`` (or
 a later API version) which will specify the ``read/POLLIN`` protocol
diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index f74f722ad702..b3e40b42e1b3 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -927,6 +927,9 @@ calls without any restrictions.
 
 The default value is 0.
 
+Another way to control permissions for userfaultfd is to use
+/dev/userfaultfd instead of userfaultfd(2). See
+Documentation/admin-guide/mm/userfaultfd.rst.
 
 user_reserve_kbytes
 ===================
-- 
2.37.1.559.g78731f0fdb-goog

