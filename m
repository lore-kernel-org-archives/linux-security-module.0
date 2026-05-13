Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1995830B509
	for <linux-security-module@vger.kernel.org>; Wed, 13 May 2026 16:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778688369; cv=none; b=XliLok5+n+zixuTYsUUSUkH7a5/TS1V+cpuLxSRds5DBOJu3iQa9YDL/vFYqpIRRmNi4+dCGzJSRLH7h9LrwLuwzM31+JZHNpzkHewFQAVfc7j1YPluAJdiWsioU/LJpS0ua6XPSHQlMyRj7Qpi2Yv4L6jkARe2AKcBDltoIlDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778688369; c=relaxed/simple;
	bh=BtBQFQVwDyUoLwpwufh+3WfzoywqT8r9ZW8qY0dDV1A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O6YCKZeNUzqR3t4Et5UfyceIsSmMLpyuVt9tU2J0hAxpIIr+J4gM2h70+7tPGVCy72EkKNROQIsaavE2XId7nHIoggr5hI83YW+xSnmYBR6aa2adPfDvgfh/7EcJTlaENOC88BdqFJTDjhhJbc5IKRse4mSFia3oKGYSbvkqa80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t0rL+Khc; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t0rL+Khc"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-48d144d3428so40739985e9.3
        for <linux-security-module@vger.kernel.org>; Wed, 13 May 2026 09:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778688365; x=1779293165; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=btfGQnO+nL9c8q4hrPoVEJZNf4bkbVRqGDdIFJkLTv0=;
        b=t0rL+Khczry8MGySMlGfwgCitTob3jpEFWhZI/X1nPIMjOiRYpkrGJpXiSx+hnfRL4
         VXEReXBq4hH/qC+4z6+mNRHwsB2XKCrWm89SADVIjpXHtMzlEHObvCjljmmwvlbXWRy7
         8RJqhhbJxkXJsR8umNfXDddRRYQSKoavW+vfkbqWKu9kYRzzYPNEutfPpF9iItbRDyLS
         sQnSjiFLeZBq0zZU0tc+y50TKVbxgky/YBmgNGe/UqMxcnA9bhKJKYtgWbIHPpJ6GnWm
         HT20JaF5slP3zHXSa3qp5F/BcRP5B2nS3hhQTw+d3CluYZC7yCpDZ9o461IiuNIvu5fB
         inNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778688365; x=1779293165;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=btfGQnO+nL9c8q4hrPoVEJZNf4bkbVRqGDdIFJkLTv0=;
        b=rKYU3/X7G7DbuTCIH/mldZG0qDCpDSxKkvsyF2td+KmlbEkrW1N5QKC/i6p8Xd+pRT
         gUeXmmIHOnABLXKC1NnKSmXSF9MREywMSn8hTLCIAXhE1erVCeb2Fs0JFYU8XlOVD9la
         Aeo3iBGhOEqjpgur1Nz/MX6Dn2Eshpj4hzN1m1uDorgtFTAEayJJqWop63dbXQ2kU9AM
         X4fiCKUmiSqeNFlVsL6j7mExEmW0wv1o1fkd8MiaIM8us2JDaoyKc9hyphOjIJYn2P0R
         dtEevkKAyD+s1ZpXbCJ+xUG1JuRcP47pNkVfPHI+Z9c+n/mBbWCuwJNEJ+w/SYWHNUWd
         sVMg==
X-Gm-Message-State: AOJu0Yxtx4a4l3OEEZP7Bc37PYDIQhLPDEz6+qlmvRobtBfx3tbeHrLA
	tNKEUmRNVIkGx0plNjZfa526eTTmxI74oM8jAc77CX9DpiSdpYsYXz4WTrQ82Vhl3FN6LRbKSx7
	TN/0mng==
X-Received: from wmrk22.prod.google.com ([2002:a05:600c:b56:b0:48a:5531:d9cb])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3b15:b0:48a:5342:36b5
 with SMTP id 5b1f17b1804b1-48fc9a3e5eamr56789945e9.21.1778688364709; Wed, 13
 May 2026 09:06:04 -0700 (PDT)
Date: Wed, 13 May 2026 18:05:52 +0200
In-Reply-To: <20260513160552.4022649-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260513160552.4022649-1-gnoack@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260513160552.4022649-4-gnoack@google.com>
Subject: [PATCH v2 3/3] selftests/landlock: Test OverlayFS renames w/o LANDLOCK_ACCESS_FS_MAKE_WHITEOUT
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, Christian Brauner <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, Serge Hallyn <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Even though OverlayFS uses vfs_rename() with RENAME_WHITEOUT, and even
though RENAME_WHITEOUT requires LANDLOCK_ACCESS_FS_MAKE_WHITEOUT, a process
that renames files in an OverlayFS can do so without having the
LANDLOCK_ACCESS_FS_MAKE_WHITEOUT right in that location.

This works, and is supposed to work, because OverlayFS uses the credentials
determined at mount time for the internal vfs_rename() operation. -- The
rename happens with the credentials of the user who mounted the OverlayFS.

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 tools/testing/selftests/landlock/fs_test.c | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index bdad92195f62..0c29887278d0 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -6963,6 +6963,37 @@ TEST_F_FORK(layout2_overlay, same_content_different_=
file)
 	}
 }
=20
+TEST_F_FORK(layout2_overlay, rename_in_overlay_without_make_whiteout)
+{
+	struct stat st;
+	const char *merge_fl1_renamed =3D MERGE_DATA "/fl1_renamed";
+
+	if (self->skip_test)
+		SKIP(return, "overlayfs is not supported (test)");
+
+	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_MAKE_WHITEOUT, NULL);
+
+	/*
+	 * Execute a regular file rename within OverlayFS.
+	 * merge_fl1 originates from lower layer, so this triggers a copy-up
+	 * and creation of a whiteout in the upper layer.
+	 */
+	EXPECT_EQ(0, rename(merge_fl1, merge_fl1_renamed));
+
+	/* Check that the rename worked. */
+	EXPECT_EQ(0, stat(merge_fl1_renamed, &st));
+	EXPECT_EQ(-1, stat(merge_fl1, &st));
+	EXPECT_EQ(ENOENT, errno);
+
+	/*
+	 * Check that the whiteout object on the underlying "upper" filesystem
+	 * exists after the rename.  This is OK because it was done with the
+	 * credentials of the OverlayFS.
+	 */
+	EXPECT_EQ(0, stat(UPPER_DATA "/fl1", &st));
+	EXPECT_TRUE(S_ISCHR(st.st_mode));
+	EXPECT_EQ(0, st.st_rdev);
+}
=20
 FIXTURE(layout3_fs)
 {
--=20
2.54.0.563.g4f69b47b94-goog

