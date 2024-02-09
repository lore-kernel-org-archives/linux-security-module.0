Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDE47F480
	for <linux-security-module@vger.kernel.org>; Fri,  9 Feb 2024 17:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707498396; cv=none; b=jqRdorx3FRc5JdL8XA0UE55sIli8C2nQ/xJorGG109tspcncgCk6iMFFX5FBqbS6JIQDd+R3vN+Ks6uSy0i4O+B0KM41u3jjqrJXGR8mM9ZnT/DfnOcVvS1DPNdmH533D0UgoBf+bNAQM6CYs9wfp5kabmRBh+aBfaJxSYerLCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707498396; c=relaxed/simple;
	bh=ZOMMoEDQ5xIGIh13zw5bCfNnxE82fCIe2LgtgMyom98=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=lMLGl9RtTEiDSkbp7oiSzxN39VcgidQz+PiDJdZsqO2qb1yTo5PaLmrJvrMVLEeZA6tE2yv39j65mb55ELyfUhGW5XRYHH7szUmu4WouKoLm2udLeIk2008dYg5CkojAydG9OIVqho/RxtrwPNkig2N3OT5oAayHNjCwcQyIaIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wvYgzuwv; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wvYgzuwv"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5611e1da4c6so822647a12.1
        for <linux-security-module@vger.kernel.org>; Fri, 09 Feb 2024 09:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707498393; x=1708103193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+kC6dT4IyBTfeBcHN42EnhFy5ZpJ2/rUmLiDKj8ztc=;
        b=wvYgzuwv0BVe4kqj49qaEVMDC8Rw0A+H/B/1rN+utWgvAOy4ycvKUt6lT33qUK1iMi
         w1pHzgAV7J9175qCvgVMwtbVQYyZO48Dgqa8B4LvDSq2DiTeVa8Tj1Gcje1RFkx5cKcy
         i+vO9T7vAYBhJqXdSIQvT3GbGiNjaDHCzCVYFTqija7gnGheALk+c550ziiTT5vAIWlc
         4iIpGzcllFqfkzYnFGy+XMvfnKopglsyEv/c4r/2mtZtOFNbC6eDT4FlFkPCQLVv8dWA
         NKRzFFVKflOnk668cy4pXz0aaqRfg6SmHs2Ra2kS4tqcVljxZUdP/HsQPZnytURI4wVN
         /C4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707498393; x=1708103193;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o+kC6dT4IyBTfeBcHN42EnhFy5ZpJ2/rUmLiDKj8ztc=;
        b=a5g5SGf/uX1VRS5kBwSpk/MahXelITODyZVwHSJcF3hJtiUxXeZpars2FDIRw7R3Wx
         lJ3j2kUubslkmLylduPljES6gHm5Ql3Y+y56nMdxVK01Cq4w6ZlF3dXt9QVJUzqXmM38
         Qgs7+XG6NS14uDgmAkwelMfZ6VaVJM2iaj/ERX+TAWnMiuqObqXPCdxLngD7tpwOERim
         KagdAZ/cOyx91SsCmKO1StWg9o22K6G9d5Q936APbQ9QtZzZyZcIto6JsyXea4AzC21a
         tdqeoLG4r9yuILk7EwlreA1UjIbZkNqYhnwWN/eWp5k0Tc48WRr8AYJKa7glPbhmR5FE
         Rwlw==
X-Gm-Message-State: AOJu0Yzil4iKRdv5qux1zIFJp33anSoqPUeRHlL8Lw4acKX1eW/qITJc
	ECiXdlAjKCU236Emomxa2yywpMaB5DGPSOU9saWFv/IHDlM1uwEbMozo4HMwYSOQKIO9dzwfCP7
	hsnom4qwgaVR/fkv7Pk3HR+ucliGR75vuBl0BRniyhX5xNHP5XoKdmL0h6oHjTH3ApX9K2CKfdx
	CD4L4VKve816vVNZEKS8ZtUvN1xwz6abvda4jY6wRtUbPVllkA9IyK
X-Google-Smtp-Source: AGHT+IE+S3vXTRJstlGpyHPrIzXl4dpZ7xz7gmneKPNSqhlpVLJgSelFzxDYg6Ih094UIcOnll2O2YPkRo8=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:3162:977f:c07:bcd8])
 (user=gnoack job=sendgmr) by 2002:a05:6402:4009:b0:560:b996:189d with SMTP id
 d9-20020a056402400900b00560b996189dmr10674eda.2.1707498393599; Fri, 09 Feb
 2024 09:06:33 -0800 (PST)
Date: Fri,  9 Feb 2024 18:06:10 +0100
In-Reply-To: <20240209170612.1638517-1-gnoack@google.com>
Message-Id: <20240209170612.1638517-7-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209170612.1638517-1-gnoack@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v9 6/8] selftests/landlock: Check IOCTL restrictions for named
 UNIX domain sockets
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

Suggested-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 tools/testing/selftests/landlock/fs_test.c | 53 ++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index ae8b8b412828..59b57ff6915b 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -18,8 +18,10 @@
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
@@ -3983,6 +3985,57 @@ TEST_F_FORK(layout1, named_pipe_ioctl)
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
+		.handled_access_fs =3D LANDLOCK_ACCESS_FS_IOCTL,
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
+	snprintf(cli_un.sun_path, sizeof(cli_un.sun_path), "%s%ld", path,
+		 (long)getpid());
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
 /* clang-format on */
--=20
2.43.0.687.g38aa6559b0-goog

