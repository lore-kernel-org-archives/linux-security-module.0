Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82096C32773
	for <linux-security-module@archiver.kernel.org>; Fri, 19 Aug 2022 20:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351894AbiHSUwp (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 19 Aug 2022 16:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352118AbiHSUw3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 19 Aug 2022 16:52:29 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7909010E962
        for <linux-security-module@vger.kernel.org>; Fri, 19 Aug 2022 13:52:13 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3328a211611so93767857b3.5
        for <linux-security-module@vger.kernel.org>; Fri, 19 Aug 2022 13:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=cU7/6qINBgFAfTXfLa178LOY1yjmrSCVESmZNe7FU4M=;
        b=bC4lMI8huw1uRRzwGbHtFYE2tB88na003CekKY0ACebDw98OX4FLPryvf3oIjLvbpT
         2Z94mnqJPrWYcjP3lmF0GohedIfZnStwZI38zjxUUxQx48j9wG65sUDiEbDITVLYRKcL
         mVtlRswKM70g0APD+T61jU6cKtU63dY0BC21ebFhGj0hneMmEysLC4lYHb5oDAVNIzpp
         mb1WTwMI3YxYE/fxX+RjWDwy8EJG82QrF3wHtWjI0Yh4kNcN3PEFdFExtn3hpGXpQYOj
         rmZcPvO+scdHRyaPD9DDquqWTzT/hefOPdLuGFDA0SzUJxmBxqB86WHfSQvwRiAOGOM6
         arxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=cU7/6qINBgFAfTXfLa178LOY1yjmrSCVESmZNe7FU4M=;
        b=lcYs3kHasg1xllOsthvsF/3L+kTxIocvf/V2sO1yjMLDiK5YWa8CIMD5lVMIUxKXUZ
         2fgtYOTpRlfk/i9nJeWpFDTD2dnUs8UaVkwn/BTp1OMPeH3Nra0CqsoCBVP7G1pNXOGx
         0YOXaFspHXkQQjxvtyRX0AIEj8sjP25qAgK2IV5pRG0chJ1EsBJMLBhrNxv/U0cnaN2Q
         yPBz8DKI6gcvi7L2G6+Qu6g/h/1qFduTVlwpG97ekmGW4pSkFw2mhXt0lhUrwGUSjUgT
         t2IflIx9wz3/iQDsCnUWwT09jwwfxWJVBwJXOY6QIH5Her3q5PhMbx0l8qoEz0Lw7tOi
         wiMA==
X-Gm-Message-State: ACgBeo1W6bCue3DiEtAGv1DZFtshHlZCTJcfXX9WHtcHFiNx8/UsnEay
        d3dlVX5JBaIt94X9L3wcsVgCqmQeSGp+w7U1nFpg
X-Google-Smtp-Source: AA6agR597bmial/03bil7OFmDdc43FwP1zL4eJRRyQeIFMDrkuV6ElwIhtWPrgaR/KqOaLYWWlpmihWtAUKx254JQc//
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2d4:203:baf:4c5:18b:2c4b])
 (user=axelrasmussen job=sendgmr) by 2002:a25:dcd4:0:b0:690:6ce9:7bb5 with
 SMTP id y203-20020a25dcd4000000b006906ce97bb5mr9476909ybe.516.1660942332708;
 Fri, 19 Aug 2022 13:52:12 -0700 (PDT)
Date:   Fri, 19 Aug 2022 13:51:57 -0700
In-Reply-To: <20220819205201.658693-1-axelrasmussen@google.com>
Message-Id: <20220819205201.658693-2-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20220819205201.658693-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH v7 1/5] selftests: vm: add hugetlb_shared userfaultfd test to run_vmtests.sh
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
        linux-mm@kvack.org, linux-security-module@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This not being included was just a simple oversight. There are certain
features (like minor fault support) which are only enabled on shared
mappings, so without including hugetlb_shared we actually lose a
significant amount of test coverage.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 tools/testing/selftests/vm/run_vmtests.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/selftests/vm/run_vmtests.sh
index de86983b8a0f..b8e7f6f38d64 100755
--- a/tools/testing/selftests/vm/run_vmtests.sh
+++ b/tools/testing/selftests/vm/run_vmtests.sh
@@ -121,9 +121,11 @@ run_test ./gup_test -a
 run_test ./gup_test -ct -F 0x1 0 19 0x1000
 
 run_test ./userfaultfd anon 20 16
-# Test requires source and destination huge pages.  Size of source
-# (half_ufd_size_MB) is passed as argument to test.
+# Hugetlb tests require source and destination huge pages. Pass in half the
+# size ($half_ufd_size_MB), which is used for *each*.
 run_test ./userfaultfd hugetlb "$half_ufd_size_MB" 32
+run_test ./userfaultfd hugetlb_shared "$half_ufd_size_MB" 32 "$mnt"/uffd-test
+rm -f "$mnt"/uffd-test
 run_test ./userfaultfd shmem 20 16
 
 #cleanup
-- 
2.37.1.595.g718a3a8f04-goog

