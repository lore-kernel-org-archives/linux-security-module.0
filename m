Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MAjAqBAD"
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615211734
	for <linux-security-module@vger.kernel.org>; Fri,  8 Dec 2023 07:51:48 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id ffacd0b85a97d-3333c3b6519so1615501f8f.2
        for <linux-security-module@vger.kernel.org>; Fri, 08 Dec 2023 07:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702050707; x=1702655507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=avVducTTrz8Unk6ncqcB5xXi1wrDHpE3wxNIhRc8Oys=;
        b=MAjAqBADgd28HPIVYrmBXgdvBgL4v9Ggd2UYVjCYy1/GK1gV8KgZVJQY0FSnWZtUtO
         hCeEW/WID9Qv2FP60kiky7faVaLyizSzEJ1nYxXQL5BnPVtVVp4ATh1KPEnNu9kkPqiy
         lk9apuvnpLM6iNKKE+tyXZip4uaCedk+r3ZYUrXvPgmwU0UeiF0LpTmsp0BI3fbum33H
         +vnFP6IwarDDDxSiCpciFWFv4BhxqMAQOTfdhJdfX8xOZCv71QjhrQxFTTUjd9E8FU68
         AYNpSuv88PuALzJxyNV14DijCra1CwMxycThoxzhqVTIjWOFFpnFlBOLtNxEQBj2cZpN
         PZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702050707; x=1702655507;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=avVducTTrz8Unk6ncqcB5xXi1wrDHpE3wxNIhRc8Oys=;
        b=QZD/rjG9/su0rUKfwex+s8GrZcAHvrVyN7VomZkUd5g6EuHjRKFavZ31YXFPPVG66h
         zgetd/hyh8/6Qqjx7kdmlHt40YcF9rIf6Z46tOpod1c43K9B1jKa9WcxRSabrZ14Xrs9
         J20WWp6f2bg2f/CE4lR/Njonzgn/blqJpqXZmfIUCaodCKT6X1G4OyDxbdiWC344TpC+
         9xr9zvxb+7UlZ2w7xQehp7EmXTAxC8ppeprs23kjDpbA6ZshWnD6Zzib1rb0E6tjzXrk
         zH2vln11JJwNkD38lZRzluTzeR9QRJtqDWuQEpQTf8WbdkfYOGvRA40HKBlMOdqVxxl8
         1HKQ==
X-Gm-Message-State: AOJu0YyZNuKDu+MjFIHTlJowlol6QpsM1tknczMjrskq9A+z9i3oyfaT
	cibM6S9owEOy4QdeJpartYPdTsa6lUajI5t4OIP93cq9nZ10cmu7k09P/TnvIjnDRtxLY5XNYM7
	TL6zDMr/QTOuHozsxLnmZ6RAuvSt+scLBfbvBRuq+eKq1RU6BM1Fq6uARx6bSOC+XOoRqLtSwaZ
	09qiAuVw==
X-Google-Smtp-Source: AGHT+IGhon+9+mocZYXG/AkXZxfC8IiQVxvHXSA6wYkfaJglO6e4cFbNuHxeQEqiqKsISXIhQUWVcqKng7U=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:d80e:bfc8:2891:24c1])
 (user=gnoack job=sendgmr) by 2002:adf:d1cf:0:b0:333:5232:d7f5 with SMTP id
 b15-20020adfd1cf000000b003335232d7f5mr1303wrd.8.1702050706550; Fri, 08 Dec
 2023 07:51:46 -0800 (PST)
Date: Fri,  8 Dec 2023 16:51:19 +0100
In-Reply-To: <20231208155121.1943775-1-gnoack@google.com>
Message-Id: <20231208155121.1943775-8-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231208155121.1943775-1-gnoack@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Subject: [PATCH v8 7/9] selftests/landlock: Test ioctl(2) and ftruncate(2)
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
LANDLOCK_ACCESS_FS_TRUNCATE and LANDLOCK_ACCESS_FS_IOCTL access rights
in that file hierarchy.

Suggested-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 tools/testing/selftests/landlock/fs_test.c | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index dcc8ed6cc076..89d1e4af6fb2 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -3875,6 +3875,46 @@ TEST(memfd_ftruncate_and_ioctl)
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
2.43.0.472.g3155946c3a-goog

