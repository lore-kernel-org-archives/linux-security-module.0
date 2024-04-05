Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AA0175548
	for <linux-security-module@vger.kernel.org>; Fri,  5 Apr 2024 21:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712353290; cv=none; b=ucXrU6bKiIMB1eLCaqKSpjnEO7cvTarLgaetRJhjq3m9eoUmODyPcXaCGONMSVOU5T4N3Q1UNXUzBDexkw+L7DCAZhoc872Nu+B3buhIspKzkHZtvUVAggCamAsthzeP0K+EyMFAl9UmyIOI5L+Z9SUffOvKzlkRmRqAhIDHKac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712353290; c=relaxed/simple;
	bh=qLMDwtyoGcqvFMu9EgR1JHLn66RlQNI/pH5oSg2jAJk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MgzU5XQlX9tLfL/ZAypVdidm3ILyKVxHiAHLhlUVK7YyMvWGka10pRajz/IwgazyX9tSsvH2WfMIs+6P0lJbThOl/y8F9J0MwrXqmukN2jhO2HuSSWiIgyClwb/k4MJ63ipy4C1XQjQJayQJ9SvtYZvEfe/IwKJMkZwpysQ6YTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TIsUASRU; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TIsUASRU"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-56c5ce6dd4dso1884517a12.2
        for <linux-security-module@vger.kernel.org>; Fri, 05 Apr 2024 14:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712353287; x=1712958087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fc14ktG9ishMSkK8oO4f2RF7Hc8qCkHa2Mip9JK5uP8=;
        b=TIsUASRUNvHEB6EPNkNhzpI/KHtjt+fSWcKUiS9TGX2Vn9bEYjvknmFFqxgq02vJUj
         gg6JrnGIexYBCz7Vwvmen+xxKU7/Zn5lFfhWqcImrxGpoTczhczdW/gpRwgjEsCJScOu
         Zvaa+ZBs+05TZR17PADuAd1TcnLLIj9OGfb1FAMy9XIoEMeQpynassqNYCEZ6X4t58xP
         7n1xGBvk0v8ZWiN1R++OX2QJcpPGENbcGMZZPFIGjLhEa4+P97b35nNd/zyuRu4PVTzf
         x+Q58Cvf+lA3DcJb3oyeRUlq7lg+eX5iAoFNwi7v0pafrU4YvbgTNc/+AuCnI/MqoYn5
         U+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712353287; x=1712958087;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Fc14ktG9ishMSkK8oO4f2RF7Hc8qCkHa2Mip9JK5uP8=;
        b=wpc31BgzPMxlWLlTpvka5LClroPbnZB/GlLJYEUZA227ZZSt+JJRS7qPHlrbobxV7m
         R2RsZMyJSvATByyxQKtAZq0qVt7g0bkRzFttND3g47HafVT1M325lZBLDEKhD8K0Rcz0
         /BjgbhUgBD6woQX3wLuiFOmCLseVIqSFUD9UuF0nmdu4XJ+SMM+CfHDUgAEONHsFUZp4
         ZuMr6BSIFNOh0Aoyo6qwcmKbATjIB8N9iY9HlTEJGLE7OMDLhWOdp+QFTQANaXP+pZuh
         sNTSFjcZQqKTM1y196Qa9UOiPZQthkPPlL7n+t7x5/7+p+5k6hyBDv+OPOpM7Ts1qAfb
         wRWg==
X-Gm-Message-State: AOJu0YwxhHGXh791tQEjlmOhV20ZM3kPce+H1kPju66j6k99+an/tNwr
	fhZbC82zV9SdUXK877YFUj6vBWcozp0eTPCJoievAVcLATkWjoUrbHFzLGc4eLAiT108XcfRYyU
	oBtZvwB7OOkNVnGMVX5h2P0tJiaEp8jc8k6Q5GcuZMaX4RetzSEHUfZIGHhd27/DA/J/zXRQeJ6
	XhJRO/nHOWQB+SFmyI99kvMdfj45KEQrFnioNnXpmz9fyhgYOJKXy3
X-Google-Smtp-Source: AGHT+IHqFS5AI9UI/vpOn5k0bm6lPACo3o++vVDdnl0yWHrksyzS5WQtUNQe7q479q6p/ykpoXJPgD3hAtg=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:6402:321e:b0:56c:4d33:10a5 with SMTP id
 g30-20020a056402321e00b0056c4d3310a5mr4155eda.2.1712353286763; Fri, 05 Apr
 2024 14:41:26 -0700 (PDT)
Date: Fri,  5 Apr 2024 21:40:36 +0000
In-Reply-To: <20240405214040.101396-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240405214040.101396-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240405214040.101396-9-gnoack@google.com>
Subject: [PATCH v14 08/12] selftests/landlock: Exhaustive test for the IOCTL allow-list
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
 tools/testing/selftests/landlock/fs_test.c | 95 ++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index 10b29a288e9c..e4ba149cf6fd 100644
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
@@ -3937,6 +3938,100 @@ TEST_F_FORK(layout1, o_path_ftruncate_and_ioctl)
 	ASSERT_EQ(0, close(fd));
 }
=20
+/*
+ * ioctl_error - generically call the given ioctl with a pointer to a
+ * sufficiently large memory region
+ *
+ * Returns the IOCTLs error, or 0.
+ */
+static int ioctl_error(int fd, unsigned int cmd)
+{
+	char buf[1024]; /* sufficiently large */
+	int res =3D ioctl(fd, cmd, &buf);
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
+	EXPECT_NE(EACCES, ioctl_error(fd, FIOCLEX));
+	EXPECT_NE(EACCES, ioctl_error(fd, FIONCLEX));
+	EXPECT_NE(EACCES, ioctl_error(fd, FIONBIO));
+	EXPECT_NE(EACCES, ioctl_error(fd, FIOASYNC));
+	EXPECT_NE(EACCES, ioctl_error(fd, FIOQSIZE));
+	EXPECT_NE(EACCES, ioctl_error(fd, FIFREEZE));
+	EXPECT_NE(EACCES, ioctl_error(fd, FITHAW));
+	EXPECT_NE(EACCES, ioctl_error(fd, FS_IOC_FIEMAP));
+	EXPECT_NE(EACCES, ioctl_error(fd, FIGETBSZ));
+	EXPECT_NE(EACCES, ioctl_error(fd, FICLONE));
+	EXPECT_NE(EACCES, ioctl_error(fd, FICLONERANGE));
+	EXPECT_NE(EACCES, ioctl_error(fd, FIDEDUPERANGE));
+	EXPECT_NE(EACCES, ioctl_error(fd, FS_IOC_GETFSUUID));
+	EXPECT_NE(EACCES, ioctl_error(fd, FS_IOC_GETFSSYSFSPATH));
+
+	/*
+	 * Checks blocked commands.
+	 * A call to a blocked IOCTL command always returns EACCES.
+	 */
+	EXPECT_EQ(EACCES, ioctl_error(fd, FIONREAD));
+	EXPECT_EQ(EACCES, ioctl_error(fd, FS_IOC_GETFLAGS));
+	EXPECT_EQ(EACCES, ioctl_error(fd, FS_IOC_SETFLAGS));
+	EXPECT_EQ(EACCES, ioctl_error(fd, FS_IOC_FSGETXATTR));
+	EXPECT_EQ(EACCES, ioctl_error(fd, FS_IOC_FSSETXATTR));
+	EXPECT_EQ(EACCES, ioctl_error(fd, FIBMAP));
+	EXPECT_EQ(EACCES, ioctl_error(fd, FS_IOC_RESVSP));
+	EXPECT_EQ(EACCES, ioctl_error(fd, FS_IOC_RESVSP64));
+	EXPECT_EQ(EACCES, ioctl_error(fd, FS_IOC_UNRESVSP));
+	EXPECT_EQ(EACCES, ioctl_error(fd, FS_IOC_UNRESVSP64));
+	EXPECT_EQ(EACCES, ioctl_error(fd, FS_IOC_ZERO_RANGE));
+
+	/* Default case is also blocked. */
+	EXPECT_EQ(EACCES, ioctl_error(fd, 0xc00ffeee));
+
+	ASSERT_EQ(0, close(fd));
+}
+
 /*
  * Named pipes are not governed by the LANDLOCK_ACCESS_FS_IOCTL_DEV right,
  * because they are not character or block devices.
--=20
2.44.0.478.gd926399ef9-goog

