Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F646392824
	for <linux-security-module@vger.kernel.org>; Wed, 10 Jun 2026 09:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781083412; cv=none; b=RStor1owmwgvQwpAFBZ6OmO3G9u2jvWFvTn0zMBhmlJVBj5ekfYpuShHFbBseoVG5Y6rfrz3Mc13ALWkBcudfEkiau8+Yata4pl6Ghgy930RL66Gx0b5UXCwz+TKUBIBhhP6scGxa4or+V/A6zZ66V8sXrcU7bNBgLippvY3Ers=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781083412; c=relaxed/simple;
	bh=ag2IfMkAvnO2xW4LY70l743baJgjNsjtzdZkGT0z11s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g/FU+3eTQTS7ws9yBbhsG4oWJ4xSUQYfqRVrcuM8jP1BP1QeSBZkpAVL/7IbQv8FD8DLQNOFzK1ZJGFTdjUhFKCEeQJvfzzv/f8ZlnbNACAgwXJbKYNwe11Q9s8oCchqaW7bd/HJHo9+f/pmTXY/gVMe4p+s3XvFXsd0xooQ43c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VBWj48Vh; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VBWj48Vh"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-490ae0167ceso30365095e9.1
        for <linux-security-module@vger.kernel.org>; Wed, 10 Jun 2026 02:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781083410; x=1781688210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xIOGH79Vtz9Ik21CD9VRMixc82R49Gggm9QyQYE19zw=;
        b=VBWj48Vh/nQdp+x4NwK3nhVB2IN1tK7oHdk+srAAKkdVxgpxez6NEh/fPSlB0LIWb/
         pgbtfXsPVPLAh8qRELwHQlIqKbijK5l2eZ/F83wmhgmZIlEiW3NaEe2w1rFfdtenxfOs
         nB8POh5YXzGRFWIZ7B+KvJMBIfbv/gw5SMegI3zYV5zgaBnY68WyRWfEPxR6bPdsP4u3
         kbA4KoNrnVQ8ZfS2hpbhyxjuR3FLyQJ2qnfSIqIhqNTnmzo3KmPJLff7QF5Em/O8LuIL
         bG+8yrA+XpG8dvGaEUzt5edBVMh79GRCtB06PZ+OATi9bWitmMAD+o5fstuSfvIYVn02
         wmgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781083410; x=1781688210;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xIOGH79Vtz9Ik21CD9VRMixc82R49Gggm9QyQYE19zw=;
        b=Tlt3qt3/j/v1SUWEN6Nr2s35TIvesu4jP7ygEgjaRUCcTdT9sqc3YXIw0L6foK8MnB
         oQuMuXDq6Ecys2w4KfGKvy6D3u91CN0JXg9d+JGnZqu6DNC1v4ZZfrZBS/KzviVQ8H4u
         DeYDpGrPgH9jTMRCUYEf8j2kFB3CLVVdWdLU5rh51i6aLUVR6Zx+T3RwTKvRqOmvvtpi
         8/W8YuYSgguzb5FcI8F/mSWYXMxRAgNH3+JwsWjQ4BRNDxWhJkGfPq4rGHhUUx+KAsKs
         VyXtrDpkI9fbyT5NPeiy0074kYyWPElb9gpo6VnriNuAv4nr6qU3if6oSgI/zFtRoU58
         OlAQ==
X-Gm-Message-State: AOJu0YzHH20Rw5Fe64j0HBV33uIx5JxoPGLUF3u+pGNH35150vCjzJhf
	3MBGRVe9aszVKgr52iOa/mAPlPCzBb1oO5MRta4jXspn0XjJuLywULdvQpLcEG/dzVU0mxXSEl/
	45Tv3Bw==
X-Received: from wmmo1.prod.google.com ([2002:a05:600c:601:b0:490:b573:93c6])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:a117:b0:490:c2a3:3302
 with SMTP id 5b1f17b1804b1-490c2a3336dmr281702745e9.35.1781083409789; Wed, 10
 Jun 2026 02:23:29 -0700 (PDT)
Date: Wed, 10 Jun 2026 11:23:18 +0200
In-Reply-To: <20260610092318.3868884-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260610092318.3868884-1-gnoack@google.com>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260610092318.3868884-4-gnoack@google.com>
Subject: [PATCH v3 3/3] selftests/landlock: Test OverlayFS renames w/o LANDLOCK_ACCESS_FS_MAKE_WHITEOUT
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
2.54.0.1099.g489fc7bff1-goog

