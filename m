Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793692293;
	b=hrvi7SPIoaz/X5NIPQGgyh90QBQzSdGVWAD2buKiy4SOpjQBgU4PtSXBipzF2x9RT4Jo
	 OUB8lXtfZtbgL43ljOFy+j2Zs3X2roIxCxJjcsX2K85nBE5TxXz2Qdb0zXBs4I0tJYl5d
	 AGQ4Y05O4D4Jzn18rpZNzlMQrwI1g2r95PM5S13gz99HnPCrZzveYpDKIEqsyl2GiwlLc
	 I6ld+zCWw9yi8xDYd6iH//W1uReNUn85YG3GgDzTTkb3v7yI0477KPAcx8VcaLbryRbMZ
	 hYuFpfCPXPiAr7hOGMys8SIIplOVfJEyAYY4arBx1b8zK1M4adk18QQuiSannA1DRnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793692293;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy;
	bh=KIP85lJts2az258btkcwCPddnlpfAN3ilQdc6gKXSHY=;
	b=b/xc/PQbmdykBYLm4XYfogMPqbaV6yI4+myX8y/fShFV4BA2TO0JEfnymHET6HmBWVR6
	 vw6qb6lH+hA95FpAHOB33yRNgc1LbACXml1u50yUsGuXTbLC0N8lZZv2B8MTEc97qZgX+
	 EvyGE3/XJTxaZQLmxVZedzivf5QV8Gwmh4+xKgCk7GuNuWX+RHExNeXD9n16ECDnUgL75
	 0TySyF4/ej2xT9fIGtj1myqSz2lEhli2bYgPKkQArTaMJWHVOlqchvfEpegXVzYK7SJbS
	 NbXQvxIHllp0Eq2kq7hsWZWO7CQx3MUh9gS6DFDupULW0Ge6ixl+gN8CnANM29+Uwyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=n8Is5aZ7;
	arc=none smtp.remote-ip=113.46.200.226
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86EF606A32F;
	Tue,  3 Nov 2026 07:51:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C86EF606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=n8Is5aZ7
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=KIP85lJts2az258btkcwCPddnlpfAN3ilQdc6gKXSHY=;
	b=n8Is5aZ71EKtW+LJTLP5QzCTwnaMoYR7YmcPZ2Al/n9rkAdlGuuN3K1MO5QURwb8tpBhDjnO6
	hayTlaBL3wnQzazSvkRP8NMZP3Py8/Ppl7NQCHyEmWROFGUQ1MZt8Ytt0q/aGbQnGP2MDSiwhRB
	Wt8OkG//dpZZbwtb24djGaE=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4jJgkK2JstzKmVT;
	Tue,  3 Nov 2026 15:51:21 +0800 (CST)
Received: from whupemk100010.china.huawei.com (unknown [7.152.184.41])
	by mail.maildlp.com (Postfix) with ESMTPS id 479AB40578;
	Tue,  3 Nov 2026 15:51:26 +0800 (CST)
Received: from octopus.huawei.com (10.67.174.191) by
 whupemk100010.china.huawei.com (7.152.184.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 3 Nov 2026 15:51:25 +0800
From: Cai Xinchen <caixinchen1@huawei.com>
To: <nicolas.bouchinet@oss.cyber.gouv.fr>, <xiujianfeng@huawei.com>,
	<paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
	<shuah@kernel.org>, <caixinchen1@huawei.com>
CC: <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <bpf@vger.kernel.org>,
	<lujialin4@huawei.com>
Subject: [PATCH -next 9/9] selftests/lsm: add lockdown securityfs test
Date: Tue, 3 Nov 2026 16:24:21 +0800
Message-ID: <20261103082421.3033195-10-caixinchen1@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
In-Reply-To: <20261103082421.3033195-1-caixinchen1@huawei.com>
References: <20261103082421.3033195-1-caixinchen1@huawei.com>
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
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 whupemk100010.china.huawei.com (7.152.184.41)

Add a kselftest for the lockdown securityfs interface.  It checks the
read format, rejects unknown levels, and verifies that an already locked
down kernel neither accepts the current level nor a lower one.  The test
skips itself when lockdown is not enabled, when not run as root, or when
the file cannot be opened for writing, and it never escalates lockdown
on the test machine.

Use the shared file read helper from common.c instead of duplicating it.

Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>
---
 tools/testing/selftests/lsm/Makefile        |   3 +-
 tools/testing/selftests/lsm/common.c        |  35 +++-
 tools/testing/selftests/lsm/common.h        |   2 +
 tools/testing/selftests/lsm/lockdown_test.c | 176 ++++++++++++++++++++
 4 files changed, 206 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/lsm/lockdown_test.c

diff --git a/tools/testing/selftests/lsm/Makefile b/tools/testing/selftests/lsm/Makefile
index 3f80c0bc093d..737e8686bb7d 100644
--- a/tools/testing/selftests/lsm/Makefile
+++ b/tools/testing/selftests/lsm/Makefile
@@ -6,12 +6,13 @@ CFLAGS += -Wall -O2 $(KHDR_INCLUDES)
 LOCAL_HDRS += common.h
 
 TEST_GEN_PROGS := lsm_get_self_attr_test lsm_list_modules_test \
-		  lsm_set_self_attr_test
+		  lsm_set_self_attr_test lockdown_test
 
 include ../lib.mk
 
 $(OUTPUT)/lsm_get_self_attr_test: lsm_get_self_attr_test.c common.c
 $(OUTPUT)/lsm_set_self_attr_test: lsm_set_self_attr_test.c common.c
 $(OUTPUT)/lsm_list_modules_test: lsm_list_modules_test.c common.c
+$(OUTPUT)/lockdown_test: lockdown_test.c common.c
 
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
diff --git a/tools/testing/selftests/lsm/lockdown_test.c b/tools/testing/selftests/lsm/lockdown_test.c
new file mode 100644
index 000000000000..35109833da37
--- /dev/null
+++ b/tools/testing/selftests/lsm/lockdown_test.c
@@ -0,0 +1,176 @@
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
+TEST(lockdown_read_format)
+{
+	char buf[128], level[32];
+
+	if (read_file(LOCKDOWN_PATH, buf, sizeof(buf))) {
+		if (errno == ENOENT)
+			SKIP(return, "%s is not present", LOCKDOWN_PATH);
+		SKIP(return, "cannot read %s: %s", LOCKDOWN_PATH,
+		     strerror(errno));
+	}
+
+	ASSERT_EQ(0, get_active_level(buf, level, sizeof(level)));
+	ASSERT_TRUE(!strcmp(level, "none") ||
+		    !strcmp(level, "integrity") ||
+		    !strcmp(level, "confidentiality"));
+
+	ASSERT_NE(NULL, strstr(buf, "none"));
+	ASSERT_NE(NULL, strstr(buf, "integrity"));
+	ASSERT_NE(NULL, strstr(buf, "confidentiality"));
+}
+
+TEST(lockdown_invalid_write)
+{
+	char before[128], after[128];
+
+	if (read_file(LOCKDOWN_PATH, before, sizeof(before))) {
+		if (errno == ENOENT)
+			SKIP(return, "%s is not present", LOCKDOWN_PATH);
+		SKIP(return, "cannot read %s: %s", LOCKDOWN_PATH,
+		     strerror(errno));
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
+
+	if (read_file(LOCKDOWN_PATH, before, sizeof(before))) {
+		if (errno == ENOENT)
+			SKIP(return, "%s is not present", LOCKDOWN_PATH);
+		SKIP(return, "cannot read %s: %s", LOCKDOWN_PATH,
+		     strerror(errno));
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
+		SKIP(return, "kernel is not locked down, refusing to escalate");
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
+
+	if (read_file(LOCKDOWN_PATH, before, sizeof(before))) {
+		if (errno == ENOENT)
+			SKIP(return, "%s is not present", LOCKDOWN_PATH);
+		SKIP(return, "cannot read %s: %s", LOCKDOWN_PATH,
+		     strerror(errno));
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
+TEST_HARNESS_MAIN
-- 
2.18.0.huawei.25

