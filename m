Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21647C0015E
	for <linux-security-module@archiver.kernel.org>; Fri, 23 Jun 2023 14:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbjFWOou (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 23 Jun 2023 10:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjFWOoJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 23 Jun 2023 10:44:09 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F03294D
        for <linux-security-module@vger.kernel.org>; Fri, 23 Jun 2023 07:43:49 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-beb64c0d603so1162722276.1
        for <linux-security-module@vger.kernel.org>; Fri, 23 Jun 2023 07:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687531428; x=1690123428;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SP+6dk3xB1XlJuOJxY1FrVHQ3rRmrxh3vILamkrvgf8=;
        b=j+3NUH4LJriS6po9aPjHeXdGyCfXXDMbiZ5Rp712V9Z9ssFjBzyB3/Rov0F376qy7Y
         kTHw7zZRryFXk8RAfi3LfPPIDOqcHJRBNHVAh9+e9sodnpwIjIppFrpzvm+cuPZ+5IWs
         EBsFJiY74SZoiYStECb/TXOYUmr+nE9cCuZ/hTvtLTCt9PocKKEmGPJGZDukW4pAyaD7
         YJ7F5ZRwlF8UH11Yz4UKZwzRp2wAM02Q2/UhiypDyAeSxAKKAXk1TICz0WKeybFZHPaG
         sCywh97r/35ngGLov82Fl0ILqfTYh0ruZbxGCrRW8WOusqhiVN/XtOnqtq907JHNhIeQ
         ZQqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687531428; x=1690123428;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SP+6dk3xB1XlJuOJxY1FrVHQ3rRmrxh3vILamkrvgf8=;
        b=dSWDJgzcxwhcGNOt3AoF7cU2MjSEZeCX0UYIAYzr+mDgZdZyQUkOF+tbJcSsuGKBKi
         fhDz2/NjtzEzwsbF83hpxPZAJum2d55cBd8Ky8sQGI5JIPPCiD687AH883iLe4HLc2Ce
         xNTL32f/O89KVOmSsETqA/NGk0LtG0kZQmqjjL42aF9gDlSxP/YeKV5iP3llluGXnkwy
         lL806w20hCNqsWQ0eYi6ks6pKzp62feN6XmeXk64clySX1NNoG1K/l4da61OxTQh3B06
         3WLAHN9ijla4bHo4ZMwjjUWWhFN8qUPq9TzOjrpNPkGTLuGEUjk8HWXS6icZLk+LuSpV
         V32g==
X-Gm-Message-State: AC+VfDwUb4Z6Ys8T5SkwLuVc4tcAb/Mz4wI7jfRr6JZP7URj3jjMyObA
        jD5WkBkqi4qlkRBOHn9BhQvtEIeumfjHTat+ocA8PcwcguAkDPBbZq+3b9XgGxNocrGdpQV83Xs
        yYEI3ErXH2OtGCmSK+JXzFp2KOe1oZdvvOoRtdWLOxpmKKKZEEXU00Bz99vkR0BCcp0O29X1hxL
        6RFxQ/tA==
X-Google-Smtp-Source: ACHHUZ7aQ74QGDcNmrQ1N+LygwBLvUtpw67QHb8jFWORcyo2oGPmcfBIwwYBF2t6+Y/TOO3wDaSyX7XPfuI=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:8b55:dee0:6991:c318])
 (user=gnoack job=sendgmr) by 2002:a05:6902:86:b0:bc7:4714:182e with SMTP id
 h6-20020a056902008600b00bc74714182emr3685630ybs.3.1687531428196; Fri, 23 Jun
 2023 07:43:48 -0700 (PDT)
Date:   Fri, 23 Jun 2023 16:43:27 +0200
In-Reply-To: <20230623144329.136541-1-gnoack@google.com>
Message-Id: <20230623144329.136541-5-gnoack@google.com>
Mime-Version: 1.0
References: <20230623144329.136541-1-gnoack@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 4/6] selftests/landlock: Test ioctl with memfds
From:   "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To:     linux-security-module@vger.kernel.org,
        "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc:     Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Allen Webb <allenwebb@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        linux-fsdevel@vger.kernel.org,
        "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Because the ioctl right is associated with the opened file,
we expect that it will work with files which are opened by means
other than open(2).

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 tools/testing/selftests/landlock/fs_test.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index 0f0899768fe7..ebd93e895775 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -3716,18 +3716,20 @@ TEST_F_FORK(ftruncate, open_and_ftruncate_in_differ=
ent_processes)
 	ASSERT_EQ(0, close(socket_fds[1]));
 }
=20
-TEST(memfd_ftruncate)
+TEST(memfd_ftruncate_and_ioctl)
 {
-	int fd;
+	int fd, n;
=20
 	fd =3D memfd_create("name", MFD_CLOEXEC);
 	ASSERT_LE(0, fd);
=20
 	/*
-	 * Checks that ftruncate is permitted on file descriptors that are
-	 * created in ways other than open(2).
+	 * Checks that operations associated with the opened file
+	 * (ftruncate, ioctl) are permitted on file descriptors that
+	 * are created in ways other than open(2).
 	 */
 	EXPECT_EQ(0, test_ftruncate(fd));
+	EXPECT_EQ(0, ioctl(fd, FIONREAD, &n));
=20
 	ASSERT_EQ(0, close(fd));
 }
--=20
2.41.0.162.gfafddb0af9-goog

