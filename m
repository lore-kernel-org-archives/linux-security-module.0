Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2fXDyaE7"
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22431723
	for <linux-security-module@vger.kernel.org>; Fri,  8 Dec 2023 07:51:33 -0800 (PST)
Received: by mail-ed1-x54a.google.com with SMTP id 4fb4d7f45d1cf-54dbe033977so1158696a12.0
        for <linux-security-module@vger.kernel.org>; Fri, 08 Dec 2023 07:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702050692; x=1702655492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7kWpQGARUuYr0YqUEA1D+Re6NElKsOYqdPIeXFsPG38=;
        b=2fXDyaE7ozq3tM27EOya8UmO4n5z+W3gnPNO764Aip06t5Y4eB6iPe9MHdz5pJkSxz
         Q7HTf/4Y3Ayr+8I3ROWP9S/VhK3BEGtJPHmk7nlsFGU/1/XHlI3QefKBzx4/23NKQe70
         KLMvDsv7eC2NgCx5qEmimOQ7QGLxifWCYmojdqc+wIYLCzJ+sJqt07C1ImNDUmt9E2MA
         laJLwGiTFUyBBsyxA/Y1s/Q/eEXzvLax1hjDXadNSkbSa3mGyUgJZw+BZmQcSNjPnYj6
         vekPBsh16G+p6HedonzObcMx7uBrahm/tUcp6DHB8OfT99107nSuo3uc/X321XmuRKpY
         ArBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702050692; x=1702655492;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7kWpQGARUuYr0YqUEA1D+Re6NElKsOYqdPIeXFsPG38=;
        b=mf7lZYDO+uYpnOPKQk2YuAF1rIls3ZJiBsJehXW+Qnhw4vU2cQvt8xRkzYVVYwLvTT
         WXadKZSRcj7px74A+Wf3X6QCkW94xFBQs/AdTCqS2kWFnKN6XTBS6fMUYfoFTPjsUi7V
         9TI7e+lwxP0DSkUgHPWwgfW4xBOEqqKbBIU4onojL101hplJ/dzH6NiUrMM3Sy437XWs
         JiGJF4BXuupvG9HcayEqKnzA0m3KbzHstgOTydRV0UNy52v+KwZNlklLFiNLIXUltfeh
         ooQWDbCg8rZkjJHvXlXoq2DGiSXALnDOOJ2KB+kF6ZaQh5X6tusYkFEZUwy6PYO6fP5u
         w5Yg==
X-Gm-Message-State: AOJu0YyYXOUgMmO+yR4bh7xX+v2rsta+RkbAyU+l0jrEpYQ/YFqL1DCp
	39pqm7B0SL0/Ba+lYTTY4Xp8keWpjBazTfRN8cGrwtW4ZWdFWmpRqI4zixbFJdvjyX93tmV0auL
	fn++/IrNfHjdj3bs3ueX4TwBvKvZkxg3mEtgaWaZ8cmkx9lDMBJrTcobBwJE2ywbw0k3D3qqxaN
	W70clhZg==
X-Google-Smtp-Source: AGHT+IEmKWtB5JCKmUgMb8Dj9DXsjPZORR5fK4vDweMRskchlYpAqg79BFHUKJBKX3h8yttseayvSepE4ZM=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:d80e:bfc8:2891:24c1])
 (user=gnoack job=sendgmr) by 2002:a50:9eca:0:b0:54f:4811:2a9c with SMTP id
 a68-20020a509eca000000b0054f48112a9cmr2234edf.6.1702050691941; Fri, 08 Dec
 2023 07:51:31 -0800 (PST)
Date: Fri,  8 Dec 2023 16:51:14 +0100
In-Reply-To: <20231208155121.1943775-1-gnoack@google.com>
Message-Id: <20231208155121.1943775-3-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231208155121.1943775-1-gnoack@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Subject: [PATCH v8 2/9] selftests/landlock: Rename "permitted" to "allowed" in
 ftruncate tests
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

Suggested-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 tools/testing/selftests/landlock/fs_test.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index a1d17ab527ae..50818904397c 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -3688,7 +3688,7 @@ FIXTURE_TEARDOWN(ftruncate)
 FIXTURE_VARIANT(ftruncate)
 {
 	const __u64 handled;
-	const __u64 permitted;
+	const __u64 allowed;
 	const int expected_open_result;
 	const int expected_ftruncate_result;
 };
@@ -3697,7 +3697,7 @@ FIXTURE_VARIANT(ftruncate)
 FIXTURE_VARIANT_ADD(ftruncate, w_w) {
 	/* clang-format on */
 	.handled =3D LANDLOCK_ACCESS_FS_WRITE_FILE,
-	.permitted =3D LANDLOCK_ACCESS_FS_WRITE_FILE,
+	.allowed =3D LANDLOCK_ACCESS_FS_WRITE_FILE,
 	.expected_open_result =3D 0,
 	.expected_ftruncate_result =3D 0,
 };
@@ -3706,7 +3706,7 @@ FIXTURE_VARIANT_ADD(ftruncate, w_w) {
 FIXTURE_VARIANT_ADD(ftruncate, t_t) {
 	/* clang-format on */
 	.handled =3D LANDLOCK_ACCESS_FS_TRUNCATE,
-	.permitted =3D LANDLOCK_ACCESS_FS_TRUNCATE,
+	.allowed =3D LANDLOCK_ACCESS_FS_TRUNCATE,
 	.expected_open_result =3D 0,
 	.expected_ftruncate_result =3D 0,
 };
@@ -3715,7 +3715,7 @@ FIXTURE_VARIANT_ADD(ftruncate, t_t) {
 FIXTURE_VARIANT_ADD(ftruncate, wt_w) {
 	/* clang-format on */
 	.handled =3D LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_TRUNCATE,
-	.permitted =3D LANDLOCK_ACCESS_FS_WRITE_FILE,
+	.allowed =3D LANDLOCK_ACCESS_FS_WRITE_FILE,
 	.expected_open_result =3D 0,
 	.expected_ftruncate_result =3D EACCES,
 };
@@ -3724,8 +3724,7 @@ FIXTURE_VARIANT_ADD(ftruncate, wt_w) {
 FIXTURE_VARIANT_ADD(ftruncate, wt_wt) {
 	/* clang-format on */
 	.handled =3D LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_TRUNCATE,
-	.permitted =3D LANDLOCK_ACCESS_FS_WRITE_FILE |
-		     LANDLOCK_ACCESS_FS_TRUNCATE,
+	.allowed =3D LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_TRUNCATE,
 	.expected_open_result =3D 0,
 	.expected_ftruncate_result =3D 0,
 };
@@ -3734,7 +3733,7 @@ FIXTURE_VARIANT_ADD(ftruncate, wt_wt) {
 FIXTURE_VARIANT_ADD(ftruncate, wt_t) {
 	/* clang-format on */
 	.handled =3D LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_TRUNCATE,
-	.permitted =3D LANDLOCK_ACCESS_FS_TRUNCATE,
+	.allowed =3D LANDLOCK_ACCESS_FS_TRUNCATE,
 	.expected_open_result =3D EACCES,
 };
=20
@@ -3744,7 +3743,7 @@ TEST_F_FORK(ftruncate, open_and_ftruncate)
 	const struct rule rules[] =3D {
 		{
 			.path =3D path,
-			.access =3D variant->permitted,
+			.access =3D variant->allowed,
 		},
 		{},
 	};
@@ -3785,7 +3784,7 @@ TEST_F_FORK(ftruncate, open_and_ftruncate_in_differen=
t_processes)
 		const struct rule rules[] =3D {
 			{
 				.path =3D path,
-				.access =3D variant->permitted,
+				.access =3D variant->allowed,
 			},
 			{},
 		};
--=20
2.43.0.472.g3155946c3a-goog

