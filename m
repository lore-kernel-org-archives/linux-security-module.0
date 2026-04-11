Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A3233030F
	for <linux-security-module@vger.kernel.org>; Sat, 11 Apr 2026 09:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775898637; cv=none; b=Ao0nF4It81pV058jATb326pBBiup6kOLWZBjsZ4vkuQaRB3aqpQUOOf4k4nqBUIQ/W1tyfYLZivWnborxUCXr+R+E2DjIyjyitMQg4iSL0kPc5lketKmkmfcuSEptQ7ueyMn3Fm7zPG+Ur+tW7+gKRhbf8Y4QLX//XGZKxkdEUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775898637; c=relaxed/simple;
	bh=Js+pvHdZfZaUrBFysXEJqrIWU3Tqm2pvYV+EtMmrzj0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=stLJxh1fIzgK4XyVUllv9NjJtijWhU3cTjwRgnkNZ+bahtKhW64qcii634JWJ34jkq6+yBNvxPlh9DY2BzVKZ8HAfCjfbRZAJkVW5r3v1OYDRNJ6nUnn1PSYF+3SAItHOv1qeCBcqy/alE4kvlZo2yLRemkMEg+8dm3OzirLVRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R3ZPsA3s; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R3ZPsA3s"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-488df213f8bso2316785e9.1
        for <linux-security-module@vger.kernel.org>; Sat, 11 Apr 2026 02:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775898634; x=1776503434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qXZ7hVyNV+J9DaGwWeoXNYLiN9KJhcyX3JwSvbKBF8A=;
        b=R3ZPsA3slZn+cqN2k/1m6guhj+LS2TEFJ+wJ+P6+0MfQqw4CA5LyTRLmh6U96zc8m5
         bLCqa24bx9EAFL7w9QiDLMkjr4qjcfB2TkwixF1S9dRsHXG3Ax1ysk/zUAO7iBLGTxD5
         CkfJQrCsWYKWGwDY7DMH2qpF9in5QVIrocOwOz+AZVRN9RGsikebYgL1ULyS2oT9nT19
         HOY0gkPhukbGdAu+MnNwSVDLXZmo1pzjw99utlSiswPulZbLLYfzSI9zaGLypjzR3IS+
         t/XzoWje6XlF/BqW/M+5ymxC23rq84xYFR/WNxjbbgwaqGzU4mYF0Ls/StjYmbljKzt0
         ArQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775898634; x=1776503434;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qXZ7hVyNV+J9DaGwWeoXNYLiN9KJhcyX3JwSvbKBF8A=;
        b=n6Q7f3MngNcRMs1Q8Sk0BV74XGhUIIc0ILYfSsphitmIvv69399SkCmt2ti1d9BTaL
         ndCIsNU4X606fjuhqDK0mDB/9Sn5c7UO8Qn8wM0eUSLfb7oF56170inzJ6oYCsu3hMQ1
         GEsm/woIk6t+EJVqQMYsDouFWUgp9wpL5gneR2T7FhLS5VVajUeaID9cL9CcHa7+G7eu
         OVgwX25uf3kMlZywujLpwM5wP+w5XkDyEyAC8h8Nd4AzUBb++/NzYSyyhQ7uy0POPK4n
         gwAp7b2b5dkITC5K7C8gyaKY7P0M/xFOtp25ht+B2Rv7MgkS10NRYlIhStCo5WSFlioa
         +0mw==
X-Gm-Message-State: AOJu0Yystm9Lqt81TlIQBAMbGE2vkI8ZPkSM/Zu54hftsWK5y3n8VS8C
	inDsx2j9K93sXOay5e9zakDMeMUBzqW/OZeRwLJcNGWvKptelwZYliNwc5VUzlBnKTt/ac1X9P6
	YCFc8mg==
X-Received: from wmco3.prod.google.com ([2002:a05:600c:a303:b0:488:c127:b938])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600d:8453:b0:46e:59bd:f7e2
 with SMTP id 5b1f17b1804b1-488d68ae9b7mr64344655e9.11.1775898634404; Sat, 11
 Apr 2026 02:10:34 -0700 (PDT)
Date: Sat, 11 Apr 2026 11:09:45 +0200
In-Reply-To: <20260411090944.3131168-2-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260411090944.3131168-2-gnoack@google.com>
X-Mailer: git-send-email 2.54.0.rc0.605.g598a273b03-goog
Message-ID: <20260411090944.3131168-5-gnoack@google.com>
Subject: [PATCH 2/3] selftests/landlock: Add test for RENAME_WHITEOUT denial
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, Christian Brauner <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, Serge Hallyn <serge@hallyn.com>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Add a test to check that renames with RENAME_WHITEOUT are guarded by
LANDLOCK_ACCESS_FS_MAKE_CHAR.

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 tools/testing/selftests/landlock/fs_test.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index cdb47fc1fc0a..d867016e3fd3 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -2247,6 +2247,19 @@ TEST_F_FORK(layout1, rename_file)
 			       RENAME_EXCHANGE));
 }
=20
+TEST_F_FORK(layout1, rename_whiteout_denied)
+{
+	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_MAKE_CHAR, NULL);
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
@@ -6949,6 +6962,7 @@ TEST_F_FORK(layout2_overlay, same_content_different_f=
ile)
 	}
 }
=20
+
 FIXTURE(layout3_fs)
 {
 	bool has_created_dir;
--=20
2.54.0.rc0.605.g598a273b03-goog

