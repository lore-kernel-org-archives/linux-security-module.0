Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B37151C4F
	for <linux-security-module@vger.kernel.org>; Fri, 22 Mar 2024 15:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711120237; cv=none; b=tOg6bicQrX/6Xg+axXSSYVAfyH+yDZBUJ+IRQeYY7+c392fdvCfyzBaz4sw6IAog0lLQmXvxSNs2+mw62Lzo+YAv2Mj9LP2XemXbStLKM4EoNhxgF2q5Amkl+i9cf29BJldIPRv5tZ/xTQOmMIQg9mu5MCjXnhF/QQdF+pjKCac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711120237; c=relaxed/simple;
	bh=4Wux5xa/CaSDeSCUYomCmTq0IllWEfYpxAtQo5oE6Es=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PeGWqBCSNCyvlEN/wT4Bpuo9SyY6fee0n/eeftoBeN1OmLXcI0H4SMIzNPLivlyGzpedArjPrP37bGnim7hL3BsrIkQYWajoEikP23FoD6Mvo17d9S/W5x0WKT5ZI354+sOCg/8YfhVIGiZlBU8dQ9/YHlY3ucGpUV1jVr5VGZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=peNyGOeC; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="peNyGOeC"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dd0ae66422fso4306798276.0
        for <linux-security-module@vger.kernel.org>; Fri, 22 Mar 2024 08:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711120235; x=1711725035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wVuQbOd4o/tS0DiPUw74ee5jBWWOCcrb2jESG2kQjGE=;
        b=peNyGOeC8vSxwz3XojdjjoNgm5aCiv1hqGFDTPkWg6bH2Ck9Sy9f4ZJ87SG3vaewUS
         XuFRIjSrBuQBXbIPUFac4xmcsFBczcEwZoJ8+xiH6STg5LKEDpZVqMvNREabJx9KgpH/
         QUq4o1IM3w6aXpjqC4Lc4EnPhZSiqCAk7UcwCLLhb5l0e0Yy3KJEFy66teZwbCUBr2io
         btoo1/j47SDxqsHW20OhupR8/M7ZNn+XHHiZLSRFLbRvuVEbeoTWPPH0IV0HErFLUFcY
         uSQKjYx5yWpguwMNYu8hnAvrxkyC48w74U3i3fPZSTlU1O1rBLXMXShRxPiuiVd0M8KP
         /aVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711120235; x=1711725035;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wVuQbOd4o/tS0DiPUw74ee5jBWWOCcrb2jESG2kQjGE=;
        b=prd4De6ypKL8/F8G+nTI+ydx4jQctntdxcjXtPDEJ2yATTMe+Pub1tmTDszXswO8gn
         WeGk52lL977da0BYJvsw/E/DK6FVymT76CWS7dEuM23uFso+CiQjDxgiKp4LSnI2zrZv
         ZBRfMz6/CG1v9XT/6lDnLnkeJOU31JDs4YvHN5/jtgmfcyfdXduwMZPae64FTQU55xDw
         AG24XYcSoXxQugkP2GJYUP2sEazyL69CN/vLtnUxrRWlL3aTEZaS3303Xmk9U2PlNrss
         CdmtPddengOG90V8hOHts27ghai5vTzk6lMbBnYztL29QtdQrjosRrFtJpZhDWSftBZA
         8ZVg==
X-Gm-Message-State: AOJu0YyPcCDLrXNy1wOsBbM92azpjfHBnd5dCvEuW9G3tdFytNfFp0Hu
	B+jR0VDtoTIz1I7z4llLDfCYVxZ1f+U1kR22w5i9hOA10j3VQU+IwU6GKW0YN4iDeAsDrJGL+as
	yzjtQMFpQoOp8l7N2lAdKPxgifWgssK9gU+R5dExPv4hH1L5UuY4rf0hnAWGd832aM4pEqUom9J
	Aqpxk37XNpUJYNZ0J7RTU0is2Jt+ibcYLH3pw4me6uS63wVkn+hEqs
X-Google-Smtp-Source: AGHT+IHdoIRrYCQ5q0Pp2bP8dBRgqXOW6UZEosLGOrjKbm9gVcMoCyJPSj2NcTPjlJog/th1Dcb8QRDIEhE=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:6902:1a48:b0:dc2:2e5c:a21d with SMTP id
 cy8-20020a0569021a4800b00dc22e5ca21dmr624303ybb.6.1711120235018; Fri, 22 Mar
 2024 08:10:35 -0700 (PDT)
Date: Fri, 22 Mar 2024 15:09:59 +0000
In-Reply-To: <20240322151002.3653639-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240322151002.3653639-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240322151002.3653639-7-gnoack@google.com>
Subject: [PATCH v11 6/9] selftests/landlock: Test IOCTLs on named pipes
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

Named pipes should behave like pipes created with pipe(2),
so we don't want to restrict IOCTLs on them.

Suggested-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 tools/testing/selftests/landlock/fs_test.c | 43 ++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index dde4673e2df4..d3aaa343f6e4 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -3933,6 +3933,49 @@ TEST_F_FORK(layout1, o_path_ftruncate_and_ioctl)
 	ASSERT_EQ(0, close(fd));
 }
=20
+/*
+ * Named pipes are not governed by the LANDLOCK_ACCESS_FS_IOCTL_DEV right,
+ * because they are not character or block devices.
+ */
+TEST_F_FORK(layout1, named_pipe_ioctl)
+{
+	pid_t child_pid;
+	int fd, ruleset_fd;
+	const char *const path =3D file1_s1d1;
+	const struct landlock_ruleset_attr attr =3D {
+		.handled_access_fs =3D LANDLOCK_ACCESS_FS_IOCTL_DEV,
+	};
+
+	ASSERT_EQ(0, unlink(path));
+	ASSERT_EQ(0, mkfifo(path, 0600));
+
+	/* Enables Landlock. */
+	ruleset_fd =3D landlock_create_ruleset(&attr, sizeof(attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* The child process opens the pipe for writing. */
+	child_pid =3D fork();
+	ASSERT_NE(-1, child_pid);
+	if (child_pid =3D=3D 0) {
+		fd =3D open(path, O_WRONLY);
+		close(fd);
+		exit(0);
+	}
+
+	fd =3D open(path, O_RDONLY);
+	ASSERT_LE(0, fd);
+
+	/* FIONREAD is implemented by pipefifo_fops. */
+	EXPECT_EQ(0, test_fionread_ioctl(fd));
+
+	ASSERT_EQ(0, close(fd));
+	ASSERT_EQ(0, unlink(path));
+
+	ASSERT_EQ(child_pid, waitpid(child_pid, NULL, 0));
+}
+
 /* clang-format off */
 FIXTURE(ioctl) {};
=20
--=20
2.44.0.396.g6e790dbe36-goog

