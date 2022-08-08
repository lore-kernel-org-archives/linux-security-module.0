Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F707C25B0E
	for <linux-security-module@archiver.kernel.org>; Mon,  8 Aug 2022 17:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244063AbiHHR41 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 8 Aug 2022 13:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244008AbiHHR4Z (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 8 Aug 2022 13:56:25 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA94630A
        for <linux-security-module@vger.kernel.org>; Mon,  8 Aug 2022 10:56:23 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id k13-20020a056902024d00b0066fa7f50b97so7902824ybs.6
        for <linux-security-module@vger.kernel.org>; Mon, 08 Aug 2022 10:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=Jwq0jXWhpPKY4rjZycF0kBtXykpSsmq4jMCb4fxEPCM=;
        b=Yyk9ueBMp+D30ALuCCr4oQg4v0Phj71m9ZUNFotBmxh5WUoEer1fIKUM0YNI8t36m/
         LAKC/p9D6Ibbok4i3QPJuOcLeLuIZtfZz5hWpJ2SamU/0IqIgKUcq5tdx+B0lyBwjzWU
         6rlAg4BqXREsBkDISimbX7tf6KbTpVyl8Sp7EURabchFN3gbwsiNGVRrvf2Dz2vV+YiO
         3CyjWXzxMSiuTFLOXfXCyEX3jlVt/8lgkhEOc6o2d2ADrfwgq5hAGBW01/v+pi4V5E9Q
         Y0xIlwhyNQFlXTgiXIJE1rXkVz/ykc6WHPLIvdfzBC4Sd+2KaItcnCFA+eFXdTaHMTth
         ajfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=Jwq0jXWhpPKY4rjZycF0kBtXykpSsmq4jMCb4fxEPCM=;
        b=X20SV4GoRDL3YfFn9nNjLKrCNYrR56b1ZiDdPjm7I1OdFPk9oHpWk2B6gYC6NYM/gz
         ZfBwxqHjVASgUKX1x+GM2bdbxuH+X/8WbhgnEsjy+JrU9snW4kVCv3IH9tm6rgneXGwS
         jVyA55/uJr9fE+P6FLLCQ9W/dKxOo8g4qcDMJkiI0/SqTEScQunHp0410bIZDPkN3vst
         sGHnAsVv0my8FqQnW+zkYqjEBJbvcaVOV6qnQt6NwKiMQdSuaBnGvQ0uES27is10xXOb
         Bk0gAuVEIqUWxtDI09dpOMwEqVW/UDrq9Ip4vt/mfSIQLcUft40G3Ltm4mp6sQXq3UdO
         6epw==
X-Gm-Message-State: ACgBeo3aMnza4MQ9JOC27rSrcGWCIYUijsG9Jz0gKem+644cbRZY/es/
        1+Wbpsp/YKMSr8VjspYOAHQhYhp886EPzjk7Jny1
X-Google-Smtp-Source: AA6agR43R4xY0r1/MvCjyc43MmcPqeFzuRXsCNk0/nJZn8G74hDr1u1wkNE8kXISlycKU+NX0kObB9Nbsmb3XfCgX24r
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2d4:203:7a2a:3bb5:f3a0:3bbc])
 (user=axelrasmussen job=sendgmr) by 2002:a25:41cb:0:b0:671:80ac:bb4c with
 SMTP id o194-20020a2541cb000000b0067180acbb4cmr16114083yba.24.1659981383209;
 Mon, 08 Aug 2022 10:56:23 -0700 (PDT)
Date:   Mon,  8 Aug 2022 10:56:10 -0700
In-Reply-To: <20220808175614.3885028-1-axelrasmussen@google.com>
Message-Id: <20220808175614.3885028-2-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20220808175614.3885028-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v5 1/5] selftests: vm: add hugetlb_shared userfaultfd test to run_vmtests.sh
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
2.37.1.559.g78731f0fdb-goog

