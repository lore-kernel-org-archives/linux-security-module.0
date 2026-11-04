Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826590;
	b=qEKwJh+8qsHRWB0DMSfcuiPxtSZHJDmBdOdT1z7qfTdmjURwaRaztwxihN77rBNSm4s3
	 X2A9fftYzx+Ku+5/uEPae1xMYLKIwS+IB3zXwVW4SKu9bQ8yl3sBXLEdw9lo/fd56zlKR
	 YoBrfNsFr+uwh5kc5KAud/XTGSW99lgRy/VItVsZZCml7IdgWt2e/6G/DQynvIO+3U7Pe
	 UyEIvzWyjZL1FyhEGv2R0yPp51qXK0QtmZ4ST8ZF2SCWKCsdsULsX9P05p4G8jEE7siRk
	 XeLgdBWbRm9En0rJ0nuAYhqAJBKj4PNjzhFkkaax29/057O3Oy30KhAECkaac8+7TGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826590;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=c6JUFJlg22kxnPU8jH7MQCXL8IB0OZjCv0Haho2qHyk=;
	b=bVp6mC4pVYxxL7wPaMlG3X/1Gp5y8W80EeepIbXbQZTfiEE/8P+9Dga8GJSLnddSmPZe
	 WjbVV2Te/PuxgmQO0UIF6sG19IqUiHjmUwIk9VF6rF3kYb9XHhyHxeTSQlYUNxTj0O8Sy
	 Rf4PgA0Lmq+1zJTYmqQ7Yqu40x9mV0LjCFAFqMth1S+eLr8sWNJlPaT09Mz09nx7Z7ixq
	 NqRAohK1Y3FAoDbInVzBdesurXcadLcNJdhquCJ5Eqw/4RTArsDiFBHRP9r3N7ErAUZKg
	 mAl1BPYl3EVK+WfGY5TTosLMwDeuXpq8YvVzX5tMsJxUTLHP9sbuu2Pq7oRs++S4uPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yqLBXH2P;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CE76080789
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:09:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08CE76080789
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yqLBXH2P
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48df54150dfso815366f8f.0
        for <linux-security-module@vger.kernel.org>; Wed, 04 Nov 2026 13:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793826587; x=1794431387; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c6JUFJlg22kxnPU8jH7MQCXL8IB0OZjCv0Haho2qHyk=;
        b=yqLBXH2PAw7osnoHoXsEeZlh1Tpjby8XlQ63cVA/Ufcbtlkr4No98wsfZntu1ib47o
         Oo6M6N01NR5Ar23B84eVeUKqm9Jac3QWaynmQA7OIwj6/gPQRg2bUpi12YDf1TUuxrvr
         G8HItU5I6UyidihRbAxrV/NdHDHxAJeT7XjTL0mklfqimOwVNDGIVHB1sI89T49WFYTD
         GBIHteKCh+fX6H6Yq+CzNWALMnGsvwnrG+r+XdIJzpX04akY7maP8tjQUm/yUvhHyqKs
         FXp1l0DFS7W6nsvkNg7yFOI4WCnx2GraHzkpPbyGUWc+AYixGOc/E8QccQAGUdcETZy0
         EgRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793826587; x=1794431387;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c6JUFJlg22kxnPU8jH7MQCXL8IB0OZjCv0Haho2qHyk=;
        b=S7etdtlnazj7rZs4uPrfoakCf2rWEUxJUfSOPYzpoDXwFh8ln1R/FvE2iudVHpdmC4
         3AiyCahk/OB1ebyv2MXEN5LgQhSs88FoWzKPRHQ3mjj5s3v/s+RxxBcg/Fh1KFlc+TqL
         SyXDeEhBxQoDx8qRafdJ6CT/zzSs767DJNmV8Yc7MlT775MQSWXbkdHnD72phlxj4hlz
         hsPSF2CzJLfyrc4h7eBIQYArXaAaZQOZq1Kc3cbQy5FlZAJiMkw5z8DdjNX+BjxMbTkt
         DZzsGPPMYoj1XhshDU+nhyif6LtOGRN2jnPJ/I/KuwW96ietLy1eeNcL4fx4WFot7il9
         kG9A==
X-Gm-Message-State: APuU4Z9dv/VwaLrhIpEFsBwkWaUYEnE3UNUUCtli30/eyp/dPHyLVbeg
	ww+TZxC3qwg/5NxjuVqXf6JWZgHH4fvpaE6n8pX3YJ01zP0K+9Vutx+OPhz56Ixv
X-Gm-Gg: AYBFou3FwFY9p7ew77e34HElEjTJMLv1JGPclj24Bmkqgqii6Fa1QLcWpUCDAaPwTkk
	q7WHD9xGXKbFo+Uf7KZENeZ1SaNT7xHRfFUGNGhz4wXl59AjV/h6756mCaZRKKQj8jUzDwla64w
	Ua36RmXsrbCgbxVnvlEwf+4a5LrFNDD3AcUjmVHpndMJjwkB7wCyww2ShgepJAtC3tW5GecmO09
	gPve4WeDZFjdPxfqe9ekk/xKuLC8c690NHWdO2X7VnWrYPz8MfQkE8XR0HvpQQ3jXVXll6Wvxeg
	NjaB/7GXhAU3E3RbAbdLsHll7yKF5soHhetWns44/ufWjOvyom6Rl6wM0E4WAfSGCt3GGH0DLaa
	el77vsZbVBvaGhjaxGE7h0ZOX4LA5zzc6Vgd62eRuL39pW5dRs5W/Va/mU6RTIQcpdZUaExfydG
	JeM9Y/ejGcn6mlYv6sjg9vw7P2oDEcOhq8DJDYQGKzKcAyOcsjrOVHX65XeTRCp7N12i8c5LQjO
	fjKrv/f3CgrmObCzql5qOSjslSNz7Qs4/NOmGgqtxPqwizxbXr9hswwJlCk4fuMyMkpEM2F2PtB
	DVtDPEOkpi8Y6gAtTTyWHg42t45Rg1/JAYDJPfp1zbsBgV4LD1cKtA==
X-Received: by 2002:a05:600c:8b46:b0:4a0:4a8:d444 with SMTP id 5b1f17b1804b1-4ac18c73238mr397437885e9.33.1793826587227;
        Wed, 04 Nov 2026 13:09:47 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b56b78d656sm12985485e9.0.2026.11.04.13.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 13:09:46 -0800 (PST)
From: =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Date: Wed, 04 Nov 2026 22:09:10 +0100
Subject: [PATCH v2 24/27] selftests/landlock: Use ASSERT for syscall
 failures before errno checks
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
Message-Id: <20261104-selftests-refactor-v2-24-c52f23f7ce33@gmail.com>
References: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
In-Reply-To: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
X-Mailer: b4 0.15.2

In cases where a syscall is expected to fail, but unexpectedly
succeeds, the resulting errno is undefined and we should not proceed
to check the errno.  Replace EXPECT* with ASSERT* macros for syscall
invocations where this is the case, so that we abort the tests early
in such cases.

In the errata test, check errno with EXPECT after the combined VERSION
and ERRATA flags, since nothing depends on it.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/audit_test.c      |  8 +--
 tools/testing/selftests/landlock/base_test.c       | 40 ++++++-------
 tools/testing/selftests/landlock/cap_test.c        | 30 +++++-----
 tools/testing/selftests/landlock/fs_test.c         | 50 ++++++++--------
 tools/testing/selftests/landlock/net_test.c        | 24 ++++----
 tools/testing/selftests/landlock/ns_test.c         | 68 +++++++++++-----------
 tools/testing/selftests/landlock/ptrace_test.c     | 14 ++---
 .../selftests/landlock/scoped_abstract_unix_test.c | 14 ++---
 8 files changed, 124 insertions(+), 124 deletions(-)

diff --git a/tools/testing/selftests/landlock/audit_test.c b/tools/testing/selftests/landlock/audit_test.c
index b38d0c5d5869..392e75ddfa3c 100644
--- a/tools/testing/selftests/landlock/audit_test.c
+++ b/tools/testing/selftests/landlock/audit_test.c
@@ -100,7 +100,7 @@ TEST_F(audit, layers)
 			EXPECT_EQ(0, landlock_restrict_self(ruleset_fd, 0));
 
 			/* Creates a denial to get the domain ID. */
-			EXPECT_EQ(-1, kill(getppid(), 0));
+			ASSERT_EQ(-1, kill(getppid(), 0));
 			EXPECT_EQ(EPERM, errno);
 			EXPECT_EQ(0,
 				  matches_log_signal(_metadata, self->audit_fd,
@@ -119,7 +119,7 @@ TEST_F(audit, layers)
 		}
 
 		/* Checks that we reached the maximum number of layers. */
-		EXPECT_EQ(-1, landlock_restrict_self(ruleset_fd, 0));
+		ASSERT_EQ(-1, landlock_restrict_self(ruleset_fd, 0));
 		EXPECT_EQ(E2BIG, errno);
 
 		/* Updates filter rules to match the drop record. */
@@ -711,7 +711,7 @@ TEST_F(audit_flags, signal)
 		EXPECT_EQ(0, close(ruleset_fd));
 
 		/* First signal checks to test log entries. */
-		EXPECT_EQ(-1, kill(getppid(), 0));
+		ASSERT_EQ(-1, kill(getppid(), 0));
 		EXPECT_EQ(EPERM, errno);
 
 		if (!expect_audit) {
@@ -736,7 +736,7 @@ TEST_F(audit_flags, signal)
 		}
 
 		/* Second signal checks to test audit_count_records(). */
-		EXPECT_EQ(-1, kill(getppid(), 0));
+		ASSERT_EQ(-1, kill(getppid(), 0));
 		EXPECT_EQ(EPERM, errno);
 
 		/* Makes sure there is no superfluous logged records. */
diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index 9a1d5b8aacb8..b1a729b94e7b 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -136,7 +136,7 @@ TEST(errata)
 			      NULL, 0,
 			      LANDLOCK_CREATE_RULESET_VERSION |
 				      LANDLOCK_CREATE_RULESET_ERRATA));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 
 	ASSERT_EQ(-1, landlock_create_ruleset(NULL, 0,
 					      LANDLOCK_CREATE_RULESET_ERRATA |
@@ -352,7 +352,7 @@ TEST(restrict_self_fd)
 	fd = open("/dev/null", O_RDONLY | O_CLOEXEC);
 	ASSERT_LE(0, fd);
 
-	EXPECT_EQ(-1, landlock_restrict_self(fd, 0));
+	ASSERT_EQ(-1, landlock_restrict_self(fd, 0));
 	EXPECT_EQ(EBADFD, errno);
 
 	EXPECT_EQ(0, close(fd));
@@ -369,12 +369,12 @@ TEST(restrict_self_fd_flags)
 	 * LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF accepts -1 but not any file
 	 * descriptor.
 	 */
-	EXPECT_EQ(-1, landlock_restrict_self(
+	ASSERT_EQ(-1, landlock_restrict_self(
 			      fd, LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF));
 	EXPECT_EQ(EBADFD, errno);
 
 	/* LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS requires a ruleset FD. */
-	EXPECT_EQ(-1, landlock_restrict_self(
+	ASSERT_EQ(-1, landlock_restrict_self(
 			      fd, LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS));
 	EXPECT_EQ(EBADFD, errno);
 
@@ -387,40 +387,40 @@ TEST(restrict_self_flags)
 
 	/* Tests invalid flag combinations. */
 
-	EXPECT_EQ(-1, landlock_restrict_self(-1, last_flag << 1));
+	ASSERT_EQ(-1, landlock_restrict_self(-1, last_flag << 1));
 	EXPECT_EQ(EINVAL, errno);
 
-	EXPECT_EQ(-1, landlock_restrict_self(-1, -1));
+	ASSERT_EQ(-1, landlock_restrict_self(-1, -1));
 	EXPECT_EQ(EINVAL, errno);
 
 	/* Tests valid flag combinations. */
 
-	EXPECT_EQ(-1, landlock_restrict_self(-1, 0));
+	ASSERT_EQ(-1, landlock_restrict_self(-1, 0));
 	EXPECT_EQ(EBADF, errno);
 
-	EXPECT_EQ(-1, landlock_restrict_self(
+	ASSERT_EQ(-1, landlock_restrict_self(
 			      -1, LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF));
 	EXPECT_EQ(EBADF, errno);
 
-	EXPECT_EQ(-1,
+	ASSERT_EQ(-1,
 		  landlock_restrict_self(
 			  -1,
 			  LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF |
 				  LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF));
 	EXPECT_EQ(EBADF, errno);
 
-	EXPECT_EQ(-1,
+	ASSERT_EQ(-1,
 		  landlock_restrict_self(
 			  -1,
 			  LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON |
 				  LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF));
 	EXPECT_EQ(EBADF, errno);
 
-	EXPECT_EQ(-1, landlock_restrict_self(
+	ASSERT_EQ(-1, landlock_restrict_self(
 			      -1, LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON));
 	EXPECT_EQ(EBADF, errno);
 
-	EXPECT_EQ(-1,
+	ASSERT_EQ(-1,
 		  landlock_restrict_self(
 			  -1, LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF |
 				      LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON));
@@ -428,18 +428,18 @@ TEST(restrict_self_flags)
 
 	/* LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS requires a ruleset FD. */
 
-	EXPECT_EQ(-1, landlock_restrict_self(
+	ASSERT_EQ(-1, landlock_restrict_self(
 			      -1, LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS));
 	EXPECT_EQ(EBADF, errno);
 
-	EXPECT_EQ(-1, landlock_restrict_self(
+	ASSERT_EQ(-1, landlock_restrict_self(
 			      -1, LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF |
 					  LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS));
 	EXPECT_EQ(EBADF, errno);
 
 	/* Tests with an invalid ruleset_fd. */
 
-	EXPECT_EQ(-1, landlock_restrict_self(
+	ASSERT_EQ(-1, landlock_restrict_self(
 			      -2, LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF));
 	EXPECT_EQ(EBADF, errno);
 
@@ -465,7 +465,7 @@ TEST(restrict_self_no_new_privs)
 	ASSERT_EQ(0, prctl(PR_GET_NO_NEW_PRIVS, 0, 0, 0, 0));
 
 	/* Checks that a failed call does not set no_new_privs. */
-	EXPECT_EQ(-1, landlock_restrict_self(
+	ASSERT_EQ(-1, landlock_restrict_self(
 			      -1, LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS));
 	EXPECT_EQ(EBADF, errno);
 	EXPECT_EQ(0, prctl(PR_GET_NO_NEW_PRIVS, 0, 0, 0, 0));
@@ -596,7 +596,7 @@ TEST(cred_transfer)
 	EXPECT_EQ(0, close(ruleset_fd));
 
 	/* Checks ruleset enforcement. */
-	EXPECT_EQ(-1, open("/", O_RDONLY | O_DIRECTORY | O_CLOEXEC));
+	ASSERT_EQ(-1, open("/", O_RDONLY | O_DIRECTORY | O_CLOEXEC));
 	EXPECT_EQ(EACCES, errno);
 
 	/* Needed for KEYCTL_SESSION_TO_PARENT permission checks */
@@ -610,7 +610,7 @@ TEST(cred_transfer)
 	ASSERT_LE(0, child);
 	if (child == 0) {
 		/* Checks ruleset enforcement. */
-		EXPECT_EQ(-1, open("/", O_RDONLY | O_DIRECTORY | O_CLOEXEC));
+		ASSERT_EQ(-1, open("/", O_RDONLY | O_DIRECTORY | O_CLOEXEC));
 		EXPECT_EQ(EACCES, errno);
 
 		/*
@@ -629,7 +629,7 @@ TEST(cred_transfer)
 				     0, 0, 0));
 
 		/* Re-checks ruleset enforcement. */
-		EXPECT_EQ(-1, open("/", O_RDONLY | O_DIRECTORY | O_CLOEXEC));
+		ASSERT_EQ(-1, open("/", O_RDONLY | O_DIRECTORY | O_CLOEXEC));
 		EXPECT_EQ(EACCES, errno);
 
 		_exit(_metadata->exit_code);
@@ -641,7 +641,7 @@ TEST(cred_transfer)
 	EXPECT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
 
 	/* Re-checks ruleset enforcement. */
-	EXPECT_EQ(-1, open("/", O_RDONLY | O_DIRECTORY | O_CLOEXEC));
+	ASSERT_EQ(-1, open("/", O_RDONLY | O_DIRECTORY | O_CLOEXEC));
 	EXPECT_EQ(EACCES, errno);
 }
 
diff --git a/tools/testing/selftests/landlock/cap_test.c b/tools/testing/selftests/landlock/cap_test.c
index 5a7dbd26f92f..8e6e92450b13 100644
--- a/tools/testing/selftests/landlock/cap_test.c
+++ b/tools/testing/selftests/landlock/cap_test.c
@@ -243,7 +243,7 @@ TEST(add_rule_unknown_no_runtime_effect)
 	 * CAP_SYS_ADMIN.
 	 */
 	set_cap(_metadata, CAP_SYS_ADMIN);
-	EXPECT_EQ(-1, sethostname("test", 4));
+	ASSERT_EQ(-1, sethostname("test", 4));
 	EXPECT_EQ(EPERM, errno);
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 }
@@ -366,7 +366,7 @@ TEST_F(cap_enforce, use)
 	/* Test CAP_SYS_ADMIN via sethostname. */
 	set_cap(_metadata, CAP_SYS_ADMIN);
 	if (variant->expected_sysadmin) {
-		EXPECT_EQ(-1, sethostname("test", 4));
+		ASSERT_EQ(-1, sethostname("test", 4));
 		EXPECT_EQ(variant->expected_sysadmin, errno);
 	} else {
 		EXPECT_EQ(0, sethostname("test", 4));
@@ -376,7 +376,7 @@ TEST_F(cap_enforce, use)
 	/* Test CAP_SYS_CHROOT via chroot. */
 	set_cap(_metadata, CAP_SYS_CHROOT);
 	if (variant->expected_chroot) {
-		EXPECT_EQ(-1, chroot("/"));
+		ASSERT_EQ(-1, chroot("/"));
 		EXPECT_EQ(variant->expected_chroot, errno);
 	} else {
 		EXPECT_EQ(0, chroot("/"));
@@ -532,7 +532,7 @@ TEST_F(cap_stacking, two_layers)
 	/* Test CAP_SYS_ADMIN via sethostname. */
 	set_cap(_metadata, CAP_SYS_ADMIN);
 	if (variant->expected_sysadmin) {
-		EXPECT_EQ(-1, sethostname("test", 4));
+		ASSERT_EQ(-1, sethostname("test", 4));
 		EXPECT_EQ(variant->expected_sysadmin, errno);
 	} else {
 		EXPECT_EQ(0, sethostname("test", 4));
@@ -542,7 +542,7 @@ TEST_F(cap_stacking, two_layers)
 	/* Test CAP_SYS_CHROOT via chroot. */
 	set_cap(_metadata, CAP_SYS_CHROOT);
 	if (variant->expected_chroot) {
-		EXPECT_EQ(-1, chroot("/"));
+		ASSERT_EQ(-1, chroot("/"));
 		EXPECT_EQ(variant->expected_chroot, errno);
 	} else {
 		EXPECT_EQ(0, chroot("/"));
@@ -586,7 +586,7 @@ TEST(cap_without_nnp)
 	 * CAP_SYS_ADMIN is still in effective set but Landlock denies it:
 	 * cap_capable() returns 0, then hook_capable() returns -EPERM.
 	 */
-	EXPECT_EQ(-1, sethostname("test", 4));
+	ASSERT_EQ(-1, sethostname("test", 4));
 	EXPECT_EQ(EPERM, errno);
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 
@@ -654,7 +654,7 @@ TEST(cap_userns_ownership_bypass)
 		 * (from user NS creation), so cap_capable() returns 0.  But
 		 * Landlock denies because no rule allows CAP_SYS_CHROOT.
 		 */
-		EXPECT_EQ(-1, chroot("/"));
+		ASSERT_EQ(-1, chroot("/"));
 		EXPECT_EQ(EPERM, errno);
 
 		_exit(_metadata->exit_code);
@@ -810,7 +810,7 @@ TEST_F(cap_audit, denied)
 
 	/* Deny CAP_SYS_CHROOT (no allow rule). */
 	set_cap(_metadata, CAP_SYS_CHROOT);
-	EXPECT_EQ(-1, chroot("/"));
+	ASSERT_EQ(-1, chroot("/"));
 	EXPECT_EQ(EPERM, errno);
 	clear_cap(_metadata, CAP_SYS_CHROOT);
 
@@ -896,7 +896,7 @@ TEST_F(cap_audit, quieted)
 	EXPECT_EQ(0, close(ruleset_fd));
 
 	set_cap(_metadata, CAP_SYS_CHROOT);
-	EXPECT_EQ(-1, chroot("/"));
+	ASSERT_EQ(-1, chroot("/"));
 	EXPECT_EQ(EPERM, errno);
 	clear_cap(_metadata, CAP_SYS_CHROOT);
 
@@ -905,7 +905,7 @@ TEST_F(cap_audit, quieted)
 	 * denial IS logged.  This proves quieting is per-member, not global.
 	 */
 	set_cap(_metadata, CAP_SYS_ADMIN);
-	EXPECT_EQ(-1, sethostname("test", 4));
+	ASSERT_EQ(-1, sethostname("test", 4));
 	EXPECT_EQ(EPERM, errno);
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 
@@ -952,7 +952,7 @@ TEST_F(cap_audit, quiet_youngest_layer_wins)
 	EXPECT_EQ(0, close(ruleset_fd));
 
 	set_cap(_metadata, CAP_SYS_CHROOT);
-	EXPECT_EQ(-1, chroot("/"));
+	ASSERT_EQ(-1, chroot("/"));
 	EXPECT_EQ(EPERM, errno);
 	clear_cap(_metadata, CAP_SYS_CHROOT);
 
@@ -986,7 +986,7 @@ TEST_F(cap_audit, quiet_unknown_bit_no_effect)
 	EXPECT_EQ(0, close(ruleset_fd));
 
 	set_cap(_metadata, CAP_SYS_CHROOT);
-	EXPECT_EQ(-1, chroot("/"));
+	ASSERT_EQ(-1, chroot("/"));
 	EXPECT_EQ(EPERM, errno);
 	clear_cap(_metadata, CAP_SYS_CHROOT);
 
@@ -1059,7 +1059,7 @@ TEST_F(cap_audit, noaudit_probe_not_logged)
 	 * domain IS logged.  This proves the empty record set above is caused
 	 * by CAP_OPT_NOAUDIT, not by an always-allow or always-silent bug.
 	 */
-	EXPECT_EQ(-1, sethostname("test", 4));
+	ASSERT_EQ(-1, sethostname("test", 4));
 	EXPECT_EQ(EPERM, errno);
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 
@@ -1271,12 +1271,12 @@ static void exercise_cap_trace_denial(struct __test_metadata *const _metadata,
 		EXPECT_EQ(0, close(fd));
 
 		/* Control: an ordinary denial in the same domain is traced. */
-		EXPECT_EQ(-1, chroot("/"));
+		ASSERT_EQ(-1, chroot("/"));
 		EXPECT_EQ(EPERM, errno);
 		clear_cap(_metadata, CAP_SYS_ADMIN);
 		clear_cap(_metadata, CAP_SYS_CHROOT);
 	} else {
-		EXPECT_EQ(-1, chroot("/"));
+		ASSERT_EQ(-1, chroot("/"));
 		EXPECT_EQ(EPERM, errno);
 		clear_cap(_metadata, CAP_SYS_CHROOT);
 	}
diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 78b2bf06b6ee..fe1ca9c2d949 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -671,7 +671,7 @@ TEST_F_FORK(layout0, rule_with_unknown_access)
 
 	for (access = 1ULL << 63; access != ACCESS_LAST; access >>= 1) {
 		path_beneath.allowed_access = access;
-		EXPECT_EQ(-1, landlock_add_rule(ruleset_fd,
+		ASSERT_EQ(-1, landlock_add_rule(ruleset_fd,
 						LANDLOCK_RULE_PATH_BENEATH,
 						&path_beneath, 0));
 		EXPECT_EQ(EINVAL, errno);
@@ -705,7 +705,7 @@ TEST_F_FORK(layout1, rule_with_unhandled_access)
 		if (access == ruleset_attr.handled_access_fs) {
 			EXPECT_EQ(0, err);
 		} else {
-			EXPECT_EQ(-1, err);
+			ASSERT_EQ(-1, err);
 			EXPECT_EQ(EINVAL, errno);
 		}
 	}
@@ -2062,7 +2062,7 @@ TEST_F_FORK(layout1, umount_sandboxer)
 
 	/* Tests that the sandboxer is tied to its mount point. */
 	set_cap(_metadata, CAP_SYS_ADMIN);
-	EXPECT_EQ(-1, umount(dir_s3d2));
+	ASSERT_EQ(-1, umount(dir_s3d2));
 	EXPECT_EQ(EBUSY, errno);
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 
@@ -2257,7 +2257,7 @@ TEST_F_FORK(layout1, rename_whiteout_denied)
 	 * file1_s3d3 is in dir_s3d2 (tmpfs), so it supports RENAME_WHITEOUT.
 	 * Denied, because whiteout creation is guarded with MAKE_REG.
 	 */
-	EXPECT_EQ(-1, renameat2(AT_FDCWD, file1_s3d3, AT_FDCWD,
+	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s3d3, AT_FDCWD,
 				TMP_DIR "/s3d1/s3d2/s3d3/f2", RENAME_WHITEOUT));
 	EXPECT_EQ(EACCES, errno);
 }
@@ -2347,7 +2347,7 @@ TEST_F_FORK(layout1, rename_whiteout_reparenting)
 	 * there, even though it is granted in the destination directory
 	 * dir_s3d3.
 	 */
-	EXPECT_EQ(-1, renameat2(AT_FDCWD, file1_s3d4, AT_FDCWD,
+	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s3d4, AT_FDCWD,
 				TMP_DIR "/s3d1/s3d2/s3d3/f2", RENAME_WHITEOUT));
 	EXPECT_EQ(EACCES, errno);
 
@@ -2397,7 +2397,7 @@ TEST_F_FORK(layout1, rename_whiteout_exchange)
 	 * dir_s3d4, even though it is granted in the whiteout object's own
 	 * directory dir_s3d3.
 	 */
-	EXPECT_EQ(-1, renameat2(AT_FDCWD, file1_s3d4, AT_FDCWD, whiteout_s3d3,
+	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s3d4, AT_FDCWD, whiteout_s3d3,
 				RENAME_EXCHANGE));
 	EXPECT_EQ(EACCES, errno);
 
@@ -2630,11 +2630,11 @@ TEST_F_FORK(layout1, refer_mount_root_deny)
 	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_MAKE_DIR, NULL);
 
 	/* Link denied by Landlock: EACCES. */
-	EXPECT_EQ(-1, linkat(root_fd, ".", root_fd, "does_not_exist", 0));
+	ASSERT_EQ(-1, linkat(root_fd, ".", root_fd, "does_not_exist", 0));
 	EXPECT_EQ(EACCES, errno);
 
 	/* renameat2() always returns EBUSY. */
-	EXPECT_EQ(-1, renameat2(root_fd, ".", root_fd, "does_not_exist", 0));
+	ASSERT_EQ(-1, renameat2(root_fd, ".", root_fd, "does_not_exist", 0));
 	EXPECT_EQ(EBUSY, errno);
 
 	EXPECT_EQ(0, close(root_fd));
@@ -5394,14 +5394,14 @@ TEST_F_FORK(layout1_bind, path_disconnected_rename)
 		 * Tests that access widening checks indeed prevents us from renaming it
 		 * back.
 		 */
-		EXPECT_EQ(-1, rename(dir_s4d2, dir_s1d3));
+		ASSERT_EQ(-1, rename(dir_s4d2, dir_s1d3));
 		EXPECT_EQ(EXDEV, errno);
 
 		/*
 		 * Including through the now disconnected fd (but it should return
 		 * EXDEV).
 		 */
-		EXPECT_EQ(-1, renameat(bind_s1d3_fd, file1_name, AT_FDCWD,
+		ASSERT_EQ(-1, renameat(bind_s1d3_fd, file1_name, AT_FDCWD,
 				       file1_s2d2));
 		EXPECT_EQ(EXDEV, errno);
 		_exit(_metadata->exit_code);
@@ -7626,12 +7626,12 @@ TEST_F(audit_layout1, remove_dir)
 
 	enforce_fs(_metadata, ACCESS_ALL, NULL);
 
-	EXPECT_EQ(-1, rmdir(dir_s1d3));
+	ASSERT_EQ(-1, rmdir(dir_s1d3));
 	EXPECT_EQ(EACCES, errno);
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
 				    "fs\\.remove_dir", dir_s1d2));
 
-	EXPECT_EQ(-1, unlinkat(AT_FDCWD, dir_s1d3, AT_REMOVEDIR));
+	ASSERT_EQ(-1, unlinkat(AT_FDCWD, dir_s1d3, AT_REMOVEDIR));
 	EXPECT_EQ(EACCES, errno);
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
 				    "fs\\.remove_dir", dir_s1d2));
@@ -7647,7 +7647,7 @@ TEST_F(audit_layout1, remove_file)
 
 	enforce_fs(_metadata, ACCESS_ALL, NULL);
 
-	EXPECT_EQ(-1, unlink(file1_s1d3));
+	ASSERT_EQ(-1, unlink(file1_s1d3));
 	EXPECT_EQ(EACCES, errno);
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
 				    "fs\\.remove_file", dir_s1d3));
@@ -7665,7 +7665,7 @@ TEST_F(audit_layout1, make_char)
 
 	enforce_fs(_metadata, ACCESS_ALL, NULL);
 
-	EXPECT_EQ(-1, mknod(file1_s1d3, S_IFCHR | 0644, makedev(7, 0)));
+	ASSERT_EQ(-1, mknod(file1_s1d3, S_IFCHR | 0644, makedev(7, 0)));
 	EXPECT_EQ(EACCES, errno);
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.make_char",
 				    dir_s1d3));
@@ -7684,7 +7684,7 @@ TEST_F(audit_layout1, make_whiteout)
 	enforce_fs(_metadata, ACCESS_ALL, NULL);
 
 	/* Whiteout creation is denied and logged as fs.make_reg. */
-	EXPECT_EQ(-1, mknod(file1_s1d3, S_IFCHR | 0644, makedev(0, 0)));
+	ASSERT_EQ(-1, mknod(file1_s1d3, S_IFCHR | 0644, makedev(0, 0)));
 	EXPECT_EQ(EACCES, errno);
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.make_reg",
 				    dir_s1d3));
@@ -7702,7 +7702,7 @@ TEST_F(audit_layout1, make_dir)
 
 	enforce_fs(_metadata, ACCESS_ALL, NULL);
 
-	EXPECT_EQ(-1, mkdir(file1_s1d3, 0755));
+	ASSERT_EQ(-1, mkdir(file1_s1d3, 0755));
 	EXPECT_EQ(EACCES, errno);
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.make_dir",
 				    dir_s1d3));
@@ -7720,7 +7720,7 @@ TEST_F(audit_layout1, make_reg)
 
 	enforce_fs(_metadata, ACCESS_ALL, NULL);
 
-	EXPECT_EQ(-1, mknod(file1_s1d3, S_IFREG | 0644, 0));
+	ASSERT_EQ(-1, mknod(file1_s1d3, S_IFREG | 0644, 0));
 	EXPECT_EQ(EACCES, errno);
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.make_reg",
 				    dir_s1d3));
@@ -7738,7 +7738,7 @@ TEST_F(audit_layout1, make_sock)
 
 	enforce_fs(_metadata, ACCESS_ALL, NULL);
 
-	EXPECT_EQ(-1, mknod(file1_s1d3, S_IFSOCK | 0644, 0));
+	ASSERT_EQ(-1, mknod(file1_s1d3, S_IFSOCK | 0644, 0));
 	EXPECT_EQ(EACCES, errno);
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.make_sock",
 				    dir_s1d3));
@@ -7756,7 +7756,7 @@ TEST_F(audit_layout1, make_fifo)
 
 	enforce_fs(_metadata, ACCESS_ALL, NULL);
 
-	EXPECT_EQ(-1, mknod(file1_s1d3, S_IFIFO | 0644, 0));
+	ASSERT_EQ(-1, mknod(file1_s1d3, S_IFIFO | 0644, 0));
 	EXPECT_EQ(EACCES, errno);
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.make_fifo",
 				    dir_s1d3));
@@ -7774,7 +7774,7 @@ TEST_F(audit_layout1, make_block)
 
 	enforce_fs(_metadata, ACCESS_ALL, NULL);
 
-	EXPECT_EQ(-1, mknod(file1_s1d3, S_IFBLK | 0644, 0));
+	ASSERT_EQ(-1, mknod(file1_s1d3, S_IFBLK | 0644, 0));
 	EXPECT_EQ(EACCES, errno);
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
 				    "fs\\.make_block", dir_s1d3));
@@ -7792,7 +7792,7 @@ TEST_F(audit_layout1, make_sym)
 
 	enforce_fs(_metadata, ACCESS_ALL, NULL);
 
-	EXPECT_EQ(-1, symlink("target", file1_s1d3));
+	ASSERT_EQ(-1, symlink("target", file1_s1d3));
 	EXPECT_EQ(EACCES, errno);
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.make_sym",
 				    dir_s1d3));
@@ -7810,7 +7810,7 @@ TEST_F(audit_layout1, refer_handled)
 
 	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_REFER, NULL);
 
-	EXPECT_EQ(-1, link(file1_s1d1, file1_s1d3));
+	ASSERT_EQ(-1, link(file1_s1d1, file1_s1d3));
 	EXPECT_EQ(EXDEV, errno);
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.refer",
 				    dir_s1d1));
@@ -7834,7 +7834,7 @@ TEST_F(audit_layout1, refer_make)
 		   LANDLOCK_ACCESS_FS_MAKE_REG | LANDLOCK_ACCESS_FS_REFER,
 		   NULL);
 
-	EXPECT_EQ(-1, link(file1_s1d1, file1_s1d3));
+	ASSERT_EQ(-1, link(file1_s1d1, file1_s1d3));
 	EXPECT_EQ(EACCES, errno);
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.refer",
 				    dir_s1d1));
@@ -7931,7 +7931,7 @@ TEST_F(audit_layout1, truncate)
 
 	enforce_fs(_metadata, ACCESS_ALL, NULL);
 
-	EXPECT_EQ(-1, truncate(file1_s1d3, 0));
+	ASSERT_EQ(-1, truncate(file1_s1d3, 0));
 	EXPECT_EQ(EACCES, errno);
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.truncate",
 				    file1_s1d3));
@@ -8005,7 +8005,7 @@ TEST_F(audit_layout1, mount)
 	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_EXECUTE, NULL);
 
 	set_cap(_metadata, CAP_SYS_ADMIN);
-	EXPECT_EQ(-1, mount(NULL, dir_s3d2, NULL, MS_RDONLY, NULL));
+	ASSERT_EQ(-1, mount(NULL, dir_s3d2, NULL, MS_RDONLY, NULL));
 	EXPECT_EQ(EPERM, errno);
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
index 563e2214390b..51bcb4740dde 100644
--- a/tools/testing/selftests/landlock/net_test.c
+++ b/tools/testing/selftests/landlock/net_test.c
@@ -1361,11 +1361,11 @@ TEST_F(protocol, tcp_fastopen)
 	}
 
 	if (restricted) {
-		EXPECT_EQ(-1, read(client_fd, &buf, 1));
+		ASSERT_EQ(-1, read(client_fd, &buf, 1));
 		EXPECT_EQ(ENOTCONN, errno);
 	} else if (self->srv0.protocol.domain == AF_UNIX &&
 		   self->srv0.protocol.type == SOCK_STREAM) {
-		EXPECT_EQ(-1, read(client_fd, &buf, 1));
+		ASSERT_EQ(-1, read(client_fd, &buf, 1));
 		EXPECT_EQ(EINVAL, errno);
 	} else {
 		EXPECT_EQ(1, read(client_fd, &buf, 1));
@@ -2261,7 +2261,7 @@ TEST_F(mini, ruleset_with_unknown_access)
 			.handled_access_net = access_mask,
 		};
 
-		EXPECT_EQ(-1, landlock_create_ruleset(&ruleset_attr,
+		ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr,
 						      sizeof(ruleset_attr), 0));
 		EXPECT_EQ(EINVAL, errno);
 	}
@@ -2284,7 +2284,7 @@ TEST_F(mini, rule_with_unknown_access)
 
 	for (access = 1ULL << 63; access != ACCESS_LAST; access >>= 1) {
 		net_port.allowed_access = access;
-		EXPECT_EQ(-1,
+		ASSERT_EQ(-1,
 			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
 					    &net_port, 0));
 		EXPECT_EQ(EINVAL, errno);
@@ -2316,7 +2316,7 @@ TEST_F(mini, rule_with_unhandled_access)
 		if (access == ruleset_attr.handled_access_net) {
 			EXPECT_EQ(0, err);
 		} else {
-			EXPECT_EQ(-1, err);
+			ASSERT_EQ(-1, err);
 			EXPECT_EQ(EINVAL, errno);
 		}
 	}
@@ -2349,12 +2349,12 @@ TEST_F(mini, inval)
 	ASSERT_LE(0, ruleset_fd);
 
 	/* Checks unhandled allowed_access. */
-	EXPECT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
+	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
 					&tcp_bind_connect, 0));
 	EXPECT_EQ(EINVAL, errno);
 
 	/* Checks zero access value. */
-	EXPECT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
+	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
 					&tcp_denied, 0));
 	EXPECT_EQ(ENOMSG, errno);
 
@@ -2414,15 +2414,15 @@ TEST_F(mini, tcp_port_overflow)
 	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
 				       &port_max_bind, 0));
 
-	EXPECT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
+	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
 					&port_overflow1, 0));
 	EXPECT_EQ(EINVAL, errno);
 
-	EXPECT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
+	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
 					&port_overflow2, 0));
 	EXPECT_EQ(EINVAL, errno);
 
-	EXPECT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
+	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
 					&port_overflow3, 0));
 	EXPECT_EQ(EINVAL, errno);
 
@@ -2430,7 +2430,7 @@ TEST_F(mini, tcp_port_overflow)
 	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
 				       &port_max_connect, 0));
 
-	EXPECT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
+	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
 					&port_overflow4, 0));
 	EXPECT_EQ(EINVAL, errno);
 
@@ -2549,7 +2549,7 @@ TEST_F(ipv4_tcp, with_fs)
 	EXPECT_EQ(0, close(dir_fd));
 
 	dir_fd = open("/", O_RDONLY);
-	EXPECT_EQ(-1, dir_fd);
+	ASSERT_EQ(-1, dir_fd);
 	EXPECT_EQ(EACCES, errno);
 
 	/* Tests port binding. */
diff --git a/tools/testing/selftests/landlock/ns_test.c b/tools/testing/selftests/landlock/ns_test.c
index 57d03233bf6d..96b1264c4353 100644
--- a/tools/testing/selftests/landlock/ns_test.c
+++ b/tools/testing/selftests/landlock/ns_test.c
@@ -296,7 +296,7 @@ TEST(add_rule_unknown_no_runtime_effect)
 	 * CLONE_NEWUTS is a real, known CLONE_NEW* type but was not authorised
 	 * by the rule above; deny-by-default applies.
 	 */
-	EXPECT_EQ(-1, unshare(CLONE_NEWUTS));
+	ASSERT_EQ(-1, unshare(CLONE_NEWUTS));
 	EXPECT_EQ(EPERM, errno);
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 }
@@ -346,7 +346,7 @@ TEST(add_rule_unknown_no_runtime_effect_setns)
 	 * CLONE_NEWUTS is a real, known CLONE_NEW* type but was not authorised
 	 * by the rule above; deny-by-default applies at the install hook.
 	 */
-	EXPECT_EQ(-1, setns(ns_fd, CLONE_NEWUTS));
+	ASSERT_EQ(-1, setns(ns_fd, CLONE_NEWUTS));
 	EXPECT_EQ(EPERM, errno);
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 	EXPECT_EQ(0, close(ns_fd));
@@ -707,7 +707,7 @@ TEST_F(ns_create, unshare)
 
 	err = unshare(variant->namespace_types);
 	if (variant->expected_result) {
-		EXPECT_EQ(-1, err);
+		ASSERT_EQ(-1, err);
 		EXPECT_EQ(variant->expected_result, errno);
 	} else {
 		EXPECT_EQ(0, err);
@@ -753,7 +753,7 @@ TEST_F(ns_create, clone3)
 		_exit(EXIT_SUCCESS);
 
 	if (variant->expected_result) {
-		EXPECT_EQ(-1, pid);
+		ASSERT_EQ(-1, pid);
 		EXPECT_EQ(variant->expected_result, errno);
 	} else {
 		ASSERT_LE(0, pid);
@@ -821,7 +821,7 @@ TEST_F(ns_create, setns)
 
 	err = setns(ns_fd, variant->namespace_types);
 	if (expected) {
-		EXPECT_EQ(-1, err);
+		ASSERT_EQ(-1, err);
 		EXPECT_EQ(expected, errno);
 	} else {
 		EXPECT_EQ(0, err);
@@ -949,7 +949,7 @@ TEST_F(ns_stacking, two_layers)
 	if (expect_success) {
 		EXPECT_EQ(0, unshare(CLONE_NEWUSER));
 	} else {
-		EXPECT_EQ(-1, unshare(CLONE_NEWUSER));
+		ASSERT_EQ(-1, unshare(CLONE_NEWUSER));
 		EXPECT_EQ(EPERM, errno);
 	}
 }
@@ -997,7 +997,7 @@ TEST(combined_cap_ns)
 
 	/* CAP_SYS_CHROOT denied (not in allowed capability rules). */
 	set_cap(_metadata, CAP_SYS_CHROOT);
-	EXPECT_EQ(-1, chroot("/"));
+	ASSERT_EQ(-1, chroot("/"));
 	EXPECT_EQ(EPERM, errno);
 	clear_cap(_metadata, CAP_SYS_CHROOT);
 
@@ -1007,7 +1007,7 @@ TEST(combined_cap_ns)
 	 * to pass, so that Landlock's hook is actually reached.
 	 */
 	set_cap(_metadata, CAP_SYS_ADMIN);
-	EXPECT_EQ(-1, unshare(CLONE_NEWUTS));
+	ASSERT_EQ(-1, unshare(CLONE_NEWUTS));
 	EXPECT_EQ(EPERM, errno);
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 
@@ -1040,7 +1040,7 @@ TEST(ns_create_partial)
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 
 	/* User namespace should be denied (no rule). */
-	EXPECT_EQ(-1, unshare(CLONE_NEWUSER));
+	ASSERT_EQ(-1, unshare(CLONE_NEWUSER));
 	EXPECT_EQ(EPERM, errno);
 }
 
@@ -1117,7 +1117,7 @@ TEST_F(ns_mount_fd, open_tree_clone)
 	fd = sys_open_tree(AT_FDCWD, "/",
 			   OPEN_TREE_CLONE | OPEN_TREE_CLOEXEC | AT_RECURSIVE);
 	if (variant->expected_errno) {
-		EXPECT_EQ(-1, fd);
+		ASSERT_EQ(-1, fd);
 		EXPECT_EQ(variant->expected_errno, errno);
 	} else {
 		ASSERT_LE(0, fd);
@@ -1152,7 +1152,7 @@ TEST_F(ns_mount_fd, open_tree_namespace)
 			   OPEN_TREE_NAMESPACE | OPEN_TREE_CLOEXEC |
 				   AT_RECURSIVE);
 	if (variant->expected_errno) {
-		EXPECT_EQ(-1, fd);
+		ASSERT_EQ(-1, fd);
 		EXPECT_EQ(variant->expected_errno, errno);
 	} else {
 		ASSERT_LE(0, fd);
@@ -1189,7 +1189,7 @@ TEST_F(ns_mount_fd, fsmount_default)
 
 	mnt_fd = sys_fsmount(fs_fd, FSMOUNT_CLOEXEC, 0);
 	if (variant->expected_errno) {
-		EXPECT_EQ(-1, mnt_fd);
+		ASSERT_EQ(-1, mnt_fd);
 		EXPECT_EQ(variant->expected_errno, errno);
 	} else {
 		ASSERT_LE(0, mnt_fd);
@@ -1225,7 +1225,7 @@ TEST_F(ns_mount_fd, fsmount_namespace)
 
 	mnt_fd = sys_fsmount(fs_fd, FSMOUNT_CLOEXEC | FSMOUNT_NAMESPACE, 0);
 	if (variant->expected_errno) {
-		EXPECT_EQ(-1, mnt_fd);
+		ASSERT_EQ(-1, mnt_fd);
 		EXPECT_EQ(variant->expected_errno, errno);
 	} else {
 		ASSERT_LE(0, mnt_fd);
@@ -1297,7 +1297,7 @@ TEST_F(ns_create_multi_flag, unshare)
 
 		err = unshare(CLONE_NEWUSER | CLONE_NEWUTS);
 		if (variant->expected_errno) {
-			EXPECT_EQ(-1, err);
+			ASSERT_EQ(-1, err);
 			EXPECT_EQ(variant->expected_errno, errno);
 		} else {
 			EXPECT_EQ(0, err);
@@ -1425,7 +1425,7 @@ TEST_F(setns_cross_process, setns)
 
 	set_cap(_metadata, CAP_SYS_ADMIN);
 	if (variant->expected_setns) {
-		EXPECT_EQ(-1, setns(ns_fd, CLONE_NEWUTS));
+		ASSERT_EQ(-1, setns(ns_fd, CLONE_NEWUTS));
 		EXPECT_EQ(variant->expected_setns, errno);
 	} else {
 		EXPECT_EQ(0, setns(ns_fd, CLONE_NEWUTS));
@@ -1480,7 +1480,7 @@ TEST(setns_and_create)
 	ASSERT_EQ(0, unshare(CLONE_NEWUTS));
 
 	/* IPC unshare: denied by NS rule (type not allowed). */
-	EXPECT_EQ(-1, unshare(CLONE_NEWIPC));
+	ASSERT_EQ(-1, unshare(CLONE_NEWIPC));
 	EXPECT_EQ(EPERM, errno);
 
 	/* setns into current UTS: allowed by NS rule. */
@@ -1495,7 +1495,7 @@ TEST(setns_and_create)
 	 * needed (no capable() call from the kernel for user NS).  Denied
 	 * because CLONE_NEWUSER is not in the allowed namespace types.
 	 */
-	EXPECT_EQ(-1, unshare(CLONE_NEWUSER));
+	ASSERT_EQ(-1, unshare(CLONE_NEWUSER));
 	EXPECT_EQ(EPERM, errno);
 }
 
@@ -1542,7 +1542,7 @@ TEST(two_permissions_cap_denied)
 	 * fails before the namespace hook is reached.
 	 */
 	set_cap(_metadata, CAP_SYS_ADMIN);
-	EXPECT_EQ(-1, unshare(CLONE_NEWUTS));
+	ASSERT_EQ(-1, unshare(CLONE_NEWUTS));
 	EXPECT_EQ(EPERM, errno);
 
 	/*
@@ -1553,7 +1553,7 @@ TEST(two_permissions_cap_denied)
 	 */
 	ns_fd = open("/proc/self/ns/uts", O_RDONLY);
 	ASSERT_LE(0, ns_fd);
-	EXPECT_EQ(-1, setns(ns_fd, CLONE_NEWUTS));
+	ASSERT_EQ(-1, setns(ns_fd, CLONE_NEWUTS));
 	EXPECT_EQ(EPERM, errno);
 	EXPECT_EQ(0, close(ns_fd));
 	clear_cap(_metadata, CAP_SYS_ADMIN);
@@ -1605,7 +1605,7 @@ TEST(two_permissions_combined_unshare_denied)
 	 * created.
 	 */
 	set_cap(_metadata, CAP_SYS_ADMIN);
-	EXPECT_EQ(-1, unshare(CLONE_NEWUSER | CLONE_NEWUTS));
+	ASSERT_EQ(-1, unshare(CLONE_NEWUSER | CLONE_NEWUTS));
 	EXPECT_EQ(EPERM, errno);
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 
@@ -1712,7 +1712,7 @@ TEST(two_permissions_ns_denied)
 	 * in the allowed namespace types, so the Landlock namespace hook denies
 	 * it.
 	 */
-	EXPECT_EQ(-1, unshare(CLONE_NEWUTS));
+	ASSERT_EQ(-1, unshare(CLONE_NEWUTS));
 	EXPECT_EQ(EPERM, errno);
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 }
@@ -1764,7 +1764,7 @@ TEST(two_permissions_mnt_setns)
 	 */
 	set_cap(_metadata, CAP_SYS_ADMIN);
 	set_cap(_metadata, CAP_SYS_CHROOT);
-	EXPECT_EQ(-1, setns(ns_fd, CLONE_NEWNS));
+	ASSERT_EQ(-1, setns(ns_fd, CLONE_NEWNS));
 	EXPECT_EQ(EPERM, errno);
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 	clear_cap(_metadata, CAP_SYS_CHROOT);
@@ -1785,7 +1785,7 @@ TEST(two_permissions_mnt_setns)
 	 */
 	set_cap(_metadata, CAP_SYS_ADMIN);
 	set_cap(_metadata, CAP_SYS_CHROOT);
-	EXPECT_EQ(-1, setns(ns_fd, CLONE_NEWNS));
+	ASSERT_EQ(-1, setns(ns_fd, CLONE_NEWNS));
 	EXPECT_EQ(EPERM, errno);
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 	clear_cap(_metadata, CAP_SYS_CHROOT);
@@ -1880,7 +1880,7 @@ TEST(setns_inherited_fd)
 		EXPECT_EQ(0, close(ruleset_fd));
 
 		set_cap(_metadata, CAP_SYS_ADMIN);
-		EXPECT_EQ(-1, setns(ns_fd, CLONE_NEWUTS));
+		ASSERT_EQ(-1, setns(ns_fd, CLONE_NEWUTS));
 		EXPECT_EQ(EPERM, errno);
 		clear_cap(_metadata, CAP_SYS_ADMIN);
 
@@ -1971,7 +1971,7 @@ TEST_F(ns_audit, create_denied)
 	EXPECT_EQ(0, close(ruleset_fd));
 
 	set_cap(_metadata, CAP_SYS_ADMIN);
-	EXPECT_EQ(-1, unshare(CLONE_NEWUTS));
+	ASSERT_EQ(-1, unshare(CLONE_NEWUTS));
 	EXPECT_EQ(EPERM, errno);
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 
@@ -2053,7 +2053,7 @@ TEST_F(ns_audit, setns_denied)
 	ASSERT_EQ(0, ioctl(ns_fd, NS_GET_ID, &ns_id));
 
 	set_cap(_metadata, CAP_SYS_ADMIN);
-	EXPECT_EQ(-1, setns(ns_fd, CLONE_NEWUTS));
+	ASSERT_EQ(-1, setns(ns_fd, CLONE_NEWUTS));
 	EXPECT_EQ(EPERM, errno);
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 	EXPECT_EQ(0, close(ns_fd));
@@ -2089,7 +2089,7 @@ TEST_F(ns_audit, create_quieted)
 	EXPECT_EQ(0, close(ruleset_fd));
 
 	set_cap(_metadata, CAP_SYS_ADMIN);
-	EXPECT_EQ(-1, unshare(CLONE_NEWUTS));
+	ASSERT_EQ(-1, unshare(CLONE_NEWUTS));
 	EXPECT_EQ(EPERM, errno);
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 
@@ -2117,7 +2117,7 @@ TEST_F(ns_audit, setns_quieted)
 	ASSERT_LE(0, ns_fd);
 
 	set_cap(_metadata, CAP_SYS_ADMIN);
-	EXPECT_EQ(-1, setns(ns_fd, CLONE_NEWUTS));
+	ASSERT_EQ(-1, setns(ns_fd, CLONE_NEWUTS));
 	EXPECT_EQ(EPERM, errno);
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 	EXPECT_EQ(0, close(ns_fd));
@@ -2147,7 +2147,7 @@ TEST_F(ns_audit, quiet_is_per_member)
 	EXPECT_EQ(0, close(ruleset_fd));
 
 	set_cap(_metadata, CAP_SYS_ADMIN);
-	EXPECT_EQ(-1, unshare(CLONE_NEWUTS));
+	ASSERT_EQ(-1, unshare(CLONE_NEWUTS));
 	EXPECT_EQ(EPERM, errno);
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 
@@ -2179,7 +2179,7 @@ TEST_F(ns_audit, quiet_unknown_bit_no_effect)
 	EXPECT_EQ(0, close(ruleset_fd));
 
 	set_cap(_metadata, CAP_SYS_ADMIN);
-	EXPECT_EQ(-1, unshare(CLONE_NEWUTS));
+	ASSERT_EQ(-1, unshare(CLONE_NEWUTS));
 	EXPECT_EQ(EPERM, errno);
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 
@@ -2208,7 +2208,7 @@ TEST_F(ns_audit, allow_and_quiet)
 	set_cap(_metadata, CAP_SYS_ADMIN);
 	EXPECT_EQ(0, unshare(CLONE_NEWNET));
 	/* Quieted member: denied but not logged. */
-	EXPECT_EQ(-1, unshare(CLONE_NEWUTS));
+	ASSERT_EQ(-1, unshare(CLONE_NEWUTS));
 	EXPECT_EQ(EPERM, errno);
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 
@@ -2266,7 +2266,7 @@ TEST_F(ns_audit, quiet_youngest_layer_wins)
 	EXPECT_EQ(0, close(ruleset_fd));
 
 	set_cap(_metadata, CAP_SYS_ADMIN);
-	EXPECT_EQ(-1, unshare(CLONE_NEWUTS));
+	ASSERT_EQ(-1, unshare(CLONE_NEWUTS));
 	EXPECT_EQ(EPERM, errno);
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 
@@ -2302,7 +2302,7 @@ TEST_F(ns_audit, quiet_parent_only_denying_layer)
 	EXPECT_EQ(0, close(ruleset_fd));
 
 	set_cap(_metadata, CAP_SYS_ADMIN);
-	EXPECT_EQ(-1, unshare(CLONE_NEWUTS));
+	ASSERT_EQ(-1, unshare(CLONE_NEWUTS));
 	EXPECT_EQ(EPERM, errno);
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 
@@ -2498,7 +2498,7 @@ static void test_ns_trace_denial(struct __test_metadata *const _metadata,
 		ret = setns(ns_fd, CLONE_NEWUTS);
 	else
 		ret = unshare(CLONE_NEWUTS);
-	EXPECT_EQ(-1, ret);
+	ASSERT_EQ(-1, ret);
 	EXPECT_EQ(EPERM, errno);
 
 	clear_cap(_metadata, CAP_SYS_ADMIN);
diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/testing/selftests/landlock/ptrace_test.c
index 4fd2b440aa45..ea8e4be6659e 100644
--- a/tools/testing/selftests/landlock/ptrace_test.c
+++ b/tools/testing/selftests/landlock/ptrace_test.c
@@ -204,7 +204,7 @@ TEST_F(scoped_domains, trace)
 		if (can_trace_parent) {
 			EXPECT_EQ(0, ret);
 		} else {
-			EXPECT_EQ(-1, ret);
+			ASSERT_EQ(-1, ret);
 			EXPECT_EQ(EPERM, errno);
 		}
 		if (ret == 0) {
@@ -218,7 +218,7 @@ TEST_F(scoped_domains, trace)
 		if (can_trace_child) {
 			EXPECT_EQ(0, ret);
 		} else {
-			EXPECT_EQ(-1, ret);
+			ASSERT_EQ(-1, ret);
 			EXPECT_EQ(EPERM, errno);
 		}
 
@@ -259,7 +259,7 @@ TEST_F(scoped_domains, trace)
 		ASSERT_EQ(0, ptrace(PTRACE_DETACH, child, NULL, 0));
 	} else {
 		/* The child should not be traced by the parent. */
-		EXPECT_EQ(-1, ptrace(PTRACE_DETACH, child, NULL, 0));
+		ASSERT_EQ(-1, ptrace(PTRACE_DETACH, child, NULL, 0));
 		EXPECT_EQ(ESRCH, errno);
 	}
 
@@ -276,7 +276,7 @@ TEST_F(scoped_domains, trace)
 	if (can_trace_child) {
 		EXPECT_EQ(0, ret);
 	} else {
-		EXPECT_EQ(-1, ret);
+		ASSERT_EQ(-1, ret);
 		EXPECT_EQ(EPERM, errno);
 	}
 
@@ -377,7 +377,7 @@ TEST_F(audit, trace)
 		ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1));
 
 		/* Tests child PTRACE_TRACEME. */
-		EXPECT_EQ(-1, ptrace(PTRACE_TRACEME));
+		ASSERT_EQ(-1, ptrace(PTRACE_TRACEME));
 		EXPECT_EQ(EPERM, errno);
 		/* We should see the child process. */
 		EXPECT_EQ(0, matches_log_ptrace(_metadata, self->audit_fd,
@@ -414,11 +414,11 @@ TEST_F(audit, trace)
 	ASSERT_EQ(1, read(pipe_child[0], &buf_parent, 1));
 
 	/* The child should not be traced by the parent. */
-	EXPECT_EQ(-1, ptrace(PTRACE_DETACH, child, NULL, 0));
+	ASSERT_EQ(-1, ptrace(PTRACE_DETACH, child, NULL, 0));
 	EXPECT_EQ(ESRCH, errno);
 
 	/* Tests PTRACE_ATTACH on the child. */
-	EXPECT_EQ(-1, ptrace(PTRACE_ATTACH, child, NULL, 0));
+	ASSERT_EQ(-1, ptrace(PTRACE_ATTACH, child, NULL, 0));
 	EXPECT_EQ(EPERM, errno);
 	EXPECT_EQ(0, matches_log_ptrace(_metadata, self->audit_fd, child));
 
diff --git a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
index df41da5f2ab0..4c7f9c102d50 100644
--- a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
+++ b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
@@ -122,7 +122,7 @@ TEST_F(scoped_domains, connect_to_parent)
 		if (can_connect_to_parent) {
 			EXPECT_EQ(0, err);
 		} else {
-			EXPECT_EQ(-1, err);
+			ASSERT_EQ(-1, err);
 			EXPECT_EQ(EPERM, errno);
 		}
 		EXPECT_EQ(0, close(stream_client));
@@ -132,7 +132,7 @@ TEST_F(scoped_domains, connect_to_parent)
 		if (can_connect_to_parent) {
 			EXPECT_EQ(0, err);
 		} else {
-			EXPECT_EQ(-1, err);
+			ASSERT_EQ(-1, err);
 			EXPECT_EQ(EPERM, errno);
 		}
 		EXPECT_EQ(0, close(dgram_client));
@@ -417,7 +417,7 @@ TEST_F(scoped_audit, connect_to_child)
 	ASSERT_EQ(1, read(pipe_child[0], &buf, 1));
 	err_dgram = connect(dgram_client, &self->dgram_address.unix_addr,
 			    self->dgram_address.unix_addr_len);
-	EXPECT_EQ(-1, err_dgram);
+	ASSERT_EQ(-1, err_dgram);
 	EXPECT_EQ(EPERM, errno);
 
 	if (should_audit) {
@@ -762,7 +762,7 @@ TEST_F(outside_socket, socket_with_different_domain)
 		if (variant->child_socket) {
 			EXPECT_EQ(0, err);
 		} else {
-			EXPECT_EQ(-1, err);
+			ASSERT_EQ(-1, err);
 			EXPECT_EQ(EPERM, errno);
 		}
 		EXPECT_EQ(0, close(client_socket));
@@ -939,7 +939,7 @@ TEST_F(various_address_sockets, scoped_pathname_sockets)
 			      &stream_abstract_addr.unix_addr,
 			      stream_abstract_addr.unix_addr_len);
 		if (variant->domain == SCOPE_SANDBOX) {
-			EXPECT_EQ(-1, err);
+			ASSERT_EQ(-1, err);
 			EXPECT_EQ(EPERM, errno);
 		} else {
 			EXPECT_EQ(0, err);
@@ -954,7 +954,7 @@ TEST_F(various_address_sockets, scoped_pathname_sockets)
 			     &dgram_abstract_addr.unix_addr,
 			     dgram_abstract_addr.unix_addr_len);
 		if (variant->domain == SCOPE_SANDBOX) {
-			EXPECT_EQ(-1, err);
+			ASSERT_EQ(-1, err);
 			EXPECT_EQ(EPERM, errno);
 		} else {
 			EXPECT_EQ(1, err);
@@ -965,7 +965,7 @@ TEST_F(various_address_sockets, scoped_pathname_sockets)
 			      &dgram_abstract_addr.unix_addr,
 			      dgram_abstract_addr.unix_addr_len);
 		if (variant->domain == SCOPE_SANDBOX) {
-			EXPECT_EQ(-1, err);
+			ASSERT_EQ(-1, err);
 			EXPECT_EQ(EPERM, errno);
 		} else {
 			EXPECT_EQ(0, err);

-- 
2.56.0

