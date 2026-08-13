Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78ED33F5B6
	for <linux-security-module@vger.kernel.org>; Thu, 13 Aug 2026 09:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786613547; cv=none; b=Obgj9yVrolO370bgbr7dJe9JcyMok3tM8PVLrKqUo7omjIWJ7sDw+CkgEvY7lJXrE91iQmXeiYoHOXb3cu6wu5jkZMtwQDUSYNM70R41mIA6dM++2ybEx+JHeOWi56UtkXgZaWND9pi9HlRSJdyQxCZKvJFWjR8CiJC8FpdXfmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786613547; c=relaxed/simple;
	bh=DJAD7h7HayPCKlOK76x1lV5M+/6UOBnfB80gV6vnAsc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PMDaBoOC0RBb8v/vMpq6R5K57mMUSZb5c9W0hlAiKvLIXF2DhmzDYtDqfOkmB+K6RoR4bi4V07F+VzB3vVNYSdvM1knq6AWaUlpMmGX2GHBvdZ+kkSDepSrnqpAeOyUS/HknrJHTOmSIP+6ODzwgjiNXO+OAUkkSu849TbDoma0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gz4dZdrT; arc=none smtp.client-ip=209.85.221.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gz4dZdrT"
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47407691804so352193f8f.1
        for <linux-security-module@vger.kernel.org>; Thu, 13 Aug 2026 02:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786613544; x=1787218344; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OLG/FhVYbBK+Hbn3PFGRd9FAG2Yqmv/GY2Kg3RbP5kw=;
        b=Gz4dZdrTwk/RUSYdmDU4HLrW0zeFSPG2I0PtdXqW7xXhu38BrKrdtDb87rS3aIP92m
         2m3Df9Dw+TWFLEpXCsWcR5/kJY67bobBqIX+MvN+46mEP5IUH4OQX5fmTBJ2erZScl/+
         zHfBo12v0P7bukdnWRZoSwR3FGw0BxSWcEWn3vLHYqMlpDKLxTG3rH86H7WSG1MXoQaj
         DL/THnvyYmGFqEcM+ItM+NTq+YSPi2X/xsCnFqxwj5HkoQ6XX62t2KTCp417969hX5Cy
         ZfJkXlgjXjhuJSQY0a1KjprhBxTcVQ8gSpjqj6SIRh6PWqf+phoHVb/QGqQKWXOI0aVt
         ntBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786613544; x=1787218344;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OLG/FhVYbBK+Hbn3PFGRd9FAG2Yqmv/GY2Kg3RbP5kw=;
        b=F01b8KYQg1HGMoKQE1Mdp0rK4CSwd2Oz9h1WcTSGjo+8iPqp7TkHoMmqjs+2ITfydE
         DDyt05QlkYkNGIOGCOcrJmb7SYGYGwjenPZO48L8wlLHpNg9fTt3TL6s4OYv0+FflbgR
         UC5yWGOCDTlJTcWb5P85RE6kfjOs/iLYAWfNOmWUbU/hxQsTYfy5RA4FJXxTuVAQIANi
         HsI6aa3m7DcxWSqlnWPDi6KqS1c3ZY/XcyYtOlkkYKmw74vn31JA2+N6OGXZWFbrYsF5
         8jule6YnDxQTdX3mJ2UP4JFOnpuO9GYybdRfzGYKLY1kBaGoKcSysmC9PRXO59ELpk1h
         g3dg==
X-Gm-Message-State: AOJu0Yy0Wh3JQsv4o4NDblQaVRdZE8Dpzn1FQOdS4LvbqV11JU0x7f2L
	LRLJXpNibojWSWDNGy5E6eWeHCSVXdpQSzPL9Vryn8BSFZK+tzcscz5prU9zhsjjk3S93gdYfAT
	3XKeD/g==
X-Received: from wrzf4.prod.google.com ([2002:a05:6000:1b04:b0:481:5161:f25d])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:4108:b0:47f:97a4:f121
 with SMTP id ffacd0b85a97d-4815a065ca8mr5632925f8f.30.1786613543464; Thu, 13
 Aug 2026 02:32:23 -0700 (PDT)
Date: Thu, 13 Aug 2026 11:31:56 +0200
In-Reply-To: <20260813093157.1436894-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260813093157.1436894-1-gnoack@google.com>
X-Mailer: git-send-email 2.55.0.699.gb54405d56f-goog
Message-ID: <20260813093157.1436894-6-gnoack@google.com>
Subject: [PATCH v6 5/6] selftests/landlock: Test whiteout object behaviour in
 OverlayFS renames
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, Christian Brauner <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, Serge Hallyn <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Even though OverlayFS uses vfs_rename() with RENAME_WHITEOUT on its backing
directories, and even though RENAME_WHITEOUT requires
LANDLOCK_ACCESS_FS_MAKE_REG, a process that renames non-regular files in an
OverlayFS can do so without having the LANDLOCK_ACCESS_FS_MAKE_REG right in
that location.

This works, and is supposed to work, because the changes to the backing
directories are done by OverlayFS, not by the originator task that did the
original rename() on the OverlayFS mount.  Therefore, the changes done to
backing directories are not subject to the originator task's credentials.

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 tools/testing/selftests/landlock/fs_test.c | 56 +++++++++++++++++++++-
 1 file changed, 54 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index a9130ed70af5..0531701e8ce6 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -2283,6 +2283,13 @@ static bool is_fifo(const char *const path)
 	return stat(path, &st) =3D=3D 0 && S_ISFIFO(st.st_mode);
 }
=20
+static bool is_missing(const char *const path)
+{
+	struct stat st;
+
+	return stat(path, &st) =3D=3D -1 && errno =3D=3D ENOENT;
+}
+
 TEST_F_FORK(layout1, rename_whiteout_allowed)
 {
 	const struct rule rules[] =3D {
@@ -6635,6 +6642,8 @@ static const char lower_fo1[] =3D LOWER_DATA "/fo1";
 static const char lower_do1[] =3D LOWER_DATA "/do1";
 static const char lower_do1_fo2[] =3D LOWER_DATA "/do1/fo2";
 static const char lower_do1_fl3[] =3D LOWER_DATA "/do1/fl3";
+/* lower_pl1 is a FIFO and is deliberately not in the lists below. */
+static const char lower_pl1[] =3D LOWER_DATA "/pl1";
=20
 static const char (*lower_base_files[])[] =3D {
 	&lower_fl1,
@@ -6684,6 +6693,8 @@ static const char (*upper_sub_files[])[] =3D {
 #define MERGE_BASE TMP_DIR "/merge"
 #define MERGE_DATA MERGE_BASE "/data"
 static const char merge_fl1[] =3D MERGE_DATA "/fl1";
+/* merge_pl1 is a FIFO and is deliberately not in the lists below. */
+static const char merge_pl1[] =3D MERGE_DATA "/pl1";
 static const char merge_dl1[] =3D MERGE_DATA "/dl1";
 static const char merge_dl1_fl2[] =3D MERGE_DATA "/dl1/fl2";
 static const char merge_fu1[] =3D MERGE_DATA "/fu1";
@@ -6724,7 +6735,8 @@ static const char (*merge_sub_files[])[] =3D {
  * =E2=94=82=C2=A0=C2=A0     =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=
=94=80 fl3
  * =E2=94=82=C2=A0=C2=A0     =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=
=94=80 fo2
  * =E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 fl1
- * =E2=94=82=C2=A0=C2=A0     =E2=94=94=E2=94=80=E2=94=80 fo1
+ * =E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 fo1
+ * =E2=94=82=C2=A0=C2=A0     =E2=94=94=E2=94=80=E2=94=80 pl1 [FIFO]
  * =E2=94=9C=E2=94=80=E2=94=80 merge
  * =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 data
  * =E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 dl1
@@ -6737,7 +6749,8 @@ static const char (*merge_sub_files[])[] =3D {
  * =E2=94=82=C2=A0=C2=A0     =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=
=94=80 fu2
  * =E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 fl1
  * =E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 fo1
- * =E2=94=82=C2=A0=C2=A0     =E2=94=94=E2=94=80=E2=94=80 fu1
+ * =E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 fu1
+ * =E2=94=82=C2=A0=C2=A0     =E2=94=94=E2=94=80=E2=94=80 pl1 [FIFO]
  * =E2=94=94=E2=94=80=E2=94=80 upper
  *     =E2=94=9C=E2=94=80=E2=94=80 data
  *     =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 do1
@@ -6775,6 +6788,7 @@ FIXTURE_SETUP(layout2_overlay)
 	create_file(_metadata, lower_fo1);
 	create_file(_metadata, lower_do1_fo2);
 	create_file(_metadata, lower_do1_fl3);
+	ASSERT_EQ(0, mknod(lower_pl1, S_IFIFO | 0600, 0));
=20
 	create_directory(_metadata, UPPER_BASE);
 	set_cap(_metadata, CAP_SYS_ADMIN);
@@ -6807,6 +6821,7 @@ FIXTURE_TEARDOWN_PARENT(layout2_overlay)
 	EXPECT_EQ(0, remove_path(lower_fl1));
 	EXPECT_EQ(0, remove_path(lower_do1_fo2));
 	EXPECT_EQ(0, remove_path(lower_fo1));
+	EXPECT_EQ(0, remove_path(lower_pl1));
=20
 	/* umount(LOWER_BASE)) is handled by namespace lifetime. */
 	EXPECT_EQ(0, remove_path(LOWER_BASE));
@@ -7127,6 +7142,43 @@ TEST_F_FORK(layout2_overlay, same_content_different_=
file)
 	}
 }
=20
+TEST_F_FORK(layout2_overlay, rename_in_overlay_without_make_reg)
+{
+	const char *const merge_pl1_renamed =3D MERGE_DATA "/pl1_renamed";
+
+	if (self->skip_test)
+		SKIP(return, "overlayfs is not supported (test)");
+
+	/*
+	 * merge_pl1 is a FIFO which only exists in the lower layer.  Before
+	 * the rename, the upper layer has no entry under this name.
+	 */
+	ASSERT_TRUE(is_fifo(merge_pl1));
+	ASSERT_TRUE(is_missing(UPPER_DATA "/pl1"));
+
+	/* MAKE_REG is restricted, but MAKE_FIFO is not. */
+	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_MAKE_REG, NULL);
+
+	/*
+	 * Rename the FIFO through OverlayFS.  merge_pl1 originates from the
+	 * lower layer, so this triggers a copy-up and creates the whiteout in
+	 * the upper layer to hide the lower layer FIFO file.  Even though
+	 * MAKE_REG is restricted, the rename on the OverlayFS works.
+	 */
+	EXPECT_EQ(0, rename(merge_pl1, merge_pl1_renamed));
+
+	/* Check that the rename worked. */
+	EXPECT_TRUE(is_fifo(merge_pl1_renamed));
+	EXPECT_TRUE(is_missing(merge_pl1));
+
+	/*
+	 * Check that the whiteout object was created on the underlying "upper"
+	 * filesystem during the rename.  This is OK because the whiteout object
+	 * was created by OverlayFS, not by the calling task.
+	 */
+	EXPECT_TRUE(is_whiteout(UPPER_DATA "/pl1"));
+}
+
 FIXTURE(layout3_fs)
 {
 	bool has_created_dir;
--=20
2.55.0.699.gb54405d56f-goog

