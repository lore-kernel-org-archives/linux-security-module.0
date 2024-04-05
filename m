Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A23C17557E
	for <linux-security-module@vger.kernel.org>; Fri,  5 Apr 2024 21:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712353287; cv=none; b=qPtCf2CLIRlaRIBLm15yi1eLsxSS7DgoS0xt2X/UZzEiyJRlFapdst1+2O6c8uBhOrKOmiR4+XTJ2YEhwHQkiSyKwF8zxuPooEWlOzYxNa9w7FSdB4IqoWbQQ0haRRpnicwNbWKl8bxwc0dOA2ZI/JK9hJqH96FOvSsBAAVtuJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712353287; c=relaxed/simple;
	bh=XrnYYxI+KCCO+Qa5vPr3MeDGJNYdQzakwnKE59Nzsts=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kLQkYJNQb9GYLWeutqRW7h0gM8IaGCwAOlGR6f6HaH8z/dQlc/TFEumpdLfN/z5we/mwBPh9U3ZOZELE/i8ngQ7bAll7aKaJ1rCHYMX4sERsVptcHAC3qsK1utFTiFgFO43rU1oAu8Q4n5quPSCy3ljE35gPJn/uer9H+hoCJls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JpfQD9XZ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JpfQD9XZ"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbf618042daso4149251276.0
        for <linux-security-module@vger.kernel.org>; Fri, 05 Apr 2024 14:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712353284; x=1712958084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nBbNmNFl+n5lpfyI1mNxnpRrGBsCnYQndb3n58WFmTI=;
        b=JpfQD9XZoe4ha97rfIvq5FRM1dXGLRDwp0FKxuxpjURBHQ5hkrRaf+pYzQfdM930x4
         8tBaBJriY46QpY9vhgToDOdAfKNAJ8kq1iUQGCKmMxFgUQkPgFJEAnC4Aaq7iTL9+Vqj
         Hn+e01OegOtYAFIqRX6n9zxQ6H3lVcZZFQpALV5QtkxMX8DXJQpCQ1sXO0lJhZGccmIv
         i8K4cwBk/hEs0DgxQpTWrSP+Z2GMk3Z9GwRSI6zovzG2wcCPX9RutA4L2B2KaGDpWlDi
         /DU8Zyp/SI8+a5l0bs6NA9GefdGGjExziZ00YJCJWGkcGvCgcA0bFOCMen2GPQwWj7dI
         80uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712353284; x=1712958084;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nBbNmNFl+n5lpfyI1mNxnpRrGBsCnYQndb3n58WFmTI=;
        b=XC4xirJvzcrYyqh8XwyUBl/bSn4N7qBqYAS/rCB6SXj4TCfCFvbVHjf3wcXIijWtdX
         tl3bKP4bkSFwv7j+yIy6FLVptUVQH1pN35aCYTyq6cA78qK9RxoK5XDCZaVO30zyhnC4
         V47JyxNdk9lYVV0bpEkQqvXT04BsG5NUMRXXt0In5OnJXQMgz+2unpa6teUiiNGzm3cD
         lK96hIY7FBlQlEu6c4BcgD4ijlNW3qaUrC8QZVvb3POj0PlLL9+OjsAUssaTjpED1Msd
         WdI+pkyfLi4JZWch+i0StlndVBPa4TTqm3TGj9SL2ZcSgS5DBd7uIlCAv1kPSAZmPsRl
         sBjg==
X-Gm-Message-State: AOJu0YwOV0kDwwqqps1D/+eOPcVCVJZrS8wQxZ+dXBFTPX2oJk56B97W
	21KoEpWHwI1QYkDv89uU6WoxbE6lZD4omBzcTjqTnF9IUs3b05O4/Zl/oErIUowmtBHyzrRMWY1
	hSpI6SXI5aS9tmMHasTUK2fVZTxi/y/Tv2Ypho2qDaHbOHZrZRjEw3/ds7Zrl/XDh0qFK+ORt7l
	AS8GZSdi7djuV8IxPu+T5BDJfWXodHc+CVVTH4zQObiNjIAZDVPOOA
X-Google-Smtp-Source: AGHT+IGlCqhV+FVUp2mV1SdfkGDRhN8E7j+1Aly5UutobdCKC56eYKvbcj9nPfvjhlxl9RyHI6kcUe7DqJA=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:6902:1502:b0:dd9:1b94:edb5 with SMTP id
 q2-20020a056902150200b00dd91b94edb5mr220907ybu.10.1712353284398; Fri, 05 Apr
 2024 14:41:24 -0700 (PDT)
Date: Fri,  5 Apr 2024 21:40:35 +0000
In-Reply-To: <20240405214040.101396-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240405214040.101396-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240405214040.101396-8-gnoack@google.com>
Subject: [PATCH v14 07/12] selftests/landlock: Check IOCTL restrictions for
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
 tools/testing/selftests/landlock/fs_test.c | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index 215f0e8bcd69..10b29a288e9c 100644
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
@@ -3978,6 +3980,55 @@ TEST_F_FORK(layout1, named_pipe_ioctl)
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
2.44.0.478.gd926399ef9-goog

