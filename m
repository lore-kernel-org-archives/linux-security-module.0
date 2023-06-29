Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5669EB64D9
	for <linux-security-module@archiver.kernel.org>; Thu, 29 Jun 2023 05:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjF2FVE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 29 Jun 2023 01:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjF2FVC (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 29 Jun 2023 01:21:02 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B730198E
        for <linux-security-module@vger.kernel.org>; Wed, 28 Jun 2023 22:21:01 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35T0k36x022899
        for <linux-security-module@vger.kernel.org>; Wed, 28 Jun 2023 22:21:01 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rgypq1q8c-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Wed, 28 Jun 2023 22:21:00 -0700
Received: from twshared52565.14.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 28 Jun 2023 22:20:59 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id D919D33AFB5D8; Wed, 28 Jun 2023 22:18:48 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>
CC:     <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <brauner@kernel.org>, <lennart@poettering.net>,
        <cyphar@cyphar.com>, <luto@kernel.org>, <kernel-team@meta.com>,
        <sargun@sargun.me>
Subject: [PATCH RESEND v3 bpf-next 08/14] libbpf: add BPF token support to bpf_btf_load() API
Date:   Wed, 28 Jun 2023 22:18:26 -0700
Message-ID: <20230629051832.897119-9-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230629051832.897119-1-andrii@kernel.org>
References: <20230629051832.897119-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: dIxUwrJE6H5xDiTDI1NsDBqG9dl2u3yV
X-Proofpoint-ORIG-GUID: dIxUwrJE6H5xDiTDI1NsDBqG9dl2u3yV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_14,2023-06-27_01,2023-05-22_02
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Allow user to specify token_fd for bpf_btf_load() API that wraps
kernel's BPF_BTF_LOAD command. This allows loading BTF from unprivileged
process as long as it has BPF token allowing BPF_BTF_LOAD command, which
can be created and delegated by privileged process.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf.c | 4 +++-
 tools/lib/bpf/bpf.h | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 882297b1e136..6fb915069be7 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -1098,7 +1098,7 @@ int bpf_raw_tracepoint_open(const char *name, int prog_fd)
 
 int bpf_btf_load(const void *btf_data, size_t btf_size, struct bpf_btf_load_opts *opts)
 {
-	const size_t attr_sz = offsetofend(union bpf_attr, btf_log_true_size);
+	const size_t attr_sz = offsetofend(union bpf_attr, btf_token_fd);
 	union bpf_attr attr;
 	char *log_buf;
 	size_t log_size;
@@ -1123,6 +1123,8 @@ int bpf_btf_load(const void *btf_data, size_t btf_size, struct bpf_btf_load_opts
 
 	attr.btf = ptr_to_u64(btf_data);
 	attr.btf_size = btf_size;
+	attr.btf_token_fd = OPTS_GET(opts, token_fd, 0);
+
 	/* log_level == 0 and log_buf != NULL means "try loading without
 	 * log_buf, but retry with log_buf and log_level=1 on error", which is
 	 * consistent across low-level and high-level BTF and program loading
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index cd3fb5ce6fe2..dc7c4af21ad9 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -132,9 +132,10 @@ struct bpf_btf_load_opts {
 	 * If kernel doesn't support this feature, log_size is left unchanged.
 	 */
 	__u32 log_true_size;
+	__u32 token_fd;
 	size_t :0;
 };
-#define bpf_btf_load_opts__last_field log_true_size
+#define bpf_btf_load_opts__last_field token_fd
 
 LIBBPF_API int bpf_btf_load(const void *btf_data, size_t btf_size,
 			    struct bpf_btf_load_opts *opts);
-- 
2.34.1

