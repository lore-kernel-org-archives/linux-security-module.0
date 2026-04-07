Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601833815EB
	for <linux-security-module@vger.kernel.org>; Tue,  7 Apr 2026 20:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775592167; cv=none; b=Eha/DDtsCBR9auV3LXejsh1SvHyHnIeHevxGMhVyjTe9KjL/ChJLarm72EVMk92AwyUN20w/k2cIxMk3GbGP4XM3Uon94qCYH0hn2Br09T46KHkOVFZRllnNOOIuBEFJqpRPbXDCNZ+6p1CSqt1xYNSO2NdAk5AmgFVcw5g6zSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775592167; c=relaxed/simple;
	bh=ADfjPKYtul6AxZfXeotH/sQzr7G8VBZoAUMqHdbUnDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V4m2n9QUVUapdh/GIOl223Xckolefj1XQBAhzdP2tsvVjKTqj/rOlWk1RMA3LK9NoB60sebJGo7nWsVvhgYEhoYXulpx3ijJeH3UuLuvWAtUAGS2jaDELbm+Y6bkPLqweGrvuhQKN07OvzeQvUAiiaLSE9PTgdySFJRbwSMsJxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PAXMgNM1; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAXMgNM1"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-6501725d888so4371508d50.0
        for <linux-security-module@vger.kernel.org>; Tue, 07 Apr 2026 13:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775592164; x=1776196964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V+tWCOUaD88Gl+7U3/IhIfD+F7ejPPugL1d7Q4iQykY=;
        b=PAXMgNM1So9Ew4T4N07Q/Ypp1Rd1y5Fk2RnZakcSj8pE6gPT/8+vsvhbFmWFDSJZ+G
         AiPJrz4/Hrp60mqFNf8dO/us9TFxfZwcYNT0H/I/dLvMO3NuOKHR3nbcCE8oREY2dA1S
         xrRWmj+S2IpPcf2LoE82VMxxGsRGfm44O8E8I2c967BbidKsOHIy5juoPYijaIYWCwnd
         YERAImY2mB5Mv+PZobl4N8lGupGsVB7rdWSBAakQPh+KwWpWrG8Qoea8Wy6e6cFVjb8d
         LlvEWk6es5DPsmqvF0SxRqi2OoZ/E/wY5KyWJvb8Yka+SDG7yjwdHmJxT7jOs+Hr+vxO
         scmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775592164; x=1776196964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V+tWCOUaD88Gl+7U3/IhIfD+F7ejPPugL1d7Q4iQykY=;
        b=rKABiR2MmB1XjQx6JM/TyYkVBVuWTQ+HpB/M8f62g258vB6Pj4oGTkYrH5NuKpQwyh
         J+G1LRTpXBJNjKIJBp9wA3ZWbS/EwgdZIa8fM/cE37yscluuGV1vj1ja6NpwYhW+clxd
         G8ILyH0jFa8hEpDh22Z6mEouqqM+DMbXSMKXU2gGQxQxqbHO+x9+sKA0y7W8QwmmYonw
         4cqU+PdTyLAOAqLgDCQKpf6viuj57goArryneSmrKvNjjpHYTmucIVG+qvBReUDwCaWv
         HdVx36HKPmOJwOZkiS+oWbwmDKz3NbyJdd0tPFb0aI9tzQepyXXaBi4eiMdMlHZ7HZT8
         PPzw==
X-Forwarded-Encrypted: i=1; AJvYcCX1jvw1XCUo7BdHFTsiNoHNtujoNIqSoPrkOeEupq0dEfEF5gbFfCNwzJaT0kS81KLeftDjts0kuP677xFoQNqmqZWPTPw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2+lPsR1jyuAuOmBsdGL5MeGF2lyOmmRkF7ZODZxUy6wcniSyr
	8yKChomqkU4LyNruDCv3sSe1THNxkzWjWtn2eyoptbzSGFAn6Q+EIicH
X-Gm-Gg: AeBDiesLo7o7nOX6X/+2hEhTWQPEGVEnXLY54chAQFDBOfpMD+PHlbwrl8g3sXabaoy
	qsWSlrcFssWzbTcJ4al6tcTugcm68148XwAwecvJBxMnLJupc8MHZUckfSJ+GzvEzLwu5Z6GzdV
	Z9kVDknFpJzBgZAW3gmbdJzJYn/8sM7hbRHJUCwGzmJU1zP79kmHoKSJb8c9XRdIpLD013j9J/a
	5T3oOxeuv96JSjTaf0q6SvuanhiCmNJNH69Pcj4SkcOpg0YI2kJ3CxPzhEq2RbtQELZayIfgnf0
	B3lfebvxUefMk6OaNrMm4rvZFG6quPum+DD13tOz0bANanwPg4fZBIKn+YCMM/7fZ0mTyjOz8p/
	TsajCGU6wYonAA72YEr1X3s1tv5DuBWPMB7cQpxNTlrGP1/3+O5HH6AzP4g9V5I5rcI1EYULkaZ
	f/szwESPICT75OwhfZ0Vni6ZmFUnWMQgPCpIOPwfIiDHqXwIr7N509DeANTFCkz/HVr3VZtAXO
X-Received: by 2002:a05:690e:1919:b0:650:7344:90f0 with SMTP id 956f58d0204a3-65073449e85mr6947552d50.37.1775592164269;
        Tue, 07 Apr 2026 13:02:44 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:92f8:8594:e84e:1d9a])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a828f3csm8354078d50.3.2026.04.07.13.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 13:02:44 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kpsingh@kernel.org,
	paul@paul-moore.com,
	mic@digikod.net,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	kees@kernel.org
Cc: gnoack@google.com,
	jack@suse.cz,
	jmorris@namei.org,
	serge@hallyn.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	martin.lau@linux.dev,
	m@maowtm.org,
	eddyz87@gmail.com,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	skhan@linuxfoundation.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [RFC PATCH 15/20] selftests/bpf: Add Landlock kfunc test runner
Date: Tue,  7 Apr 2026 16:01:37 -0400
Message-ID: <20260407200157.3874806-16-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407200157.3874806-1-utilityemal77@gmail.com>
References: <20260407200157.3874806-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a selftest program that loads the Landlock BPF program. The program
creates Landlock rulesets under two topologies (with and without parent
domain). It tests proper enforcement of Landlock rulesets by forking and
executing a child process while a ruleset is enforced by BPF. The result
of the operation is checked and the BPF program counters are verified to
ensure proper execution.

Assisted-by: OpenAI:GPT-5.4
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 .../bpf/prog_tests/landlock_kfuncs.c          | 733 ++++++++++++++++++
 1 file changed, 733 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/landlock_kfuncs.c

diff --git a/tools/testing/selftests/bpf/prog_tests/landlock_kfuncs.c b/tools/testing/selftests/bpf/prog_tests/landlock_kfuncs.c
new file mode 100644
index 000000000000..a2f2a067b911
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/landlock_kfuncs.c
@@ -0,0 +1,733 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/limits.h>
+#include "../../../../../usr/include/linux/landlock.h"
+#include <sched.h>
+#include <stdbool.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mount.h>
+#include <sys/prctl.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <test_progs.h>
+#include <unistd.h>
+
+#include "landlock_kfuncs.skel.h"
+#include "../../landlock/wrappers.h"
+
+#ifndef BIT
+#define BIT(nr) (1U << (nr))
+#endif
+
+#ifndef LANDLOCK_RESTRICT_SELF_TSYNC
+#define LANDLOCK_RESTRICT_SELF_TSYNC BIT(3)
+#endif
+
+#ifndef LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
+#define LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS BIT(4)
+#endif
+
+#define LANDLOCK_EXEC_PATH "/bin/sh"
+#define MNT_TMP_DATA "size=4m,mode=700"
+
+enum previous_domain_kind {
+	PREV_DOMAIN_NONE,
+	PREV_DOMAIN_NESTED,
+};
+
+enum operation_kind {
+	OPERATION_READ,
+	OPERATION_WRITE,
+	OPERATION_CREATE,
+};
+
+struct hook_variant {
+	const char *name;
+	bool enable_bprm_creds_for_exec;
+	bool enable_bprm_creds_from_file;
+};
+
+struct restrict_variant {
+	const char *name;
+	enum previous_domain_kind previous_domain;
+	__u32 restrict_flags;
+	int expected_restrict_ret;
+	bool expect_enforced;
+};
+
+struct operation_case {
+	const char *name;
+	enum operation_kind kind;
+	__u64 handled_access_fs;
+	__u64 allowed_access_fs;
+};
+
+struct landlock_test_env {
+	char base_dir[PATH_MAX];
+	char allowed_dir[PATH_MAX];
+	char restricted_dir[PATH_MAX];
+	char allowed_file[PATH_MAX];
+	char restricted_file[PATH_MAX];
+	char created_file[PATH_MAX];
+};
+
+static const struct hook_variant hook_variants[] = {
+	{
+		.name = "bprm_creds_for_exec",
+		.enable_bprm_creds_for_exec = true,
+	},
+	{
+		.name = "bprm_creds_from_file",
+		.enable_bprm_creds_from_file = true,
+	},
+};
+
+static const struct restrict_variant domain_variants[] = {
+	{
+		.name = "no_previous_domain",
+		.previous_domain = PREV_DOMAIN_NONE,
+		.expect_enforced = true,
+	},
+	{
+		.name = "nested_previous_domain",
+		.previous_domain = PREV_DOMAIN_NESTED,
+		.expect_enforced = true,
+	},
+};
+
+static const struct restrict_variant flag_variants[] = {
+	{
+		.name = "flag_no_new_privs",
+		.previous_domain = PREV_DOMAIN_NONE,
+		.restrict_flags = LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS,
+		.expect_enforced = true,
+	},
+	{
+		.name = "flag_log_same_exec_off",
+		.previous_domain = PREV_DOMAIN_NONE,
+		.restrict_flags = LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF,
+		.expect_enforced = true,
+	},
+	{
+		.name = "flag_log_new_exec_on",
+		.previous_domain = PREV_DOMAIN_NONE,
+		.restrict_flags = LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON,
+		.expect_enforced = true,
+	},
+	{
+		.name = "flag_log_subdomains_off",
+		.previous_domain = PREV_DOMAIN_NONE,
+		.restrict_flags = LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF,
+		.expect_enforced = true,
+	},
+	{
+		.name = "flag_tsync_rejected",
+		.previous_domain = PREV_DOMAIN_NONE,
+		.restrict_flags = LANDLOCK_RESTRICT_SELF_TSYNC,
+		.expected_restrict_ret = -EINVAL,
+		.expect_enforced = false,
+	},
+};
+
+static const struct operation_case operation_cases[] = {
+	{
+		.name = "read_file",
+		.kind = OPERATION_READ,
+		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
+		.allowed_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
+	},
+	{
+		.name = "write_file",
+		.kind = OPERATION_WRITE,
+		.handled_access_fs = LANDLOCK_ACCESS_FS_WRITE_FILE,
+		.allowed_access_fs = LANDLOCK_ACCESS_FS_WRITE_FILE,
+	},
+	{
+		.name = "make_reg",
+		.kind = OPERATION_CREATE,
+		.handled_access_fs = LANDLOCK_ACCESS_FS_MAKE_REG |
+				     LANDLOCK_ACCESS_FS_WRITE_FILE,
+		.allowed_access_fs = LANDLOCK_ACCESS_FS_MAKE_REG |
+				     LANDLOCK_ACCESS_FS_WRITE_FILE,
+	},
+};
+
+static int landlock_version(void)
+{
+	return landlock_create_ruleset(NULL, 0,
+				       LANDLOCK_CREATE_RULESET_VERSION);
+}
+
+static int write_all(int fd, const char *buf, size_t len)
+{
+	while (len > 0) {
+		ssize_t written;
+
+		written = write(fd, buf, len);
+		if (written < 0) {
+			if (errno == EINTR)
+				continue;
+			return -errno;
+		}
+		buf += written;
+		len -= written;
+	}
+
+	return 0;
+}
+
+static int write_text_file(const char *path, const char *contents)
+{
+	int err;
+	int fd;
+
+	fd = open(path, O_WRONLY | O_CREAT | O_TRUNC | O_CLOEXEC, 0600);
+	if (fd < 0)
+		return -errno;
+
+	err = write_all(fd, contents, strlen(contents));
+	close(fd);
+	return err;
+}
+
+static int read_text_file(const char *path, char *buf, size_t len)
+{
+	ssize_t bytes;
+	int fd;
+
+	fd = open(path, O_RDONLY | O_CLOEXEC);
+	if (fd < 0)
+		return -errno;
+
+	bytes = read(fd, buf, len - 1);
+	close(fd);
+	if (bytes < 0)
+		return -errno;
+
+	buf[bytes] = '\0';
+	return 0;
+}
+
+static bool path_exists(const char *path)
+{
+	return access(path, F_OK) == 0;
+}
+
+static int delete_ruleset_map_elem(struct landlock_kfuncs *skel)
+{
+	__u32 key = 0;
+	int err;
+
+	err = bpf_map_delete_elem(bpf_map__fd(skel->maps.ruleset_map), &key);
+	if (!err || errno == ENOENT)
+		return 0;
+	return -errno;
+}
+
+static int update_ruleset_map(struct landlock_kfuncs *skel, int ruleset_fd)
+{
+	__u32 key = 0;
+
+	if (bpf_map_update_elem(bpf_map__fd(skel->maps.ruleset_map), &key,
+				&ruleset_fd, BPF_ANY))
+		return -errno;
+
+	return 0;
+}
+
+static void reset_bss(struct landlock_kfuncs *skel)
+{
+	skel->bss->target_pid = 0;
+	skel->bss->enable_bprm_creds_for_exec = false;
+	skel->bss->enable_bprm_creds_from_file = false;
+	skel->bss->restrict_flags = 0;
+
+	skel->bss->matched_pid = 0;
+	skel->bss->bprm_creds_for_exec_hits = 0;
+	skel->bss->bprm_creds_from_file_hits = 0;
+	skel->bss->lookup_calls = 0;
+	skel->bss->lookup_failed = 0;
+	skel->bss->restrict_calls = 0;
+	skel->bss->restrict_ret = 0;
+	skel->bss->put_calls = 0;
+}
+
+static int add_path_rule(int ruleset_fd, const char *path, __u64 access)
+{
+	struct landlock_path_beneath_attr path_beneath = {
+		.allowed_access = access,
+	};
+	int err;
+	int parent_fd;
+
+	parent_fd = open(path, O_PATH | O_CLOEXEC | O_DIRECTORY);
+	if (parent_fd < 0)
+		return -errno;
+
+	path_beneath.parent_fd = parent_fd;
+	err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
+				&path_beneath, 0);
+	err = err ? -errno : 0;
+	close(parent_fd);
+	return err;
+}
+
+static int create_exec_ruleset(const struct landlock_test_env *env,
+			       const struct operation_case *op)
+{
+	struct landlock_ruleset_attr attr = {
+		.handled_access_fs = op->handled_access_fs,
+	};
+	int err;
+	int ruleset_fd;
+
+	ruleset_fd = landlock_create_ruleset(&attr, sizeof(attr), 0);
+	if (ruleset_fd < 0)
+		return -errno;
+
+	err = add_path_rule(ruleset_fd, env->allowed_dir,
+			    op->allowed_access_fs);
+	if (err) {
+		close(ruleset_fd);
+		return err;
+	}
+
+	return ruleset_fd;
+}
+
+static int create_and_apply_previous_domain(const struct landlock_test_env *env,
+					    enum previous_domain_kind kind,
+					    __u64 handled_access_fs)
+{
+	struct landlock_ruleset_attr attr = {};
+	int err;
+	int ruleset_fd;
+
+	if (kind == PREV_DOMAIN_NONE)
+		return 0;
+
+	attr.handled_access_fs = handled_access_fs;
+
+	ruleset_fd = landlock_create_ruleset(&attr, sizeof(attr), 0);
+	if (ruleset_fd < 0)
+		return -errno;
+
+	if (kind == PREV_DOMAIN_NESTED) {
+		err = add_path_rule(ruleset_fd, env->base_dir,
+				    handled_access_fs);
+		if (err) {
+			close(ruleset_fd);
+			return err;
+		}
+	}
+
+	if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0))
+		return -errno;
+
+	err = landlock_restrict_self(ruleset_fd, 0);
+	err = err ? -errno : 0;
+	close(ruleset_fd);
+	return err;
+}
+
+static int prepare_layout(struct landlock_test_env *env)
+{
+	char template[] = "/tmp/landlock_kfuncsXXXXXX";
+	int err;
+
+	if (!mkdtemp(template))
+		return -errno;
+
+	err = snprintf(env->base_dir, sizeof(env->base_dir), "%s", template);
+	if (err < 0 || err >= (int)sizeof(env->base_dir))
+		return -ENAMETOOLONG;
+
+	if (unshare(CLONE_NEWNS))
+		return -errno;
+
+	if (mount("tmpfs", env->base_dir, "tmpfs", 0, MNT_TMP_DATA))
+		return -errno;
+
+	if (mount(NULL, env->base_dir, NULL, MS_PRIVATE | MS_REC, NULL))
+		return -errno;
+
+	err = snprintf(env->allowed_dir, sizeof(env->allowed_dir), "%s/allowed",
+		       env->base_dir);
+	if (err < 0 || err >= (int)sizeof(env->allowed_dir))
+		return -ENAMETOOLONG;
+
+	err = snprintf(env->restricted_dir, sizeof(env->restricted_dir),
+		       "%s/restricted", env->base_dir);
+	if (err < 0 || err >= (int)sizeof(env->restricted_dir))
+		return -ENAMETOOLONG;
+
+	err = snprintf(env->allowed_file, sizeof(env->allowed_file), "%s/file",
+		       env->allowed_dir);
+	if (err < 0 || err >= (int)sizeof(env->allowed_file))
+		return -ENAMETOOLONG;
+
+	err = snprintf(env->restricted_file, sizeof(env->restricted_file),
+		       "%s/file", env->restricted_dir);
+	if (err < 0 || err >= (int)sizeof(env->restricted_file))
+		return -ENAMETOOLONG;
+
+	err = snprintf(env->created_file, sizeof(env->created_file),
+		       "%s/created", env->restricted_dir);
+	if (err < 0 || err >= (int)sizeof(env->created_file))
+		return -ENAMETOOLONG;
+
+	if (mkdir(env->allowed_dir, 0700))
+		return -errno;
+	if (mkdir(env->restricted_dir, 0700))
+		return -errno;
+
+	err = write_text_file(env->allowed_file, "allowed\n");
+	if (err)
+		return err;
+
+	err = write_text_file(env->restricted_file, "restricted\n");
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static void cleanup_layout(const struct landlock_test_env *env)
+{
+	umount(env->base_dir);
+	rmdir(env->base_dir);
+}
+
+static int seed_operation_state(const struct landlock_test_env *env,
+				const struct operation_case *op)
+{
+	int err;
+
+	err = write_text_file(env->allowed_file, "allowed\n");
+	if (err)
+		return err;
+
+	err = write_text_file(env->restricted_file, "restricted\n");
+	if (err)
+		return err;
+
+	if (op->kind == OPERATION_CREATE && unlink(env->created_file) &&
+	    errno != ENOENT)
+		return -errno;
+
+	return 0;
+}
+
+static int build_command(char *buf, size_t len,
+			 const struct landlock_test_env *env,
+			 const struct operation_case *op)
+{
+	switch (op->kind) {
+	case OPERATION_READ:
+		return snprintf(buf, len, "cat '%s' >/dev/null",
+				env->restricted_file);
+	case OPERATION_WRITE:
+		return snprintf(buf, len, "printf 'written\\n' >> '%s'",
+				env->restricted_file);
+	case OPERATION_CREATE:
+		return snprintf(buf, len, "printf 'created\\n' > '%s'",
+				env->created_file);
+	}
+
+	return -EINVAL;
+}
+
+static int run_exec_attempt(struct landlock_kfuncs *skel,
+			    const struct landlock_test_env *env,
+			    const struct operation_case *op,
+			    const struct hook_variant *hook,
+			    const struct restrict_variant *variant,
+			    bool enable_bpf, int ruleset_fd, int *child_status)
+{
+	char command[PATH_MAX * 2];
+	char signal_byte = 1;
+	pid_t child;
+	pid_t target_pid;
+	int go_pipe[2];
+	int err;
+
+	err = build_command(command, sizeof(command), env, op);
+	if (err < 0 || err >= (int)sizeof(command))
+		return -ENAMETOOLONG;
+
+	if (pipe(go_pipe))
+		return -errno;
+
+	child = fork();
+	if (child < 0) {
+		err = -errno;
+		goto out_close_pipe;
+	}
+	target_pid = child;
+
+	if (child == 0) {
+		close(go_pipe[1]);
+
+		err = create_and_apply_previous_domain(env,
+					     variant->previous_domain,
+					     op->handled_access_fs);
+		if (err)
+			_exit(-err);
+
+		if (read(go_pipe[0], &signal_byte, sizeof(signal_byte)) !=
+		    sizeof(signal_byte))
+			_exit(200);
+
+		execl(LANDLOCK_EXEC_PATH, "sh", "-ec", command, NULL);
+		_exit(errno);
+	}
+
+	close(go_pipe[0]);
+	reset_bss(skel);
+
+	if (enable_bpf) {
+		skel->bss->target_pid = target_pid;
+		skel->bss->enable_bprm_creds_for_exec =
+			hook->enable_bprm_creds_for_exec;
+		skel->bss->enable_bprm_creds_from_file =
+			hook->enable_bprm_creds_from_file;
+		skel->bss->restrict_flags = variant->restrict_flags;
+
+		err = update_ruleset_map(skel, ruleset_fd);
+		if (err)
+			goto out_kill_child;
+	}
+
+	if (write(go_pipe[1], &signal_byte, sizeof(signal_byte)) !=
+	    sizeof(signal_byte)) {
+		err = -errno;
+		goto out_kill_child;
+	}
+	close(go_pipe[1]);
+
+	if (waitpid(child, child_status, 0) != child)
+		return -errno;
+
+	return 0;
+
+out_kill_child:
+	close(go_pipe[1]);
+	kill(child, SIGKILL);
+	waitpid(child, NULL, 0);
+	return err;
+
+out_close_pipe:
+	close(go_pipe[0]);
+	close(go_pipe[1]);
+	return err;
+}
+
+static void assert_operation_outcome(const struct landlock_test_env *env,
+				     const struct operation_case *op,
+				     bool expect_success, int child_status)
+{
+	char contents[256];
+
+	ASSERT_TRUE(WIFEXITED(child_status), "child_exited");
+	if (expect_success)
+		ASSERT_EQ(WEXITSTATUS(child_status), 0, "child_exit_code");
+	else
+		ASSERT_NEQ(WEXITSTATUS(child_status), 0, "child_exit_code");
+
+	switch (op->kind) {
+	case OPERATION_READ:
+		ASSERT_OK(read_text_file(env->restricted_file, contents,
+					 sizeof(contents)),
+			  "read_restricted_file");
+		ASSERT_STREQ(contents, "restricted\n", "restricted_contents");
+		break;
+	case OPERATION_WRITE:
+		ASSERT_OK(read_text_file(env->restricted_file, contents,
+					 sizeof(contents)),
+			  "read_restricted_file");
+		if (expect_success) {
+			ASSERT_STREQ(contents, "restricted\nwritten\n",
+				     "restricted_contents");
+		} else {
+			ASSERT_STREQ(contents, "restricted\n",
+				     "restricted_contents");
+		}
+		break;
+	case OPERATION_CREATE:
+		if (expect_success) {
+			ASSERT_TRUE(path_exists(env->created_file),
+				    "created_file_exists");
+			ASSERT_OK(read_text_file(env->created_file, contents,
+						 sizeof(contents)),
+				  "read_created_file");
+			ASSERT_STREQ(contents, "created\n", "created_contents");
+		} else {
+			ASSERT_FALSE(path_exists(env->created_file),
+				     "created_file_exists");
+		}
+		break;
+	}
+}
+
+static void assert_bpf_state(const struct landlock_kfuncs *skel,
+			     const struct hook_variant *hook, bool expect_bpf,
+			     int expected_restrict_ret)
+{
+	if (!expect_bpf) {
+		ASSERT_EQ(skel->bss->matched_pid, 0, "matched_pid");
+		ASSERT_EQ(skel->bss->bprm_creds_for_exec_hits, 0,
+			  "bprm_creds_for_exec_hits");
+		ASSERT_EQ(skel->bss->bprm_creds_from_file_hits, 0,
+			  "bprm_creds_from_file_hits");
+		ASSERT_EQ(skel->bss->lookup_calls, 0, "lookup_calls");
+		ASSERT_EQ(skel->bss->lookup_failed, 0, "lookup_failed");
+		ASSERT_EQ(skel->bss->restrict_calls, 0, "restrict_calls");
+		ASSERT_EQ(skel->bss->put_calls, 0, "put_calls");
+		return;
+	}
+
+	ASSERT_EQ(skel->bss->matched_pid, 1, "matched_pid");
+	ASSERT_EQ(skel->bss->lookup_calls, 1, "lookup_calls");
+	ASSERT_EQ(skel->bss->lookup_failed, 0, "lookup_failed");
+	ASSERT_EQ(skel->bss->restrict_calls, 1, "restrict_calls");
+	ASSERT_EQ(skel->bss->restrict_ret, expected_restrict_ret,
+		  "restrict_ret");
+	ASSERT_EQ(skel->bss->put_calls, 1, "put_calls");
+
+	if (hook->enable_bprm_creds_for_exec) {
+		ASSERT_EQ(skel->bss->bprm_creds_for_exec_hits, 1,
+			  "bprm_creds_for_exec_hits");
+		ASSERT_EQ(skel->bss->bprm_creds_from_file_hits, 0,
+			  "bprm_creds_from_file_hits");
+	} else {
+		ASSERT_EQ(skel->bss->bprm_creds_for_exec_hits, 0,
+			  "bprm_creds_for_exec_hits");
+		ASSERT_EQ(skel->bss->bprm_creds_from_file_hits, 1,
+			  "bprm_creds_from_file_hits");
+	}
+}
+
+static void
+run_case(struct landlock_kfuncs *skel, const struct landlock_test_env *env,
+	 const struct hook_variant *hook, const struct operation_case *op,
+	 const struct restrict_variant *variant, const char *subtest_name)
+{
+	int child_status;
+	int err;
+	int ruleset_fd;
+
+	if (!test__start_subtest(subtest_name))
+		return;
+
+	err = seed_operation_state(env, op);
+	if (!ASSERT_OK(err, "seed_baseline"))
+		return;
+
+	err = run_exec_attempt(skel, env, op, hook, variant, false, -1,
+			       &child_status);
+	if (!ASSERT_OK(err, "baseline_exec"))
+		return;
+	assert_operation_outcome(env, op, true, child_status);
+	assert_bpf_state(skel, hook, false, 0);
+
+	err = seed_operation_state(env, op);
+	if (!ASSERT_OK(err, "seed_enforced"))
+		return;
+
+	ruleset_fd = create_exec_ruleset(env, op);
+	if (!ASSERT_GE(ruleset_fd, 0, "create_ruleset"))
+		return;
+
+	err = run_exec_attempt(skel, env, op, hook, variant, true, ruleset_fd,
+			       &child_status);
+	close(ruleset_fd);
+	if (!ASSERT_OK(err, "enforced_exec"))
+		return;
+
+	assert_operation_outcome(env, op, !variant->expect_enforced,
+				 child_status);
+	assert_bpf_state(skel, hook, true, variant->expected_restrict_ret);
+	ASSERT_OK(delete_ruleset_map_elem(skel), "delete_ruleset_map_elem");
+}
+
+void test_landlock_kfuncs(void)
+{
+	struct landlock_test_env env = {};
+	struct landlock_kfuncs *skel = NULL;
+	int err;
+	int version;
+	size_t i;
+	size_t j;
+
+	version = landlock_version();
+	if (version < 1) {
+		test__skip();
+		return;
+	}
+
+	skel = landlock_kfuncs__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	err = landlock_kfuncs__attach(skel);
+	if (!ASSERT_OK(err, "attach"))
+		goto out;
+
+	err = prepare_layout(&env);
+	if (!ASSERT_OK(err, "prepare_layout"))
+		goto out;
+
+	ASSERT_OK(delete_ruleset_map_elem(skel), "delete_ruleset_map_elem");
+	reset_bss(skel);
+
+	for (i = 0; i < ARRAY_SIZE(hook_variants); i++) {
+		for (j = 0; j < ARRAY_SIZE(operation_cases); j++) {
+			char name[128];
+
+			ASSERT_LT(snprintf(name, sizeof(name),
+					   "%s/%s/no_previous_domain",
+					   hook_variants[i].name,
+					   operation_cases[j].name),
+				  (int)sizeof(name), "subtest_name_len");
+			run_case(skel, &env, &hook_variants[i],
+				 &operation_cases[j], &domain_variants[0],
+				 name);
+		}
+
+		for (j = 0; j < ARRAY_SIZE(domain_variants); j++) {
+			char name[128];
+
+			ASSERT_LT(snprintf(name, sizeof(name),
+					   "%s/write_file/%s",
+					   hook_variants[i].name,
+					   domain_variants[j].name),
+				  (int)sizeof(name), "subtest_name_len");
+			run_case(skel, &env, &hook_variants[i],
+				 &operation_cases[1], &domain_variants[j],
+				 name);
+		}
+
+		for (j = 0; j < ARRAY_SIZE(flag_variants); j++) {
+			char name[128];
+
+			ASSERT_LT(snprintf(name, sizeof(name),
+					   "%s/write_file/%s",
+					   hook_variants[i].name,
+					   flag_variants[j].name),
+				  (int)sizeof(name), "subtest_name_len");
+			run_case(skel, &env, &hook_variants[i],
+				 &operation_cases[1], &flag_variants[j], name);
+		}
+	}
+
+out:
+	if (env.base_dir[0])
+		cleanup_layout(&env);
+	landlock_kfuncs__destroy(skel);
+}
-- 
2.53.0

