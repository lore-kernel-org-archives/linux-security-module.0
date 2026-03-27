Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D9535AC3A
	for <linux-security-module@vger.kernel.org>; Fri, 27 Mar 2026 16:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774630170; cv=none; b=u2uNzJtLDEdxa9TVIfEs54KktlX2i0MfuTgz/4ikNm2CKoG8moOdpr57ikSm2OB6AQcesxsmnGaLxrjz22N67VUJeb9BNYLxLQVqvlA5WhSzdiv0vmmpQOI74FQdaRwRR0pbOeTNyAsZlAvSE4x0QtTIv81sV8NiJQCeOKVMq58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774630170; c=relaxed/simple;
	bh=JwlJK27ld5wY72CdZJsUNzFCBoWDPpz0xRcYOzdUy18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LSuKOtaMQ6PAIzYO1hFeiOg+7l8KE75+HfNdwo0jH58vEG1R52v8aFNvvFYkE96YK1+NtK9QV4eZAZE1JJ/eQUIePCpOoWuXT9xPqQUep0bR64fWtvwHnzDFX0xKTrKrYj0SPWEhQ15IS87JOS/Cpuhudwp5qn8zO5iT1wIqL9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLA3e2DK; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLA3e2DK"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-486507134e4so26950355e9.0
        for <linux-security-module@vger.kernel.org>; Fri, 27 Mar 2026 09:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774630168; x=1775234968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L4uXACmOVDZbOw+U/66ZI9WIPBSn+WvwZpUDFZPPhLU=;
        b=OLA3e2DKLdZu1kxi8nmh/aNaUr88pL3JCe9lwxi3r6siUIHzUUoE2Vl/vSdn+4BuG0
         92FXK3NNm39KkeEdbbCr3wtgmP9wjBDyzvs7NOYJR2rOX442c9zzyimvP1AArpnh6XzH
         bWxlh3JsVbE2TipapyvZwsWdlJydeRRaHJDr2vwdVrMSuzfaen8Jf3DN4/fjBSyADGXT
         5I7ax5S8fPTNswYSw8rA3r6MT7IpDlu5/FC4XwP9kk4KTNswlNEtyPFjo1JV1SpKQ/dv
         Hrwn4wf0KxV9vqDEJux4f/L9xJT8T8yArryRhjJajA6aNIUks+8k+RR9viAwU2uuXkAv
         2atQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774630168; x=1775234968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L4uXACmOVDZbOw+U/66ZI9WIPBSn+WvwZpUDFZPPhLU=;
        b=J1QZXc2jvq08u58ndzWZU5tRjWCoUavP4QwD324tkXvqKMV9h9yZn7/a2s4dw22S/t
         P/S8X46GzpzMjO9pwOeJ/jrDeLX361ZYRZDMmNOshEXan0rrpgxbBua+qjy/zmQ6qGDz
         4aeEbn43n/xoOARnTYGJ4fm1VEkrIpq/ESl0wf+Ke+86r3g57ij9Hr44sdMmOkCf3UFM
         lUAU+tz44WK38vgkrsWpn8mco4MZKYjslxFcuRBErocskZBbf37OlaM/w5V0y/k4xweW
         +hq2dfZlDNM4fKP2t3McK09vx1G+4+ne6vUYSnQvFhz3qBVP2UhGt+hc0LBeWq+qEUKm
         u/kw==
X-Forwarded-Encrypted: i=1; AJvYcCXzISB1NqpqwCClLWhEzhj5yBXq22OFoC1hDQEkB4jmeRxpAAdM1axim3MTdt6LiIiIWF9PZ4FNuEZCbCk+6LQ/QY8pYqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEiu3ylF9uxdy/FUVDWbiUVNB2b/LWTk8FbNX34gHDemfMsdYB
	/nvFZn5iYNv8whk8pIJE435hlZRP752Q135L3X1BLSjM2x12olYFI77C
X-Gm-Gg: ATEYQzweO3QoY3hOzq2konxFsvorWf7pQxdOAzXrhlNRkSf9rVmLDHgWzZAnOzTP7LD
	cwqkQ+sx2Afv8NAK/jRLxuEHsE+ckLwxYsBWXDVB2NkMr6VzclVjNdjDJZThUlA7j59h7ZIf5ok
	e4imgIsgwn3le0weT7lVaSOmaErXvmfo1xGArmN4YZ7DLG7UJ5FruumKjLQEHUs4+skrbfrC4JS
	wpGvzYndR+K/shRdrFhUV67UAUkpe6qbUW/KldiOt5EIpQFafBJDPC7HmMBt2wkoVioGl7EhmR7
	olKi3mHqi8gxbyZtkqvsU87A3PG2Lh+y/Aac6lmkuv3j5q/QEt2uVRMrjxo/m/dTNk7d92glM0m
	2cukUU5ckb5MULp3NmVEEJ2Bpjamh9YWXjHqboD0lmhOp2Bcq7vG0V/5a/k0yvou04FGEUezt/f
	Opm0G4Z4pgA0uvI38FBMQjUwT5FYkgDVIedlxR4MdoLbYc6sRC
X-Received: by 2002:a05:600c:1546:b0:487:4eb:d125 with SMTP id 5b1f17b1804b1-48727ef0351mr54127165e9.9.1774630167571;
        Fri, 27 Mar 2026 09:49:27 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43c9876ffafsm995508f8f.37.2026.03.27.09.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 09:49:27 -0700 (PDT)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	"John Johansen" <john.johansen@canonical.com>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	linux-security-module@vger.kernel.org,
	"Tingmao Wang" <m@maowtm.org>,
	"Justin Suess" <utilityemal77@gmail.com>,
	"Samasth Norway Ananda" <samasth.norway.ananda@oracle.com>,
	"Matthieu Buffet" <matthieu@buffet.re>,
	"Mikhail Ivanov" <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	"Demi Marie Obenour" <demiobenour@gmail.com>,
	"Alyssa Ross" <hi@alyssa.is>,
	"Jann Horn" <jannh@google.com>,
	"Tahera Fahimi" <fahimitahera@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Kuniyuki Iwashima" <kuniyu@google.com>,
	"Georgia Garcia" <georgia.garcia@canonical.com>
Subject: [PATCH v8 09/12] selftests/landlock: Audit test for LANDLOCK_ACCESS_FS_RESOLVE_UNIX
Date: Fri, 27 Mar 2026 17:48:34 +0100
Message-ID: <20260327164838.38231-10-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327164838.38231-1-gnoack3000@gmail.com>
References: <20260327164838.38231-1-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add an audit test to check that Landlock denials from
LANDLOCK_ACCESS_FS_RESOLVE_UNIX result in audit logs in the expected
format.  (There is one audit test for each filesystem access right, so
we should add one for LANDLOCK_ACCESS_FS_RESOLVE_UNIX as well.)

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/fs_test.c | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index f8cfd31335e1..3dad643741f7 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -7961,6 +7961,46 @@ TEST_F(audit_layout1, ioctl_dev)
 	EXPECT_EQ(1, records.domain);
 }
 
+TEST_F(audit_layout1, resolve_unix)
+{
+	struct audit_records records;
+	const char *const path = "sock";
+	int srv_fd, cli_fd, status;
+	pid_t child_pid;
+
+	srv_fd = set_up_named_unix_server(_metadata, SOCK_STREAM, path);
+
+	child_pid = fork();
+	ASSERT_LE(0, child_pid);
+	if (!child_pid) {
+		drop_access_rights(_metadata,
+				   &(struct landlock_ruleset_attr){
+					   .handled_access_fs = ACCESS_ALL,
+				   });
+
+		cli_fd = socket(AF_UNIX, SOCK_STREAM, 0);
+		ASSERT_LE(0, cli_fd);
+		EXPECT_EQ(EACCES,
+			  test_connect_named_unix(_metadata, cli_fd, path));
+
+		EXPECT_EQ(0, close(cli_fd));
+		_exit(_metadata->exit_code);
+	}
+
+	ASSERT_EQ(child_pid, waitpid(child_pid, &status, 0));
+	EXPECT_EQ(1, WIFEXITED(status));
+	EXPECT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
+
+	EXPECT_EQ(0, matches_log_fs_extra(_metadata, self->audit_fd,
+					  "fs\\.resolve_unix", path, NULL));
+
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(1, records.domain);
+
+	EXPECT_EQ(0, close(srv_fd));
+}
+
 TEST_F(audit_layout1, mount)
 {
 	struct audit_records records;
-- 
2.53.0

