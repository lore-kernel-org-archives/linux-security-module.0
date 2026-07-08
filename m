Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD433806AB
	for <linux-security-module@vger.kernel.org>; Wed,  8 Jul 2026 13:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783517996; cv=none; b=RWPr2VPFyb7WN32hawKGBHluCSEY0AwBH9x4vjjo6FboSviORR5jtdFBZT4wtTD/JenzZZ6vuwckjmoewx88PzgeWI7LQMJmvSgfS9oJKkACYdijGpqZfPjVXOXNFcmSkTr9gBVrvdsUxFRBDe7mloUmYJl40HU4uCax9q+sx30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783517996; c=relaxed/simple;
	bh=8MU3Jp6AUmrULHOP80o582pPCz4pOQeDRRHtZbJkJWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=njR6AvJudgKoZl5kTkYZAjorDcwOqbWGdEPh41w4QjwuF/pv3f7iBIVLWbpl0eevBQMPsDt8WdyjEU/cC95EbEkpNydsvHh9QiMoxCLSYGfF4UpisBpUPGgtO9qDaSHvhhA8cMTvpxDRyMF7vxZdon+ru1xz3KZ7hHBqjBcdoAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQvUmSxV; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQvUmSxV"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-667a0f55a59so695634d50.1
        for <linux-security-module@vger.kernel.org>; Wed, 08 Jul 2026 06:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783517991; x=1784122791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tR3/w3lSeZn2HV1NEiBms72YcEYc0KBooH41VLnj+Vo=;
        b=hQvUmSxVvbynLflnTz7Qew3BpY/YifKZgH1UvO3ug0B08uA9yNaAkoQAAm5wXaOnfB
         NORdYqbDni4GIzD4+Ca1gPeMG4u4MkCiEMsIfyuQ6WzG28OEsjbB2qs7BsBxfp3egL/R
         AqnjrTQK3ruooN0TRalmoH1ZhEVDGtdeYJqATdy3o0ZgjJFGukg6QMeuZ6R7QIpYVope
         /BZ34jcBlZgiZgGyA8dCmXth//V6my6jblb0qHi6Jwt3tTv9NPNvOrlT0NMeZzFCgQt9
         M2Lhe2kPBh5LAIXsGj3T1JYqGJjSwH/BuPoh0m84xZyn0xV/1A4as1vqrqt3Sva6PiUw
         PIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783517991; x=1784122791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tR3/w3lSeZn2HV1NEiBms72YcEYc0KBooH41VLnj+Vo=;
        b=giTJvNf6P1P7ao6+d72y1kA5VjYnXeokymAZH602y4RRdrf0jZZjXPFzhkQSeCMbUA
         b4NqRWgvhJuA/xalfr/G2NEwUak6yinEb2Oizjrn2RrMYFqSof7aJNGV3C3Se54UJptj
         5i9TuGJWbnWdmzmy/VoRcV7/OfkfnVUj/Ofr1VYGz1o0OG2QuDVvne2hJ8ofpFqKCM4w
         7NjxVd7Y9NijvTskKc2WwxGAMSXVHs4xwodE84Ipg8/6YPUK+A2ol06GgV1AJdmgOgi4
         Kb7o8IQ3OgVFv3Ps3HTylFEUpxXFF33XvQMV/58hWk5yT1UBNkC/BAGtNKPA19IUSuEc
         7Rww==
X-Forwarded-Encrypted: i=1; AHgh+RqSK4WVr/Qzk3unAVB+kYsE/yqvrV83e3p1qCJ3fZkfocwwWIVAD5c2F+BgbJ/L1b1uEK0FUrxs9OZL38AV7rBdGm5H9XA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFszNfSDEW52ogo3OrycH3mEgNK2TUm1pQjQYRacDbNuQi0DOv
	UDS52soUGSljUcwIJqXMhr02ivzn4gqXt14GO/zS9ZuBoR0yC/z2wn8z
X-Gm-Gg: AfdE7cmfanNyuSfmFD9gFeA9o2WjRhF8wxhcf3XLN6CcS2Y4uG+QZYiefra14eF3bVL
	xkVLnho7WlCE65Xwmhq1YPbmVo/pCop2VElOs/6Q4+IXl6Ru0VuaRFPKLYSJMqF6agXgcmJzUhd
	w0nkERRSMMkiwVsh43lxFrym7YmWXRzOaHt8OMJbjBDnJPDKf140E6AiudAtMgC3BmNrAXsGzHb
	VuOjCoqRmTBDfYB5TgV4ZTDxCnRHXnNDFS4K/stdi/NxT5oiZ7SzMVl67bSUewKqBhBvwLT1bqA
	IAjA8Tk+k6kGBJ15NozinxDuEJI/qwSGZU5cJgq5ohwLglDFNABZA7+Si2a0PrMONhxZQ+2C8jU
	ATZP301S/xMEvcfoiKwnwy2Nb0sWKr9ou6CU1JVFjYGKn1r5j2PJtEWymwBxREhOD0qRt1EOUnJ
	RaRGuotHUsN/zkft0/u/3ZuJMZ8KjQjIXYAwkLfTjttQX7tmg=
X-Received: by 2002:a53:b012:0:b0:667:8c87:25ef with SMTP id 956f58d0204a3-6679f1acdebmr1373545d50.71.1783517991270;
        Wed, 08 Jul 2026 06:39:51 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:717c:ccb8:c362:d995])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-667877a2db1sm2087969d50.6.2026.07.08.06.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 06:39:51 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: mic@digikod.net,
	linux-security-module@vger.kernel.org
Cc: gnoack@google.com,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH 2/3] selftests/landlock: Test LANDLOCK_RESTRICT_SELF_NNP_ON_EXEC
Date: Wed,  8 Jul 2026 09:39:26 -0400
Message-ID: <20260708133928.852999-3-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260708133928.852999-1-utilityemal77@gmail.com>
References: <20260708133928.852999-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an nnp_on_exec fixture checking that staging no_new_privs does not
set it before execve(2) but does set it for the executed program, with
and without a ruleset, and that LANDLOCK_RESTRICT_SELF_TSYNC propagates
the staged state to sibling threads.  Also check that the
no_new_privs/CAP_SYS_ADMIN requirement still applies to stage-only
calls.

Update the ABI version and last-flag checks accordingly.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 tools/testing/selftests/landlock/base_test.c | 259 ++++++++++++++++++-
 1 file changed, 255 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index cbd3c1669951..55ae26a72752 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -11,9 +11,12 @@
 #include <fcntl.h>
 #include <linux/keyctl.h>
 #include <linux/landlock.h>
+#include <pthread.h>
+#include <stdlib.h>
 #include <string.h>
 #include <sys/prctl.h>
 #include <sys/socket.h>
+#include <sys/stat.h>
 #include <sys/types.h>
 
 #include "common.h"
@@ -76,7 +79,7 @@ TEST(abi_version)
 	const struct landlock_ruleset_attr ruleset_attr = {
 		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
 	};
-	ASSERT_EQ(10, landlock_create_ruleset(NULL, 0,
+	ASSERT_EQ(11, landlock_create_ruleset(NULL, 0,
 					      LANDLOCK_CREATE_RULESET_VERSION));
 
 	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
@@ -288,7 +291,7 @@ TEST(restrict_self_fd)
 	EXPECT_EQ(EBADFD, errno);
 }
 
-TEST(restrict_self_fd_logging_flags)
+TEST(restrict_self_fd_flags)
 {
 	int fd;
 
@@ -302,11 +305,16 @@ TEST(restrict_self_fd_logging_flags)
 	EXPECT_EQ(-1, landlock_restrict_self(
 			      fd, LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF));
 	EXPECT_EQ(EBADFD, errno);
+
+	/* Same for LANDLOCK_RESTRICT_SELF_NNP_ON_EXEC. */
+	EXPECT_EQ(-1, landlock_restrict_self(
+			      fd, LANDLOCK_RESTRICT_SELF_NNP_ON_EXEC));
+	EXPECT_EQ(EBADFD, errno);
 }
 
-TEST(restrict_self_logging_flags)
+TEST(restrict_self_flags)
 {
-	const __u32 last_flag = LANDLOCK_RESTRICT_SELF_TSYNC;
+	const __u32 last_flag = LANDLOCK_RESTRICT_SELF_NNP_ON_EXEC;
 
 	/* Tests invalid flag combinations. */
 
@@ -349,6 +357,12 @@ TEST(restrict_self_logging_flags)
 				      LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON));
 	EXPECT_EQ(EBADF, errno);
 
+	EXPECT_EQ(-1,
+		  landlock_restrict_self(
+			  -1, LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF |
+				      LANDLOCK_RESTRICT_SELF_NNP_ON_EXEC));
+	EXPECT_EQ(EBADF, errno);
+
 	/* Tests with an invalid ruleset_fd. */
 
 	EXPECT_EQ(-1, landlock_restrict_self(
@@ -359,6 +373,243 @@ TEST(restrict_self_logging_flags)
 			     -1, LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF));
 }
 
+/*
+ * Exits with the NoNewPrivs value of the executed shell, as read from
+ * /proc/self/status, making the staged no_new_privs observable after an
+ * execve(2).
+ */
+static const char nnp_script[] =
+	"#!/bin/sh\n"
+	"while read -r label value; do\n"
+	"	if [ \"$label\" = \"NoNewPrivs:\" ]; then\n"
+	"		exit \"$value\"\n"
+	"	fi\n"
+	"done < /proc/self/status\n"
+	"exit 42\n";
+
+/* Returns the no_new_privs value inherited through fork(2) and execve(2). */
+static int get_nnp_after_exec(const char *const script_path)
+{
+	int status;
+	const pid_t child = fork();
+
+	if (child < 0)
+		return -errno;
+
+	if (child == 0) {
+		char *const argv[] = { (char *)script_path, NULL };
+
+		execve(script_path, argv, NULL);
+		_exit(127);
+	}
+
+	if (waitpid(child, &status, 0) != child)
+		return -ECHILD;
+
+	if (!WIFEXITED(status))
+		return -EIO;
+
+	return WEXITSTATUS(status);
+}
+
+struct nnp_staging_thread {
+	const char *script_path;
+	int ruleset_fd;
+	__u32 flags;
+	int restrict_ret;
+	int restrict_errno;
+	int open_write_ret;
+	int open_write_errno;
+	int nnp_before_exec;
+	int nnp_after_exec;
+};
+
+/*
+ * Stages no_new_privs from a sibling thread of the test thread, so that the
+ * test thread can observe whether LANDLOCK_RESTRICT_SELF_TSYNC propagated the
+ * staged state.
+ */
+static void *stage_nnp_on_exec(void *data)
+{
+	struct nnp_staging_thread *const ctx = data;
+
+	ctx->restrict_ret = landlock_restrict_self(ctx->ruleset_fd, ctx->flags);
+	ctx->restrict_errno = errno;
+
+	/*
+	 * Tries to open the script for writing to check that a ruleset passed
+	 * along LANDLOCK_RESTRICT_SELF_NNP_ON_EXEC is enforced immediately,
+	 * unlike the staged no_new_privs.
+	 */
+	ctx->open_write_ret = open(ctx->script_path, O_WRONLY | O_CLOEXEC);
+	ctx->open_write_errno = errno;
+	if (ctx->open_write_ret >= 0)
+		close(ctx->open_write_ret);
+
+	ctx->nnp_before_exec = prctl(PR_GET_NO_NEW_PRIVS, 0, 0, 0, 0);
+	ctx->nnp_after_exec = get_nnp_after_exec(ctx->script_path);
+	return NULL;
+}
+
+FIXTURE(nnp_on_exec)
+{
+	char script_path[sizeof("/tmp/landlock_nnp_XXXXXX")];
+};
+
+FIXTURE_VARIANT(nnp_on_exec)
+{
+	const bool with_ruleset;
+	const bool tsync;
+	const bool nnp_before;
+	const bool cap_sys_admin;
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(nnp_on_exec, no_ruleset) {
+	/* clang-format on */
+	.cap_sys_admin = true,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(nnp_on_exec, with_ruleset) {
+	/* clang-format on */
+	.with_ruleset = true,
+	.cap_sys_admin = true,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(nnp_on_exec, no_ruleset_tsync) {
+	/* clang-format on */
+	.tsync = true,
+	.cap_sys_admin = true,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(nnp_on_exec, with_ruleset_tsync) {
+	/* clang-format on */
+	.with_ruleset = true,
+	.tsync = true,
+	.cap_sys_admin = true,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(nnp_on_exec, nnp_already_set) {
+	/* clang-format on */
+	.nnp_before = true,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(nnp_on_exec, nnp_already_set_tsync) {
+	/* clang-format on */
+	.nnp_before = true,
+	.tsync = true,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(nnp_on_exec, unprivileged) {
+	/* clang-format on */
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(nnp_on_exec, unprivileged_tsync) {
+	/* clang-format on */
+	.tsync = true,
+};
+
+FIXTURE_SETUP(nnp_on_exec)
+{
+	int script_fd;
+
+	disable_caps(_metadata);
+
+	memcpy(self->script_path, "/tmp/landlock_nnp_XXXXXX",
+	       sizeof(self->script_path));
+	script_fd = mkstemp(self->script_path);
+	ASSERT_LE(0, script_fd);
+	ASSERT_EQ(sizeof(nnp_script) - 1,
+		  write(script_fd, nnp_script, sizeof(nnp_script) - 1));
+	ASSERT_EQ(0, fchmod(script_fd, 0700));
+	ASSERT_EQ(0, close(script_fd));
+}
+
+FIXTURE_TEARDOWN(nnp_on_exec)
+{
+	EXPECT_EQ(0, unlink(self->script_path));
+}
+
+TEST_F(nnp_on_exec, staging)
+{
+	/* The nnp/CAP_SYS_ADMIN gate applies even to stage-only calls. */
+	const bool expect_success = variant->nnp_before ||
+				    variant->cap_sys_admin;
+	struct nnp_staging_thread staging = {
+		.script_path = self->script_path,
+		.ruleset_fd = -1,
+		.flags = LANDLOCK_RESTRICT_SELF_NNP_ON_EXEC,
+	};
+	pthread_t thread;
+
+	if (variant->tsync)
+		staging.flags |= LANDLOCK_RESTRICT_SELF_TSYNC;
+
+	if (variant->with_ruleset) {
+		const struct landlock_ruleset_attr ruleset_attr = {
+			.handled_access_fs = LANDLOCK_ACCESS_FS_WRITE_FILE,
+		};
+
+		staging.ruleset_fd =
+			landlock_create_ruleset(&ruleset_attr,
+						sizeof(ruleset_attr), 0);
+		ASSERT_LE(0, staging.ruleset_fd);
+	}
+
+	if (variant->nnp_before)
+		ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
+	if (variant->cap_sys_admin)
+		set_cap(_metadata, CAP_SYS_ADMIN);
+
+	/* The staging thread inherits no_new_privs and capabilities. */
+	ASSERT_EQ(0, pthread_create(&thread, NULL, stage_nnp_on_exec,
+				    &staging));
+	ASSERT_EQ(0, pthread_join(thread, NULL));
+
+	if (variant->cap_sys_admin)
+		clear_cap(_metadata, CAP_SYS_ADMIN);
+
+	if (expect_success) {
+		EXPECT_EQ(0, staging.restrict_ret);
+	} else {
+		EXPECT_EQ(-1, staging.restrict_ret);
+		EXPECT_EQ(EPERM, staging.restrict_errno);
+	}
+
+	/* A ruleset is enforced immediately, unlike the staged no_new_privs. */
+	if (variant->with_ruleset) {
+		EXPECT_EQ(-1, staging.open_write_ret);
+		EXPECT_EQ(EACCES, staging.open_write_errno);
+	} else {
+		EXPECT_LE(0, staging.open_write_ret);
+	}
+
+	/* Staging never sets no_new_privs before the execve(2)... */
+	EXPECT_EQ(variant->nnp_before, staging.nnp_before_exec);
+	/* ...but a successful call sets it for the executed program. */
+	EXPECT_EQ(expect_success, staging.nnp_after_exec);
+
+	/*
+	 * On this sibling thread, the staged state is only visible if it was
+	 * propagated with LANDLOCK_RESTRICT_SELF_TSYNC, and it is still not
+	 * set before the execve(2).
+	 */
+	EXPECT_EQ(variant->nnp_before,
+		  prctl(PR_GET_NO_NEW_PRIVS, 0, 0, 0, 0));
+	EXPECT_EQ((variant->nnp_before || (expect_success && variant->tsync)),
+		  get_nnp_after_exec(self->script_path));
+
+	if (variant->with_ruleset)
+		EXPECT_EQ(0, close(staging.ruleset_fd));
+}
+
 TEST(ruleset_fd_io)
 {
 	struct landlock_ruleset_attr ruleset_attr = {
-- 
2.54.0

