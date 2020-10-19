Return-Path: <SRS0=+Ebz=D2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7AAC433DF
	for <linux-security-module@archiver.kernel.org>; Mon, 19 Oct 2020 18:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 971DD2231B
	for <linux-security-module@archiver.kernel.org>; Mon, 19 Oct 2020 18:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbgJSS3N (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 19 Oct 2020 14:29:13 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49316 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbgJSS3N (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 19 Oct 2020 14:29:13 -0400
Received: from mail-qv1-f71.google.com ([209.85.219.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <gpiccoli@canonical.com>)
        id 1kUZuA-0004ga-Nt
        for linux-security-module@vger.kernel.org; Mon, 19 Oct 2020 18:29:10 +0000
Received: by mail-qv1-f71.google.com with SMTP id i5so498924qvr.1
        for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2020 11:29:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nFSi4OtxvAk/2TeYa4t3Di2sFP7xbSzpmy1A/2ESiB0=;
        b=TYAsM25UokEG70Jk9/ew4BxJR7SusQWyNqIIg5mY24/H/VpgPZyNTKp2HJ+z4NR5rr
         iZfO8YtVYBtp0scNS3KjvCfmB/+taI0Y1FzL5qvwdRim7GxfBFEPpsPo/T/7ZDk33KEE
         I3CPwwkY1Oj6gu3mHOzOslCQ349KCgSbGuT7YMTcsmSNTKOuL4RpE8V839sxPcOT7ND+
         5OlmdbrJjTTUQ9Yqalg20hFOiHvUaEQBm0b16EipH1F5wvUZ9oO8z93scTB4gIo4fR16
         sxGszxQUgVBLpQhakscdaOb3PzaTHTtZd3ZFSN/ICmqecqx308YNbzkMwd8xCcy4brSS
         99iQ==
X-Gm-Message-State: AOAM531wNRGEXbLMYyhiCdF5mKxp5xeOEZL7ffIDWVbN/+5r9TVmg4PF
        J22CjrvAD+d6u387wxKtE7N4r7D0rbpF+GTCTjTKVCui7sEOy/TSZoQBejG5/pJypu2QuCr3QWf
        q33LzAO9dYRtfYTmfaTn5nkDbtftkpuec3byrSrBNSysKIBTasQVOpw==
X-Received: by 2002:a05:620a:66d:: with SMTP id a13mr822420qkh.301.1603132144204;
        Mon, 19 Oct 2020 11:29:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwXOLphwHsQlpyOjL1HNupZgTMWTIQz+87TljMlP/X3Ky+1N7HyJN4kOuI75JMPlJY5OisJow==
X-Received: by 2002:a05:620a:66d:: with SMTP id a13mr822176qkh.301.1603132140231;
        Mon, 19 Oct 2020 11:29:00 -0700 (PDT)
Received: from localhost (200-160-93-101.static-user.ajato.com.br. [200.160.93.101])
        by smtp.gmail.com with ESMTPSA id 124sm350834qkn.47.2020.10.19.11.28.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Oct 2020 11:28:59 -0700 (PDT)
From:   "Guilherme G. Piccoli" <gpiccoli@canonical.com>
To:     linux-mm@kvack.org
Cc:     kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org, gpiccoli@canonical.com,
        kernel@gpiccoli.net, cascardo@canonical.com,
        Alexander Potapenko <glider@google.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@suse.cz>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH] mm, hugetlb: Avoid double clearing for hugetlb pages
Date:   Mon, 19 Oct 2020 15:28:53 -0300
Message-Id: <20201019182853.7467-1-gpiccoli@canonical.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Commit 6471384af2a6 ("mm: security: introduce init_on_alloc=1 and init_on_free=1
boot options") introduced the option for clearing/initializing kernel
pages on allocation time - this can be achieved either using a parameter
or a Kconfig setting. The goal for the change was a kernel hardening measure.

Despite the performance degradation with "init_on_alloc" is considered
low, there is one case in which it can be noticed and it may impact
latency of the system - this is when hugetlb pages are allocated.
Those pages are meant to be used by userspace *only* (differently of THP,
for example). In allocation time for hugetlb, their component pages go
through the initialization/clearing process in

 prep_new_page()
  kernel_init_free_pages()

and, when used in userspace mappings, the hugetlb are _again_ cleared;
I've checked that in practice by running the kernel selftest[0] for
hugetlb mapping - the pages go through clear_huge_pages() on page
fault [ see hugetlb_no_page() ].

This patch proposes a way to prevent this resource waste by skipping
the page initialization/clearing if the page is a component of hugetlb
page (even if "init_on_alloc" or the respective Kconfig are set).
The performance improvement measured in [1] demonstrates that it is
effective and bring the hugetlb allocation time to the same level as
with "init_on_alloc" disabled. Despite we've used sysctl to allocate
hugetlb pages in our tests, the same delay happens in early boot time
when hugetlb parameters are set on kernel cmdline (and "init_on_alloc"
is set).

[0] tools/testing/selftests/vm/map_hugetlb.c

[1] Test results - all tests executed in a pristine kernel 5.9+, from
2020-10-19, at commit 7cf726a594353010. A virtual machine with 96G of
total memory was used, the test consists in allocating 64G of 2M hugetlb
pages. Results below:

* Without this patch, init_on_alloc=1
$ cat /proc/meminfo |grep "MemA\|Hugetlb"
MemAvailable:   97892212 kB
Hugetlb:               0 kB

$ time echo 32768 > /proc/sys/vm/nr_hugepages
real    0m24.189s
user    0m0.000s
sys     0m24.184s

$ cat /proc/meminfo |grep "MemA\|Hugetlb"
MemAvailable:   30784732 kB
Hugetlb:        67108864 kB

* Without this patch, init_on_alloc=0
$ cat /proc/meminfo |grep "MemA\|Hugetlb"
MemAvailable:   97892752 kB
Hugetlb:               0 kB

$ time echo 32768 > /proc/sys/vm/nr_hugepages
real    0m0.316s
user    0m0.000s
sys     0m0.316s

$ cat /proc/meminfo |grep "MemA\|Hugetlb"
MemAvailable:   30783628 kB
Hugetlb:        67108864 kB

* WITH this patch, init_on_alloc=1
$ cat /proc/meminfo |grep "MemA\|Hugetlb"
MemAvailable:   97891952 kB
Hugetlb:               0 kB

$ time echo 32768 > /proc/sys/vm/nr_hugepages
real    0m0.209s
user    0m0.000s
sys     0m0.209s

$ cat /proc/meminfo |grep "MemA\|Hugetlb"
MemAvailable:   30782964 kB
Hugetlb:        67108864 kB

* WITH this patch, init_on_alloc=0
$ cat /proc/meminfo |grep "MemA\|Hugetlb"
MemAvailable:   97892620 kB
Hugetlb:               0 kB

$ time echo 32768 > /proc/sys/vm/nr_hugepages
real    0m0.206s
user    0m0.000s
sys     0m0.206s

$ cat /proc/meminfo |grep "MemA\|Hugetlb"
MemAvailable:   30783804 kB
Hugetlb:        67108864 kB

Signed-off-by: Guilherme G. Piccoli <gpiccoli@canonical.com>
Suggested-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: James Morris <jamorris@linux.microsoft.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Michal Hocko <mhocko@suse.cz>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
---


Hi everybody, thanks in advance for the review/comments. I'd like to
point 2 things related to the implementation:

1) I understand that adding GFP flags is not really welcome by the
mm community; I've considered passing that as function parameter but
that would be a hacky mess, so I decided to add the flag since it seems
this is a fair use of the flag mechanism (to control actions on pages).
If anybody has a better/simpler suggestion to implement this, I'm all
ears - thanks!

2) The checkpatch script gave me the following error, but I decided to
ignore it in order to maintain the same format present in the file:

ERROR: space required after that close brace '}'
#171: FILE: include/trace/events/mmflags.h:52:


 include/linux/gfp.h            | 14 +++++++++-----
 include/linux/mm.h             |  2 +-
 include/trace/events/mmflags.h |  3 ++-
 mm/hugetlb.c                   |  7 +++++++
 tools/perf/builtin-kmem.c      |  1 +
 5 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index c603237e006c..c03909f8e7b6 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -39,8 +39,9 @@ struct vm_area_struct;
 #define ___GFP_HARDWALL		0x100000u
 #define ___GFP_THISNODE		0x200000u
 #define ___GFP_ACCOUNT		0x400000u
+#define ___GFP_NOINIT_ON_ALLOC	0x800000u
 #ifdef CONFIG_LOCKDEP
-#define ___GFP_NOLOCKDEP	0x800000u
+#define ___GFP_NOLOCKDEP	0x1000000u
 #else
 #define ___GFP_NOLOCKDEP	0
 #endif
@@ -215,16 +216,19 @@ struct vm_area_struct;
  * %__GFP_COMP address compound page metadata.
  *
  * %__GFP_ZERO returns a zeroed page on success.
+ *
+ * %__GFP_NOINIT_ON_ALLOC avoids uspace pages to be double-cleared (like HugeTLB)
  */
-#define __GFP_NOWARN	((__force gfp_t)___GFP_NOWARN)
-#define __GFP_COMP	((__force gfp_t)___GFP_COMP)
-#define __GFP_ZERO	((__force gfp_t)___GFP_ZERO)
+#define __GFP_NOWARN		((__force gfp_t)___GFP_NOWARN)
+#define __GFP_COMP		((__force gfp_t)___GFP_COMP)
+#define __GFP_ZERO		((__force gfp_t)___GFP_ZERO)
+#define __GFP_NOINIT_ON_ALLOC	((__force gfp_t)___GFP_NOINIT_ON_ALLOC)
 
 /* Disable lockdep for GFP context tracking */
 #define __GFP_NOLOCKDEP ((__force gfp_t)___GFP_NOLOCKDEP)
 
 /* Room for N __GFP_FOO bits */
-#define __GFP_BITS_SHIFT (23 + IS_ENABLED(CONFIG_LOCKDEP))
+#define __GFP_BITS_SHIFT (24 + IS_ENABLED(CONFIG_LOCKDEP))
 #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
 
 /**
diff --git a/include/linux/mm.h b/include/linux/mm.h
index ef360fe70aaf..7fa60d22a90a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2882,7 +2882,7 @@ DECLARE_STATIC_KEY_FALSE(init_on_alloc);
 static inline bool want_init_on_alloc(gfp_t flags)
 {
 	if (static_branch_unlikely(&init_on_alloc) &&
-	    !page_poisoning_enabled())
+	    !page_poisoning_enabled() && !(flags & __GFP_NOINIT_ON_ALLOC))
 		return true;
 	return flags & __GFP_ZERO;
 }
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index 67018d367b9f..89b0c0ddcc52 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -48,7 +48,8 @@
 	{(unsigned long)__GFP_WRITE,		"__GFP_WRITE"},		\
 	{(unsigned long)__GFP_RECLAIM,		"__GFP_RECLAIM"},	\
 	{(unsigned long)__GFP_DIRECT_RECLAIM,	"__GFP_DIRECT_RECLAIM"},\
-	{(unsigned long)__GFP_KSWAPD_RECLAIM,	"__GFP_KSWAPD_RECLAIM"}\
+	{(unsigned long)__GFP_KSWAPD_RECLAIM,	"__GFP_KSWAPD_RECLAIM"},\
+	{(unsigned long)__GFP_NOINIT_ON_ALLOC,	"__GFP_NOINIT_ON_ALLOC"}\
 
 #define show_gfp_flags(flags)						\
 	(flags) ? __print_flags(flags, "|",				\
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index fe76f8fd5a73..c60a6726b0be 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1742,6 +1742,13 @@ static struct page *alloc_fresh_huge_page(struct hstate *h,
 {
 	struct page *page;
 
+	/*
+	 * Signal the following page allocs to avoid them being cleared
+	 * in allocation time - since HugeTLB pages are *only* used as
+	 * userspace pages, they'll be cleared by default before usage.
+	 */
+	gfp_mask |= __GFP_NOINIT_ON_ALLOC;
+
 	if (hstate_is_gigantic(h))
 		page = alloc_gigantic_page(h, gfp_mask, nid, nmask);
 	else
diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index a50dae2c4ae9..bef90d8bb7f6 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -660,6 +660,7 @@ static const struct {
 	{ "__GFP_RECLAIM",		"R" },
 	{ "__GFP_DIRECT_RECLAIM",	"DR" },
 	{ "__GFP_KSWAPD_RECLAIM",	"KR" },
+	{ "__GFP_NOINIT_ON_ALLOC",	"NIA" },
 };
 
 static size_t max_gfp_len;
-- 
2.28.0

