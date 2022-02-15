Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5E5C433FE
	for <linux-security-module@archiver.kernel.org>; Tue, 15 Feb 2022 12:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237850AbiBOMm3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 15 Feb 2022 07:42:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237807AbiBOMmI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 15 Feb 2022 07:42:08 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E300140D1;
        Tue, 15 Feb 2022 04:41:43 -0800 (PST)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jygg61fqbz67y8P;
        Tue, 15 Feb 2022 20:40:50 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Feb 2022 13:41:41 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <shuah@kernel.org>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <andrii@kernel.org>, <kpsingh@kernel.org>,
        <revest@chromium.org>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v2 4/6] selftests/bpf: Add test for bpf_ima_file_hash()
Date:   Tue, 15 Feb 2022 13:40:40 +0100
Message-ID: <20220215124042.186506-5-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220215124042.186506-1-roberto.sassu@huawei.com>
References: <20220215124042.186506-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.63.22]
X-ClientProxiedBy: lhreml753-chm.china.huawei.com (10.201.108.203) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Modify the existing IMA test to call bpf_ima_file_hash() and update the
expected result accordingly.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 .../selftests/bpf/prog_tests/test_ima.c       | 29 ++++++++++++++++---
 tools/testing/selftests/bpf/progs/ima.c       | 10 +++++--
 2 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_ima.c b/tools/testing/selftests/bpf/prog_tests/test_ima.c
index 97d8a6f84f4a..62bf0e830453 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_ima.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_ima.c
@@ -13,9 +13,10 @@
 
 #include "ima.skel.h"
 
-static int run_measured_process(const char *measured_dir, u32 *monitored_pid)
+static int run_measured_process(const char *measured_dir, u32 *monitored_pid,
+				bool *use_ima_file_hash)
 {
-	int child_pid, child_status;
+	int err, child_pid, child_status;
 
 	child_pid = fork();
 	if (child_pid == 0) {
@@ -24,6 +25,21 @@ static int run_measured_process(const char *measured_dir, u32 *monitored_pid)
 		       NULL);
 		exit(errno);
 
+	} else if (child_pid > 0) {
+		waitpid(child_pid, &child_status, 0);
+		err = WEXITSTATUS(child_status);
+		if (err)
+			return err;
+	}
+
+	child_pid = fork();
+	if (child_pid == 0) {
+		*monitored_pid = getpid();
+		*use_ima_file_hash = true;
+		execlp("./ima_setup.sh", "./ima_setup.sh", "run", measured_dir,
+		       NULL);
+		exit(errno);
+
 	} else if (child_pid > 0) {
 		waitpid(child_pid, &child_status, 0);
 		return WEXITSTATUS(child_status);
@@ -72,12 +88,17 @@ void test_test_ima(void)
 	if (CHECK(err, "failed to run command", "%s, errno = %d\n", cmd, errno))
 		goto close_clean;
 
-	err = run_measured_process(measured_dir, &skel->bss->monitored_pid);
+	err = run_measured_process(measured_dir, &skel->bss->monitored_pid,
+				   &skel->bss->use_ima_file_hash);
 	if (CHECK(err, "run_measured_process", "err = %d\n", err))
 		goto close_clean;
 
 	err = ring_buffer__consume(ringbuf);
-	ASSERT_EQ(err, 1, "num_samples_or_err");
+	/*
+	 * 1 sample with use_ima_file_hash = false
+	 * 2 samples with use_ima_file_hash = true (./ima_setup.sh, /bin/true)
+	 */
+	ASSERT_EQ(err, 3, "num_samples_or_err");
 	ASSERT_NEQ(ima_hash_from_bpf, 0, "ima_hash");
 
 close_clean:
diff --git a/tools/testing/selftests/bpf/progs/ima.c b/tools/testing/selftests/bpf/progs/ima.c
index 96060ff4ffc6..9bb63f96cfc0 100644
--- a/tools/testing/selftests/bpf/progs/ima.c
+++ b/tools/testing/selftests/bpf/progs/ima.c
@@ -18,6 +18,8 @@ struct {
 
 char _license[] SEC("license") = "GPL";
 
+bool use_ima_file_hash;
+
 SEC("lsm.s/bprm_committed_creds")
 void BPF_PROG(ima, struct linux_binprm *bprm)
 {
@@ -28,8 +30,12 @@ void BPF_PROG(ima, struct linux_binprm *bprm)
 
 	pid = bpf_get_current_pid_tgid() >> 32;
 	if (pid == monitored_pid) {
-		ret = bpf_ima_inode_hash(bprm->file->f_inode, &ima_hash,
-					 sizeof(ima_hash));
+		if (!use_ima_file_hash)
+			ret = bpf_ima_inode_hash(bprm->file->f_inode, &ima_hash,
+						 sizeof(ima_hash));
+		else
+			ret = bpf_ima_file_hash(bprm->file, &ima_hash,
+						sizeof(ima_hash));
 		if (ret < 0 || ima_hash == 0)
 			return;
 
-- 
2.32.0

