Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C5EC433EF
	for <linux-security-module@archiver.kernel.org>; Tue, 28 Jun 2022 22:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiF1W3s (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 28 Jun 2022 18:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiF1W3q (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 28 Jun 2022 18:29:46 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A732CC86
        for <linux-security-module@vger.kernel.org>; Tue, 28 Jun 2022 15:29:45 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 15-20020a63020f000000b003fca9ebc5cbso7283960pgc.22
        for <linux-security-module@vger.kernel.org>; Tue, 28 Jun 2022 15:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=xN1tr+EF1U2lJ5hEJvDA2irPOc2C4bJjaXH4buE8Ybc=;
        b=c8kPmxVkddBB2y1bWEwiJQtC1wpNCWo5LteiR+O0AIIzEsPUdZ9cGWqK61JUH+PIJA
         I5O5kDD5RO8vyKoeZ34Xyu8u2NOqfcucCcYf0PaZ/m6p+JBRcOvRe/wablznGpg2SZ1z
         JZxbBFCGgb3XFZ7f/YpHzy8Z6qI4YzH2sMmIRwgQgCBipYXUk53bzFhiCuivD0gYJlKh
         rc2QwbHtiM/1qP++ES6IY2PhdsCvppbhl/FOgFudjFZL7CHuIs7pfEZyTD1qCjyzq2Ev
         CuyQa099vVGS1/+6kfzuMKfIpW5ugBKoZzUarQtnNfEfSRIdaUs636nZpdFFDWesrMYz
         zZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=xN1tr+EF1U2lJ5hEJvDA2irPOc2C4bJjaXH4buE8Ybc=;
        b=4kOtxOWOXf1n0oPr1Wpnrei5hUTXixpvYT/Q8l/CtmmDj+3CEOlv2kAXZJhzns70YD
         bxD+bobfiWNLiIyjxGuffn5b0yM7/cSFfgfeJ52Akt9MICQNfC021WIkpUnC5Ts2OOFf
         X51wzRjQqPJN6+W0+E+aBcnsIt/Y3fOveZuTiFsIaz7Chx9UXgF2x2b2rZsDsuPV4fc+
         TIlWEV/vbvblko5MFEZjgmTc4/vmdpyptMS1ahGb/X8eih0C6XlrvazFRYuf4AILcQ2e
         phP66BYxAVM7JVwOoDp1ccCcL4qtY8rlY8yHZeRoDrShZI6y73ceocRCYBGCS5WcJfcm
         NXeA==
X-Gm-Message-State: AJIora/1qN+KfOQL9O+JnAcCRS0vqtd+kr6EIknUMhqgXP9ppu4hW5fI
        FW9Tt3zJDCsXhuEosI+5UaBdUqw9kus=
X-Google-Smtp-Source: AGRyM1sb4gu4wh5t9NQKPjdrCAAjh5Tye0AhwWk6lGIKhKerpY6JHghFizoXUql4EeVUdekawlr2sfZTuNo=
X-Received: from jeffxuc.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:31a7])
 (user=jeffxu job=sendgmr) by 2002:aa7:82ca:0:b0:51b:cf43:d00a with SMTP id
 f10-20020aa782ca000000b0051bcf43d00amr6978032pfn.58.1656455385235; Tue, 28
 Jun 2022 15:29:45 -0700 (PDT)
Date:   Tue, 28 Jun 2022 22:29:41 +0000
Message-Id: <20220628222941.2642917-1-jeffxu@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH] selftests/landlock: skip ptrace_test when YAMA is enabled
From:   Jeff Xu <jeffxu@google.com>
To:     "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc:     linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

ptrace_test assumes YAMA is disabled, skip it if YAMA is enabled.

Cc: Jorge Lucangeli Obes <jorgelo@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
Tested-by: Jeff Xu <jeffxu@google.com>
Signed-off-by: Jeff Xu <jeffxu@google.com>
Change-Id: I623742ca9f20ec706a38c92f6c0bab755f73578f
---
 .../testing/selftests/landlock/ptrace_test.c  | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/testing=
/selftests/landlock/ptrace_test.c
index c28ef98ff3ac..ef2d36f56764 100644
--- a/tools/testing/selftests/landlock/ptrace_test.c
+++ b/tools/testing/selftests/landlock/ptrace_test.c
@@ -226,6 +226,44 @@ FIXTURE_TEARDOWN(hierarchy)
 {
 }
=20
+int open_sysfs(const char *path, int flags, int *fd)
+{
+	*fd =3D open(path, flags);
+
+	if (fd < 0)
+		return -1;
+
+	return 0;
+}
+
+int read_sysfs_int_fd(int fd, int *val)
+{
+	char buf[2];
+
+	if (read(fd, buf, sizeof(buf)) < 0)
+		return -1;
+
+	buf[sizeof(buf) - 1] =3D '\0';
+	*val =3D atoi(buf);
+	return 0;
+}
+
+int read_sysfs_int(const char *path, int *val)
+{
+	int fd;
+
+	if (open_sysfs(path, O_RDONLY, &fd) !=3D 0)
+		return -1;
+
+	if (read_sysfs_int_fd(fd, val) !=3D 0) {
+		close(fd);
+		return -1;
+	}
+
+	close(fd);
+	return 0;
+}
+
 /* Test PTRACE_TRACEME and PTRACE_ATTACH for parent and child. */
 TEST_F(hierarchy, trace)
 {
@@ -235,6 +273,17 @@ TEST_F(hierarchy, trace)
 	char buf_parent;
 	long ret;
=20
+	int ptrace_val;
+
+	ASSERT_EQ(0, read_sysfs_int("/proc/sys/kernel/yama/ptrace_scope",
+				    &ptrace_val));
+	if (ptrace_val !=3D 0) {
+		/*
+		 * Yama's scoped ptrace is presumed disabled.  If enabled, skip.
+		 */
+		SKIP(return, "yama is enabled, skip current test");
+	}
+
 	/*
 	 * Removes all effective and permitted capabilities to not interfere
 	 * with cap_ptrace_access_check() in case of PTRACE_MODE_FSCREDS.
--=20
2.37.0.rc0.161.g10f37bed90-goog

