Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Es9cdRn2"
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D1A19A6
	for <linux-security-module@vger.kernel.org>; Fri, 24 Nov 2023 09:30:37 -0800 (PST)
Received: by mail-ej1-x64a.google.com with SMTP id a640c23a62f3a-a02baf72f5dso151521766b.3
        for <linux-security-module@vger.kernel.org>; Fri, 24 Nov 2023 09:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700847036; x=1701451836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tHuLL/RrZm9MFgLTJrL/JWVFan8E6pN9n/zvC9iRwos=;
        b=Es9cdRn2sPYEhxUNfzFCyVyuPmzuh8IGLWCBaxOMeqoJLZr068L/C4TrMfoyURQt07
         ExbdYm5DoBIAiE+ufgv1mb49v6lwL0+oNtTk4tJn9NurdGE+2yKRrENObosdoWVg/DHZ
         DNtccLB7FGZ1YWtt9LEZwxquWRlpWCxqH2RxohDYyReeBEIUCmdVlY/kup2grcRc188G
         0G42sHe+RRBr2fMmL2cH5DkHOPpKT743OGC4BMQvl2WCcfejajfPHbiCvsUG0m6jvCPB
         PTWhO4eVu8cThI2BMuigUNMqeFUIOX2AOxNtJwmglSDfPd18YFGi/QZxTA6yj/UL4xMW
         DYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700847036; x=1701451836;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tHuLL/RrZm9MFgLTJrL/JWVFan8E6pN9n/zvC9iRwos=;
        b=SnSTq1ZTxPE+byOnHvdWM4gkPenBfRCvwnlGAcQq0swSKgeAFOL+/5EnZOikVNsVcX
         acAcCOuKQG+qEvXIyd+9jBQAtiHHx3B7cMl0PqwV/wvsGDSHJLht5cA62vmnxDyhKYrW
         KqXgWNlgWpPbSdrK/Hsr4lYQuXVDpU728e6iqnWtEM78QkKuV3TVzNJLUDu04+P2zOjk
         A9cRDSXWxpHX3R1tFPJuG6u9RCe5E0CCOS8nE+NwZ+wW16FQjsV7/hhoC78PEtQIHHMA
         ML7Gw7KPHaDdtWrcsEjRJkSNBaR7zYxuPDXCukj+7cBn351bm2ju6GaZiA7WZFTm3lhb
         zVIA==
X-Gm-Message-State: AOJu0YxDGuSu1ELzvh+N4dY9oGiQMCZGBjF+P+CB3VqbTWhDsKI1OB6j
	RBwUIScobqDnVX9eXW9nNt4DHDr6zGxZije9aYYgVdReB6YYFOBddxdL7aVfiCiQKfmJ+LmsdrD
	fpdJqPisfG1e9T9DNJ4R47ylqHK34hVNsVICmxMMW5uD0I/O1PPpduqxs86alCOd56PzuQ6L0Rg
	F21fBhtQ==
X-Google-Smtp-Source: AGHT+IGc9qOP8qXncKlYFF1SOvM4i8WMlDCp1BbsVq0O5n/FmiWyx4WcGVp8y8fbwUcs5B0RxD6Fee+IgF4=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:9429:6eed:3418:ad8a])
 (user=gnoack job=sendgmr) by 2002:a17:906:3102:b0:9ae:4a0b:d7aa with SMTP id
 2-20020a170906310200b009ae4a0bd7aamr35202ejx.6.1700847035976; Fri, 24 Nov
 2023 09:30:35 -0800 (PST)
Date: Fri, 24 Nov 2023 18:30:19 +0100
In-Reply-To: <20231124173026.3257122-1-gnoack@google.com>
Message-Id: <20231124173026.3257122-3-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231124173026.3257122-1-gnoack@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v6 2/9] selftests/landlock: Rename "permitted" to "allowed" in
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
index 18e1f86a6234..971a7bb404d6 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -3627,7 +3627,7 @@ FIXTURE_TEARDOWN(ftruncate)
 FIXTURE_VARIANT(ftruncate)
 {
 	const __u64 handled;
-	const __u64 permitted;
+	const __u64 allowed;
 	const int expected_open_result;
 	const int expected_ftruncate_result;
 };
@@ -3636,7 +3636,7 @@ FIXTURE_VARIANT(ftruncate)
 FIXTURE_VARIANT_ADD(ftruncate, w_w) {
 	/* clang-format on */
 	.handled =3D LANDLOCK_ACCESS_FS_WRITE_FILE,
-	.permitted =3D LANDLOCK_ACCESS_FS_WRITE_FILE,
+	.allowed =3D LANDLOCK_ACCESS_FS_WRITE_FILE,
 	.expected_open_result =3D 0,
 	.expected_ftruncate_result =3D 0,
 };
@@ -3645,7 +3645,7 @@ FIXTURE_VARIANT_ADD(ftruncate, w_w) {
 FIXTURE_VARIANT_ADD(ftruncate, t_t) {
 	/* clang-format on */
 	.handled =3D LANDLOCK_ACCESS_FS_TRUNCATE,
-	.permitted =3D LANDLOCK_ACCESS_FS_TRUNCATE,
+	.allowed =3D LANDLOCK_ACCESS_FS_TRUNCATE,
 	.expected_open_result =3D 0,
 	.expected_ftruncate_result =3D 0,
 };
@@ -3654,7 +3654,7 @@ FIXTURE_VARIANT_ADD(ftruncate, t_t) {
 FIXTURE_VARIANT_ADD(ftruncate, wt_w) {
 	/* clang-format on */
 	.handled =3D LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_TRUNCATE,
-	.permitted =3D LANDLOCK_ACCESS_FS_WRITE_FILE,
+	.allowed =3D LANDLOCK_ACCESS_FS_WRITE_FILE,
 	.expected_open_result =3D 0,
 	.expected_ftruncate_result =3D EACCES,
 };
@@ -3663,8 +3663,7 @@ FIXTURE_VARIANT_ADD(ftruncate, wt_w) {
 FIXTURE_VARIANT_ADD(ftruncate, wt_wt) {
 	/* clang-format on */
 	.handled =3D LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_TRUNCATE,
-	.permitted =3D LANDLOCK_ACCESS_FS_WRITE_FILE |
-		     LANDLOCK_ACCESS_FS_TRUNCATE,
+	.allowed =3D LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_TRUNCATE,
 	.expected_open_result =3D 0,
 	.expected_ftruncate_result =3D 0,
 };
@@ -3673,7 +3672,7 @@ FIXTURE_VARIANT_ADD(ftruncate, wt_wt) {
 FIXTURE_VARIANT_ADD(ftruncate, wt_t) {
 	/* clang-format on */
 	.handled =3D LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_TRUNCATE,
-	.permitted =3D LANDLOCK_ACCESS_FS_TRUNCATE,
+	.allowed =3D LANDLOCK_ACCESS_FS_TRUNCATE,
 	.expected_open_result =3D EACCES,
 };
=20
@@ -3683,7 +3682,7 @@ TEST_F_FORK(ftruncate, open_and_ftruncate)
 	const struct rule rules[] =3D {
 		{
 			.path =3D path,
-			.access =3D variant->permitted,
+			.access =3D variant->allowed,
 		},
 		{},
 	};
@@ -3724,7 +3723,7 @@ TEST_F_FORK(ftruncate, open_and_ftruncate_in_differen=
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
2.43.0.rc1.413.gea7ed67945-goog

