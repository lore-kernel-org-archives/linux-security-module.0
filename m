Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1ABC7EE23
	for <linux-security-module@archiver.kernel.org>; Wed,  7 Jun 2023 23:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbjFGXyL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 7 Jun 2023 19:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjFGXyK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 7 Jun 2023 19:54:10 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FD3213B
        for <linux-security-module@vger.kernel.org>; Wed,  7 Jun 2023 16:54:07 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357HIbKx019828
        for <linux-security-module@vger.kernel.org>; Wed, 7 Jun 2023 16:54:07 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3r2a81audc-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Wed, 07 Jun 2023 16:54:06 -0700
Received: from twshared52565.14.frc2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 16:54:04 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id A6F7F32857D38; Wed,  7 Jun 2023 16:53:56 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>
CC:     <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <brauner@kernel.org>, <lennart@poettering.net>,
        <cyphar@cyphar.com>, <luto@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v2 bpf-next 02/18] libbpf: add bpf_token_create() API
Date:   Wed, 7 Jun 2023 16:53:36 -0700
Message-ID: <20230607235352.1723243-3-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607235352.1723243-1-andrii@kernel.org>
References: <20230607235352.1723243-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: -B4u8nnsE0EAJHkKN_s-YsZcy36jTX9t
X-Proofpoint-GUID: -B4u8nnsE0EAJHkKN_s-YsZcy36jTX9t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_12,2023-06-07_01,2023-05-22_02
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Add low-level wrapper API for BPF_TOKEN_CREATE command in bpf() syscall.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf.c      | 18 ++++++++++++++++++
 tools/lib/bpf/bpf.h      | 11 +++++++++++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 30 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index ed86b37d8024..38be66719485 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -1201,3 +1201,21 @@ int bpf_prog_bind_map(int prog_fd, int map_fd,
 	ret = sys_bpf(BPF_PROG_BIND_MAP, &attr, attr_sz);
 	return libbpf_err_errno(ret);
 }
+
+int bpf_token_create(struct bpf_token_create_opts *opts)
+{
+	const size_t attr_sz = offsetofend(union bpf_attr, token_create);
+	union bpf_attr attr;
+	int ret;
+
+	if (!OPTS_VALID(opts, bpf_token_create_opts))
+		return libbpf_err(-EINVAL);
+
+	memset(&attr, 0, attr_sz);
+	attr.token_create.flags = OPTS_GET(opts, flags, 0);
+	attr.token_create.token_fd = OPTS_GET(opts, token_fd, 0);
+	attr.token_create.allowed_cmds = OPTS_GET(opts, allowed_cmds, 0);
+
+	ret = sys_bpf_fd(BPF_TOKEN_CREATE, &attr, attr_sz);
+	return libbpf_err_errno(ret);
+}
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 9aa0ee473754..f2b8041ca27a 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -551,6 +551,17 @@ struct bpf_test_run_opts {
 LIBBPF_API int bpf_prog_test_run_opts(int prog_fd,
 				      struct bpf_test_run_opts *opts);
 
+struct bpf_token_create_opts {
+	size_t sz; /* size of this struct for forward/backward compatibility */
+	__u32 flags;
+	__u32 token_fd;
+	__u64 allowed_cmds;
+	size_t :0;
+};
+#define bpf_token_create_opts__last_field allowed_cmds
+
+LIBBPF_API int bpf_token_create(struct bpf_token_create_opts *opts);
+
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 7521a2fb7626..62cbe4775081 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -395,4 +395,5 @@ LIBBPF_1.2.0 {
 LIBBPF_1.3.0 {
 	global:
 		bpf_obj_pin_opts;
+		bpf_token_create;
 } LIBBPF_1.2.0;
-- 
2.34.1

