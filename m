Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80D824CEF8
	for <linux-security-module@vger.kernel.org>; Fri, 21 Feb 2025 18:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740163507; cv=none; b=Jh4sqDzxV4eheDdSqZ8ZT84fM+hmZ90iMnl/OORj39r+Sn44F4pFzXpfbfMRLS1YcAsPf/GlyjXfkgJW14tcgZaIhOrxWGXodznhBHNOlkQcsvlRHbnvdC64rXbz69vVbprs4uXGBeje3ZfpCc/g1RabthPXpDBK7hrqXCN0MFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740163507; c=relaxed/simple;
	bh=DvJ1ikKORt4ZSTX2gg+XF/hfJSJfMN8d+45ewT5VJ9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fdxRs5edxXAVUZ++vREytbwrPr+RsMMnwMyVK8nEgZ+uSMXLnWcnEsrFMbTuJMEs+qU91JEyjnvBF2Nx2pq3z2j2unCRsfdQJT/3HoNJPEs3wtyhwMA2+6TaqQadpBu7un7hlRD6XiWFp9MlpXFdfEwvwyZRJydYLw3jGVYU5ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UXqLwoud; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXqLwoud"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38f24fc466aso1737785f8f.2
        for <linux-security-module@vger.kernel.org>; Fri, 21 Feb 2025 10:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740163504; x=1740768304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rgeaITZ6K5JhxpLHAqhrv7z5woVj94WJRowCGOYu1Lc=;
        b=UXqLwoudPOseE6S87zRFZNFcpxY3BhupfAbBfayXE9XfVLLN3ULNKyf+t7lrs23nsn
         lSV0g1ipHtQ/xvcTxfCq3tMUDCpZlQ/jIadoJBYzyP41raFvqYnZ+yWJiIggJH9Ni3CX
         Kv8jzJwDKH92Yxx95DrL6iF5sxkjisu9gTWbTUn0hOgl800ElFk7hMgKkRQyE/jB8D1B
         BVXzH8hUbWy63Fwhd6OMLbMu3ZcQmAXMewLKgw7+7bgXiECQd/Y4Hpudt1uelCIQbLpg
         mQoTyrocWyTYYNPCDu32K8oJKOodonqiTdrm2C046rS/rF09DFuXNtSLFg1XJp7LAhGc
         dNjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740163504; x=1740768304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rgeaITZ6K5JhxpLHAqhrv7z5woVj94WJRowCGOYu1Lc=;
        b=dg5lk+JIRdHj1sxh1ZtwPsEfaMA/cOeIj3nRoxmySpKdEjLCSocWUfk4KWfLSTaNxT
         EL2D6lR+gJNQUzxR5A3uKI/08D5DGIFOTlB3Q4nOe0L7MUUhyekljpDyB2aLkpFgqkzv
         4e7qO9UZk7oPhSOoniM8TFYSMWyQhe5Y2e2ZW2jlGDVECToNN0KOqhLvyTXDmmC72ukZ
         2OOs6GYiZyjL2oeKt5TBUVXdEgF9IkdvJmvI1/7VGAI+GGTut9S11NobqjZqSs9FtKBe
         AKfO2PBksKJDFpHHsqDKlHfqoeZ1pCcTo9cbx93mtzHSeNmtN5p/NnuSaYYVmx1BX8ui
         yOJA==
X-Gm-Message-State: AOJu0Yz7GEplApaqxuFdqt88zeUVhYOD0EOP0uGnjh3Yy94fkODqlcEW
	2SJXCUtaLgpupfN1CzbRmSqxXwy2RYboaE8jol9yliNv4y6FRw/jnjnjgg==
X-Gm-Gg: ASbGncuNiqhU1ep7vtx6P8UyQ4tTfRzIJizjq/UzhG7O+VClvyMjGY4BeSI/mSqgU6c
	yxfppWufdJXEhax9QQfff698tROMEYHddlwRKfhKBhxzZc8YlGGhcTEi+w8aRugQyWeiNwz/esO
	Ijwy8xh4Ijj7bCQBaI9U6cOOmZ7NcA/1SspHc5ovVBmHxvnwAaHelDN+PYhX24dwWv1/B1261ua
	0BJ7LUsuHCTsn/garoKgaHqMk9iTHbIEKaT5YlYSINbJoxQgjRJk+ByJ2kguZPcDbfNsCqR0jtA
	D6a9x96Y8wlHOe2gzsTWOzsIxqY=
X-Google-Smtp-Source: AGHT+IGbLhNmeo1nrNvHkTibqqJnjA8qJC9+YAzFHed3BTzSpkakLsS7vw6FXCP0mP5tMmfR/GlUAg==
X-Received: by 2002:adf:e309:0:b0:38f:2b59:b550 with SMTP id ffacd0b85a97d-38f70857b6bmr3098552f8f.50.1740163504063;
        Fri, 21 Feb 2025 10:45:04 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:a201:48ff:95d2:7dab:ae81])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-439b02ce37fsm25814065e9.8.2025.02.21.10.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 10:45:03 -0800 (PST)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: linux-security-module@vger.kernel.org,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Jann Horn <jannh@google.com>
Subject: [RFC 2/2] landlock: selftests for LANDLOCK_RESTRICT_SELF_TSYNC
Date: Fri, 21 Feb 2025 19:44:18 +0100
Message-ID: <20250221184417.27954-4-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221184417.27954-2-gnoack3000@gmail.com>
References: <20250221184417.27954-2-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Exercise various scenarios where Landlock domains are enforced across
all of a processes' threads.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/tsync_test.c | 94 +++++++++++++++++++
 1 file changed, 94 insertions(+)
 create mode 100644 tools/testing/selftests/landlock/tsync_test.c

diff --git a/tools/testing/selftests/landlock/tsync_test.c b/tools/testing/selftests/landlock/tsync_test.c
new file mode 100644
index 0000000000000..e8261a58c13ba
--- /dev/null
+++ b/tools/testing/selftests/landlock/tsync_test.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Landlock tests - Enforcing the same restrictions across multiple threads
+ *
+ * Copyright © 2025 Günther Noack <gnoack3000@gmail.com>
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
+	struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_fs = (LANDLOCK_ACCESS_FS_WRITE_FILE |
+				      LANDLOCK_ACCESS_FS_TRUNCATE),
+	};
+	const int ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+
+	ASSERT_LE(0, ruleset_fd);
+	return ruleset_fd;
+}
+
+TEST(single_threaded_success)
+{
+	const int ruleset_fd = create_ruleset(_metadata);
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
+	const int ruleset_fd = create_ruleset(_metadata);
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
+TEST(multi_threaded_failure)
+{
+	pthread_t t1;
+	const int ruleset_fd = create_ruleset(_metadata);
+
+	disable_caps(_metadata);
+
+	ASSERT_EQ(0, pthread_create(&t1, NULL, idle, NULL));
+
+	/*
+	 * landlock_restrict_self is expected to fail, because the other thread
+	 * has neither the NO_NEW_PRIVS flag nor CAP_SYS_ADMIN, and thus, it may
+	 * not enforce the Landlock ruleset.
+	 */
+	ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
+	EXPECT_EQ(-1, landlock_restrict_self(ruleset_fd,
+					     LANDLOCK_RESTRICT_SELF_TSYNC));
+	EXPECT_EQ(errno, EPERM);
+
+	ASSERT_EQ(0, pthread_cancel(t1));
+	ASSERT_EQ(0, pthread_join(t1, NULL));
+	ASSERT_EQ(0, close(ruleset_fd));
+}
+
+TEST_HARNESS_MAIN
-- 
2.48.1

