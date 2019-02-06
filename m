Return-Path: <SRS0=88KC=QN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86D4C169C4
	for <linux-security-module@archiver.kernel.org>; Wed,  6 Feb 2019 19:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8404120823
	for <linux-security-module@archiver.kernel.org>; Wed,  6 Feb 2019 19:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WMVnrxCw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfBFTDP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 6 Feb 2019 14:03:15 -0500
Received: from mail-ot1-f72.google.com ([209.85.210.72]:43054 "EHLO
        mail-ot1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfBFTDO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 6 Feb 2019 14:03:14 -0500
Received: by mail-ot1-f72.google.com with SMTP id z6so6997775otm.10
        for <linux-security-module@vger.kernel.org>; Wed, 06 Feb 2019 11:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pEQPhZ4NAtAGCJnRpSx7wz43SDQDQOOMM5gSHV/xOzw=;
        b=WMVnrxCwsa6PebaQQpSIneYJP6eLYboXJODjbYg6gWBEeSaVFIX9S9/ZbQbZMuqFzK
         7RlrhAJtr+ZaYARCQvUwNa24JUhf0umvAnqVdBnW1uItzD1fTMUXswp67SBOI0GffuBh
         dCEjXlbAuEx2FXUw8kuZImXC0oC4Ahqgx5pjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pEQPhZ4NAtAGCJnRpSx7wz43SDQDQOOMM5gSHV/xOzw=;
        b=fRjHusk8LIP0/OOtLUoERrHnmEeRtTPxaFF6PPuZvy929WgRSLfyAmEOyC9iBFanvo
         rId8A+chEnbNx2c+dYvV6bed1S3jU9hGTaXyzlbqU8awx2ZYK0X0AusBy+/BpsNN4kpU
         j+ATG9RBrSR7RI02Jnv/WY8BbXlc3UteJ+xwBEysr2GqD7xi7RGpK2tnEC619Rpe535n
         dmON7GO4v1t36NUlB8uwoTGdH4DsmvuzmPNvpEKaUrGQajksQzEmJNqpHIvxz9MQFuzu
         yTnxWZhnolZW+mXbsQ4ZdLRFuyBmNy2RRG58FKvorQ6oGGuROi8dj5Tpwtg7K1s8E727
         ikdw==
X-Gm-Message-State: AHQUAuZsPc2oqYjcQZgz591F3aCmaNrSoK+ztGOo03mxogTAj0TjAVAc
        giYl6qUAv0eEQkbCLR+vPl3h4pPZCRklDRGl
X-Google-Smtp-Source: AHgI3IZQXIgwe4bMyH3RVCpomsXojlOGSbGYlMbnacuCZ13TPwac/nec6/z4d0PmpjnD5YZXvgrTy+5xmEX1iFP/
X-Received: by 2002:aca:4006:: with SMTP id n6mr7126721oia.49.1549479793687;
 Wed, 06 Feb 2019 11:03:13 -0800 (PST)
Date:   Wed,  6 Feb 2019 11:03:09 -0800
In-Reply-To: <CAGXu5jJX5V9H5uWArV93eM9jFzaCO4s3rQPBa6rN0LbKtMj82Q@mail.gmail.com>
Message-Id: <20190206190309.247032-1-mortonm@chromium.org>
Mime-Version: 1.0
References: <CAGXu5jJX5V9H5uWArV93eM9jFzaCO4s3rQPBa6rN0LbKtMj82Q@mail.gmail.com>
X-Mailer: git-send-email 2.20.1.611.gfbb209baf1-goog
Subject: [PATCH] LSM: SafeSetID: add selftest
From:   mortonm@chromium.org
To:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        casey@schaufler-ca.com, sds@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Cc:     Micah Morton <mortonm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Micah Morton <mortonm@chromium.org>

This patch adds a selftest for the SafeSetID LSM. The test requires
mounting securityfs if it isn't mounted, creating test users in
/etc/passwd, and configuring policies for the SafeSetID LSM through
writes to securityfs.

Signed-off-by: Micah Morton <mortonm@chromium.org>
---
This test is reasonably robust for demonstrating the functionality of
the LSM, but is no masterpiece by any means. I'm not totally sure how
these tests are used. Are they incorporated into testing frameworks for
the Linux kernel that are run regularly or just PoC binaries that sit in
this directory more or less as documentation? If its the former, this
code probably needs some more cleanup and better organization. Beyond
coding style, the test doesn't bother to clean up users that were added
in /etc/passwd for testing purposes nor flushes policies that were
configured for the LSM relating to those users. Should it?

 tools/testing/selftests/safesetid/.gitignore  |   1 +
 tools/testing/selftests/safesetid/Makefile    |   8 +
 tools/testing/selftests/safesetid/config      |   2 +
 .../selftests/safesetid/safesetid-test.c      | 334 ++++++++++++++++++
 .../selftests/safesetid/safesetid-test.sh     |  26 ++
 5 files changed, 371 insertions(+)
 create mode 100644 tools/testing/selftests/safesetid/.gitignore
 create mode 100644 tools/testing/selftests/safesetid/Makefile
 create mode 100644 tools/testing/selftests/safesetid/config
 create mode 100644 tools/testing/selftests/safesetid/safesetid-test.c
 create mode 100755 tools/testing/selftests/safesetid/safesetid-test.sh

diff --git a/tools/testing/selftests/safesetid/.gitignore b/tools/testing/selftests/safesetid/.gitignore
new file mode 100644
index 000000000000..9c1a629bca01
--- /dev/null
+++ b/tools/testing/selftests/safesetid/.gitignore
@@ -0,0 +1 @@
+safesetid-test
diff --git a/tools/testing/selftests/safesetid/Makefile b/tools/testing/selftests/safesetid/Makefile
new file mode 100644
index 000000000000..98da7a504737
--- /dev/null
+++ b/tools/testing/selftests/safesetid/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+# Makefile for mount selftests.
+CFLAGS = -Wall -lcap -O2
+
+TEST_PROGS := run_tests.sh
+TEST_GEN_FILES := safesetid-test
+
+include ../lib.mk
diff --git a/tools/testing/selftests/safesetid/config b/tools/testing/selftests/safesetid/config
new file mode 100644
index 000000000000..9d44e5c2e096
--- /dev/null
+++ b/tools/testing/selftests/safesetid/config
@@ -0,0 +1,2 @@
+CONFIG_SECURITY=y
+CONFIG_SECURITYFS=y
diff --git a/tools/testing/selftests/safesetid/safesetid-test.c b/tools/testing/selftests/safesetid/safesetid-test.c
new file mode 100644
index 000000000000..892c8e8b1b8b
--- /dev/null
+++ b/tools/testing/selftests/safesetid/safesetid-test.c
@@ -0,0 +1,334 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <errno.h>
+#include <pwd.h>
+#include <string.h>
+#include <syscall.h>
+#include <sys/capability.h>
+#include <sys/types.h>
+#include <sys/mount.h>
+#include <sys/prctl.h>
+#include <sys/wait.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <stdbool.h>
+#include <stdarg.h>
+
+#ifndef CLONE_NEWUSER
+# define CLONE_NEWUSER 0x10000000
+#endif
+
+#define ROOT_USER 0
+#define RESTRICTED_PARENT 1
+#define ALLOWED_CHILD1 2
+#define ALLOWED_CHILD2 3
+#define NO_POLICY_USER 4
+
+char* add_whitelist_policy_file = "/sys/kernel/security/safesetid/add_whitelist_policy";
+
+static void die(char *fmt, ...)
+{
+	va_list ap;
+	va_start(ap, fmt);
+	vfprintf(stderr, fmt, ap);
+	va_end(ap);
+	exit(EXIT_FAILURE);
+}
+
+static bool vmaybe_write_file(bool enoent_ok, char *filename, char *fmt, va_list ap)
+{
+	char buf[4096];
+	int fd;
+	ssize_t written;
+	int buf_len;
+
+	buf_len = vsnprintf(buf, sizeof(buf), fmt, ap);
+	if (buf_len < 0) {
+		printf("vsnprintf failed: %s\n",
+		    strerror(errno));
+		return false;
+	}
+	if (buf_len >= sizeof(buf)) {
+		printf("vsnprintf output truncated\n");
+		return false;
+	}
+
+	fd = open(filename, O_WRONLY);
+	if (fd < 0) {
+		if ((errno == ENOENT) && enoent_ok)
+			return true;
+		return false;
+	}
+	written = write(fd, buf, buf_len);
+	if (written != buf_len) {
+		if (written >= 0) {
+			printf("short write to %s\n", filename);
+			return false;
+		} else {
+			printf("write to %s failed: %s\n",
+				filename, strerror(errno));
+			return false;
+		}
+	}
+	if (close(fd) != 0) {
+		printf("close of %s failed: %s\n",
+			filename, strerror(errno));
+		return false;
+	}
+	return true;
+}
+
+static bool write_file(char *filename, char *fmt, ...)
+{
+	va_list ap;
+	bool ret;
+
+	va_start(ap, fmt);
+	ret = vmaybe_write_file(false, filename, fmt, ap);
+	va_end(ap);
+
+	return ret;
+}
+
+static void ensure_user_exists(uid_t uid)
+{
+	struct passwd p;
+
+	FILE *fd;
+	char name_str[10];
+
+	if (getpwuid(uid) == NULL) {
+		memset(&p,0x00,sizeof(p));
+		fd=fopen("/etc/passwd","a");
+		if (fd == NULL)
+			die("couldn't open file\n");
+		if (fseek(fd, 0, SEEK_END))
+			die("couldn't fseek\n");
+		snprintf(name_str, 10, "%d", uid);
+		p.pw_name=name_str;
+		p.pw_uid=uid;
+		p.pw_gecos="Test account";
+		p.pw_dir="/dev/null";
+		p.pw_shell="/bin/false";
+		int value = putpwent(&p,fd);
+		if (value != 0)
+			die("putpwent failed\n");
+		if (fclose(fd))
+			die("fclose failed\n");
+	}
+}
+
+static void ensure_securityfs_mounted(void)
+{
+	int fd = open(add_whitelist_policy_file, O_WRONLY);
+	if (fd < 0) {
+		if (errno == ENOENT) {
+			// Need to mount securityfs
+			if (mount("securityfs", "/sys/kernel/security",
+						"securityfs", 0, NULL) < 0)
+				die("mounting securityfs failed\n");
+		} else {
+			die("couldn't find securityfs for unknown reason\n");
+		}
+	} else {
+		if (close(fd) != 0) {
+			die("close of %s failed: %s\n",
+				add_whitelist_policy_file, strerror(errno));
+		}
+	}
+}
+
+static void write_policies(void)
+{
+	ssize_t written;
+	int fd;
+
+	fd = open(add_whitelist_policy_file, O_WRONLY);
+	if (fd < 0)
+		die("cant open add_whitelist_policy file\n");
+	written = write(fd, "1:2", strlen("1:2"));
+	if (written != strlen("1:2")) {
+		if (written >= 0) {
+			die("short write to %s\n", add_whitelist_policy_file);
+		} else {
+			die("write to %s failed: %s\n",
+				add_whitelist_policy_file, strerror(errno));
+		}
+	}
+	written = write(fd, "1:3", strlen("1:3"));
+	if (written != strlen("1:3")) {
+		if (written >= 0) {
+			die("short write to %s\n", add_whitelist_policy_file);
+		} else {
+			die("write to %s failed: %s\n",
+				add_whitelist_policy_file, strerror(errno));
+		}
+	}
+	if (close(fd) != 0) {
+		die("close of %s failed: %s\n",
+			add_whitelist_policy_file, strerror(errno));
+	}
+}
+
+static bool test_userns(bool expect_success)
+{
+	uid_t uid;
+	char map_file_name[32];
+	size_t sz = sizeof(map_file_name);
+	pid_t cpid;
+	bool success;
+
+	uid = getuid();
+
+	int clone_flags = CLONE_NEWUSER;
+	cpid = syscall(SYS_clone, clone_flags, NULL);
+	if (cpid == -1) {
+	    printf("clone failed");
+	    return false;
+	}
+
+	if (cpid == 0) {	/* Code executed by child */
+		// Give parent 1 second to write map file
+		sleep(1);
+		exit(EXIT_SUCCESS);
+	} else {		/* Code executed by parent */
+		if(snprintf(map_file_name, sz, "/proc/%d/uid_map", cpid) < 0) {
+			printf("preparing file name string failed");
+			return false;
+		}
+		success = write_file(map_file_name, "0 0 1", uid);
+		return success == expect_success;
+	}
+
+	printf("should not reach here");
+	return false;
+}
+
+static void test_setuid(uid_t child_uid, bool expect_success)
+{
+	pid_t cpid, w;
+	int wstatus;
+
+	cpid = fork();
+	if (cpid == -1) {
+		die("fork\n");
+	}
+
+	if (cpid == 0) {	    /* Code executed by child */
+		setuid(child_uid);
+		if (getuid() == child_uid)
+			exit(EXIT_SUCCESS);
+		else
+			exit(EXIT_FAILURE);
+	} else {		 /* Code executed by parent */
+		do {
+			w = waitpid(cpid, &wstatus, WUNTRACED | WCONTINUED);
+			if (w == -1) {
+				die("waitpid\n");
+			}
+
+			if (WIFEXITED(wstatus)) {
+				if (WEXITSTATUS(wstatus) == EXIT_SUCCESS) {
+					if (expect_success) {
+						return;
+					} else {
+						die("unexpected success\n");
+					}
+				} else {
+					if (expect_success) {
+						die("unexpected failure\n");
+					} else {
+						return;
+					}
+				}
+			} else if (WIFSIGNALED(wstatus)) {
+				if (WTERMSIG(wstatus) == 9) {
+					if (expect_success)
+						die("killed unexpectedly\n");
+					else
+						return;
+				} else {
+					die("unexpected signal: %d\n", wstatus);
+				}
+			} else {
+				die("unexpected status: %d\n", wstatus);
+			}
+		} while (!WIFEXITED(wstatus) && !WIFSIGNALED(wstatus));
+	}
+
+	die("should not reach here\n");
+}
+
+static void ensure_users_exist(void)
+{
+	ensure_user_exists(ROOT_USER);
+	ensure_user_exists(RESTRICTED_PARENT);
+	ensure_user_exists(ALLOWED_CHILD1);
+	ensure_user_exists(ALLOWED_CHILD2);
+	ensure_user_exists(NO_POLICY_USER);
+}
+
+static void drop_caps(bool setid_retained)
+{
+	cap_value_t cap_values[] = {CAP_SETUID, CAP_SETGID};
+	cap_t caps;
+
+	caps = cap_get_proc();
+	if (setid_retained)
+		cap_set_flag(caps, CAP_EFFECTIVE, 2, cap_values, CAP_SET);
+	else
+		cap_clear(caps);
+	cap_set_proc(caps);
+	cap_free(caps);
+}
+
+int main(int argc, char **argv)
+{
+	ensure_users_exist();
+	ensure_securityfs_mounted();
+	write_policies();
+
+	if (prctl(PR_SET_KEEPCAPS, 1L))
+		die("Error with set keepcaps\n");
+
+	// First test to make sure we can write userns mappings from a user
+	// that doesn't have any restrictions (as long as it has CAP_SETUID);
+	setuid(NO_POLICY_USER);
+	setgid(NO_POLICY_USER);
+
+	// Take away all but setid caps
+	drop_caps(true);
+
+	// Need PR_SET_DUMPABLE flag set so we can write /proc/[pid]/uid_map
+	// from non-root parent process.
+	if (prctl(PR_SET_DUMPABLE, 1, 0, 0, 0))
+		die("Error with set dumpable\n");
+
+	if (!test_userns(true)) {
+		die("test_userns failed when it should work\n");
+	}
+
+	setuid(RESTRICTED_PARENT);
+	setgid(RESTRICTED_PARENT);
+
+	test_setuid(ROOT_USER, false);
+	test_setuid(ALLOWED_CHILD1, true);
+	test_setuid(ALLOWED_CHILD2, true);
+	test_setuid(NO_POLICY_USER, false);
+
+	if (!test_userns(false)) {
+		die("test_userns worked when it should fail\n");
+	}
+
+	// Now take away all caps
+	drop_caps(false);
+	test_setuid(2, false);
+	test_setuid(3, false);
+	test_setuid(4, false);
+
+	// NOTE: this test doesn't clean up users that were created in
+	// /etc/passwd or flush policies that were added to the LSM.
+	return EXIT_SUCCESS;
+}
diff --git a/tools/testing/selftests/safesetid/safesetid-test.sh b/tools/testing/selftests/safesetid/safesetid-test.sh
new file mode 100755
index 000000000000..e4fdce675c54
--- /dev/null
+++ b/tools/testing/selftests/safesetid/safesetid-test.sh
@@ -0,0 +1,26 @@
+#!/bin/bash
+
+TCID="safesetid-test.sh"
+errcode=0
+
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+check_root()
+{
+	uid=$(id -u)
+	if [ $uid -ne 0 ]; then
+		echo $TCID: must be run as root >&2
+		exit $ksft_skip
+	fi
+}
+
+main_function()
+{
+  check_root
+  ./safesetid-test
+}
+
+main_function
+echo "$TCID: done"
+exit $errcode
-- 
2.20.1.611.gfbb209baf1-goog

