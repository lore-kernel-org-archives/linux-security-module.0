Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vnlnzQEK"
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3184710FF
	for <linux-security-module@vger.kernel.org>; Fri,  1 Dec 2023 06:31:04 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id ffacd0b85a97d-333127fecf9so1613100f8f.2
        for <linux-security-module@vger.kernel.org>; Fri, 01 Dec 2023 06:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701441062; x=1702045862; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O+NrHJh/7Jw+EUdljtYJPR+S0uMt7t/D6jnfOb6pKUQ=;
        b=vnlnzQEKimnafLPzfs0CqKpD/QSeRgkbrNZaKa8E2a3z1ggKQ+he0pCwMKDAQgvPjB
         v56rqqdCGyZMCFOUpuxuW+iiicNLk9HNyn755Xk0UKArST0qRs5fWHT1TLcO6Ahw9Mwz
         4bMO2KsFKH8ImbxlRdgSuVEwb3oA420IhPj5pa5C1vOpIR12iFuXhjZhkFVWwOZtvg8H
         WkrI7ocnG5vlwSmNh4rhq7pCEc1exk0lcXfwIaQLzI3WKIxHI5pDSe1+4p6JT8ktHt35
         W0KuVhkHYS8VAdkRYDWfLh50wtcoYZXpCi9n6rSSN4hZKHdyRsIwNEikbmcoypobqEb/
         C5aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701441062; x=1702045862;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O+NrHJh/7Jw+EUdljtYJPR+S0uMt7t/D6jnfOb6pKUQ=;
        b=OHubD+AV3hyLQSwLi0a9li5gNykNo5bWimBkwWv1pbgOxuGHMhNK8rnu0B0qEVS3sI
         LxYEYdC0JleS7nrhqOwsVDN4V/l0sUYwBG654hbqQA3zHlBIJdFFXPvRX0RsjEjC3ly6
         bO3Dmz38R8Sq1o4oPNeouDVo8jhmxip8yOoysGc8EVrN5oGQ3WO++DNTtN6W79peG5Lj
         j44u9KUyMuPtMOnB7rw77POsQmuX+99EEKTZQxMeyUk0Gj+ncRqpwVqE4j73cOup4gCL
         TISc36lz/ghHTH8OjDEIL4ij80J5q0eu/9puHzpQhYAw/ciL5S+9iKuPEAu2IfNWUpv/
         COWw==
X-Gm-Message-State: AOJu0Yw3Eovy7GuKI4/IBiCVoVrwRvS8MtMeL48/l8lHeYPvl+dfZKfv
	l0nCkEDtb3EY3kSJBIrIsnvNMJ3EWhuLDBA/3wBQ5nQtlf5+JPTch5IS8FbhHUklhFAoQNf0MxK
	GxdQEtQ/+E5O1bwhJMSN3Gdaosf+/BqrK5dj8vzYiuDCF5bOBVptlY0dRfJ+NQOjfeMmP+TRePw
	QJNz3FLw==
X-Google-Smtp-Source: AGHT+IHiWwRaeYTHp/PFkZMh7xMEpsiUfojb4LzrP0ITzNo0IXlWQAx6OP+LqbYbNTytDmgR++b4y8BojPg=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:fab0:4182:b9df:bfec])
 (user=gnoack job=sendgmr) by 2002:a5d:4352:0:b0:333:1756:b3c9 with SMTP id
 u18-20020a5d4352000000b003331756b3c9mr148141wrr.5.1701441062390; Fri, 01 Dec
 2023 06:31:02 -0800 (PST)
Date: Fri,  1 Dec 2023 15:30:38 +0100
In-Reply-To: <20231201143042.3276833-1-gnoack@google.com>
Message-Id: <20231201143042.3276833-6-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231201143042.3276833-1-gnoack@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v7 5/9] selftests/landlock: Test IOCTL support
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: linux-security-module@vger.kernel.org, 
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc: Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Allen Webb <allenwebb@google.com>, Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Exercises Landlock's IOCTL feature in different combinations of
handling and permitting the rights LANDLOCK_ACCESS_FS_IOCTL,
LANDLOCK_ACCESS_FS_READ_FILE, LANDLOCK_ACCESS_FS_WRITE_FILE and
LANDLOCK_ACCESS_FS_READ_DIR, and in different combinations of using
files and directories.

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 tools/testing/selftests/landlock/fs_test.c | 431 ++++++++++++++++++++-
 1 file changed, 428 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index 192608c3e840..054779ef4527 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -9,6 +9,7 @@
=20
 #define _GNU_SOURCE
 #include <fcntl.h>
+#include <linux/fs.h>
 #include <linux/landlock.h>
 #include <linux/magic.h>
 #include <sched.h>
@@ -733,6 +734,9 @@ static int create_ruleset(struct __test_metadata *const=
 _metadata,
 	}
=20
 	for (i =3D 0; rules[i].path; i++) {
+		if (!rules[i].access)
+			continue;
+
 		add_path_beneath(_metadata, ruleset_fd, rules[i].access,
 				 rules[i].path);
 	}
@@ -3441,7 +3445,7 @@ TEST_F_FORK(layout1, truncate_unhandled)
 			      LANDLOCK_ACCESS_FS_WRITE_FILE;
 	int ruleset_fd;
=20
-	/* Enable Landlock. */
+	/* Enables Landlock. */
 	ruleset_fd =3D create_ruleset(_metadata, handled, rules);
=20
 	ASSERT_LE(0, ruleset_fd);
@@ -3524,7 +3528,7 @@ TEST_F_FORK(layout1, truncate)
 			      LANDLOCK_ACCESS_FS_TRUNCATE;
 	int ruleset_fd;
=20
-	/* Enable Landlock. */
+	/* Enables Landlock. */
 	ruleset_fd =3D create_ruleset(_metadata, handled, rules);
=20
 	ASSERT_LE(0, ruleset_fd);
@@ -3750,7 +3754,7 @@ TEST_F_FORK(ftruncate, open_and_ftruncate)
 	};
 	int fd, ruleset_fd;
=20
-	/* Enable Landlock. */
+	/* Enables Landlock. */
 	ruleset_fd =3D create_ruleset(_metadata, variant->handled, rules);
 	ASSERT_LE(0, ruleset_fd);
 	enforce_ruleset(_metadata, ruleset_fd);
@@ -3827,6 +3831,16 @@ TEST_F_FORK(ftruncate, open_and_ftruncate_in_differe=
nt_processes)
 	ASSERT_EQ(0, close(socket_fds[1]));
 }
=20
+/* Invokes the FS_IOC_GETFLAGS IOCTL and returns its errno or 0. */
+static int test_fs_ioc_getflags_ioctl(int fd)
+{
+	uint32_t flags;
+
+	if (ioctl(fd, FS_IOC_GETFLAGS, &flags) < 0)
+		return errno;
+	return 0;
+}
+
 TEST(memfd_ftruncate)
 {
 	int fd;
@@ -3843,6 +3857,417 @@ TEST(memfd_ftruncate)
 	ASSERT_EQ(0, close(fd));
 }
=20
+/* clang-format off */
+FIXTURE(ioctl) {};
+/* clang-format on */
+
+FIXTURE_SETUP(ioctl)
+{
+	prepare_layout(_metadata);
+	create_file(_metadata, file1_s1d1);
+}
+
+FIXTURE_TEARDOWN(ioctl)
+{
+	EXPECT_EQ(0, remove_path(file1_s1d1));
+	cleanup_layout(_metadata);
+}
+
+FIXTURE_VARIANT(ioctl)
+{
+	const __u64 handled;
+	const __u64 allowed;
+	const mode_t open_mode;
+	/*
+	 * These are the expected IOCTL results for a representative IOCTL from
+	 * each of the IOCTL groups.  We only distinguish the 0 and EACCES
+	 * results here, and treat other errors as 0.
+	 */
+	const int expected_fioqsize_result; /* G1 */
+	const int expected_fibmap_result; /* G2 */
+	const int expected_fionread_result; /* G3 */
+	const int expected_fs_ioc_zero_range_result; /* G4 */
+	const int expected_fs_ioc_getflags_result; /* other */
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, handled_i_allowed_none) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_IOCTL,
+	.allowed =3D 0,
+	.open_mode =3D O_RDWR,
+	.expected_fioqsize_result =3D EACCES,
+	.expected_fibmap_result =3D EACCES,
+	.expected_fionread_result =3D EACCES,
+	.expected_fs_ioc_zero_range_result =3D EACCES,
+	.expected_fs_ioc_getflags_result =3D EACCES,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, handled_i_allowed_i) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_IOCTL,
+	.allowed =3D LANDLOCK_ACCESS_FS_IOCTL,
+	.open_mode =3D O_RDWR,
+	.expected_fioqsize_result =3D 0,
+	.expected_fibmap_result =3D 0,
+	.expected_fionread_result =3D 0,
+	.expected_fs_ioc_zero_range_result =3D 0,
+	.expected_fs_ioc_getflags_result =3D 0,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, unhandled) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_EXECUTE,
+	.allowed =3D LANDLOCK_ACCESS_FS_EXECUTE,
+	.open_mode =3D O_RDWR,
+	.expected_fioqsize_result =3D 0,
+	.expected_fibmap_result =3D 0,
+	.expected_fionread_result =3D 0,
+	.expected_fs_ioc_zero_range_result =3D 0,
+	.expected_fs_ioc_getflags_result =3D 0,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, handled_rwd_allowed_r) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_READ_FILE |
+		   LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_READ_DIR,
+	.allowed =3D LANDLOCK_ACCESS_FS_READ_FILE,
+	.open_mode =3D O_RDONLY,
+	/* If LANDLOCK_ACCESS_FS_IOCTL is not handled, all IOCTLs work. */
+	.expected_fioqsize_result =3D 0,
+	.expected_fibmap_result =3D 0,
+	.expected_fionread_result =3D 0,
+	.expected_fs_ioc_zero_range_result =3D 0,
+	.expected_fs_ioc_getflags_result =3D 0,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, handled_rwd_allowed_w) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_READ_FILE |
+		   LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_READ_DIR,
+	.allowed =3D LANDLOCK_ACCESS_FS_WRITE_FILE,
+	.open_mode =3D O_WRONLY,
+	/* If LANDLOCK_ACCESS_FS_IOCTL is not handled, all IOCTLs work. */
+	.expected_fioqsize_result =3D 0,
+	.expected_fibmap_result =3D 0,
+	.expected_fionread_result =3D 0,
+	.expected_fs_ioc_zero_range_result =3D 0,
+	.expected_fs_ioc_getflags_result =3D 0,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, handled_ri_allowed_r) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_READ_FILE | LANDLOCK_ACCESS_FS_IOCTL,
+	.allowed =3D LANDLOCK_ACCESS_FS_READ_FILE,
+	.open_mode =3D O_RDONLY,
+	.expected_fioqsize_result =3D 0,
+	.expected_fibmap_result =3D 0,
+	.expected_fionread_result =3D 0,
+	.expected_fs_ioc_zero_range_result =3D EACCES,
+	.expected_fs_ioc_getflags_result =3D EACCES,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, handled_wi_allowed_w) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_IOCTL,
+	.allowed =3D LANDLOCK_ACCESS_FS_WRITE_FILE,
+	.open_mode =3D O_WRONLY,
+	.expected_fioqsize_result =3D 0,
+	.expected_fibmap_result =3D 0,
+	.expected_fionread_result =3D EACCES,
+	.expected_fs_ioc_zero_range_result =3D 0,
+	.expected_fs_ioc_getflags_result =3D EACCES,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, handled_di_allowed_d) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_READ_DIR | LANDLOCK_ACCESS_FS_IOCTL,
+	.allowed =3D LANDLOCK_ACCESS_FS_READ_DIR,
+	.open_mode =3D O_RDWR,
+	.expected_fioqsize_result =3D 0,
+	.expected_fibmap_result =3D EACCES,
+	.expected_fionread_result =3D EACCES,
+	.expected_fs_ioc_zero_range_result =3D EACCES,
+	.expected_fs_ioc_getflags_result =3D EACCES,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, handled_rwi_allowed_rw) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_READ_FILE |
+		   LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_IOCTL,
+	.allowed =3D LANDLOCK_ACCESS_FS_READ_FILE | LANDLOCK_ACCESS_FS_WRITE_FILE=
,
+	.open_mode =3D O_RDWR,
+	.expected_fioqsize_result =3D 0,
+	.expected_fibmap_result =3D 0,
+	.expected_fionread_result =3D 0,
+	.expected_fs_ioc_zero_range_result =3D 0,
+	.expected_fs_ioc_getflags_result =3D EACCES,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, handled_rwi_allowed_r) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_READ_FILE |
+		   LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_IOCTL,
+	.allowed =3D LANDLOCK_ACCESS_FS_READ_FILE,
+	.open_mode =3D O_RDONLY,
+	.expected_fioqsize_result =3D 0,
+	.expected_fibmap_result =3D 0,
+	.expected_fionread_result =3D 0,
+	.expected_fs_ioc_zero_range_result =3D EACCES,
+	.expected_fs_ioc_getflags_result =3D EACCES,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, handled_rwi_allowed_ri) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_READ_FILE |
+		   LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_IOCTL,
+	.allowed =3D LANDLOCK_ACCESS_FS_READ_FILE | LANDLOCK_ACCESS_FS_IOCTL,
+	.open_mode =3D O_RDONLY,
+	.expected_fioqsize_result =3D 0,
+	.expected_fibmap_result =3D 0,
+	.expected_fionread_result =3D 0,
+	.expected_fs_ioc_zero_range_result =3D EACCES,
+	.expected_fs_ioc_getflags_result =3D 0,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, handled_rwi_allowed_w) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_READ_FILE |
+		   LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_IOCTL,
+	.allowed =3D LANDLOCK_ACCESS_FS_WRITE_FILE,
+	.open_mode =3D O_WRONLY,
+	.expected_fioqsize_result =3D 0,
+	.expected_fibmap_result =3D 0,
+	.expected_fionread_result =3D EACCES,
+	.expected_fs_ioc_zero_range_result =3D 0,
+	.expected_fs_ioc_getflags_result =3D EACCES,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, handled_rwi_allowed_wi) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_READ_FILE |
+		   LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_IOCTL,
+	.allowed =3D LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_IOCTL,
+	.open_mode =3D O_WRONLY,
+	.expected_fioqsize_result =3D 0,
+	.expected_fibmap_result =3D 0,
+	.expected_fionread_result =3D EACCES,
+	.expected_fs_ioc_zero_range_result =3D 0,
+	.expected_fs_ioc_getflags_result =3D 0,
+};
+
+static int test_fioqsize_ioctl(int fd)
+{
+	size_t sz;
+
+	if (ioctl(fd, FIOQSIZE, &sz) < 0)
+		return errno;
+	return 0;
+}
+
+static int test_fibmap_ioctl(int fd)
+{
+	int blk =3D 0;
+
+	/*
+	 * We only want to distinguish here whether Landlock already caught it,
+	 * so we treat anything but EACCESS as success.  (It commonly returns
+	 * EPERM when missing CAP_SYS_RAWIO.)
+	 */
+	if (ioctl(fd, FIBMAP, &blk) < 0 && errno =3D=3D EACCES)
+		return errno;
+	return 0;
+}
+
+static int test_fionread_ioctl(int fd)
+{
+	size_t sz =3D 0;
+
+	if (ioctl(fd, FIONREAD, &sz) < 0 && errno =3D=3D EACCES)
+		return errno;
+	return 0;
+}
+
+#define FS_IOC_ZERO_RANGE _IOW('X', 57, struct space_resv)
+
+static int test_fs_ioc_zero_range_ioctl(int fd)
+{
+	struct space_resv {
+		__s16 l_type;
+		__s16 l_whence;
+		__s64 l_start;
+		__s64 l_len; /* len =3D=3D 0 means until end of file */
+		__s32 l_sysid;
+		__u32 l_pid;
+		__s32 l_pad[4]; /* reserved area */
+	} reservation =3D {};
+	/*
+	 * This can fail for various reasons, but we only want to distinguish
+	 * here whether Landlock already caught it, so we treat anything but
+	 * EACCES as success.
+	 */
+	if (ioctl(fd, FS_IOC_ZERO_RANGE, &reservation) < 0 && errno =3D=3D EACCES=
)
+		return errno;
+	return 0;
+}
+
+TEST_F_FORK(ioctl, handle_dir_access_file)
+{
+	const int flag =3D 0;
+	const struct rule rules[] =3D {
+		{
+			.path =3D dir_s1d1,
+			.access =3D variant->allowed,
+		},
+		{},
+	};
+	int file_fd, ruleset_fd;
+
+	/* Enables Landlock. */
+	ruleset_fd =3D create_ruleset(_metadata, variant->handled, rules);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	file_fd =3D open(file1_s1d1, variant->open_mode);
+	ASSERT_LE(0, file_fd);
+
+	/*
+	 * Checks that IOCTL commands in each IOCTL group return the expected
+	 * errors.
+	 */
+	EXPECT_EQ(variant->expected_fioqsize_result,
+		  test_fioqsize_ioctl(file_fd));
+	EXPECT_EQ(variant->expected_fibmap_result, test_fibmap_ioctl(file_fd));
+	EXPECT_EQ(variant->expected_fionread_result,
+		  test_fionread_ioctl(file_fd));
+	EXPECT_EQ(variant->expected_fs_ioc_zero_range_result,
+		  test_fs_ioc_zero_range_ioctl(file_fd));
+	EXPECT_EQ(variant->expected_fs_ioc_getflags_result,
+		  test_fs_ioc_getflags_ioctl(file_fd));
+
+	/* Checks that unrestrictable commands are unrestricted. */
+	EXPECT_EQ(0, ioctl(file_fd, FIOCLEX));
+	EXPECT_EQ(0, ioctl(file_fd, FIONCLEX));
+	EXPECT_EQ(0, ioctl(file_fd, FIONBIO, &flag));
+	EXPECT_EQ(0, ioctl(file_fd, FIOASYNC, &flag));
+
+	ASSERT_EQ(0, close(file_fd));
+}
+
+TEST_F_FORK(ioctl, handle_dir_access_dir)
+{
+	const char *const path =3D dir_s1d1;
+	const int flag =3D 0;
+	const struct rule rules[] =3D {
+		{
+			.path =3D path,
+			.access =3D variant->allowed,
+		},
+		{},
+	};
+	int dir_fd, ruleset_fd;
+
+	/* Enables Landlock. */
+	ruleset_fd =3D create_ruleset(_metadata, variant->handled, rules);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/*
+	 * Ignore variant->open_mode for this test, as we intend to open a
+	 * directory.  If the directory can not be opened, the variant is
+	 * infeasible to test with an opened directory.
+	 */
+	dir_fd =3D open(path, O_RDONLY);
+	if (dir_fd < 0)
+		return;
+
+	/*
+	 * Checks that IOCTL commands in each IOCTL group return the expected
+	 * errors.
+	 */
+	EXPECT_EQ(variant->expected_fioqsize_result,
+		  test_fioqsize_ioctl(dir_fd));
+	EXPECT_EQ(variant->expected_fibmap_result, test_fibmap_ioctl(dir_fd));
+	EXPECT_EQ(variant->expected_fionread_result,
+		  test_fionread_ioctl(dir_fd));
+	EXPECT_EQ(variant->expected_fs_ioc_zero_range_result,
+		  test_fs_ioc_zero_range_ioctl(dir_fd));
+	EXPECT_EQ(variant->expected_fs_ioc_getflags_result,
+		  test_fs_ioc_getflags_ioctl(dir_fd));
+
+	/* Checks that unrestrictable commands are unrestricted. */
+	EXPECT_EQ(0, ioctl(dir_fd, FIOCLEX));
+	EXPECT_EQ(0, ioctl(dir_fd, FIONCLEX));
+	EXPECT_EQ(0, ioctl(dir_fd, FIONBIO, &flag));
+	EXPECT_EQ(0, ioctl(dir_fd, FIOASYNC, &flag));
+
+	ASSERT_EQ(0, close(dir_fd));
+}
+
+TEST_F_FORK(ioctl, handle_file_access_file)
+{
+	const char *const path =3D file1_s1d1;
+	const int flag =3D 0;
+	const struct rule rules[] =3D {
+		{
+			.path =3D path,
+			.access =3D variant->allowed,
+		},
+		{},
+	};
+	int file_fd, ruleset_fd;
+
+	if (variant->allowed & LANDLOCK_ACCESS_FS_READ_DIR) {
+		SKIP(return, "LANDLOCK_ACCESS_FS_READ_DIR "
+			     "can not be granted on files");
+	}
+
+	/* Enables Landlock. */
+	ruleset_fd =3D create_ruleset(_metadata, variant->handled, rules);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	file_fd =3D open(path, variant->open_mode);
+	ASSERT_LE(0, file_fd);
+
+	/*
+	 * Checks that IOCTL commands in each IOCTL group return the expected
+	 * errors.
+	 */
+	EXPECT_EQ(variant->expected_fioqsize_result,
+		  test_fioqsize_ioctl(file_fd));
+	EXPECT_EQ(variant->expected_fibmap_result, test_fibmap_ioctl(file_fd));
+	EXPECT_EQ(variant->expected_fionread_result,
+		  test_fionread_ioctl(file_fd));
+	EXPECT_EQ(variant->expected_fs_ioc_zero_range_result,
+		  test_fs_ioc_zero_range_ioctl(file_fd));
+	EXPECT_EQ(variant->expected_fs_ioc_getflags_result,
+		  test_fs_ioc_getflags_ioctl(file_fd));
+
+	/* Checks that unrestrictable commands are unrestricted. */
+	EXPECT_EQ(0, ioctl(file_fd, FIOCLEX));
+	EXPECT_EQ(0, ioctl(file_fd, FIONCLEX));
+	EXPECT_EQ(0, ioctl(file_fd, FIONBIO, &flag));
+	EXPECT_EQ(0, ioctl(file_fd, FIOASYNC, &flag));
+
+	ASSERT_EQ(0, close(file_fd));
+}
+
 /* clang-format off */
 FIXTURE(layout1_bind) {};
 /* clang-format on */
--=20
2.43.0.rc2.451.g8631bc7472-goog

