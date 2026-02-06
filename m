Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4565427FD72
	for <linux-security-module@vger.kernel.org>; Fri,  6 Feb 2026 15:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770390739; cv=none; b=oMj5Az2e2E4+XDr5ewY9ciXAPT9RY90bANOrBe2NnonSUcPTPfd19MWKV48prgqRwIOv7mTNyBN261v9VDNyVh/ft+HDOutJ1SDxdpIGtpIrGmzs8ntHUTeFiyRCh7rbRpS/Yk4WS1hjkezO024TU0nnwN7huWa9Nw89wbvB7+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770390739; c=relaxed/simple;
	bh=xL8lc2gffzWYEdi+FYDb7n2g5Qbfdim5Euu8kbAMxH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jJJamgMLlw30W/ySKXaWB43I+I3jBaGGGR+ZbV3PFw63SZTkoKvnzmTB73SOssWQODRAgaU5FOqoYgHd6HtOnLsYrhiOhVQn8PV11G76ykjKxVRH6SSLC0o4hDTPC0P/p/6KsXHee1xcoki8SufVpa0IxviotFVJ/ycSe735E44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0Og5KNV; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0Og5KNV"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4801eb2c0a5so21080605e9.3
        for <linux-security-module@vger.kernel.org>; Fri, 06 Feb 2026 07:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770390738; x=1770995538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ArDKoe7mKlWpNoU+H0IBuhyP6b67HjPisIUFamoEqc4=;
        b=m0Og5KNVAjx2USx4NtJkhDvbraoZO0nPhJhDZEsgaeodQly6dmVUcdyGP1tkSzHviC
         MZDDRKvwN4XzJg9dxLgGV+fTXua4RlDTNpwhQorL+R39gZmRw0UtUiNHCpQmGUwUvZ3a
         Ct2AuoT3t5YOp/QLHBe1RWjO75gs7SCKkuG/qIEDjtTvq/PQyam/FVexwBiXGy3eDKnY
         ZFISJsS0ZURuUr6K7Wtgff128bWmXPfbKLfSTgaRBgEhHHKsh18JTcYQjuO6UQIVAqR3
         smGO8lRHMCx7zYjnXSPZjBvKpoSG8xlyF5k3LRuTOdlkmIUfOGlxjia3qUdLkoJfdkra
         hYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770390738; x=1770995538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ArDKoe7mKlWpNoU+H0IBuhyP6b67HjPisIUFamoEqc4=;
        b=S7q4H/bCf9yMIpAuhvtIhjiDb85Ivc7s62yoIyE6ch3cPgEvJVGVnIgvwh05iOuspT
         58QOzpQMxeoCwn9c9T2Q9+RZt4zfQCfikRgylUSFlDkQX5FHZTBlOGOAbOM709qF/gQE
         Fym3E0GcBLAZXdEYknOLIfM0BFNNvMlMWV9d6h5vfCAob4L/JSfdJ5sjaLWSfnwjcr9j
         p8iVdk4Q4hG/bPPaULTf5f9gzR1zb53d5ZYRD+J9hs9S5kXhZrlMW36Is8B67xs5Q5SI
         nLElKjbWfRxyghqeskevsjbBOjroTTaMjSfS6ItyI0IQzrKyYm4tlXfZoufl6D8J5LjI
         fmdA==
X-Forwarded-Encrypted: i=1; AJvYcCV9VOUAw8/FsoMALrI4YeHsZXzWTD/DYQsb12VuIXcySejUP8YOprq2/ktRD0mSmUK1Q9POkvDI09B5x0WeWSYxcU41V+s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo+nh6XzfWzZ1zuksfC2zHngOe606bU7Q8DBocKlQBFCobqnZx
	IVzYZRZ7NAf6tX+K+LrmCpYB8Los6X62jVCaxmGC1bhfUYAfAH4FIR+Z
X-Gm-Gg: AZuq6aJTXW8R5Bz4Ig1FAakKydQ8QztkUlSBf6JtutRy6HX23XOLLxNZFAAj3/8ydA9
	q+k8w1sXMvzWGoenoVBT0nBjDRTT/mBS+UEybNTSI8q1UVwRtkKNArgciOEQefWfKfFU62UE4kO
	M5f9p1ry50UguFnEGg4ZnaY2zdRaVstsgHLs2VfpHJ6xs4NvGfHF54bNbGYmZNQLXN8qtuMwO1W
	efPkUCqRRdshkOK+dldbELljuZ9Y9PZbHH3xAIN/af6AQlD/PieL5LtBpZSyOVINHECELQG8dxG
	r2pGFmsRgLxlwET0aJdFf4PPaJWE7X42piwYxp+c8Il0zr+IuHxe9/zJMOMgecnbojLWomz4k6U
	dV1Jo+OaezaByuSkP/P7MKngRaDBDbWMWjMTI0/8228g933V5wFcUU8A9pO6DjxFgDhpQoqEnfQ
	EuEE1bt3ffeLnK9gaHy3suAadRZacmBJrfQDkz
X-Received: by 2002:a05:600c:4748:b0:480:1d0b:2d32 with SMTP id 5b1f17b1804b1-483201e4947mr44663965e9.12.1770390737365;
        Fri, 06 Feb 2026 07:12:17 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48323c0296dsm48683015e9.1.2026.02.06.07.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 07:12:17 -0800 (PST)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	linux-security-module@vger.kernel.org,
	"Tingmao Wang" <m@maowtm.org>,
	"Justin Suess" <utilityemal77@gmail.com>,
	"Samasth Norway Ananda" <samasth.norway.ananda@oracle.com>,
	"Matthieu Buffet" <matthieu@buffet.re>,
	"Mikhail Ivanov" <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v3 1/3] selftests/landlock: Add filesystem access benchmark
Date: Fri,  6 Feb 2026 16:11:53 +0100
Message-ID: <20260206151154.97915-3-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260206151154.97915-2-gnoack3000@gmail.com>
References: <20260206151154.97915-2-gnoack3000@gmail.com>
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
 tools/testing/selftests/landlock/fs_bench.c | 214 ++++++++++++++++++++
 3 files changed, 216 insertions(+)
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
index 000000000000..377b7888b9bf
--- /dev/null
+++ b/tools/testing/selftests/landlock/fs_bench.c
@@ -0,0 +1,214 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Landlock filesystem benchmark
+ *
+ * This program benchmarks the time required for file access checks.  We use a
+ * large number (-d flag) of nested directories where each directory inode has
+ * an associated Landlock rule, and we repeatedly (-n flag) exercise a file
+ * access for which Landlock has to walk the path all the way up to the root.
+ *
+ * With an increasing number of nested subdirectories, Landlock's portion of the
+ * overall system call time increases, which makes the effects of Landlock
+ * refactorings more measurable.
+ *
+ * This benchmark does *not* measure the building of the Landlock ruleset.  The
+ * time required to add all these rules is not large enough to be easily
+ * measurable.  A separate benchmark tool would be better to test that, and that
+ * tool could then also use a simpler file system layout.
+ *
+ * Copyright 2026 Google LLC
+ */
+
+#define _GNU_SOURCE
+#include <err.h>
+#include <fcntl.h>
+#include <linux/landlock.h>
+#include <linux/prctl.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdio.h>
+#include <errno.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/prctl.h>
+#include <sys/stat.h>
+#include <sys/times.h>
+#include <time.h>
+#include <unistd.h>
+
+#include "wrappers.h"
+
+static void usage(const char *const argv0)
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
+static int build_directory(size_t depth, const bool use_landlock)
+{
+	const char *path = "d"; /* directory name */
+	int abi, ruleset_fd, curr, prev;
+
+	if (use_landlock) {
+		abi = landlock_create_ruleset(NULL, 0,
+					      LANDLOCK_CREATE_RULESET_VERSION);
+		if (abi < 7)
+			err(1, "Landlock ABI too low: got %d, wanted 7+", abi);
+	}
+
+	ruleset_fd = -1;
+	if (use_landlock) {
+		struct landlock_ruleset_attr attr = {
+			.handled_access_fs = LANDLOCK_ACCESS_FS_IOCTL_DEV |
+					     LANDLOCK_ACCESS_FS_WRITE_FILE |
+					     LANDLOCK_ACCESS_FS_MAKE_REG,
+		};
+		ruleset_fd = landlock_create_ruleset(&attr, sizeof(attr), 0U);
+		if (ruleset_fd < 0)
+			err(1, "landlock_create_ruleset");
+	}
+
+	curr = open(".", O_PATH);
+	if (curr < 0)
+		err(1, "open(.)");
+
+	while (depth--) {
+		if (use_landlock) {
+			struct landlock_path_beneath_attr attr = {
+				.allowed_access = LANDLOCK_ACCESS_FS_IOCTL_DEV,
+				.parent_fd = curr,
+			};
+			if (landlock_add_rule(ruleset_fd,
+					      LANDLOCK_RULE_PATH_BENEATH, &attr,
+					      0) < 0)
+				err(1, "landlock_add_rule");
+		}
+
+		if (mkdirat(curr, path, 0700) < 0)
+			err(1, "mkdirat(%s)", path);
+
+		prev = curr;
+		curr = openat(curr, path, O_PATH);
+		if (curr < 0)
+			err(1, "openat(%s)", path);
+
+		close(prev);
+	}
+
+	if (use_landlock) {
+		if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0) < 0)
+			err(1, "prctl");
+
+		if (landlock_restrict_self(ruleset_fd, 0) < 0)
+			err(1, "landlock_restrict_self");
+	}
+
+	close(ruleset_fd);
+	return curr;
+}
+
+static void remove_recursively(const size_t depth)
+{
+	const char *path = "d"; /* directory name */
+
+	int fd = openat(AT_FDCWD, ".", O_PATH);
+
+	if (fd < 0)
+		err(1, "openat(.)");
+
+	for (size_t i = 0; i < depth - 1; i++) {
+		int oldfd = fd;
+
+		fd = openat(fd, path, O_PATH);
+		if (fd < 0)
+			err(1, "openat(%s)", path);
+		close(oldfd);
+	}
+
+	for (size_t i = 0; i < depth; i++) {
+		if (unlinkat(fd, path, AT_REMOVEDIR) < 0)
+			err(1, "unlinkat(%s)", path);
+		int newfd = openat(fd, "..", O_PATH);
+
+		close(fd);
+		fd = newfd;
+	}
+	close(fd);
+}
+
+int main(int argc, char *argv[])
+{
+	bool use_landlock = true;
+	size_t num_iterations = 100000;
+	size_t num_subdirs = 10000;
+	int c, curr, fd;
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
+	curr = build_directory(num_subdirs, use_landlock);
+
+	for (int i = 0; i < num_iterations; i++) {
+		fd = openat(curr, "file.txt", O_CREAT | O_TRUNC | O_WRONLY);
+		if (use_landlock) {
+			if (fd == 0)
+				errx(1, "openat succeeded, expected EACCES");
+			if (errno != EACCES)
+				err(1, "openat expected EACCES, but got");
+		}
+		if (fd != -1)
+			close(fd);
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
+	close(curr);
+
+	remove_recursively(num_subdirs);
+}
-- 
2.52.0

