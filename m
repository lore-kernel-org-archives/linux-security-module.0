Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C83A41DE0D
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 15:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785512656; cv=none; b=qfEhD6YIAtZIgjq3KxCKGR+EDCzV6O1XtTtJiSfCZ+e/s1WlX59G13h0IQYCfhYmWkAc0Phd/hitnPQ+D63M+J4E12+9qdcOEvlRUqFrA9kx9CpT7dSii6RraLbLvMmKteAkSw1x6p+cUqHmwiDeliyIFURgbNaKmeDn9syts88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785512656; c=relaxed/simple;
	bh=TJ9HPSS+M1fe6v9NKzBfwlcx06zPUDntZicQ01w3ItQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mFCl7TXBenB/R+a6C2kfVMJS6FZI9tFwdevS4tr8N84Eo0/oxWDz/vgcaQgoqzX52E8TcRxcrTlbivLGg/QLnI7MJ8iVKBoaI87B78eD0ALISZbFaiSAd1M00g28THw6p4bS4RWlfaacQeqh7MP/F7rclZ53uzTm2dZc6poI2tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cR+VfHe7; arc=none smtp.client-ip=209.85.221.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cR+VfHe7"
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47f8158485eso1170378f8f.3
        for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 08:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785512653; x=1786117453; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Bg+J0hFnk6id2Mxx+bKeBNlau85/xnRytQBYX/Utu3g=;
        b=cR+VfHe7qEDe9RR7vyUNTQLREGX2uNEPt/4rEBdvEYYFzTLt7P/2Zjff8cCNUE+hSs
         vxinFAEpCtxLmV+Aj27U3wNGFx/rehb8tNTE2YAAQHukEJxWgypvDcPXQrNtAJZ41tpW
         H9zOfXFimH09d0pYFCvy8nTY96ODAl8U7hF+sxGQVCbkrp6ciHXHvzonP8JENZIiSgkf
         S1rtQGCDJ2uW/TBo+Xmn6zWyVe+MXYBxZGpl191hzexe14b/ied352HRrT3HldSNCNYY
         73Ny6/JlFKAPmELxDdOZ9CGnP3X5AR50oWcQnh5uLTA5SXrf3AByDll4egnXlkFJJ/0L
         p94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785512653; x=1786117453;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bg+J0hFnk6id2Mxx+bKeBNlau85/xnRytQBYX/Utu3g=;
        b=SbQAyAw2gFjobHEnX+qV47PdaNVN+2n8mvJBDbod9qmnAgNoX4UJIjdVLjQCsNDAs1
         vwIyN0FK6pQ8qAG/w/z1bKGE7Klr5Oia9jjTNJ74M2e02Xb+BOPWjOgY0Dcm77FlPTIL
         shYRkilSUMT1Wy723JafiEg+TydQmXJ3dPv0B4JuIrOz8Zyk8bsC4VFoBMKjdM6dkvX8
         SF153c0l5FIZZ4QpCLwHOmRSssAVu9C9og6VnL4uhv2utVxrz0OKIWEJEmwnWo8ww5Kk
         bVLhKUAVrMWCBJ+44IdWJKQbQDzfpLXrN9+tpMNt0bJrl/yVuJT5VT3U0spUM+p8TPSL
         LS2Q==
X-Gm-Message-State: AOJu0Yzi1/wLmBhkPhEHjv/svkYfAA1QMPQYHQNhWAOs08tCK09Z+eRY
	7tZ4P8ENnmgd8/6T9f39y5d7U/Jo5JgRuxkzkTah2NvWkWTUKcL5IpRUi6wvwkO7GO68nk1x/sT
	jiY5T/g==
X-Received: from wrqm17.prod.google.com ([2002:a5d:4a11:0:b0:470:8b9:c366])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:470f:b0:47d:f445:9490
 with SMTP id ffacd0b85a97d-47fd7335076mr185984f8f.60.1785512652920; Fri, 31
 Jul 2026 08:44:12 -0700 (PDT)
Date: Fri, 31 Jul 2026 17:43:51 +0200
In-Reply-To: <20260731154353.1790268-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260731154353.1790268-1-gnoack@google.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260731154353.1790268-4-gnoack@google.com>
Subject: [PATCH v5 3/5] selftests/landlock: Add tests for whiteout object creation
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
 tools/testing/selftests/landlock/fs_test.c | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index e82b56a74c5f..2701f00c79ae 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -2247,6 +2247,25 @@ TEST_F_FORK(layout1, rename_file)
 			       RENAME_EXCHANGE));
 }
=20
+TEST_F_FORK(layout1, rename_whiteout_denied)
+{
+	/* The affected file is a FIFO. */
+	ASSERT_EQ(0, unlink(file1_s3d3));
+	ASSERT_EQ(0, mknod(file1_s3d3, S_IFIFO | 0600, 0));
+
+	/* Deny MAKE_REG, but allow MAKE_FIFO. */
+	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_MAKE_REG, NULL);
+
+	/*
+	 * Try to rename a file with RENAME_WHITEOUT.
+	 * file1_s3d3 is in dir_s3d2 (tmpfs), so it supports RENAME_WHITEOUT.
+	 * Denied, because whiteout creation is guarded with MAKE_REG.
+	 */
+	EXPECT_EQ(-1, renameat2(AT_FDCWD, file1_s3d3, AT_FDCWD,
+				TMP_DIR "/s3d1/s3d2/s3d3/f2", RENAME_WHITEOUT));
+	EXPECT_EQ(EACCES, errno);
+}
+
 TEST_F_FORK(layout1, rename_dir)
 {
 	const struct rule rules[] =3D {
@@ -3270,6 +3289,13 @@ TEST_F_FORK(layout1, make_char)
 		       makedev(1, 3));
 }
=20
+TEST_F_FORK(layout1, make_whiteout)
+{
+	/* Creates a whiteout object (creation guarded by MAKE_REG). */
+	test_make_file(_metadata, LANDLOCK_ACCESS_FS_MAKE_REG, S_IFCHR,
+		       makedev(0, 0));
+}
+
 TEST_F_FORK(layout1, make_block)
 {
 	/* Creates a /dev/loop0 device. */
--=20
2.55.0.508.g3f0d502094-goog

