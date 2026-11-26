Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.220
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795697244;
	b=Oo5KDYY4blDH+2buJro/eMKarfktUWt5kjlo2IqPS85JrIgWlXpVitPIni6Gx9xOGwZW
	 8U2gRz+O7j8IecMDazgxbwrbxoF6NxyhhMVot0xuJBKPbmkNXv7JCyFxHzAVClDWNW8Lc
	 gQKOI7uLlDDWvO3vOw+fFle3I+WVwK/wjgIvODyla5EOUyw8mTUnXky74yqcYl2P2SHZP
	 e2tgo2yZXAYTjWPrN24L91m9l/1QfZxIlz/uRd+H32Zfrz3zzhhqtMA8w4qm0poPcrPuj
	 GQVTOzX7orpRdNCJpQXEGq3l/8/PQ2LKOI/wGKaVECWmdLI8M/HRwpPg4xSrjWCQEGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795697244;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy;
	bh=9vmW46yLisqFTv2BeB2pX4mXx9Hct1Zvh3ctPnSR220=;
	b=Bv65ioMtztCtafMMQUh1tesuIFk11Q/DSIEfIFJ8/asRD+rYF+itor6kMqonSmiMi5XN
	 3r5t2PsnSB72DjAaNNDbbJS3PtcB1l1k0vTiSi9HXD247c3P7lgZYMemen1nnWgu3oBsF
	 /U/l4FZ8c3m19sUNeWeNE8EW2dsa083uGfBCcjXrEriHT36zcMs4Q4EAsvEHEuOL1iaG6
	 K9+Nr8mRXkC35WI2PPxUoDRj0ZHSGdNsVrsOakwbgeMWcxKx8hW3RzcDIrfzAz2UT1kYY
	 VGIoYZhuEfha9JC0mmfGU8GLeuiV5qLUMofrqbZZ1AMQHwx4ZBdTgu8+0vvN6T7UFPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=IryGkcVT;
	arc=none smtp.remote-ip=113.46.200.220
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB1460A261B;
	Thu, 26 Nov 2026 12:47:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EB1460A261B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=IryGkcVT
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=9vmW46yLisqFTv2BeB2pX4mXx9Hct1Zvh3ctPnSR220=;
	b=IryGkcVTwHTHQ3S+P+MhvqFunrarz2dnZdda/vfSUo/znL0+2/85O8oiHH6Bmt3M6w6zJypaV
	V3WRiVZ67UshwCs1IjnMGg66iqhsyl/CguBCvOxMuTqkXTeN/2q/QDfSVAKmF31RYiQAErncvn9
	y1jYI0Meb4NAHmTboU4Fc3E=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4jZxBK5RJNz12LDD;
	Thu, 26 Nov 2026 20:46:33 +0800 (CST)
Received: from whupemk100010.china.huawei.com (unknown [7.152.184.41])
	by mail.maildlp.com (Postfix) with ESMTPS id 40E774057D;
	Thu, 26 Nov 2026 20:47:21 +0800 (CST)
Received: from octopus.huawei.com (10.67.174.191) by
 whupemk100010.china.huawei.com (7.152.184.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 26 Nov 2026 20:47:19 +0800
From: Cai Xinchen <caixinchen1@huawei.com>
To: <nicolas.bouchinet@oss.cyber.gouv.fr>, <xiujianfeng@huawei.com>,
	<paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
	<shuah@kernel.org>, <kalevi@kolttonen.fi>, <caixinchen1@huawei.com>
CC: <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <bpf@vger.kernel.org>,
	<lujialin4@huawei.com>
Subject: [PATCH v3 8/8] selftests/lsm: add lockdown securityfs test
Date: Thu, 26 Nov 2026 21:13:15 +0800
Message-ID: <20261126131315.1256553-9-caixinchen1@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
In-Reply-To: <20261126131315.1256553-1-caixinchen1@huawei.com>
References: <20261126131315.1256553-1-caixinchen1@huawei.com>
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
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 whupemk100010.china.huawei.com (7.152.184.41)

Add a kselftest for the lockdown securityfs interface.  It checks the
read format, rejects unknown levels, verifies that an already locked
down kernel neither accepts the current level nor a lower one, and
checks that the level can be upgraded.  The test skips itself when
lockdown is not enabled, when not run as root, or when the file cannot
be opened for writing.

The upgrade test irreversibly raises the lockdown level, so the test is
built but not run by default; run "make run_lockdown_test" to execute
it, preferably on a disposable test system.  It runs before the tests
that expect an already locked down kernel, so they do not run at the
none level.

Enable CONFIG_SECURITY_LOCKDOWN_LSM in the selftest config fragment so
that the test has something to exercise.

Use the shared file read helper from common.c instead of duplicating
it, and share the read, root and writable checks between the tests
through a fixture setup.

Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>
---
 tools/testing/selftests/lsm/Makefile        |   8 +
 tools/testing/selftests/lsm/common.c        |  47 ++++-
 tools/testing/selftests/lsm/common.h        |   2 +
 tools/testing/selftests/lsm/config          |   1 +
 tools/testing/selftests/lsm/lockdown_test.c | 191 ++++++++++++++++++++
 5 files changed, 240 insertions(+), 9 deletions(-)
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
index 927dce4f04cb..aa01203a65f9 100644
--- a/tools/testing/selftests/lsm/common.c
+++ b/tools/testing/selftests/lsm/common.c
@@ -7,6 +7,7 @@
 
 #define _GNU_SOURCE
 #include <linux/lsm.h>
+#include <errno.h>
 #include <fcntl.h>
 #include <string.h>
 #include <stdio.h>
@@ -50,23 +51,51 @@ int read_proc_attr(const char *attr, char *value, size_t size)
 	return 0;
 }
 
-int read_sysfs_lsms(char *lsms, size_t size)
+int read_file(const char *path, char *buf, size_t size)
 {
-	FILE *fp;
-	size_t red;
+	ssize_t len;
+	int fd;
+
+	if (!size) {
+		errno = EINVAL;
+		return -1;
+	}
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return -1;
 
-	fp = fopen("/sys/kernel/security/lsm", "r");
-	if (fp == NULL)
+	len = read(fd, buf, size);
+	if (len < 0) {
+		int err = errno;
+
+		close(fd);
+		errno = err;
 		return -1;
-	red = fread(lsms, 1, size, fp);
-	fclose(fp);
+	}
+
+	close(fd);
 
-	if (red <= 0 || red == size)
+	/*
+	 * An empty file is not a valid status string, and a completely
+	 * filled buffer means the string did not fit: no room is left
+	 * for the terminating NUL.  Fail in both cases, like the
+	 * previous read_sysfs_lsms() implementation did.
+	 */
+	if (!len || len == (ssize_t)size) {
+		errno = EOVERFLOW;
 		return -1;
-	lsms[red] = '\0';
+	}
+
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
index 000000000000..70337dd76223
--- /dev/null
+++ b/tools/testing/selftests/lsm/lockdown_test.c
@@ -0,0 +1,191 @@
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
+FIXTURE(lockdown)
+{
+	char status[128];
+	char level[32];
+};
+
+FIXTURE_SETUP(lockdown)
+{
+	int ret;
+
+	ret = read_lockdown_status(self->status, sizeof(self->status));
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
+	ASSERT_EQ(0, get_active_level(self->status, self->level,
+				      sizeof(self->level)));
+}
+
+FIXTURE_TEARDOWN(lockdown)
+{
+}
+
+TEST_F(lockdown, read_format)
+{
+	ASSERT_NE(NULL, strstr(self->status, "none"));
+	ASSERT_NE(NULL, strstr(self->status, "integrity"));
+	ASSERT_NE(NULL, strstr(self->status, "confidentiality"));
+
+	ASSERT_TRUE(!strcmp(self->level, "none") ||
+		    !strcmp(self->level, "integrity") ||
+		    !strcmp(self->level, "confidentiality"));
+}
+
+TEST_F(lockdown, invalid_write)
+{
+	char after[128];
+
+	errno = 0;
+	ASSERT_EQ(-1, write_status("invalid-level"));
+	ASSERT_EQ(EINVAL, errno);
+
+	ASSERT_EQ(0, read_file(LOCKDOWN_PATH, after, sizeof(after)));
+	ASSERT_STREQ(self->status, after);
+}
+
+/*
+ * This test raises the lockdown level and cannot undo it, so it runs
+ * before the tests that expect an already locked down kernel.
+ */
+TEST_F(lockdown, upgrade)
+{
+	const char *next;
+	char after[128], level[32];
+
+	if (!strcmp(self->level, "none"))
+		next = "integrity";
+	else if (!strcmp(self->level, "integrity"))
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
+TEST_F(lockdown, same_level_rejected)
+{
+	char after[128];
+
+	errno = 0;
+	ASSERT_EQ(-1, write_status(self->level));
+	ASSERT_EQ(EPERM, errno);
+
+	ASSERT_EQ(0, read_file(LOCKDOWN_PATH, after, sizeof(after)));
+	ASSERT_STREQ(self->status, after);
+}
+
+TEST_F(lockdown, no_downgrade)
+{
+	const char *lower;
+	char after[128];
+
+	if (!strcmp(self->level, "confidentiality"))
+		lower = "integrity";
+	else if (!strcmp(self->level, "integrity"))
+		lower = "none";
+	else
+		SKIP(return, "kernel is not locked down, nothing to downgrade");
+
+	errno = 0;
+	ASSERT_EQ(-1, write_status(lower));
+	ASSERT_EQ(EPERM, errno);
+
+	ASSERT_EQ(0, read_file(LOCKDOWN_PATH, after, sizeof(after)));
+	ASSERT_STREQ(self->status, after);
+}
+
+TEST_HARNESS_MAIN
-- 
2.18.0.huawei.25

