Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DEACDB474
	for <linux-security-module@archiver.kernel.org>; Thu, 12 Oct 2023 22:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443020AbjJLWck convert rfc822-to-8bit (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 12 Oct 2023 18:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443024AbjJLWci (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 12 Oct 2023 18:32:38 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1040D6
        for <linux-security-module@vger.kernel.org>; Thu, 12 Oct 2023 15:32:36 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39CLuoPM014798
        for <linux-security-module@vger.kernel.org>; Thu, 12 Oct 2023 15:32:36 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3tppq2a9pk-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Thu, 12 Oct 2023 15:32:35 -0700
Received: from twshared40933.03.prn6.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 12 Oct 2023 15:32:31 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 81C3F39A3A767; Thu, 12 Oct 2023 15:29:43 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <brauner@kernel.org>, <lennart@poettering.net>,
        <kernel-team@meta.com>, <sargun@sargun.me>
Subject: [PATCH v7 bpf-next 18/18] bpf,selinux: allocate bpf_security_struct per BPF token
Date:   Thu, 12 Oct 2023 15:28:10 -0700
Message-ID: <20231012222810.4120312-19-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012222810.4120312-1-andrii@kernel.org>
References: <20231012222810.4120312-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Zbgo-qZwEqmczgMZs838aCw9_sib4xHq
X-Proofpoint-ORIG-GUID: Zbgo-qZwEqmczgMZs838aCw9_sib4xHq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_14,2023-10-12_01,2023-05-22_02
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

