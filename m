Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740F54DA16
	for <linux-security-module@vger.kernel.org>; Fri, 22 Mar 2024 15:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711120235; cv=none; b=bUZETkt5amr58gDNvo+KRqxuhgC1ugCs+GE+5zHObAN7b87wKsQB7S0VQX6gUXCR7OXIkEFcvWBSmZ6gY6amzZf4FBLlJWuoM2ldHlRMt+dFUyY7GR5rp/U4CNk5ztVvnFfn6jaOVz70SWoFMuUDKkTB+CwTLIvBOF+Xt5rm+Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711120235; c=relaxed/simple;
	bh=Jdal8IKILETTWsojG5pDXheVDyQeR66rUe3RKtiUO/I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LAMfjkWBxXJlqggNNNdjsTpJFjlj9OMBpSq0YTmvi5MVtRzOTBq34tMxTrSjoaCgfCiRt77Jj7oggcavKb1zJWB+WzmxY8K3/foD8yj8pSlUXndz0S5pP4qs+zIh3XVZLHNshnQufC469dHzfFs3a0LmuaYf7FK3mQFCM+CZKu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bU6hjMje; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bU6hjMje"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-a471cf9c035so39211266b.3
        for <linux-security-module@vger.kernel.org>; Fri, 22 Mar 2024 08:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711120231; x=1711725031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qobHCRmb6cXg9TV4MF/PMa0SUI8jbJIaeOrvT83hbEo=;
        b=bU6hjMjePveUDucSLDn8BySlkBy3CDd27PP1gsW/OmGgY3ZIg9xZCE6iURr+OIjPj1
         hqni29jfjGfdlCtNMdjgwqGyZsDk+hAUmd9uAPx+sQqV6PlFFPCRlUKxyDEe6nZ/b9CN
         BKoMp/E+vrHPa2TKonVLWWpzsoXS1gL3DQkPDbseyK5mgtOFMDD7RVkH9HS59xoqx0Mw
         u3dogKvsP02RuL5N59PkrRaiB74/SK3wTlmQDl27hl/q5xsIyPQsOIpzp5QXu2tuOb7Y
         UPCgIy4yFvyH+CMq9NTHx+hpcVWKYQeHhnJm6XjbsitzfQ4lZTy2WrYhDuGgtz690Dlk
         4gEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711120231; x=1711725031;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qobHCRmb6cXg9TV4MF/PMa0SUI8jbJIaeOrvT83hbEo=;
        b=G/NI/50akrb0CDjj9OrNP4jnK0wMHFWjDzybQFhdzbvbVUZJJAT284iYddTHQIQhyO
         6xmLO9m6zcswDj1qwbXEmVFmZzb3L+aAM6GIhmYP4rbO/X7QoM9tF523EG/cYqTTvCNI
         Soee+v7bEbbZ9cfV/ecDrsAMeLcMGRMXQZM8NU3/xUdZhH5ifRJvBR4Ld9O105XJ4mbh
         1+vHuHUQqatHBQjcpiBsznqUsolcnKpRsn2aWkVOSa31affQ2MBcQ8XSkED0TtuS3Kux
         cSGsmrOGYhkcnr2eAY3cf4GSHEVQymuZrl2QcyDyka1LqcLUUqPG35RZ5P6L+ABohY1x
         VZ8g==
X-Gm-Message-State: AOJu0YzStTZ9ya+YYdWfoIFTX/tIWqX9NqlMOvdUlQy05lxctHqS1YWE
	LfI+lY7tc2Az+Uw5TU4BOi56HWsFAcxqs1e4+dRGmMBg9SusBwA2NI5rxOHIO/CEchimDMeL12m
	wmLNWPmV5bKOU55mgxLGfC82O7owLYA5/2/jo5m45Cp0pFBRCvdtDZN5QhhIVvnZGHHOOkdqkQb
	KuEvTEfV4ixOEjw6bbGcbkLgdAHGylqWnmHoDLoeQwtpeBNq0kDNO4
X-Google-Smtp-Source: AGHT+IGKONiWvctPFgaXTgXqq9xxHFVwjT49Su0OSiBo8MX70YapJ4UVh8nInJsSxxBNK14VBxvLp0hWONE=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a17:906:a1d0:b0:a47:1499:6de0 with SMTP id
 bx16-20020a170906a1d000b00a4714996de0mr0ejb.7.1711120230227; Fri, 22 Mar 2024
 08:10:30 -0700 (PDT)
Date: Fri, 22 Mar 2024 15:09:57 +0000
In-Reply-To: <20240322151002.3653639-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240322151002.3653639-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240322151002.3653639-5-gnoack@google.com>
Subject: [PATCH v11 4/9] selftests/landlock: Test IOCTL with memfds
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

Because the LANDLOCK_ACCESS_FS_IOCTL_DEV right is associated with the
opened file during open(2), IOCTLs are supposed to work with files
which are opened by means other than open(2).

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 tools/testing/selftests/landlock/fs_test.c | 36 ++++++++++++++++------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index 22229fe3e403..32a77757462b 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -3850,20 +3850,38 @@ static int test_fs_ioc_getflags_ioctl(int fd)
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

