Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62E2C4167B
	for <linux-security-module@archiver.kernel.org>; Fri,  3 Nov 2023 15:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344047AbjKCP5u (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 3 Nov 2023 11:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234329AbjKCP5s (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 3 Nov 2023 11:57:48 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53356D52
        for <linux-security-module@vger.kernel.org>; Fri,  3 Nov 2023 08:57:45 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id 4fb4d7f45d1cf-5411a36a37fso2719676a12.0
        for <linux-security-module@vger.kernel.org>; Fri, 03 Nov 2023 08:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699027064; x=1699631864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxvKLDLDIIL6ajW+0JhrE5ylNn+Ttpm+mn9PCmHiykk=;
        b=fAxkO+gZSeRX/WXvqNNZ3MLD8qy+cxPtBNEB81iFM97oNC9nk5G8zMIAtS3tRsJqec
         wfaJvFLVrDLsEl6D3yhkjGO7H0IfVgrWOgQrf+EKGzc9Rrc3GqNmpgmDhWLk+dN06HV4
         BC2GZgrYNk7VmlRt+VX05BFA1cH1G4Yt3guZlSKJUnDuZ1jdvIsG9S2rblY0nH1sPljC
         hIqSLK6MADHfrcwYJIC07GykRy5cI1AX4KcxywCVfWoIqVUiOoTzvuP7YguIb5cNmr3P
         yQdNssDi5lEvD/w4eVWCsz/iXj5alg5qh3pIb5jn3N89h4LhjtVo/hNnS4HnCRItCksz
         xxFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699027064; x=1699631864;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mxvKLDLDIIL6ajW+0JhrE5ylNn+Ttpm+mn9PCmHiykk=;
        b=dP9WutfuRcZV+tXdseVwSjXLHD18saYDSNnEThHNCB/+TPYTlcFMXCNzn00N/izrCP
         9wAg4vTAToUTjldtUuO0145WBQgeCqKIQwr/Rkh0gei/88a61uCRfRCKYWNpipxhQd6l
         W5Z2RGZJgetcyeCZifmA+qQGaiqwK8EjBCISFIYHyWrdA5dvgGwW3PFfrAuUUGH86RGX
         ada6UsRUDk7sZZoYJvxQJz/PVHSrqnbovp3/TsBplj1ACxwS83Q8iyd5mxmfCz2PyA8x
         tzcDZHOHGH0fjNTpUVw6jt3YWo7cUoeRa2NmAYd/6IuxV4WFTV2SGwz8GUrGjWODMPKU
         ZvYA==
X-Gm-Message-State: AOJu0YxRvWtWYgVutAzVbFkW/jN6UFpiBW5xhLq/EP7M5VtkPqPVWzKP
        qa+in0ke65PFWvrwenFRBoBfSikwZZVWZwAjCy7F8HsAlbDlZN8+QMzvd2aJgSb95Gmp9Z9OwPw
        CtSufb76Yg5uvURd3lhyfY3NrAG5qVMqv8mTDL5+KUOWrBwqgQeKNZEXuqDZVbqkEdAM6W7FqzP
        hKOW0vRA==
X-Google-Smtp-Source: AGHT+IFO+w+kful6dHdJwQ+/Cw0YmHCA5rEGgf/6cHbgOUGhXEwdbnuAVb7H1JRbhvDByeR1+AK4NhIbL2c=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:7ddd:bc72:7a4a:ba94])
 (user=gnoack job=sendgmr) by 2002:aa7:d5d1:0:b0:53e:227d:727f with SMTP id
 d17-20020aa7d5d1000000b0053e227d727fmr32488eds.2.1699027063815; Fri, 03 Nov
 2023 08:57:43 -0700 (PDT)
Date:   Fri,  3 Nov 2023 16:57:14 +0100
In-Reply-To: <20231103155717.78042-1-gnoack@google.com>
Message-Id: <20231103155717.78042-5-gnoack@google.com>
Mime-Version: 1.0
References: <20231103155717.78042-1-gnoack@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Subject: [PATCH v4 4/7] selftests/landlock: Test IOCTL with memfds
From:   "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To:     linux-security-module@vger.kernel.org,
        "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc:     Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Allen Webb <allenwebb@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Matt Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org,
        "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Because the LANDLOCK_ACCESS_FS_IOCTL right is associated with the
opened file during open(2), IOCTLs are supposed to work with files
which are opened by means other than open(2).

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 tools/testing/selftests/landlock/fs_test.c | 36 ++++++++++++++++------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index 564e73087e08..8a244c9cd030 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -3778,20 +3778,38 @@ static int test_fs_ioc_getflags_ioctl(int fd)
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
2.42.0.869.gea05f2083d-goog

