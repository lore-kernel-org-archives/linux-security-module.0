Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7617433030F
	for <linux-security-module@vger.kernel.org>; Sat, 11 Apr 2026 09:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775898640; cv=none; b=dO4y2pjqzm8bYD45aghSXnSZLIGOVOBdSZxklI8eiAB3s66dMBuC3cqWQt52xP4gNI0LJFAXhVrv5DSrgsA4/+Y5t8xoib6muJz7UqxBsn2xuacpsp1BzBEWgpeClBgVVOL0HE8lMYVc1TiQocLqFDdbTPe2885uEuoUoAxNgkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775898640; c=relaxed/simple;
	bh=TJGJJlmuObuMk1a0mhrOptWgVlNY3mmt5yJN1Kem1/U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f0H38mU2GRVga8z8mdkvha/oIW8wMctyoHWDsg6mD25gS48zkMjorT1tqw6eNtjyVZUUq71+Ri4XhHEZ24fKpO+dxzlWLHKdOZ3L7Xv0CQUobwP9+7NHhKohAkBYcUENqDo9GEcdFLNjHZrOe+kFZDSPpsjpAJeVNJ06fRUd0mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IrSUyh+Y; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IrSUyh+Y"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-488dcaf2f2fso3834995e9.0
        for <linux-security-module@vger.kernel.org>; Sat, 11 Apr 2026 02:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775898638; x=1776503438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6FCJxa/S51s5aJDCX+k6HJH5U0vcvWWW6o0Ap45aP9w=;
        b=IrSUyh+Ykhbkpl8DGtt+VZFE4GSjVqGYp8BBjCluMTzFb/Qo2RNX2sdk6LU9ljE+xF
         y80IyVp6L1+dwnu9lB9/Y6aWdLT68FXqtMTtA/7n7hIZ4obKcv5QDb1VQ8SQEvP02S8T
         o6Q39uRzjJZ6XgADITpxJCMiD775ZhG8LFb+4oAz6IfXVoIgff07NEqsRzC/Vq5sUMAX
         ADVqkdktcop5IR1OR+t82Q7MwW5Tc5OsTq7U97r9ncBPHBtKce/jRgyynhXcH+IWZxBI
         NBp1ox7IdsR+w55H9NxcxvX7oSgmeuiEaYEZvAEk9Um5F8x5QUM/XnakevoFrC+4vve9
         MBZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775898638; x=1776503438;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6FCJxa/S51s5aJDCX+k6HJH5U0vcvWWW6o0Ap45aP9w=;
        b=riDea/d3jCzpHTkqGmzi/AehuyadrOwLEnFq0zvKW/nHOTX/pe1rq4Xo9VUM471D51
         7VmNn4Ymnuw0iptSMKUkif10KQqfukvz4cxahZDcyhAZ4gRWLxNixud+EFlcJfHf6GRX
         kVTKWRtQdYvx4EyMRB3NuLPyUbIub6Z7cE6f9OTmlp9+Ke8Gl47abj77t1C462Za/D1O
         8+1jCXckIjhU0gotDY//pDefKyx3aDKm5x+DPmbtvSP4RCTQGiJ/0Jsv2Ty1mME75YeJ
         Z4pECaWYlmeTKjqXkSLxJXTeEd0DpB8Nod1vT9kS+rOWbH7OZ1dzl6SfH/EM4OlFGKXw
         8g7g==
X-Gm-Message-State: AOJu0YxxlQvhGElQY6RllL6owoow1IzeA2V1e2xxMfMU0SRfpA20wjaW
	iv9Fam+LlWeIyRUZmzEPLbXnCiCYeii4r4VhA7rYc941XWe4aAqkuwvlUJaK8yZnQeN3rwRrGt5
	bEmoPJQ==
X-Received: from wmbb20.prod.google.com ([2002:a05:600c:5894:b0:485:2f8c:9478])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:198c:b0:485:3fd1:9936
 with SMTP id 5b1f17b1804b1-488d67b8d43mr80209665e9.5.1775898637916; Sat, 11
 Apr 2026 02:10:37 -0700 (PDT)
Date: Sat, 11 Apr 2026 11:09:46 +0200
In-Reply-To: <20260411090944.3131168-2-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260411090944.3131168-2-gnoack@google.com>
X-Mailer: git-send-email 2.54.0.rc0.605.g598a273b03-goog
Message-ID: <20260411090944.3131168-6-gnoack@google.com>
Subject: [PATCH 3/3] selftests/landlock: Test OverlayFS renames w/o LANDLOCK_ACCESS_FS_MAKE_CHAR
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, Christian Brauner <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, Serge Hallyn <serge@hallyn.com>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Even though OverlayFS uses vfs_rename() with RENAME_WHITEOUT under the
hood, and even though RENAME_WHITEOUT requires
LANDLOCK_ACCESS_FS_MAKE_CHAR, a process that renames files in an OverlayFS
can do so without having the LANDLOCK_ACCESS_FS_MAKE_CHAR right in that
location.  This works because OverlayFS uses the credentials determined at
mount time for the internal vfs_rename() operation.

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 security/landlock/fs.c                     | 11 +++++---
 tools/testing/selftests/landlock/fs_test.c | 31 ++++++++++++++++++++++
 2 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 2b84a229e4d8..9b49f6c3e5da 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1523,11 +1523,14 @@ static int hook_path_rename(const struct path *cons=
t old_dir,
 		int err;
=20
 		/*
-		 * This check would better be done together with other path
-		 * walks which are already happening for the normal rename check
-		 * in current_check_refer_path().
+		 * Rename with RENAME_WHITEOUT creates a whiteout object
+		 * (character device file with major=3Dminor=3D0) in the old
+		 * location, so we check the access right for creating that.
+		 *
+		 * See Documentation/filesystems/overlayfs.rst and renameat2(2).
 		 */
-		err =3D current_check_access_path(old_dir, LANDLOCK_ACCESS_FS_MAKE_CHAR)=
;
+		err =3D current_check_access_path(old_dir,
+						LANDLOCK_ACCESS_FS_MAKE_CHAR);
 		if (err)
 			return err;
 	}
diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index d867016e3fd3..4cf6fc0bcb71 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -6962,6 +6962,37 @@ TEST_F_FORK(layout2_overlay, same_content_different_=
file)
 	}
 }
=20
+TEST_F_FORK(layout2_overlay, rename_in_overlay_without_make_char)
+{
+	struct stat st;
+	const char *merge_fl1_renamed =3D MERGE_DATA "/fl1_renamed";
+
+	if (self->skip_test)
+		SKIP(return, "overlayfs is not supported (test)");
+
+	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_MAKE_CHAR, NULL);
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
2.54.0.rc0.605.g598a273b03-goog

