Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1BD130AED
	for <linux-security-module@vger.kernel.org>; Fri, 19 Apr 2024 16:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713543103; cv=none; b=SiYbtBgPSRKOopfElBYF1hIgZUkXyDgB5TFLwWJnn13HcF0427Dmu1+g/9MGpDkTwIcN+MzzpBExb0GrENE3Qx2lT0e4RZxpxga2GNFoBru/o9b/6uGcuyE9+GWUta1BiTHPpur3dajkOtvvZWHv+l2vcJPJJdxhrVhRX7eAOF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713543103; c=relaxed/simple;
	bh=r5UNgUM78q5XLuj5NMQgb9HQbedr3JCHVW3UzlU0A0c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T+qQmZ6rCYMD5kuG36m/2zMwdWUYokUie1Nf3iNxmgO96MTE+G4Ix0ueDOX0dUprbZ+pKq0Z4fqiLBkF9gTRUYLhfas8pEUXIjHjMsVWYJsqYNBkPBI381TTlr9ilLx8uGp+PSnBCoNm2G7u4Tx9frO/x8QaU9r88B0jzOExv6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ghliW+mr; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ghliW+mr"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-56e678f6d81so3243826a12.0
        for <linux-security-module@vger.kernel.org>; Fri, 19 Apr 2024 09:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713543099; x=1714147899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6J5az365xK+ZzeSMyv+LbNjMTEu5kjOKEeh883eiHPw=;
        b=ghliW+mrI6gp5GPUugW2/3vuYipLaCVWr6n8+suqnNhu3olQtd6fm99VRP5LB8QmWG
         QV51VN5Tb1MRuQU2C75XH1b+EwYA72aweJRxB/UAbmf59H1gbFC1JFyjqD+ZEpUIctK3
         LISsn1TUWpSNS/47M6JtL1m7EZ1vglQbOXiyMkWKuQ/q75gEsDY9TgkftPVxU4lB4Xif
         /hqJl0wfzKfNKKwSvQKbnfl3y6NSMOT2Cm6XujVj4+c3T0PcWMtblXnX40UI1qKURDw8
         7We5taMl77ZLMCK4viLGpwNHYilMWAGwUBa83/AUqIGSKY1ICKBbdI4sdF1s6oRyz5Jg
         eHMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713543099; x=1714147899;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6J5az365xK+ZzeSMyv+LbNjMTEu5kjOKEeh883eiHPw=;
        b=F4djXfWXdGmesNrJ/zlOTUd6zs+bdDc4O7bja/obFEDSZJhSBk/qPrkXqcAcTheGoS
         350ocr9bioCzNMXhcmiYS0Tk7wBbiZPzo4MZ2zWS2Ic08dkZM75ahIH8DyrK+Eeraydf
         2hpEpMqI7b1tneKSkBJAFhqU4CZEIOYpSQ3yRUcQ2j+0+tCh0bWFe00dQGWVC89AaKkY
         yLHs0gRklmrobrYuirOE2GGYB4iLh2uuUS7GsrEJSPFDQ5CUbIirSWBV5s9PxNuUXgUa
         TfHSns7ORKPa34O5wIHtRjJp9FXsUxM6/Bf6JmiclOsyOR/mKXcCSRs2OqgufLG7AU2I
         K9dw==
X-Gm-Message-State: AOJu0YxpWh3wvW2B8vj09KOFKr17ZIAa54pE/+0QvUS6Wt/j6cRuxrs1
	iTUCfZSGS57YCkQVUsjbiBz7Aj7h3TMmb1eRHnJ/yB7Rxv9CynRo9foQqBhS3fT2ihIqK3E2B4f
	9q5tZ0DdelD8iXZaqJDUQvxr4NlAtQDVwzyrf3+NEPl7mz9kQrwNzpnbBhdMjB2cUgboyiarO51
	EYbN18VGeMngZh0yL1PqYehcOXZs6ypT29Ts0aXPucYlcAebKIHea/
X-Google-Smtp-Source: AGHT+IHisJXB+GsHOnfXBzfhkwHJ+2ZKhxXdPCwJnSFv+hBOjspSP9l3J/lisVR8sJ4EglnuqSdIBajCuW4=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:aa7:d654:0:b0:571:d7c8:9d5f with SMTP id
 v20-20020aa7d654000000b00571d7c89d5fmr1918edr.3.1713543099468; Fri, 19 Apr
 2024 09:11:39 -0700 (PDT)
Date: Fri, 19 Apr 2024 16:11:15 +0000
In-Reply-To: <20240419161122.2023765-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240419161122.2023765-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240419161122.2023765-5-gnoack@google.com>
Subject: [PATCH v15 04/11] selftests/landlock: Test ioctl(2) and ftruncate(2)
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
index 6967e02ba3cb..2cfda6af71ab 100644
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
2.44.0.769.g3c40516874-goog

