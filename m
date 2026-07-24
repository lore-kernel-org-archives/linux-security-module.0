Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D3C3016F5
	for <linux-security-module@vger.kernel.org>; Fri, 24 Jul 2026 16:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784909422; cv=none; b=dw7IMPys4fxi/kyZnVCEG/37Q55Ggjs6YJ09kepJcLdBb/sAVbDFoJR/aUKtI7++Z5m7Z2NFUY6jNEbhckdagrVTPUQjWyGpgCRKg0TeLuLCd/THltQJyaS82Vo+ogO5/nmEOcfh6qCLMO5sIRQ+BYPZoQar8yJw0s+N9VjBMMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784909422; c=relaxed/simple;
	bh=VWMzx4TPf8qzWt6Bhha4pWQo/Q9dvOg0cc/qUxFFnVI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t3tb3y1pCrxTUN+KPWMG1wbpDW8lH+7/JTPcDSk3o5TmH8GP0nkK1c6N39bdgKvY/xxCLQp222bOas8bO4VbcXEmNBli+QR3ERHWaAVFyeQrrrEYymLxNiwjkWx0lhPuhx0Gg9LCDHJQvOmWYPR4Dbz/UCn0NcsWiMxTt48nk4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dVcCC1hZ; arc=none smtp.client-ip=209.85.221.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dVcCC1hZ"
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47f5a972b0eso552829f8f.2
        for <linux-security-module@vger.kernel.org>; Fri, 24 Jul 2026 09:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784909419; x=1785514219; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=88T1TJ90Gq3SY2/jtE9W0IbtrAZou9Bc2XovzZLNGoY=;
        b=dVcCC1hZuALcRiZGfpyC2ys0Wi+iJUk4Z4uDb5yF3z8iGnZixSvOk/OSMUpB9GC0k4
         14Kw6ExIM7hx84mullyG8144DYB9TYqJbfDwkOnAWp0LLtIcwRBZoRkhO6bx71WH3uVE
         D8czWUI/fZNQ1uIXaxLZfNEdXA5vpJ+VZxiEgf+oZtbeDk1Doh6gwTNsJdgwOHPYd6Dw
         EBGQg3c5ek2YlajKCNQJNVoYnSG+YyrDXrUkDWJvP2auDKd3albn/QBLx5/x3/Eexnl0
         2yRfZvWfp+Llr3eOATqEr27gh1y572mk9FeAVsqVxKMfSqAqoDwv68JYx/260fLW/ZfI
         Sf7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784909419; x=1785514219;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=88T1TJ90Gq3SY2/jtE9W0IbtrAZou9Bc2XovzZLNGoY=;
        b=l6/Lrne0RxctWsTpZBbv/jqEbbac3DgcYbsTi4rNe/LTGPW8ArxNkBznsB0J4jsSP+
         Buku1wP6ENdBPlW0AR/Ik98+13QkKyEkdKPDGHJbt2IZ8EbIrvHC1q74X08G2K/q/FzQ
         zyISPPqx7AyBIzrY3OWwCzApbnefyWKabug7N8BTOuGNNgEiLMMgwN6VXph3j2NsPpQ/
         1XeGIABeK3mNBm9MMqJGRoSSsD2wDBuYG//vQ/OJONipU3AfawgP68yOy40tk8RC/l1D
         G/NlyDakJZiunRY74OKGNA+/Dte9HzhN6H6KnKUvlHRdNRBeiYpOs8+QCXTIer/kp7nM
         Cb3w==
X-Gm-Message-State: AOJu0YyEva5vWRYzQtLsjex7pMLc8Rh/1v1HEPMiQHaenaFUQUBUeK1z
	Mdenv75nTGp5tZwHjDQAS04ai6CYjF6/gJi0FNs+vMUDwu7qtJz1H+MNywueXW9aWI6KoB5vkYf
	SjhmRNg==
X-Received: from wrwr2.prod.google.com ([2002:a5d:6942:0:b0:47f:86af:60e6])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:2583:b0:47f:96b5:ffae
 with SMTP id ffacd0b85a97d-47f96b60602mr4647212f8f.37.1784909418535; Fri, 24
 Jul 2026 09:10:18 -0700 (PDT)
Date: Fri, 24 Jul 2026 18:10:00 +0200
In-Reply-To: <20260724161004.2360749-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260724161004.2360749-1-gnoack@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260724161004.2360749-2-gnoack@google.com>
Subject: [PATCH v4 1/5] selftests/landlock: Use an actual chardev for
 MAKE_CHAR audit test
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, Christian Brauner <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, Serge Hallyn <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

By passing a (0, 0) device number, the audit test for
LANDLOCK_ACCESS_FS_MAKE_CHAR was accidentally creating a whiteout object
rather than a char device.  In preparation to treating whiteout objects
differently, use an actual character device instead.

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 tools/testing/selftests/landlock/fs_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index 86e08aa6e0a7..e82b56a74c5f 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -7436,7 +7436,7 @@ TEST_F(audit_layout1, make_char)
=20
 	enforce_fs(_metadata, ACCESS_ALL, NULL);
=20
-	EXPECT_EQ(-1, mknod(file1_s1d3, S_IFCHR | 0644, 0));
+	EXPECT_EQ(-1, mknod(file1_s1d3, S_IFCHR | 0644, makedev(7, 0)));
 	EXPECT_EQ(EACCES, errno);
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.make_char",
 				    dir_s1d3));
--=20
2.55.0.229.g6434b31f56-goog

