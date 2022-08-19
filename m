Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC6FC32771
	for <linux-security-module@archiver.kernel.org>; Fri, 19 Aug 2022 20:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352055AbiHSUx6 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 19 Aug 2022 16:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352060AbiHSUwg (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 19 Aug 2022 16:52:36 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A173110F682
        for <linux-security-module@vger.kernel.org>; Fri, 19 Aug 2022 13:52:23 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-32a115757b6so95217677b3.13
        for <linux-security-module@vger.kernel.org>; Fri, 19 Aug 2022 13:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=jnCzi2soCjCrdoYyE26okeRANWMjNTuMb/vBG8/63Ug=;
        b=dIpcC3duR2F4UdEnpnHe2+B2ki05YIFseJ6XkifI1ovJCzemg2dHLOQR3Hcrc13yAL
         Lpy72mYkw+OVc8KXup1+UJK4XLguOgG5HwNBjH22RGBbJMIcWlulfNwQfWuP3eCH1lzl
         b6B/y6zPicu82sY/bgXGd+sZ7zR21n9PVfNhwwMc7sFL1dgEFNdgDl4r6Df+26JDnzoX
         D/QTc2Uc0q9CmmICpeKvhxd1UkQnOMlXqy1sHiVX7JddGHfDA7XMLC1N6qy4z3fF6Ds0
         wKDnL40gO8YfOaMBnPWMebrtf+ROzhZfFnwNXLkDKPFG0O28730Y0sG1orQLamNZ7Y7E
         ZYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=jnCzi2soCjCrdoYyE26okeRANWMjNTuMb/vBG8/63Ug=;
        b=M1oDSAk5lB+15u4dDZZa8oPTLLfzHUKng8GZCJLvW0kzZCPKvKX23FabzT3wOBVl0s
         tfMo//cmifaTTx5mWmeGzaeJ/qrO7w9dZduOJXghdVpyE+O/rYZ6gpZOB3cSb4ueZsOG
         j/eYFLqk3naTjRPfZHXwgTaQoJCuwInMQoXmQbfmn3oOJM6LCUhSCyz+KSLyINjNrhEc
         zHNrwyZIiNUSxzuZzxSEiH+2eB72u59dHsJjOl7tgZf/GkjuX1zkVunttlu6ADFX+p4T
         7/pBvj9N89SuBRnYruH1ogNKNtWOs66VHNCaq/UAJBb/LrFQ6WZa7yZRD3lmmfHflqYQ
         sHTg==
X-Gm-Message-State: ACgBeo2VHBS1I3PERLnA2fCnnbwBFWizrVrjEYOVInERqp/tEELofODY
        4sJEw/gsE9NdUT793IW/ehsAozP/d55uzaKsRtby
X-Google-Smtp-Source: AA6agR6tYdLSyLary3+Q5VuCsv3LcSs1JihCOYeNOoWw3HYFbFr1DaLds4QXVaepr+bVaJJ9uL2y6ztcYfkdMgBc8C6B
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2d4:203:baf:4c5:18b:2c4b])
 (user=axelrasmussen job=sendgmr) by 2002:a81:eb04:0:b0:329:94ef:3e68 with
 SMTP id n4-20020a81eb04000000b0032994ef3e68mr9476724ywm.309.1660942342250;
 Fri, 19 Aug 2022 13:52:22 -0700 (PDT)
Date:   Fri, 19 Aug 2022 13:52:01 -0700
In-Reply-To: <20220819205201.658693-1-axelrasmussen@google.com>
Message-Id: <20220819205201.658693-6-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20220819205201.658693-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH v7 5/5] selftests: vm: add /dev/userfaultfd test cases to run_vmtests.sh
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

This new mode was recently added to the userfaultfd selftest. We want to
exercise both userfaultfd(2) as well as /dev/userfaultfd, so add both
test cases to the script.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 tools/testing/selftests/vm/run_vmtests.sh | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/selftests/vm/run_vmtests.sh
index b8e7f6f38d64..e780e76c26b8 100755
--- a/tools/testing/selftests/vm/run_vmtests.sh
+++ b/tools/testing/selftests/vm/run_vmtests.sh
@@ -120,13 +120,16 @@ run_test ./gup_test -a
 # Dump pages 0, 19, and 4096, using pin_user_pages:
 run_test ./gup_test -ct -F 0x1 0 19 0x1000
 
-run_test ./userfaultfd anon 20 16
-# Hugetlb tests require source and destination huge pages. Pass in half the
-# size ($half_ufd_size_MB), which is used for *each*.
-run_test ./userfaultfd hugetlb "$half_ufd_size_MB" 32
-run_test ./userfaultfd hugetlb_shared "$half_ufd_size_MB" 32 "$mnt"/uffd-test
-rm -f "$mnt"/uffd-test
-run_test ./userfaultfd shmem 20 16
+uffd_mods=("" ":dev")
+for mod in "${uffd_mods[@]}"; do
+	run_test ./userfaultfd anon${mod} 20 16
+	# Hugetlb tests require source and destination huge pages. Pass in half
+	# the size ($half_ufd_size_MB), which is used for *each*.
+	run_test ./userfaultfd hugetlb${mod} "$half_ufd_size_MB" 32
+	run_test ./userfaultfd hugetlb_shared${mod} "$half_ufd_size_MB" 32 "$mnt"/uffd-test
+	rm -f "$mnt"/uffd-test
+	run_test ./userfaultfd shmem${mod} 20 16
+done
 
 #cleanup
 umount "$mnt"
-- 
2.37.1.595.g718a3a8f04-goog

