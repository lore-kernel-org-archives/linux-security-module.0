Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8258130E5E
	for <linux-security-module@vger.kernel.org>; Fri, 19 Apr 2024 16:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713543110; cv=none; b=jI+CSUd9+Ao/iX/xJ+3Bpcel7PmQAQrznrBODFmubPohv8Gl/GpUFsy7e4j65bziYyC2bZsl9ExtiKuel66yFRVBy7gLmHumWiJBA6m9MqGqubyQuTxjz6GPQzQGS3jb6aCi1lLSbqlRK2WL4YDITvihv1Jt1LediduIaPenWko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713543110; c=relaxed/simple;
	bh=aaS/rxuzH0/LdbPc/Gme9UHEZOyJtUZlv6RxicDoDB0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fmS6hzaQjkZHX9IM9hXRwNz+0xdmeWaPNAaQBudrT+G0f0RXqJ4hFzV/SLpXvL5ncy+YRCtCYdgDPkRi6z+IQSe89HUKx6ubRuqxj045KiPB3fuQobm3f7327r+FzhkvqlxUyd122XuhIFSa+KVmIVX0GSMEuROQH1kkdVyhI6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IRUBJCb+; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IRUBJCb+"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-a51acf7c214so73384566b.1
        for <linux-security-module@vger.kernel.org>; Fri, 19 Apr 2024 09:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713543107; x=1714147907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mTpirY2EDqMuFXipxHHF5iZId6Sqj8pwgsZB0mt9fb0=;
        b=IRUBJCb+zqkubnMHpN2HjD+PfyYiH6IwiYoWlD1aYoWrOgr/BwUhnqyNRpL5jMRGcr
         8NhNdWjdVZQvCygzmBoOUUx7Ksgl/kBmwt7KxDVSCWN450gaI1GmneFPUn8XtAxO825f
         576OaYgzB6q/4ntp4ubiELaBbD4N1GV7ZZoXregzEgyPWWnyCmDLauk2SDeWa8DyHXOF
         CLefCTz6Bnr6HWE9Y47UCU0E1Wueavo7Ts2SLpG6w+DdLXM8acwFnURhGsB5I75vOwK0
         AdoMUEta3jeI+hhnmkTb2dN/4mDH7jySutFqiDfngGhcdDS1PRw8zwyPItb2B+iC+lEU
         BIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713543107; x=1714147907;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mTpirY2EDqMuFXipxHHF5iZId6Sqj8pwgsZB0mt9fb0=;
        b=jIAdo4Yf2JS/Un+Eec1s6fGrls+82Cv8n9wRwUOj//DezehnmzfVwxFmtIRTdwmEQH
         lH7PpV3UxQ+X/7YUEPQYzMh9cG9KPJPi39mNbku4DA6p9LoHmKUg98Wvnf4iaQ8Y+YLU
         BMn8NjSYqzOEglUDculuajbp7KToIK34e3nyh3iHn5ThrtJBBXY43khkvpD9lwmQDakk
         /Ve3Ak1KjH2mjFyrAFJu1Am22rxMhrkMHiulsIS/i0Q9/omVtAcdNDFs3SUTIQaUZJzo
         9rXCI9HfTHVeWmfD19EGe1MePBNfWz4SmI7Wv7ZnFWi4Oiui8MgoKEJxGZ95aBBEYk6J
         8Icw==
X-Gm-Message-State: AOJu0YzvQZxnod1Z4h8CJHQv3/oHIRhXQd/KuE3rFQBPaGyOJhGlis21
	eu6gSg632M6DPqMVU6lSG8DgRz+O47VifIQggqqs/9bz3qPpj6hC85iuomksJjZnmCyDQgvd2fb
	xICPl6pUPFAQ397BTfKR5lF7ucNeV4aS9nBE2kehikwePOZhXIU/Je9bT7hm+AF+6WpirBjazXo
	mMjwkKvYQXCnWDVuqu9uR7sY3IdGbIuwZUBMIRAuuu/C2XUm3w0DxS
X-Google-Smtp-Source: AGHT+IF0MJxi7LsjQ2UaIbU6BctiT4aGoxjEtTVhV3EMzDCyonyoshl62E/FaHeU8BLHZRnUM+6piP0TFrg=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a17:906:846f:b0:a55:68c2:5ccf with SMTP id
 hx15-20020a170906846f00b00a5568c25ccfmr2430ejc.2.1713543106958; Fri, 19 Apr
 2024 09:11:46 -0700 (PDT)
Date: Fri, 19 Apr 2024 16:11:18 +0000
In-Reply-To: <20240419161122.2023765-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240419161122.2023765-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240419161122.2023765-8-gnoack@google.com>
Subject: [PATCH v15 07/11] selftests/landlock: Exhaustive test for the IOCTL allow-list
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: linux-security-module@vger.kernel.org, 
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc: Jeff Xu <jeffxu@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This test checks all IOCTL commands implemented in do_vfs_ioctl().

Suggested-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 tools/testing/selftests/landlock/fs_test.c | 114 +++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index 232ab02f829d..beb79154a679 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -10,6 +10,7 @@
 #define _GNU_SOURCE
 #include <asm/termbits.h>
 #include <fcntl.h>
+#include <linux/fiemap.h>
 #include <linux/landlock.h>
 #include <linux/magic.h>
 #include <sched.h>
@@ -3937,6 +3938,119 @@ TEST_F_FORK(layout1, o_path_ftruncate_and_ioctl)
 	ASSERT_EQ(0, close(fd));
 }
=20
+/*
+ * ioctl_error - generically call the given ioctl with a pointer to a
+ * sufficiently large zeroed-out memory region.
+ *
+ * Returns the IOCTLs error, or 0.
+ */
+static int ioctl_error(struct __test_metadata *const _metadata, int fd,
+		       unsigned int cmd)
+{
+	char buf[128]; /* sufficiently large */
+	int res, stdinbak_fd;
+
+	/*
+	 * Depending on the IOCTL command, parts of the zeroed-out buffer might
+	 * be interpreted as file descriptor numbers.  We do not want to
+	 * accidentally operate on file descriptor 0 (stdin), so we temporarily
+	 * move stdin to a different FD and close FD 0 for the IOCTL call.
+	 */
+	stdinbak_fd =3D dup(0);
+	ASSERT_LT(0, stdinbak_fd);
+	ASSERT_EQ(0, close(0));
+
+	/* Invokes the IOCTL with a zeroed-out buffer. */
+	bzero(&buf, sizeof(buf));
+	res =3D ioctl(fd, cmd, &buf);
+
+	/* Restores the old FD 0 and closes the backup FD. */
+	ASSERT_EQ(0, dup2(stdinbak_fd, 0));
+	ASSERT_EQ(0, close(stdinbak_fd));
+
+	if (res < 0)
+		return errno;
+
+	return 0;
+}
+
+/* Define some linux/falloc.h IOCTL commands which are not available in ua=
pi headers. */
+struct space_resv {
+	__s16 l_type;
+	__s16 l_whence;
+	__s64 l_start;
+	__s64 l_len; /* len =3D=3D 0 means until end of file */
+	__s32 l_sysid;
+	__u32 l_pid;
+	__s32 l_pad[4]; /* reserved area */
+};
+
+#define FS_IOC_RESVSP _IOW('X', 40, struct space_resv)
+#define FS_IOC_UNRESVSP _IOW('X', 41, struct space_resv)
+#define FS_IOC_RESVSP64 _IOW('X', 42, struct space_resv)
+#define FS_IOC_UNRESVSP64 _IOW('X', 43, struct space_resv)
+#define FS_IOC_ZERO_RANGE _IOW('X', 57, struct space_resv)
+
+/*
+ * Tests a series of blanket-permitted and denied IOCTLs.
+ */
+TEST_F_FORK(layout1, blanket_permitted_ioctls)
+{
+	const struct landlock_ruleset_attr attr =3D {
+		.handled_access_fs =3D LANDLOCK_ACCESS_FS_IOCTL_DEV,
+	};
+	int ruleset_fd, fd;
+
+	/* Enables Landlock. */
+	ruleset_fd =3D landlock_create_ruleset(&attr, sizeof(attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	fd =3D open("/dev/null", O_RDWR | O_CLOEXEC);
+	ASSERT_LE(0, fd);
+
+	/*
+	 * Checks permitted commands.
+	 * These ones may return errors, but should not be blocked by Landlock.
+	 */
+	EXPECT_NE(EACCES, ioctl_error(_metadata, fd, FIOCLEX));
+	EXPECT_NE(EACCES, ioctl_error(_metadata, fd, FIONCLEX));
+	EXPECT_NE(EACCES, ioctl_error(_metadata, fd, FIONBIO));
+	EXPECT_NE(EACCES, ioctl_error(_metadata, fd, FIOASYNC));
+	EXPECT_NE(EACCES, ioctl_error(_metadata, fd, FIOQSIZE));
+	EXPECT_NE(EACCES, ioctl_error(_metadata, fd, FIFREEZE));
+	EXPECT_NE(EACCES, ioctl_error(_metadata, fd, FITHAW));
+	EXPECT_NE(EACCES, ioctl_error(_metadata, fd, FS_IOC_FIEMAP));
+	EXPECT_NE(EACCES, ioctl_error(_metadata, fd, FIGETBSZ));
+	EXPECT_NE(EACCES, ioctl_error(_metadata, fd, FICLONE));
+	EXPECT_NE(EACCES, ioctl_error(_metadata, fd, FICLONERANGE));
+	EXPECT_NE(EACCES, ioctl_error(_metadata, fd, FIDEDUPERANGE));
+	EXPECT_NE(EACCES, ioctl_error(_metadata, fd, FS_IOC_GETFSUUID));
+	EXPECT_NE(EACCES, ioctl_error(_metadata, fd, FS_IOC_GETFSSYSFSPATH));
+
+	/*
+	 * Checks blocked commands.
+	 * A call to a blocked IOCTL command always returns EACCES.
+	 */
+	EXPECT_EQ(EACCES, ioctl_error(_metadata, fd, FIONREAD));
+	EXPECT_EQ(EACCES, ioctl_error(_metadata, fd, FS_IOC_GETFLAGS));
+	EXPECT_EQ(EACCES, ioctl_error(_metadata, fd, FS_IOC_SETFLAGS));
+	EXPECT_EQ(EACCES, ioctl_error(_metadata, fd, FS_IOC_FSGETXATTR));
+	EXPECT_EQ(EACCES, ioctl_error(_metadata, fd, FS_IOC_FSSETXATTR));
+	EXPECT_EQ(EACCES, ioctl_error(_metadata, fd, FIBMAP));
+	EXPECT_EQ(EACCES, ioctl_error(_metadata, fd, FS_IOC_RESVSP));
+	EXPECT_EQ(EACCES, ioctl_error(_metadata, fd, FS_IOC_RESVSP64));
+	EXPECT_EQ(EACCES, ioctl_error(_metadata, fd, FS_IOC_UNRESVSP));
+	EXPECT_EQ(EACCES, ioctl_error(_metadata, fd, FS_IOC_UNRESVSP64));
+	EXPECT_EQ(EACCES, ioctl_error(_metadata, fd, FS_IOC_ZERO_RANGE));
+
+	/* Default case is also blocked. */
+	EXPECT_EQ(EACCES, ioctl_error(_metadata, fd, 0xc00ffeee));
+
+	ASSERT_EQ(0, close(fd));
+}
+
 /*
  * Named pipes are not governed by the LANDLOCK_ACCESS_FS_IOCTL_DEV right,
  * because they are not character or block devices.
--=20
2.44.0.769.g3c40516874-goog

