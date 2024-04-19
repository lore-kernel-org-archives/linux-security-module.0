Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3B8132499
	for <linux-security-module@vger.kernel.org>; Fri, 19 Apr 2024 16:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713543110; cv=none; b=Fhrnfjew2B35u08vhHvmf18aphcBZLsKKa+Qyn2TVhdnTPEgiZAbg9sVpwa2DxWQLQCGFGHsoaAbfiTvDEkBFxV/4V6enU6uZ6AArPW5MHYxQjgpyCZtk4HjIRdbcfurtgMhCpR/kFk/3nAjXP+HUIf3y9/iNjBB+1EBDULV5+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713543110; c=relaxed/simple;
	bh=/T2ATdVre3nC66getn9D+RTNZJEh2jhYoVCDuKPjn0M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tXTPq74mtlSgT42JGFDiAn+vVQXCh68ugSuRJKrRWftm/OVU+nEOL53iW1aeb3Zb3AJOczmqZXta0cBen8Mvgme9l0av7HB7SB0vGnGg9bjPSKynj+VTiKctCv8Y76BCS9FiJxN4K4J62YrrBqDMXXIQuMyVnQ2l7GT4iEjJ4KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FJjfqni/; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FJjfqni/"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-a51a2113040so112372066b.0
        for <linux-security-module@vger.kernel.org>; Fri, 19 Apr 2024 09:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713543105; x=1714147905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u3Q8PluHQ2WZfMWH5jOIaXU1wUR7CEGtaUVFi0VXGVQ=;
        b=FJjfqni/E+SsH0uwj36wfUNWEZWhkDi4AjHtfCMExArPUOKY9GLcJgDo3c1ZpR8LZu
         Rm72OedZQOGq0ResXchqEuKotu85PaHpF3rilzpIjhxUmCO1ufj94fv9jlO5dKISgUZO
         ZI6tjRo6N+IAKKPKu54U/vHBRuWoZ1Bbx0J8q7yxHA7i8yGVone/+Cfx/n7oPRhPfoZ/
         v0CMorCNbr2a7KtRIexy9r1wztROX9vL06g+hMiAVo2ukxWPQGV36PZ8L4y5COa1j6F0
         bpP9yM7vCx08fLjVQkQ+ade+rYpocqBDHLhFtOCu5j6OIFdzc4CIJqwixHjTU6qjO27L
         ZkyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713543105; x=1714147905;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u3Q8PluHQ2WZfMWH5jOIaXU1wUR7CEGtaUVFi0VXGVQ=;
        b=Vx82qdMFLmjjYu7d9XTlKVanyFSGdTuuHAggUyp9dQMldq1QtetZtj3VEPk3pnAf5q
         5MjFnJYGZlPBhN4UHEa3FfYbGrxjwq0XiQmZlL/+jYMO0lHcoHdcNwsY5fFeVPB5fgFV
         HkA8A4FYlmv5P4kwXTfNLvhw9j0pur4U10EwJ74jy6glU+WAMot+gUWNMlrz1mipY8kj
         ZNDmh9SBfT9y4husxmIw/uFBxVla7Bd4yNZxPrhWE0N4CW/jSjN9w45ZaVfavEKH3WHz
         QVq/lKlASDesqiAJNrmw3rD1zWsYn0R6jeu0E37YU9Zj/FYP1eIN7cYSC5ChR/5KCrG7
         v+Zw==
X-Gm-Message-State: AOJu0YxXvu7P90yS3IAfO6dfa8VEmPX4Kje0b2LeGgXaLrsVAHfSSP/f
	5E9lWlX806wsFnVKXYogbdzcNCOTT57kC6Da0gjbANbfFkmSaaB9bCIzSCmM54hqbpkUWFG7QJn
	atPXxGtgvfVkA0eOytZfARU3o1/Ot4OqVcOCtaTAAK0I72TvXsxqZbIDYhvNiU5MqV/VBU2tXh8
	8KjBsak2e9Lxs0W3Lbg2Lxy4k9NlPLVtThqPc5Z6zilFcFciVKhYkO
X-Google-Smtp-Source: AGHT+IHcOl5SAaDcp7T7q5bwPlujuHOYqKTXXleyT6wfMJpe6DECCqjIK5YVX2PlOrj5a5ETvyGSrhnpYKg=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a17:906:2bcd:b0:a51:d7c5:31af with SMTP id
 n13-20020a1709062bcd00b00a51d7c531afmr1768ejg.13.1713543104653; Fri, 19 Apr
 2024 09:11:44 -0700 (PDT)
Date: Fri, 19 Apr 2024 16:11:17 +0000
In-Reply-To: <20240419161122.2023765-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240419161122.2023765-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240419161122.2023765-7-gnoack@google.com>
Subject: [PATCH v15 06/11] selftests/landlock: Check IOCTL restrictions for
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

The LANDLOCK_ACCESS_FS_IOCTL_DEV right should have no effect on the use of
named UNIX domain sockets.

Suggested-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 tools/testing/selftests/landlock/fs_test.c | 52 ++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index f4c6b9fadef8..232ab02f829d 100644
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
@@ -3978,6 +3980,56 @@ TEST_F_FORK(layout1, named_pipe_ioctl)
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
+	srv_fd =3D socket(AF_UNIX, SOCK_STREAM, 0);
+	ASSERT_LE(0, srv_fd);
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
+	cli_fd =3D socket(AF_UNIX, SOCK_STREAM, 0);
+	ASSERT_LE(0, cli_fd);
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
2.44.0.769.g3c40516874-goog

