Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33B117556D
	for <linux-security-module@vger.kernel.org>; Fri,  5 Apr 2024 21:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712353282; cv=none; b=VxV7k7CVxSnefiYisqj9HSUgRmEHDts3IFTgOT3060nTLlXBqVspfWjIUpJblz00jkQej72CEUa8/Dcnp3UiXagNEIBBFsWuX30/Zu1SDztETOgmkRPz0I8gX90vvIA81Oyfv0RJbftpOKjV8x99byBHcY53eXz8WvGrnJ9COBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712353282; c=relaxed/simple;
	bh=cn1OktrYxfexIxvnLjxZnl8EEiqk8pa4E/agZ8LAcHo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WBfD2YKxk6aUNyz635WwJKBg9e1fH9rVTMN9OSGURWCh9NwvNw1Gw8ZOcl0xQQKJgbjl7ouq1SdnCV26AzMCG9gsWaEV1fX+5RfH1JIK4VbM47sIHhnIKuQbQjui9iesYW4qFuIeiySn1bz5uMbW+4O+0WNiY5+GjUXIZEERG2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ePkCYsHq; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ePkCYsHq"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a2386e932so48563157b3.1
        for <linux-security-module@vger.kernel.org>; Fri, 05 Apr 2024 14:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712353280; x=1712958080; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g0G0jOKR0aVvhcJWNUSzc1F+nw52n1gf12u/GuQVyXU=;
        b=ePkCYsHqHTqZ70B3Dd/HqI4oLySQ/M3tpzOWZxM5/JuF/Z73/JcNVzmOyVa9TCTE/U
         4WC4Zim4x407LSB+Uop9sJZD44lg0C4zxM0UmiCiozN+7ydK+2F+L5bKKD+iWT5pVzR+
         tMct/kRrCfiv6YlK328OvoV2URQ9OGWogsmx1MRl0quYLme6o4O0myiLkYiolGUVeaM4
         itKjw5h+7CFjA+eBKt9jbIl6ltguXlOxuhXM23WPNFTZ/V+bMQUrWAYT9IVu9vezZyLE
         pLE0duF43uCSMPBmpoeXpkg8FbNdlJ+G3cqdGReCqo9p4FdnspZ6V4JFgY5e1aWuKTBk
         OzGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712353280; x=1712958080;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g0G0jOKR0aVvhcJWNUSzc1F+nw52n1gf12u/GuQVyXU=;
        b=Ly6UmpofVp/pUp8wQ94+3YshV81/LZ7qsJC7U2/Hc7eFqremMaTLuJPe9Up4t9hj4o
         qhuwhBx3SvvHWZqi5Ahl5cku4MZKwMfGrNde28mr0Vuk/cr+e1GieM6w4eaGP27gNISR
         BAfyzTdHxOQQ2n59GjI7gitnDMfie6fiKH/t7agEMRIRvkAq5+wUxvOq5u+sG9aa966F
         nERY+8YmO67yEm7sVtoqoE+9wv3OnlKja25QXKCuC/+79ZdQ5d0ZCVeHXMhCvREW0i5O
         RxE+2ZRBEquYJxq3JlRgcI5rfNIndx+zkt+DhIlA7XiG3Vp6Cwh/ZkzJ71S0rzKlnEQG
         m5bQ==
X-Gm-Message-State: AOJu0YwMCzbkcFeG87j8f0QnIMdftgj5uxZz84is0MamZq8cFha/3UHK
	jnYpoqV13+RivAG7qU7I8VuHHWDhqjcrZzP3irW9604XK3sKkOHZRRBlXWgc/ByqDg9R+2aVn6v
	1At5d3IJpQzOLOkbl3hA7BhcaR1qkMz/4+689g6riaB3V0QVSmVjaePSMn/acukeRNgnUp1vd2x
	TmgjdKBqs073H51G5UXVlTX+3HDdljgbcFaJqK9GJzgy1z2n1Pa0TE
X-Google-Smtp-Source: AGHT+IFk7eYL+6vrQYJifJQ2QGJFdPZ/x9sRIPx8+ra6M5qJeWO0gO4hfdcb+sSyaa8EDcRQy1jdz59QZMQ=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:690c:6e09:b0:615:33de:61d5 with SMTP id
 jb9-20020a05690c6e0900b0061533de61d5mr643105ywb.1.1712353279626; Fri, 05 Apr
 2024 14:41:19 -0700 (PDT)
Date: Fri,  5 Apr 2024 21:40:33 +0000
In-Reply-To: <20240405214040.101396-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240405214040.101396-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240405214040.101396-6-gnoack@google.com>
Subject: [PATCH v14 05/12] selftests/landlock: Test ioctl(2) and ftruncate(2)
 with open(O_PATH)
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

ioctl(2) and ftruncate(2) operations on files opened with O_PATH
should always return EBADF, independent of the
LANDLOCK_ACCESS_FS_TRUNCATE and LANDLOCK_ACCESS_FS_IOCTL_DEV access
rights in that file hierarchy.

Suggested-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 tools/testing/selftests/landlock/fs_test.c | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index 70a05651619d..84e5477d2e36 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -3895,6 +3895,46 @@ static int test_fionread_ioctl(int fd)
 	return 0;
 }
=20
+TEST_F_FORK(layout1, o_path_ftruncate_and_ioctl)
+{
+	const struct landlock_ruleset_attr attr =3D {
+		.handled_access_fs =3D ACCESS_ALL,
+	};
+	int ruleset_fd, fd;
+
+	/*
+	 * Checks that for files opened with O_PATH, both ioctl(2) and
+	 * ftruncate(2) yield EBADF, as it is documented in open(2) for the
+	 * O_PATH flag.
+	 */
+	fd =3D open(dir_s1d1, O_PATH | O_CLOEXEC);
+	ASSERT_LE(0, fd);
+
+	EXPECT_EQ(EBADF, test_ftruncate(fd));
+	EXPECT_EQ(EBADF, test_fs_ioc_getflags_ioctl(fd));
+
+	ASSERT_EQ(0, close(fd));
+
+	/* Enables Landlock. */
+	ruleset_fd =3D landlock_create_ruleset(&attr, sizeof(attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/*
+	 * Checks that after enabling Landlock,
+	 * - the file can still be opened with O_PATH
+	 * - both ioctl and truncate still yield EBADF (not EACCES).
+	 */
+	fd =3D open(dir_s1d1, O_PATH | O_CLOEXEC);
+	ASSERT_LE(0, fd);
+
+	EXPECT_EQ(EBADF, test_ftruncate(fd));
+	EXPECT_EQ(EBADF, test_fs_ioc_getflags_ioctl(fd));
+
+	ASSERT_EQ(0, close(fd));
+}
+
 /* clang-format off */
 FIXTURE(ioctl) {};
=20
--=20
2.44.0.478.gd926399ef9-goog

