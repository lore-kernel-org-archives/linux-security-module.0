Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B588C7EE29
	for <linux-security-module@archiver.kernel.org>; Fri,  2 Jun 2023 15:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbjFBPBg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 2 Jun 2023 11:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236314AbjFBPBF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 2 Jun 2023 11:01:05 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593CAE53
        for <linux-security-module@vger.kernel.org>; Fri,  2 Jun 2023 08:01:00 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 3527Y5qj003045
        for <linux-security-module@vger.kernel.org>; Fri, 2 Jun 2023 08:00:59 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3qyc3papjm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Fri, 02 Jun 2023 08:00:59 -0700
Received: from twshared44841.48.prn1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 2 Jun 2023 08:00:58 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 261E131E04B7C; Fri,  2 Jun 2023 08:00:50 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>
CC:     <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <brauner@kernel.org>, <lennart@poettering.net>,
        <cyphar@cyphar.com>, <luto@kernel.org>
Subject: [PATCH RESEND bpf-next 18/18] selftests/bpf: add BPF token-enabled BPF_PROG_LOAD tests
Date:   Fri, 2 Jun 2023 08:00:11 -0700
Message-ID: <20230602150011.1657856-19-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230602150011.1657856-1-andrii@kernel.org>
References: <20230602150011.1657856-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: kH4hUrNOt53NNaUsCxM7Xt875ejki43i
X-Proofpoint-ORIG-GUID: kH4hUrNOt53NNaUsCxM7Xt875ejki43i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_11,2023-06-02_02,2023-05-22_02
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Add a test validating that BPF token can be used to load privileged BPF
program using privileged BPF helpers through delegated BPF token created
by privileged process.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/token.c  | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/token.c b/tools/testing/selftests/bpf/prog_tests/token.c
index b141f722c0c6..d5093ededf06 100644
--- a/tools/testing/selftests/bpf/prog_tests/token.c
+++ b/tools/testing/selftests/bpf/prog_tests/token.c
@@ -4,6 +4,7 @@
 #include <test_progs.h>
 #include <bpf/btf.h>
 #include "cap_helpers.h"
+#include <linux/filter.h>
 
 static int drop_priv_caps(__u64 *old_caps)
 {
@@ -191,6 +192,83 @@ static void subtest_btf_token(void)
 		ASSERT_OK(restore_priv_caps(old_caps), "restore_caps");
 }
 
+static void subtest_prog_token(void)
+{
+	LIBBPF_OPTS(bpf_token_create_opts, token_opts);
+	LIBBPF_OPTS(bpf_prog_load_opts, prog_opts);
+	int token_fd = 0, prog_fd = 0;
+	__u64 old_caps = 0;
+	struct bpf_insn insns[] = {
+		/* bpf_jiffies64() requires CAP_BPF */
+		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_jiffies64),
+		/* bpf_get_current_task() requires CAP_PERFMON */
+		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_current_task),
+		/* r0 = 0; exit; */
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	size_t insn_cnt = ARRAY_SIZE(insns);
+
+	/* check that IGNORE_UNKNOWN_PROG_TYPES flag is respected */
+	token_opts.flags = BPF_F_TOKEN_IGNORE_UNKNOWN_PROG_TYPES;
+	token_opts.allowed_prog_types = ~0ULL; /* any current and future prog type is allowed */
+	token_opts.allowed_attach_types = 0;
+	token_fd = bpf_token_create(&token_opts);
+	if (!ASSERT_GT(token_fd, 0, "token_create_prog_type_future_proof"))
+		return;
+	close(token_fd);
+
+	/* check that IGNORE_UNKNOWN_ATTACH_TYPES flag is respected */
+	token_opts.flags = BPF_F_TOKEN_IGNORE_UNKNOWN_ATTACH_TYPES;
+	token_opts.allowed_prog_types = 0;
+	token_opts.allowed_attach_types = ~0ULL; /* any current and future attach type is allowed */
+	token_fd = bpf_token_create(&token_opts);
+	if (!ASSERT_GT(token_fd, 0, "token_create_prog_type_future_proof"))
+		return;
+	close(token_fd);
+
+	/* create BPF token allowing BPF_PROG_LOAD command */
+	token_opts.flags = 0;
+	token_opts.allowed_cmds = 1ULL << BPF_PROG_LOAD;
+	token_opts.allowed_prog_types = 1ULL << BPF_PROG_TYPE_XDP;
+	token_opts.allowed_attach_types = 1ULL << BPF_XDP;
+	token_fd = bpf_token_create(&token_opts);
+	if (!ASSERT_GT(token_fd, 0, "token_create"))
+		return;
+
+	/* drop privileges to test token_fd passing */
+	if (!ASSERT_OK(drop_priv_caps(&old_caps), "drop_caps"))
+		goto cleanup;
+
+	/* validate we can successfully load BPF program with token; this
+	 * being XDP program (CAP_NET_ADMIN) using bpf_jiffies64() (CAP_BPF)
+	 * and bpf_get_current_task() (CAP_PERFMON) helpers validates we have
+	 * BPF token wired properly in a bunch of places in the kernel
+	 */
+	prog_opts.token_fd = token_fd;
+	prog_opts.expected_attach_type = BPF_XDP;
+	prog_fd = bpf_prog_load(BPF_PROG_TYPE_XDP, "token_prog", "GPL",
+				insns, insn_cnt, &prog_opts);
+	if (!ASSERT_GT(prog_fd, 0, "prog_fd"))
+		goto cleanup;
+	close(prog_fd);
+
+	/* now validate that we *cannot* load BPF program without token */
+	prog_opts.token_fd = 0;
+	prog_fd = bpf_prog_load(BPF_PROG_TYPE_XDP, "token_prog", "GPL",
+				insns, insn_cnt, &prog_opts);
+	if (!ASSERT_EQ(prog_fd, -EPERM, "prog_fd_eperm"))
+		goto cleanup;
+
+cleanup:
+	if (prog_fd > 0)
+		close(prog_fd);
+	if (token_fd)
+		close(token_fd);
+	if (old_caps)
+		ASSERT_OK(restore_priv_caps(old_caps), "restore_caps");
+}
+
 void test_token(void)
 {
 	if (test__start_subtest("token_create"))
@@ -199,4 +277,6 @@ void test_token(void)
 		subtest_map_token();
 	if (test__start_subtest("btf_token"))
 		subtest_btf_token();
+	if (test__start_subtest("prog_token"))
+		subtest_prog_token();
 }
-- 
2.34.1

