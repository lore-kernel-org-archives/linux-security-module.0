Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232B641DE0D
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 15:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785512662; cv=none; b=FdPAGxyfhetiMt1mMpDNu3W7kua6n28v72MJXOossNPwrSTNSTsAD7rtZlB3kzmS6dAzOi4ITZImiXLKigv5M5Tgcun3g2D0gyBDSX4Wbt0V8qAIdmw+U/ygr/VLq77siaXZAZSenF+Muji9pwSY+CsLOuy5wisi9McTCLp64MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785512662; c=relaxed/simple;
	bh=aKUoONfgZuM+HqwJkkbJsSz/h+L+hsouDolGA2i9NpE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hE7EGIJejddGx8C2bFrMilDiaiUOhgs3b5WEzxBa9b6uWqNqwCJx3iY4otZSSUb8CuN7SMLUg1GxuD5zTLyPLIrA3o61FOcTEQuIAXozABtKd0mLqvBj5UdcLYXRdzN8m/UBgYUwSw80yt8fPX9/LSoBh8b/GTrh072aOWcQAu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dWqJSKnu; arc=none smtp.client-ip=209.85.208.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dWqJSKnu"
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-69841da1946so1196859a12.2
        for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 08:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785512659; x=1786117459; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4H9TSJ2HG8lfDPdulVhWQ3S9NDYSxxwgCMtvTQJZAaM=;
        b=dWqJSKnuTjFLTmbYZbAm+syNoCU873mhJVHiXqLctVOryrKyPvTC4MluCP4SmAbqlr
         5Fp2lzzBANb6c3PqReWOwH9qsWiQ2csoP8DLUa7tPvUpcTgpaWruSsZTGxHX+ojBk7e/
         /o3Pnutd+dYIBMdnTHiM9D5tr3qvdf+gh9I9353ervGLI8bL79oX6yPs5+rBujDm+hmF
         xgJT3bxf4RV33vz2Tme3I9zGh+A64ZePxpgNFnWc9MUks77fA3jgL8ViM6QxQoMXDI9g
         4vZrFEfVabmlh59ff3jvUHcElLaxsFanBuNXTzkOiDZg14ypT3I+UgWK7cztKDjt2Rk/
         HHyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785512659; x=1786117459;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4H9TSJ2HG8lfDPdulVhWQ3S9NDYSxxwgCMtvTQJZAaM=;
        b=pRzOdRxFjOBNBrZgf1jXhUumTMOItZcqrt2RphAnegvz741wFctmtrC2TEnsjJtPMN
         mjUPyCtgdmwxH9O2rTUFwvaCLHHnJ/WAhLn5BMF5EPYZQ4dMs3yR2rQvKKqTqygyOcPH
         SmvV2j6MdsHNUirc92Shu8BoNy11aKb1F8xH7mVkapTg8fN8jFPFtRS0Cnx0NkZa3wSZ
         B5CBBlf6uNNKhq6lM6gK268vSmOlJBLybgPEWFdlNgaBGxx8yQj23Kbewal28ptrKZRt
         ajcA74zdzvdkVtlsLUpSHtVlYRW3iMtbFEnUs1RKcIfB2nVinjAxhOZnsuUSuXsA9p/P
         vMwA==
X-Gm-Message-State: AOJu0Yw7+zreNdrM79nfkN1qm75Wo2aI8wwg7DmnSIzDhtFY7nYyVvCa
	/ojbmCXlWhOi7Q601SxxucL7Ai8XEGwn3ft3/dezObaeY4KTB0zPTijh4bSE/dmor2TQ8Jyfb9I
	WNRfu7Q==
X-Received: from wmgb5.prod.google.com ([2002:a05:600c:1505:b0:495:6060:d6f4])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:4348:b0:6a0:1704:de29
 with SMTP id 4fb4d7f45d1cf-6a0a7d2d0a5mr41388a12.33.1785512659218; Fri, 31
 Jul 2026 08:44:19 -0700 (PDT)
Date: Fri, 31 Jul 2026 17:43:52 +0200
In-Reply-To: <20260731154353.1790268-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260731154353.1790268-1-gnoack@google.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260731154353.1790268-5-gnoack@google.com>
Subject: [PATCH v5 4/5] selftests/landlock: Test whiteout object behaviour in
 OverlayFS renames
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, Christian Brauner <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, Serge Hallyn <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Even though OverlayFS uses vfs_rename() with RENAME_WHITEOUT, and even
though RENAME_WHITEOUT requires LANDLOCK_ACCESS_FS_MAKE_REG, a process
that renames non-regular files in an OverlayFS can do so without
having the LANDLOCK_ACCESS_FS_MAKE_REG right in that location.

This works, and is supposed to work, because OverlayFS uses the
credentials determined at mount time for the internal vfs_rename()
operation.  The rename happens with the credentials of the user who
mounted the OverlayFS.

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 tools/testing/selftests/landlock/fs_test.c | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index 2701f00c79ae..306f0164b5e2 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -6977,6 +6977,46 @@ TEST_F_FORK(layout2_overlay, same_content_different_=
file)
 	}
 }
=20
+TEST_F_FORK(layout2_overlay, rename_in_overlay_without_make_reg)
+{
+	struct stat st;
+	const char *merge_fl1_renamed =3D MERGE_DATA "/fl1_renamed";
+
+	if (self->skip_test)
+		SKIP(return, "overlayfs is not supported (test)");
+
+	/*
+	 * In this test, merge_fl1 is a FIFO file.  MAKE_REG is restricted, but
+	 * MAKE_FIFO is allowed.  Despite MAKE_REG being restricted, the rename
+	 * on the OverlayFS works and creates a whiteout file in the underlying
+	 * upper file system.
+	 */
+	ASSERT_EQ(0, unlink(merge_fl1));
+	ASSERT_EQ(0, mknod(merge_fl1, S_IFIFO, 0));
+	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_MAKE_REG, NULL);
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
+
 FIXTURE(layout3_fs)
 {
 	bool has_created_dir;
--=20
2.55.0.508.g3f0d502094-goog

