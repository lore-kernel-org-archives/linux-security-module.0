Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE1043E4A3
	for <linux-security-module@vger.kernel.org>; Fri, 24 Jul 2026 16:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784909430; cv=none; b=uTq6tsYyCj3KKLI2XgktvqYDH7xWL+4M1ApLte5ANnoS9R4YYTVkq3TLJUBN5oPQDPolR6J5tkXTaUdaIzRssEhAqe+7qibY80yIxQCpMyHnuop0PN/QfQVg+EHQrwSetKkpaVk++flAjn8nzbfMdbEjFzsrUktBUJE30vc0k2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784909430; c=relaxed/simple;
	bh=KLm006mQZUKXXKxgi4kXpbQwgqlH/HcUDhpUphNZHZ8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jIm691n3avz0CI3E1JV8Q1P8W0lU2g7gJF4rD2DNhZWMzEskE6phPfTKXv1aV4HaanQgK7JVkpImmrZQgNwro1K5Tr+qLZHJSqJ0hFUYOy8W6IGBKzuk5GOx9I67WAO1oytQTAmyN4Ph+4NjG3pVgFhC1e9AJdSLO7mZ1mwCZNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E4+65mBV; arc=none smtp.client-ip=209.85.221.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E4+65mBV"
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47f9ae25143so512614f8f.2
        for <linux-security-module@vger.kernel.org>; Fri, 24 Jul 2026 09:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784909424; x=1785514224; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=P92ek6lJkrwyqrRbvyct/H2ZxGH/5bgxqDjUriboX9Q=;
        b=E4+65mBVIByHIvU+vHPXt5nsNfShCpu497UkYdg4PJpiPUrcPr2koAvgcAfy7mUYZd
         ZKPF4KI7qJ7eEjFoCapEL/RFzPxam2pPq45JrYh3yTYRfbOiei6iPMzbsg2RZS++pvIV
         EC752AVySEAOxS048cyyr+1S+b5NOxCu6/N8bGHGYD/mLVPQjXp6SBU5KqrIkjeE61Rg
         nfajvep1+LIGYSmU6tnd+K0nt6n6ObV2jNxL1pCxcVLwdvzeHgaT5mMl/bx+mUDER6fT
         JYthC1UWZulZCYRfDhO88NAzR5InTf3zAm/7Pon3aqjALUuM0wRSmaAF6/1PzRKwK6ss
         MNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784909424; x=1785514224;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P92ek6lJkrwyqrRbvyct/H2ZxGH/5bgxqDjUriboX9Q=;
        b=GLKh9EUGUopOJDHHgKeJwUdD5l1y2MVqMYSseyVmag7COcdyharItHzOVSVt2i9Sb0
         2Gdbb7GHYDSYiItUzLysbKDwv7QeXym9IxHKPjnwUZJZHlitAh164VGzWCPvvnHIyxLn
         /7qHa0VODEyMQfzJwA0oiUtmB+RCuNHyk/LMxPGyTspUrbq4eG5vI17HWs4uioI+lfMy
         r9laRHH79NVYsQTT3/lcX7XxP/0pO6Lcq/T+cc9l3yuMvbnKQPBkttmPb60qzyGkh7gH
         J09IZqmKoqDLFXQ0Ih1wgaPdmP072ee8REXD1/+TOwc88ZwIQOdd/LCMKbNviGA3gu3s
         Q1ow==
X-Gm-Message-State: AOJu0Yx1/Eg1BKLHfrxEEHJgL2AowXLCqn7JeG4LtunUc/OYHN7J2s7o
	kXyBQxY77OSvfJgab2pYPbIJIhP2qcUS7oF6yZ91JiMeZYORdOflU5A/Zopr+jZ0SWHeCtroNcb
	CvglkJw==
X-Received: from wrno17.prod.google.com ([2002:adf:ead1:0:b0:468:50b5:41e])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:1849:b0:47f:7e7d:eb0
 with SMTP id ffacd0b85a97d-47f8d71f831mr11138292f8f.19.1784909424119; Fri, 24
 Jul 2026 09:10:24 -0700 (PDT)
Date: Fri, 24 Jul 2026 18:10:02 +0200
In-Reply-To: <20260724161004.2360749-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260724161004.2360749-1-gnoack@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260724161004.2360749-4-gnoack@google.com>
Subject: [PATCH v4 3/5] selftests/landlock: Add tests for whiteout object creation
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, Christian Brauner <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, Serge Hallyn <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Add a test to check that whiteout object creation is guarded by
LANDLOCK_ACCESS_FS_MAKE_REG, in the cases where these are created from
userspace:

* Conventional creation with mknod()
* Linking or renaming an existing whiteout object
* renameat2() with RENAME_WHITEOUT,
  which creates a new whiteout object in the source location

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 tools/testing/selftests/landlock/fs_test.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index e82b56a74c5f..fe5faeca83eb 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -2247,6 +2247,19 @@ TEST_F_FORK(layout1, rename_file)
 			       RENAME_EXCHANGE));
 }
=20
+TEST_F_FORK(layout1, rename_whiteout_denied)
+{
+	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_MAKE_REG, NULL);
+
+	/*
+	 * Try to rename a file with RENAME_WHITEOUT.
+	 * file1_s3d3 is in dir_s3d2 (tmpfs), so it supports RENAME_WHITEOUT.
+	 */
+	EXPECT_EQ(-1, renameat2(AT_FDCWD, file1_s3d3, AT_FDCWD,
+				TMP_DIR "/s3d1/s3d2/s3d3/f2", RENAME_WHITEOUT));
+	EXPECT_EQ(EACCES, errno);
+}
+
 TEST_F_FORK(layout1, rename_dir)
 {
 	const struct rule rules[] =3D {
@@ -3270,6 +3283,14 @@ TEST_F_FORK(layout1, make_char)
 		       makedev(1, 3));
 }
=20
+TEST_F_FORK(layout1, make_whiteout)
+{
+	/* Creates a whiteout object (creation guarded by MAKE_REG). */
+	set_cap(_metadata, CAP_MKNOD);
+	test_make_file(_metadata, LANDLOCK_ACCESS_FS_MAKE_REG, S_IFCHR,
+		       makedev(0, 0));
+}
+
 TEST_F_FORK(layout1, make_block)
 {
 	/* Creates a /dev/loop0 device. */
@@ -6951,6 +6972,7 @@ TEST_F_FORK(layout2_overlay, same_content_different_f=
ile)
 	}
 }
=20
+
 FIXTURE(layout3_fs)
 {
 	bool has_created_dir;
--=20
2.55.0.229.g6434b31f56-goog

