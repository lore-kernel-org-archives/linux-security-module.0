Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA130156C6E
	for <linux-security-module@vger.kernel.org>; Wed, 27 Mar 2024 13:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711545054; cv=none; b=L9OvMOyIOFKYgVN+/V9S7AzFMgIRvDUIbs7Oom3Gw4w1/Bbe4qglniSoIU+aXNxzHAtVV1vRTWYZWnar0ZK6xemp8C8QXtEMPJruY+gyQV60EJlfmBqIRCptZGrZchEN4z0mChNO2B5AjC63tgnYJUU5JJSK16Yl5PLmlliq+s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711545054; c=relaxed/simple;
	bh=PzJGa2HfpgVLnDUpmLGlb/dqvpX/FkFzABSz1we97A8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q+mqPehuun7x1utDsyG8RSSAITvr/6aD+SvrLhCSUy3e0NLVtxC2uurV+MO4hvgC2T0yuDimT8lyRhjR5Nf3Gzwra+VxxC1qr22wGqs9IWSQBV7aiIvT1xTndsssZOd7vTPkzcSSUmPmZDhZINo2ObbcpvPdsvbb7pop/Dx1Gt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QGsOOdfY; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QGsOOdfY"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a0815e3f9so100244997b3.2
        for <linux-security-module@vger.kernel.org>; Wed, 27 Mar 2024 06:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711545052; x=1712149852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fzPTTiV8TDpQ+tgkp4cOnmhSmJYTm/HQtupr8LnZc4k=;
        b=QGsOOdfYjmnJZ2pRrEZqH4S56dFUYuYftJtZvhX3OZ5L0U7nwXLc4bhYPay/nvhNWu
         v3KNYOmdlwa3eOMZop/mrUz2/1ZMlPCrfLaK4U/f99Kfxs+QcCymrDZYlt/DHXolFfFI
         ijY7HiYGfLz0zKZE7wit1sr4ursH1KRxVi0Ic+q6y7V+WKo+T3RBrRQeDdVdyIS9V2Iw
         8ppcnbdxzga6Zsal6JG1QdrcfELp49FWvpnRw2hMlmUR5PNNNlg3sSVV5HAtrI0PvV32
         fZMcTmZS1DtlOQr8HotKz5pY8t2LhOzOL9x+K4wAJbjzjiwUqLRdp4o4SWlRHOSzpH2K
         iq4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711545052; x=1712149852;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fzPTTiV8TDpQ+tgkp4cOnmhSmJYTm/HQtupr8LnZc4k=;
        b=B7BCIWaBXwiLdYi/D6q2JqdVuvHHpswIVfQUVoYQvUmTGbb7ZoTeJZG4S7C7HQCOIP
         HRD22TLtCdT6X5/Q8EPPiU4wXtG+Xomqxb+Hia89e0LRa+CU+HTpszo7d6FS/AVnIVml
         c5F9oDAl3Gw7/innQbmsL7p9mC5tmyeoXq6v3pLXbMnbGfywlxslItrrWFfe0XE6CRe4
         qteJRpVev9nhWnAEnt+PHXlzsxx89NKRx1DahW2ZnreM6pvPmS0zwAEABNIQ54gXZ+mu
         XnihATtRPl5Oaoxo5Njex6qxy1K2HOIJbeAlqysmGauuQbhiPCQiRdAQNo55v/Vjfb3h
         RC4A==
X-Gm-Message-State: AOJu0YyN8E1xv1j3twk4q1XU+EEROabSQkuafh3y2HtBJtXVekyYVY4e
	FTQ6nnp+7bfBr6Bwye/ydDnWU6OTS9PD8FT6PYy2d82aRJ01cqOrXmsrXwxSEPdjGttpryKHY6r
	mB7+AMFikFxUsRqyorRpHw0Cliwh28LLd67cvCcowu8j9FTl1Mp+wIIJrxhl5Jfgos2YJk9ybqN
	XCYxfa+HUxELFBvXX8aa5c4NsbXUc9ctXl/2cDU4QxKoprCwvrZRXt
X-Google-Smtp-Source: AGHT+IEj5xyB4jlBs/VuCQSCdpxVwv1JNV8jFOzaRyekrjl3/ZhBrgLDgewF4InBk9/iYczmvVC4h1KlHSI=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a0d:d556:0:b0:611:a036:221b with SMTP id
 x83-20020a0dd556000000b00611a036221bmr987965ywd.9.1711545051877; Wed, 27 Mar
 2024 06:10:51 -0700 (PDT)
Date: Wed, 27 Mar 2024 13:10:33 +0000
In-Reply-To: <20240327131040.158777-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240327131040.158777-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240327131040.158777-4-gnoack@google.com>
Subject: [PATCH v13 03/10] selftests/landlock: Test IOCTL with memfds
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

Because the LANDLOCK_ACCESS_FS_IOCTL_DEV right is associated with the
opened file during open(2), IOCTLs are supposed to work with files
which are opened by means other than open(2).

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 tools/testing/selftests/landlock/fs_test.c | 36 ++++++++++++++++------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index 8a72e26d4977..70a05651619d 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -3852,20 +3852,38 @@ static int test_fs_ioc_getflags_ioctl(int fd)
 	return 0;
 }
=20
-TEST(memfd_ftruncate)
+TEST(memfd_ftruncate_and_ioctl)
 {
-	int fd;
-
-	fd =3D memfd_create("name", MFD_CLOEXEC);
-	ASSERT_LE(0, fd);
+	const struct landlock_ruleset_attr attr =3D {
+		.handled_access_fs =3D ACCESS_ALL,
+	};
+	int ruleset_fd, fd, i;
=20
 	/*
-	 * Checks that ftruncate is permitted on file descriptors that are
-	 * created in ways other than open(2).
+	 * We exercise the same test both with and without Landlock enabled, to
+	 * ensure that it behaves the same in both cases.
 	 */
-	EXPECT_EQ(0, test_ftruncate(fd));
+	for (i =3D 0; i < 2; i++) {
+		/* Creates a new memfd. */
+		fd =3D memfd_create("name", MFD_CLOEXEC);
+		ASSERT_LE(0, fd);
=20
-	ASSERT_EQ(0, close(fd));
+		/*
+		 * Checks that operations associated with the opened file
+		 * (ftruncate, ioctl) are permitted on file descriptors that are
+		 * created in ways other than open(2).
+		 */
+		EXPECT_EQ(0, test_ftruncate(fd));
+		EXPECT_EQ(0, test_fs_ioc_getflags_ioctl(fd));
+
+		ASSERT_EQ(0, close(fd));
+
+		/* Enables Landlock. */
+		ruleset_fd =3D landlock_create_ruleset(&attr, sizeof(attr), 0);
+		ASSERT_LE(0, ruleset_fd);
+		enforce_ruleset(_metadata, ruleset_fd);
+		ASSERT_EQ(0, close(ruleset_fd));
+	}
 }
=20
 static int test_fionread_ioctl(int fd)
--=20
2.44.0.396.g6e790dbe36-goog

