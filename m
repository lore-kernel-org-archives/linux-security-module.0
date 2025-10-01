Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0A72581
	for <linux-security-module@vger.kernel.org>; Wed,  1 Oct 2025 11:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759317505; cv=none; b=FceF24Mr/epgXGgmuqu6/GTe0U/IShmJHE+1OLxpnMeIcQsA9iN6mOLzGdUGG++t/Pm26D7L1aQ3AKLeiZfv6TGIqLFP9CslIxH3mxQVAfjDO0Jxh0pb9qpOD+7nANfnE7hY8Bs7MkFBTJBDx6ZBLVuCYABdJmgzYs3dnYOJYIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759317505; c=relaxed/simple;
	bh=qDHtHBAjT6olAmqY9c9q3GOFn5snN88dnre8E4YBSmg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cxfWadKBisQa3qbmaLLoKQ5lqa293U/EBHERvXiqUGIGfpeECGevbAYFvaFBlrtzyOG20S/BRVHhHpFfgc0P0JBxLgMgqgS6V+/w7HXdq+L/O8sB+JO8NAuMdSwNSTaqDZ+te+Oh2plkROlIL0uayzinL60tH0ByZC+dHSPcOvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HuPVtcEs; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HuPVtcEs"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-46e45899798so19891135e9.3
        for <linux-security-module@vger.kernel.org>; Wed, 01 Oct 2025 04:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759317502; x=1759922302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6jjcpPPZxhp4X1YAEpre0Ds+RHO+MBfCZ9jsXgo1xuY=;
        b=HuPVtcEsDcF3c7mWp43EV/vj6GELjcOZCTxUsuN3oIUcq7Z46VAfYERGezGFfrh8pY
         oL7boVs230fm83GGSQroLkYtW4undVD4yw6TKfwgqbelwqcXcbFfTOSc7nPDprVb7CD9
         6xHGSgZt1/8fB1h/iqFL1AhtgEMdwhCNLGgcMXztgjhdKnxzqkxU3LXjR2Caqf2QQ7LY
         gy9mKVgDdOE4XY0FM983ktJHF1gI9//FoY/Hbx7BI806Jjbrv42efPwkCgkW5QW1ghGS
         sPlkb+Fdvuh9OVRyW46LJFhhUg0kmexsRe8IOoo/1aS4XemthpGXL9eYzWxoYRvuVbi/
         REyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759317502; x=1759922302;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6jjcpPPZxhp4X1YAEpre0Ds+RHO+MBfCZ9jsXgo1xuY=;
        b=Humx9V8ULlVaeXgpyPuc3enB+S07sww9dP7xVYZ/zWuC8KcQb0jDlTUeCJV2YnUEhU
         qb9NUhnfLLylORA2FS3kyJXYqr6RufM7qTaK/OKxcGXZ9+C+SeNUxhnT/ukEmVFEu6ns
         GoDFCYaMx8oliEnuPkhNi6y8LBc0o15YpK6vK2ixUqKNGKJDa8ASYHRdn6neXmy3VtnO
         u3/n6ohlBNgbh2tBW7qDVCwiF4EuOmEsuoynRcTUz1/IHa2qIuDtKlqBNdu1Zk6cSq8p
         YnnOyJfpV6i4IIfU8jjsDYzCAFUAfVOZcUC0UTTs+0E+1uSCDRBGqgpOET0hXH3p9Fef
         t+Wg==
X-Forwarded-Encrypted: i=1; AJvYcCX3s7XulHJPvzC7nRnS2rMibLNTQkytf+m/IGnmBy1X/gkqS/Wb+FWGHOpyp67QJucmHW4/LG7ZP4j5WfmfEnCN64l39fQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBwqqIllBHHOR1jnioOBFDZdBds2H5n29JIq4yoOqJ+b4wIojk
	hrHSCXw+2sUbAklxYDxo8MT7J5OC6AwhSbBy6wz2uxf9jRCtlhmBRMOFi33iyCgw1ry9oaiq9Sd
	IUg8/jw==
X-Google-Smtp-Source: AGHT+IEy5C8fAHrF74XqzSNx5uReeD9pjYfDjS/Qeqfqu0/E/Zhp/PKOPGqzmvww3krxtAxuEug6B1A7bGo=
X-Received: from wmbgz11.prod.google.com ([2002:a05:600c:888b:b0:46e:54f3:6f51])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:8119:b0:46e:4883:27d
 with SMTP id 5b1f17b1804b1-46e6128617amr26740085e9.30.1759317502159; Wed, 01
 Oct 2025 04:18:22 -0700 (PDT)
Date: Wed,  1 Oct 2025 13:18:07 +0200
In-Reply-To: <20251001111807.18902-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251001111807.18902-1-gnoack@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251001111807.18902-3-gnoack@google.com>
Subject: [PATCH v2 2/2] landlock: selftests for LANDLOCK_RESTRICT_SELF_TSYNC
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Tingmao Wang <m@maowtm.org>, 
	Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Exercise various scenarios where Landlock domains are enforced across
all of a processes' threads.

Cc: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
Cc: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 tools/testing/selftests/landlock/base_test.c  |  6 +-
 tools/testing/selftests/landlock/tsync_test.c | 99 +++++++++++++++++++
 2 files changed, 102 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/landlock/tsync_test.c

diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/s=
elftests/landlock/base_test.c
index 7b69002239d7..b9be6dcb7e8c 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -288,7 +288,7 @@ TEST(restrict_self_fd)
 	EXPECT_EQ(EBADFD, errno);
 }
=20
-TEST(restrict_self_fd_flags)
+TEST(restrict_self_fd_logging_flags)
 {
 	int fd;
=20
@@ -304,9 +304,9 @@ TEST(restrict_self_fd_flags)
 	EXPECT_EQ(EBADFD, errno);
 }
=20
-TEST(restrict_self_flags)
+TEST(restrict_self_logging_flags)
 {
-	const __u32 last_flag =3D LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF;
+	const __u32 last_flag =3D LANDLOCK_RESTRICT_SELF_TSYNC;
=20
 	/* Tests invalid flag combinations. */
=20
diff --git a/tools/testing/selftests/landlock/tsync_test.c b/tools/testing/=
selftests/landlock/tsync_test.c
new file mode 100644
index 000000000000..356e20de352f
--- /dev/null
+++ b/tools/testing/selftests/landlock/tsync_test.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Landlock tests - Enforcing the same restrictions across multiple thread=
s
+ *
+ * Copyright =C2=A9 2025 G=C3=BCnther Noack <gnoack3000@gmail.com>
+ */
+
+#define _GNU_SOURCE
+#include <pthread.h>
+#include <sys/prctl.h>
+#include <linux/landlock.h>
+
+#include "common.h"
+
+/* create_ruleset - Create a simple ruleset FD common to all tests */
+static int create_ruleset(struct __test_metadata *const _metadata)
+{
+	struct landlock_ruleset_attr ruleset_attr =3D {
+		.handled_access_fs =3D (LANDLOCK_ACCESS_FS_WRITE_FILE |
+				      LANDLOCK_ACCESS_FS_TRUNCATE),
+	};
+	const int ruleset_fd =3D
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+
+	ASSERT_LE(0, ruleset_fd);
+	return ruleset_fd;
+}
+
+TEST(single_threaded_success)
+{
+	const int ruleset_fd =3D create_ruleset(_metadata);
+
+	disable_caps(_metadata);
+
+	ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
+	ASSERT_EQ(0, landlock_restrict_self(ruleset_fd,
+					    LANDLOCK_RESTRICT_SELF_TSYNC));
+
+	ASSERT_EQ(0, close(ruleset_fd));
+}
+
+void *idle(void *data)
+{
+	while (true)
+		sleep(1);
+}
+
+TEST(multi_threaded_success)
+{
+	pthread_t t1, t2;
+	const int ruleset_fd =3D create_ruleset(_metadata);
+
+	disable_caps(_metadata);
+
+	ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
+
+	ASSERT_EQ(0, pthread_create(&t1, NULL, idle, NULL));
+	ASSERT_EQ(0, pthread_create(&t2, NULL, idle, NULL));
+
+	EXPECT_EQ(0, landlock_restrict_self(ruleset_fd,
+					    LANDLOCK_RESTRICT_SELF_TSYNC));
+
+	ASSERT_EQ(0, pthread_cancel(t1));
+	ASSERT_EQ(0, pthread_cancel(t2));
+	ASSERT_EQ(0, pthread_join(t1, NULL));
+	ASSERT_EQ(0, pthread_join(t2, NULL));
+	ASSERT_EQ(0, close(ruleset_fd));
+}
+
+TEST(multi_threaded_success_despite_diverging_domains)
+{
+	pthread_t t1, t2;
+	const int ruleset_fd =3D create_ruleset(_metadata);
+
+	disable_caps(_metadata);
+
+	ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
+
+	ASSERT_EQ(0, pthread_create(&t1, NULL, idle, NULL));
+	ASSERT_EQ(0, pthread_create(&t2, NULL, idle, NULL));
+
+	/*
+	 * The main thread enforces a ruleset,
+	 * thereby bringing the threads' Landlock domains out of sync.
+	 */
+	EXPECT_EQ(0, landlock_restrict_self(ruleset_fd, 0));
+
+	/* Still, TSYNC succeeds, bringing the threads in sync again. */
+	EXPECT_EQ(0, landlock_restrict_self(ruleset_fd,
+					    LANDLOCK_RESTRICT_SELF_TSYNC));
+
+	ASSERT_EQ(0, pthread_cancel(t1));
+	ASSERT_EQ(0, pthread_cancel(t2));
+	ASSERT_EQ(0, pthread_join(t1, NULL));
+	ASSERT_EQ(0, pthread_join(t2, NULL));
+	ASSERT_EQ(0, close(ruleset_fd));
+}
+
+TEST_HARNESS_MAIN
--=20
2.51.0.618.g983fd99d29-goog

