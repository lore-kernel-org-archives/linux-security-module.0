Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [185.125.25.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562C8229B3C
	for <linux-security-module@vger.kernel.org>; Thu, 20 Mar 2025 19:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742497690; cv=none; b=er1fXuCDQ/M2+TQJcgFmba+957UjYIzjQahPw4JKCE048Sbsfi75WMmw45dok4xNBCWmKymtf/3XQjgoL48Tm74pOgdYDOt7h7dZ2Is5tl30bHHg1px/IwrWqAbMVyG1yfsedXywc/V//QfJUCSbYVioagc0KPCsWNX9UWQBzd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742497690; c=relaxed/simple;
	bh=llAxyH2rc04bg55OSoGriL7EdVHgVfd/Sz72lTje0Ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RmchMiglwgdB9Pn7VusDZb544kx49AAVYoumhJpwf6enIQirCz+bnllP8IwxUMJipOe7fLAoInvgg9Xkt2Wzy4RH1GZEHl6k8J+lBr/Bib8mGZ6N7oqfQ4lWeKJepc2k/wDl/jPgyHxQUmaE4uPcYhXvHf4pt0g3TeDkpu3ZxUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=vmKP3loG; arc=none smtp.client-ip=185.125.25.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="vmKP3loG"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZJZps6vgxz1Jl;
	Thu, 20 Mar 2025 20:08:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1742497685;
	bh=iwqk7NYrXhgHM7Wx3NCCghBTb/VvlWEG4icbWaIxWZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vmKP3loGhR+VJVh0442n9Kun0gukj4fhCEnxoHcvYy2KwpeIvFY+lTWYNZmOirnyl
	 kriub66uGpYoDEGgiWlth+c97KlzUCCa2IXZbsokYADix4fSqxMN2jdtoPSJJu40fH
	 30yLAD7SG9RKBpU3fY8hFTuPT7j1hYRFK8kCo5+8=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZJZpr6mBlzCJ2;
	Thu, 20 Mar 2025 20:08:04 +0100 (CET)
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
	Matthieu Buffet <matthieu@buffet.re>,
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
Subject: [PATCH v7 26/28] selftests/landlock: Add audit tests for filesystem
Date: Thu, 20 Mar 2025 20:07:15 +0100
Message-ID: <20250320190717.2287696-27-mic@digikod.net>
In-Reply-To: <20250320190717.2287696-1-mic@digikod.net>
References: <20250320190717.2287696-1-mic@digikod.net>
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
- fs.change_topology

Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v6:
- Check audit_count_records() calls for audit errors.
- Add regression test for commit d617f0d72d80 ("landlock: Optimize file
  path walks and prepare for audit support").
- Add test_rename and test_exchange tests.
- Check domain allocation interwinded record.
- Add the execute_make test.
- Use a set of access rights instead of only one to make sure only the
  relevant access rights are blocked and logged.
- Add new audit_layout1.mount test.
- Add comments.

Changes since v5:
- New patch.
---
 tools/testing/selftests/landlock/audit.h   |  35 ++
 tools/testing/selftests/landlock/common.h  |  16 +
 tools/testing/selftests/landlock/fs_test.c | 594 +++++++++++++++++++++
 3 files changed, 645 insertions(+)

diff --git a/tools/testing/selftests/landlock/audit.h b/tools/testing/selftests/landlock/audit.h
index 08a5c53bd6f5..b9054086a0c9 100644
--- a/tools/testing/selftests/landlock/audit.h
+++ b/tools/testing/selftests/landlock/audit.h
@@ -208,6 +208,41 @@ static int audit_set_status(int fd, __u32 key, __u32 val)
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
index 6e1d143ddfa7..88a3c78f5d98 100644
--- a/tools/testing/selftests/landlock/common.h
+++ b/tools/testing/selftests/landlock/common.h
@@ -208,6 +208,22 @@ enforce_ruleset(struct __test_metadata *const _metadata, const int ruleset_fd)
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
index aa6f2c1cbec7..f819011a8798 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -41,6 +41,7 @@
 #define _ASM_GENERIC_FCNTL_H
 #include <linux/fcntl.h>
 
+#include "audit.h"
 #include "common.h"
 
 #ifndef renameat2
@@ -5554,4 +5555,597 @@ TEST_F_FORK(layout3_fs, release_inodes)
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
+	/*
+	 * It is assume that absolute_path does not contain control characters nor
+	 * spaces, see audit_string_contains_control().
+	 */
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
+	disable_caps(_metadata);
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
+TEST_F(audit_layout1, execute_make)
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
+	test_check_exec(_metadata, EACCES, file1_s1d1);
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.execute",
+				    file1_s1d1));
+
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(0, records.domain);
+}
+
+/*
+ * Using a set of handled/denied access rights make it possible to check that
+ * only the blocked ones are logged.
+ */
+
+/* clang-format off */
+static const __u64 access_fs_16 =
+	LANDLOCK_ACCESS_FS_EXECUTE |
+	LANDLOCK_ACCESS_FS_WRITE_FILE |
+	LANDLOCK_ACCESS_FS_READ_FILE |
+	LANDLOCK_ACCESS_FS_READ_DIR |
+	LANDLOCK_ACCESS_FS_REMOVE_DIR |
+	LANDLOCK_ACCESS_FS_REMOVE_FILE |
+	LANDLOCK_ACCESS_FS_MAKE_CHAR |
+	LANDLOCK_ACCESS_FS_MAKE_DIR |
+	LANDLOCK_ACCESS_FS_MAKE_REG |
+	LANDLOCK_ACCESS_FS_MAKE_SOCK |
+	LANDLOCK_ACCESS_FS_MAKE_FIFO |
+	LANDLOCK_ACCESS_FS_MAKE_BLOCK |
+	LANDLOCK_ACCESS_FS_MAKE_SYM |
+	LANDLOCK_ACCESS_FS_REFER |
+	LANDLOCK_ACCESS_FS_TRUNCATE |
+	LANDLOCK_ACCESS_FS_IOCTL_DEV;
+/* clang-format on */
+
+TEST_F(audit_layout1, execute_read)
+{
+	struct audit_records records;
+
+	copy_file(_metadata, bin_true, file1_s1d1);
+	test_execute(_metadata, 0, file1_s1d1);
+	test_check_exec(_metadata, 0, file1_s1d1);
+
+	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
+					      .handled_access_fs = access_fs_16,
+				      });
+
+	/*
+	 * The only difference with the previous audit_layout1.execute_read test is
+	 * the extra ",fs\\.read_file" blocked by the executable file.
+	 */
+	test_execute(_metadata, EACCES, file1_s1d1);
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
+				    "fs\\.execute,fs\\.read_file", file1_s1d1));
+	test_check_exec(_metadata, EACCES, file1_s1d1);
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
+				    "fs\\.execute,fs\\.read_file", file1_s1d1));
+
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(0, records.domain);
+}
+
+TEST_F(audit_layout1, write_file)
+{
+	struct audit_records records;
+
+	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
+					      .handled_access_fs = access_fs_16,
+				      });
+
+	EXPECT_EQ(EACCES, test_open(file1_s1d1, O_WRONLY));
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
+				    "fs\\.write_file", file1_s1d1));
+
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(1, records.domain);
+}
+
+TEST_F(audit_layout1, read_file)
+{
+	struct audit_records records;
+
+	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
+					      .handled_access_fs = access_fs_16,
+				      });
+
+	EXPECT_EQ(EACCES, test_open(file1_s1d1, O_RDONLY));
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.read_file",
+				    file1_s1d1));
+
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(1, records.domain);
+}
+
+TEST_F(audit_layout1, read_dir)
+{
+	struct audit_records records;
+
+	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
+					      .handled_access_fs = access_fs_16,
+				      });
+
+	EXPECT_EQ(EACCES, test_open(dir_s1d1, O_DIRECTORY));
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.read_dir",
+				    dir_s1d1));
+
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
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
+	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
+					      .handled_access_fs = access_fs_16,
+				      });
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
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(0, records.domain);
+}
+
+TEST_F(audit_layout1, remove_file)
+{
+	struct audit_records records;
+
+	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
+					      .handled_access_fs = access_fs_16,
+				      });
+
+	EXPECT_EQ(-1, unlink(file1_s1d3));
+	EXPECT_EQ(EACCES, errno);
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
+				    "fs\\.remove_file", dir_s1d3));
+
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
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
+	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
+					      .handled_access_fs = access_fs_16,
+				      });
+
+	EXPECT_EQ(-1, mknod(file1_s1d3, S_IFCHR | 0644, 0));
+	EXPECT_EQ(EACCES, errno);
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.make_char",
+				    dir_s1d3));
+
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
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
+	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
+					      .handled_access_fs = access_fs_16,
+				      });
+
+	EXPECT_EQ(-1, mkdir(file1_s1d3, 0755));
+	EXPECT_EQ(EACCES, errno);
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.make_dir",
+				    dir_s1d3));
+
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
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
+	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
+					      .handled_access_fs = access_fs_16,
+				      });
+
+	EXPECT_EQ(-1, mknod(file1_s1d3, S_IFREG | 0644, 0));
+	EXPECT_EQ(EACCES, errno);
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.make_reg",
+				    dir_s1d3));
+
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
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
+	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
+					      .handled_access_fs = access_fs_16,
+				      });
+
+	EXPECT_EQ(-1, mknod(file1_s1d3, S_IFSOCK | 0644, 0));
+	EXPECT_EQ(EACCES, errno);
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.make_sock",
+				    dir_s1d3));
+
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
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
+	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
+					      .handled_access_fs = access_fs_16,
+				      });
+
+	EXPECT_EQ(-1, mknod(file1_s1d3, S_IFIFO | 0644, 0));
+	EXPECT_EQ(EACCES, errno);
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.make_fifo",
+				    dir_s1d3));
+
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
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
+	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
+					      .handled_access_fs = access_fs_16,
+				      });
+
+	EXPECT_EQ(-1, mknod(file1_s1d3, S_IFBLK | 0644, 0));
+	EXPECT_EQ(EACCES, errno);
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
+				    "fs\\.make_block", dir_s1d3));
+
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
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
+	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
+					      .handled_access_fs = access_fs_16,
+				      });
+
+	EXPECT_EQ(-1, symlink("target", file1_s1d3));
+	EXPECT_EQ(EACCES, errno);
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.make_sym",
+				    dir_s1d3));
+
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(1, records.domain);
+}
+
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
+	EXPECT_EQ(0, matches_log_domain_allocated(self->audit_fd, NULL));
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.refer",
+				    dir_s1d3));
+
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
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
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(0, records.domain);
+}
+
+TEST_F(audit_layout1, refer_rename)
+{
+	struct audit_records records;
+
+	EXPECT_EQ(0, unlink(file1_s1d3));
+
+	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
+					      .handled_access_fs = access_fs_16,
+				      });
+
+	EXPECT_EQ(EACCES, test_rename(file1_s1d2, file1_s2d3));
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
+				    "fs\\.remove_file,fs\\.refer", dir_s1d2));
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
+				    "fs\\.remove_file,fs\\.make_reg,fs\\.refer",
+				    dir_s2d3));
+
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(0, records.domain);
+}
+
+TEST_F(audit_layout1, refer_exchange)
+{
+	struct audit_records records;
+
+	EXPECT_EQ(0, unlink(file1_s1d3));
+
+	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
+					      .handled_access_fs = access_fs_16,
+				      });
+
+	/*
+	 * The only difference with the previous audit_layout1.refer_rename test is
+	 * the extra ",fs\\.make_reg" blocked by the source directory.
+	 */
+	EXPECT_EQ(EACCES, test_exchange(file1_s1d2, file1_s2d3));
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
+				    "fs\\.remove_file,fs\\.make_reg,fs\\.refer",
+				    dir_s1d2));
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
+				    "fs\\.remove_file,fs\\.make_reg,fs\\.refer",
+				    dir_s2d3));
+
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(0, records.domain);
+}
+
+/*
+ * This test checks that the audit record is correctly generated when the
+ * operation is only partially denied.  This is the case for rename(2) when the
+ * source file is allowed to be referenced but the destination directory is not.
+ *
+ * This is also a regression test for commit d617f0d72d80 ("landlock: Optimize
+ * file path walks and prepare for audit support") and commit 058518c20920
+ * ("landlock: Align partial refer access checks with final ones").
+ */
+TEST_F(audit_layout1, refer_rename_half)
+{
+	struct audit_records records;
+	const struct rule layer1[] = {
+		{
+			.path = dir_s2d2,
+			.access = LANDLOCK_ACCESS_FS_REFER,
+		},
+		{},
+	};
+	int ruleset_fd =
+		create_ruleset(_metadata, LANDLOCK_ACCESS_FS_REFER, layer1);
+
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	ASSERT_EQ(-1, rename(dir_s1d2, dir_s2d3));
+	ASSERT_EQ(EXDEV, errno);
+
+	/* Only half of the request is denied. */
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.refer",
+				    dir_s1d1));
+
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(1, records.domain);
+}
+
+TEST_F(audit_layout1, truncate)
+{
+	struct audit_records records;
+
+	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
+					      .handled_access_fs = access_fs_16,
+				      });
+
+	EXPECT_EQ(-1, truncate(file1_s1d3, 0));
+	EXPECT_EQ(EACCES, errno);
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.truncate",
+				    file1_s1d3));
+
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
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
+					   access_fs_16 &
+					   ~LANDLOCK_ACCESS_FS_READ_FILE,
+			   });
+
+	fd = open("/dev/null", O_RDONLY | O_CLOEXEC);
+	ASSERT_LE(0, fd);
+	EXPECT_EQ(EACCES, ioctl_error(_metadata, fd, FIONREAD));
+	EXPECT_EQ(0, matches_log_fs_extra(_metadata, self->audit_fd,
+					  "fs\\.ioctl_dev", "/dev/null",
+					  " ioctlcmd=0x541b"));
+
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(1, records.domain);
+}
+
+TEST_F(audit_layout1, mount)
+{
+	struct audit_records records;
+
+	drop_access_rights(_metadata,
+			   &(struct landlock_ruleset_attr){
+				   .handled_access_fs =
+					   LANDLOCK_ACCESS_FS_EXECUTE,
+			   });
+
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	EXPECT_EQ(-1, mount(NULL, dir_s3d2, NULL, MS_RDONLY, NULL));
+	EXPECT_EQ(EPERM, errno);
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
+				    "fs\\.change_topology", dir_s3d2));
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(1, records.domain);
+}
+
 TEST_HARNESS_MAIN
-- 
2.49.0

