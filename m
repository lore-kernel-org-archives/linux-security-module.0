Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582144D595
	for <linux-security-module@vger.kernel.org>; Fri, 22 Mar 2024 15:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711120241; cv=none; b=gH5y/uIGRI+dgJIrwBjCQDxDYY5WV3Fl25YdeKL9Paj4v3YVhGysALVTBZEEqLzNxqcAOH1t7QEol3P67oe6shUwiy4e+sSkmhBJyLc36LFUPOktW9hdJZo19LL5/pcKYlx2fl34298B37dnxMYdJY4EtJerYjNLekF0U5iKUEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711120241; c=relaxed/simple;
	bh=R63P4N4ut3QWcKBwrsSKNW9gphHCqTPMh/5hYUZu3qs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TFtth6Ji+mHGSpQx0samzjJl0fZZzMrKdQOy8VNMkNjqpQdoyk6lqx6vKbjlXAN5F8mVoxhCBM3LDL61EnIVRVPDKawY0rBZSzfNGbMMznFnsScbKt4kFYOH9DfbkwxpYf/jf09xfdlPa2gpY7ES+LwxOA3Q6eVs8TVSN6XaZxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sz9OYgp5; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sz9OYgp5"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-a46852c2239so161328966b.1
        for <linux-security-module@vger.kernel.org>; Fri, 22 Mar 2024 08:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711120238; x=1711725038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M9xd0irwbkgB8QE4v3yIoFgRxbZM8RilcqJPUwmelvc=;
        b=Sz9OYgp5515+cpnek6qEzGRbWochr7j6lqrzNOakvmM//iMNqYcGoTrK+KuA3ngkab
         GBQEBwSq4iuB9ahVMqV9mVKPtNF413I2Hg0HLI5giJXZNUmexJFREzZJqWdZRgYvBcbz
         ufAqAVIWxWJ4epF01Sj6hSd6lmHEAXGpXXFefro0PTFv03Mlxtwgh1NdAuzdM9pQLi6F
         lDqX+7Rd87PNALAidlAeNbJEqKG/vTluP0iPEvKa97DNIcNw2M4qF91VZVGb+lukGcrK
         xupmADQ67KAINzoqQeFjVmAvhBowlO9jXOCv/H6RlLOOGeRfJZ0+jBI6jANDefjf+2gX
         0DVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711120238; x=1711725038;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M9xd0irwbkgB8QE4v3yIoFgRxbZM8RilcqJPUwmelvc=;
        b=oKydZtUldX0y3xU9JE5+qYoGD8LRYDJowXjJHg1gVK6mxwOjmjvIq98uU4k8jszmOi
         cAXh3axuq1ZL3VkoKSoFZmVRJBlCYiLSLp8dGAknXm/7j7gdtLG8tNlyEe1HogqqAEub
         5B5pXDTQZxgdQPr4ZoUbPHCXbAdBZJRV2DxKM4dOOpW47LAPP/un5p+RyPBJC/NX8VEW
         uydm2uVv7bSVLsfQSoelOpsocEiwtncwCoDf3DEAYJXvjIP6MtM3Fbg20pRGPOBocKeY
         xab+NAhbY2OrV6tznJu2BHFdWOIbfMoSNr1SR6m6/YdbEsREI1FbZwr8bllEvppruKAg
         OP4w==
X-Gm-Message-State: AOJu0YwKRIW9B9tySomAfbOECnQuSFXllSbf9fbxv2IK2Z6V/jjAHvUf
	6rKcl3AxSEjEww0tPuV6OTGogjP6DQP1o/r7pQlMCouoELG+4SZTouIFxwaZqbedr3S3owj06Q0
	Yx3cndXV2H8vQ11wzJQT2NAuJiYu/ZDeSLjlPRuWPomtK+KeWALFf1Q8ImDHxyUezF934Hn8d5Q
	RI7gpJhcJK09Hio9DUltpMgbRGoisrlK5fdgvRFEDbosR95lfra5dd
X-Google-Smtp-Source: AGHT+IHn7g7WhrbCoj+qwr3+lnHh3Nzxk3BhHeFxtHPYejqb8fDsbQYGnt/pSY23Iu2Eb9T3/kTLwpxNCzo=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a17:906:4c4b:b0:a47:31bb:1581 with SMTP id
 d11-20020a1709064c4b00b00a4731bb1581mr4777ejw.9.1711120237415; Fri, 22 Mar
 2024 08:10:37 -0700 (PDT)
Date: Fri, 22 Mar 2024 15:10:00 +0000
In-Reply-To: <20240322151002.3653639-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240322151002.3653639-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240322151002.3653639-8-gnoack@google.com>
Subject: [PATCH v11 7/9] selftests/landlock: Check IOCTL restrictions for
 named UNIX domain sockets
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

Suggested-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 tools/testing/selftests/landlock/fs_test.c | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index d3aaa343f6e4..2ade195bde56 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -20,8 +20,10 @@
 #include <sys/mount.h>
 #include <sys/prctl.h>
 #include <sys/sendfile.h>
+#include <sys/socket.h>
 #include <sys/stat.h>
 #include <sys/sysmacros.h>
+#include <sys/un.h>
 #include <sys/vfs.h>
 #include <unistd.h>
=20
@@ -3976,6 +3978,55 @@ TEST_F_FORK(layout1, named_pipe_ioctl)
 	ASSERT_EQ(child_pid, waitpid(child_pid, NULL, 0));
 }
=20
+/* For named UNIX domain sockets, no IOCTL restrictions apply. */
+TEST_F_FORK(layout1, named_unix_domain_socket_ioctl)
+{
+	const char *const path =3D file1_s1d1;
+	int srv_fd, cli_fd, ruleset_fd;
+	socklen_t size;
+	struct sockaddr_un srv_un, cli_un;
+	const struct landlock_ruleset_attr attr =3D {
+		.handled_access_fs =3D LANDLOCK_ACCESS_FS_IOCTL_DEV,
+	};
+
+	/* Sets up a server */
+	srv_un.sun_family =3D AF_UNIX;
+	strncpy(srv_un.sun_path, path, sizeof(srv_un.sun_path));
+
+	ASSERT_EQ(0, unlink(path));
+	ASSERT_LE(0, (srv_fd =3D socket(AF_UNIX, SOCK_STREAM, 0)));
+
+	size =3D offsetof(struct sockaddr_un, sun_path) + strlen(srv_un.sun_path)=
;
+	ASSERT_EQ(0, bind(srv_fd, (struct sockaddr *)&srv_un, size));
+	ASSERT_EQ(0, listen(srv_fd, 10 /* qlen */));
+
+	/* Enables Landlock. */
+	ruleset_fd =3D landlock_create_ruleset(&attr, sizeof(attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* Sets up a client connection to it */
+	cli_un.sun_family =3D AF_UNIX;
+
+	ASSERT_LE(0, (cli_fd =3D socket(AF_UNIX, SOCK_STREAM, 0)));
+
+	size =3D offsetof(struct sockaddr_un, sun_path) + strlen(cli_un.sun_path)=
;
+	ASSERT_EQ(0, bind(cli_fd, (struct sockaddr *)&cli_un, size));
+
+	bzero(&cli_un, sizeof(cli_un));
+	cli_un.sun_family =3D AF_UNIX;
+	strncpy(cli_un.sun_path, path, sizeof(cli_un.sun_path));
+	size =3D offsetof(struct sockaddr_un, sun_path) + strlen(cli_un.sun_path)=
;
+
+	ASSERT_EQ(0, connect(cli_fd, (struct sockaddr *)&cli_un, size));
+
+	/* FIONREAD and other IOCTLs should not be forbidden. */
+	EXPECT_EQ(0, test_fionread_ioctl(cli_fd));
+
+	ASSERT_EQ(0, close(cli_fd));
+}
+
 /* clang-format off */
 FIXTURE(ioctl) {};
=20
--=20
2.44.0.396.g6e790dbe36-goog

