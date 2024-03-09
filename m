Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4789374F1
	for <linux-security-module@vger.kernel.org>; Sat,  9 Mar 2024 07:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709970824; cv=none; b=kwVlCcUZrS/STV1PubUlD0Sg/l5N7nw0wg5/EFaUNLea9nDjso6IM1vBD5gHz7PKufXxbRHySeCiEt8XNI3RulMBtfTQcBtchUvFLVqBA6xk1Tie2VmX7GU1onOjgKrRfB46KGw764OJfdGzw/7aTvQ+p3XKF1yYbLpEE3XGD6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709970824; c=relaxed/simple;
	bh=LnWWTWsCU0spX5jOHOmnt+NMIc+/Q5BpY3npXqS3RzI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h5DEa9uwYDGYJLeWjguLwSG8KBQ6AMYblyf8ZAdMhyagdu34WQazw0F+IEnjAnoK5H8OIzln6Dz+m3WhllkmtZkhnQs8dU6+zdAfIKniXiHTR/KHIrl5Pf2jdLimlw0pcx5zBiFWV1HOJ13y/9EdpK2Qs/YiB/Uo29iK3VRCmHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AmsyryWU; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AmsyryWU"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcc0bcf9256so2389127276.3
        for <linux-security-module@vger.kernel.org>; Fri, 08 Mar 2024 23:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709970822; x=1710575622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q5KAFkt8c3ebWOo+/ZIaVQQgVH/0sXUyTE45VSTpW7Q=;
        b=AmsyryWU0MC7E3/T1kekz88Z/FZAP++8yc0wk5BsKAqKvJcG3bpqjCHUpX8yfF2tHG
         /g2LE7gbeCJZQP2HGsBcw87s8zoPM/UYQcbv6FfrL7VuWnO1yu5VgF1R3GHhduIdM102
         5Ykou+8LiasmKc71+475/aqhVxoIMgAD5M3CUHaw/lM915rgessvd6WrtRgMqREnrF85
         inZ2QYYBxV6ilKb+O8lCQ8/YAyiQDj6mc6Hnvi7jYQw7/rI8owU9QhLGe2bLwCjMUGKg
         F6nMir9wr0QzQ/q6thxafjtFU9b9IH17AM5iTnFgDCOixmZmxiB4m5JzQoXHk7wTIww1
         z0IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709970822; x=1710575622;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q5KAFkt8c3ebWOo+/ZIaVQQgVH/0sXUyTE45VSTpW7Q=;
        b=RK+XvX4VukNDfLwbmVrGju9roy0GHpmpzsFu1rlIma/xi6ya8/2xDkPs2QVmacRLUa
         /Tez+Wme7I5kIiny8YwYLZnckvmD1nHwMZhGlRKVrEjmrMguZYFMFYFFU4jfaXAco7sa
         DvaP8f1PU+u+wCdeMu6wu796G9kQNoefgnexJdQsXHkFpuLPZIgjZ1KPSjl8LudRy1Gv
         8PSBoaBRpVJbkW/dfATN1Ryd1GLfjTlFfFeRq8Z743h7lf6P4G83r7mcHqCdlJ1oAWCS
         OsWTawtWYuwo4t/G2qucVG7OUSjJL00nLu8tAgYy8Vdhmq2urTXW9UmptTHGDc3/xiK6
         E/Ag==
X-Gm-Message-State: AOJu0YwdNgEvuFM7oqhriCXlpjJ94DOk0c2XSj39KgkHrP81exDBUc8s
	Bw3prtQRfJnvBvAToA/5niYyjwoSgXK3PwEoVSkkWEoIGAD4CH0pAF47QMcERgc4ZK8JKwhCQhI
	VKIyvGsb+aZHGvbnRtD/kwyT1chojNKKKG4qeuCKdY+lboQ+w1Z0/DjxlQuP53x6jtlYLc75aLr
	uL62L3PPRwJW2LkzG/p+YtuITvjtVvvWjqD/xIeGNg+xnAbTKVOpcP
X-Google-Smtp-Source: AGHT+IG2UzW8T2XXCnZ0WKef9syIHtSKgT7HVGMP7GTket6ehHLA9AR/ZmA/bywD9mEzzCuohI2AJvz0ozU=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:6902:1143:b0:dcd:59a5:7545 with SMTP id
 p3-20020a056902114300b00dcd59a57545mr64713ybu.10.1709970821249; Fri, 08 Mar
 2024 23:53:41 -0800 (PST)
Date: Sat,  9 Mar 2024 07:53:18 +0000
In-Reply-To: <20240309075320.160128-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240309075320.160128-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240309075320.160128-8-gnoack@google.com>
Subject: [PATCH v10 7/9] selftests/landlock: Check IOCTL restrictions for
 named UNIX domain sockets
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
index d991f44875bc..941e6f9702b7 100644
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
@@ -3976,6 +3978,57 @@ TEST_F_FORK(layout1, named_pipe_ioctl)
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
=20
--=20
2.44.0.278.ge034bb2e1d-goog

