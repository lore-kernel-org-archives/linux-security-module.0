Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826598;
	b=Xc+jdmsBTCjUWIBp5xHj8rAK9mGVvlixdQBE6+WkZSXXYPlpcyG3Sb2qAdyUEKkx6arX
	 4kjVPkB4mvbQj1SFdjxASjkb/b6kwoTSj0y/D7dxubyOmJI1M8Ofv6WMROsf4j0/yyfDz
	 uJI2FCGuvNCOeZ1JWi6n6ZMYuagHsPmb+bX6bFSWP7Y+wvn9hbp1+yzPGeV+918KWVAnL
	 WbSjF2QHkSgswbYKohWrbcRnZHVfJtWf4XgPQHNUeMPfGOcd9+uC/ni0puB5E7FV/IVQS
	 ZF1uVYDsihQCOoin1AwhhxB5Fk9Qq9D/Dlu+SYwvNQBUcnBqZCNOlybpVA4A5n/jE4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826598;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=ClHebjpxaGVpSHSJKRDEIiJJ8nKPxJMTd7GtkoHHbdI=;
	b=a1i6nyC93c1tD5FlrNqjUdXEa7hIOWIKA62psRpdu7JqisOjghDJKNMv5L8JRdxRznab
	 z7MrAfXchl6OZa5Z15/Jp4Qz5vRr0oT7TD9LoDA5bKLaXqxthT8MdAza5fqQ6VmxoJIX1
	 8QnBaoznzOQiuPCvOFWbRZaFCA266rO1pMT99lU0DurElaNta/q+OjaCFqkkHmWCN3w+4
	 BSZ4cbJOtBM8FKyoJvDlO6J37KgC9DyFxD/Bu7f9tjZ47pspezUn45NM3MQDCgYBmpL9H
	 FkrYgt8P5eT+V2viGsVbdwzp+04ZeYiFEgGpluyP4mwmJc/n6WJNlhTyUVJ/Ul6GLBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aeEAxlht;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8AD607D65B
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:09:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E8AD607D65B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aeEAxlht
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso9306385e9.0
        for <linux-security-module@vger.kernel.org>; Wed, 04 Nov 2026 13:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793826595; x=1794431395; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ClHebjpxaGVpSHSJKRDEIiJJ8nKPxJMTd7GtkoHHbdI=;
        b=aeEAxlhtV2gW3xf/z1tVBOc/yAinFykcp8uyGZHVOzT/wpo4Pb9phrnVmg0JLljZ/J
         LM2ProcZTH0es6G+iCtetmlixoAkCgEslAZn5YZflw4q9qQO6t/iXsoOQ4LECxHy2XTO
         RudAdVNxky+cIMfAg7c+f1JjklINV6O7DyxYxPwWTKNWC7rEv1ELI1rPp5l/2CF8zy4k
         LsN73WLTRZmbWnwmWYqeRF20tAxlxxulPDSmiRwg1op7Vr6YYahoyILqSVdmP84ozjCw
         eT7+jSOKXDWkyknXuBkFP9TxkWetlVRDZh5EEIlomcs5CAJKKtpK2mfZA6S7MVNcxnQD
         WJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793826595; x=1794431395;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ClHebjpxaGVpSHSJKRDEIiJJ8nKPxJMTd7GtkoHHbdI=;
        b=2Xr7O+KmXg8QOXVg7KGlKLnLXJ6bJZSbBuTmczGghUe+c8gVy3B2xC5Fs4SxSe8Fnv
         ir70K203w787layuSEWAG6iAZFpsL8pbg/RnTJU+udk2tgaq303tffAqv8GXFOsCidM1
         4NAK5Ggr4qWMWZLtm57kYsltGdCb2TWFa0IJDGmGWHbXLT/6VGwiDYzg4iX/zhVEvRLv
         LbcrZxcSmHq3PXFun1R2VQGgJcJofjUgdQ71m0NRgIJoupAqohiX+1VpmystfPIcsBOO
         7hakzfknBuJUTWHAhR1hE0P0n9YVHfoRaZFoj6hDAqyTAUOW90ZgDankqlXXjcDKCkTy
         jUFw==
X-Gm-Message-State: APuU4Z8kD0I8wlEd/2Yt5UsXakyTbuyYgyWA8T4D/Xoo4Whfukt5KpFf
	pJQHSTyTemXPJP4kL1UMOFPhpZ0cRZvrz6BS6iNEo8hITXkp4eOOYXVg
X-Gm-Gg: AYBFou0IAmY3a1OSn7SjX+Wf4XRP1D97avU1GawhysEgHf1qAMZLGOXU+j6xlk5QZAh
	WTXl6kwunBejkA5cY2AUswQ0RGB7M16sngQGYvoOVrPzLm3gs5A6vdu7AL+NY0HzV9rWDuPVpiF
	Pmr2jDzr89B2LW0MG47p2EOHaDgPBEJ8V7Bct9wdizasRhfIr46Rk2cFgw+8L+fjxE/8W4yjMJ0
	GHPW+o/Mp0cogIGuyhar4Sql+bw9ftrNCdYOvXiop6eHe4+TYIgMAk8+rtu/1ItETMz/MDhvBYX
	2rMJ5tMbKzYjnfrHGRRHFpufVVPht/7NZfpQ0ngp0LqwfPNvD9mM/iaDdefO/89j37U+9p7lYWq
	Eo5F3UKdJ4U5eUY8kqZUuGDsxT4FN1Y5YvfN5KtsS+uP08jjQ3PRn71+YDVd9ztXkZzZnjeVIuI
	bMm0kMsw43b6I8d8u53ybzzKpS1vJZmBb0j31aqWrT6wapZMRltlKkefVPw9dZsJ4pZ70G7oosw
	F8+f1KpC6aM9SJre9DFku3jbt9uHoMUCT4qm7rbUH301AJQ1qxhKXvoKwY1jmZezaFKbpWy1QAf
	bhjww76SBPw9G8NWxbeM3aBEx2Iftt8vt+11W9Mmh9CibH9RdWMu5+5dYDiJsPm86ZS2W+nR0fY
	=
X-Received: by 2002:a05:600c:c16a:b0:4a1:fbd2:f689 with SMTP id 5b1f17b1804b1-4ac16fa352emr390692765e9.7.1793826593218;
        Wed, 04 Nov 2026 13:09:53 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b572bba207sm10222055e9.10.2026.11.04.13.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 13:09:52 -0800 (PST)
From: =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Date: Wed, 04 Nov 2026 22:09:13 +0100
Subject: [PATCH v2 27/27] selftests/landlock: Use EXPECT for checks that
 later steps do not need
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261104-selftests-refactor-v2-27-c52f23f7ce33@gmail.com>
References: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
In-Reply-To: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
X-Mailer: b4 0.15.2

ASSERT aborts the test, so it should only be used when continuing after
a failure is pointless.  Use EXPECT for checks whose outcome nothing
later in the test depends on:

* errno values after a failed syscall,
* test_open() and test_open_rel(), which leave no state behind,
* WEXITSTATUS() of a child that has exited,
* matches_log_fs() and matches_log_fs_extra(),
* the record counts returned by audit_count_records().

Keep ASSERT for operations whose side effects later checks depend on,
such as renames, links and file removals.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/audit_test.c      |   10 +-
 tools/testing/selftests/landlock/base_test.c       |  104 +-
 tools/testing/selftests/landlock/cap_test.c        |   22 +-
 tools/testing/selftests/landlock/fs_test.c         | 1024 ++++++++++----------
 tools/testing/selftests/landlock/net_test.c        |    2 +-
 tools/testing/selftests/landlock/ns_test.c         |   26 +-
 .../selftests/landlock/scoped_abstract_unix_test.c |    8 +-
 .../selftests/landlock/scoped_signal_test.c        |    6 +-
 tools/testing/selftests/landlock/scoped_test.c     |    2 +-
 9 files changed, 602 insertions(+), 602 deletions(-)

diff --git a/tools/testing/selftests/landlock/audit_test.c b/tools/testing/selftests/landlock/audit_test.c
index 392e75ddfa3c..23ab3a696299 100644
--- a/tools/testing/selftests/landlock/audit_test.c
+++ b/tools/testing/selftests/landlock/audit_test.c
@@ -315,14 +315,14 @@ TEST_F(audit, log_subdomains_off_fork)
 	if (child == 0) {
 		ASSERT_EQ(0, landlock_restrict_self(ruleset_fd, 0));
 		ASSERT_EQ(-1, kill(getppid(), 0));
-		ASSERT_EQ(EPERM, errno);
+		EXPECT_EQ(EPERM, errno);
 		_exit(_metadata->exit_code);
 		return;
 	}
 
 	ASSERT_EQ(child, waitpid(child, &status, 0));
 	ASSERT_EQ(true, WIFEXITED(status));
-	ASSERT_EQ(0, WEXITSTATUS(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
 
 	/* The denial must be logged (baseline). */
 	EXPECT_EQ(0, matches_log_signal(_metadata, self->audit_fd, getpid(),
@@ -348,14 +348,14 @@ TEST_F(audit, log_subdomains_off_fork)
 	if (child == 0) {
 		ASSERT_EQ(0, landlock_restrict_self(ruleset_fd, 0));
 		ASSERT_EQ(-1, kill(getppid(), 0));
-		ASSERT_EQ(EPERM, errno);
+		EXPECT_EQ(EPERM, errno);
 		_exit(_metadata->exit_code);
 		return;
 	}
 
 	ASSERT_EQ(child, waitpid(child, &status, 0));
 	ASSERT_EQ(true, WIFEXITED(status));
-	ASSERT_EQ(0, WEXITSTATUS(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
 
 	/* No denial record should appear. */
 	EXPECT_EQ(-EAGAIN, matches_log_signal(_metadata, self->audit_fd,
@@ -981,7 +981,7 @@ TEST_F(audit_exec, signal_and_open)
 	EXPECT_EQ(0, close(pipe_child[0]));
 	ASSERT_EQ(child, waitpid(child, &status, 0));
 	ASSERT_EQ(1, WIFEXITED(status));
-	ASSERT_EQ(0, WEXITSTATUS(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
 
 	/* Tests that the audit record only matches the child. */
 	if (!(variant->restrict_flags &
diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index 46af291edaef..c055280015ad 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -33,40 +33,40 @@ TEST(inconsistent_attr)
 	/* Checks copy_from_user(). */
 	ASSERT_EQ(-1, landlock_create_ruleset(ruleset_attr, 0, 0));
 	/* The size if less than sizeof(struct landlock_attr_enforce). */
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 	ASSERT_EQ(-1, landlock_create_ruleset(ruleset_attr, 1, 0));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 	ASSERT_EQ(-1, landlock_create_ruleset(ruleset_attr, 7, 0));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 
 	ASSERT_EQ(-1, landlock_create_ruleset(NULL, 1, 0));
 	/* The size if less than sizeof(struct landlock_attr_enforce). */
-	ASSERT_EQ(EFAULT, errno);
+	EXPECT_EQ(EFAULT, errno);
 
 	ASSERT_EQ(-1, landlock_create_ruleset(
 			      NULL, sizeof(struct landlock_ruleset_attr), 0));
-	ASSERT_EQ(EFAULT, errno);
+	EXPECT_EQ(EFAULT, errno);
 
 	ASSERT_EQ(-1, landlock_create_ruleset(ruleset_attr, page_size + 1, 0));
-	ASSERT_EQ(E2BIG, errno);
+	EXPECT_EQ(E2BIG, errno);
 
 	/* Checks minimal valid attribute size. */
 	ASSERT_EQ(-1, landlock_create_ruleset(ruleset_attr, 8, 0));
-	ASSERT_EQ(ENOMSG, errno);
+	EXPECT_EQ(ENOMSG, errno);
 	ASSERT_EQ(-1, landlock_create_ruleset(
 			      ruleset_attr,
 			      sizeof(struct landlock_ruleset_attr), 0));
-	ASSERT_EQ(ENOMSG, errno);
+	EXPECT_EQ(ENOMSG, errno);
 	ASSERT_EQ(-1, landlock_create_ruleset(ruleset_attr, page_size, 0));
-	ASSERT_EQ(ENOMSG, errno);
+	EXPECT_EQ(ENOMSG, errno);
 
 	/* Checks non-zero value. */
 	buf[page_size - 2] = '.';
 	ASSERT_EQ(-1, landlock_create_ruleset(ruleset_attr, page_size, 0));
-	ASSERT_EQ(E2BIG, errno);
+	EXPECT_EQ(E2BIG, errno);
 
 	ASSERT_EQ(-1, landlock_create_ruleset(ruleset_attr, page_size + 1, 0));
-	ASSERT_EQ(E2BIG, errno);
+	EXPECT_EQ(E2BIG, errno);
 
 	free(buf);
 }
@@ -81,21 +81,21 @@ TEST(abi_version)
 
 	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
 					      LANDLOCK_CREATE_RULESET_VERSION));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 
 	ASSERT_EQ(-1, landlock_create_ruleset(NULL, sizeof(ruleset_attr),
 					      LANDLOCK_CREATE_RULESET_VERSION));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 
 	ASSERT_EQ(-1,
 		  landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr),
 					  LANDLOCK_CREATE_RULESET_VERSION));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 
 	ASSERT_EQ(-1, landlock_create_ruleset(NULL, 0,
 					      LANDLOCK_CREATE_RULESET_VERSION |
 						      1 << 31));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 }
 
 /*
@@ -121,16 +121,16 @@ TEST(errata)
 
 	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
 					      LANDLOCK_CREATE_RULESET_ERRATA));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 
 	ASSERT_EQ(-1, landlock_create_ruleset(NULL, sizeof(ruleset_attr),
 					      LANDLOCK_CREATE_RULESET_ERRATA));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 
 	ASSERT_EQ(-1,
 		  landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr),
 					  LANDLOCK_CREATE_RULESET_ERRATA));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 
 	ASSERT_EQ(-1, landlock_create_ruleset(
 			      NULL, 0,
@@ -141,7 +141,7 @@ TEST(errata)
 	ASSERT_EQ(-1, landlock_create_ruleset(NULL, 0,
 					      LANDLOCK_CREATE_RULESET_ERRATA |
 						      1 << 31));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 }
 
 #define PERMISSION_LAST LANDLOCK_PERMISSION_CAPABILITY_USE
@@ -159,7 +159,7 @@ TEST(ruleset_with_unknown_permission)
 		/* Unknown handled_permissions values must be rejected. */
 		ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr,
 						      sizeof(ruleset_attr), 0));
-		ASSERT_EQ(EINVAL, errno);
+		EXPECT_EQ(EINVAL, errno);
 	}
 }
 
@@ -175,29 +175,29 @@ TEST(create_ruleset_checks_ordering)
 
 	/* Checks priority for invalid flags. */
 	ASSERT_EQ(-1, landlock_create_ruleset(NULL, 0, invalid_flag));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 
 	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0, invalid_flag));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 
 	ASSERT_EQ(-1, landlock_create_ruleset(NULL, sizeof(ruleset_attr),
 					      invalid_flag));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 
 	ASSERT_EQ(-1,
 		  landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr),
 					  invalid_flag));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 
 	/* Checks too big ruleset_attr size. */
 	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, -1, 0));
-	ASSERT_EQ(E2BIG, errno);
+	EXPECT_EQ(E2BIG, errno);
 
 	/* Checks too small ruleset_attr size. */
 	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0, 0));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 1, 0));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 
 	/* Checks valid call. */
 	ruleset_fd =
@@ -223,25 +223,25 @@ TEST(add_rule_checks_ordering)
 
 	/* Checks invalid flags. */
 	ASSERT_EQ(-1, landlock_add_rule(-1, 0, NULL, 100));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 
 	/* Checks invalid ruleset FD. */
 	ASSERT_EQ(-1, landlock_add_rule(-1, 0, NULL, 0));
-	ASSERT_EQ(EBADF, errno);
+	EXPECT_EQ(EBADF, errno);
 
 	/* Checks invalid rule type. */
 	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, 0, NULL, 0));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 
 	/* Checks invalid rule attr. */
 	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
 					NULL, 0));
-	ASSERT_EQ(EFAULT, errno);
+	EXPECT_EQ(EFAULT, errno);
 
 	/* Checks invalid path_beneath.parent_fd. */
 	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
 					&path_beneath_attr, 0));
-	ASSERT_EQ(EBADF, errno);
+	EXPECT_EQ(EBADF, errno);
 
 	/* Checks valid call. */
 	path_beneath_attr.parent_fd =
@@ -281,11 +281,11 @@ TEST(restrict_self_checks_ordering)
 	 * CAP_SYS_ADMIN requirement.
 	 */
 	ASSERT_EQ(-1, landlock_restrict_self(-1, -1));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 	ASSERT_EQ(-1, landlock_restrict_self(-1, 0));
-	ASSERT_EQ(EPERM, errno);
+	EXPECT_EQ(EPERM, errno);
 	ASSERT_EQ(-1, landlock_restrict_self(ruleset_fd, 0));
-	ASSERT_EQ(EPERM, errno);
+	EXPECT_EQ(EPERM, errno);
 	/*
 	 * LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS fulfills the no_new_privs /
 	 * CAP_SYS_ADMIN requirement but requires a ruleset, so the FD is
@@ -293,17 +293,17 @@ TEST(restrict_self_checks_ordering)
 	 */
 	ASSERT_EQ(-1, landlock_restrict_self(
 			      -1, LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS));
-	ASSERT_EQ(EBADF, errno);
+	EXPECT_EQ(EBADF, errno);
 
 	ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
 
 	/* Checks invalid flags. */
 	ASSERT_EQ(-1, landlock_restrict_self(-1, -1));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 
 	/* Checks invalid ruleset FD. */
 	ASSERT_EQ(-1, landlock_restrict_self(-1, 0));
-	ASSERT_EQ(EBADF, errno);
+	EXPECT_EQ(EBADF, errno);
 
 	/* Checks valid call. */
 	ASSERT_EQ(0, landlock_restrict_self(ruleset_fd, 0));
@@ -338,7 +338,7 @@ TEST(restrict_self_max_layers)
 	drop_caps(_metadata);
 	ASSERT_EQ(-1, landlock_restrict_self(
 			      ruleset_fd, LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS));
-	ASSERT_EQ(E2BIG, errno);
+	EXPECT_EQ(E2BIG, errno);
 
 	/* Checks that the failed call did not set no_new_privs. */
 	ASSERT_EQ(0, prctl(PR_GET_NO_NEW_PRIVS, 0, 0, 0, 0));
@@ -492,9 +492,9 @@ TEST(ruleset_fd_io)
 	ASSERT_LE(0, ruleset_fd);
 
 	ASSERT_EQ(-1, write(ruleset_fd, ".", 1));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 	ASSERT_EQ(-1, read(ruleset_fd, &buf, 1));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 
 	EXPECT_EQ(0, close(ruleset_fd));
 }
@@ -549,7 +549,7 @@ TEST(ruleset_fd_transfer)
 
 		/* Checks that the ruleset enforcement. */
 		ASSERT_EQ(-1, open("/", O_RDONLY | O_DIRECTORY | O_CLOEXEC));
-		ASSERT_EQ(EACCES, errno);
+		EXPECT_EQ(EACCES, errno);
 		dir_fd = open("/tmp", O_RDONLY | O_DIRECTORY | O_CLOEXEC);
 		ASSERT_LE(0, dir_fd);
 		EXPECT_EQ(0, close(dir_fd));
@@ -569,7 +569,7 @@ TEST(ruleset_fd_transfer)
 
 	ASSERT_EQ(child, waitpid(child, &status, 0));
 	ASSERT_EQ(1, WIFEXITED(status));
-	ASSERT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
+	EXPECT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
 }
 
 TEST(cred_transfer)
@@ -667,7 +667,7 @@ TEST(useless_quiet_rule_fs)
 	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
 					&path_beneath_attr,
 					LANDLOCK_ADD_RULE_QUIET));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 
 	/* Check that the rule had not been added. */
 	EXPECT_EQ(0, close(root_fd));
@@ -675,7 +675,7 @@ TEST(useless_quiet_rule_fs)
 	EXPECT_EQ(0, close(ruleset_fd));
 
 	ASSERT_EQ(-1, open("/", O_RDONLY | O_DIRECTORY | O_CLOEXEC));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 }
 
 TEST(useless_quiet_rule_net)
@@ -698,7 +698,7 @@ TEST(useless_quiet_rule_net)
 	ASSERT_EQ(-1,
 		  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
 				    &net_port_attr, LANDLOCK_ADD_RULE_QUIET));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 
 	EXPECT_EQ(0, close(ruleset_fd));
 }
@@ -721,15 +721,15 @@ TEST(invalid_quiet_bits_1)
 	/* Quiet bit set but not part of the handled mask. */
 	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr_fs,
 					      sizeof(ruleset_attr_fs), 0));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 
 	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr_net,
 					      sizeof(ruleset_attr_net), 0));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 
 	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr_scoped,
 					      sizeof(ruleset_attr_scoped), 0));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 }
 
 TEST(invalid_quiet_bits_2)
@@ -750,15 +750,15 @@ TEST(invalid_quiet_bits_2)
 	/* Quiet bit outside of the valid access range. */
 	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr_fs,
 					      sizeof(ruleset_attr_fs), 0));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 
 	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr_net,
 					      sizeof(ruleset_attr_net), 0));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 
 	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr_scoped,
 					      sizeof(ruleset_attr_scoped), 0));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 }
 
 TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/landlock/cap_test.c b/tools/testing/selftests/landlock/cap_test.c
index 8e6e92450b13..2b5767f70e26 100644
--- a/tools/testing/selftests/landlock/cap_test.c
+++ b/tools/testing/selftests/landlock/cap_test.c
@@ -80,14 +80,14 @@ TEST(add_rule_bad_attr)
 	/* Invalid rule pointer returns EFAULT. */
 	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_CAPABILITY,
 					NULL, 0));
-	ASSERT_EQ(EFAULT, errno);
+	EXPECT_EQ(EFAULT, errno);
 
 	/* Empty permissions selector returns ENOMSG. */
 	attr.permissions = 0;
 	attr.allowed_capabilities = (1ULL << CAP_NET_RAW);
 	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_CAPABILITY,
 					&attr, 0));
-	ASSERT_EQ(ENOMSG, errno);
+	EXPECT_EQ(ENOMSG, errno);
 
 	/* Useless rule: neither allowed nor quiet capabilities set. */
 	attr.permissions = LANDLOCK_PERMISSION_CAPABILITY_USE;
@@ -95,7 +95,7 @@ TEST(add_rule_bad_attr)
 	attr.quiet_capabilities = 0;
 	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_CAPABILITY,
 					&attr, 0));
-	ASSERT_EQ(ENOMSG, errno);
+	EXPECT_EQ(ENOMSG, errno);
 
 	/* Quiet-only rule (empty allowed set) is legal. */
 	attr.permissions = LANDLOCK_PERMISSION_CAPABILITY_USE;
@@ -117,14 +117,14 @@ TEST(add_rule_bad_attr)
 	attr.allowed_capabilities = (1ULL << CAP_NET_RAW);
 	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_CAPABILITY,
 					&attr, 0));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 
 	/* permissions with wrong type. */
 	attr.permissions = LANDLOCK_PERMISSION_NAMESPACE_USE;
 	attr.allowed_capabilities = (1ULL << CAP_NET_RAW);
 	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_CAPABILITY,
 					&attr, 0));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 
 	/*
 	 * Unknown capability bits (e.g. bit 63) are silently accepted for
@@ -145,7 +145,7 @@ TEST(add_rule_bad_attr)
 	attr.allowed_capabilities = (1ULL << CAP_NET_RAW);
 	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_CAPABILITY,
 					&attr, LANDLOCK_ADD_RULE_QUIET));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 
 	EXPECT_EQ(0, close(ruleset_fd));
 
@@ -161,7 +161,7 @@ TEST(add_rule_bad_attr)
 	attr.allowed_capabilities = (1ULL << CAP_NET_RAW);
 	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_CAPABILITY,
 					&attr, 0));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 	EXPECT_EQ(0, close(ruleset_fd));
 }
 
@@ -705,7 +705,7 @@ TEST(cap_target_userns_independent)
 	EXPECT_EQ(0, close(sockets[0]));
 	ASSERT_EQ(target, waitpid(target, &status, 0));
 	ASSERT_TRUE(WIFEXITED(status));
-	ASSERT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
+	EXPECT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
 
 	set_cap(_metadata, CAP_SYS_ADMIN);
 	for (int sandboxed = 0; sandboxed <= 1; sandboxed++) {
@@ -1154,10 +1154,10 @@ TEST_F(cap_trace, rule_events)
 				       1ULL << CAP_SYS_CHROOT));
 	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_CAPABILITY,
 					&invalid_attr, 0));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_CAPABILITY,
 					&valid_attr, LANDLOCK_ADD_RULE_QUIET));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 	ASSERT_EQ(0, add_cap_rule_full(ruleset_fd, 1ULL << CAP_SYS_ADMIN,
 				       1ULL << CAP_SYS_CHROOT));
 	ASSERT_EQ(0, add_cap_rule(ruleset_fd, 63));
@@ -1303,7 +1303,7 @@ static void test_cap_trace_denial(struct __test_metadata *const _metadata,
 
 	ASSERT_EQ(child, waitpid(child, &status, 0));
 	ASSERT_TRUE(WIFEXITED(status));
-	ASSERT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
+	EXPECT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
 
 	buf = tracefs_read_buf();
 	ASSERT_NE(NULL, buf);
diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 408e4b220e02..c3357ed08e1e 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -332,7 +332,7 @@ static void cleanup_layout(struct __test_metadata *const _metadata)
 		 * visibility of the nested TMP_DIR mount point for the test's
 		 * parent process doing this cleanup.
 		 */
-		ASSERT_EQ(EINVAL, errno);
+		EXPECT_EQ(EINVAL, errno);
 	}
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 	EXPECT_EQ(0, remove_path(TMP_DIR));
@@ -448,25 +448,25 @@ static int test_open(const char *const path, const int flags)
 
 TEST_F_FORK(layout1, no_restriction)
 {
-	ASSERT_EQ(0, test_open(dir_s1d1, O_RDONLY));
-	ASSERT_EQ(0, test_open(file1_s1d1, O_RDONLY));
-	ASSERT_EQ(0, test_open(file2_s1d1, O_RDONLY));
-	ASSERT_EQ(0, test_open(dir_s1d2, O_RDONLY));
-	ASSERT_EQ(0, test_open(file1_s1d2, O_RDONLY));
-	ASSERT_EQ(0, test_open(file2_s1d2, O_RDONLY));
-	ASSERT_EQ(0, test_open(dir_s1d3, O_RDONLY));
-	ASSERT_EQ(0, test_open(file1_s1d3, O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s1d1, O_RDONLY));
+	EXPECT_EQ(0, test_open(file1_s1d1, O_RDONLY));
+	EXPECT_EQ(0, test_open(file2_s1d1, O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s1d2, O_RDONLY));
+	EXPECT_EQ(0, test_open(file1_s1d2, O_RDONLY));
+	EXPECT_EQ(0, test_open(file2_s1d2, O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s1d3, O_RDONLY));
+	EXPECT_EQ(0, test_open(file1_s1d3, O_RDONLY));
 
-	ASSERT_EQ(0, test_open(dir_s2d1, O_RDONLY));
-	ASSERT_EQ(0, test_open(file1_s2d1, O_RDONLY));
-	ASSERT_EQ(0, test_open(dir_s2d2, O_RDONLY));
-	ASSERT_EQ(0, test_open(file1_s2d2, O_RDONLY));
-	ASSERT_EQ(0, test_open(dir_s2d3, O_RDONLY));
-	ASSERT_EQ(0, test_open(file1_s2d3, O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s2d1, O_RDONLY));
+	EXPECT_EQ(0, test_open(file1_s2d1, O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s2d2, O_RDONLY));
+	EXPECT_EQ(0, test_open(file1_s2d2, O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s2d3, O_RDONLY));
+	EXPECT_EQ(0, test_open(file1_s2d3, O_RDONLY));
 
-	ASSERT_EQ(0, test_open(dir_s3d1, O_RDONLY));
-	ASSERT_EQ(0, test_open(dir_s3d2, O_RDONLY));
-	ASSERT_EQ(0, test_open(dir_s3d3, O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s3d1, O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s3d2, O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s3d3, O_RDONLY));
 }
 
 TEST_F_FORK(layout1, inval)
@@ -491,7 +491,7 @@ TEST_F_FORK(layout1, inval)
 	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
 					&path_beneath, 0));
 	/* Returns EBADF because ruleset_fd is not a landlock-ruleset FD. */
-	ASSERT_EQ(EBADF, errno);
+	EXPECT_EQ(EBADF, errno);
 	EXPECT_EQ(0, close(ruleset_fd));
 
 	ruleset_fd = open(dir_s1d1, O_DIRECTORY | O_CLOEXEC);
@@ -499,7 +499,7 @@ TEST_F_FORK(layout1, inval)
 	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
 					&path_beneath, 0));
 	/* Returns EBADFD because ruleset_fd is not a valid ruleset. */
-	ASSERT_EQ(EBADFD, errno);
+	EXPECT_EQ(EBADFD, errno);
 	EXPECT_EQ(0, close(ruleset_fd));
 
 	/* Gets a real ruleset. */
@@ -521,7 +521,7 @@ TEST_F_FORK(layout1, inval)
 	path_beneath.parent_fd = ruleset_fd;
 	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
 					&path_beneath, 0));
-	ASSERT_EQ(EBADFD, errno);
+	EXPECT_EQ(EBADFD, errno);
 
 	/* Checks unhandled allowed_access. */
 	path_beneath.parent_fd =
@@ -532,28 +532,28 @@ TEST_F_FORK(layout1, inval)
 	path_beneath.allowed_access |= LANDLOCK_ACCESS_FS_EXECUTE;
 	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
 					&path_beneath, 0));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 	path_beneath.allowed_access &= ~LANDLOCK_ACCESS_FS_EXECUTE;
 
 	/* Tests with denied-by-default access right. */
 	path_beneath.allowed_access |= LANDLOCK_ACCESS_FS_REFER;
 	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
 					&path_beneath, 0));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 	path_beneath.allowed_access &= ~LANDLOCK_ACCESS_FS_REFER;
 
 	/* Test with unknown (64-bits) value. */
 	path_beneath.allowed_access |= (1ULL << 60);
 	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
 					&path_beneath, 0));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 	path_beneath.allowed_access &= ~(1ULL << 60);
 
 	/* Test with no access. */
 	path_beneath.allowed_access = 0;
 	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
 					&path_beneath, 0));
-	ASSERT_EQ(ENOMSG, errno);
+	EXPECT_EQ(ENOMSG, errno);
 	path_beneath.allowed_access &= ~(1ULL << 60);
 
 	EXPECT_EQ(0, close(path_beneath.parent_fd));
@@ -629,7 +629,7 @@ TEST_F_FORK(layout1, file_and_dir_access_rights)
 			ASSERT_EQ(0, err);
 		} else {
 			ASSERT_EQ(-1, err);
-			ASSERT_EQ(EINVAL, errno);
+			EXPECT_EQ(EINVAL, errno);
 		}
 	}
 	EXPECT_EQ(0, close(path_beneath_file.parent_fd));
@@ -649,7 +649,7 @@ TEST_F_FORK(layout0, ruleset_with_unknown_access)
 
 		ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr,
 						      sizeof(ruleset_attr), 0));
-		ASSERT_EQ(EINVAL, errno);
+		EXPECT_EQ(EINVAL, errno);
 	}
 }
 
@@ -806,24 +806,24 @@ TEST_F_FORK(layout0, proc_nsfs)
 		rules);
 
 	ASSERT_LE(0, ruleset_fd);
-	ASSERT_EQ(0, test_open("/proc/self/ns/mnt", O_RDONLY));
+	EXPECT_EQ(0, test_open("/proc/self/ns/mnt", O_RDONLY));
 
 	enforce_ruleset(_metadata, ruleset_fd);
 
-	ASSERT_EQ(EACCES, test_open("/", O_RDONLY));
-	ASSERT_EQ(EACCES, test_open("/dev", O_RDONLY));
-	ASSERT_EQ(0, test_open("/dev/null", O_RDONLY));
-	ASSERT_EQ(EACCES, test_open("/dev/full", O_RDONLY));
+	EXPECT_EQ(EACCES, test_open("/", O_RDONLY));
+	EXPECT_EQ(EACCES, test_open("/dev", O_RDONLY));
+	EXPECT_EQ(0, test_open("/dev/null", O_RDONLY));
+	EXPECT_EQ(EACCES, test_open("/dev/full", O_RDONLY));
 
-	ASSERT_EQ(EACCES, test_open("/proc", O_RDONLY));
-	ASSERT_EQ(EACCES, test_open("/proc/self", O_RDONLY));
-	ASSERT_EQ(EACCES, test_open("/proc/self/ns", O_RDONLY));
+	EXPECT_EQ(EACCES, test_open("/proc", O_RDONLY));
+	EXPECT_EQ(EACCES, test_open("/proc/self", O_RDONLY));
+	EXPECT_EQ(EACCES, test_open("/proc/self/ns", O_RDONLY));
 	/*
 	 * Because nsfs is an internal filesystem, /proc/self/ns/mnt is a
 	 * disconnected path.  Such path cannot be identified and must then be
 	 * allowed.
 	 */
-	ASSERT_EQ(0, test_open("/proc/self/ns/mnt", O_RDONLY));
+	EXPECT_EQ(0, test_open("/proc/self/ns/mnt", O_RDONLY));
 
 	/*
 	 * Checks that it is not possible to add nsfs-like filesystem
@@ -835,7 +835,7 @@ TEST_F_FORK(layout0, proc_nsfs)
 	ASSERT_LE(0, path_beneath.parent_fd);
 	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
 					&path_beneath, 0));
-	ASSERT_EQ(EBADFD, errno);
+	EXPECT_EQ(EBADFD, errno);
 	EXPECT_EQ(0, close(path_beneath.parent_fd));
 }
 
@@ -855,7 +855,7 @@ TEST_F_FORK(layout0, unpriv)
 	ruleset_fd = create_ruleset(_metadata, ACCESS_RO, rules);
 	ASSERT_LE(0, ruleset_fd);
 	ASSERT_EQ(-1, landlock_restrict_self(ruleset_fd, 0));
-	ASSERT_EQ(EPERM, errno);
+	EXPECT_EQ(EPERM, errno);
 
 	/* enforce_ruleset() calls prctl(no_new_privs). */
 	enforce_ruleset(_metadata, ruleset_fd);
@@ -882,23 +882,23 @@ TEST_F_FORK(layout1, effective_access)
 	enforce_fs(_metadata, ACCESS_RW, rules);
 
 	/* Tests on a directory (with or without O_PATH). */
-	ASSERT_EQ(EACCES, test_open("/", O_RDONLY));
-	ASSERT_EQ(0, test_open("/", O_RDONLY | O_PATH));
-	ASSERT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY));
-	ASSERT_EQ(0, test_open(dir_s1d1, O_RDONLY | O_PATH));
-	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_RDONLY));
-	ASSERT_EQ(0, test_open(file1_s1d1, O_RDONLY | O_PATH));
+	EXPECT_EQ(EACCES, test_open("/", O_RDONLY));
+	EXPECT_EQ(0, test_open("/", O_RDONLY | O_PATH));
+	EXPECT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s1d1, O_RDONLY | O_PATH));
+	EXPECT_EQ(EACCES, test_open(file1_s1d1, O_RDONLY));
+	EXPECT_EQ(0, test_open(file1_s1d1, O_RDONLY | O_PATH));
 
-	ASSERT_EQ(0, test_open(dir_s1d2, O_RDONLY));
-	ASSERT_EQ(0, test_open(file1_s1d2, O_RDONLY));
-	ASSERT_EQ(0, test_open(dir_s1d3, O_RDONLY));
-	ASSERT_EQ(0, test_open(file1_s1d3, O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s1d2, O_RDONLY));
+	EXPECT_EQ(0, test_open(file1_s1d2, O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s1d3, O_RDONLY));
+	EXPECT_EQ(0, test_open(file1_s1d3, O_RDONLY));
 
 	/* Tests on a file (with or without O_PATH). */
-	ASSERT_EQ(EACCES, test_open(dir_s2d2, O_RDONLY));
-	ASSERT_EQ(0, test_open(dir_s2d2, O_RDONLY | O_PATH));
+	EXPECT_EQ(EACCES, test_open(dir_s2d2, O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s2d2, O_RDONLY | O_PATH));
 
-	ASSERT_EQ(0, test_open(file1_s2d2, O_RDONLY));
+	EXPECT_EQ(0, test_open(file1_s2d2, O_RDONLY));
 
 	/* Checks effective read and write actions. */
 	reg_fd = open(file1_s2d2, O_RDWR | O_CLOEXEC);
@@ -913,7 +913,7 @@ TEST_F_FORK(layout1, effective_access)
 	reg_fd = open(file1_s2d2, O_RDONLY | O_CLOEXEC);
 	ASSERT_LE(0, reg_fd);
 	ASSERT_EQ(-1, write(reg_fd, &buf, 1));
-	ASSERT_EQ(EBADF, errno);
+	EXPECT_EQ(EBADF, errno);
 	EXPECT_EQ(0, close(reg_fd));
 }
 
@@ -934,11 +934,11 @@ TEST_F_FORK(layout1, unhandled_access)
 	 * Because the policy does not handle LANDLOCK_ACCESS_FS_WRITE_FILE,
 	 * opening for write-only should be allowed, but not read-write.
 	 */
-	ASSERT_EQ(0, test_open(file1_s1d1, O_WRONLY));
-	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_RDWR));
+	EXPECT_EQ(0, test_open(file1_s1d1, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d1, O_RDWR));
 
-	ASSERT_EQ(0, test_open(file1_s1d2, O_WRONLY));
-	ASSERT_EQ(0, test_open(file1_s1d2, O_RDWR));
+	EXPECT_EQ(0, test_open(file1_s1d2, O_WRONLY));
+	EXPECT_EQ(0, test_open(file1_s1d2, O_RDWR));
 }
 
 TEST_F_FORK(layout1, ruleset_overlap)
@@ -961,22 +961,22 @@ TEST_F_FORK(layout1, ruleset_overlap)
 	enforce_fs(_metadata, ACCESS_RW, rules);
 
 	/* Checks s1d1 hierarchy. */
-	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_RDONLY));
-	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_WRONLY));
-	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_RDWR));
-	ASSERT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d1, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d1, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d1, O_RDWR));
+	EXPECT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
 
 	/* Checks s1d2 hierarchy. */
-	ASSERT_EQ(0, test_open(file1_s1d2, O_RDONLY));
-	ASSERT_EQ(0, test_open(file1_s1d2, O_WRONLY));
-	ASSERT_EQ(0, test_open(file1_s1d2, O_RDWR));
-	ASSERT_EQ(0, test_open(dir_s1d2, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(0, test_open(file1_s1d2, O_RDONLY));
+	EXPECT_EQ(0, test_open(file1_s1d2, O_WRONLY));
+	EXPECT_EQ(0, test_open(file1_s1d2, O_RDWR));
+	EXPECT_EQ(0, test_open(dir_s1d2, O_RDONLY | O_DIRECTORY));
 
 	/* Checks s1d3 hierarchy. */
-	ASSERT_EQ(0, test_open(file1_s1d3, O_RDONLY));
-	ASSERT_EQ(0, test_open(file1_s1d3, O_WRONLY));
-	ASSERT_EQ(0, test_open(file1_s1d3, O_RDWR));
-	ASSERT_EQ(0, test_open(dir_s1d3, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(0, test_open(file1_s1d3, O_RDONLY));
+	EXPECT_EQ(0, test_open(file1_s1d3, O_WRONLY));
+	EXPECT_EQ(0, test_open(file1_s1d3, O_RDWR));
+	EXPECT_EQ(0, test_open(dir_s1d3, O_RDONLY | O_DIRECTORY));
 }
 
 TEST_F_FORK(layout1, layer_rule_unions)
@@ -1014,67 +1014,67 @@ TEST_F_FORK(layout1, layer_rule_unions)
 	enforce_fs(_metadata, ACCESS_RW, layer1);
 
 	/* Checks s1d1 hierarchy with layer1. */
-	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_RDONLY));
-	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_WRONLY));
-	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_RDWR));
-	ASSERT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d1, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d1, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d1, O_RDWR));
+	EXPECT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
 
 	/* Checks s1d2 hierarchy with layer1. */
-	ASSERT_EQ(0, test_open(file1_s1d2, O_RDONLY));
-	ASSERT_EQ(EACCES, test_open(file1_s1d2, O_WRONLY));
-	ASSERT_EQ(EACCES, test_open(file1_s1d2, O_RDWR));
-	ASSERT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(0, test_open(file1_s1d2, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d2, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d2, O_RDWR));
+	EXPECT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
 
 	/* Checks s1d3 hierarchy with layer1. */
-	ASSERT_EQ(0, test_open(file1_s1d3, O_RDONLY));
-	ASSERT_EQ(0, test_open(file1_s1d3, O_WRONLY));
+	EXPECT_EQ(0, test_open(file1_s1d3, O_RDONLY));
+	EXPECT_EQ(0, test_open(file1_s1d3, O_WRONLY));
 	/* dir_s1d3 should allow READ_FILE and WRITE_FILE (O_RDWR). */
-	ASSERT_EQ(0, test_open(file1_s1d3, O_RDWR));
-	ASSERT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(0, test_open(file1_s1d3, O_RDWR));
+	EXPECT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
 
 	/* Doesn't change anything from layer1. */
 	enforce_fs(_metadata, ACCESS_RW, layer2);
 
 	/* Checks s1d1 hierarchy with layer2. */
-	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_RDONLY));
-	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_WRONLY));
-	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_RDWR));
-	ASSERT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d1, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d1, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d1, O_RDWR));
+	EXPECT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
 
 	/* Checks s1d2 hierarchy with layer2. */
-	ASSERT_EQ(0, test_open(file1_s1d2, O_RDONLY));
-	ASSERT_EQ(EACCES, test_open(file1_s1d2, O_WRONLY));
-	ASSERT_EQ(EACCES, test_open(file1_s1d2, O_RDWR));
-	ASSERT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(0, test_open(file1_s1d2, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d2, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d2, O_RDWR));
+	EXPECT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
 
 	/* Checks s1d3 hierarchy with layer2. */
-	ASSERT_EQ(0, test_open(file1_s1d3, O_RDONLY));
-	ASSERT_EQ(0, test_open(file1_s1d3, O_WRONLY));
+	EXPECT_EQ(0, test_open(file1_s1d3, O_RDONLY));
+	EXPECT_EQ(0, test_open(file1_s1d3, O_WRONLY));
 	/* dir_s1d3 should allow READ_FILE and WRITE_FILE (O_RDWR). */
-	ASSERT_EQ(0, test_open(file1_s1d3, O_RDWR));
-	ASSERT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(0, test_open(file1_s1d3, O_RDWR));
+	EXPECT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
 
 	/* Only allows write (but not read) to dir_s1d3. */
 	enforce_fs(_metadata, ACCESS_RW, layer3);
 
 	/* Checks s1d1 hierarchy with layer3. */
-	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_RDONLY));
-	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_WRONLY));
-	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_RDWR));
-	ASSERT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d1, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d1, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d1, O_RDWR));
+	EXPECT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
 
 	/* Checks s1d2 hierarchy with layer3. */
-	ASSERT_EQ(EACCES, test_open(file1_s1d2, O_RDONLY));
-	ASSERT_EQ(EACCES, test_open(file1_s1d2, O_WRONLY));
-	ASSERT_EQ(EACCES, test_open(file1_s1d2, O_RDWR));
-	ASSERT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d2, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d2, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d2, O_RDWR));
+	EXPECT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
 
 	/* Checks s1d3 hierarchy with layer3. */
-	ASSERT_EQ(EACCES, test_open(file1_s1d3, O_RDONLY));
-	ASSERT_EQ(0, test_open(file1_s1d3, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d3, O_RDONLY));
+	EXPECT_EQ(0, test_open(file1_s1d3, O_WRONLY));
 	/* dir_s1d3 should now deny READ_FILE and WRITE_FILE (O_RDWR). */
-	ASSERT_EQ(EACCES, test_open(file1_s1d3, O_RDWR));
-	ASSERT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d3, O_RDWR));
+	EXPECT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
 }
 
 TEST_F_FORK(layout1, non_overlapping_accesses)
@@ -1100,7 +1100,7 @@ TEST_F_FORK(layout1, non_overlapping_accesses)
 	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_MAKE_REG, layer1);
 
 	ASSERT_EQ(-1, mknod(file1_s1d1, S_IFREG | 0700, 0));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(0, mknod(file1_s1d2, S_IFREG | 0700, 0));
 	ASSERT_EQ(0, unlink(file1_s1d2));
 
@@ -1108,12 +1108,12 @@ TEST_F_FORK(layout1, non_overlapping_accesses)
 
 	/* Unchanged accesses for file creation. */
 	ASSERT_EQ(-1, mknod(file1_s1d1, S_IFREG | 0700, 0));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(0, mknod(file1_s1d2, S_IFREG | 0700, 0));
 
 	/* Checks file removing. */
 	ASSERT_EQ(-1, unlink(file1_s1d2));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(0, unlink(file1_s1d3));
 }
 
@@ -1212,25 +1212,25 @@ TEST_F_FORK(layout1, interleaved_masked_accesses)
 	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_READ_FILE, layer1_read);
 
 	/* Checks that read access is granted for file1_s1d3 with layer 1. */
-	ASSERT_EQ(0, test_open(file1_s1d3, O_RDWR));
-	ASSERT_EQ(EACCES, test_open(file2_s1d3, O_RDONLY));
-	ASSERT_EQ(0, test_open(file2_s1d3, O_WRONLY));
+	EXPECT_EQ(0, test_open(file1_s1d3, O_RDWR));
+	EXPECT_EQ(EACCES, test_open(file2_s1d3, O_RDONLY));
+	EXPECT_EQ(0, test_open(file2_s1d3, O_WRONLY));
 
 	enforce_fs(_metadata,
 		   LANDLOCK_ACCESS_FS_READ_FILE | LANDLOCK_ACCESS_FS_WRITE_FILE,
 		   layer2_read_write);
 
 	/* Checks that previous access rights are unchanged with layer 2. */
-	ASSERT_EQ(0, test_open(file1_s1d3, O_RDWR));
-	ASSERT_EQ(EACCES, test_open(file2_s1d3, O_RDONLY));
-	ASSERT_EQ(0, test_open(file2_s1d3, O_WRONLY));
+	EXPECT_EQ(0, test_open(file1_s1d3, O_RDWR));
+	EXPECT_EQ(EACCES, test_open(file2_s1d3, O_RDONLY));
+	EXPECT_EQ(0, test_open(file2_s1d3, O_WRONLY));
 
 	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_READ_FILE, layer3_read);
 
 	/* Checks that previous access rights are unchanged with layer 3. */
-	ASSERT_EQ(0, test_open(file1_s1d3, O_RDWR));
-	ASSERT_EQ(EACCES, test_open(file2_s1d3, O_RDONLY));
-	ASSERT_EQ(0, test_open(file2_s1d3, O_WRONLY));
+	EXPECT_EQ(0, test_open(file1_s1d3, O_RDWR));
+	EXPECT_EQ(EACCES, test_open(file2_s1d3, O_RDONLY));
+	EXPECT_EQ(0, test_open(file2_s1d3, O_WRONLY));
 
 	/* This time, denies write access for the file hierarchy. */
 	enforce_fs(_metadata,
@@ -1241,36 +1241,36 @@ TEST_F_FORK(layout1, interleaved_masked_accesses)
 	 * Checks that the only change with layer 4 is that write access is
 	 * denied.
 	 */
-	ASSERT_EQ(0, test_open(file1_s1d3, O_RDONLY));
-	ASSERT_EQ(EACCES, test_open(file1_s1d3, O_WRONLY));
-	ASSERT_EQ(EACCES, test_open(file2_s1d3, O_RDONLY));
-	ASSERT_EQ(EACCES, test_open(file2_s1d3, O_WRONLY));
+	EXPECT_EQ(0, test_open(file1_s1d3, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d3, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(file2_s1d3, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(file2_s1d3, O_WRONLY));
 
 	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_READ_FILE, layer5_read);
 
 	/* Checks that previous access rights are unchanged with layer 5. */
-	ASSERT_EQ(0, test_open(file1_s1d3, O_RDONLY));
-	ASSERT_EQ(EACCES, test_open(file1_s1d3, O_WRONLY));
-	ASSERT_EQ(EACCES, test_open(file2_s1d3, O_WRONLY));
-	ASSERT_EQ(EACCES, test_open(file2_s1d3, O_RDONLY));
+	EXPECT_EQ(0, test_open(file1_s1d3, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d3, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(file2_s1d3, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(file2_s1d3, O_RDONLY));
 
 	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_EXECUTE, layer6_execute);
 
 	/* Checks that previous access rights are unchanged with layer 6. */
-	ASSERT_EQ(0, test_open(file1_s1d3, O_RDONLY));
-	ASSERT_EQ(EACCES, test_open(file1_s1d3, O_WRONLY));
-	ASSERT_EQ(EACCES, test_open(file2_s1d3, O_WRONLY));
-	ASSERT_EQ(EACCES, test_open(file2_s1d3, O_RDONLY));
+	EXPECT_EQ(0, test_open(file1_s1d3, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d3, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(file2_s1d3, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(file2_s1d3, O_RDONLY));
 
 	enforce_fs(_metadata,
 		   LANDLOCK_ACCESS_FS_READ_FILE | LANDLOCK_ACCESS_FS_WRITE_FILE,
 		   layer7_read_write);
 
 	/* Checks read access is now denied with layer 7. */
-	ASSERT_EQ(EACCES, test_open(file1_s1d3, O_RDONLY));
-	ASSERT_EQ(EACCES, test_open(file1_s1d3, O_WRONLY));
-	ASSERT_EQ(EACCES, test_open(file2_s1d3, O_WRONLY));
-	ASSERT_EQ(EACCES, test_open(file2_s1d3, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d3, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d3, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(file2_s1d3, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(file2_s1d3, O_RDONLY));
 }
 
 TEST_F_FORK(layout1, inherit_subset)
@@ -1287,18 +1287,18 @@ TEST_F_FORK(layout1, inherit_subset)
 
 	enforce_ruleset(_metadata, ruleset_fd);
 
-	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_WRONLY));
-	ASSERT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d1, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
 
 	/* Write access is forbidden. */
-	ASSERT_EQ(EACCES, test_open(file1_s1d2, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d2, O_WRONLY));
 	/* Readdir access is allowed. */
-	ASSERT_EQ(0, test_open(dir_s1d2, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(0, test_open(dir_s1d2, O_RDONLY | O_DIRECTORY));
 
 	/* Write access is forbidden. */
-	ASSERT_EQ(EACCES, test_open(file1_s1d3, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d3, O_WRONLY));
 	/* Readdir access is allowed. */
-	ASSERT_EQ(0, test_open(dir_s1d3, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(0, test_open(dir_s1d3, O_RDONLY | O_DIRECTORY));
 
 	/*
 	 * Tests shared rule extension: the following rules should not grant
@@ -1321,18 +1321,18 @@ TEST_F_FORK(layout1, inherit_subset)
 	enforce_ruleset(_metadata, ruleset_fd);
 
 	/* Same tests and results as above. */
-	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_WRONLY));
-	ASSERT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d1, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
 
 	/* It is still forbidden to write in file1_s1d2. */
-	ASSERT_EQ(EACCES, test_open(file1_s1d2, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d2, O_WRONLY));
 	/* Readdir access is still allowed. */
-	ASSERT_EQ(0, test_open(dir_s1d2, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(0, test_open(dir_s1d2, O_RDONLY | O_DIRECTORY));
 
 	/* It is still forbidden to write in file1_s1d3. */
-	ASSERT_EQ(EACCES, test_open(file1_s1d3, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d3, O_WRONLY));
 	/* Readdir access is still allowed. */
-	ASSERT_EQ(0, test_open(dir_s1d3, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(0, test_open(dir_s1d3, O_RDONLY | O_DIRECTORY));
 
 	/*
 	 * Try to get more privileges by adding new access rights to the parent
@@ -1342,18 +1342,18 @@ TEST_F_FORK(layout1, inherit_subset)
 	enforce_ruleset(_metadata, ruleset_fd);
 
 	/* Same tests and results as above. */
-	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_WRONLY));
-	ASSERT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d1, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
 
 	/* It is still forbidden to write in file1_s1d2. */
-	ASSERT_EQ(EACCES, test_open(file1_s1d2, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d2, O_WRONLY));
 	/* Readdir access is still allowed. */
-	ASSERT_EQ(0, test_open(dir_s1d2, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(0, test_open(dir_s1d2, O_RDONLY | O_DIRECTORY));
 
 	/* It is still forbidden to write in file1_s1d3. */
-	ASSERT_EQ(EACCES, test_open(file1_s1d3, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d3, O_WRONLY));
 	/* Readdir access is still allowed. */
-	ASSERT_EQ(0, test_open(dir_s1d3, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(0, test_open(dir_s1d3, O_RDONLY | O_DIRECTORY));
 
 	/*
 	 * Now, dir_s1d3 get a new rule tied to it, only allowing
@@ -1372,21 +1372,21 @@ TEST_F_FORK(layout1, inherit_subset)
 	 */
 
 	/* Same tests and results as above. */
-	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_WRONLY));
-	ASSERT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d1, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
 
 	/* It is still forbidden to write in file1_s1d2. */
-	ASSERT_EQ(EACCES, test_open(file1_s1d2, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d2, O_WRONLY));
 	/* Readdir access is still allowed. */
-	ASSERT_EQ(0, test_open(dir_s1d2, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(0, test_open(dir_s1d2, O_RDONLY | O_DIRECTORY));
 
 	/* It is still forbidden to write in file1_s1d3. */
-	ASSERT_EQ(EACCES, test_open(file1_s1d3, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d3, O_WRONLY));
 	/*
 	 * Readdir of dir_s1d3 is still allowed because of the OR policy inside
 	 * the same layer.
 	 */
-	ASSERT_EQ(0, test_open(dir_s1d3, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(0, test_open(dir_s1d3, O_RDONLY | O_DIRECTORY));
 }
 
 TEST_F_FORK(layout1, inherit_superset)
@@ -1403,11 +1403,11 @@ TEST_F_FORK(layout1, inherit_superset)
 	enforce_ruleset(_metadata, ruleset_fd);
 
 	/* Readdir access is denied for dir_s1d2. */
-	ASSERT_EQ(EACCES, test_open(dir_s1d2, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(EACCES, test_open(dir_s1d2, O_RDONLY | O_DIRECTORY));
 	/* Readdir access is allowed for dir_s1d3. */
-	ASSERT_EQ(0, test_open(dir_s1d3, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(0, test_open(dir_s1d3, O_RDONLY | O_DIRECTORY));
 	/* File access is allowed for file1_s1d3. */
-	ASSERT_EQ(0, test_open(file1_s1d3, O_RDONLY));
+	EXPECT_EQ(0, test_open(file1_s1d3, O_RDONLY));
 
 	/* Now dir_s1d2, parent of dir_s1d3, gets a new rule tied to it. */
 	add_path_beneath(_metadata, ruleset_fd,
@@ -1418,11 +1418,11 @@ TEST_F_FORK(layout1, inherit_superset)
 	EXPECT_EQ(0, close(ruleset_fd));
 
 	/* Readdir access is still denied for dir_s1d2. */
-	ASSERT_EQ(EACCES, test_open(dir_s1d2, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(EACCES, test_open(dir_s1d2, O_RDONLY | O_DIRECTORY));
 	/* Readdir access is still allowed for dir_s1d3. */
-	ASSERT_EQ(0, test_open(dir_s1d3, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(0, test_open(dir_s1d3, O_RDONLY | O_DIRECTORY));
 	/* File access is still allowed for file1_s1d3. */
-	ASSERT_EQ(0, test_open(file1_s1d3, O_RDONLY));
+	EXPECT_EQ(0, test_open(file1_s1d3, O_RDONLY));
 }
 
 TEST_F_FORK(layout0, max_layers)
@@ -1443,7 +1443,7 @@ TEST_F_FORK(layout0, max_layers)
 	for (i = 0; i < 2; i++) {
 		err = landlock_restrict_self(ruleset_fd, 0);
 		ASSERT_EQ(-1, err);
-		ASSERT_EQ(E2BIG, errno);
+		EXPECT_EQ(E2BIG, errno);
 	}
 	EXPECT_EQ(0, close(ruleset_fd));
 }
@@ -1457,20 +1457,20 @@ TEST_F_FORK(layout1, empty_or_same_ruleset)
 	ruleset_fd =
 		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
 	ASSERT_EQ(-1, ruleset_fd);
-	ASSERT_EQ(ENOMSG, errno);
+	EXPECT_EQ(ENOMSG, errno);
 
 	/* Enforces policy which denies read access to all files. */
 	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_READ_FILE, NULL);
 
-	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_RDONLY));
-	ASSERT_EQ(0, test_open(dir_s1d1, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d1, O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s1d1, O_RDONLY));
 
 	/* Nests a policy which denies read access to all directories. */
 	ruleset_fd =
 		create_ruleset(_metadata, LANDLOCK_ACCESS_FS_READ_DIR, NULL);
 	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_RDONLY));
-	ASSERT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d1, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY));
 
 	/* Enforces a second time with the same ruleset. */
 	enforce_ruleset(_metadata, ruleset_fd);
@@ -1494,13 +1494,13 @@ TEST_F_FORK(layout1, rule_on_mountpoint)
 
 	enforce_fs(_metadata, ACCESS_RW, rules);
 
-	ASSERT_EQ(0, test_open(dir_s1d1, O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s1d1, O_RDONLY));
 
-	ASSERT_EQ(EACCES, test_open(dir_s2d1, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(dir_s2d1, O_RDONLY));
 
-	ASSERT_EQ(EACCES, test_open(dir_s3d1, O_RDONLY));
-	ASSERT_EQ(0, test_open(dir_s3d2, O_RDONLY));
-	ASSERT_EQ(0, test_open(dir_s3d3, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(dir_s3d1, O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s3d2, O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s3d3, O_RDONLY));
 }
 
 TEST_F_FORK(layout1, rule_over_mountpoint)
@@ -1520,13 +1520,13 @@ TEST_F_FORK(layout1, rule_over_mountpoint)
 
 	enforce_fs(_metadata, ACCESS_RW, rules);
 
-	ASSERT_EQ(0, test_open(dir_s1d1, O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s1d1, O_RDONLY));
 
-	ASSERT_EQ(EACCES, test_open(dir_s2d1, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(dir_s2d1, O_RDONLY));
 
-	ASSERT_EQ(0, test_open(dir_s3d1, O_RDONLY));
-	ASSERT_EQ(0, test_open(dir_s3d2, O_RDONLY));
-	ASSERT_EQ(0, test_open(dir_s3d3, O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s3d1, O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s3d2, O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s3d3, O_RDONLY));
 }
 
 /*
@@ -1546,15 +1546,15 @@ TEST_F_FORK(layout1, rule_over_root_allow_then_deny)
 	enforce_fs(_metadata, ACCESS_RW, rules);
 
 	/* Checks allowed access. */
-	ASSERT_EQ(0, test_open("/", O_RDONLY));
-	ASSERT_EQ(0, test_open(dir_s1d1, O_RDONLY));
+	EXPECT_EQ(0, test_open("/", O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s1d1, O_RDONLY));
 
 	rules[0].access = LANDLOCK_ACCESS_FS_READ_FILE;
 	enforce_fs(_metadata, ACCESS_RW, rules);
 
 	/* Checks denied access (on a directory). */
-	ASSERT_EQ(EACCES, test_open("/", O_RDONLY));
-	ASSERT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open("/", O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY));
 }
 
 TEST_F_FORK(layout1, rule_over_root_deny)
@@ -1570,8 +1570,8 @@ TEST_F_FORK(layout1, rule_over_root_deny)
 	enforce_fs(_metadata, ACCESS_RW, rules);
 
 	/* Checks denied access (on a directory). */
-	ASSERT_EQ(EACCES, test_open("/", O_RDONLY));
-	ASSERT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open("/", O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY));
 }
 
 TEST_F_FORK(layout1, rule_inside_mount_ns)
@@ -1594,8 +1594,8 @@ TEST_F_FORK(layout1, rule_inside_mount_ns)
 
 	enforce_fs(_metadata, ACCESS_RW, rules);
 
-	ASSERT_EQ(0, test_open("s3d3", O_RDONLY));
-	ASSERT_EQ(EACCES, test_open("/", O_RDONLY));
+	EXPECT_EQ(0, test_open("s3d3", O_RDONLY));
+	EXPECT_EQ(EACCES, test_open("/", O_RDONLY));
 }
 
 TEST_F_FORK(layout1, mount_and_pivot)
@@ -1612,9 +1612,9 @@ TEST_F_FORK(layout1, mount_and_pivot)
 
 	set_cap(_metadata, CAP_SYS_ADMIN);
 	ASSERT_EQ(-1, mount(NULL, dir_s3d2, NULL, MS_RDONLY, NULL));
-	ASSERT_EQ(EPERM, errno);
+	EXPECT_EQ(EPERM, errno);
 	ASSERT_EQ(-1, syscall(__NR_pivot_root, dir_s3d2, dir_s3d3));
-	ASSERT_EQ(EPERM, errno);
+	EXPECT_EQ(EPERM, errno);
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 }
 
@@ -1644,7 +1644,7 @@ TEST_F_FORK(layout1, move_mount)
 	set_cap(_metadata, CAP_SYS_ADMIN);
 	ASSERT_EQ(-1, syscall(__NR_move_mount, AT_FDCWD, dir_s3d2, AT_FDCWD,
 			      dir_s1d2, 0));
-	ASSERT_EQ(EPERM, errno);
+	EXPECT_EQ(EPERM, errno);
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 }
 
@@ -1684,16 +1684,16 @@ TEST_F_FORK(layout1, topology_changes_with_net_and_fs)
 	/* Mount, remount, move_mount, umount, and pivot_root checks. */
 	set_cap(_metadata, CAP_SYS_ADMIN);
 	ASSERT_EQ(-1, mount_opt(&mnt_tmp, dir_s1d2));
-	ASSERT_EQ(EPERM, errno);
+	EXPECT_EQ(EPERM, errno);
 	ASSERT_EQ(-1, mount(NULL, dir_s3d2, NULL, MS_PRIVATE | MS_REC, NULL));
-	ASSERT_EQ(EPERM, errno);
+	EXPECT_EQ(EPERM, errno);
 	ASSERT_EQ(-1, syscall(__NR_move_mount, AT_FDCWD, dir_s3d2, AT_FDCWD,
 			      dir_s2d2, 0));
-	ASSERT_EQ(EPERM, errno);
+	EXPECT_EQ(EPERM, errno);
 	ASSERT_EQ(-1, umount(dir_s3d2));
-	ASSERT_EQ(EPERM, errno);
+	EXPECT_EQ(EPERM, errno);
 	ASSERT_EQ(-1, syscall(__NR_pivot_root, dir_s3d2, dir_s3d3));
-	ASSERT_EQ(EPERM, errno);
+	EXPECT_EQ(EPERM, errno);
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 }
 
@@ -1724,10 +1724,10 @@ TEST_F_FORK(layout1, release_inodes)
 	enforce_ruleset(_metadata, ruleset_fd);
 	EXPECT_EQ(0, close(ruleset_fd));
 
-	ASSERT_EQ(0, test_open(file1_s1d1, O_RDONLY));
-	ASSERT_EQ(EACCES, test_open(dir_s3d2, O_RDONLY));
+	EXPECT_EQ(0, test_open(file1_s1d1, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(dir_s3d2, O_RDONLY));
 	/* This dir_s3d3 would not be allowed and does not exist anyway. */
-	ASSERT_EQ(ENOENT, test_open(dir_s3d3, O_RDONLY));
+	EXPECT_EQ(ENOENT, test_open(dir_s3d3, O_RDONLY));
 }
 
 /*
@@ -1760,13 +1760,13 @@ TEST_F_FORK(layout1, covered_rule)
 	ASSERT_EQ(0, mount_opt(&mnt_tmp, dir_s3d2));
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 
-	ASSERT_EQ(0, test_open(dir_s3d2, O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s3d2, O_RDONLY));
 
 	enforce_ruleset(_metadata, ruleset_fd);
 	EXPECT_EQ(0, close(ruleset_fd));
 
 	/* Checks that access to the new mount point is denied. */
-	ASSERT_EQ(EACCES, test_open(dir_s3d2, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(dir_s3d2, O_RDONLY));
 }
 
 enum relative_access {
@@ -1853,35 +1853,35 @@ static void test_relative_path(struct __test_metadata *const _metadata,
 		break;
 	}
 
-	ASSERT_EQ((rel == REL_CHROOT_CHDIR) ? 0 : EACCES,
+	EXPECT_EQ((rel == REL_CHROOT_CHDIR) ? 0 : EACCES,
 		  test_open_rel(dirfd, "..", O_RDONLY));
-	ASSERT_EQ(0, test_open_rel(dirfd, ".", O_RDONLY));
+	EXPECT_EQ(0, test_open_rel(dirfd, ".", O_RDONLY));
 
 	if (rel == REL_CHROOT_ONLY) {
 		/* The current directory is dir_s2d2. */
-		ASSERT_EQ(0, test_open_rel(dirfd, "./s2d3", O_RDONLY));
+		EXPECT_EQ(0, test_open_rel(dirfd, "./s2d3", O_RDONLY));
 	} else {
 		/* The current directory is dir_s1d2. */
-		ASSERT_EQ(0, test_open_rel(dirfd, "./s1d3", O_RDONLY));
+		EXPECT_EQ(0, test_open_rel(dirfd, "./s1d3", O_RDONLY));
 	}
 
 	if (rel == REL_CHROOT_ONLY || rel == REL_CHROOT_CHDIR) {
 		/* Checks the root dir_s1d2. */
-		ASSERT_EQ(0, test_open_rel(dirfd, "/..", O_RDONLY));
-		ASSERT_EQ(0, test_open_rel(dirfd, "/", O_RDONLY));
-		ASSERT_EQ(0, test_open_rel(dirfd, "/f1", O_RDONLY));
-		ASSERT_EQ(0, test_open_rel(dirfd, "/s1d3", O_RDONLY));
+		EXPECT_EQ(0, test_open_rel(dirfd, "/..", O_RDONLY));
+		EXPECT_EQ(0, test_open_rel(dirfd, "/", O_RDONLY));
+		EXPECT_EQ(0, test_open_rel(dirfd, "/f1", O_RDONLY));
+		EXPECT_EQ(0, test_open_rel(dirfd, "/s1d3", O_RDONLY));
 	}
 
 	if (rel != REL_CHROOT_CHDIR) {
-		ASSERT_EQ(EACCES, test_open_rel(dirfd, "../../s1d1", O_RDONLY));
-		ASSERT_EQ(0, test_open_rel(dirfd, "../../s1d1/s1d2", O_RDONLY));
-		ASSERT_EQ(0, test_open_rel(dirfd, "../../s1d1/s1d2/s1d3",
+		EXPECT_EQ(EACCES, test_open_rel(dirfd, "../../s1d1", O_RDONLY));
+		EXPECT_EQ(0, test_open_rel(dirfd, "../../s1d1/s1d2", O_RDONLY));
+		EXPECT_EQ(0, test_open_rel(dirfd, "../../s1d1/s1d2/s1d3",
 					   O_RDONLY));
 
-		ASSERT_EQ(EACCES, test_open_rel(dirfd, "../../s2d1", O_RDONLY));
-		ASSERT_EQ(0, test_open_rel(dirfd, "../../s2d1/s2d2", O_RDONLY));
-		ASSERT_EQ(0, test_open_rel(dirfd, "../../s2d1/s2d2/s2d3",
+		EXPECT_EQ(EACCES, test_open_rel(dirfd, "../../s2d1", O_RDONLY));
+		EXPECT_EQ(0, test_open_rel(dirfd, "../../s2d1/s2d2", O_RDONLY));
+		EXPECT_EQ(0, test_open_rel(dirfd, "../../s2d1/s2d2/s2d3",
 					   O_RDONLY));
 	}
 
@@ -1953,7 +1953,7 @@ static void test_execute(struct __test_metadata *const _metadata, const int err,
 	}
 	ASSERT_EQ(child, waitpid(child, &status, 0));
 	ASSERT_EQ(1, WIFEXITED(status));
-	ASSERT_EQ(err ? 2 : 0, WEXITSTATUS(status))
+	EXPECT_EQ(err ? 2 : 0, WEXITSTATUS(status))
 	{
 		TH_LOG("Unexpected return code for \"%s\"", path);
 	};
@@ -1995,18 +1995,18 @@ TEST_F_FORK(layout1, execute)
 
 	enforce_fs(_metadata, rules[0].access, rules);
 
-	ASSERT_EQ(0, test_open(dir_s1d1, O_RDONLY));
-	ASSERT_EQ(0, test_open(file1_s1d1, O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s1d1, O_RDONLY));
+	EXPECT_EQ(0, test_open(file1_s1d1, O_RDONLY));
 	test_execute(_metadata, EACCES, file1_s1d1);
 	test_check_exec(_metadata, EACCES, file1_s1d1);
 
-	ASSERT_EQ(0, test_open(dir_s1d2, O_RDONLY));
-	ASSERT_EQ(0, test_open(file1_s1d2, O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s1d2, O_RDONLY));
+	EXPECT_EQ(0, test_open(file1_s1d2, O_RDONLY));
 	test_execute(_metadata, 0, file1_s1d2);
 	test_check_exec(_metadata, 0, file1_s1d2);
 
-	ASSERT_EQ(0, test_open(dir_s1d3, O_RDONLY));
-	ASSERT_EQ(0, test_open(file1_s1d3, O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s1d3, O_RDONLY));
+	EXPECT_EQ(0, test_open(file1_s1d3, O_RDONLY));
 	test_execute(_metadata, 0, file1_s1d3);
 	test_check_exec(_metadata, 0, file1_s1d3);
 }
@@ -2085,7 +2085,7 @@ TEST_F_FORK(layout1, umount_sandboxer)
 	EXPECT_EQ(1, write(pipe_parent[1], ".", 1));
 	ASSERT_EQ(child, waitpid(child, &status, 0));
 	ASSERT_EQ(1, WIFEXITED(status));
-	ASSERT_EQ(0, WEXITSTATUS(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
 }
 
 TEST_F_FORK(layout1, link)
@@ -2112,15 +2112,15 @@ TEST_F_FORK(layout1, link)
 	enforce_fs(_metadata, layer1[0].access, layer1);
 
 	ASSERT_EQ(-1, link(file2_s1d1, file1_s1d1));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 
 	/* Denies linking because of reparenting. */
 	ASSERT_EQ(-1, link(file1_s2d1, file1_s1d2));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 	ASSERT_EQ(-1, link(file2_s1d2, file1_s1d3));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 	ASSERT_EQ(-1, link(file2_s1d3, file1_s1d2));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 
 	ASSERT_EQ(0, link(file2_s1d2, file1_s1d2));
 	ASSERT_EQ(0, link(file2_s1d3, file1_s1d3));
@@ -2189,47 +2189,47 @@ TEST_F_FORK(layout1, rename_file)
 	 * but to a different directory (which also allows file removal).
 	 */
 	ASSERT_EQ(-1, rename(file1_s2d3, file1_s1d3));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s2d3, AT_FDCWD, file1_s1d3,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s2d3, AT_FDCWD, dir_s1d3,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 
 	/*
 	 * Tries to replace a file, from a directory that denies file removal,
 	 * to a different directory (which allows file removal).
 	 */
 	ASSERT_EQ(-1, rename(file1_s2d1, file1_s1d3));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s2d1, AT_FDCWD, file1_s1d3,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, dir_s2d2, AT_FDCWD, file1_s1d3,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 
 	/* Exchanges files and directories that partially allow removal. */
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, dir_s2d2, AT_FDCWD, file1_s2d1,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	/* Checks that file1_s2d1 cannot be removed (instead of ENOTDIR). */
 	ASSERT_EQ(-1, rename(dir_s2d2, file1_s2d1));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s2d1, AT_FDCWD, dir_s2d2,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	/* Checks that file1_s1d1 cannot be removed (instead of EISDIR). */
 	ASSERT_EQ(-1, rename(file1_s1d1, dir_s1d2));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 
 	/* Renames files with different parents. */
 	ASSERT_EQ(-1, rename(file1_s2d2, file1_s1d2));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 	ASSERT_EQ(0, unlink(file1_s1d3));
 	ASSERT_EQ(-1, rename(file1_s2d1, file1_s1d3));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 
 	/* Exchanges and renames files with same parent. */
 	ASSERT_EQ(0, renameat2(AT_FDCWD, file2_s2d3, AT_FDCWD, file1_s2d3,
@@ -2437,12 +2437,12 @@ TEST_F_FORK(layout1, rename_dir)
 	/* Exchanges and renames directory to a different parent. */
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, dir_s2d3, AT_FDCWD, dir_s1d3,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 	ASSERT_EQ(-1, rename(dir_s2d3, dir_s1d3));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s2d2, AT_FDCWD, dir_s1d3,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 
 	/*
 	 * Exchanges directory to the same parent, which doesn't allow
@@ -2450,16 +2450,16 @@ TEST_F_FORK(layout1, rename_dir)
 	 */
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, dir_s1d1, AT_FDCWD, dir_s2d1,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	/* Checks that dir_s1d2 cannot be removed (instead of ENOTDIR). */
 	ASSERT_EQ(-1, rename(dir_s1d2, file1_s1d1));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s1d1, AT_FDCWD, dir_s1d2,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	/* Checks that dir_s1d2 cannot be removed (instead of EISDIR). */
 	ASSERT_EQ(-1, rename(file1_s1d1, dir_s1d2));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 
 	/*
 	 * Exchanges and renames directory to the same parent, which allows
@@ -2490,22 +2490,22 @@ TEST_F_FORK(layout1, reparent_refer)
 	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_REFER, layer1);
 
 	ASSERT_EQ(-1, rename(dir_s1d2, dir_s2d1));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 	ASSERT_EQ(-1, rename(dir_s1d2, dir_s2d2));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 	ASSERT_EQ(-1, rename(dir_s1d2, dir_s2d3));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 
 	ASSERT_EQ(-1, rename(dir_s1d3, dir_s2d1));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 	ASSERT_EQ(-1, rename(dir_s1d3, dir_s2d2));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 	/*
 	 * Moving should only be allowed when the source and the destination
 	 * parent directory have REFER.
 	 */
 	ASSERT_EQ(-1, rename(dir_s1d3, dir_s2d3));
-	ASSERT_EQ(ENOTEMPTY, errno);
+	EXPECT_EQ(ENOTEMPTY, errno);
 	ASSERT_EQ(0, unlink(file1_s2d3));
 	ASSERT_EQ(0, unlink(file2_s2d3));
 	ASSERT_EQ(0, rename(dir_s1d3, dir_s2d3));
@@ -2704,27 +2704,27 @@ TEST_F_FORK(layout1, reparent_link)
 
 	/* Denies linking because of missing MAKE_REG. */
 	ASSERT_EQ(-1, link(file2_s1d1, file1_s1d1));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	/* Denies linking because of missing source and destination REFER. */
 	ASSERT_EQ(-1, link(file1_s2d1, file1_s1d2));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 	/* Denies linking because of missing source REFER. */
 	ASSERT_EQ(-1, link(file1_s2d1, file1_s1d3));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 
 	/* Denies linking because of missing MAKE_REG. */
 	ASSERT_EQ(-1, link(file1_s2d2, file1_s1d1));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	/* Denies linking because of missing destination REFER. */
 	ASSERT_EQ(-1, link(file1_s2d2, file1_s1d2));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 
 	/* Allows linking because of REFER and MAKE_REG. */
 	ASSERT_EQ(0, link(file1_s2d2, file1_s1d3));
 	ASSERT_EQ(0, unlink(file1_s2d2));
 	/* Reverse linking denied because of missing MAKE_REG. */
 	ASSERT_EQ(-1, link(file1_s1d3, file1_s2d2));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(0, unlink(file1_s2d3));
 	/* Checks reverse linking. */
 	ASSERT_EQ(0, link(file1_s1d3, file1_s2d3));
@@ -2738,9 +2738,9 @@ TEST_F_FORK(layout1, reparent_link)
 	ASSERT_EQ(0, unlink(file1_s1d3));
 
 	ASSERT_EQ(-1, link(file2_s1d2, file1_s1d3));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 	ASSERT_EQ(-1, link(file2_s1d3, file1_s1d2));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 
 	ASSERT_EQ(0, link(file2_s1d2, file1_s1d2));
 	ASSERT_EQ(0, link(file2_s1d3, file1_s1d3));
@@ -2779,57 +2779,57 @@ TEST_F_FORK(layout1, reparent_rename)
 	/* Denies renaming because of missing MAKE_REG. */
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, file2_s1d1, AT_FDCWD, file1_s1d1,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s1d1, AT_FDCWD, file2_s1d1,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(0, unlink(file1_s1d1));
 	ASSERT_EQ(-1, rename(file2_s1d1, file1_s1d1));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	/* Even denies same file exchange. */
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, file2_s1d1, AT_FDCWD, file2_s1d1,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 
 	/* Denies renaming because of missing source and destination REFER. */
 	ASSERT_EQ(-1, rename(file1_s2d1, file1_s1d2));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 	/*
 	 * Denies renaming because of missing MAKE_REG, source and destination
 	 * REFER.
 	 */
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s2d1, AT_FDCWD, file2_s1d1,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, file2_s1d1, AT_FDCWD, file1_s2d1,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 
 	/* Denies renaming because of missing source REFER. */
 	ASSERT_EQ(-1, rename(file1_s2d1, file1_s1d3));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 	/* Denies renaming because of missing MAKE_REG. */
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s2d1, AT_FDCWD, file2_s1d3,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 
 	/* Denies renaming because of missing MAKE_REG. */
 	ASSERT_EQ(-1, rename(file1_s2d2, file1_s1d1));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	/* Denies renaming because of missing destination REFER*/
 	ASSERT_EQ(-1, rename(file1_s2d2, file1_s1d2));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 
 	/* Denies exchange because of one missing MAKE_REG. */
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s2d2, AT_FDCWD, file2_s1d3,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	/* Allows renaming because of REFER and MAKE_REG. */
 	ASSERT_EQ(0, rename(file1_s2d2, file1_s1d3));
 
 	/* Reverse renaming denied because of missing MAKE_REG. */
 	ASSERT_EQ(-1, rename(file1_s1d3, file1_s2d2));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(0, unlink(file1_s2d3));
 	ASSERT_EQ(0, rename(file1_s1d3, file1_s2d3));
 
@@ -2861,17 +2861,17 @@ TEST_F_FORK(layout1, reparent_rename)
 	 */
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s2d3, AT_FDCWD, dir_s1d3,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, dir_s1d3, AT_FDCWD, file1_s2d3,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 	ASSERT_EQ(-1, rename(file1_s2d3, dir_s1d3));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 
 	ASSERT_EQ(-1, rename(file2_s1d2, file1_s1d3));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 	ASSERT_EQ(-1, rename(file2_s1d3, file1_s1d2));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 
 	/* Renaming in the same directory is always allowed. */
 	ASSERT_EQ(0, rename(file2_s1d2, file1_s1d2));
@@ -2880,12 +2880,12 @@ TEST_F_FORK(layout1, reparent_rename)
 	ASSERT_EQ(0, unlink(file1_s1d2));
 	/* Denies because of missing source MAKE_REG and destination REFER. */
 	ASSERT_EQ(-1, rename(dir_s2d3, file1_s1d2));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 
 	ASSERT_EQ(0, unlink(file1_s1d3));
 	/* Denies because of missing source MAKE_REG and REFER. */
 	ASSERT_EQ(-1, rename(dir_s2d2, file1_s1d3));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 }
 
 static void
@@ -2969,14 +2969,14 @@ TEST_F_FORK(layout1, reparent_exdev_layers_rename1)
 	 * MAKE_DIR is not tied to dir_s2d2.
 	 */
 	ASSERT_EQ(-1, rename(dir_s1d3, file1_s2d2));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 
 	/*
 	 * Moving the dir_s1d3 directory below dir_s2d3 is forbidden because it
 	 * would grants MAKE_REG and MAKE_DIR rights to it.
 	 */
 	ASSERT_EQ(-1, rename(dir_s1d3, file1_s2d3));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 
 	/*
 	 * Moving the file2_s1d3 file below dir_s2d3 is denied because the
@@ -2984,7 +2984,7 @@ TEST_F_FORK(layout1, reparent_exdev_layers_rename1)
 	 * default.
 	 */
 	ASSERT_EQ(-1, rename(file2_s1d3, file1_s2d3));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 }
 
 TEST_F_FORK(layout1, reparent_exdev_layers_rename2)
@@ -2993,42 +2993,42 @@ TEST_F_FORK(layout1, reparent_exdev_layers_rename2)
 
 	/* Checks EACCES predominance over EXDEV. */
 	ASSERT_EQ(-1, rename(file1_s1d1, file1_s2d2));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, rename(file1_s1d2, file1_s2d2));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, rename(file1_s1d1, file1_s2d3));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 	/* Modify layout! */
 	ASSERT_EQ(0, rename(file1_s1d2, file1_s2d3));
 
 	/* Without REFER source. */
 	ASSERT_EQ(-1, rename(dir_s1d1, file1_s2d2));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 	ASSERT_EQ(-1, rename(dir_s1d2, file1_s2d2));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 
 	reparent_exdev_layers_enforce2(_metadata);
 
 	/* Checks EACCES predominance over EXDEV. */
 	ASSERT_EQ(-1, rename(file1_s1d1, file1_s2d2));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	/* Checks with actual file2_s1d2. */
 	ASSERT_EQ(-1, rename(file2_s1d2, file1_s2d2));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, rename(file1_s1d1, file1_s2d3));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 	/*
 	 * Modifying the layout is now denied because the second layer does not
 	 * handle REFER, which is always denied by default.
 	 */
 	ASSERT_EQ(-1, rename(file2_s1d2, file1_s2d3));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 
 	/* Without REFER source, EACCES wins over EXDEV. */
 	ASSERT_EQ(-1, rename(dir_s1d1, file1_s2d2));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, rename(dir_s1d2, file1_s2d2));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 }
 
 TEST_F_FORK(layout1, reparent_exdev_layers_exchange1)
@@ -3046,10 +3046,10 @@ TEST_F_FORK(layout1, reparent_exdev_layers_exchange1)
 	/* Error predominance with file exchange: returns EXDEV and EACCES. */
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s1d1, AT_FDCWD, file1_s2d3,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s2d3, AT_FDCWD, file1_s1d1,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 
 	/*
 	 * Checks with directories which creation could be allowed, but denied
@@ -3057,10 +3057,10 @@ TEST_F_FORK(layout1, reparent_exdev_layers_exchange1)
 	 */
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, dir_file1_s1d2, AT_FDCWD,
 				dir_file2_s2d3, RENAME_EXCHANGE));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, dir_file2_s2d3, AT_FDCWD,
 				dir_file1_s1d2, RENAME_EXCHANGE));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 
 	/* Checks with same access rights. */
 	ASSERT_EQ(0, renameat2(AT_FDCWD, dir_s1d3, AT_FDCWD, dir_s2d3,
@@ -3093,46 +3093,46 @@ TEST_F_FORK(layout1, reparent_exdev_layers_exchange1)
 	 */
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, dir_file2_s2d3, AT_FDCWD, file1_s2d2,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s2d2, AT_FDCWD, dir_file2_s2d3,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 
 	reparent_exdev_layers_enforce2(_metadata);
 
 	/* Error predominance with file exchange: returns EXDEV and EACCES. */
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s1d1, AT_FDCWD, file1_s2d3,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s2d3, AT_FDCWD, file1_s1d1,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 
 	/* Checks with directories which creation is now denied. */
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, dir_file1_s1d2, AT_FDCWD,
 				dir_file2_s2d3, RENAME_EXCHANGE));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, dir_file2_s2d3, AT_FDCWD,
 				dir_file1_s1d2, RENAME_EXCHANGE));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 
 	/* Checks with different (child-only) access rights. */
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, dir_s1d3, AT_FDCWD, dir_s2d3,
 				RENAME_EXCHANGE));
 	/* Denied because of MAKE_DIR. */
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, dir_s2d3, AT_FDCWD, dir_s1d3,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 
 	/* Checks with different (child-only) access rights. */
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, dir_s2d3, AT_FDCWD, dir_file1_s1d2,
 				RENAME_EXCHANGE));
 	/* Denied because of MAKE_DIR. */
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, dir_file1_s1d2, AT_FDCWD, dir_s2d3,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 
 	/* See layout1.reparent_exdev_layers_exchange2 for complement. */
 }
@@ -3150,10 +3150,10 @@ TEST_F_FORK(layout1, reparent_exdev_layers_exchange2)
 	/* Checks that exchange between file and directory are consistent. */
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s2d2, AT_FDCWD, dir_file2_s2d3,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, dir_file2_s2d3, AT_FDCWD, file1_s2d2,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 }
 
 TEST_F_FORK(layout1, reparent_exdev_layers_exchange3)
@@ -3174,10 +3174,10 @@ TEST_F_FORK(layout1, reparent_exdev_layers_exchange3)
 			       RENAME_EXCHANGE));
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s2d2, AT_FDCWD, dir_file2_s2d3,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, dir_file2_s2d3, AT_FDCWD, file1_s2d2,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 }
 
 TEST_F_FORK(layout1, reparent_remove)
@@ -3207,23 +3207,23 @@ TEST_F_FORK(layout1, reparent_remove)
 
 	/* Access denied because of wrong/swapped remove file/dir. */
 	ASSERT_EQ(-1, rename(file1_s1d1, dir_s2d2));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, rename(dir_s2d2, file1_s1d1));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s1d1, AT_FDCWD, dir_s2d2,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s1d1, AT_FDCWD, dir_s2d3,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 
 	/* Access allowed thanks to the matching rights. */
 	ASSERT_EQ(-1, rename(file1_s2d1, dir_s1d2));
-	ASSERT_EQ(EISDIR, errno);
+	EXPECT_EQ(EISDIR, errno);
 	ASSERT_EQ(-1, rename(dir_s1d2, file1_s2d1));
-	ASSERT_EQ(ENOTDIR, errno);
+	EXPECT_EQ(ENOTDIR, errno);
 	ASSERT_EQ(-1, rename(dir_s1d3, file1_s2d1));
-	ASSERT_EQ(ENOTDIR, errno);
+	EXPECT_EQ(ENOTDIR, errno);
 	ASSERT_EQ(0, unlink(file1_s2d1));
 	ASSERT_EQ(0, unlink(file1_s1d3));
 	ASSERT_EQ(0, unlink(file2_s1d3));
@@ -3235,7 +3235,7 @@ TEST_F_FORK(layout1, reparent_remove)
 			       RENAME_EXCHANGE));
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s2d2, AT_FDCWD, dir_s1d3,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 }
 
 TEST_F_FORK(layout1, reparent_dom_superset)
@@ -3276,13 +3276,13 @@ TEST_F_FORK(layout1, reparent_dom_superset)
 		   layer1);
 
 	ASSERT_EQ(-1, rename(file1_s1d2, file1_s2d1));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 	/*
 	 * Moving file1_s1d2 beneath dir_s2d3 would grant it the READ_FILE
 	 * access right.
 	 */
 	ASSERT_EQ(-1, rename(file1_s1d2, file1_s2d3));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 	/*
 	 * Moving file1_s1d2 should be allowed even if dir_s2d2 grants a
 	 * superset of access rights compared to dir_s1d2, because file1_s1d2
@@ -3292,13 +3292,13 @@ TEST_F_FORK(layout1, reparent_dom_superset)
 	ASSERT_EQ(0, rename(file1_s2d2, file1_s1d2));
 
 	ASSERT_EQ(-1, rename(dir_s1d3, file1_s2d1));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 	/*
 	 * Moving dir_s1d3 beneath dir_s2d3 would grant it the MAKE_FIFO access
 	 * right.
 	 */
 	ASSERT_EQ(-1, rename(dir_s1d3, file1_s2d3));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 	/*
 	 * Moving dir_s1d3 should be allowed even if dir_s2d2 grants a superset
 	 * of access rights compared to dir_s1d2, because dir_s1d3 already has
@@ -3315,7 +3315,7 @@ TEST_F_FORK(layout1, reparent_dom_superset)
 	 */
 	ASSERT_EQ(0, rename(file1_s2d3, file2_s1d2));
 	ASSERT_EQ(-1, rename(file2_s1d2, file1_s2d3));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 	ASSERT_EQ(0, unlink(file2_s1d2));
 	ASSERT_EQ(0, unlink(file2_s2d3));
 	/*
@@ -3324,7 +3324,7 @@ TEST_F_FORK(layout1, reparent_dom_superset)
 	 */
 	ASSERT_EQ(0, rename(dir_s2d3, file2_s1d2));
 	ASSERT_EQ(-1, rename(file2_s1d2, dir_s2d3));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 }
 
 TEST_F_FORK(layout1, remove_dir)
@@ -3350,13 +3350,13 @@ TEST_F_FORK(layout1, remove_dir)
 
 	/* dir_s1d2 itself cannot be removed. */
 	ASSERT_EQ(-1, rmdir(dir_s1d2));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, unlinkat(AT_FDCWD, dir_s1d2, AT_REMOVEDIR));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, rmdir(dir_s1d1));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, unlinkat(AT_FDCWD, dir_s1d1, AT_REMOVEDIR));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 }
 
 TEST_F_FORK(layout1, remove_file)
@@ -3372,9 +3372,9 @@ TEST_F_FORK(layout1, remove_file)
 	enforce_fs(_metadata, rules[0].access, rules);
 
 	ASSERT_EQ(-1, unlink(file1_s1d1));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, unlinkat(AT_FDCWD, file1_s1d1, 0));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(0, unlink(file1_s1d2));
 	ASSERT_EQ(0, unlinkat(AT_FDCWD, file1_s1d3, 0));
 }
@@ -3408,11 +3408,11 @@ static void test_make_file(struct __test_metadata *const _metadata,
 	enforce_fs(_metadata, access, rules);
 
 	ASSERT_EQ(-1, mknod(file1_s1d1, mode | 0400, dev));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, link(file2_s1d1, file1_s1d1));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, rename(file2_s1d1, file1_s1d1));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 
 	ASSERT_EQ(0, mknod(file1_s1d2, mode | 0400, dev))
 	{
@@ -3500,11 +3500,11 @@ TEST_F_FORK(layout1, make_sym)
 	enforce_fs(_metadata, rules[0].access, rules);
 
 	ASSERT_EQ(-1, symlink("none", file1_s1d1));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, link(file2_s1d1, file1_s1d1));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, rename(file2_s1d1, file1_s1d1));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 
 	ASSERT_EQ(0, symlink("none", file1_s1d2));
 	ASSERT_EQ(0, link(file1_s1d2, file2_s1d2));
@@ -3535,7 +3535,7 @@ TEST_F_FORK(layout1, make_dir)
 
 	/* Uses file_* as directory names. */
 	ASSERT_EQ(-1, mkdir(file1_s1d1, 0700));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(0, mkdir(file1_s1d2, 0700));
 	ASSERT_EQ(0, mkdir(file1_s1d3, 0700));
 }
@@ -3567,8 +3567,8 @@ TEST_F_FORK(layout1, proc_unlinked_file)
 		   LANDLOCK_ACCESS_FS_READ_FILE | LANDLOCK_ACCESS_FS_WRITE_FILE,
 		   rules);
 
-	ASSERT_EQ(EACCES, test_open(file1_s1d2, O_RDWR));
-	ASSERT_EQ(0, test_open(file1_s1d2, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d2, O_RDWR));
+	EXPECT_EQ(0, test_open(file1_s1d2, O_RDONLY));
 	reg_fd = open(file1_s1d2, O_RDONLY | O_CLOEXEC);
 	ASSERT_LE(0, reg_fd);
 	ASSERT_EQ(0, unlink(file1_s1d2));
@@ -3583,7 +3583,7 @@ TEST_F_FORK(layout1, proc_unlinked_file)
 		TH_LOG("Successfully opened /proc/self/fd/%d: %s", reg_fd,
 		       strerror(errno));
 	}
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 
 	EXPECT_EQ(0, close(reg_fd));
 }
@@ -3606,8 +3606,8 @@ TEST_F_FORK(layout1, proc_pipe)
 	enforce_fs(_metadata, rules[0].access, rules);
 
 	/* Checks enforcement for normal files. */
-	ASSERT_EQ(0, test_open(file1_s1d2, O_RDWR));
-	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_RDWR));
+	EXPECT_EQ(0, test_open(file1_s1d2, O_RDWR));
+	EXPECT_EQ(EACCES, test_open(file1_s1d1, O_RDWR));
 
 	/* Checks access to pipes through FD. */
 	ASSERT_EQ(0, pipe2(pipe_fds, O_CLOEXEC));
@@ -4052,7 +4052,7 @@ TEST_F_FORK(ftruncate, open_and_ftruncate_in_different_processes)
 
 	ASSERT_EQ(child, waitpid(child, &status, 0));
 	ASSERT_EQ(1, WIFEXITED(status));
-	ASSERT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
+	EXPECT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
 
 	EXPECT_EQ(0, close(socket_fds[0]));
 	EXPECT_EQ(0, close(socket_fds[1]));
@@ -5039,24 +5039,24 @@ FIXTURE_TEARDOWN_PARENT(layout1_bind)
 
 TEST_F_FORK(layout1_bind, no_restriction)
 {
-	ASSERT_EQ(0, test_open(dir_s1d1, O_RDONLY));
-	ASSERT_EQ(0, test_open(file1_s1d1, O_RDONLY));
-	ASSERT_EQ(0, test_open(dir_s1d2, O_RDONLY));
-	ASSERT_EQ(0, test_open(file1_s1d2, O_RDONLY));
-	ASSERT_EQ(0, test_open(dir_s1d3, O_RDONLY));
-	ASSERT_EQ(0, test_open(file1_s1d3, O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s1d1, O_RDONLY));
+	EXPECT_EQ(0, test_open(file1_s1d1, O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s1d2, O_RDONLY));
+	EXPECT_EQ(0, test_open(file1_s1d2, O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s1d3, O_RDONLY));
+	EXPECT_EQ(0, test_open(file1_s1d3, O_RDONLY));
 
-	ASSERT_EQ(0, test_open(dir_s2d1, O_RDONLY));
-	ASSERT_EQ(0, test_open(file1_s2d1, O_RDONLY));
-	ASSERT_EQ(0, test_open(dir_s2d2, O_RDONLY));
-	ASSERT_EQ(0, test_open(file1_s2d2, O_RDONLY));
-	ASSERT_EQ(ENOENT, test_open(dir_s2d3, O_RDONLY));
-	ASSERT_EQ(ENOENT, test_open(file1_s2d3, O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s2d1, O_RDONLY));
+	EXPECT_EQ(0, test_open(file1_s2d1, O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s2d2, O_RDONLY));
+	EXPECT_EQ(0, test_open(file1_s2d2, O_RDONLY));
+	EXPECT_EQ(ENOENT, test_open(dir_s2d3, O_RDONLY));
+	EXPECT_EQ(ENOENT, test_open(file1_s2d3, O_RDONLY));
 
-	ASSERT_EQ(0, test_open(bind_dir_s1d3, O_RDONLY));
-	ASSERT_EQ(0, test_open(bind_file1_s1d3, O_RDONLY));
+	EXPECT_EQ(0, test_open(bind_dir_s1d3, O_RDONLY));
+	EXPECT_EQ(0, test_open(bind_file1_s1d3, O_RDONLY));
 
-	ASSERT_EQ(0, test_open(dir_s3d1, O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s3d1, O_RDONLY));
 }
 
 TEST_F_FORK(layout1_bind, same_content_same_file)
@@ -5113,73 +5113,73 @@ TEST_F_FORK(layout1_bind, same_content_same_file)
 	enforce_fs(_metadata, ACCESS_RW, layer1_parent);
 
 	/* Checks source hierarchy. */
-	ASSERT_EQ(0, test_open(file1_s1d1, O_RDONLY));
-	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_WRONLY));
-	ASSERT_EQ(0, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(0, test_open(file1_s1d1, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d1, O_WRONLY));
+	EXPECT_EQ(0, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
 
-	ASSERT_EQ(0, test_open(file1_s1d2, O_RDONLY));
-	ASSERT_EQ(EACCES, test_open(file1_s1d2, O_WRONLY));
-	ASSERT_EQ(0, test_open(dir_s1d2, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(0, test_open(file1_s1d2, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d2, O_WRONLY));
+	EXPECT_EQ(0, test_open(dir_s1d2, O_RDONLY | O_DIRECTORY));
 
 	/* Checks destination hierarchy. */
-	ASSERT_EQ(0, test_open(file1_s2d1, O_RDWR));
-	ASSERT_EQ(0, test_open(dir_s2d1, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(0, test_open(file1_s2d1, O_RDWR));
+	EXPECT_EQ(0, test_open(dir_s2d1, O_RDONLY | O_DIRECTORY));
 
-	ASSERT_EQ(0, test_open(file1_s2d2, O_RDWR));
-	ASSERT_EQ(0, test_open(dir_s2d2, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(0, test_open(file1_s2d2, O_RDWR));
+	EXPECT_EQ(0, test_open(dir_s2d2, O_RDONLY | O_DIRECTORY));
 
 	/* Sets rules for the mount points. */
 	enforce_fs(_metadata, ACCESS_RW, layer2_mount_point);
 
 	/* Checks source hierarchy. */
-	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_RDONLY));
-	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_WRONLY));
-	ASSERT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d1, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d1, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
 
-	ASSERT_EQ(0, test_open(file1_s1d2, O_RDONLY));
-	ASSERT_EQ(EACCES, test_open(file1_s1d2, O_WRONLY));
-	ASSERT_EQ(0, test_open(dir_s1d2, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(0, test_open(file1_s1d2, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d2, O_WRONLY));
+	EXPECT_EQ(0, test_open(dir_s1d2, O_RDONLY | O_DIRECTORY));
 
 	/* Checks destination hierarchy. */
-	ASSERT_EQ(EACCES, test_open(file1_s2d1, O_RDONLY));
-	ASSERT_EQ(EACCES, test_open(file1_s2d1, O_WRONLY));
-	ASSERT_EQ(EACCES, test_open(dir_s2d1, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(EACCES, test_open(file1_s2d1, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s2d1, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(dir_s2d1, O_RDONLY | O_DIRECTORY));
 
-	ASSERT_EQ(0, test_open(file1_s2d2, O_RDWR));
-	ASSERT_EQ(0, test_open(dir_s2d2, O_RDONLY | O_DIRECTORY));
-	ASSERT_EQ(0, test_open(bind_dir_s1d3, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(0, test_open(file1_s2d2, O_RDWR));
+	EXPECT_EQ(0, test_open(dir_s2d2, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(0, test_open(bind_dir_s1d3, O_RDONLY | O_DIRECTORY));
 
 	/* Sets a (shared) rule only on the source. */
 	enforce_fs(_metadata, ACCESS_RW, layer3_source);
 
 	/* Checks source hierarchy. */
-	ASSERT_EQ(EACCES, test_open(file1_s1d2, O_RDONLY));
-	ASSERT_EQ(EACCES, test_open(file1_s1d2, O_WRONLY));
-	ASSERT_EQ(EACCES, test_open(dir_s1d2, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d2, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d2, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(dir_s1d2, O_RDONLY | O_DIRECTORY));
 
-	ASSERT_EQ(0, test_open(file1_s1d3, O_RDONLY));
-	ASSERT_EQ(EACCES, test_open(file1_s1d3, O_WRONLY));
-	ASSERT_EQ(EACCES, test_open(dir_s1d3, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(0, test_open(file1_s1d3, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d3, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(dir_s1d3, O_RDONLY | O_DIRECTORY));
 
 	/* Checks destination hierarchy. */
-	ASSERT_EQ(EACCES, test_open(file1_s2d2, O_RDONLY));
-	ASSERT_EQ(EACCES, test_open(file1_s2d2, O_WRONLY));
-	ASSERT_EQ(EACCES, test_open(dir_s2d2, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(EACCES, test_open(file1_s2d2, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s2d2, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(dir_s2d2, O_RDONLY | O_DIRECTORY));
 
-	ASSERT_EQ(0, test_open(bind_file1_s1d3, O_RDONLY));
-	ASSERT_EQ(EACCES, test_open(bind_file1_s1d3, O_WRONLY));
-	ASSERT_EQ(EACCES, test_open(bind_dir_s1d3, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(0, test_open(bind_file1_s1d3, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(bind_file1_s1d3, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(bind_dir_s1d3, O_RDONLY | O_DIRECTORY));
 
 	/* Sets a (shared) rule only on the destination. */
 	enforce_fs(_metadata, ACCESS_RW, layer4_destination);
 
 	/* Checks source hierarchy. */
-	ASSERT_EQ(EACCES, test_open(file1_s1d3, O_RDONLY));
-	ASSERT_EQ(EACCES, test_open(file1_s1d3, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d3, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d3, O_WRONLY));
 
 	/* Checks destination hierarchy. */
-	ASSERT_EQ(EACCES, test_open(bind_file1_s1d3, O_RDONLY));
-	ASSERT_EQ(EACCES, test_open(bind_file1_s1d3, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(bind_file1_s1d3, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(bind_file1_s1d3, O_WRONLY));
 }
 
 TEST_F_FORK(layout1_bind, reparent_cross_mount)
@@ -5203,15 +5203,15 @@ TEST_F_FORK(layout1_bind, reparent_cross_mount)
 
 	/* Checks basic denied move. */
 	ASSERT_EQ(-1, rename(file1_s1d1, file1_s1d2));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 
 	/* Checks real cross-mount move (Landlock is not involved). */
 	ASSERT_EQ(-1, rename(file1_s2d1, file1_s2d2));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 
 	/* Checks move that will give more accesses. */
 	ASSERT_EQ(-1, rename(file1_s2d2, bind_file1_s1d3));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 
 	/* Checks legitimate downgrade move. */
 	ASSERT_EQ(0, rename(bind_file1_s1d3, file1_s2d2));
@@ -6846,33 +6846,33 @@ TEST_F_FORK(layout2_overlay, no_restriction)
 	if (self->skip_test)
 		SKIP(return, "overlayfs is not supported (test)");
 
-	ASSERT_EQ(0, test_open(lower_fl1, O_RDONLY));
-	ASSERT_EQ(0, test_open(lower_dl1, O_RDONLY));
-	ASSERT_EQ(0, test_open(lower_dl1_fl2, O_RDONLY));
-	ASSERT_EQ(0, test_open(lower_fo1, O_RDONLY));
-	ASSERT_EQ(0, test_open(lower_do1, O_RDONLY));
-	ASSERT_EQ(0, test_open(lower_do1_fo2, O_RDONLY));
-	ASSERT_EQ(0, test_open(lower_do1_fl3, O_RDONLY));
+	EXPECT_EQ(0, test_open(lower_fl1, O_RDONLY));
+	EXPECT_EQ(0, test_open(lower_dl1, O_RDONLY));
+	EXPECT_EQ(0, test_open(lower_dl1_fl2, O_RDONLY));
+	EXPECT_EQ(0, test_open(lower_fo1, O_RDONLY));
+	EXPECT_EQ(0, test_open(lower_do1, O_RDONLY));
+	EXPECT_EQ(0, test_open(lower_do1_fo2, O_RDONLY));
+	EXPECT_EQ(0, test_open(lower_do1_fl3, O_RDONLY));
 
-	ASSERT_EQ(0, test_open(upper_fu1, O_RDONLY));
-	ASSERT_EQ(0, test_open(upper_du1, O_RDONLY));
-	ASSERT_EQ(0, test_open(upper_du1_fu2, O_RDONLY));
-	ASSERT_EQ(0, test_open(upper_fo1, O_RDONLY));
-	ASSERT_EQ(0, test_open(upper_do1, O_RDONLY));
-	ASSERT_EQ(0, test_open(upper_do1_fo2, O_RDONLY));
-	ASSERT_EQ(0, test_open(upper_do1_fu3, O_RDONLY));
+	EXPECT_EQ(0, test_open(upper_fu1, O_RDONLY));
+	EXPECT_EQ(0, test_open(upper_du1, O_RDONLY));
+	EXPECT_EQ(0, test_open(upper_du1_fu2, O_RDONLY));
+	EXPECT_EQ(0, test_open(upper_fo1, O_RDONLY));
+	EXPECT_EQ(0, test_open(upper_do1, O_RDONLY));
+	EXPECT_EQ(0, test_open(upper_do1_fo2, O_RDONLY));
+	EXPECT_EQ(0, test_open(upper_do1_fu3, O_RDONLY));
 
-	ASSERT_EQ(0, test_open(merge_fl1, O_RDONLY));
-	ASSERT_EQ(0, test_open(merge_dl1, O_RDONLY));
-	ASSERT_EQ(0, test_open(merge_dl1_fl2, O_RDONLY));
-	ASSERT_EQ(0, test_open(merge_fu1, O_RDONLY));
-	ASSERT_EQ(0, test_open(merge_du1, O_RDONLY));
-	ASSERT_EQ(0, test_open(merge_du1_fu2, O_RDONLY));
-	ASSERT_EQ(0, test_open(merge_fo1, O_RDONLY));
-	ASSERT_EQ(0, test_open(merge_do1, O_RDONLY));
-	ASSERT_EQ(0, test_open(merge_do1_fo2, O_RDONLY));
-	ASSERT_EQ(0, test_open(merge_do1_fl3, O_RDONLY));
-	ASSERT_EQ(0, test_open(merge_do1_fu3, O_RDONLY));
+	EXPECT_EQ(0, test_open(merge_fl1, O_RDONLY));
+	EXPECT_EQ(0, test_open(merge_dl1, O_RDONLY));
+	EXPECT_EQ(0, test_open(merge_dl1_fl2, O_RDONLY));
+	EXPECT_EQ(0, test_open(merge_fu1, O_RDONLY));
+	EXPECT_EQ(0, test_open(merge_du1, O_RDONLY));
+	EXPECT_EQ(0, test_open(merge_du1_fu2, O_RDONLY));
+	EXPECT_EQ(0, test_open(merge_fo1, O_RDONLY));
+	EXPECT_EQ(0, test_open(merge_do1, O_RDONLY));
+	EXPECT_EQ(0, test_open(merge_do1_fo2, O_RDONLY));
+	EXPECT_EQ(0, test_open(merge_do1_fl3, O_RDONLY));
+	EXPECT_EQ(0, test_open(merge_do1_fu3, O_RDONLY));
 }
 
 #define for_each_path(path_list, path_entry, i)               \
@@ -7016,29 +7016,29 @@ TEST_F_FORK(layout2_overlay, same_content_different_file)
 
 	/* Checks lower layer. */
 	for_each_path(lower_base_files, path_entry, i) {
-		ASSERT_EQ(0, test_open(path_entry, O_RDONLY));
-		ASSERT_EQ(EACCES, test_open(path_entry, O_WRONLY));
+		EXPECT_EQ(0, test_open(path_entry, O_RDONLY));
+		EXPECT_EQ(EACCES, test_open(path_entry, O_WRONLY));
 	}
 	for_each_path(lower_base_directories, path_entry, i) {
-		ASSERT_EQ(EACCES,
+		EXPECT_EQ(EACCES,
 			  test_open(path_entry, O_RDONLY | O_DIRECTORY));
 	}
 	for_each_path(lower_sub_files, path_entry, i) {
-		ASSERT_EQ(0, test_open(path_entry, O_RDONLY));
-		ASSERT_EQ(EACCES, test_open(path_entry, O_WRONLY));
+		EXPECT_EQ(0, test_open(path_entry, O_RDONLY));
+		EXPECT_EQ(EACCES, test_open(path_entry, O_WRONLY));
 	}
 	/* Checks upper layer. */
 	for_each_path(upper_base_files, path_entry, i) {
-		ASSERT_EQ(0, test_open(path_entry, O_RDONLY));
-		ASSERT_EQ(EACCES, test_open(path_entry, O_WRONLY));
+		EXPECT_EQ(0, test_open(path_entry, O_RDONLY));
+		EXPECT_EQ(EACCES, test_open(path_entry, O_WRONLY));
 	}
 	for_each_path(upper_base_directories, path_entry, i) {
-		ASSERT_EQ(EACCES,
+		EXPECT_EQ(EACCES,
 			  test_open(path_entry, O_RDONLY | O_DIRECTORY));
 	}
 	for_each_path(upper_sub_files, path_entry, i) {
-		ASSERT_EQ(0, test_open(path_entry, O_RDONLY));
-		ASSERT_EQ(EACCES, test_open(path_entry, O_WRONLY));
+		EXPECT_EQ(0, test_open(path_entry, O_RDONLY));
+		EXPECT_EQ(EACCES, test_open(path_entry, O_WRONLY));
 	}
 	/*
 	 * Checks that access rights are independent from the lower and upper
@@ -7047,13 +7047,13 @@ TEST_F_FORK(layout2_overlay, same_content_different_file)
 	 * through the merge point is still allowed.
 	 */
 	for_each_path(merge_base_files, path_entry, i) {
-		ASSERT_EQ(0, test_open(path_entry, O_RDWR));
+		EXPECT_EQ(0, test_open(path_entry, O_RDWR));
 	}
 	for_each_path(merge_base_directories, path_entry, i) {
-		ASSERT_EQ(0, test_open(path_entry, O_RDONLY | O_DIRECTORY));
+		EXPECT_EQ(0, test_open(path_entry, O_RDONLY | O_DIRECTORY));
 	}
 	for_each_path(merge_sub_files, path_entry, i) {
-		ASSERT_EQ(0, test_open(path_entry, O_RDWR));
+		EXPECT_EQ(0, test_open(path_entry, O_RDWR));
 	}
 
 	/* Sets rules on data directories (i.e. inside overlay scope). */
@@ -7061,13 +7061,13 @@ TEST_F_FORK(layout2_overlay, same_content_different_file)
 
 	/* Checks merge. */
 	for_each_path(merge_base_files, path_entry, i) {
-		ASSERT_EQ(0, test_open(path_entry, O_RDWR));
+		EXPECT_EQ(0, test_open(path_entry, O_RDWR));
 	}
 	for_each_path(merge_base_directories, path_entry, i) {
-		ASSERT_EQ(0, test_open(path_entry, O_RDONLY | O_DIRECTORY));
+		EXPECT_EQ(0, test_open(path_entry, O_RDONLY | O_DIRECTORY));
 	}
 	for_each_path(merge_sub_files, path_entry, i) {
-		ASSERT_EQ(0, test_open(path_entry, O_RDWR));
+		EXPECT_EQ(0, test_open(path_entry, O_RDWR));
 	}
 
 	/* Same checks with tighter rules. */
@@ -7075,21 +7075,21 @@ TEST_F_FORK(layout2_overlay, same_content_different_file)
 
 	/* Checks changes for lower layer. */
 	for_each_path(lower_base_files, path_entry, i) {
-		ASSERT_EQ(EACCES, test_open(path_entry, O_RDONLY));
+		EXPECT_EQ(EACCES, test_open(path_entry, O_RDONLY));
 	}
 	/* Checks changes for upper layer. */
 	for_each_path(upper_base_files, path_entry, i) {
-		ASSERT_EQ(EACCES, test_open(path_entry, O_RDONLY));
+		EXPECT_EQ(EACCES, test_open(path_entry, O_RDONLY));
 	}
 	/* Checks all merge accesses. */
 	for_each_path(merge_base_files, path_entry, i) {
-		ASSERT_EQ(EACCES, test_open(path_entry, O_RDWR));
+		EXPECT_EQ(EACCES, test_open(path_entry, O_RDWR));
 	}
 	for_each_path(merge_base_directories, path_entry, i) {
-		ASSERT_EQ(0, test_open(path_entry, O_RDONLY | O_DIRECTORY));
+		EXPECT_EQ(0, test_open(path_entry, O_RDONLY | O_DIRECTORY));
 	}
 	for_each_path(merge_sub_files, path_entry, i) {
-		ASSERT_EQ(0, test_open(path_entry, O_RDWR));
+		EXPECT_EQ(0, test_open(path_entry, O_RDWR));
 	}
 
 	/* Sets rules directly on overlayed files. */
@@ -7097,24 +7097,24 @@ TEST_F_FORK(layout2_overlay, same_content_different_file)
 
 	/* Checks unchanged accesses on lower layer. */
 	for_each_path(lower_sub_files, path_entry, i) {
-		ASSERT_EQ(0, test_open(path_entry, O_RDONLY));
-		ASSERT_EQ(EACCES, test_open(path_entry, O_WRONLY));
+		EXPECT_EQ(0, test_open(path_entry, O_RDONLY));
+		EXPECT_EQ(EACCES, test_open(path_entry, O_WRONLY));
 	}
 	/* Checks unchanged accesses on upper layer. */
 	for_each_path(upper_sub_files, path_entry, i) {
-		ASSERT_EQ(0, test_open(path_entry, O_RDONLY));
-		ASSERT_EQ(EACCES, test_open(path_entry, O_WRONLY));
+		EXPECT_EQ(0, test_open(path_entry, O_RDONLY));
+		EXPECT_EQ(EACCES, test_open(path_entry, O_WRONLY));
 	}
 	/* Checks all merge accesses. */
 	for_each_path(merge_base_files, path_entry, i) {
-		ASSERT_EQ(EACCES, test_open(path_entry, O_RDWR));
+		EXPECT_EQ(EACCES, test_open(path_entry, O_RDWR));
 	}
 	for_each_path(merge_base_directories, path_entry, i) {
-		ASSERT_EQ(EACCES,
+		EXPECT_EQ(EACCES,
 			  test_open(path_entry, O_RDONLY | O_DIRECTORY));
 	}
 	for_each_path(merge_sub_files, path_entry, i) {
-		ASSERT_EQ(0, test_open(path_entry, O_RDWR));
+		EXPECT_EQ(0, test_open(path_entry, O_RDWR));
 	}
 
 	/* Only allows access to the merge hierarchy. */
@@ -7122,22 +7122,22 @@ TEST_F_FORK(layout2_overlay, same_content_different_file)
 
 	/* Checks new accesses on lower layer. */
 	for_each_path(lower_sub_files, path_entry, i) {
-		ASSERT_EQ(EACCES, test_open(path_entry, O_RDONLY));
+		EXPECT_EQ(EACCES, test_open(path_entry, O_RDONLY));
 	}
 	/* Checks new accesses on upper layer. */
 	for_each_path(upper_sub_files, path_entry, i) {
-		ASSERT_EQ(EACCES, test_open(path_entry, O_RDONLY));
+		EXPECT_EQ(EACCES, test_open(path_entry, O_RDONLY));
 	}
 	/* Checks all merge accesses. */
 	for_each_path(merge_base_files, path_entry, i) {
-		ASSERT_EQ(EACCES, test_open(path_entry, O_RDWR));
+		EXPECT_EQ(EACCES, test_open(path_entry, O_RDWR));
 	}
 	for_each_path(merge_base_directories, path_entry, i) {
-		ASSERT_EQ(EACCES,
+		EXPECT_EQ(EACCES,
 			  test_open(path_entry, O_RDONLY | O_DIRECTORY));
 	}
 	for_each_path(merge_sub_files, path_entry, i) {
-		ASSERT_EQ(0, test_open(path_entry, O_RDWR));
+		EXPECT_EQ(0, test_open(path_entry, O_RDWR));
 	}
 }
 
@@ -7434,7 +7434,7 @@ TEST_F_FORK(layout3_fs, release_inodes)
 	EXPECT_EQ(0, close(ruleset_fd));
 
 	/* Checks that access to the new mount point is denied. */
-	ASSERT_EQ(EACCES, test_open(TMP_DIR, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(TMP_DIR, O_RDONLY));
 }
 
 static int matches_log_fs_extra(struct __test_metadata *const _metadata,
@@ -7914,7 +7914,7 @@ TEST_F(audit_layout1, refer_rename_half)
 	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_REFER, layer1);
 
 	ASSERT_EQ(-1, rename(dir_s1d2, dir_s2d3));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 
 	/* Only half of the request is denied. */
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.refer",
@@ -8233,7 +8233,7 @@ void audit_quiet_layout1_test_body(struct __test_metadata *const _metadata,
 			};
 		} else {
 			ASSERT_EQ(-1, fd);
-			ASSERT_EQ(EACCES, errno);
+			EXPECT_EQ(EACCES, errno);
 		}
 
 		expect_audit = true;
@@ -8248,12 +8248,12 @@ void audit_quiet_layout1_test_body(struct __test_metadata *const _metadata,
 			expect_audit = false;
 
 		if (expect_audit)
-			ASSERT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
+			EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
 						    blocker, target->target));
 
 		/* Check that we see no (other) logs. */
 		ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
-		ASSERT_EQ(0, records.access);
+		EXPECT_EQ(0, records.access);
 
 		if (target->expect_open_success && fd >= 0) {
 			if (debug_quiet_tests)
@@ -8265,11 +8265,11 @@ void audit_quiet_layout1_test_body(struct __test_metadata *const _metadata,
 			} else {
 				ASSERT_EQ(-1, ret);
 				if (open_mode != O_RDONLY)
-					ASSERT_EQ(EACCES, errno);
+					EXPECT_EQ(EACCES, errno);
 			}
 
 			if (target->audit_truncate)
-				ASSERT_EQ(0, matches_log_fs(_metadata,
+				EXPECT_EQ(0, matches_log_fs(_metadata,
 							    self->audit_fd,
 							    "fs\\.truncate",
 							    target->target));
@@ -8289,7 +8289,7 @@ void audit_quiet_layout1_test_body(struct __test_metadata *const _metadata,
 			}
 
 			if (target->audit_ioctl)
-				ASSERT_EQ(0, matches_log_fs_extra(
+				EXPECT_EQ(0, matches_log_fs_extra(
 						     _metadata, self->audit_fd,
 						     "fs\\.ioctl_dev",
 						     target->target,
@@ -8298,7 +8298,7 @@ void audit_quiet_layout1_test_body(struct __test_metadata *const _metadata,
 			/* Check that we see no other logs. */
 			ASSERT_EQ(0, audit_count_records(self->audit_fd,
 							 &records));
-			ASSERT_EQ(0, records.access);
+			EXPECT_EQ(0, records.access);
 			EXPECT_EQ(0, close(fd));
 		}
 	}
@@ -9687,10 +9687,10 @@ static void simple_quiet_rename(struct __test_metadata *const _metadata,
 		}
 
 		if (source_blockers)
-			ASSERT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
+			EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
 						    source_blockers, dir_s1d1));
 		if (dest_blockers)
-			ASSERT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
+			EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
 						    dest_blockers, dir_s2d1));
 	}
 	/*
@@ -9698,7 +9698,7 @@ static void simple_quiet_rename(struct __test_metadata *const _metadata,
 	 * audit_quiet_layout1_test_body.
 	 */
 	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
-	ASSERT_EQ(0, records.access);
+	EXPECT_EQ(0, records.access);
 }
 
 TEST_F(audit_quiet_rename, rename_ok)
@@ -9813,11 +9813,11 @@ TEST_F(audit_quiet_rename, handle_all_deny_quiet_refer)
 	ASSERT_EQ(0, apply_a_layer(_metadata, &layer));
 
 	ASSERT_EQ(-1, renameat(AT_FDCWD, file1_s1d1, AT_FDCWD, file1_s2d1));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 
 	/* No logs */
 	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
-	ASSERT_EQ(0, records.access);
+	EXPECT_EQ(0, records.access);
 }
 
 TEST_F(audit_quiet_rename, handle_all_deny_not_quiet_refer)
@@ -9849,16 +9849,16 @@ TEST_F(audit_quiet_rename, handle_all_deny_not_quiet_refer)
 	ASSERT_EQ(0, apply_a_layer(_metadata, &layer));
 
 	ASSERT_EQ(-1, renameat(AT_FDCWD, file1_s1d1, AT_FDCWD, file1_s2d1));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 
-	ASSERT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.refer",
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.refer",
 				    dir_s1d1));
-	ASSERT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.refer",
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.refer",
 				    dir_s2d1));
 
 	/* No other logs */
 	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
-	ASSERT_EQ(0, records.access);
+	EXPECT_EQ(0, records.access);
 }
 
 TEST_F(audit_quiet_rename, handle_all_deny_refer_quiet_source_not_quiet_dest)
@@ -9890,14 +9890,14 @@ TEST_F(audit_quiet_rename, handle_all_deny_refer_quiet_source_not_quiet_dest)
 	ASSERT_EQ(0, apply_a_layer(_metadata, &layer));
 
 	ASSERT_EQ(-1, renameat(AT_FDCWD, file1_s1d1, AT_FDCWD, file1_s2d1));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 
-	ASSERT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.refer",
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.refer",
 				    dir_s2d1));
 
 	/* No other logs */
 	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
-	ASSERT_EQ(0, records.access);
+	EXPECT_EQ(0, records.access);
 }
 
 TEST_F(audit_quiet_rename, quiet_same_dir)
@@ -9921,10 +9921,10 @@ TEST_F(audit_quiet_rename, quiet_same_dir)
 	ASSERT_EQ(0, apply_a_layer(_metadata, &layer));
 
 	ASSERT_EQ(-1, renameat(AT_FDCWD, file1_s1d1, AT_FDCWD, file2_s1d1));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 
 	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
-	ASSERT_EQ(0, records.access);
+	EXPECT_EQ(0, records.access);
 }
 
 TEST_F(audit_quiet_rename, quiet_flag_on_file_ignored)
@@ -9953,18 +9953,18 @@ TEST_F(audit_quiet_rename, quiet_flag_on_file_ignored)
 	ASSERT_EQ(0, apply_a_layer(_metadata, &layer));
 
 	ASSERT_EQ(-1, renameat(AT_FDCWD, file1_s1d1, AT_FDCWD, file1_s2d1));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 
-	ASSERT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
 				    "fs\\.remove_file,fs\\.refer", dir_s1d1));
 	/* We didn't unlink destination file */
-	ASSERT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
 				    "fs\\.remove_file,fs\\.make_reg,fs\\.refer",
 				    dir_s2d1));
 
 	/* No other logs */
 	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
-	ASSERT_EQ(0, records.access);
+	EXPECT_EQ(0, records.access);
 }
 
 TEST_F(audit_quiet_rename, quiet_flag_on_file_ignored_same_dir)
@@ -9993,15 +9993,15 @@ TEST_F(audit_quiet_rename, quiet_flag_on_file_ignored_same_dir)
 	ASSERT_EQ(0, apply_a_layer(_metadata, &layer));
 
 	ASSERT_EQ(-1, renameat(AT_FDCWD, file1_s1d1, AT_FDCWD, file2_s1d1));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 
-	ASSERT_EQ(0,
+	EXPECT_EQ(0,
 		  matches_log_fs(_metadata, self->audit_fd,
 				 "fs\\.remove_file,fs\\.make_reg", dir_s1d1));
 
 	/* No other logs */
 	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
-	ASSERT_EQ(0, records.access);
+	EXPECT_EQ(0, records.access);
 }
 
 TEST_F(audit_quiet_rename, two_layers_different_quiet1)
@@ -10049,17 +10049,17 @@ TEST_F(audit_quiet_rename, two_layers_different_quiet1)
 	ASSERT_EQ(0, apply_a_layer(_metadata, &layer2));
 
 	ASSERT_EQ(-1, renameat(AT_FDCWD, file1_s1d1, AT_FDCWD, file1_s2d1));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 
 	/*
 	 * The youngest denial will be layer 2.  Refer is quieted but we are
 	 * also missing remove_file on source.
 	 */
-	ASSERT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
 				    "fs\\.remove_file,fs\\.refer", dir_s1d1));
 	/* No other logs */
 	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
-	ASSERT_EQ(0, records.access);
+	EXPECT_EQ(0, records.access);
 }
 
 TEST_F(audit_quiet_rename, two_layers_different_quiet2)
@@ -10107,14 +10107,14 @@ TEST_F(audit_quiet_rename, two_layers_different_quiet2)
 	ASSERT_EQ(0, apply_a_layer(_metadata, &layer2));
 
 	ASSERT_EQ(-1, renameat(AT_FDCWD, file1_s1d1, AT_FDCWD, file1_s2d1));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 
 	/*
 	 * The youngest denial will be layer 2, but refer is quieted (and that
 	 * layer does not handle any other accesses).
 	 */
 	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
-	ASSERT_EQ(0, records.access);
+	EXPECT_EQ(0, records.access);
 }
 
 TEST_F(audit_quiet_rename, two_layers_different_quiet3)
@@ -10162,13 +10162,13 @@ TEST_F(audit_quiet_rename, two_layers_different_quiet3)
 	ASSERT_EQ(0, apply_a_layer(_metadata, &layer2));
 
 	ASSERT_EQ(-1, renameat(AT_FDCWD, file1_s1d1, AT_FDCWD, file1_s2d1));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 
 	/*
 	 * The youngest denial will be layer 2, in which everything is quieted.
 	 */
 	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
-	ASSERT_EQ(0, records.access);
+	EXPECT_EQ(0, records.access);
 }
 
 TEST_F(audit_quiet_rename,
@@ -10206,15 +10206,15 @@ TEST_F(audit_quiet_rename,
 	ASSERT_EQ(0, apply_a_layer(_metadata, &layer2));
 
 	ASSERT_EQ(-1, renameat(AT_FDCWD, file1_s1d1, AT_FDCWD, file1_s2d1));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 
-	ASSERT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
 				    "fs\\.remove_file,fs\\.refer", dir_s1d1));
-	ASSERT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
 				    "fs\\.make_reg,fs\\.refer", dir_s2d1));
 	/* No other logs. */
 	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
-	ASSERT_EQ(0, records.access);
+	EXPECT_EQ(0, records.access);
 }
 
 TEST_F(audit_quiet_rename,
@@ -10258,14 +10258,14 @@ TEST_F(audit_quiet_rename,
 	ASSERT_EQ(0, apply_a_layer(_metadata, &layer2));
 
 	ASSERT_EQ(-1, renameat(AT_FDCWD, file1_s1d1, AT_FDCWD, file1_s2d1));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 
 	/* Source is quieted but destination is not. */
-	ASSERT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
 				    "fs\\.make_reg,fs\\.refer", dir_s2d1));
 	/* No other logs. */
 	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
-	ASSERT_EQ(0, records.access);
+	EXPECT_EQ(0, records.access);
 }
 
 TEST_F(audit_quiet_rename, rename_xchg)
@@ -10295,10 +10295,10 @@ TEST_F(audit_quiet_rename, rename_xchg)
 
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s1d1, AT_FDCWD, file1_s2d1,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 
 	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
-	ASSERT_EQ(0, records.access);
+	EXPECT_EQ(0, records.access);
 }
 
 TEST_F(audit_quiet_rename, quiet_on_parent_mount)
@@ -10324,10 +10324,10 @@ TEST_F(audit_quiet_rename, quiet_on_parent_mount)
 
 	ASSERT_EQ(-1, renameat(AT_FDCWD, bind_file1_s1d3, AT_FDCWD,
 			       bind_file2_s1d3));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 
 	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
-	ASSERT_EQ(0, records.access);
+	EXPECT_EQ(0, records.access);
 }
 
 TEST_F(audit_quiet_rename, quiet_behind_mountpoint_ignored)
@@ -10353,13 +10353,13 @@ TEST_F(audit_quiet_rename, quiet_behind_mountpoint_ignored)
 
 	ASSERT_EQ(-1, renameat(AT_FDCWD, bind_file1_s1d3, AT_FDCWD,
 			       bind_file2_s1d3));
-	ASSERT_EQ(EACCES, errno);
-	ASSERT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
+	EXPECT_EQ(EACCES, errno);
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
 				    "fs\\.remove_file,fs\\.make_reg",
 				    bind_dir_s1d3));
 
 	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
-	ASSERT_EQ(0, records.access);
+	EXPECT_EQ(0, records.access);
 }
 
 TEST_F(audit_quiet_rename, quiet_on_parent_mount_disconnected)
@@ -10394,10 +10394,10 @@ TEST_F(audit_quiet_rename, quiet_on_parent_mount_disconnected)
 
 	ASSERT_EQ(-1,
 		  renameat(bind_s1d3_fd, file1_name, bind_s1d3_fd, file2_name));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 
 	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
-	ASSERT_EQ(0, records.access);
+	EXPECT_EQ(0, records.access);
 }
 
 TEST_F(audit_quiet_rename, quiet_behind_mountpoint_disconnected)
@@ -10432,10 +10432,10 @@ TEST_F(audit_quiet_rename, quiet_behind_mountpoint_disconnected)
 
 	ASSERT_EQ(-1,
 		  renameat(bind_s1d3_fd, file1_name, bind_s1d3_fd, file2_name));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 
 	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
-	ASSERT_EQ(0, records.access);
+	EXPECT_EQ(0, records.access);
 }
 
 /* clang-format off */
diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
index e194fd78d8a1..31e113873d66 100644
--- a/tools/testing/selftests/landlock/net_test.c
+++ b/tools/testing/selftests/landlock/net_test.c
@@ -3720,7 +3720,7 @@ TEST_F(trace_net_address, deny_access_net)
 
 	ASSERT_EQ(child, waitpid(child, &status, 0));
 	ASSERT_TRUE(WIFEXITED(status));
-	ASSERT_EQ(0, WEXITSTATUS(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
 
 	buf = tracefs_read_buf();
 	ASSERT_NE(NULL, buf);
diff --git a/tools/testing/selftests/landlock/ns_test.c b/tools/testing/selftests/landlock/ns_test.c
index 96b1264c4353..5c93f7010bbd 100644
--- a/tools/testing/selftests/landlock/ns_test.c
+++ b/tools/testing/selftests/landlock/ns_test.c
@@ -121,14 +121,14 @@ TEST(add_rule_bad_attr)
 	/* Invalid rule pointer returns EFAULT. */
 	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NAMESPACE,
 					NULL, 0));
-	ASSERT_EQ(EFAULT, errno);
+	EXPECT_EQ(EFAULT, errno);
 
 	/* Empty permissions selector returns ENOMSG. */
 	attr.permissions = 0;
 	attr.allowed_namespace_types = CLONE_NEWUTS;
 	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NAMESPACE,
 					&attr, 0));
-	ASSERT_EQ(ENOMSG, errno);
+	EXPECT_EQ(ENOMSG, errno);
 
 	/* Valid namespace selector plus an extra unhandled selector bit. */
 	attr.permissions = LANDLOCK_PERMISSION_NAMESPACE_USE |
@@ -136,14 +136,14 @@ TEST(add_rule_bad_attr)
 	attr.allowed_namespace_types = CLONE_NEWUTS;
 	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NAMESPACE,
 					&attr, 0));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 
 	/* permissions with wrong type. */
 	attr.permissions = LANDLOCK_PERMISSION_CAPABILITY_USE;
 	attr.allowed_namespace_types = CLONE_NEWUTS;
 	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NAMESPACE,
 					&attr, 0));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 
 	/*
 	 * Unknown namespace bits (e.g. bit 63) are silently accepted for
@@ -160,7 +160,7 @@ TEST(add_rule_bad_attr)
 	attr.quiet_namespace_types = 0;
 	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NAMESPACE,
 					&attr, 0));
-	ASSERT_EQ(ENOMSG, errno);
+	EXPECT_EQ(ENOMSG, errno);
 
 	/* Quiet-only rule (empty allowed set) is legal. */
 	attr.permissions = LANDLOCK_PERMISSION_NAMESPACE_USE;
@@ -201,7 +201,7 @@ TEST(add_rule_bad_attr)
 	attr.allowed_namespace_types = CLONE_NEWUTS;
 	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NAMESPACE,
 					&attr, LANDLOCK_ADD_RULE_QUIET));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 
 	EXPECT_EQ(0, close(ruleset_fd));
 
@@ -217,7 +217,7 @@ TEST(add_rule_bad_attr)
 	attr.allowed_namespace_types = CLONE_NEWUTS;
 	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NAMESPACE,
 					&attr, 0));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 	EXPECT_EQ(0, close(ruleset_fd));
 }
 
@@ -759,7 +759,7 @@ TEST_F(ns_create, clone3)
 		ASSERT_LE(0, pid);
 		ASSERT_EQ(pid, waitpid(pid, &status, 0));
 		ASSERT_EQ(1, WIFEXITED(status));
-		ASSERT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
+		EXPECT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
 	}
 
 	if (!variant->drop_all_caps &&
@@ -1307,7 +1307,7 @@ TEST_F(ns_create_multi_flag, unshare)
 
 	ASSERT_EQ(child, waitpid(child, &status, 0));
 	ASSERT_EQ(1, WIFEXITED(status));
-	ASSERT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
+	EXPECT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
 }
 
 /* clang-format off */
@@ -1438,7 +1438,7 @@ TEST_F(setns_cross_process, setns)
 	EXPECT_EQ(0, close(pipe_parent[1]));
 	ASSERT_EQ(child, waitpid(child, &status, 0));
 	ASSERT_EQ(1, WIFEXITED(status));
-	ASSERT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
+	EXPECT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
 }
 
 /*
@@ -1660,7 +1660,7 @@ TEST(two_permissions_combined_unshare_allowed)
 	}
 	ASSERT_EQ(child, waitpid(child, &status, 0));
 	ASSERT_EQ(1, WIFEXITED(status));
-	ASSERT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
+	EXPECT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
 }
 
 /*
@@ -2393,10 +2393,10 @@ TEST_F(ns_trace, rule_events)
 	ASSERT_EQ(0, add_ns_rule_full(ruleset_fd, CLONE_NEWUTS, CLONE_NEWNET));
 	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NAMESPACE,
 					&invalid_attr, 0));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NAMESPACE,
 					&valid_attr, LANDLOCK_ADD_RULE_QUIET));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 	ASSERT_EQ(0, add_ns_rule_full(ruleset_fd, CLONE_NEWUTS, CLONE_NEWNET));
 	ASSERT_EQ(0, add_ns_rule(ruleset_fd, 1ULL << 63));
 	EXPECT_EQ(0, close(ruleset_fd));
diff --git a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
index 4c7f9c102d50..9aa1d375ef51 100644
--- a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
+++ b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
@@ -1114,7 +1114,7 @@ TEST(datagram_sockets)
 		ASSERT_EQ(-1, sendto(client_unconn_socket, ".", 1, 0,
 				     &non_connected_addr.unix_addr,
 				     non_connected_addr.unix_addr_len));
-		ASSERT_EQ(EPERM, errno);
+		EXPECT_EQ(EPERM, errno);
 		ASSERT_EQ(1, write(pipe_child[1], ".", 1));
 
 		EXPECT_EQ(0, close(client_conn_socket));
@@ -1196,17 +1196,17 @@ TEST(self_connect)
 		ASSERT_EQ(-1,
 			  connect(connected_socket, &connected_addr.unix_addr,
 				  connected_addr.unix_addr_len));
-		ASSERT_EQ(EPERM, errno);
+		EXPECT_EQ(EPERM, errno);
 
 		ASSERT_EQ(-1, sendto(connected_socket, ".", 1, 0,
 				     &connected_addr.unix_addr,
 				     connected_addr.unix_addr_len));
-		ASSERT_EQ(EPERM, errno);
+		EXPECT_EQ(EPERM, errno);
 
 		ASSERT_EQ(-1, sendto(non_connected_socket, ".", 1, 0,
 				     &non_connected_addr.unix_addr,
 				     non_connected_addr.unix_addr_len));
-		ASSERT_EQ(EPERM, errno);
+		EXPECT_EQ(EPERM, errno);
 
 		EXPECT_EQ(0, close(connected_socket));
 		EXPECT_EQ(0, close(non_connected_socket));
diff --git a/tools/testing/selftests/landlock/scoped_signal_test.c b/tools/testing/selftests/landlock/scoped_signal_test.c
index 66fec3822812..f9c270a1107a 100644
--- a/tools/testing/selftests/landlock/scoped_signal_test.c
+++ b/tools/testing/selftests/landlock/scoped_signal_test.c
@@ -124,7 +124,7 @@ TEST_F(scoping_signals, send_sig_to_parent)
 		 */
 		err = kill(parent, variant->sig);
 		ASSERT_EQ(-1, err);
-		ASSERT_EQ(EPERM, errno);
+		EXPECT_EQ(EPERM, errno);
 
 		/*
 		 * No matter of the domain, a process should be able to
@@ -216,7 +216,7 @@ TEST_F(scoped_domains, check_access_signal)
 			ASSERT_EQ(0, err);
 		} else {
 			ASSERT_EQ(-1, err);
-			ASSERT_EQ(EPERM, errno);
+			EXPECT_EQ(EPERM, errno);
 		}
 		/*
 		 * No matter of the domain, a process should be able to
@@ -241,7 +241,7 @@ TEST_F(scoped_domains, check_access_signal)
 		ASSERT_EQ(0, err);
 	} else {
 		ASSERT_EQ(-1, err);
-		ASSERT_EQ(EPERM, errno);
+		EXPECT_EQ(EPERM, errno);
 	}
 	ASSERT_EQ(0, raise(0));
 
diff --git a/tools/testing/selftests/landlock/scoped_test.c b/tools/testing/selftests/landlock/scoped_test.c
index b90f76ed0d9c..4d8f79170892 100644
--- a/tools/testing/selftests/landlock/scoped_test.c
+++ b/tools/testing/selftests/landlock/scoped_test.c
@@ -26,7 +26,7 @@ TEST(ruleset_with_unknown_scope)
 
 		ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr,
 						      sizeof(ruleset_attr), 0));
-		ASSERT_EQ(EINVAL, errno);
+		EXPECT_EQ(EINVAL, errno);
 	}
 }
 

-- 
2.56.0

