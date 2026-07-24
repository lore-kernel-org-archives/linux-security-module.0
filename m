Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA1043FD2B
	for <linux-security-module@vger.kernel.org>; Fri, 24 Jul 2026 16:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784909432; cv=none; b=gIkZ2SX0CGHYq3RkXpRpm2wD0aSAx3gAyOc3T893tyf+MTQyrcoHGFR2su8PrpC/Jx07aGYCKKRhtTwFgEqykfSPtk40/dqJOpqm6fqpxvTIVVUNWGe/XqB/U9Hoyy7gnek7i0n9ey62jOUVB6DXvUCf1JhuauYIpKbpQzJRGUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784909432; c=relaxed/simple;
	bh=v5ccRvQ3YwBo56sOXbb+wTg2aYeK0JeAO/6ffhGxMqQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YHUiwOOFtrx1obtoG2XN0X+DROyq4khe7eLOgXU3qUlRTKgcsLPMtDoGDv1mcfTaTW12W/g+SHj4hy41LF30Zcw55pCTXWk9+oZuwtrnMavzEXny0fWvkEoTHMrpUsOzp4tu1otpmxVF0CG6yewZbif92ZqmO4ibiU5YqUF0z6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VlI/13NE; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VlI/13NE"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49545071724so6497275e9.0
        for <linux-security-module@vger.kernel.org>; Fri, 24 Jul 2026 09:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784909427; x=1785514227; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XP2y7YJIeI2b+dcadaVKNsDvHpELZHSl922WsQhRfYo=;
        b=VlI/13NEYFXFBBvfaqaPNgN7Owygx/eP+dnIa/dFONoKQm7KDUSfIZi7XuXjjKEYt8
         Qj3HgHQjXfNCp+O/LREoJHwYz91rIQbbXtoSNGIKimc3N80POHK6sHA1fpOG44/DCVwS
         lzwf9dBXbahamqEKQ87ynHsdwM3cn6rI+yyMlR61SCRPWCzfYXCPXSlK9ECO8F0jDqZ6
         wUtUXCVMwagJco+r9KZloyHeCSOppMn86qwB7u7H+jSu1rOubHIE6K5SvebuyPhjrydQ
         fGmHHOLFJqDJ/RgtrpQVt68csAzqZg+fcSDY3rA/njyJz2B2K2YmUtPWRoJDfG8f9bY5
         Os6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784909427; x=1785514227;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XP2y7YJIeI2b+dcadaVKNsDvHpELZHSl922WsQhRfYo=;
        b=i/64JKzZIRmz5wsIkKYm+N6p0OKZpSjBAQrv+oYL0dnffKJgbo6nClwKKyllWPhV/n
         qdLtJleOq0Cw78+rlrxCV2A9JfzT4xwbgrne8sDixT/eMd9iRKNhJ9YPA6hLBJRTDZLo
         u/e8eJC8O5zKVAig5HRX4VHBqY0IomIHszQPCce4az6L4JcT228AxSbf98s8Oq6N4gI8
         wdj2sLgKxN+HL6lM2nkA11OQkvDJ/ugtWGcI7/FRFgrp5IadmwPfWWLRbjqDL0R9ooy+
         05xpuDwSWdT8avXuYBeA1BKWzX6iR3soQaOFDRdjg667KIEIS7A0T9QgAGp1J2xD/PLT
         mSgA==
X-Gm-Message-State: AOJu0YxWW8Scdlh4NoEQtEiBjPHp+iNrHs7xt5+x+4+fDvHtPRUigZdd
	cpVrlKD1yNC03010JnO+kHpX0HR+TzUCGzv9KYYdcOTCvKP/A9prvH+gIKqiCtuWEmoo5RaAIyx
	UE6YR9Q==
X-Received: from wmbhc7.prod.google.com ([2002:a05:600c:8707:b0:493:ae35:2761])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:474e:b0:493:ee2b:c876
 with SMTP id 5b1f17b1804b1-49573d22ee7mr112299445e9.35.1784909426695; Fri, 24
 Jul 2026 09:10:26 -0700 (PDT)
Date: Fri, 24 Jul 2026 18:10:03 +0200
In-Reply-To: <20260724161004.2360749-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260724161004.2360749-1-gnoack@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260724161004.2360749-5-gnoack@google.com>
Subject: [PATCH v4 4/5] selftests/landlock: Test whiteout object behaviour in
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
though RENAME_WHITEOUT requires LANDLOCK_ACCESS_FS_MAKE_REG, a process that
renames non-regular files in an OverlayFS can do so without having the
LANDLOCK_ACCESS_FS_MAKE_REG right in that location.

This works, and is supposed to work, because OverlayFS uses the credentials
determined at mount time for the internal vfs_rename() operation. -- The
rename happens with the credentials of the user who mounted the OverlayFS.

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 tools/testing/selftests/landlock/fs_test.c | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index fe5faeca83eb..73770dbb0592 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -6972,6 +6972,45 @@ TEST_F_FORK(layout2_overlay, same_content_different_=
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
=20
 FIXTURE(layout3_fs)
 {
--=20
2.55.0.229.g6434b31f56-goog

