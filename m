Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4338175569
	for <linux-security-module@vger.kernel.org>; Fri,  5 Apr 2024 21:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712353280; cv=none; b=AVhjFL9v8wcqvCzwfm+/F0Q/uuBk1bKp3lBjEsleaokxjVfT5C+6s+Ou52jXpaM2xnNXfHxqoFVd2N4hp+Qv8EVVgrWRQ2nqNByGMS1igsX49SY8PaToVUt3y4eqrkR7YP6JZ4MSATivbPFQRxra4EwjC/pwUjMlLDqG+6dCdYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712353280; c=relaxed/simple;
	bh=mTGd0atLVM8A70V3jLnT5qjUJDUe0jZM2W1J5PkVDac=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QAzVhsBX7yUAuEQC+4Q7x2HL9Z0AW5zwHKCYfVP6Uk8gRx4qyNIyUyB4mD1XP6ozJsl5IagYyd7OpvbLZxaHjBvTKQQ/+Zf6fnaIECb/P1Aq3h65mEtECyWHJ/IZegrBXxuV1x1bNG/2NFlqMIrrJun/EugSxZlT/GERDGT+3Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pr3V5wGG; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pr3V5wGG"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-a51a1c8d979so16884466b.2
        for <linux-security-module@vger.kernel.org>; Fri, 05 Apr 2024 14:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712353277; x=1712958077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sQsxKlrfUUBg5XpcWZn3PX2WqaAgMSpXIdj6//RRCTY=;
        b=Pr3V5wGGzvCYBT0cGjvHsAnx8SBaEpKu/NVbrIleH1Sy31y/BglNewgzmvuZCwCXEy
         k/30XjYKyd7e+hUS033wpxw7O9JKyZ0XL6HNOyMXA14KX5oOUsUJrGRhNNtJa2ffXAAT
         0U3q9npxpGH1M6wYBCpoBUodoPK6oqKVIj6EufYetOA8P/zA4NZU2tRDxj5cqXYo/1ch
         fjxFSFz7rRhFVK+/p89wweDPQsroqs7yWhfAXse+BYS5FrYCo9Mb9kcJ7bRJyM+qkPEt
         2p4vv0krtlW4gUObQVKpJ4tbWB/IP3qCs+xeDSrm/z2IelMqR9O/ZZASbOSozFJ9HrHI
         V0rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712353277; x=1712958077;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sQsxKlrfUUBg5XpcWZn3PX2WqaAgMSpXIdj6//RRCTY=;
        b=ZITUlCWteiC4OMoBl5uNnl93JNgYdXkTEMZXnyzNQOawi3TMzO+PDKfVYonVKe6wgF
         OC0sIOO7KmFdGilmeGUuCrU1khZuuTIlWQd4yki9CRxq0zb9E99eiwbGU/BLoomtgGVs
         IpCzcUMZwEvHzG0TV9V9oBLoqTyVkirHf+XiJORGVyssNvR+/5vwpJyooKp4V56YVEYG
         rYDMbfM3Lo67iNWMu1wn/tiBIH3Q+0dTHYp9ja+wLStWEUd1l2imiy4OLZQklbZYHtH3
         Wn+YYKrDGW6ip98bzZfm7jMdTsOHRagJJBhgYvnEMRsU2eoQsXEsRPwrbVqdHKTbdaoq
         J49A==
X-Gm-Message-State: AOJu0YxkPvZxJho4xEY/JRuK9zKBqCcbFiZScKvSAk0JmcTashMzD9Su
	235WsT19daB+YsY/hKckQnBGxHbEKCVPnhjXl3RXkOCGSEq37XYQ6o2vDzxBfgPjAcRX13NQQt4
	4FOCS/qoBwPAmc7ReU3kKs5OkkPsEirH3BahUSx5ZMEwglz59JN1tcBkiosThnx1HFzdDr+ugR4
	aA+Ug9TClAfRSgAO5Yieo6CZ6Hb98BJE67GIUPC9mTSNWhfQtR3Wu+
X-Google-Smtp-Source: AGHT+IHc7ZnRf9A4OQGK/czqVVD9KSBBMChv4wWI41HPw7YFWsTFeHHYpppwlobrqfsWzdUXKh92rqCxbMc=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a17:907:77d2:b0:a51:9148:1938 with SMTP id
 kz18-20020a17090777d200b00a5191481938mr3232ejc.15.1712353276946; Fri, 05 Apr
 2024 14:41:16 -0700 (PDT)
Date: Fri,  5 Apr 2024 21:40:32 +0000
In-Reply-To: <20240405214040.101396-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240405214040.101396-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240405214040.101396-5-gnoack@google.com>
Subject: [PATCH v14 04/12] selftests/landlock: Test IOCTL with memfds
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
2.44.0.478.gd926399ef9-goog

