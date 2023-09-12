Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C07EE3F38
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Sep 2023 21:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237428AbjILVaR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 12 Sep 2023 17:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237722AbjILVaG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 12 Sep 2023 17:30:06 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31FF1721
        for <linux-security-module@vger.kernel.org>; Tue, 12 Sep 2023 14:29:40 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 38CKjRUF024950
        for <linux-security-module@vger.kernel.org>; Tue, 12 Sep 2023 14:29:40 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3t2ya38db9-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Tue, 12 Sep 2023 14:29:39 -0700
Received: from twshared34392.14.frc2.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 12 Sep 2023 14:29:30 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 55EB837F406C2; Tue, 12 Sep 2023 14:29:16 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <brauner@kernel.org>, <lennart@poettering.net>,
        <kernel-team@meta.com>, <sargun@sargun.me>
Subject: [PATCH v4 bpf-next 04/12] bpf: add BPF token support to BPF_BTF_LOAD command
Date:   Tue, 12 Sep 2023 14:28:58 -0700
Message-ID: <20230912212906.3975866-5-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912212906.3975866-1-andrii@kernel.org>
References: <20230912212906.3975866-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: lJT5yFXpYhibSKJSX39a9eemqJs0CZQT
X-Proofpoint-GUID: lJT5yFXpYhibSKJSX39a9eemqJs0CZQT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_20,2023-09-05_01,2023-05-22_02
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
index 9c399454712e..1527d861f408 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1606,6 +1606,7 @@ union bpf_attr {
 		 * truncated), or smaller (if log buffer wasn't filled completely).
 		 */
 		__u32		btf_log_true_size;
+		__u32		btf_token_fd;
 	};
 
 	struct {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index fbd8c82e5ec6..0d394b471ee0 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4714,15 +4714,31 @@ static int bpf_obj_get_info_by_fd(const union bpf_attr *attr,
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
index 9c399454712e..1527d861f408 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1606,6 +1606,7 @@ union bpf_attr {
 		 * truncated), or smaller (if log buffer wasn't filled completely).
 		 */
 		__u32		btf_log_true_size;
+		__u32		btf_token_fd;
 	};
 
 	struct {
-- 
2.34.1

