Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [185.125.25.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEA233937F
	for <linux-security-module@vger.kernel.org>; Wed, 22 Jul 2026 15:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784733260; cv=none; b=Ommd4DlemJUshQEmbPyMS+Tg+rqDiGlG8Jrlu2czj/UKbif82e+FVsRpiSVETOzTF8pIHrUdwDlZa0mRFTJcl5TNkThZKUadt7eQNeKF3Mc7LmnuVUAnwOUbDAtX6/y1goaSfWtWRljYuIaJMnV+nBHCVxZ4+vMhKBKpQF5BwSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784733260; c=relaxed/simple;
	bh=BZZaNzokCXYI7hfAMJ7nG40wITMumGdee4TZ5qD1+X0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rr26UmfxRHKqG8fO2TRImqxjTkKZRaXiGKNLBZhc6ZK9RJI4va1S38wyxuyDeU3V9+c4UqQrfuVdq/TKW0kTqNKPbF8zd4x6oLJaGENVfkLWmdRJR+DHTTbdzcv/HTyAT/l52FVgtrsprk87gs8vojOJzS22lwF9bl4hYLnhozU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=iPmsbUG9; arc=none smtp.client-ip=185.125.25.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="iPmsbUG9"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4h4yTC3spBzq7Z;
	Wed, 22 Jul 2026 17:14:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1784733247;
	bh=aAcfoCORRbDeFzWjd5jOWObSKd1NugosU/wA/e0fh20=;
	h=From:To:Cc:Subject:Date:From;
	b=iPmsbUG9Xg13Ix+xa8p+xcY8I3dGC7RB+nEuUZbMqFlrDm/LSLSlRAIik+wR0b8u/
	 I6HoC6BZ27WYk2FURe9pkU6ggQnMLAa9gfM37e/vpZ8ZPCgwp2SAkIqWsQoLbYJSgb
	 VBBMwPRlO7L1gGtkXUwNXbdtGRqgHoaFX3e7VMnc=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4h4yTB3vCHzSCD;
	Wed, 22 Jul 2026 17:14:06 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	Takao Sato <takaosato1997@gmail.com>,
	Willy Tarreau <w@1wt.eu>,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk
Subject: [PATCH v1] selftests/landlock: Add tests for O_TMPFILE
Date: Wed, 22 Jul 2026 17:13:52 +0200
Message-ID: <20260722151354.2736457-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

open(2) with O_TMPFILE creates its unnamed inode through vfs_tmpfile(),
which, unlike normal file creation, calls neither security_path_mknod()
nor security_inode_create().  It is nonetheless mediated: vfs_tmpfile()
opens the inode through the filesystem's ->tmpfile() operation, which
reaches security_file_open() via finish_open().  The open is therefore
checked like any other, and materializing the file with linkat(2) is
checked like any other link.

Add tests for both paths so O_TMPFILE cannot bypass Landlock.

Cc: Günther Noack <gnoack@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 tools/testing/selftests/landlock/fs_test.c | 251 +++++++++++++++++++++
 1 file changed, 251 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index cdb47fc1fc0a..b826b2c6a8f0 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -450,6 +450,25 @@ static int test_open(const char *const path, const int flags)
 	return test_open_rel(AT_FDCWD, path, flags);
 }
 
+/*
+ * Opens an anonymous O_TMPFILE inode in the directory dir.  O_TMPFILE is always
+ * combined with O_WRONLY or O_RDWR, so the caller must pass one of them in
+ * flags.
+ */
+static int test_tmpfile(const char *const dir, const int flags)
+{
+	int fd;
+
+	fd = open(dir, O_TMPFILE | flags | O_CLOEXEC, 0700);
+	if (fd < 0)
+		return errno;
+
+	if (close(fd) != 0)
+		return errno;
+
+	return 0;
+}
+
 TEST_F_FORK(layout1, no_restriction)
 {
 	ASSERT_EQ(0, test_open(dir_s1d1, O_RDONLY));
@@ -2140,6 +2159,238 @@ TEST_F_FORK(layout1, link)
 	ASSERT_EQ(0, link(file1_s1d3, file2_s1d3));
 }
 
+/*
+ * O_TMPFILE does not go through the path_mknod hook: vfs_tmpfile() creates the
+ * inode without calling security_path_mknod().  These tests verify that the
+ * resulting file is still mediated, via the file_open hook, so O_TMPFILE cannot
+ * be used to bypass Landlock.
+ */
+
+/*
+ * An O_TMPFILE open requires WRITE_FILE (and READ_FILE for O_RDWR) on the
+ * directory hierarchy, exactly like any other writable open.  It does not
+ * require (nor is it granted by) MAKE_REG: the anonymous inode is not yet a
+ * named file.  O_TMPFILE always implies write access, so a read-only request is
+ * rejected by the VFS with EINVAL before Landlock is consulted; Landlock must
+ * not change that into EACCES.
+ */
+TEST_F_FORK(layout1, open_tmpfile)
+{
+	const struct rule rules[] = {
+		/* Write allowed, but neither MAKE_REG nor READ_FILE. */
+		{
+			.path = dir_s1d1,
+			.access = LANDLOCK_ACCESS_FS_WRITE_FILE,
+		},
+		/* Both read and write allowed. */
+		{
+			.path = dir_s1d2,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE |
+				  LANDLOCK_ACCESS_FS_WRITE_FILE,
+		},
+		/* File-creation right without write. */
+		{
+			.path = dir_s2d1,
+			.access = LANDLOCK_ACCESS_FS_MAKE_REG,
+		},
+		{},
+	};
+
+	/* Baseline: an unsandboxed O_TMPFILE open works. */
+	EXPECT_EQ(0, test_tmpfile(dir_s1d1, O_WRONLY));
+	EXPECT_EQ(0, test_tmpfile(dir_s2d1, O_RDWR));
+	EXPECT_EQ(0, test_tmpfile(dir_s3d1, O_RDWR));
+
+	/* O_TMPFILE requires write access: read-only is EINVAL at the VFS. */
+	EXPECT_EQ(EINVAL, test_tmpfile(dir_s1d1, O_RDONLY));
+
+	enforce_fs(_metadata,
+		   LANDLOCK_ACCESS_FS_READ_FILE |
+			   LANDLOCK_ACCESS_FS_WRITE_FILE |
+			   LANDLOCK_ACCESS_FS_MAKE_REG,
+		   rules);
+
+	/* Write is enough for an O_WRONLY tmpfile; MAKE_REG is not needed. */
+	EXPECT_EQ(0, test_tmpfile(dir_s1d1, O_WRONLY));
+	/* O_RDWR additionally needs READ_FILE, which is absent here. */
+	EXPECT_EQ(EACCES, test_tmpfile(dir_s1d1, O_RDWR));
+
+	/* Read and write allowed: both open modes succeed. */
+	EXPECT_EQ(0, test_tmpfile(dir_s1d2, O_WRONLY));
+	EXPECT_EQ(0, test_tmpfile(dir_s1d2, O_RDWR));
+
+	/* MAKE_REG without WRITE_FILE does not allow the open. */
+	EXPECT_EQ(EACCES, test_tmpfile(dir_s2d1, O_WRONLY));
+	EXPECT_EQ(EACCES, test_tmpfile(dir_s2d1, O_RDWR));
+
+	/* No rule at all: the open is denied. */
+	EXPECT_EQ(EACCES, test_tmpfile(dir_s3d1, O_WRONLY));
+	EXPECT_EQ(EACCES, test_tmpfile(dir_s3d1, O_RDWR));
+
+	/*
+	 * A read-only O_TMPFILE stays EINVAL under Landlock, whether the
+	 * directory is fully allowed or has no rule: the VFS rejects the flag
+	 * combination before the file_open hook, so Landlock never turns it
+	 * into EACCES.
+	 */
+	EXPECT_EQ(EINVAL, test_tmpfile(dir_s1d2, O_RDONLY));
+	EXPECT_EQ(EINVAL, test_tmpfile(dir_s3d1, O_RDONLY));
+}
+
+/*
+ * When the ruleset handles neither file read nor write access, Landlock has no
+ * opinion on an O_TMPFILE open and must not interfere with it.
+ */
+TEST_F_FORK(layout1, open_tmpfile_unhandled)
+{
+	const struct rule rules[] = {
+		{
+			.path = dir_s1d2,
+			.access = LANDLOCK_ACCESS_FS_READ_DIR,
+		},
+		{},
+	};
+
+	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_READ_DIR, rules);
+
+	EXPECT_EQ(0, test_tmpfile(dir_s1d1, O_WRONLY));
+	EXPECT_EQ(0, test_tmpfile(dir_s1d3, O_RDWR));
+	EXPECT_EQ(0, test_tmpfile(dir_s3d1, O_RDWR));
+}
+
+/*
+ * Materializing an anonymous O_TMPFILE into its creation directory with
+ * linkat(AT_EMPTY_PATH) is gated by MAKE_REG on that directory, even though
+ * obtaining the writable tmpfile only required WRITE_FILE.  This is the check
+ * that stops O_TMPFILE from creating a named file where the sandbox forbids
+ * file creation.  Linking into the same directory does not involve reparenting,
+ * so REFER is not required.
+ */
+TEST_F_FORK(layout1, link_tmpfile)
+{
+	int fd;
+	const struct rule rules[] = {
+		/* Write only: the tmpfile opens but cannot be linked. */
+		{
+			.path = dir_s1d1,
+			.access = LANDLOCK_ACCESS_FS_WRITE_FILE,
+		},
+		/* Write and MAKE_REG: the tmpfile opens and can be linked. */
+		{
+			.path = dir_s2d1,
+			.access = LANDLOCK_ACCESS_FS_WRITE_FILE |
+				  LANDLOCK_ACCESS_FS_MAKE_REG,
+		},
+		{},
+	};
+
+	/* Frees names in the two directories for the new links. */
+	ASSERT_EQ(0, unlink(file1_s1d1));
+	ASSERT_EQ(0, unlink(file1_s2d1));
+
+	enforce_fs(_metadata,
+		   LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_MAKE_REG,
+		   rules);
+
+	/*
+	 * WRITE_FILE is enough to obtain the anonymous tmpfile.  linkat(2) with
+	 * AT_EMPTY_PATH needs no capability because the fd's open-time
+	 * credentials match the caller's.  Linking into the same directory does
+	 * not require REFER (no reparenting), only MAKE_REG, which is absent
+	 * here.
+	 */
+	fd = open(dir_s1d1, O_TMPFILE | O_WRONLY | O_CLOEXEC, 0700);
+	ASSERT_LE(0, fd);
+	ASSERT_EQ(-1, linkat(fd, "", AT_FDCWD, file1_s1d1, AT_EMPTY_PATH));
+	EXPECT_EQ(EACCES, errno);
+	EXPECT_EQ(0, close(fd));
+
+	/* With MAKE_REG on the directory, the same link is allowed. */
+	fd = open(dir_s2d1, O_TMPFILE | O_WRONLY | O_CLOEXEC, 0700);
+	ASSERT_LE(0, fd);
+	EXPECT_EQ(0, linkat(fd, "", AT_FDCWD, file1_s2d1, AT_EMPTY_PATH));
+	EXPECT_EQ(0, close(fd));
+}
+
+/*
+ * Linking a tmpfile into a different directory is a reparenting operation: like
+ * any cross-directory link it requires LANDLOCK_ACCESS_FS_REFER.  Without it,
+ * materializing the tmpfile outside its creation directory is denied with
+ * EXDEV, so a tmpfile cannot escape its origin hierarchy.
+ */
+TEST_F_FORK(layout1, link_tmpfile_reparent_without_refer)
+{
+	int fd;
+	const struct rule rules[] = {
+		/* Source directory: only the tmpfile open is allowed. */
+		{
+			.path = dir_s1d1,
+			.access = LANDLOCK_ACCESS_FS_WRITE_FILE,
+		},
+		/* Destination directory: file creation is allowed. */
+		{
+			.path = dir_s2d1,
+			.access = LANDLOCK_ACCESS_FS_MAKE_REG,
+		},
+		{},
+	};
+
+	/* Frees a name in the destination directory for the new link. */
+	ASSERT_EQ(0, unlink(file1_s2d1));
+
+	enforce_fs(_metadata,
+		   LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_MAKE_REG,
+		   rules);
+
+	fd = open(dir_s1d1, O_TMPFILE | O_WRONLY | O_CLOEXEC, 0700);
+	ASSERT_LE(0, fd);
+	/* Cross-directory link without REFER is denied with EXDEV. */
+	ASSERT_EQ(-1, linkat(fd, "", AT_FDCWD, file1_s2d1, AT_EMPTY_PATH));
+	EXPECT_EQ(EXDEV, errno);
+	EXPECT_EQ(0, close(fd));
+}
+
+/*
+ * With LANDLOCK_ACCESS_FS_REFER on both directories, a tmpfile created in one
+ * directory can be linked into another.  The destination needs only MAKE_REG
+ * (plus REFER), not WRITE_FILE: the reparenting check compares file access
+ * rights, and the tmpfile gains none by moving to a directory that grants only
+ * the directory-level creation right.
+ */
+TEST_F_FORK(layout1, link_tmpfile_reparent_with_refer)
+{
+	int fd;
+	const struct rule rules[] = {
+		/* Source: tmpfile open (write) and reparenting. */
+		{
+			.path = dir_s1d1,
+			.access = LANDLOCK_ACCESS_FS_WRITE_FILE |
+				  LANDLOCK_ACCESS_FS_REFER,
+		},
+		/* Destination: file creation and reparenting, but no write. */
+		{
+			.path = dir_s2d1,
+			.access = LANDLOCK_ACCESS_FS_MAKE_REG |
+				  LANDLOCK_ACCESS_FS_REFER,
+		},
+		{},
+	};
+
+	/* Frees a name in the destination directory for the new link. */
+	ASSERT_EQ(0, unlink(file1_s2d1));
+
+	enforce_fs(_metadata,
+		   LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_MAKE_REG |
+			   LANDLOCK_ACCESS_FS_REFER,
+		   rules);
+
+	fd = open(dir_s1d1, O_TMPFILE | O_WRONLY | O_CLOEXEC, 0700);
+	ASSERT_LE(0, fd);
+	/* REFER on both sides plus MAKE_REG on the destination allows it. */
+	EXPECT_EQ(0, linkat(fd, "", AT_FDCWD, file1_s2d1, AT_EMPTY_PATH));
+	EXPECT_EQ(0, close(fd));
+}
+
 static int test_rename(const char *const oldpath, const char *const newpath)
 {
 	if (rename(oldpath, newpath))
-- 
2.54.0

