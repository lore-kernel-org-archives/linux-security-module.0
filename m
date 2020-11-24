Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB005C64E7B
	for <linux-security-module@archiver.kernel.org>; Tue, 24 Nov 2020 15:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9679E206D4
	for <linux-security-module@archiver.kernel.org>; Tue, 24 Nov 2020 15:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c/dkqqDE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389304AbgKXPMW (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 24 Nov 2020 10:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389580AbgKXPMR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 24 Nov 2020 10:12:17 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70465C0613D6
        for <linux-security-module@vger.kernel.org>; Tue, 24 Nov 2020 07:12:16 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id x22so2710026wmc.5
        for <linux-security-module@vger.kernel.org>; Tue, 24 Nov 2020 07:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D7JMOLrkMMbgevNC61+0DIHgDGPPJS+bWf43N7huZE4=;
        b=c/dkqqDERVTz4nu8SZ1gJ/LT6g48/emtgI7ARP3cPql+gzxhR/llp/kIJuITTF1sZR
         fh+rmIb7R7TznZ8FVI9Z/LhFHPlPINvxoIPWfgt5ulrRAqAavc3Qv4HfO6kBv5NnsORC
         to35R6Dmw0QVByyXkQqnwjrPTPq79GJissoQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D7JMOLrkMMbgevNC61+0DIHgDGPPJS+bWf43N7huZE4=;
        b=PCOugh5qTS5vi1bbMf3zAgwPkCHGN0GDgVEFmSMhsZwvoCnX0C6EefGLiVkxTNeM7O
         RRHCdVlob0jD5oc5dZq9Q0HoKievYHixmZiu2Nc+nLw/W+J6gahorLzylh/yvjoDivrf
         /oFpMUJr1fGgItqjGXARWeYZRU+DlvuHo6TwFoeB6fssVgVcLpay2Do+idATkRO4iTSK
         /1XKKUa/R12SfPsfBh9XTJddaFzZZbGrZq2LKhtYF3Mv1AuAcdCi37hNGfn7oQcV2qwu
         7Gv/ReAckQOctwHIcEf7VdyA0VughLTYavlwdvgnfFcB0z9Hj3pRDOoAV1pXJSSGgusv
         QegQ==
X-Gm-Message-State: AOAM533Kc3OU0bFNOiE89rVcUJKT7IeqvImua/cAR8daDwojsXF2ilvP
        RdPc5CAbqz/CraTbpU1brChDRw==
X-Google-Smtp-Source: ABdhPJwgYZ/acFThNsyVH2bB62qgxFgAVcLZ6MTj6oIq8/O6eWQRRAbFALJ3L2mumZdTfu17A2MgWg==
X-Received: by 2002:a05:600c:22d5:: with SMTP id 21mr4944281wmg.33.1606230735161;
        Tue, 24 Nov 2020 07:12:15 -0800 (PST)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id g131sm6353127wma.35.2020.11.24.07.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 07:12:14 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH bpf-next v3 3/3] bpf: Add a selftest for bpf_ima_inode_hash
Date:   Tue, 24 Nov 2020 15:12:10 +0000
Message-Id: <20201124151210.1081188-4-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
In-Reply-To: <20201124151210.1081188-1-kpsingh@chromium.org>
References: <20201124151210.1081188-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: KP Singh <kpsingh@google.com>

The test does the following:

- Mounts a loopback filesystem and appends the IMA policy to measure
  executions only on this file-system. Restricting the IMA policy to a
  particular filesystem prevents a system-wide IMA policy change.
- Executes an executable copied to this loopback filesystem.
- Calls the bpf_ima_inode_hash in the bprm_committed_creds hook and
  checks if the call succeeded and checks if a hash was calculated.

The test shells out to the added ima_setup.sh script as the setup is
better handled in a shell script and is more complicated to do in the
test program or even shelling out individual commands from C.

The list of required configs (i.e. IMA, SECURITYFS,
IMA_{WRITE,READ}_POLICY) for running this test are also updated.

Signed-off-by: KP Singh <kpsingh@google.com>
---
 tools/testing/selftests/bpf/config            |  4 +
 tools/testing/selftests/bpf/ima_setup.sh      | 80 +++++++++++++++++++
 .../selftests/bpf/prog_tests/test_ima.c       | 74 +++++++++++++++++
 tools/testing/selftests/bpf/progs/ima.c       | 28 +++++++
 4 files changed, 186 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/ima_setup.sh
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_ima.c
 create mode 100644 tools/testing/selftests/bpf/progs/ima.c

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 2118e23ac07a..365bf9771b07 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -39,3 +39,7 @@ CONFIG_BPF_JIT=y
 CONFIG_BPF_LSM=y
 CONFIG_SECURITY=y
 CONFIG_LIRC=y
+CONFIG_IMA=y
+CONFIG_SECURITYFS=y
+CONFIG_IMA_WRITE_POLICY=y
+CONFIG_IMA_READ_POLICY=y
diff --git a/tools/testing/selftests/bpf/ima_setup.sh b/tools/testing/selftests/bpf/ima_setup.sh
new file mode 100644
index 000000000000..15490ccc5e55
--- /dev/null
+++ b/tools/testing/selftests/bpf/ima_setup.sh
@@ -0,0 +1,80 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+set -u
+
+IMA_POLICY_FILE="/sys/kernel/security/ima/policy"
+TEST_BINARY="/bin/true"
+
+usage()
+{
+        echo "Usage: $0 <setup|cleanup|run> <existing_tmp_dir>"
+        exit 1
+}
+
+setup()
+{
+        local tmp_dir="$1"
+        local mount_img="${tmp_dir}/test.img"
+        local mount_dir="${tmp_dir}/mnt"
+        local copied_bin_path="${mount_dir}/$(basename ${TEST_BINARY})"
+        mkdir -p ${mount_dir}
+
+        dd if=/dev/zero of="${mount_img}" bs=1M count=10
+
+        local loop_device="$(losetup --find --show ${mount_img})"
+
+        mkfs.ext4 "${loop_device}"
+        mount "${loop_device}" "${mount_dir}"
+
+        cp "${TEST_BINARY}" "${mount_dir}"
+        local mount_uuid="$(blkid -s UUID -o value ${loop_device})"
+        echo "measure func=BPRM_CHECK fsuuid=${mount_uuid}" > ${IMA_POLICY_FILE}
+}
+
+cleanup() {
+        local tmp_dir="$1"
+        local mount_img="${tmp_dir}/test.img"
+        local mount_dir="${tmp_dir}/mnt"
+
+        local loop_devices=$(losetup -j ${mount_img} -O NAME --noheadings)
+        for loop_dev in "${loop_devices}"; do
+                losetup -d $loop_dev
+        done
+
+        umount ${mount_dir}
+        rm -rf ${tmp_dir}
+}
+
+run()
+{
+        local tmp_dir="$1"
+        local mount_dir="${tmp_dir}/mnt"
+        local copied_bin_path="${mount_dir}/$(basename ${TEST_BINARY})"
+
+        exec "${copied_bin_path}"
+}
+
+main()
+{
+        [[ $# -ne 2 ]] && usage
+
+        local action="$1"
+        local tmp_dir="$2"
+
+        [[ ! -d "${tmp_dir}" ]] && echo "Directory ${tmp_dir} doesn't exist" && exit 1
+
+        if [[ "${action}" == "setup" ]]; then
+                setup "${tmp_dir}"
+        elif [[ "${action}" == "cleanup" ]]; then
+                cleanup "${tmp_dir}"
+        elif [[ "${action}" == "run" ]]; then
+                run "${tmp_dir}"
+        else
+                echo "Unknown action: ${action}"
+                exit 1
+        fi
+}
+
+main "$@"
diff --git a/tools/testing/selftests/bpf/prog_tests/test_ima.c b/tools/testing/selftests/bpf/prog_tests/test_ima.c
new file mode 100644
index 000000000000..61fca681d524
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_ima.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (C) 2020 Google LLC.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <sys/wait.h>
+#include <test_progs.h>
+
+#include "ima.skel.h"
+
+static int run_measured_process(const char *measured_dir, u32 *monitored_pid)
+{
+	int child_pid, child_status;
+
+	child_pid = fork();
+	if (child_pid == 0) {
+		*monitored_pid = getpid();
+		execlp("./ima_setup.sh", "./ima_setup.sh", "run", measured_dir,
+		       NULL);
+		exit(errno);
+
+	} else if (child_pid > 0) {
+		waitpid(child_pid, &child_status, 0);
+		return WEXITSTATUS(child_status);
+	}
+
+	return -EINVAL;
+}
+
+void test_test_ima(void)
+{
+	char measured_dir_template[] = "/tmp/ima_measuredXXXXXX";
+	const char *measured_dir;
+	char cmd[256];
+
+	int err, duration = 0;
+	struct ima *skel = NULL;
+
+	skel = ima__open_and_load();
+	if (CHECK(!skel, "skel_load", "skeleton failed\n"))
+		goto close_prog;
+
+	err = ima__attach(skel);
+	if (CHECK(err, "attach", "attach failed: %d\n", err))
+		goto close_prog;
+
+	measured_dir = mkdtemp(measured_dir_template);
+	if (CHECK(measured_dir == NULL, "mkdtemp", "err %d\n", errno))
+		goto close_prog;
+
+	snprintf(cmd, sizeof(cmd), "./ima_setup.sh setup %s", measured_dir);
+	if (CHECK_FAIL(system(cmd)))
+		goto close_clean;
+
+	err = run_measured_process(measured_dir, &skel->bss->monitored_pid);
+	if (CHECK(err, "run_measured_process", "err = %d\n", err))
+		goto close_clean;
+
+	CHECK(skel->data->ima_hash_ret < 0, "ima_hash_ret",
+	      "ima_hash_ret = %ld\n", skel->data->ima_hash_ret);
+
+	CHECK(skel->bss->ima_hash == 0, "ima_hash",
+	      "ima_hash = %lu\n", skel->bss->ima_hash);
+
+close_clean:
+	snprintf(cmd, sizeof(cmd), "./ima_setup.sh cleanup %s", measured_dir);
+	CHECK_FAIL(system(cmd));
+close_prog:
+	ima__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/ima.c b/tools/testing/selftests/bpf/progs/ima.c
new file mode 100644
index 000000000000..86b21aff4bc5
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/ima.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2020 Google LLC.
+ */
+
+#include "vmlinux.h"
+#include <errno.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+long ima_hash_ret = -1;
+u64 ima_hash = 0;
+u32 monitored_pid = 0;
+
+char _license[] SEC("license") = "GPL";
+
+SEC("lsm.s/bprm_committed_creds")
+int BPF_PROG(ima, struct linux_binprm *bprm)
+{
+	u32 pid = bpf_get_current_pid_tgid() >> 32;
+
+	if (pid == monitored_pid)
+		ima_hash_ret = bpf_ima_inode_hash(bprm->file->f_inode,
+						  &ima_hash, sizeof(ima_hash));
+
+	return 0;
+}
-- 
2.29.2.454.gaff20da3a2-goog

