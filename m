Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B042FF17D
	for <linux-security-module@vger.kernel.org>; Sun, 25 Jan 2026 19:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769371143; cv=none; b=rMFmIdXqVRoPKS6Ez2twuq9fXwEDN23wqrZ/wqEKfMkd8VC+plOS3/+kxm2mltUv470CkD8H6YKGwCHnmRoXSGXkYW/Hp3EJ96AdPVTBrPUM/myT9xFGxX/bOPkfa5cYd/SuHmknxUz7VkSf22Ryfn67eO4qsHwmzhhfnwwVLts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769371143; c=relaxed/simple;
	bh=R3xPcJCQrT+UmmAMpphWZYJwpTVr1ZosXe725ySa6gA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pU8SEvND9qmV37HY8uxafBfACLVrZaHkIp0JAUkVWnFqMIOOANMK2hR5WTVvx9j9zUso5zHCcpGn6+t9ER4iPA8tjAwidaEvpgjpxXzapbKwMFqoCX3bpN1gVbtNv3OquRCF/a0tgUPpYBiuu2KIu6Bplf3+4EtOF9rMQS7o57w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ncwgqAec; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncwgqAec"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4805ef35864so3458575e9.0
        for <linux-security-module@vger.kernel.org>; Sun, 25 Jan 2026 11:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769371140; x=1769975940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cIJtvoNn/1payEMbNudTjAOElNhAoBo6V6rS4pNFve0=;
        b=ncwgqAecdY9LYXBbNoMAIni61jt1/yNESYdI2piSJ6aldeXeNS32dEsTtKkcgqr1yq
         YaC65+qv99AOHGTjR4f2fgj/Y0ryQge6MrWi6pyisDPqyWiy6uHGzXXNQOJOlpJvO18j
         HOMEKZ36QxpJDePNcsnBuVEt4FhkFlddUm4eKqBZK839lFhHXHhdP01XGUlfJblA0mqY
         Y7KG79QhzpgCPmMA08x7w2bjrMYHCzJ1hcBVWEugSpX2QQySBepkTOxHAKxH5mWEj80k
         GKeftgy8vjFBD79F1gtx++eeG9NKbuykkqDsPrlqX6N0Tk8IFS/BVADhwHX5ZceA6N9y
         XY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769371140; x=1769975940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cIJtvoNn/1payEMbNudTjAOElNhAoBo6V6rS4pNFve0=;
        b=SInkeJ8696TEtSVlJ6Ra5AeVlXHQ2TXjqJSEHL/83m0ydEAShsWFdYW3hxYnj2ktyM
         dRStS+8KI18hRZxIFTNuN4YdBvkEZ4MY+Yk+DNog1pIUMpM9X9taHpnd3V9xKeVcZ/08
         GY9Uhv1FTlIAGrabBLyl8GS5DYRj2ik8/5KfFQCsBtBJFg0zjrp2eFzCc9ZTMbl4aZh/
         OQ3MiM0Fa7Mvjl6WBC3h3XWG0rZRZE+AbNktQCke5KvkymcrVIP09pycPCSIrk8Jb3DO
         zH1eHHG4nIU5sqy3n6ayDUdH2/enzi8+m/kAEiY622lFA21Ps4sx5xbcwRLqly7bX2qh
         Q+sw==
X-Gm-Message-State: AOJu0Yyom24qsRV1Co4aa7sPbLNfuoxz+ggkIEXQEZ3rx9imCYEGj6e0
	jI6CTwCKa+/oOYePQydMx/Dw7WuVPTZ9bBnX+mbzV7+MZnXcYQGCpZEJ
X-Gm-Gg: AZuq6aIWp2xHEuv7Gmvk15Rvw9npuBYPYmxVrRqRdJN+7OhaXe2/w7tPvtqXgVlZkRt
	M7p3FP1aDCqPxPxPomuC8+W0XYsDo3bgCKhk60uuzK44aipGsplzu7KXR9IN0dsU6JcxU7dDFno
	/kQKJrh+METszyzwOywT9u3Mi1eYpWzbndBwleV5y45D8expLDE/kofDOiwrXVYZVPq0f+ZNYME
	7f8WzBt5+MLUgHTvTAJutUYrM3RzTvxGoJBOX2hAtONJ+71M1DFBW7b/WBxRlhzgikd3P18K0og
	1j46FfyHwbMPT1/AN3xCF5HAU6WXiQzjZmq7GayqtWDMU9vtteot6eWAzmE14iwLw3tU5DKwdxq
	KFIk+1hL9+HZTx+zPcrDO5biFXtK/nYp0OUgYtND/meqNTxXJTsDZiW04K11trBaRRC/5Qh28Zu
	SxupCFsqNtEAvuSFvhBm1SVwXafYqSyOkaC9Fp
X-Received: by 2002:a05:600c:628f:b0:480:25ae:9993 with SMTP id 5b1f17b1804b1-4805ce67d64mr42500415e9.20.1769371140446;
        Sun, 25 Jan 2026 11:59:00 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48047028928sm414311325e9.2.2026.01.25.11.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 11:59:00 -0800 (PST)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org,
	Tingmao Wang <m@maowtm.org>,
	Justin Suess <utilityemal77@gmail.com>,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Randy Dunlap <rdunlap@infradead.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH v2 1/3] selftests/landlock: Add filesystem access benchmark
Date: Sun, 25 Jan 2026 20:58:51 +0100
Message-ID: <20260125195853.109967-2-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260125195853.109967-1-gnoack3000@gmail.com>
References: <20260125195853.109967-1-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

fs_bench benchmarks the performance of Landlock's path walk
by exercising it in a scenario that amplifies Landlock's overhead:

* Create a large number of nested directories
* Enforce a Landlock policy in which a rule is associated with each of
  these subdirectories
* Benchmark openat() applied to the deepest directory,
  forcing Landlock to walk the entire path.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/.gitignore |   1 +
 tools/testing/selftests/landlock/Makefile   |   1 +
 tools/testing/selftests/landlock/fs_bench.c | 161 ++++++++++++++++++++
 3 files changed, 163 insertions(+)
 create mode 100644 tools/testing/selftests/landlock/fs_bench.c

diff --git a/tools/testing/selftests/landlock/.gitignore b/tools/testing/selftests/landlock/.gitignore
index a820329cae0d..1974e17a2611 100644
--- a/tools/testing/selftests/landlock/.gitignore
+++ b/tools/testing/selftests/landlock/.gitignore
@@ -1,4 +1,5 @@
 /*_test
+/fs_bench
 /sandbox-and-launch
 /true
 /wait-pipe
diff --git a/tools/testing/selftests/landlock/Makefile b/tools/testing/selftests/landlock/Makefile
index 044b83bde16e..fc43225d319a 100644
--- a/tools/testing/selftests/landlock/Makefile
+++ b/tools/testing/selftests/landlock/Makefile
@@ -9,6 +9,7 @@ LOCAL_HDRS += $(wildcard *.h)
 src_test := $(wildcard *_test.c)
 
 TEST_GEN_PROGS := $(src_test:.c=)
+TEST_GEN_PROGS += fs_bench
 
 TEST_GEN_PROGS_EXTENDED := \
 	true \
diff --git a/tools/testing/selftests/landlock/fs_bench.c b/tools/testing/selftests/landlock/fs_bench.c
new file mode 100644
index 000000000000..a3b686418bc5
--- /dev/null
+++ b/tools/testing/selftests/landlock/fs_bench.c
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Landlock filesystem benchmark
+ */
+
+#define _GNU_SOURCE
+#include <err.h>
+#include <fcntl.h>
+#include <linux/landlock.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/prctl.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+#include <sys/times.h>
+#include <time.h>
+#include <unistd.h>
+
+void usage(const char *argv0)
+{
+	printf("Usage:\n");
+	printf("  %s [OPTIONS]\n", argv0);
+	printf("\n");
+	printf("  Benchmark expensive Landlock checks for D nested dirs\n");
+	printf("\n");
+	printf("Options:\n");
+	printf("  -h	help\n");
+	printf("  -L	disable Landlock (as a baseline)\n");
+	printf("  -d D	set directory depth to D\n");
+	printf("  -n N	set number of benchmark iterations to N\n");
+}
+
+/*
+ * Build a deep directory, enforce Landlock and return the FD to the
+ * deepest dir.  On any failure, exit the process with an error.
+ */
+int build_directory(size_t depth, bool use_landlock)
+{
+	const char *path = "d"; /* directory name */
+	int abi, ruleset_fd, current, previous;
+
+	if (use_landlock) {
+		abi = syscall(SYS_landlock_create_ruleset, NULL, 0,
+			      LANDLOCK_CREATE_RULESET_VERSION);
+		if (abi < 7)
+			err(1, "Landlock ABI too low: got %d, wanted 7+", abi);
+	}
+
+	ruleset_fd = -1;
+	if (use_landlock) {
+		struct landlock_ruleset_attr attr = {
+			.handled_access_fs =
+				0xffff, /* All FS access rights as of 2026-01 */
+		};
+		ruleset_fd = syscall(SYS_landlock_create_ruleset, &attr,
+				     sizeof(attr), 0U);
+		if (ruleset_fd < 0)
+			err(1, "landlock_create_ruleset");
+	}
+
+	current = open(".", O_PATH);
+	if (current < 0)
+		err(1, "open(.)");
+
+	while (depth--) {
+		if (use_landlock) {
+			struct landlock_path_beneath_attr attr = {
+				.allowed_access = LANDLOCK_ACCESS_FS_IOCTL_DEV,
+				.parent_fd = current,
+			};
+			if (syscall(SYS_landlock_add_rule, ruleset_fd,
+				    LANDLOCK_RULE_PATH_BENEATH, &attr, 0) < 0)
+				err(1, "landlock_add_rule");
+		}
+
+		if (mkdirat(current, path, 0700) < 0)
+			err(1, "mkdirat(%s)", path);
+
+		previous = current;
+		current = openat(current, path, O_PATH);
+		if (current < 0)
+			err(1, "open(%s)", path);
+
+		close(previous);
+	}
+
+	if (use_landlock) {
+		if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0) < 0)
+			err(1, "prctl");
+
+		if (syscall(SYS_landlock_restrict_self, ruleset_fd, 0) < 0)
+			err(1, "landlock_restrict_self");
+	}
+
+	close(ruleset_fd);
+	return current;
+}
+
+int main(int argc, char *argv[])
+{
+	bool use_landlock = true;
+	size_t num_iterations = 100000;
+	size_t num_subdirs = 10000;
+	int c, current, fd;
+	struct tms start_time, end_time;
+
+	setbuf(stdout, NULL);
+	while ((c = getopt(argc, argv, "hLd:n:")) != -1) {
+		switch (c) {
+		case 'h':
+			usage(argv[0]);
+			return EXIT_SUCCESS;
+		case 'L':
+			use_landlock = false;
+			break;
+		case 'd':
+			num_subdirs = atoi(optarg);
+			break;
+		case 'n':
+			num_iterations = atoi(optarg);
+			break;
+		default:
+			usage(argv[0]);
+			return EXIT_FAILURE;
+		}
+	}
+
+	printf("*** Benchmark ***\n");
+	printf("%zu dirs, %zu iterations, %s landlock\n", num_subdirs,
+	       num_iterations, use_landlock ? "with" : "without");
+
+	if (times(&start_time) == -1)
+		err(1, "times");
+
+	current = build_directory(num_subdirs, use_landlock);
+
+	for (int i = 0; i < num_iterations; i++) {
+		fd = openat(current, ".", O_DIRECTORY);
+		if (fd != -1) {
+			if (use_landlock)
+				errx(1, "openat succeeded, expected error");
+
+			close(fd);
+		}
+	}
+
+	if (times(&end_time) == -1)
+		err(1, "times");
+
+	printf("*** Benchmark concluded ***\n");
+	printf("System: %ld clocks\n",
+	       end_time.tms_stime - start_time.tms_stime);
+	printf("User  : %ld clocks\n",
+	       end_time.tms_utime - start_time.tms_utime);
+	printf("Clocks per second: %ld\n", CLOCKS_PER_SEC);
+
+	close(current);
+}
-- 
2.52.0

