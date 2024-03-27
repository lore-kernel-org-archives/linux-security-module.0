Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51675156C6E
	for <linux-security-module@vger.kernel.org>; Wed, 27 Mar 2024 13:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711545056; cv=none; b=XtICPhVkRus1XyGl0bUi1wogzgGCbVEJX/A+rR+PLWsu+ijYuUMjYoUnjptkvVecAyxn4MrDBWofz30FRBwrLnm18KVBx5YRDIDIjbGKnYaMJNql7tkElCkSnTjlbMwUVss/WUb57997n12XvJkAO/3E6zrba46iVLRwlbBCyJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711545056; c=relaxed/simple;
	bh=acx0Ig6zx/b3PNLTqaqnPb+8RFRNMEwwqyvk1f0LBeQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AgGpaOvbEgzuvMdRCjwzfU+cquLdOlJSWtLtx8AhMEP7k58QqFRRi9G8h0TohULXCPmckP/VheKaM78NuMXSzlR031n+y3Lgev5TFcbN/LuLJZBVwhHSD2Eq08r819oz4VtSfZgoQRHQ32jldcSqPOW2M3CRgIEws4AGsCz640o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XSRFmGIt; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XSRFmGIt"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60cbba6fa0bso122792957b3.3
        for <linux-security-module@vger.kernel.org>; Wed, 27 Mar 2024 06:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711545054; x=1712149854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=naM6bY08Mum2KbRgHMSO2IN9IcwPwFSqOEkQdjMZxnY=;
        b=XSRFmGItJ1D0XyrHTKZl1eMDvCB5Aeadkb0dAgz9klampY0VgAinarUzY6G2IltBhY
         vGQ3r3dsJY6QWtLYPbAxZ5RT5BUIpHoiktHMROMGYtan9YqfzTgaxSo0XA7tZ77i1yKh
         l+K1nMwaswTlKeXO7+0vjgyNA90nzLoMJdH7EP1r7y+6bJyzzRB1cAvKPCl3GmQpSZIx
         hS7m6s0jhs8ljtAMLQD7zYRUiaNJ/ZfiE6aNE5FLtxJWTkv4FCuo9H5XtctnUPxuXAUK
         jfLNsxxdPpn/W9Y0coC0777n0HtCNdI+hcFnYpffMpLg4kaWbRhnbQTbgDZ0ypQ4FhVg
         7QpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711545054; x=1712149854;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=naM6bY08Mum2KbRgHMSO2IN9IcwPwFSqOEkQdjMZxnY=;
        b=EQ4EZ7nf6ItsbXHCu62Q8ZNIkWZGB3NVAaOjStdcY0eNIWv6AerKrV/lBwICdpqEAu
         u/9eBxZNpDOxsONLEDyeJxSGx+HkrFUP3+ZcXaVpNLOjt9tE0D27zQiSL0LTe8WVvAch
         kHQhK3N4I0DOQhDGjlD+Uh25iiVHWOSJnINUM7/qB25t8/q6/kgymV0qePvz4vamYL4x
         BtsuwQPrqHrLkgftxPPvIEljuoOgB9JK4hlThKVCSCFKoWMtK1iX/pYmEHf+GKHZjvQr
         JZfRUo5as6o6S6/TaTYmIkUZhEOKQSFfc7wJSLUOCitQWzGQxd5EKAHtm7x3m1T+GCx/
         9QRA==
X-Gm-Message-State: AOJu0YzcP3zLS/2/tQKLCTj+5FlCy/S6Hxc7GvdDHD5ga2VMKrqeXQGn
	170JMyZLAQkaMyIzT1sEu71NiILFl5aQfm02b8DbIJULnXNpXI8M4IIvrC2e1f4OJk2sB3UL1dS
	uXa/zoe/gU6ab5SKpKkSnOD82EVpIbaOqPTN4Se3v+faTtVXAMJK992t1bO9eawT0PZ4VVnf3ds
	iVxJWhRhkjiZeXuP/aC6+FAHnmTTdUJQyOpETYn49VJsBK0mrjESVN
X-Google-Smtp-Source: AGHT+IFpQKC46C2Bv0g0o9mrAZP8H45cgJ/wi13og8nt1PpdGAE4hPBVv2OhH4eszhDwOvakr2Ef0NV0Udc=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a81:5408:0:b0:609:f088:cf9c with SMTP id
 i8-20020a815408000000b00609f088cf9cmr3139450ywb.1.1711545054331; Wed, 27 Mar
 2024 06:10:54 -0700 (PDT)
Date: Wed, 27 Mar 2024 13:10:34 +0000
In-Reply-To: <20240327131040.158777-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240327131040.158777-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240327131040.158777-5-gnoack@google.com>
Subject: [PATCH v13 04/10] selftests/landlock: Test ioctl(2) and ftruncate(2)
 with open(O_PATH)
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
index 70a05651619d..84e5477d2e36 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -3895,6 +3895,46 @@ static int test_fionread_ioctl(int fd)
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

