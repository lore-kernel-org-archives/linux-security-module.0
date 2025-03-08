Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch [185.125.25.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA5C219A74
	for <linux-security-module@vger.kernel.org>; Sat,  8 Mar 2025 18:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741459515; cv=none; b=T8FggC9wQldBsl1JhqGMviGnQ/C8W5q1v81WcmkCkTUjss53BU1+RhaenpxUD0e4tvC/H9dedknXg5E8JhcYeZPL8Mj1y44l+BUcCa4D+XuNmJCE7Mg3Z/PESwPF7is1J+bL0c66P0hAcB1vqM+L5v0/b7rUSyBoWYOWzLLgXIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741459515; c=relaxed/simple;
	bh=9LDxuRU8reoAJoy4A38nJFBJq/kT7oF+bhSaK4+C/3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NBiFxSuj5wgiFm2InLYRINYo4FJZOzGgsiXDfzyH+G/wxjEa695JfUZ2ITsmVu/hOMyWp0lgkwaAQif8W11PNlPxs9tfleKgPR7gqJJTfbx+cRaODEiXIJ0SUOsnD33YTq7+c7VIedeZ0i2dIMso+WGvd98YllvZFhBRN6ykSy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=cfPOoDAr; arc=none smtp.client-ip=185.125.25.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="cfPOoDAr"
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:0])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Z9Bsz22xdzShN;
	Sat,  8 Mar 2025 19:45:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1741459511;
	bh=7CG5muF+gwo8MsmFi5DT4xu/AZ64anUvZy1IoiAepOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cfPOoDArctk1RV+L8y67FHJvVoHHaqH9+Ey0scTBc7tAtzs59TxS/ixKZ2KcrOV8V
	 KeZA5VvXYEV3lkm2NvjjcGIP+Ceb3aGqWYMTYPOJUGsTztaMTWiS77H7KV1xDGzP3h
	 ha2X1ELgarkqUmt0lgeozSEynopXUKKnxgqSqW1c=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Z9Bsy0DfWzKf2;
	Sat,  8 Mar 2025 19:45:10 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Eric Paris <eparis@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Ben Scarlato <akhna@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Charles Zaffery <czaffery@roblox.com>,
	Daniel Burgener <dburgener@linux.microsoft.com>,
	Francis Laniel <flaniel@linux.microsoft.com>,
	James Morris <jmorris@namei.org>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Jorge Lucangeli Obes <jorgelo@google.com>,
	Kees Cook <kees@kernel.org>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Phil Sutter <phil@nwl.cc>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Robert Salvet <robert.salvet@roblox.com>,
	Shervin Oloumi <enlightened@google.com>,
	Song Liu <song@kernel.org>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Tingmao Wang <m@maowtm.org>,
	Tyler Hicks <code@tyhicks.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v6 25/26] selftests/landlock: Add audit tests for filesystem
Date: Sat,  8 Mar 2025 19:44:21 +0100
Message-ID: <20250308184422.2159360-26-mic@digikod.net>
In-Reply-To: <20250308184422.2159360-1-mic@digikod.net>
References: <20250308184422.2159360-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Test all filesystem blockers, including events with several records, and
record with several blockers:
- fs.execute
- fs.write_file
- fs.read_file
- fs_read_dir
- fs.remove_dir
- fs.remove_file
- fs.make_char
- fs.make_dir
- fs.make_reg
- fs.make_sock
- fs.make_fifo
- fs.make_block
- fs.make_sym
- fs.refer
- fs.truncate
- fs.ioctl_dev

Test coverage for security/landlock is 93.4% of 1407 lines according to
gcc/gcov-14.

Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20250308184422.2159360-26-mic@digikod.net
---

Changes since v5:
- New patch.
---
 tools/testing/selftests/landlock/audit.h   |  39 ++
 tools/testing/selftests/landlock/common.h  |  16 +
 tools/testing/selftests/landlock/fs_test.c | 455 +++++++++++++++++++++
 3 files changed, 510 insertions(+)

diff --git a/tools/testing/selftests/landlock/audit.h b/tools/testing/selftests/landlock/audit.h
index b3b3e52e8256..d84a88ff6535 100644
--- a/tools/testing/selftests/landlock/audit.h
+++ b/tools/testing/selftests/landlock/audit.h
@@ -22,6 +22,10 @@
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
 #endif
 
+#ifndef __maybe_unused
+#define __maybe_unused __attribute__((__unused__))
+#endif
+
 #define REGEX_LANDLOCK_PREFIX "^audit([0-9.:]\\+): domain=\\([0-9a-f]\\+\\)"
 
 struct audit_filter {
@@ -188,6 +192,41 @@ static int audit_set_status(int fd, __u32 key, __u32 val)
 	return audit_request(fd, &msg, NULL);
 }
 
+/* Returns a pointer to the last filled character of @dst, which is `\0`.  */
+static __maybe_unused char *regex_escape(const char *const src, char *dst,
+					 size_t dst_size)
+{
+	char *d = dst;
+
+	for (const char *s = src; *s; s++) {
+		switch (*s) {
+		case '$':
+		case '*':
+		case '.':
+		case '[':
+		case '\\':
+		case ']':
+		case '^':
+			if (d >= dst + dst_size - 2)
+				return (char *)-ENOMEM;
+
+			*d++ = '\\';
+			*d++ = *s;
+			break;
+		default:
+			if (d >= dst + dst_size - 1)
+				return (char *)-ENOMEM;
+
+			*d++ = *s;
+		}
+	}
+	if (d >= dst + dst_size - 1)
+		return (char *)-ENOMEM;
+
+	*d = '\0';
+	return d;
+}
+
 /*
  * @domain_id: The domain ID extracted from the audit message (if the first part
  * of @pattern is REGEX_LANDLOCK_PREFIX).  It is set to 0 if the domain ID is
diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/selftests/landlock/common.h
index c0a2d0b36217..ddcd8d00aeb3 100644
--- a/tools/testing/selftests/landlock/common.h
+++ b/tools/testing/selftests/landlock/common.h
@@ -207,6 +207,22 @@ enforce_ruleset(struct __test_metadata *const _metadata, const int ruleset_fd)
 	}
 }
 
+static void __maybe_unused
+drop_access_rights(struct __test_metadata *const _metadata,
+		   const struct landlock_ruleset_attr *const ruleset_attr)
+{
+	int ruleset_fd;
+
+	ruleset_fd =
+		landlock_create_ruleset(ruleset_attr, sizeof(*ruleset_attr), 0);
+	EXPECT_LE(0, ruleset_fd)
+	{
+		TH_LOG("Failed to create a ruleset: %s", strerror(errno));
+	}
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+}
+
 struct protocol_variant {
 	int domain;
 	int type;
diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index aa6f2c1cbec7..873d38efdad7 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -41,6 +41,7 @@
 #define _ASM_GENERIC_FCNTL_H
 #include <linux/fcntl.h>
 
+#include "audit.h"
 #include "common.h"
 
 #ifndef renameat2
@@ -5554,4 +5555,458 @@ TEST_F_FORK(layout3_fs, release_inodes)
 	ASSERT_EQ(EACCES, test_open(TMP_DIR, O_RDONLY));
 }
 
+static int matches_log_fs_extra(struct __test_metadata *const _metadata,
+				int audit_fd, const char *const blockers,
+				const char *const path, const char *const extra)
+{
+	static const char log_template[] = REGEX_LANDLOCK_PREFIX
+		" blockers=fs\\.%s path=\"%s\" dev=\"[^\"]\\+\" ino=[0-9]\\+$";
+	char *absolute_path = NULL;
+	size_t log_match_remaining = sizeof(log_template) + strlen(blockers) +
+				     PATH_MAX * 2 +
+				     (extra ? strlen(extra) : 0) + 1;
+	char log_match[log_match_remaining];
+	char *log_match_cursor = log_match;
+	size_t chunk_len;
+
+	chunk_len = snprintf(log_match_cursor, log_match_remaining,
+			     REGEX_LANDLOCK_PREFIX " blockers=%s path=\"",
+			     blockers);
+	if (chunk_len < 0 || chunk_len >= log_match_remaining)
+		return -E2BIG;
+
+	absolute_path = realpath(path, NULL);
+	if (!absolute_path)
+		return -errno;
+
+	log_match_remaining -= chunk_len;
+	log_match_cursor += chunk_len;
+	log_match_cursor = regex_escape(absolute_path, log_match_cursor,
+					log_match_remaining);
+	free(absolute_path);
+	if (log_match_cursor < 0)
+		return (long long)log_match_cursor;
+
+	log_match_remaining -= log_match_cursor - log_match;
+	chunk_len = snprintf(log_match_cursor, log_match_remaining,
+			     "\" dev=\"[^\"]\\+\" ino=[0-9]\\+%s$",
+			     extra ?: "");
+	if (chunk_len < 0 || chunk_len >= log_match_remaining)
+		return -E2BIG;
+
+	return audit_match_record(audit_fd, AUDIT_LANDLOCK_ACCESS, log_match,
+				  NULL);
+}
+
+static int matches_log_fs(struct __test_metadata *const _metadata, int audit_fd,
+			  const char *const blockers, const char *const path)
+{
+	return matches_log_fs_extra(_metadata, audit_fd, blockers, path, NULL);
+}
+
+FIXTURE(audit_layout1)
+{
+	struct audit_filter audit_filter;
+	int audit_fd;
+};
+
+FIXTURE_SETUP(audit_layout1)
+{
+	prepare_layout(_metadata);
+
+	create_layout1(_metadata);
+
+	set_cap(_metadata, CAP_AUDIT_CONTROL);
+	self->audit_fd = audit_init_with_exe_filter(&self->audit_filter);
+	EXPECT_LE(0, self->audit_fd);
+	drop_caps(_metadata);
+}
+
+FIXTURE_TEARDOWN_PARENT(audit_layout1)
+{
+	remove_layout1(_metadata);
+
+	cleanup_layout(_metadata);
+
+	EXPECT_EQ(0, audit_cleanup(-1, NULL));
+}
+
+TEST_F(audit_layout1, execute)
+{
+	struct audit_records records;
+
+	copy_file(_metadata, bin_true, file1_s1d1);
+	test_execute(_metadata, 0, file1_s1d1);
+	test_check_exec(_metadata, 0, file1_s1d1);
+
+	drop_access_rights(_metadata,
+			   &(struct landlock_ruleset_attr){
+				   .handled_access_fs =
+					   LANDLOCK_ACCESS_FS_EXECUTE,
+			   });
+
+	test_execute(_metadata, EACCES, file1_s1d1);
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.execute",
+				    file1_s1d1));
+
+	test_check_exec(_metadata, EACCES, file1_s1d1);
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.execute",
+				    file1_s1d1));
+
+	audit_count_records(self->audit_fd, &records);
+	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(0, records.domain);
+}
+
+TEST_F(audit_layout1, write_file)
+{
+	struct audit_records records;
+
+	drop_access_rights(_metadata,
+			   &(struct landlock_ruleset_attr){
+				   .handled_access_fs =
+					   LANDLOCK_ACCESS_FS_WRITE_FILE,
+			   });
+
+	EXPECT_EQ(EACCES, test_open(file1_s1d1, O_WRONLY));
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
+				    "fs\\.write_file", file1_s1d1));
+
+	audit_count_records(self->audit_fd, &records);
+	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(1, records.domain);
+}
+
+TEST_F(audit_layout1, read_file)
+{
+	struct audit_records records;
+
+	drop_access_rights(_metadata,
+			   &(struct landlock_ruleset_attr){
+				   .handled_access_fs =
+					   LANDLOCK_ACCESS_FS_READ_FILE,
+			   });
+
+	EXPECT_EQ(EACCES, test_open(file1_s1d1, O_RDONLY));
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.read_file",
+				    file1_s1d1));
+
+	audit_count_records(self->audit_fd, &records);
+	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(1, records.domain);
+}
+
+TEST_F(audit_layout1, read_dir)
+{
+	struct audit_records records;
+
+	drop_access_rights(_metadata,
+			   &(struct landlock_ruleset_attr){
+				   .handled_access_fs =
+					   LANDLOCK_ACCESS_FS_READ_DIR,
+			   });
+
+	EXPECT_EQ(EACCES, test_open(dir_s1d1, O_DIRECTORY));
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.read_dir",
+				    dir_s1d1));
+
+	audit_count_records(self->audit_fd, &records);
+	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(1, records.domain);
+}
+
+TEST_F(audit_layout1, remove_dir)
+{
+	struct audit_records records;
+
+	EXPECT_EQ(0, unlink(file1_s1d3));
+	EXPECT_EQ(0, unlink(file2_s1d3));
+
+	drop_access_rights(_metadata,
+			   &(struct landlock_ruleset_attr){
+				   .handled_access_fs =
+					   LANDLOCK_ACCESS_FS_REMOVE_DIR,
+			   });
+
+	EXPECT_EQ(-1, rmdir(dir_s1d3));
+	EXPECT_EQ(EACCES, errno);
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
+				    "fs\\.remove_dir", dir_s1d2));
+
+	EXPECT_EQ(-1, unlinkat(AT_FDCWD, dir_s1d3, AT_REMOVEDIR));
+	EXPECT_EQ(EACCES, errno);
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
+				    "fs\\.remove_dir", dir_s1d2));
+
+	audit_count_records(self->audit_fd, &records);
+	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(0, records.domain);
+}
+
+TEST_F(audit_layout1, remove_file)
+{
+	struct audit_records records;
+
+	drop_access_rights(_metadata,
+			   &(struct landlock_ruleset_attr){
+				   .handled_access_fs =
+					   LANDLOCK_ACCESS_FS_REMOVE_FILE,
+			   });
+
+	EXPECT_EQ(-1, unlink(file1_s1d3));
+	EXPECT_EQ(EACCES, errno);
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
+				    "fs\\.remove_file", dir_s1d3));
+
+	audit_count_records(self->audit_fd, &records);
+	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(1, records.domain);
+}
+
+TEST_F(audit_layout1, make_char)
+{
+	struct audit_records records;
+
+	EXPECT_EQ(0, unlink(file1_s1d3));
+
+	drop_access_rights(_metadata,
+			   &(struct landlock_ruleset_attr){
+				   .handled_access_fs =
+					   LANDLOCK_ACCESS_FS_MAKE_CHAR,
+			   });
+
+	EXPECT_EQ(-1, mknod(file1_s1d3, S_IFCHR | 0644, 0));
+	EXPECT_EQ(EACCES, errno);
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.make_char",
+				    dir_s1d3));
+
+	audit_count_records(self->audit_fd, &records);
+	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(1, records.domain);
+}
+
+TEST_F(audit_layout1, make_dir)
+{
+	struct audit_records records;
+
+	EXPECT_EQ(0, unlink(file1_s1d3));
+
+	drop_access_rights(_metadata,
+			   &(struct landlock_ruleset_attr){
+				   .handled_access_fs =
+					   LANDLOCK_ACCESS_FS_MAKE_DIR,
+			   });
+
+	EXPECT_EQ(-1, mkdir(file1_s1d3, 0755));
+	EXPECT_EQ(EACCES, errno);
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.make_dir",
+				    dir_s1d3));
+
+	audit_count_records(self->audit_fd, &records);
+	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(1, records.domain);
+}
+
+TEST_F(audit_layout1, make_reg)
+{
+	struct audit_records records;
+
+	EXPECT_EQ(0, unlink(file1_s1d3));
+
+	drop_access_rights(_metadata,
+			   &(struct landlock_ruleset_attr){
+				   .handled_access_fs =
+					   LANDLOCK_ACCESS_FS_MAKE_REG,
+			   });
+
+	EXPECT_EQ(-1, mknod(file1_s1d3, S_IFREG | 0644, 0));
+	EXPECT_EQ(EACCES, errno);
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.make_reg",
+				    dir_s1d3));
+
+	audit_count_records(self->audit_fd, &records);
+	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(1, records.domain);
+}
+
+TEST_F(audit_layout1, make_sock)
+{
+	struct audit_records records;
+
+	EXPECT_EQ(0, unlink(file1_s1d3));
+
+	drop_access_rights(_metadata,
+			   &(struct landlock_ruleset_attr){
+				   .handled_access_fs =
+					   LANDLOCK_ACCESS_FS_MAKE_SOCK,
+			   });
+
+	EXPECT_EQ(-1, mknod(file1_s1d3, S_IFSOCK | 0644, 0));
+	EXPECT_EQ(EACCES, errno);
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.make_sock",
+				    dir_s1d3));
+
+	audit_count_records(self->audit_fd, &records);
+	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(1, records.domain);
+}
+
+TEST_F(audit_layout1, make_fifo)
+{
+	struct audit_records records;
+
+	EXPECT_EQ(0, unlink(file1_s1d3));
+
+	drop_access_rights(_metadata,
+			   &(struct landlock_ruleset_attr){
+				   .handled_access_fs =
+					   LANDLOCK_ACCESS_FS_MAKE_FIFO,
+			   });
+
+	EXPECT_EQ(-1, mknod(file1_s1d3, S_IFIFO | 0644, 0));
+	EXPECT_EQ(EACCES, errno);
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.make_fifo",
+				    dir_s1d3));
+
+	audit_count_records(self->audit_fd, &records);
+	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(1, records.domain);
+}
+
+TEST_F(audit_layout1, make_block)
+{
+	struct audit_records records;
+
+	EXPECT_EQ(0, unlink(file1_s1d3));
+
+	drop_access_rights(_metadata,
+			   &(struct landlock_ruleset_attr){
+				   .handled_access_fs =
+					   LANDLOCK_ACCESS_FS_MAKE_BLOCK,
+			   });
+
+	EXPECT_EQ(-1, mknod(file1_s1d3, S_IFBLK | 0644, 0));
+	EXPECT_EQ(EACCES, errno);
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
+				    "fs\\.make_block", dir_s1d3));
+
+	audit_count_records(self->audit_fd, &records);
+	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(1, records.domain);
+}
+
+TEST_F(audit_layout1, make_sym)
+{
+	struct audit_records records;
+
+	EXPECT_EQ(0, unlink(file1_s1d3));
+
+	drop_access_rights(_metadata,
+			   &(struct landlock_ruleset_attr){
+				   .handled_access_fs =
+					   LANDLOCK_ACCESS_FS_MAKE_SYM,
+			   });
+
+	EXPECT_EQ(-1, symlink("target", file1_s1d3));
+	EXPECT_EQ(EACCES, errno);
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.make_sym",
+				    dir_s1d3));
+
+	audit_count_records(self->audit_fd, &records);
+	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(1, records.domain);
+}
+
+// TODO: Add refer_exchange
+TEST_F(audit_layout1, refer_handled)
+{
+	struct audit_records records;
+
+	EXPECT_EQ(0, unlink(file1_s1d3));
+
+	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
+					      .handled_access_fs =
+						      LANDLOCK_ACCESS_FS_REFER,
+				      });
+
+	EXPECT_EQ(-1, link(file1_s1d1, file1_s1d3));
+	EXPECT_EQ(EXDEV, errno);
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.refer",
+				    dir_s1d1));
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.refer",
+				    dir_s1d3));
+
+	audit_count_records(self->audit_fd, &records);
+	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(0, records.domain);
+}
+
+TEST_F(audit_layout1, refer_make)
+{
+	struct audit_records records;
+
+	EXPECT_EQ(0, unlink(file1_s1d3));
+
+	drop_access_rights(_metadata,
+			   &(struct landlock_ruleset_attr){
+				   .handled_access_fs =
+					   LANDLOCK_ACCESS_FS_MAKE_REG |
+					   LANDLOCK_ACCESS_FS_REFER,
+			   });
+
+	EXPECT_EQ(-1, link(file1_s1d1, file1_s1d3));
+	EXPECT_EQ(EACCES, errno);
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.refer",
+				    dir_s1d1));
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
+				    "fs\\.make_reg,fs\\.refer", dir_s1d3));
+
+	audit_count_records(self->audit_fd, &records);
+	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(0, records.domain);
+}
+
+TEST_F(audit_layout1, truncate)
+{
+	struct audit_records records;
+
+	drop_access_rights(_metadata,
+			   &(struct landlock_ruleset_attr){
+				   .handled_access_fs =
+					   LANDLOCK_ACCESS_FS_TRUNCATE,
+			   });
+
+	EXPECT_EQ(-1, truncate(file1_s1d3, 0));
+	EXPECT_EQ(EACCES, errno);
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.truncate",
+				    file1_s1d3));
+
+	audit_count_records(self->audit_fd, &records);
+	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(1, records.domain);
+}
+
+TEST_F(audit_layout1, ioctl_dev)
+{
+	struct audit_records records;
+	int fd;
+
+	drop_access_rights(_metadata,
+			   &(struct landlock_ruleset_attr){
+				   .handled_access_fs =
+					   LANDLOCK_ACCESS_FS_IOCTL_DEV,
+			   });
+
+	fd = open("/dev/null", O_RDWR | O_CLOEXEC);
+	ASSERT_LE(0, fd);
+	EXPECT_EQ(EACCES, ioctl_error(_metadata, fd, FIONREAD));
+	EXPECT_EQ(0, matches_log_fs_extra(_metadata, self->audit_fd,
+					  "fs\\.ioctl_dev", "/dev/null",
+					  " ioctlcmd=0x541b"));
+
+	audit_count_records(self->audit_fd, &records);
+	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(1, records.domain);
+}
+
 TEST_HARNESS_MAIN
-- 
2.48.1

