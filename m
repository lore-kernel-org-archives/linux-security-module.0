Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B16213ACC
	for <linux-security-module@vger.kernel.org>; Sat,  6 Apr 2024 12:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712405551; cv=none; b=HVjxGuxdnqRDiA4CpZu1z6/1nkOtkfFn6vrUg+nYX04V0d5PVch4tBw8dWYqwN3BLNAezCLd8g5tL0LJS/JmM9HvAt5IRbrhCcOU+8kbIEId8oTH7DXxXAxkzy24BZqqVV4PxQ+YC1dZw6ZTiTuA53f/Sdqcy3n01pbGvfapTog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712405551; c=relaxed/simple;
	bh=+llZnZZ0fqskCpk1GqD8dkbcPml+61V7b1nbCU6ksk4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=oe5eX8dLO70iANv8oDHUgTGCaUOMrcdQptOVXxsDG7d/D72g/aJgWUa1wWXmvZWJpME65TO2bMZiEGWxaOMmSSHqaJ7hqqywGL3zM0nTHMVGwYF26aJubsgEMFQ0XRsC5P+V2l69fObVkJOOJsPMPZSMJTfjzKsuiQj29Mkme9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILhRtIeY; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILhRtIeY"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-344117bee49so537577f8f.1
        for <linux-security-module@vger.kernel.org>; Sat, 06 Apr 2024 05:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712405547; x=1713010347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3nY0ke4mztvDFdycWcex2NH962CeQxNqnfP1gnvmLTI=;
        b=ILhRtIeYPj5suPgl1Lp4/hzBronDetGezCKLSimrUEiEUQ6L1Q4Qwv3W3m4wSfeKcu
         vglDBn19VvEd4zFdpVzDUBsxedbJT4mvBlTNus8IwvkJltyaEjlebbYQ1k1uddK/N5Jb
         syLBXJWlkrdn2a8ERKOoSsvsa3yq4Pun93JHLBw+f+GpvJ68moof3+5smi3eefgIXSom
         1VR269sk+CiG43fpTDENfq5TijuJktuXc1fU5GRukyTRyXVjaWzOmGdeRnVZZ3kUdKlR
         3DpjLNNl0woSrCO1QnyxPBHzy6eI15y4dcZqDIT3oeuhJ03aeHcDdFknPxa6G+gIEBj8
         VDbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712405547; x=1713010347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3nY0ke4mztvDFdycWcex2NH962CeQxNqnfP1gnvmLTI=;
        b=e8fu5FvEzlQ/5ZA+A13LHUay37K8VpOZzvtCKFzL7Bs1a3sWRsSjnql6PntskefuEm
         y2mAjd44BaHRGt6gMvSxUYkM8dQdgauasb8dZapsQkgjKaS5tIN7k7a/a76UXKWkUpU2
         hwMYd1z2tiLSBoz0MfLwJ8lU/N67XIlM6+AMiVxPuBPas/liFOMAAIKCxG4wj/vutMP1
         8i81HMxakCSgwDrckovybto/ftonbG3tPhoZMw7DbB5Kp1U5g67NywApMm++FiUk3DNH
         Tgq0tWWlC6L017hgr0hnPNSe8olUIsesnPCoZH3EDtGj8VN5cUA2mCWy87LkW+tyPlwa
         ed6w==
X-Forwarded-Encrypted: i=1; AJvYcCVuicdghRIDwIgSS6lvhYgkArQpkYVdJwAhFSlc7cQS0dhvlDIl+UjBUg7iqRX1MXZk/fBatW1bBafOl1doVaIAAq8TrtlHvfKsTd3+sqvg67RW3vhB
X-Gm-Message-State: AOJu0YySGXcUWdVu3TAB26rx2Cdt+B8ENuZxXHo5+LwCcaCg2ekPhnnD
	Lvxnk9WKt3E+SfBFVwkOxTQ6Spgmu4Fcfh1wfG6RmNCwTv8/hB+j
X-Google-Smtp-Source: AGHT+IEvw3Q6SBQARb3UI9C/4xBBW9Ei0m9PfHb5hogw/w9BwrS0RhlaA0RW+BU+XwCNG2YQBCnEgw==
X-Received: by 2002:a5d:438f:0:b0:33e:ca28:bb59 with SMTP id i15-20020a5d438f000000b0033eca28bb59mr3768395wrq.57.1712405546568;
        Sat, 06 Apr 2024 05:12:26 -0700 (PDT)
Received: from ubuntu-focal.zuku.co.ke ([197.237.50.252])
        by smtp.gmail.com with ESMTPSA id di3-20020a0560000ac300b00341c7129e28sm4325591wrb.91.2024.04.06.05.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 05:12:25 -0700 (PDT)
From: Dorine Tipo <dorine.a.tipo@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	skhan@linuxfoundation.org,
	Paul Moore <paul@paul-moore.com>,
	linux-security-module@vger.kernel.org,
	outreachy@lists.linux.dev
Cc: Dorine Tipo <dorine.a.tipo@gmail.com>,
	Linux-kernel-mentees-request@lists.linuxfoundation.org
Subject: [PATCH v4] Add test for io_uring openat access control with Landlock rules
Date: Thu,  4 Apr 2024 21:16:37 +0000
Message-Id: <20240404211637.38472-1-dorine.a.tipo@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This v4 patch expands Landlock test coverage to include io_uring
operations. It also introduces a test for IORING_OP_OPENAT with Landlock
rules, verifying allowed and restricted O_RDONLY access. This makes sure that
IORING_OP_OPENAT is well covered from security vulnerabilities by
ensuring Landlock controls access through io_uring.

It also updates Makefile to include -luring in the LDLIBS variable.
This ensures the test code has access to the necessary library for
io_uring operations.

The previous implementation of tests for the io_uring operation
IORING_OP_OPENAT in the Landlock fs_test suite was found to be incorrect
and ineffective.
This patch removes the previous implementation and introduces a new set
of tests that cover both allowed and denied access scenarios.

Signed-off-by: Dorine Tipo <dorine.a.tipo@gmail.com>
Changes since V1:
V2: - Consolidated two dependent patches in the V1 series into one patch
      as suggested by Fabio.
    - Updated The subject line to be more descriptive.

V3: - Added "selftests/landlock" subject prefix
    - Revised wording in the commit message to accurately reflect the
      test functionality as suggested by Mickaël.
    - Updated the Fixture set_up and tear_down to create and remove the
      necesssary files and folders for testing access.
    - renamed allowed_ruleset_fd and disallowed_ruleset_fd to ruleset_fd
      as suggest by Mickaël.
    - Moved all variable declarations to the top of the function.
    - Refactored the code to test only one allowed and one restricted
      path instead of iterating through all the paths.
    - Added comments to explain what is happening in different blocks
      of code
    - Removed the clang-format markers.
    - Removed unused arguments in the function definition.
    - Added a final rule struct with a null path to the allowed_rule
      and disallowed_rule arrays as suggested by Fabio.
    - CC'd the missing mailing lists as suggested by Shuah.
    - All executables have been included in the .gitignore so no updates
      are necessary.

V4: - Removed the previous implementation of the tests as they were not
      correctly implemented.
---
 tools/testing/selftests/landlock/Makefile  |  4 +-
 tools/testing/selftests/landlock/fs_test.c | 85 ++++++++++++++++++++++
 2 files changed, 87 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/landlock/Makefile b/tools/testing/selftests/landlock/Makefile
index 348e2dbdb4e0..ab47d1dadb62 100644
--- a/tools/testing/selftests/landlock/Makefile
+++ b/tools/testing/selftests/landlock/Makefile
@@ -13,11 +13,11 @@ TEST_GEN_PROGS := $(src_test:.c=)
 TEST_GEN_PROGS_EXTENDED := true

 # Short targets:
-$(TEST_GEN_PROGS): LDLIBS += -lcap
+$(TEST_GEN_PROGS): LDLIBS += -lcap -luring
 $(TEST_GEN_PROGS_EXTENDED): LDFLAGS += -static

 include ../lib.mk

 # Targets with $(OUTPUT)/ prefix:
-$(TEST_GEN_PROGS): LDLIBS += -lcap
+$(TEST_GEN_PROGS): LDLIBS += -lcap -luring
 $(TEST_GEN_PROGS_EXTENDED): LDFLAGS += -static
diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 9a6036fbf289..d1fae72e99be 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -21,7 +21,10 @@
 #include <sys/stat.h>
 #include <sys/sysmacros.h>
 #include <sys/vfs.h>
+#include <sys/types.h>
 #include <unistd.h>
+#include <liburing.h>
+#include <linux/io_uring.h>

 #include "common.h"

@@ -4874,4 +4877,86 @@ TEST_F_FORK(layout3_fs, release_inodes)
 	ASSERT_EQ(EACCES, test_open(TMP_DIR, O_RDONLY));
 }

+/* test openat */
+static int test_openat(struct io_uring *ring, const char *path, int dfd)
+{
+	struct io_uring_cqe *cqe;
+	struct io_uring_sqe *sqe;
+	int ret;
+
+	sqe = io_uring_get_sqe(ring);
+	if (!sqe) {
+		fprintf(stderr, "get sqe failed\n");
+		goto err;
+	}
+	io_uring_prep_openat(sqe, dfd, path, O_RDONLY, 0);
+
+	ret = io_uring_submit(ring);
+	if (ret <= 0) {
+		fprintf(stderr, "sqe submit failed: %d\n", ret);
+		goto err;
+	}
+
+	ret = io_uring_wait_cqe(ring, &cqe);
+	if (ret < 0) {
+		fprintf(stderr, "wait completion %d\n", ret);
+		goto err;
+	}
+	ret = cqe->res;
+	io_uring_cqe_seen(ring, cqe);
+	return ret;
+err:
+	return -1;
+}
+
+TEST_F_FORK(layout1, openat_allowed)
+{
+	struct io_uring ring;
+	int ret;
+	const char *path = "file1_s1d3";
+	const struct rule rules[] = {
+		{
+			.path = path,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE,
+		},
+		{
+			.path = NULL,
+		},
+	};
+	int ruleset_fd;
+
+	ruleset_fd = create_ruleset(_metadata, rules[0].access, rules);
+	ret = io_uring_queue_init(8, &ring, 0);
+
+	ASSERT_EQ(0, ret);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, test_openat(&ring, file1_s1d3, AT_FDCWD));
+}
+
+TEST_F_FORK(layout1, openat_denied)
+{
+	struct io_uring ring;
+	int ret;
+	const char *path = "file2_s1d3";
+	const struct rule rules[] = {
+		{
+			.path = path,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE,
+		},
+		{
+			.path = NULL,
+		},
+	};
+	int ruleset_fd;
+
+	ruleset_fd = create_ruleset(_metadata, rules[0].access, rules);
+	ret = io_uring_queue_init(8, &ring, 0);
+
+	ASSERT_EQ(0, ret);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(EACCES, test_openat(&ring, file1_s1d3, AT_FDCWD));
+}
+
 TEST_HARNESS_MAIN
--
2.25.1

