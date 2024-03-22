Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC724E1C4
	for <linux-security-module@vger.kernel.org>; Fri, 22 Mar 2024 15:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711120235; cv=none; b=AlmBZQ8wa9HZHr2HVUjtZsXfLKLotUQZbojqmBOyUZ2muMDXXCmrjLDRsUd+EtDcY34vx5+loWVig0GY999JYao/M1oA9kzSQ9UDh8oHlUw6xDWuKN3Fl8OvzurrA8kzRXASppBc9iUCRzurmzexrSOa147ENFuAiyKlBWltSMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711120235; c=relaxed/simple;
	bh=HzbXoAKj1O2Axw/b80Ha7oRq747pOMPBeo9PHNh77I4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AH+ijm6L5nQiqMoWjrPUpBLuYfIm/eOBiESgN4YSj1XC4Rn1a8F71Yx/W4itEElB3dHYXHoVd8ay2DWpuYIYqssyDVpWorQ8jdhrmX3ez+zzxG51hPoLXIC0tN/2L6/oL3/OUG/X8As9VuFD4SgoyhMdHJ84eDBCUxrf92wTSMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1v7j8ggj; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1v7j8ggj"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60cbba6fa0bso42942637b3.3
        for <linux-security-module@vger.kernel.org>; Fri, 22 Mar 2024 08:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711120233; x=1711725033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WK2iXIrfoq6Fz3IO0C5eVV32OG2FmcAULBO6/ELXu64=;
        b=1v7j8ggj6NwLNkUhsMNVaDxzFqBz3qp3KXXWb/6DM/utylO4tpyqxkNoCmuaUzN2IH
         xmMdWOxzGm13IbxuIjQSLbEzFviu4iFGJRPbUUKLsm1JxqehnhZ1bWxiOHXWp+njmbOQ
         xH9pLh+ZgvLQCmJNxWHZX1Y+iWHy3sZMEFeMPMwk5+wEWA8JYjxDnM80H3ZNyR7p3ftg
         FFHXu6p7qbn94inFIv1bPvBLccJlpbXkyVJu5dVYw8nMUGK/rw5keL7WUnpNLlrh5Ce/
         6wZ1xVJduQbtEm60rmajcq7b9YhWcCPnT33LelNi8yVuMvp0Z+pEZdM8xDXsHE8TsFbZ
         GlJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711120233; x=1711725033;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WK2iXIrfoq6Fz3IO0C5eVV32OG2FmcAULBO6/ELXu64=;
        b=UxY+EhldceLsPjAM/S3tEixrYuNgWf5hXI3GQYGsKP+JAqNJFJe+HWHe6tf6VNngVM
         oxM7G9txV50hdcLCXQvum/zr3KTwSNDOmUfxzOXt39qhA7AoXSbXx52aksiTK8Aov5sF
         iEWq6TrgHtJBNl6MsLyK5qhVgKExGebZ7QjgQASxYXJvT+9ABNaTnFtzHxPt79PWLYOi
         TvA5gi9wMGRgGz0bQUb0F+UwujEq7ICzGrKfM3mEjm17tTWceUOR61LURDIxtSuNOFDP
         42ryD05yRSODvBzz4MTRCN50WlPe5rGe22N4fUdODuKQb5/VCX3hYm+j0i4YtC1LNbnf
         tJ6A==
X-Gm-Message-State: AOJu0YzArstODCvJpD6Wy7rhb+KfBEWXlbnwzNBzxmviHTDZU8g/UkYD
	cUMMmS2NR2MrHZh2PKf2duH7O41ZHG2RGdI2YJOF6H2rxJU+B9lJp9dP5r666VgFrNPfMPDgHKb
	AX7UMUgId5e/20WXxjtx5jJha3g9VuW2PyUU3PXoqagWruDIEuLoZXv4ycSZShnsxZV752iR4D/
	8A6JKgJsvld41i7cbfKvtJYKpjFThc+NRImT0D7FNGdhQ05gaJaoW7
X-Google-Smtp-Source: AGHT+IE/skOcqhwr+ZTj08fMTLjErgP9sxDZA9kKjc1KHwbR43EKvperDiZY9OJDs96Y5WSECFwxnpc28bg=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a81:9c0d:0:b0:611:2ae5:2ea7 with SMTP id
 m13-20020a819c0d000000b006112ae52ea7mr151930ywa.6.1711120232760; Fri, 22 Mar
 2024 08:10:32 -0700 (PDT)
Date: Fri, 22 Mar 2024 15:09:58 +0000
In-Reply-To: <20240322151002.3653639-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240322151002.3653639-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240322151002.3653639-6-gnoack@google.com>
Subject: [PATCH v11 5/9] selftests/landlock: Test ioctl(2) and ftruncate(2)
 with open(O_PATH)
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

ioctl(2) and ftruncate(2) operations on files opened with O_PATH
should always return EBADF, independent of the
LANDLOCK_ACCESS_FS_TRUNCATE and LANDLOCK_ACCESS_FS_IOCTL_DEV access
rights in that file hierarchy.

Suggested-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 tools/testing/selftests/landlock/fs_test.c | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index 32a77757462b..dde4673e2df4 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -3893,6 +3893,46 @@ static int test_fionread_ioctl(int fd)
 	return 0;
 }
=20
+TEST_F_FORK(layout1, o_path_ftruncate_and_ioctl)
+{
+	const struct landlock_ruleset_attr attr =3D {
+		.handled_access_fs =3D ACCESS_ALL,
+	};
+	int ruleset_fd, fd;
+
+	/*
+	 * Checks that for files opened with O_PATH, both ioctl(2) and
+	 * ftruncate(2) yield EBADF, as it is documented in open(2) for the
+	 * O_PATH flag.
+	 */
+	fd =3D open(dir_s1d1, O_PATH | O_CLOEXEC);
+	ASSERT_LE(0, fd);
+
+	EXPECT_EQ(EBADF, test_ftruncate(fd));
+	EXPECT_EQ(EBADF, test_fs_ioc_getflags_ioctl(fd));
+
+	ASSERT_EQ(0, close(fd));
+
+	/* Enables Landlock. */
+	ruleset_fd =3D landlock_create_ruleset(&attr, sizeof(attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/*
+	 * Checks that after enabling Landlock,
+	 * - the file can still be opened with O_PATH
+	 * - both ioctl and truncate still yield EBADF (not EACCES).
+	 */
+	fd =3D open(dir_s1d1, O_PATH | O_CLOEXEC);
+	ASSERT_LE(0, fd);
+
+	EXPECT_EQ(EBADF, test_ftruncate(fd));
+	EXPECT_EQ(EBADF, test_fs_ioc_getflags_ioctl(fd));
+
+	ASSERT_EQ(0, close(fd));
+}
+
 /* clang-format off */
 FIXTURE(ioctl) {};
=20
--=20
2.44.0.396.g6e790dbe36-goog

