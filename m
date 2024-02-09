Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395717EEFD
	for <linux-security-module@vger.kernel.org>; Fri,  9 Feb 2024 17:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707498391; cv=none; b=Mf/7drfgkz4v5yW3xLCexpPZKlIq2rGz1zx4VIJwAGpDdgmM9uWu6w4KjhIDZzYCEEb1n6I54eWaK5fagaCO6tM70ZqTEPV7GP9IWNkvv8xzlpNrU70Ze/KNn4fvv0tcEcwDtji9fK/XLL4ZUBmuN4Zw1uQrm3JulC92bV1R2NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707498391; c=relaxed/simple;
	bh=yH1ybo8pFyJV4FaWc4tCKu5kwI86vylombstdw6W6Dc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=QF0G/CvahmvkTODS7vJHlMkwmY7F/MNajinul1doT0TKmxMPPrdTZlKh2bYOA/tAHAdSLaJjmW8qylV/WJjx7dm2JjolbIxutZTVfoaosd4A173ecc4O4enQcUp+6NvwGUjBW9viU6KocGW3jvhPFOjUWG1Q9gpbBDyF+B2dS2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sakv5ezT; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sakv5ezT"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-55926c118e5so923268a12.3
        for <linux-security-module@vger.kernel.org>; Fri, 09 Feb 2024 09:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707498388; x=1708103188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SUXvZkpipzzisPEeIj9GHmgj+gz6GS2fMiTzN8+mL+I=;
        b=Sakv5ezT1UP4bucZjLV3xEFF7kmhCpEm3eBU3pKmqorLdMu2EjU4L8UerSfmb/fu/g
         z+Z229sWiN235holIE5uQC91e3+3aJCL5SItemUYpzivkcozWlKcC0IIdEam6O27iCbY
         7n9p81r+eSg62x4afqMeoyThGH71EJh0x14wPJjLmU9bjqjAqKJuxD/hJpH3uP+SZIP7
         AI4Ur8L5UaQJGWPopr/kGe4j1w8O7HKhEPEjFwdgdZs8i6SH1jXFJUMjMnI7SUCqKY2C
         MRq8Lu3mQVh1W+DH3YgJXSAcpqbeqQo8lRe1M1scQBZXrtTdM/g6ATlGtLV63dioK5hy
         r3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707498388; x=1708103188;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SUXvZkpipzzisPEeIj9GHmgj+gz6GS2fMiTzN8+mL+I=;
        b=gV1TXhwKtaiFgzfLxHi3ebWefPEpehPRxvprAx78xEN8YfTifmkhGbkqppW7iaucFu
         jjTmyq7JC8DD5Qn6W7ozNG/R+CPZK1O9Fi4hKhSE6WLFYsAlacszZ+KG/xRyBW6wlRrJ
         XQ8zmoslr8hYPDZKryAywXngxzzmJcMJU/+RzK+JThnL3fiT9K8mFt6D5UffuaxYeyOg
         a9s+xcXutltFZEUeKHpQ8bLgOAyC22BKpfHXiEoNvm+E00UM0og/cx82LMLIux0FOGU2
         Q+10J6Z9Pr9qyxBJicOd/i8WvcNAJv+vWxTpBmJOBbRP850DQ7ALTcV4jP1WaMAwdOcn
         jZGQ==
X-Gm-Message-State: AOJu0YzkvbTzel5KYTSGOnwHgQgw3yCJiA88PpJ56PI8XEB/LYRETyss
	q99yIXwZQM3xR44u1HfQEnoKx8FgssdYUk1CLqy/bc9JCvAQE3nFuh5soOHgluWKuWVhXlwp6YY
	rC9GW1Z9vTyJnfFRy5lcEn0vnWWjxRx9A46eSTKDd6VBW43c45/Ut4nEUegC8vmBLCDoj31FGUK
	ZrZfiPgP18ETl4Jl0KcBiZeBYzF2GY0vqH2ATuqx7FqhnG8SJK+I+Y
X-Google-Smtp-Source: AGHT+IG12HwYRRpWchg7kE9xdw7gYJFKi0josGqIpnNVO8tOlBQ2dNQlzewAsPpX+SK21xfN7LDdgd0OMOE=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:3162:977f:c07:bcd8])
 (user=gnoack job=sendgmr) by 2002:a05:6402:4022:b0:560:e01b:6a4c with SMTP id
 d34-20020a056402402200b00560e01b6a4cmr7995eda.2.1707498388494; Fri, 09 Feb
 2024 09:06:28 -0800 (PST)
Date: Fri,  9 Feb 2024 18:06:08 +0100
In-Reply-To: <20240209170612.1638517-1-gnoack@google.com>
Message-Id: <20240209170612.1638517-5-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209170612.1638517-1-gnoack@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v9 4/8] selftests/landlock: Test ioctl(2) and ftruncate(2)
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
LANDLOCK_ACCESS_FS_TRUNCATE and LANDLOCK_ACCESS_FS_IOCTL access rights
in that file hierarchy.

Suggested-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 tools/testing/selftests/landlock/fs_test.c | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index aa4e5524b22f..9e9b828a898b 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -3882,6 +3882,46 @@ TEST(memfd_ftruncate_and_ioctl)
 	}
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
 /* clang-format on */
--=20
2.43.0.687.g38aa6559b0-goog

