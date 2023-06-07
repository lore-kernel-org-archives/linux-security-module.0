Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090B5C7EE23
	for <linux-security-module@archiver.kernel.org>; Wed,  7 Jun 2023 23:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbjFGXyg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 7 Jun 2023 19:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233421AbjFGXye (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 7 Jun 2023 19:54:34 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518662694
        for <linux-security-module@vger.kernel.org>; Wed,  7 Jun 2023 16:54:29 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357HPIjk002717
        for <linux-security-module@vger.kernel.org>; Wed, 7 Jun 2023 16:54:29 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3r2n4cxjr5-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Wed, 07 Jun 2023 16:54:28 -0700
Received: from twshared40933.03.prn6.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 16:54:27 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 7089A32857E2B; Wed,  7 Jun 2023 16:54:20 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>
CC:     <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <brauner@kernel.org>, <lennart@poettering.net>,
        <cyphar@cyphar.com>, <luto@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v2 bpf-next 12/18] selftests/bpf: add BPF token-enabled BPF_BTF_LOAD selftest
Date:   Wed, 7 Jun 2023 16:53:46 -0700
Message-ID: <20230607235352.1723243-13-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607235352.1723243-1-andrii@kernel.org>
References: <20230607235352.1723243-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: byS1lScmEWxfvLGzprSYBdRqtAi3S6I0
X-Proofpoint-ORIG-GUID: byS1lScmEWxfvLGzprSYBdRqtAi3S6I0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_13,2023-06-07_01,2023-05-22_02
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Add a simple test validating that BTF loading can be done from
unprivileged process through delegated BPF token.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/token.c  | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/token.c b/tools/testing/selftests/bpf/prog_tests/token.c
index 61707b3e81a7..ff8ada405576 100644
--- a/tools/testing/selftests/bpf/prog_tests/token.c
+++ b/tools/testing/selftests/bpf/prog_tests/token.c
@@ -134,10 +134,65 @@ static void subtest_map_token(void)
 		ASSERT_OK(restore_priv_caps(old_caps), "restore_caps");
 }
 
+static void subtest_btf_token(void)
+{
+	LIBBPF_OPTS(bpf_token_create_opts, token_opts);
+	LIBBPF_OPTS(bpf_btf_load_opts, btf_opts);
+	int token_fd = 0, btf_fd = 0;
+	const void *raw_btf_data;
+	struct btf *btf = NULL;
+	__u32 raw_btf_size;
+	__u64 old_caps = 0;
+
+	/* create BPF token allowing BPF_BTF_LOAD command */
+	token_opts.allowed_cmds = 1ULL << BPF_BTF_LOAD;
+	token_fd = bpf_token_create(&token_opts);
+	if (!ASSERT_GT(token_fd, 0, "token_create"))
+		return;
+
+	/* drop privileges to test token_fd passing */
+	if (!ASSERT_OK(drop_priv_caps(&old_caps), "drop_caps"))
+		goto cleanup;
+
+	btf = btf__new_empty();
+	if (!ASSERT_OK_PTR(btf, "empty_btf"))
+		goto cleanup;
+
+	ASSERT_GT(btf__add_int(btf, "int", 4, 0), 0, "int_type");
+
+	raw_btf_data = btf__raw_data(btf, &raw_btf_size);
+	if (!ASSERT_OK_PTR(raw_btf_data, "raw_btf_data"))
+		goto cleanup;
+
+	/* validate we can successfully load new BTF with token */
+	btf_opts.token_fd = token_fd;
+	btf_fd = bpf_btf_load(raw_btf_data, raw_btf_size, &btf_opts);
+	if (!ASSERT_GT(btf_fd, 0, "btf_fd"))
+		goto cleanup;
+	close(btf_fd);
+
+	/* now validate that we *cannot* load BTF without token */
+	btf_opts.token_fd = 0;
+	btf_fd = bpf_btf_load(raw_btf_data, raw_btf_size, &btf_opts);
+	if (!ASSERT_EQ(btf_fd, -EPERM, "btf_fd_eperm"))
+		goto cleanup;
+
+cleanup:
+	btf__free(btf);
+	if (btf_fd > 0)
+		close(btf_fd);
+	if (token_fd)
+		close(token_fd);
+	if (old_caps)
+		ASSERT_OK(restore_priv_caps(old_caps), "restore_caps");
+}
+
 void test_token(void)
 {
 	if (test__start_subtest("token_create"))
 		subtest_token_create();
 	if (test__start_subtest("map_token"))
 		subtest_map_token();
+	if (test__start_subtest("btf_token"))
+		subtest_btf_token();
 }
-- 
2.34.1

