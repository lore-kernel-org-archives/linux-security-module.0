Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3862E632
	for <linux-security-module@vger.kernel.org>; Fri,  9 Feb 2024 17:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707498389; cv=none; b=YxTK816OnYpEeUwnsoSjDjs5dzYAsPv2vpvCHgZ/CxPdgmAG+D/CmIsazePXt+cm8J/teB9R21t1VkL23/5uYbWH2Hln6Dq6jqmm8V9m0eZ2o68XQHv+W9vSD3yO/PvUXmdo69XQK4SzZjiJ8N36A15553G58tDPmfWacPMD8d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707498389; c=relaxed/simple;
	bh=qnVVQyk96V+29yOrH9p87U8Q4CRd3DD7DhbdDzGIkLk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=kGs8MZ196sbIkUcmGzkEQzMufxYRRvGwRNfC8lCCBapsOqNAUsmPdxzGpaCtbSJgYi6Cn73Vxe0nurmVqW3EHDPmeFLPMeZ0/e3ZGX6pDJPEVonFX+G0zUpquvnkql7tzAVirsEWJMUQ+RSV+PsurNcRZNR3QrPVtt0LdSi5VPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CFTi9fAZ; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CFTi9fAZ"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-55fc415b15aso1371268a12.0
        for <linux-security-module@vger.kernel.org>; Fri, 09 Feb 2024 09:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707498386; x=1708103186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gbIxtpk2chw6jsiB6rCOoopjh/LiZGd5/fSxW0kPD1E=;
        b=CFTi9fAZ8SfLI02MxJyk2PoEZ1CFkiRFXgoqA+U3JhaQZJMWpJ3mfAwd2sYB8QARsf
         7eDBBYx/u4ki/8BhujqImLSWaRrGU/5VSkk8mypef5vPcAgQqQafjqNziXNhkrTM0FZ0
         0QGDzNPmZMzVRzNp/tAF5yyDBKh/D5isYuEb0iMTogVzytyBhM+Pn95mpUVJL9L4/9wf
         q0lrXVX0d6acl2uTw+mNsiWe/u6f4E/zTa+F8LajeeWqikjXUfeYAxxryITH6EaJ91x5
         9NIPVLS1o6MzTUMJXzCBQfqVrabcG59xDhvV57NeflBo6X6qzWFTF+kGLaf1WiQxJAY+
         PVlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707498386; x=1708103186;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gbIxtpk2chw6jsiB6rCOoopjh/LiZGd5/fSxW0kPD1E=;
        b=QyjYGaq01dw9q7cjOL2yLxLXb2KppRfT6Ii/HkfyiS0n1QQ0HTH+yfHTJHpVhZGbQa
         mbu/7xfH20mM8dIRvnsxv4vdXXXBc21IWNg953rEy+6mUitiTBwq82b9cf9QAzn8+a2s
         2m3LyaLV5369j3siJ3PAiaNDiQidx4DLpiHscS3iXaxWiyEk+oJbsUnl9ZGnlcUdhEuL
         usOIGqZI+fnap+JLdJUXhP/jSKKTRuuw8waUXC5Al3cEuAf4h18BizPQBQOvpFq6Te0o
         vgGApG83T6CUGRcUmgFLGYQ6nvMu9MIkxgQ2O6Wkc/YW8GcxTrbrk0YBbrQf8LrORlhc
         xdqg==
X-Gm-Message-State: AOJu0YyKV9/uancMunxUNJCl/rFCA4fefg4Li9xiDsWwh1yh/xfSvum+
	CkSg4hyYNZsDeD5USqM2awvDpRIwj1znwApBHDKzX6/0Mg2mwRqe8Pt/szYhMEB4Zf3qMiJ54Z5
	hXZeDWNxS5GuQ0EtjeH32aS2qoAo3T5i/1SLawLVF4LdmgVN2C6O5RcPfpMMHWgC3oJS5asw61G
	IlW5CybAyhoYIeRtqSVbuj7ZLVPIm1czFBmvP+6+wjDjGLYW+uFfs4
X-Google-Smtp-Source: AGHT+IEkXTF2JnkhhOCozajRd1N6fTjDERadCVkYE3Gcr63l6dmKM2d5Wmn7khHsRaEPtLo/oxdM9j/9THQ=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:3162:977f:c07:bcd8])
 (user=gnoack job=sendgmr) by 2002:a05:6402:400f:b0:560:aa2e:676f with SMTP id
 d15-20020a056402400f00b00560aa2e676fmr5547eda.3.1707498386021; Fri, 09 Feb
 2024 09:06:26 -0800 (PST)
Date: Fri,  9 Feb 2024 18:06:07 +0100
In-Reply-To: <20240209170612.1638517-1-gnoack@google.com>
Message-Id: <20240209170612.1638517-4-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209170612.1638517-1-gnoack@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v9 3/8] selftests/landlock: Test IOCTL with memfds
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: linux-security-module@vger.kernel.org, 
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc: Jeff Xu <jeffxu@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Because the LANDLOCK_ACCESS_FS_IOCTL right is associated with the
opened file during open(2), IOCTLs are supposed to work with files
which are opened by means other than open(2).

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 tools/testing/selftests/landlock/fs_test.c | 36 ++++++++++++++++------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index 6ff1026c26c2..aa4e5524b22f 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -3848,20 +3848,38 @@ static int test_fs_ioc_getflags_ioctl(int fd)
 	return 0;
 }
=20
-TEST(memfd_ftruncate)
+TEST(memfd_ftruncate_and_ioctl)
 {
-	int fd;
-
-	fd =3D memfd_create("name", MFD_CLOEXEC);
-	ASSERT_LE(0, fd);
+	const struct landlock_ruleset_attr attr =3D {
+		.handled_access_fs =3D ACCESS_ALL,
+	};
+	int ruleset_fd, fd, i;
=20
 	/*
-	 * Checks that ftruncate is permitted on file descriptors that are
-	 * created in ways other than open(2).
+	 * We exercise the same test both with and without Landlock enabled, to
+	 * ensure that it behaves the same in both cases.
 	 */
-	EXPECT_EQ(0, test_ftruncate(fd));
+	for (i =3D 0; i < 2; i++) {
+		/* Creates a new memfd. */
+		fd =3D memfd_create("name", MFD_CLOEXEC);
+		ASSERT_LE(0, fd);
=20
-	ASSERT_EQ(0, close(fd));
+		/*
+		 * Checks that operations associated with the opened file
+		 * (ftruncate, ioctl) are permitted on file descriptors that are
+		 * created in ways other than open(2).
+		 */
+		EXPECT_EQ(0, test_ftruncate(fd));
+		EXPECT_EQ(0, test_fs_ioc_getflags_ioctl(fd));
+
+		ASSERT_EQ(0, close(fd));
+
+		/* Enables Landlock. */
+		ruleset_fd =3D landlock_create_ruleset(&attr, sizeof(attr), 0);
+		ASSERT_LE(0, ruleset_fd);
+		enforce_ruleset(_metadata, ruleset_fd);
+		ASSERT_EQ(0, close(ruleset_fd));
+	}
 }
=20
 /* clang-format off */
--=20
2.43.0.687.g38aa6559b0-goog

