Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54552C00140
	for <linux-security-module@archiver.kernel.org>; Mon,  8 Aug 2022 17:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244090AbiHHR5B (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 8 Aug 2022 13:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244121AbiHHR4h (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 8 Aug 2022 13:56:37 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E913517E07
        for <linux-security-module@vger.kernel.org>; Mon,  8 Aug 2022 10:56:28 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31f4450c963so83350087b3.19
        for <linux-security-module@vger.kernel.org>; Mon, 08 Aug 2022 10:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=XlgksS8fZomBMU6we0kRE5nSjV4DtoPIEs0s8v9e0Dk=;
        b=eV0w1ZYN780esWshwM0oQr+SMcM8X1ftPquQabqMDvmezQ0q1z2xKHKgDWX/yxeqc9
         ozDUd669ncenrTTXZiSADu6HOBVVJ+hx8n1kxLTCTk97Omymh2R56EtzHiXWQ3aIW+KD
         2k+KoHq5nBWEX8hgoiES2yl9f43ytrPEVoREK3tGhoY+w4usvBXzAtAleOgBr3FUZsMb
         0saV5Fro8js0s6kRVa6wN3HVgaDKhirXO5QWULIWfIxTIArpnf/9nyn9MCvTUeL8rugB
         1p612BVnCnDJF6UB4CkcsJiydss3klalfiJWZvzpzEhQL4Bzg78G9g9gN0FyVHuS5cTI
         CRcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=XlgksS8fZomBMU6we0kRE5nSjV4DtoPIEs0s8v9e0Dk=;
        b=hK7JO3th3R9zwZTQcRE8mG/h5jj/HGREHZYFpqaGhYk+lHLbYyx9sHQbl5QXvRNI5U
         JCMhpcopk10s5SFedyTqIHMmMJKvp5njT+b1Ngq2d4a6whta6MZ5SmmvrZizbzIuER+d
         jKUM1fFyjNY+gGYHpbNfmWCoYzb+GHCofK1tLdyHAUc7Jvp2FgSvMttmU+f+v4Dittf4
         AFuwJd1EW5XtYuZhnpwecN3MMudsnQvCcOPd2LSqDuJ6yTeULSpT36JEDdhYe2/vjCd7
         /gGK5Cp3jO4E1jGUdtds5p4qK3NVdO2RqQ8gb1RWKlW8KdWqWOP/kGmvEZP4thiDBvwJ
         TMYA==
X-Gm-Message-State: ACgBeo3/tY1/o9RPfLyxAXG5LvOXE93RpwzfNbhKGJwBbL1tIOawORPU
        5fiCwUyUjf26I5Uz8CS+55AIH46WjXm9amDDjlw7
X-Google-Smtp-Source: AA6agR6npeg0ptcuEpFjsffo8RCXbkNDOrCByOZCObVgrDxj7LPO76dCYQ9ymRjDrk6K+87ZEVPO8jVWMLgS4Kj7TBeU
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2d4:203:7a2a:3bb5:f3a0:3bbc])
 (user=axelrasmussen job=sendgmr) by 2002:a25:3b4e:0:b0:67a:85fd:f24f with
 SMTP id i75-20020a253b4e000000b0067a85fdf24fmr16477068yba.51.1659981388099;
 Mon, 08 Aug 2022 10:56:28 -0700 (PDT)
Date:   Mon,  8 Aug 2022 10:56:12 -0700
In-Reply-To: <20220808175614.3885028-1-axelrasmussen@google.com>
Message-Id: <20220808175614.3885028-4-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20220808175614.3885028-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v5 3/5] userfaultfd: selftests: modify selftest to use /dev/userfaultfd
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

We clearly want to ensure both userfaultfd(2) and /dev/userfaultfd keep
working into the future, so just run the test twice, using each
interface.

Instead of always testing both userfaultfd(2) and /dev/userfaultfd,
let the user choose which to test.

As with other test features, change the behavior based on a new
command line flag. Introduce the idea of "test mods", which are
generic (not specific to a test type) modifications to the behavior of
the test. This is sort of borrowed from this RFC patch series [1], but
simplified a bit.

The benefit is, in "typical" configurations this test is somewhat slow
(say, 30sec or something). Testing both clearly doubles it, so it may
not always be desirable, as users are likely to use one or the other,
but never both, in the "real world".

[1]: https://patchwork.kernel.org/project/linux-mm/patch/20201129004548.1619714-14-namit@vmware.com/

Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 69 ++++++++++++++++++++----
 1 file changed, 60 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 7c3f1b0ab468..cae72867c173 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -77,6 +77,11 @@ static int bounces;
 #define TEST_SHMEM	3
 static int test_type;
 
+#define UFFD_FLAGS	(O_CLOEXEC | O_NONBLOCK | UFFD_USER_MODE_ONLY)
+
+/* test using /dev/userfaultfd, instead of userfaultfd(2) */
+static bool test_dev_userfaultfd;
+
 /* exercise the test_uffdio_*_eexist every ALARM_INTERVAL_SECS */
 #define ALARM_INTERVAL_SECS 10
 static volatile bool test_uffdio_copy_eexist = true;
@@ -125,6 +130,8 @@ struct uffd_stats {
 const char *examples =
     "# Run anonymous memory test on 100MiB region with 99999 bounces:\n"
     "./userfaultfd anon 100 99999\n\n"
+    "# Run the same anonymous memory test, but using /dev/userfaultfd:\n"
+    "./userfaultfd anon:dev 100 99999\n\n"
     "# Run share memory test on 1GiB region with 99 bounces:\n"
     "./userfaultfd shmem 1000 99\n\n"
     "# Run hugetlb memory test on 256MiB region with 50 bounces:\n"
@@ -141,6 +148,14 @@ static void usage(void)
 		"[hugetlbfs_file]\n\n");
 	fprintf(stderr, "Supported <test type>: anon, hugetlb, "
 		"hugetlb_shared, shmem\n\n");
+	fprintf(stderr, "'Test mods' can be joined to the test type string with a ':'. "
+		"Supported mods:\n");
+	fprintf(stderr, "\tsyscall - Use userfaultfd(2) (default)\n");
+	fprintf(stderr, "\tdev - Use /dev/userfaultfd instead of userfaultfd(2)\n");
+	fprintf(stderr, "\nExample test mod usage:\n");
+	fprintf(stderr, "# Run anonymous memory test with /dev/userfaultfd:\n");
+	fprintf(stderr, "./userfaultfd anon:dev 100 99999\n\n");
+
 	fprintf(stderr, "Examples:\n\n");
 	fprintf(stderr, "%s", examples);
 	exit(1);
@@ -154,12 +169,14 @@ static void usage(void)
 			ret, __LINE__);				\
 	} while (0)
 
-#define err(fmt, ...)				\
+#define errexit(exitcode, fmt, ...)		\
 	do {					\
 		_err(fmt, ##__VA_ARGS__);	\
-		exit(1);			\
+		exit(exitcode);			\
 	} while (0)
 
+#define err(fmt, ...) errexit(1, fmt, ##__VA_ARGS__)
+
 static void uffd_stats_reset(struct uffd_stats *uffd_stats,
 			     unsigned long n_cpus)
 {
@@ -383,13 +400,29 @@ static void assert_expected_ioctls_present(uint64_t mode, uint64_t ioctls)
 	}
 }
 
+static int __userfaultfd_open_dev(void)
+{
+	int fd, _uffd = -1;
+
+	fd = open("/dev/userfaultfd", O_RDWR | O_CLOEXEC);
+	if (fd < 0)
+		return -1;
+
+	_uffd = ioctl(fd, USERFAULTFD_IOC_NEW, UFFD_FLAGS);
+	close(fd);
+	return _uffd;
+}
+
 static void userfaultfd_open(uint64_t *features)
 {
 	struct uffdio_api uffdio_api;
 
-	uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK | UFFD_USER_MODE_ONLY);
+	if (test_dev_userfaultfd)
+		uffd = __userfaultfd_open_dev();
+	else
+		uffd = syscall(__NR_userfaultfd, UFFD_FLAGS);
 	if (uffd < 0)
-		err("userfaultfd syscall not available in this kernel");
+		errexit(KSFT_SKIP, "creating userfaultfd failed");
 	uffd_flags = fcntl(uffd, F_GETFD, NULL);
 
 	uffdio_api.api = UFFD_API;
@@ -1584,8 +1617,6 @@ unsigned long default_huge_page_size(void)
 
 static void set_test_type(const char *type)
 {
-	uint64_t features = UFFD_API_FEATURES;
-
 	if (!strcmp(type, "anon")) {
 		test_type = TEST_ANON;
 		uffd_test_ops = &anon_uffd_test_ops;
@@ -1603,9 +1634,29 @@ static void set_test_type(const char *type)
 		test_type = TEST_SHMEM;
 		uffd_test_ops = &shmem_uffd_test_ops;
 		test_uffdio_minor = true;
-	} else {
-		err("Unknown test type: %s", type);
 	}
+}
+
+static void parse_test_type_arg(const char *raw_type)
+{
+	char *buf = strdup(raw_type);
+	uint64_t features = UFFD_API_FEATURES;
+
+	while (buf) {
+		const char *token = strsep(&buf, ":");
+
+		if (!test_type)
+			set_test_type(token);
+		else if (!strcmp(token, "dev"))
+			test_dev_userfaultfd = true;
+		else if (!strcmp(token, "syscall"))
+			test_dev_userfaultfd = false;
+		else
+			err("unrecognized test mod '%s'", token);
+	}
+
+	if (!test_type)
+		err("failed to parse test type argument: '%s'", raw_type);
 
 	if (test_type == TEST_HUGETLB)
 		page_size = default_huge_page_size();
@@ -1653,7 +1704,7 @@ int main(int argc, char **argv)
 		err("failed to arm SIGALRM");
 	alarm(ALARM_INTERVAL_SECS);
 
-	set_test_type(argv[1]);
+	parse_test_type_arg(argv[1]);
 
 	nr_cpus = sysconf(_SC_NPROCESSORS_ONLN);
 	nr_pages_per_cpu = atol(argv[2]) * 1024*1024 / page_size /
-- 
2.37.1.559.g78731f0fdb-goog

