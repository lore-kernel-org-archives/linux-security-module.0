Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E019C77B7E
	for <linux-security-module@archiver.kernel.org>; Tue,  2 May 2023 17:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234331AbjEBRSO (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 2 May 2023 13:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234356AbjEBRSN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 2 May 2023 13:18:13 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA0C138
        for <linux-security-module@vger.kernel.org>; Tue,  2 May 2023 10:18:06 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f315712406so179060165e9.0
        for <linux-security-module@vger.kernel.org>; Tue, 02 May 2023 10:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683047884; x=1685639884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRrHRY2a9JHTqLK37KTn7bvs8ECBmgcW0KqY+J3cONs=;
        b=Z1Pw09wyXin3S309+RagdJNHbAYM/IXhUERpdv73hVdRiXRxH0dlme69m0M8RumlI1
         iKCniVzkeHhVD4MEKiKvRZOimc/UU65qJsqxm6rDbTtV2zRybjoJ9Lj5eiyxJfXYS1uY
         W96c/Bauq6Jq6GE6bWXL5QyLJXBTS8orj1jNf7EmuKiLSDRCzW6vsVEsR2BhPk9b2Qyd
         evdF12UbSo08SyZl95JxB39zWEqMYKzGlokFfovRUbKJ+be/umgu4pZ46jKIJnZ+dEOL
         fxzq+dCZXGiEAK5Dft300VHffpGHfJ4rOr7MGmzFBH9wTBlgprY2O/ZiVw0RwAC0+qB/
         H1zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683047884; x=1685639884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FRrHRY2a9JHTqLK37KTn7bvs8ECBmgcW0KqY+J3cONs=;
        b=Swgr1UmN17jmPhEZuKutpnBh/BFxmA3uc+hqTsRA596ScDTmPN6XzJHDGlJN+DDxmh
         5L4WCI5V6yjYJONauLTBhHSAtM6ErASYQgiphkybeaHsqCKysoVZppg2CFIsLEHaflnb
         lNJuulTj5Rqr2Q5PhXtCSlwgH77dG0Bz0OmvtEkbpaYBqMSFeZClouLaHhJyH1U4hZs3
         OWjepaGPXXpnlSOfrEHLuvdHICiTwZ4ByT4l4ifdqd5oVn8llwQpI7biBYYujKpFG44z
         4/zH45HU838B/lmXIVEA2PS/dZBanUdef1smySsklUkxFf+IywY7U3QnniVpvI4muzTG
         Hmbg==
X-Gm-Message-State: AC+VfDz7Zgk9z4mMykxeBnkpX8S3WPKwJZZ1iBT1kq7GmAsqtPVEKk4r
        2o3bvec49Rs5lA/vLKuoNkhbGJdaEHs=
X-Google-Smtp-Source: ACHHUZ4Eti+Tcdw5Jy3ywwcN28hj5Cpf7vXT6Yhz5Bh+K0XdC+kay8Gppc2+jfpet2gUi3vwi1dDAw==
X-Received: by 2002:adf:f40a:0:b0:2f5:9146:7024 with SMTP id g10-20020adff40a000000b002f591467024mr14726491wro.22.1683047884352;
        Tue, 02 May 2023 10:18:04 -0700 (PDT)
Received: from localhost ([2a02:168:633b:1:9d6a:15a4:c7d1:a0f0])
        by smtp.gmail.com with ESMTPSA id z2-20020a056000110200b003062b2c5255sm7058507wrw.40.2023.05.02.10.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 10:18:04 -0700 (PDT)
From:   =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To:     linux-security-module@vger.kernel.org,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc:     =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Subject: [RFC 3/4] selftests/landlock: Test ioctl support
Date:   Tue,  2 May 2023 19:17:54 +0200
Message-Id: <20230502171755.9788-4-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230502171755.9788-1-gnoack3000@gmail.com>
References: <20230502171755.9788-1-gnoack3000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Exercise the use of Landlock's ioctl restriction: If ioctl is
restricted, the use of ioctl fails with a freshly opened /dev/tty
file.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/fs_test.c | 62 ++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index fdd7d439ce4..1f827604374 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -3655,6 +3655,68 @@ TEST(memfd_ftruncate)
 	ASSERT_EQ(0, close(fd));
 }
 
+/*
+ * Invokes ioctl(2) and returns its errno or 0.
+ * The provided fd needs to be a tty for this to work.
+ */
+static int test_tty_ioctl(int fd)
+{
+	struct winsize ws;
+
+	if (ioctl(fd, TIOCGWINSZ, &ws) < 0)
+		return errno;
+	return 0;
+}
+
+/*
+ * Attempt ioctl on /dev/tty0 and /dev/tty1,
+ * with file descriptors opened before and after landlocking.
+ */
+TEST_F_FORK(layout1, ioctl)
+{
+	const struct rule rules[] = {
+		{
+			.path = "/dev/tty1",
+			.access = LANDLOCK_ACCESS_FS_IOCTL,
+		},
+		/* Implicitly: No ioctl access on /dev/tty0. */
+		{},
+	};
+	const __u64 handled = LANDLOCK_ACCESS_FS_IOCTL;
+	int ruleset_fd;
+	int old_tty0_fd, tty0_fd, tty1_fd;
+
+	old_tty0_fd = open("/dev/tty0", O_RDWR);
+	ASSERT_LE(0, old_tty0_fd);
+
+	/* Checks that ioctl works before landlocking. */
+	EXPECT_EQ(0, test_tty_ioctl(old_tty0_fd));
+
+	/* Enable Landlock. */
+	ruleset_fd = create_ruleset(_metadata, handled, rules);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* Checks that ioctl with existing FD works after landlocking. */
+	EXPECT_EQ(0, test_tty_ioctl(old_tty0_fd));
+
+	/* Checks that same ioctl fails when file is opened after landlocking. */
+	tty0_fd = open("/dev/tty0", O_RDWR);
+	ASSERT_LE(0, tty0_fd);
+	EXPECT_EQ(EACCES, test_tty_ioctl(tty0_fd));
+
+	/* Checks that same ioctl fails when file is opened after landlocking. */
+	tty1_fd = open("/dev/tty1", O_RDWR);
+	ASSERT_LE(0, tty1_fd);
+	EXPECT_EQ(0, test_tty_ioctl(tty1_fd));
+
+	/* Close all TTY file descriptors. */
+	ASSERT_EQ(0, close(old_tty0_fd));
+	ASSERT_EQ(0, close(tty0_fd));
+	ASSERT_EQ(0, close(tty1_fd));
+}
+
 /* clang-format off */
 FIXTURE(layout1_bind) {};
 /* clang-format on */
-- 
2.40.1

