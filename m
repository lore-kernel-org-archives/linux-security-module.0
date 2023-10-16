Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2CCCDB484
	for <linux-security-module@archiver.kernel.org>; Mon, 16 Oct 2023 18:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbjJPSD0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 16 Oct 2023 14:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234124AbjJPSDW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 16 Oct 2023 14:03:22 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C33910D
        for <linux-security-module@vger.kernel.org>; Mon, 16 Oct 2023 11:03:14 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39GFUrNf016389
        for <linux-security-module@vger.kernel.org>; Mon, 16 Oct 2023 11:03:13 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ts7vhs9d3-18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Mon, 16 Oct 2023 11:03:13 -0700
Received: from twshared15247.17.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 16 Oct 2023 11:03:04 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 6BBB939D9C372; Mon, 16 Oct 2023 11:02:59 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <brauner@kernel.org>, <lennart@poettering.net>,
        <kernel-team@meta.com>, <sargun@sargun.me>
Subject: [PATCH v8 bpf-next 18/18] bpf,selinux: allocate bpf_security_struct per BPF token
Date:   Mon, 16 Oct 2023 11:02:20 -0700
Message-ID: <20231016180220.3866105-19-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016180220.3866105-1-andrii@kernel.org>
References: <20231016180220.3866105-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: dbD-eOWKobge0_CFLQ_tcs5DBT5C5OoU
X-Proofpoint-ORIG-GUID: dbD-eOWKobge0_CFLQ_tcs5DBT5C5OoU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_10,2023-10-12_01,2023-05-22_02
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Utilize newly added bpf_token_create/bpf_token_free LSM hooks to
allocate struct bpf_security_struct for each BPF token object in
SELinux. This just follows similar pattern for BPF prog and map.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 security/selinux/hooks.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 3d5dea4f1df0..acd84839ae2c 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6828,6 +6828,29 @@ static void selinux_bpf_prog_free(struct bpf_prog *prog)
 	prog->aux->security = NULL;
 	kfree(bpfsec);
 }
+
+static int selinux_bpf_token_create(struct bpf_token *token, union bpf_attr *attr,
+				    struct path *path)
+{
+	struct bpf_security_struct *bpfsec;
+
+	bpfsec = kzalloc(sizeof(*bpfsec), GFP_KERNEL);
+	if (!bpfsec)
+		return -ENOMEM;
+
+	bpfsec->sid = current_sid();
+	token->security = bpfsec;
+
+	return 0;
+}
+
+static void selinux_bpf_token_free(struct bpf_token *token)
+{
+	struct bpf_security_struct *bpfsec = token->security;
+
+	token->security = NULL;
+	kfree(bpfsec);
+}
 #endif
 
 struct lsm_blob_sizes selinux_blob_sizes __ro_after_init = {
@@ -7183,6 +7206,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(bpf_prog, selinux_bpf_prog),
 	LSM_HOOK_INIT(bpf_map_free, selinux_bpf_map_free),
 	LSM_HOOK_INIT(bpf_prog_free, selinux_bpf_prog_free),
+	LSM_HOOK_INIT(bpf_token_free, selinux_bpf_token_free),
 #endif
 
 #ifdef CONFIG_PERF_EVENTS
@@ -7241,6 +7265,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 #ifdef CONFIG_BPF_SYSCALL
 	LSM_HOOK_INIT(bpf_map_create, selinux_bpf_map_create),
 	LSM_HOOK_INIT(bpf_prog_load, selinux_bpf_prog_load),
+	LSM_HOOK_INIT(bpf_token_create, selinux_bpf_token_create),
 #endif
 #ifdef CONFIG_PERF_EVENTS
 	LSM_HOOK_INIT(perf_event_alloc, selinux_perf_event_alloc),
-- 
2.34.1

