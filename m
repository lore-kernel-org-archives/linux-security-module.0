Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E48C63798
	for <linux-security-module@archiver.kernel.org>; Fri, 20 Nov 2020 13:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5834E22264
	for <linux-security-module@archiver.kernel.org>; Fri, 20 Nov 2020 13:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XkdruCUC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbgKTNRP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 20 Nov 2020 08:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727677AbgKTNRO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 20 Nov 2020 08:17:14 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C47C061A04
        for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2020 05:17:14 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id u12so10060045wrt.0
        for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2020 05:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KobsDfLvvwwoQBJaQpY6EUfIO/NscqTe50uGy1eW/88=;
        b=XkdruCUCJy0vVXiI0GdwzPsjTOtz+tLforHPSGq48dki799F2HBzUYbMZEaoQGkyz8
         NyLIqjENSc/9cf89Uo7YA/4fY7/UCK6qyp7hCF1l9+4whOJmqJrj2iOR7teHYo98Eb9i
         IJ3UiZWpp1zl/QGGMJ3snJvt4i9Q0ShVd9O0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KobsDfLvvwwoQBJaQpY6EUfIO/NscqTe50uGy1eW/88=;
        b=IImZA7Zzjb8va7n84Ylc6Zn9WqPEWH7UWs91QK50jHl0bcq3Us3wnGi0D1XGGmt9m/
         Mopo6izsBf9zlsUcmIu4QzPaxp1cvG5jC8pQDb6yyDTerkvpG/B2BrfPkRg/vLOgbF3X
         RNk6yiilNwWp4VSQngaergDVwBhuVrNg4/1Xfky04qNDREMg0dgtoLlQx3VBm7KIAk11
         3EdHGEWZ3arZKngQD7I/Dl19hkyhCo1lunLSusjW2LORR2yefTeQHCXmMcIEVV9VA/s8
         R/hHlnec6tEgXNLmCeHa1/02jV40S05vEevzNuOJBOnSUKWw3P1IbzlocZFscW6YSJBv
         Agqw==
X-Gm-Message-State: AOAM531CTWskHJ5nk3CYkjTouWu84+iYWlZw+syd4Kofu6YuAKBbi8Nf
        8UTs+eQlhjIqRoKMSzQDp7XH9w==
X-Google-Smtp-Source: ABdhPJzUiKdrYOVWCnJTxkk/+DH44xU6PKfkwEBAAvSc9pFneQYoKimqm1y1FMfpgOt5H2pwz7MT3A==
X-Received: by 2002:adf:f246:: with SMTP id b6mr15269927wrp.238.1605878232682;
        Fri, 20 Nov 2020 05:17:12 -0800 (PST)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id u203sm4260197wme.32.2020.11.20.05.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 05:17:12 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH bpf-next 3/3] bpf: Update LSM selftests for bpf_ima_inode_hash
Date:   Fri, 20 Nov 2020 13:17:08 +0000
Message-Id: <20201120131708.3237864-3-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
In-Reply-To: <20201120131708.3237864-1-kpsingh@chromium.org>
References: <20201120131708.3237864-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: KP Singh <kpsingh@google.com>

- Update the IMA policy before executing the test binary (this is not an
  override of the policy, just an append that ensures that hashes are
  calculated on executions).

- Call the bpf_ima_inode_hash in the bprm_committed_creds hook and check
  if the call succeeded and a hash was calculated.

Signed-off-by: KP Singh <kpsingh@google.com>
---
 tools/testing/selftests/bpf/config            |  3 ++
 .../selftests/bpf/prog_tests/test_lsm.c       | 32 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/lsm.c       |  7 +++-
 3 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 2118e23ac07a..4b5764031368 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -39,3 +39,6 @@ CONFIG_BPF_JIT=y
 CONFIG_BPF_LSM=y
 CONFIG_SECURITY=y
 CONFIG_LIRC=y
+CONFIG_IMA=y
+CONFIG_IMA_WRITE_POLICY=y
+CONFIG_IMA_READ_POLICY=y
diff --git a/tools/testing/selftests/bpf/prog_tests/test_lsm.c b/tools/testing/selftests/bpf/prog_tests/test_lsm.c
index 6ab29226c99b..3f5d64adb233 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_lsm.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_lsm.c
@@ -52,6 +52,28 @@ int exec_cmd(int *monitored_pid)
 	return -EINVAL;
 }
 
+#define IMA_POLICY "measure func=BPRM_CHECK"
+
+/* This does not override the policy, IMA policy updates are
+ * append only, so this just ensures that "measure func=BPRM_CHECK"
+ * is in the policy. IMA does not allow us to remove this line once
+ * it is added.
+ */
+static int update_ima_policy(void)
+{
+	int fd, ret = 0;
+
+	fd = open("/sys/kernel/security/ima/policy", O_WRONLY);
+	if (fd < 0)
+		return -errno;
+
+	if (write(fd, IMA_POLICY, sizeof(IMA_POLICY)) == -1)
+		ret = -errno;
+
+	close(fd);
+	return ret;
+}
+
 void test_test_lsm(void)
 {
 	struct lsm *skel = NULL;
@@ -66,6 +88,10 @@ void test_test_lsm(void)
 	if (CHECK(err, "attach", "lsm attach failed: %d\n", err))
 		goto close_prog;
 
+	err = update_ima_policy();
+	if (CHECK(err != 0, "update_ima_policy", "error = %d\n", err))
+		goto close_prog;
+
 	err = exec_cmd(&skel->bss->monitored_pid);
 	if (CHECK(err < 0, "exec_cmd", "err %d errno %d\n", err, errno))
 		goto close_prog;
@@ -83,6 +109,12 @@ void test_test_lsm(void)
 	CHECK(skel->bss->mprotect_count != 1, "mprotect_count",
 	      "mprotect_count = %d\n", skel->bss->mprotect_count);
 
+	CHECK(skel->data->ima_hash_ret < 0, "ima_hash_ret",
+	      "ima_hash_ret = %d\n", skel->data->ima_hash_ret);
+
+	CHECK(skel->bss->ima_hash == 0, "ima_hash",
+	      "ima_hash = %lu\n", skel->bss->ima_hash);
+
 	syscall(__NR_setdomainname, &buf, -2L);
 	syscall(__NR_setdomainname, 0, -3L);
 	syscall(__NR_setdomainname, ~0L, -4L);
diff --git a/tools/testing/selftests/bpf/progs/lsm.c b/tools/testing/selftests/bpf/progs/lsm.c
index ff4d343b94b5..b0f9639e4b0a 100644
--- a/tools/testing/selftests/bpf/progs/lsm.c
+++ b/tools/testing/selftests/bpf/progs/lsm.c
@@ -35,6 +35,8 @@ char _license[] SEC("license") = "GPL";
 int monitored_pid = 0;
 int mprotect_count = 0;
 int bprm_count = 0;
+int ima_hash_ret = -1;
+u64 ima_hash = 0;
 
 SEC("lsm/file_mprotect")
 int BPF_PROG(test_int_hook, struct vm_area_struct *vma,
@@ -65,8 +67,11 @@ int BPF_PROG(test_void_hook, struct linux_binprm *bprm)
 	__u32 key = 0;
 	__u64 *value;
 
-	if (monitored_pid == pid)
+	if (monitored_pid == pid) {
 		bprm_count++;
+		ima_hash_ret = bpf_ima_inode_hash(bprm->file->f_inode,
+						  &ima_hash, sizeof(ima_hash));
+	}
 
 	bpf_copy_from_user(args, sizeof(args), (void *)bprm->vma->vm_mm->arg_start);
 	bpf_copy_from_user(args, sizeof(args), (void *)bprm->mm->arg_start);
-- 
2.29.2.454.gaff20da3a2-goog

