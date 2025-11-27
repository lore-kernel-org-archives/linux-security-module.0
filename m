Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B3F331A4B
	for <linux-security-module@vger.kernel.org>; Thu, 27 Nov 2025 11:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764244330; cv=none; b=jruHctyEUB2IdOkjcn9I+mt3Xm1OCgozwfjYWwtsKeGm1O2HETzvVQBSrxxklrjBBGIhaqXU9zps0ZckUJq4EZMJ50xZ3RTbvf2MCXqmkaF6llFm8cQneThlSNrWGxQediEWipkpeiWrvVN6nVVsHLiw8yYQwnzQ4LmMslPQXhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764244330; c=relaxed/simple;
	bh=ksQdQrRqO6jx2DleoBmK/7htjxtr0d+LVRBc0EG7ai4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aTyx1s/Gcc7vhm6SmaB5+AU9yfGk/gHxiAZ/uzIqm3mz504RGdwhECff8qbW5auEiFUJDEdp0IbX7z6BdxKSMgxpWEypiEnuaM+7hNphsqWiwjWkqfpiAr222thW9XFnCi8MEVlmm3rIUad9jiC42Mkg1RAuCjcsuAfnGUsZHek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MXRfqLL9; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MXRfqLL9"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-477cabba65dso4394325e9.2
        for <linux-security-module@vger.kernel.org>; Thu, 27 Nov 2025 03:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764244327; x=1764849127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SFtzkZnWquZOtMVtRuTtv9EVVfu8tOfFZmAHL8DQG1s=;
        b=MXRfqLL9kuHzFFRQic9JI5cvZZovDt8XgLnKCQsvApD2OjPrCO0zqRT7qF7U8W+9Xu
         +SGSREVDWRqukc3SclNZS3UkHhtGkFLwgY7r/Xj/a0U0bqah8NKNXiCSrCKhyghmJbtt
         RHy6OUw/hTwtwOcX9I92+aeIPB1TTjZJfJ31AkwB15E08+Vb02DRZW6lISGCHitYCbW6
         t14GlUFKi/c/dCZg+n9oG4gRuljOvmuV6iqjssdxsvTSwrAGtc45/n1N14Qf//0RG+g0
         cObKKRnwj5tAcJTaQWfAXtj+11BKm21oaPZAN3dqwykCeogU+gehXvDnfepFyraKrTsE
         6oYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764244327; x=1764849127;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SFtzkZnWquZOtMVtRuTtv9EVVfu8tOfFZmAHL8DQG1s=;
        b=LKbNU7NY+mrPecFPB4e5m9KwX8AlfMd/7Q3h0UuS7mfjwRGIIk0utnAScQmrQHE1fl
         EDMvCghrzYArtFrKBhIJtDosUq1++iemsO68l6e/IsRQNV5ijKBnS4+qwJ5xscXQ1DQp
         +e6e4nx4GohYvnwousA92DAcYO2JefLmHXv5HYD1qpaYmaV8Yv8ut2nBBT8wx81OIzrv
         o5Pkuf9plRC/sBhCfxpVpX+rKEeHt2x62MxiyApcom3xhCFh5v4aOEVQV+8Ei2090kHY
         QjA28iZBbxdVBZLMLbge8qGlDIyq4Lcc1tA5nsRgQvF4CxizZMWDSSsSNlQBljYfWwTH
         ogeg==
X-Gm-Message-State: AOJu0YzDAutSoScUB5PLOzP3ylgKXa64q281ylaMEU4Im8TOmOyC/72m
	ZJJnO1Vw6P0JKTdp2afNxpMHe8xdM6j9Mfpp2Ivm5Q6J5tEXlJcWl3AkbN4l32KEmEi5+//fi/T
	ZWdHTftvUFfQfhxSI4W+SPPxwhghupfNtFWCfCqyRCIJTc+1ql4gd6cU3Lqg65/R5VqiSPjroOS
	ZWinEHhLIfDwqyC8amnHF38DC0VrZrOUK6whsQCpOzR6ScaJ67exR40FC1
X-Google-Smtp-Source: AGHT+IEpPNKTfCdUlvBBiu5LeFk7pNUyk0aPK8C7m413QdNmDkvuUQtoxOouPNMs+IJ74yYZV/W5MCPxReQ=
X-Received: from wmbjl23.prod.google.com ([2002:a05:600c:6a97:b0:477:bdc:7343])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:8b16:b0:477:94e3:8a96
 with SMTP id 5b1f17b1804b1-477c01b512cmr187548935e9.20.1764244327244; Thu, 27
 Nov 2025 03:52:07 -0800 (PST)
Date: Thu, 27 Nov 2025 12:51:35 +0100
In-Reply-To: <20251127115136.3064948-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251127115136.3064948-1-gnoack@google.com>
X-Mailer: git-send-email 2.52.0.177.g9f829587af-goog
Message-ID: <20251127115136.3064948-3-gnoack@google.com>
Subject: [PATCH v3 2/3] landlock: selftests for LANDLOCK_RESTRICT_SELF_TSYNC
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: linux-security-module@vger.kernel.org, 
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc: Jann Horn <jannh@google.com>, Serge Hallyn <sergeh@kernel.org>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Tingmao Wang <m@maowtm.org>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, "Andrew G. Morgan" <morgan@kernel.org>, 
	John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Exercise various scenarios where Landlock domains are enforced across
all of a processes' threads.

Cc: Andrew G. Morgan <morgan@kernel.org>
Cc: John Johansen <john.johansen@canonical.com>
Cc: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
Cc: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 tools/testing/selftests/landlock/base_test.c  |   6 +-
 tools/testing/selftests/landlock/tsync_test.c | 161 ++++++++++++++++++
 2 files changed, 164 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/landlock/tsync_test.c

diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/s=
elftests/landlock/base_test.c
index f4b1a275d8d9..0fea236ef4bd 100644
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
index 000000000000..3971e0f02c49
--- /dev/null
+++ b/tools/testing/selftests/landlock/tsync_test.c
@@ -0,0 +1,161 @@
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
+	ASSERT_LE(0, ruleset_fd)
+	{
+		TH_LOG("landlock_create_ruleset: %s", strerror(errno));
+	}
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
+void store_no_new_privs(void *data)
+{
+	bool *nnp =3D data;
+
+	if (!nnp)
+		return;
+	*nnp =3D prctl(PR_GET_NO_NEW_PRIVS, 0, 0, 0, 0);
+}
+
+void *idle(void *data)
+{
+	pthread_cleanup_push(store_no_new_privs, data);
+
+	while (true)
+		sleep(1);
+
+	pthread_cleanup_pop(1);
+}
+
+TEST(multi_threaded_success)
+{
+	pthread_t t1, t2;
+	bool no_new_privs1, no_new_privs2;
+	const int ruleset_fd =3D create_ruleset(_metadata);
+
+	disable_caps(_metadata);
+
+	ASSERT_EQ(0, pthread_create(&t1, NULL, idle, &no_new_privs1));
+	ASSERT_EQ(0, pthread_create(&t2, NULL, idle, &no_new_privs2));
+
+	ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
+
+	EXPECT_EQ(0, landlock_restrict_self(ruleset_fd,
+					    LANDLOCK_RESTRICT_SELF_TSYNC));
+
+	ASSERT_EQ(0, pthread_cancel(t1));
+	ASSERT_EQ(0, pthread_cancel(t2));
+	ASSERT_EQ(0, pthread_join(t1, NULL));
+	ASSERT_EQ(0, pthread_join(t2, NULL));
+
+	/* The no_new_privs flag was implicitly enabled on all threads. */
+	EXPECT_TRUE(no_new_privs1);
+	EXPECT_TRUE(no_new_privs2);
+
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
+struct thread_restrict_data {
+	pthread_t t;
+	int ruleset_fd;
+	int result;
+};
+
+void *thread_restrict(void *data)
+{
+	struct thread_restrict_data *d =3D data;
+
+	d->result =3D landlock_restrict_self(d->ruleset_fd,
+					   LANDLOCK_RESTRICT_SELF_TSYNC);
+	return NULL;
+}
+
+TEST(competing_enablement)
+{
+	const int ruleset_fd =3D create_ruleset(_metadata);
+	struct thread_restrict_data d[] =3D {
+		{ .ruleset_fd =3D ruleset_fd },
+		{ .ruleset_fd =3D ruleset_fd },
+	};
+
+	disable_caps(_metadata);
+
+	ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
+	ASSERT_EQ(0, pthread_create(&d[0].t, NULL, thread_restrict, &d[0]));
+	ASSERT_EQ(0, pthread_create(&d[1].t, NULL, thread_restrict, &d[1]));
+
+	/* Wait for threads to finish. */
+	ASSERT_EQ(0, pthread_join(d[0].t, NULL));
+	ASSERT_EQ(0, pthread_join(d[1].t, NULL));
+
+	/* Expect that both succeeded. */
+	EXPECT_EQ(0, d[0].result);
+	EXPECT_EQ(0, d[1].result);
+
+	ASSERT_EQ(0, close(ruleset_fd));
+}
+
+TEST_HARNESS_MAIN
--=20
2.52.0.177.g9f829587af-goog

