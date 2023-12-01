Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B2Iv6pyA"
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF0910FF
	for <linux-security-module@vger.kernel.org>; Fri,  1 Dec 2023 06:30:55 -0800 (PST)
Received: by mail-ej1-x649.google.com with SMTP id a640c23a62f3a-a02cc56af16so187675166b.3
        for <linux-security-module@vger.kernel.org>; Fri, 01 Dec 2023 06:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701441054; x=1702045854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ig8lIHEbad4HUQf1qWZKpo59x8aQCHJymOa08eKBFx0=;
        b=B2Iv6pyAFuHEDByXUQgtoD/aD00SxqeCDaU020Gw63JPIDZ4dzaBjOeJEzAh2Mdw/X
         tWCTbAeZxMA4WVZbGzc1P2NCWXd4PIa0bvyYJ55xxjyrPcgTTbZAz961WQhaxlansNaT
         QSn9GO4f70AnSSPK5grijGRej46IcmYrSCdCHDlonv13ZK4L9e5hSD9CoZBOagHJPCj0
         J2s9ZAky1DKlj9o4RSkKlbAV3ggzh2eM3Wj2hTV8fFXxWPBT4BQo8QH9oxZHGHgEiqml
         eqpsy3GqyrpgO0k0UZeh2la6CriotS7M+8NN1Buo6ktETM7+mGKdZgEm9kIIcWeWCQyt
         wkyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701441054; x=1702045854;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ig8lIHEbad4HUQf1qWZKpo59x8aQCHJymOa08eKBFx0=;
        b=Vf99Q88TYDnVpshTIhOJlUS8eS57cE79VOekjfu0/yHPbDxiYoMM9SHRclhBitjw1/
         cKXyTwTrwamVCF09B+W8Ftn+BaWw4h1gqJ6TLyIu6Uk5lraI/TcK+ekSGpbD++INbZwX
         XkSdDD4Ic27SIBe0LQQoBGoItP+dSuJrk815M+R8oMSAueYKTcv3KFNj2wXF1lHZ289m
         6A7iAhfP1hDnw9kM+3GLTOkAD+yGitT3xNY6m6fYdb+bd8Vua6QDD9utipmMDDNGBmXf
         TsvcCszIe0QUgCDx2lLUNXfeQWakWz4B/xQbc3ptWK3hbzrCoXzAH0Da/Ey0yUh17rbj
         vFQA==
X-Gm-Message-State: AOJu0YxwYWxXQSTXMD02tfznAe95eNlvTBGDM1lcBqePKoX4GNgPOHmv
	CT+jWBPM0LPJxqQycPEV5s7MT6/ttoYMkE/QWz+ZA4K3aa7M3j7ZUH8CjR0olUtvbw8qXkwZPNV
	d0b2MndTycPBjJERdDP9jxEPG57VicZPH2xM5iir6c2Q+ywIBopPo04qjqvoV950TYzpZ9wS/84
	93ZGX8kw==
X-Google-Smtp-Source: AGHT+IHfTcA/cPDDFNQfDjlpw7cTfYp/i+bSjjm6XSymoV1IkAVTFLqRIOscEJMnTIKp+5zW2ztp1v2adDA=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:fab0:4182:b9df:bfec])
 (user=gnoack job=sendgmr) by 2002:a17:907:7891:b0:9b9:ff14:9ecb with SMTP id
 ku17-20020a170907789100b009b9ff149ecbmr7475ejc.4.1701441053451; Fri, 01 Dec
 2023 06:30:53 -0800 (PST)
Date: Fri,  1 Dec 2023 15:30:35 +0100
In-Reply-To: <20231201143042.3276833-1-gnoack@google.com>
Message-Id: <20231201143042.3276833-3-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231201143042.3276833-1-gnoack@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v7 2/9] selftests/landlock: Rename "permitted" to "allowed" in
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
2.43.0.rc2.451.g8631bc7472-goog

