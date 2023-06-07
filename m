Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A80C77B7A
	for <linux-security-module@archiver.kernel.org>; Wed,  7 Jun 2023 23:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbjFGXy0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 7 Jun 2023 19:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbjFGXyR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 7 Jun 2023 19:54:17 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDB8213B
        for <linux-security-module@vger.kernel.org>; Wed,  7 Jun 2023 16:54:16 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357HFjMS021697
        for <linux-security-module@vger.kernel.org>; Wed, 7 Jun 2023 16:54:16 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3r2a792t3b-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Wed, 07 Jun 2023 16:54:16 -0700
Received: from twshared40933.03.prn6.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 16:54:14 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id E5FC932857E01; Wed,  7 Jun 2023 16:54:12 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>
CC:     <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <brauner@kernel.org>, <lennart@poettering.net>,
        <cyphar@cyphar.com>, <luto@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v2 bpf-next 09/18] selftests/bpf: add BPF token-enabled test for BPF_MAP_CREATE command
Date:   Wed, 7 Jun 2023 16:53:43 -0700
Message-ID: <20230607235352.1723243-10-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607235352.1723243-1-andrii@kernel.org>
References: <20230607235352.1723243-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: keS6p7DPvJZiTABdOxpNCJp2YsmEj2FI
X-Proofpoint-ORIG-GUID: keS6p7DPvJZiTABdOxpNCJp2YsmEj2FI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_13,2023-06-07_01,2023-05-22_02
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Add test for creating BPF token with support for BPF_MAP_CREATE
delegation. And validate that its allowed_map_types filter works as
expected and allows to create privileged BPF maps through delegated
token, as long as they are allowed by privileged creator of a token.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/token.c  | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/token.c b/tools/testing/selftests/bpf/prog_tests/token.c
index cba84c480ac5..61707b3e81a7 100644
--- a/tools/testing/selftests/bpf/prog_tests/token.c
+++ b/tools/testing/selftests/bpf/prog_tests/token.c
@@ -86,8 +86,58 @@ static void subtest_token_create(void)
 		ASSERT_OK(restore_priv_caps(old_caps), "restore_caps");
 }
 
+static void subtest_map_token(void)
+{
+	LIBBPF_OPTS(bpf_token_create_opts, token_opts);
+	LIBBPF_OPTS(bpf_map_create_opts, map_opts);
+	int token_fd = 0, map_fd = 0;
+	__u64 old_caps = 0;
+
+	/* check that it's ok to allow any map type */
+	token_opts.allowed_map_types = ~0ULL; /* any current and future map types is allowed */
+	token_fd = bpf_token_create(&token_opts);
+	if (!ASSERT_GT(token_fd, 0, "token_create_future_proof"))
+		return;
+	close(token_fd);
+
+	/* create BPF token allowing STACK, but not QUEUE map */
+	token_opts.allowed_cmds = 1ULL << BPF_MAP_CREATE;
+	token_opts.allowed_map_types = 1ULL << BPF_MAP_TYPE_STACK; /* but not QUEUE */
+	token_fd = bpf_token_create(&token_opts);
+	if (!ASSERT_GT(token_fd, 0, "token_create"))
+		return;
+
+	/* drop privileges to test token_fd passing */
+	if (!ASSERT_OK(drop_priv_caps(&old_caps), "drop_caps"))
+		goto cleanup;
+
+	/* BPF_MAP_TYPE_STACK is privileged, but with given token_fd should succeed */
+	map_opts.token_fd = token_fd;
+	map_fd = bpf_map_create(BPF_MAP_TYPE_STACK, "token_stack", 0, 8, 1, &map_opts);
+	if (!ASSERT_GT(map_fd, 0, "stack_map_fd"))
+		goto cleanup;
+	close(map_fd);
+	map_fd = 0;
+
+	/* BPF_MAP_TYPE_QUEUE is privileged, and token doesn't allow it, so should fail */
+	map_opts.token_fd = token_fd;
+	map_fd = bpf_map_create(BPF_MAP_TYPE_QUEUE, "token_queue", 0, 8, 1, &map_opts);
+	if (!ASSERT_EQ(map_fd, -EPERM, "queue_map_fd"))
+		goto cleanup;
+
+cleanup:
+	if (map_fd > 0)
+		close(map_fd);
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
+	if (test__start_subtest("map_token"))
+		subtest_map_token();
 }
-- 
2.34.1

