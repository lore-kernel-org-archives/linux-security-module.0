Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.223
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315370;
	b=kYrqL4bcsFZwCPlVvj9gdAwJZmXtPeJbFXQXTd3nfFxjw3c5KsgFk6lscpry8cRn9Fup
	 bEHIF1dVrZIbQ0RJGTyIqPt1d52x7OXf0n4+O5lcraT/ulCAzFmMNFU6e48dKkUnM8onW
	 EIE2YTV6eWBy/FfbysVYwQjNoncatfXM7VIn4sU44tAOqmc7oLfyq4SRAFEARR6Q150zG
	 g6nRlm4EkpUpkqXwbwiCDKWnYRnyIhqD+Fak2vqibx1klT+0jbRTeBPiHCTtwM4RM6Lfn
	 IBZhEP4TEvI7sggRGaHaHZ2/xbQ/R1gflLbMg87T6Ctr1ZQP6POeKNPHjt3jwSYHLQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315370;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy;
	bh=ztLAvhoOg3V1ndF9G0xFqQ/+dUrG0s47FWbvbFigD0A=;
	b=wDeOuoHXwjDXRc1NjAUVnaZd7NTjw8ww5XPU0pOUfoX8deFkn2/S1LO/++Sk/6RVhHxp
	 Bx9CcPQ3UlotaAuTjjLLYeSC4Peh4dJMnl5uPFq7EaRaYTPXsTXgyOAomGynPSBqAi9SU
	 l8aLJmhPwo3J6EQY0s9btRZnNL/ZdgviAhQNGj6voeGRuSjutHCI6kH8yg3ZhsPfPB4v1
	 rnPbxkfsBHq+2aiI0k10Ey+7Ucn/HowtSv6hBLt0+KCnEVsmmcJNfxFYasukRFuQamy1o
	 pC/1PV0jl4NvLbwvH3BvYZG6HstWaXwMG9/6FVKUCYytsgudHGsnby4f5j04Q4E/cTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=E7jrSLKL;
	arc=none smtp.remote-ip=113.46.200.223
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8D160A262E;
	Tue, 10 Nov 2026 12:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC8D160A262E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=E7jrSLKL
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ztLAvhoOg3V1ndF9G0xFqQ/+dUrG0s47FWbvbFigD0A=;
	b=E7jrSLKLsJSo1cbbVYvXbse10xJYmydeHl3brlzizFBWmigK//JqbY8E8vFVIPNn/E8T/xKn+
	EhysaRI9JCtnd4hxd1m/XiYKGPh1mrrhu2Z8DSkUuqyZc5bEunoWHRcuhjr3tu+QGK4PJgsEg/N
	Z4uJHxshItwNYX1s8COx2HA=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4jP68J49gCzmVBl;
	Tue, 10 Nov 2026 20:55:44 +0800 (CST)
Received: from whupemk100010.china.huawei.com (unknown [7.152.184.41])
	by mail.maildlp.com (Postfix) with ESMTPS id 233E94048B;
	Tue, 10 Nov 2026 20:55:59 +0800 (CST)
Received: from octopus.huawei.com (10.67.174.191) by
 whupemk100010.china.huawei.com (7.152.184.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 10 Nov 2026 20:55:57 +0800
From: Cai Xinchen <caixinchen1@huawei.com>
To: <nicolas.bouchinet@oss.cyber.gouv.fr>, <xiujianfeng@huawei.com>,
	<paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
	<shuah@kernel.org>, <kalevi@kolttonen.fi>, <caixinchen1@huawei.com>
CC: <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <bpf@vger.kernel.org>,
	<lujialin4@huawei.com>
Subject: [PATCH -next -v2 8/8] selftests/lsm: add lockdown securityfs test
Date: Tue, 10 Nov 2026 21:28:18 +0800
Message-ID: <20261110132818.2231593-9-caixinchen1@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
In-Reply-To: <20261110132818.2231593-1-caixinchen1@huawei.com>
References: <20261110132818.2231593-1-caixinchen1@huawei.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 whupemk100010.china.huawei.com (7.152.184.41)

Add a kselftest for the lockdown securityfs interface.  It checks the
read format, rejects unknown levels, verifies that an already locked
down kernel neither accepts the current level nor a lower one, and
checks that the level can be upgraded.  The test skips itself when
lockdown is not enabled, when not run as root, or when the file cannot
be opened for writing.

The upgrade test irreversibly raises the lockdown level, so the test is
built but not run by default; run "make run_lockdown_test" to execute
it, preferably on a disposable test system.

Enable CONFIG_SECURITY_LOCKDOWN_LSM in the selftest config fragment so
that the test has something to exercise.

Use the shared file read helper from common.c instead of duplicating it.

Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>
---
 tools/testing/selftests/lsm/Makefile        |   8 +
 tools/testing/selftests/lsm/common.c        |  35 ++-
 tools/testing/selftests/lsm/common.h        |   2 +
 tools/testing/selftests/lsm/config          |   1 +
 tools/testing/selftests/lsm/lockdown_test.c | 230 ++++++++++++++++++++
 5 files changed, 267 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/lsm/lockdown_test.c

diff --git a/tools/testing/selftests/lsm/Makefile b/tools/testing/selftests/lsm/Makefile
index 3f80c0bc093d..3be7aa42761c 100644
--- a/tools/testing/selftests/lsm/Makefile
+++ b/tools/testing/selftests/lsm/Makefile
@@ -8,10 +8,18 @@ LOCAL_HDRS += common.h
 TEST_GEN_PROGS := lsm_get_self_attr_test lsm_list_modules_test \
 		  lsm_set_self_attr_test
 
+# lockdown_test changes the machine's lockdown level, so do not run it
+# by default.
+TEST_GEN_PROGS_EXTENDED := lockdown_test
+
 include ../lib.mk
 
 $(OUTPUT)/lsm_get_self_attr_test: lsm_get_self_attr_test.c common.c
 $(OUTPUT)/lsm_set_self_attr_test: lsm_set_self_attr_test.c common.c
 $(OUTPUT)/lsm_list_modules_test: lsm_list_modules_test.c common.c
+$(OUTPUT)/lockdown_test: lockdown_test.c common.c
+
+run_lockdown_test: all
+	$(call RUN_TESTS, lockdown_test)
 
 EXTRA_CLEAN = $(OUTPUT)/common.o
diff --git a/tools/testing/selftests/lsm/common.c b/tools/testing/selftests/lsm/common.c
index 927dce4f04cb..e7d5cdb10137 100644
--- a/tools/testing/selftests/lsm/common.c
+++ b/tools/testing/selftests/lsm/common.c
@@ -7,6 +7,7 @@
 
 #define _GNU_SOURCE
 #include <linux/lsm.h>
+#include <errno.h>
 #include <fcntl.h>
 #include <string.h>
 #include <stdio.h>
@@ -50,23 +51,39 @@ int read_proc_attr(const char *attr, char *value, size_t size)
 	return 0;
 }
 
-int read_sysfs_lsms(char *lsms, size_t size)
+int read_file(const char *path, char *buf, size_t size)
 {
-	FILE *fp;
-	size_t red;
+	ssize_t len;
+	int fd;
 
-	fp = fopen("/sys/kernel/security/lsm", "r");
-	if (fp == NULL)
+	if (!size) {
+		errno = EINVAL;
 		return -1;
-	red = fread(lsms, 1, size, fp);
-	fclose(fp);
+	}
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return -1;
+
+	len = read(fd, buf, size - 1);
+	if (len < 0) {
+		int err = errno;
 
-	if (red <= 0 || red == size)
+		close(fd);
+		errno = err;
 		return -1;
-	lsms[red] = '\0';
+	}
+
+	close(fd);
+	buf[len] = '\0';
 	return 0;
 }
 
+int read_sysfs_lsms(char *lsms, size_t size)
+{
+	return read_file("/sys/kernel/security/lsm", lsms, size);
+}
+
 int attr_lsm_count(void)
 {
 	char *names = calloc(sysconf(_SC_PAGESIZE), 1);
diff --git a/tools/testing/selftests/lsm/common.h b/tools/testing/selftests/lsm/common.h
index 06d12110d241..2f824de2d1ad 100644
--- a/tools/testing/selftests/lsm/common.h
+++ b/tools/testing/selftests/lsm/common.h
@@ -31,3 +31,5 @@ static inline int lsm_list_modules(__u64 *ids, __u32 *size, __u32 flags)
 extern int read_proc_attr(const char *attr, char *value, size_t size);
 extern int read_sysfs_lsms(char *lsms, size_t size);
 int attr_lsm_count(void);
+
+extern int read_file(const char *path, char *buf, size_t size);
diff --git a/tools/testing/selftests/lsm/config b/tools/testing/selftests/lsm/config
index 1c0c4c020f9c..f8704a4c58ad 100644
--- a/tools/testing/selftests/lsm/config
+++ b/tools/testing/selftests/lsm/config
@@ -1,3 +1,4 @@
 CONFIG_SYSFS=y
 CONFIG_SECURITY=y
 CONFIG_SECURITYFS=y
+CONFIG_SECURITY_LOCKDOWN_LSM=y
diff --git a/tools/testing/selftests/lsm/lockdown_test.c b/tools/testing/selftests/lsm/lockdown_test.c
new file mode 100644
index 000000000000..fed050551cff
--- /dev/null
+++ b/tools/testing/selftests/lsm/lockdown_test.c
@@ -0,0 +1,230 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Linux Security Module infrastructure tests
+ * Tests for the lockdown securityfs interface
+ */
+
+#define _GNU_SOURCE
+#include <linux/lsm.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include "kselftest_harness.h"
+#include "common.h"
+
+#define LOCKDOWN_PATH "/sys/kernel/security/lockdown"
+
+static int write_status(const char *value)
+{
+	ssize_t len;
+	int fd, err;
+
+	fd = open(LOCKDOWN_PATH, O_WRONLY);
+	if (fd < 0)
+		return -1;
+
+	len = write(fd, value, strlen(value));
+	err = errno;
+	close(fd);
+	if (len < 0) {
+		errno = err;
+		return -1;
+	}
+
+	return 0;
+}
+
+static int status_writable(void)
+{
+	int fd;
+
+	fd = open(LOCKDOWN_PATH, O_WRONLY);
+	if (fd < 0)
+		return -1;
+
+	close(fd);
+	return 0;
+}
+
+static int get_active_level(const char *buf, char *level, size_t size)
+{
+	const char *start, *end;
+	size_t len;
+
+	start = strchr(buf, '[');
+	if (!start)
+		return -1;
+	end = strchr(start, ']');
+	if (!end)
+		return -1;
+
+	len = end - start - 1;
+	if (len == 0 || len >= size)
+		return -1;
+
+	memcpy(level, start + 1, len);
+	level[len] = '\0';
+	return 0;
+}
+
+static int read_lockdown_status(char *buf, size_t size)
+{
+	if (!read_file(LOCKDOWN_PATH, buf, size))
+		return 0;
+
+	return errno == ENOENT ? 1 : -1;
+}
+
+TEST(lockdown_read_format)
+{
+	char buf[128], level[32];
+	int ret;
+
+	ret = read_lockdown_status(buf, sizeof(buf));
+	if (ret) {
+		if (ret > 0)
+			SKIP(return, "%s is not present", LOCKDOWN_PATH);
+		TH_LOG("cannot read %s: %s", LOCKDOWN_PATH, strerror(errno));
+		ASSERT_EQ(0, ret);
+	}
+
+	ASSERT_NE(NULL, strstr(buf, "none"));
+	ASSERT_NE(NULL, strstr(buf, "integrity"));
+	ASSERT_NE(NULL, strstr(buf, "confidentiality"));
+
+	ASSERT_EQ(0, get_active_level(buf, level, sizeof(level)));
+	ASSERT_TRUE(!strcmp(level, "none") ||
+		    !strcmp(level, "integrity") ||
+		    !strcmp(level, "confidentiality"));
+}
+
+TEST(lockdown_invalid_write)
+{
+	char before[128], after[128];
+	int ret;
+
+	ret = read_lockdown_status(before, sizeof(before));
+	if (ret) {
+		if (ret > 0)
+			SKIP(return, "%s is not present", LOCKDOWN_PATH);
+		TH_LOG("cannot read %s: %s", LOCKDOWN_PATH, strerror(errno));
+		ASSERT_EQ(0, ret);
+	}
+	if (geteuid() != 0)
+		SKIP(return, "requires root");
+	if (status_writable())
+		SKIP(return, "cannot open %s for writing: %s",
+		     LOCKDOWN_PATH, strerror(errno));
+
+	errno = 0;
+	ASSERT_EQ(-1, write_status("invalid-level"));
+	ASSERT_EQ(EINVAL, errno);
+
+	ASSERT_EQ(0, read_file(LOCKDOWN_PATH, after, sizeof(after)));
+	ASSERT_STREQ(before, after);
+}
+
+TEST(lockdown_no_downgrade)
+{
+	char before[128], after[128], level[32];
+	const char *lower;
+	int ret;
+
+	ret = read_lockdown_status(before, sizeof(before));
+	if (ret) {
+		if (ret > 0)
+			SKIP(return, "%s is not present", LOCKDOWN_PATH);
+		TH_LOG("cannot read %s: %s", LOCKDOWN_PATH, strerror(errno));
+		ASSERT_EQ(0, ret);
+	}
+	if (geteuid() != 0)
+		SKIP(return, "requires root");
+	if (status_writable())
+		SKIP(return, "cannot open %s for writing: %s",
+		     LOCKDOWN_PATH, strerror(errno));
+	ASSERT_EQ(0, get_active_level(before, level, sizeof(level)));
+
+	if (!strcmp(level, "confidentiality"))
+		lower = "integrity";
+	else if (!strcmp(level, "integrity"))
+		lower = "none";
+	else
+		SKIP(return, "kernel is not locked down, nothing to downgrade");
+
+	errno = 0;
+	ASSERT_EQ(-1, write_status(lower));
+	ASSERT_EQ(EPERM, errno);
+
+	ASSERT_EQ(0, read_file(LOCKDOWN_PATH, after, sizeof(after)));
+	ASSERT_STREQ(before, after);
+}
+
+TEST(lockdown_same_level_rejected)
+{
+	char before[128], after[128], level[32];
+	int ret;
+
+	ret = read_lockdown_status(before, sizeof(before));
+	if (ret) {
+		if (ret > 0)
+			SKIP(return, "%s is not present", LOCKDOWN_PATH);
+		TH_LOG("cannot read %s: %s", LOCKDOWN_PATH, strerror(errno));
+		ASSERT_EQ(0, ret);
+	}
+	if (geteuid() != 0)
+		SKIP(return, "requires root");
+	if (status_writable())
+		SKIP(return, "cannot open %s for writing: %s",
+		     LOCKDOWN_PATH, strerror(errno));
+	ASSERT_EQ(0, get_active_level(before, level, sizeof(level)));
+
+	errno = 0;
+	ASSERT_EQ(-1, write_status(level));
+	ASSERT_EQ(EPERM, errno);
+
+	ASSERT_EQ(0, read_file(LOCKDOWN_PATH, after, sizeof(after)));
+	ASSERT_STREQ(before, after);
+}
+
+/*
+ * This test raises the lockdown level and cannot undo it, so run it last.
+ */
+TEST(lockdown_upgrade)
+{
+	char before[128], after[128], level[32];
+	const char *next;
+	int ret;
+
+	ret = read_lockdown_status(before, sizeof(before));
+	if (ret) {
+		if (ret > 0)
+			SKIP(return, "%s is not present", LOCKDOWN_PATH);
+		TH_LOG("cannot read %s: %s", LOCKDOWN_PATH, strerror(errno));
+		ASSERT_EQ(0, ret);
+	}
+	if (geteuid() != 0)
+		SKIP(return, "requires root");
+	if (status_writable())
+		SKIP(return, "cannot open %s for writing: %s",
+		     LOCKDOWN_PATH, strerror(errno));
+	ASSERT_EQ(0, get_active_level(before, level, sizeof(level)));
+
+	if (!strcmp(level, "none"))
+		next = "integrity";
+	else if (!strcmp(level, "integrity"))
+		next = "confidentiality";
+	else
+		SKIP(return, "kernel is already at the highest level");
+
+	errno = 0;
+	ASSERT_EQ(0, write_status(next));
+
+	ASSERT_EQ(0, read_file(LOCKDOWN_PATH, after, sizeof(after)));
+	ASSERT_EQ(0, get_active_level(after, level, sizeof(level)));
+	ASSERT_STREQ(next, level);
+}
+
+TEST_HARNESS_MAIN
-- 
2.18.0.huawei.25

