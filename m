Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3C2318EC1
	for <linux-security-module@vger.kernel.org>; Wed, 13 May 2026 16:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778688367; cv=none; b=WhUkNc/OiqHqU1RyRKdsWadk5r6AY/P+FWutRyvEOCP94AEF74BFUDk505ZLThSmNFPmMzwOTUA55Q9flUiexZ2rjd34L8Jtplf5UsFx2ir2gaDmEnAFRKTKlx3c7HXWCG+IuN8efUGR7IfvZpwg0DcCljKorSKK4WHR/DfbA84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778688367; c=relaxed/simple;
	bh=LtQu5Ts6FLQCutyYUK191hDauphYdyu8JnCc1b1kd6c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LClrNNSa2S7qa1FuhFJI3cTMLJ9Z0EbwQhOZWRUJD/LgH1lcnyYhOBBFjx2x4gCl4LnvQtgHeEH5u/FtrqvFzGZX/mAz0j8lxir0Cq8PaFivI/+AKfLDQ499NNgMjFXQl8X2PDS2fhNz8ChN/HRxn+AoFeIO26qGguUAToul6Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cKcBeXIj; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cKcBeXIj"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-48eb0da933fso12479925e9.0
        for <linux-security-module@vger.kernel.org>; Wed, 13 May 2026 09:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778688362; x=1779293162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v6iLgg2IwhGx4Px+veoUITyB5prKW5l88fpsVHcBhkk=;
        b=cKcBeXIjmAy77C3t/U1S7tu/1aCEzI0uwwL4UG+5BF3IldbFc3DhA64/K7v8mCq5Jt
         rzjuUH4BcZvvyeeDpjX5EoDOkN+atEZWf+1Lw768+cV9yJrDiVBh1wJQUlXat0wPIRkm
         Go9zSHva4Mn/6/9SQ3RSNgXFV4shjqaUxLhLJvYNFg3CtIcgT6yJ6QDa9UpVtpcPQrk9
         GXEkNT1zb+hoZ60MZTtxgDrc/NznYtnvPzpvTYvbnf9gr6RDdhoH9VQbPGn1+CXNeXng
         xjqbijz5aUmZYjIUDVH124xNfrq3u/dueZyqqOvrjU0eXxAl0C698Q2z9x7Z4luNlv/V
         YFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778688362; x=1779293162;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v6iLgg2IwhGx4Px+veoUITyB5prKW5l88fpsVHcBhkk=;
        b=p7Bsc+gTTN2rJBoT8zBkvzQdwWCLmxH7Xyad3xNlOA6l/Qb1gBH9EQoFlPF5pzIv0F
         +utw/P15tKsvdmd0Im1lI1mtrPS5Vdr6jfZnAQmEaY81/mQSnYzQi9I8zYgxEBdngyZJ
         eeEaBvvPVjVWhysEXZz63k1YINXlpNbQ7mP2uvGA0//hE3dqDoIYN6UG6QBEkrIUs9Vg
         qxnLyJpoXcdeh6q8psutQWW2EIPXuif5+tKdG5+viXSsWqICwonP7h3Lii+IDueebEZa
         MLIhYhExM+i0Pf6nbwM8nzyB3cHlAXrbAoUQDu329O9abRvduORzwHQsMkzVq7Q1MbUU
         x3aA==
X-Gm-Message-State: AOJu0YzVCEF1+hy0Gtj355AFF7DFPr3x54htLN4wIsA4+pSA6UHZ+fGB
	yHGT/4Rcz3h3WkNq91uev3vQKLRqAz5sh+Z2kbdtIFSs9z//8JBqE9c3a6gEzXQXGlmcqQzxzVe
	S5NyEBg==
X-Received: from wmbjx7.prod.google.com ([2002:a05:600c:5787:b0:489:1ad9:4a6b])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:5010:b0:48a:53ea:13eb
 with SMTP id 5b1f17b1804b1-48fc9a021bfmr55133765e9.5.1778688362146; Wed, 13
 May 2026 09:06:02 -0700 (PDT)
Date: Wed, 13 May 2026 18:05:51 +0200
In-Reply-To: <20260513160552.4022649-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260513160552.4022649-1-gnoack@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260513160552.4022649-3-gnoack@google.com>
Subject: [PATCH v2 2/3] selftests/landlock: Add test for RENAME_WHITEOUT denial
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, Christian Brauner <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, Serge Hallyn <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Add a test to check that renames with RENAME_WHITEOUT are guarded by
LANDLOCK_ACCESS_FS_MAKE_WHITEOUT.

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 tools/testing/selftests/landlock/fs_test.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index 53d1b659849f..bdad92195f62 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -2248,6 +2248,19 @@ TEST_F_FORK(layout1, rename_file)
 			       RENAME_EXCHANGE));
 }
=20
+TEST_F_FORK(layout1, rename_whiteout_denied)
+{
+	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_MAKE_WHITEOUT, NULL);
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
@@ -6950,6 +6963,7 @@ TEST_F_FORK(layout2_overlay, same_content_different_f=
ile)
 	}
 }
=20
+
 FIXTURE(layout3_fs)
 {
 	bool has_created_dir;
--=20
2.54.0.563.g4f69b47b94-goog

