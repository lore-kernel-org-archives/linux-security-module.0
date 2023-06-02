Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD48EC77B7A
	for <linux-security-module@archiver.kernel.org>; Fri,  2 Jun 2023 15:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236331AbjFBPBi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 2 Jun 2023 11:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236373AbjFBPBI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 2 Jun 2023 11:01:08 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6768E4D
        for <linux-security-module@vger.kernel.org>; Fri,  2 Jun 2023 08:01:07 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 3527V8DL028611
        for <linux-security-module@vger.kernel.org>; Fri, 2 Jun 2023 08:01:07 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3qyc3papkt-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Fri, 02 Jun 2023 08:01:06 -0700
Received: from twshared25760.37.frc1.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 2 Jun 2023 08:00:39 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 969CD31E04936; Fri,  2 Jun 2023 08:00:30 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>
CC:     <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <brauner@kernel.org>, <lennart@poettering.net>,
        <cyphar@cyphar.com>, <luto@kernel.org>
Subject: [PATCH RESEND bpf-next 09/18] selftests/bpf: add BPF token-enabled test for BPF_MAP_CREATE command
Date:   Fri, 2 Jun 2023 08:00:02 -0700
Message-ID: <20230602150011.1657856-10-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230602150011.1657856-1-andrii@kernel.org>
References: <20230602150011.1657856-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: gA7s-O4J64iwI_62hJ9py3NHh4dQV9EN
X-Proofpoint-ORIG-GUID: gA7s-O4J64iwI_62hJ9py3NHh4dQV9EN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_11,2023-06-02_02,2023-05-22_02
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Add test for creating BPF token with support for BPF_MAP_CREATE
delegation. And validate that its allowed_map_types filter works as
expected and allows to create privileged BPF maps through delegated
token, as long as they are allowed by privileged creator of a token.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/token.c  | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/token.c b/tools/testing/selftests/bpf/prog_tests/token.c
index fe78b558d697..0b6e699d2439 100644
--- a/tools/testing/selftests/bpf/prog_tests/token.c
+++ b/tools/testing/selftests/bpf/prog_tests/token.c
@@ -88,8 +88,60 @@ static void subtest_token_create(void)
 		ASSERT_OK(restore_priv_caps(old_caps), "restore_caps");
 }
 
+static void subtest_map_token(void)
+{
+	LIBBPF_OPTS(bpf_token_create_opts, token_opts);
+	LIBBPF_OPTS(bpf_map_create_opts, map_opts);
+	int token_fd = 0, map_fd = 0;
+	__u64 old_caps = 0;
+
+	/* check that IGNORE_UNKNOWN_MAP_TYPES flag is respected */
+	token_opts.flags = BPF_F_TOKEN_IGNORE_UNKNOWN_MAP_TYPES;
+	token_opts.allowed_map_types = ~0ULL; /* any current and future map types is allowed */
+	token_fd = bpf_token_create(&token_opts);
+	if (!ASSERT_GT(token_fd, 0, "token_create_future_proof"))
+		return;
+	close(token_fd);
+
+	/* create BPF token allowing STACK, but not QUEUE map */
+	token_opts.flags = 0;
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

