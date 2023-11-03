Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9557C41535
	for <linux-security-module@archiver.kernel.org>; Fri,  3 Nov 2023 19:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbjKCTGK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 3 Nov 2023 15:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234483AbjKCTFy (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 3 Nov 2023 15:05:54 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0938D5A
        for <linux-security-module@vger.kernel.org>; Fri,  3 Nov 2023 12:05:51 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 3A3J2aqo003801
        for <linux-security-module@vger.kernel.org>; Fri, 3 Nov 2023 12:05:51 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3u4twdmq3a-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Fri, 03 Nov 2023 12:05:50 -0700
Received: from twshared11278.41.prn1.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 3 Nov 2023 12:05:43 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 85F823AE383D0; Fri,  3 Nov 2023 12:05:34 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
        <paul@paul-moore.com>, <brauner@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <kernel-team@meta.com>, <sargun@sargun.me>
Subject: [PATCH v9 bpf-next 05/17] bpf: add BPF token support to BPF_BTF_LOAD command
Date:   Fri, 3 Nov 2023 12:05:11 -0700
Message-ID: <20231103190523.6353-6-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103190523.6353-1-andrii@kernel.org>
References: <20231103190523.6353-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 3OCQ6H1LIAy1ZubmuUIV-nKVM5zF6rCa
X-Proofpoint-ORIG-GUID: 3OCQ6H1LIAy1ZubmuUIV-nKVM5zF6rCa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_18,2023-11-02_03,2023-05-22_02
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Accept BPF token FD in BPF_BTF_LOAD command to allow BTF data loading
through delegated BPF token. BTF loading is a pretty straightforward
operation, so as long as BPF token is created with allow_cmds granting
BPF_BTF_LOAD command, kernel proceeds to parsing BTF data and creating
BTF object.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/uapi/linux/bpf.h       |  1 +
 kernel/bpf/syscall.c           | 20 ++++++++++++++++++--
 tools/include/uapi/linux/bpf.h |  1 +
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 0f413e4d4771..022c2ef4d0eb 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1614,6 +1614,7 @@ union bpf_attr {
 		 * truncated), or smaller (if log buffer wasn't filled completely).
 		 */
 		__u32		btf_log_true_size;
+		__u32		btf_token_fd;
 	};
 
 	struct {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 99085f2a558e..6158ee3f61bb 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4751,15 +4751,31 @@ static int bpf_obj_get_info_by_fd(const union bpf_attr *attr,
 	return err;
 }
 
-#define BPF_BTF_LOAD_LAST_FIELD btf_log_true_size
+#define BPF_BTF_LOAD_LAST_FIELD btf_token_fd
 
 static int bpf_btf_load(const union bpf_attr *attr, bpfptr_t uattr, __u32 uattr_size)
 {
+	struct bpf_token *token = NULL;
+
 	if (CHECK_ATTR(BPF_BTF_LOAD))
 		return -EINVAL;
 
-	if (!bpf_capable())
+	if (attr->btf_token_fd) {
+		token = bpf_token_get_from_fd(attr->btf_token_fd);
+		if (IS_ERR(token))
+			return PTR_ERR(token);
+		if (!bpf_token_allow_cmd(token, BPF_BTF_LOAD)) {
+			bpf_token_put(token);
+			token = NULL;
+		}
+	}
+
+	if (!bpf_token_capable(token, CAP_BPF)) {
+		bpf_token_put(token);
 		return -EPERM;
+	}
+
+	bpf_token_put(token);
 
 	return btf_new_fd(attr, uattr, uattr_size);
 }
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 0f413e4d4771..022c2ef4d0eb 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1614,6 +1614,7 @@ union bpf_attr {
 		 * truncated), or smaller (if log buffer wasn't filled completely).
 		 */
 		__u32		btf_log_true_size;
+		__u32		btf_token_fd;
 	};
 
 	struct {
-- 
2.34.1

