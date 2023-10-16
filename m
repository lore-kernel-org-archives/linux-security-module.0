Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6484C41513
	for <linux-security-module@archiver.kernel.org>; Mon, 16 Oct 2023 18:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234042AbjJPSDX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 16 Oct 2023 14:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234049AbjJPSDV (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 16 Oct 2023 14:03:21 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F669FA
        for <linux-security-module@vger.kernel.org>; Mon, 16 Oct 2023 11:03:05 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39GFe0J2003017
        for <linux-security-module@vger.kernel.org>; Mon, 16 Oct 2023 11:03:05 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ts80ph7j6-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Mon, 16 Oct 2023 11:03:05 -0700
Received: from twshared32169.15.frc2.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 16 Oct 2023 11:02:53 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 1800139D9C30F; Mon, 16 Oct 2023 11:02:48 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <brauner@kernel.org>, <lennart@poettering.net>,
        <kernel-team@meta.com>, <sargun@sargun.me>
Subject: [PATCH v8 bpf-next 13/18] selftests/bpf: fix test_maps' use of bpf_map_create_opts
Date:   Mon, 16 Oct 2023 11:02:15 -0700
Message-ID: <20231016180220.3866105-14-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016180220.3866105-1-andrii@kernel.org>
References: <20231016180220.3866105-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: E4Pxca1acXfJXhF3AeL-Euhj-v0B7Z29
X-Proofpoint-ORIG-GUID: E4Pxca1acXfJXhF3AeL-Euhj-v0B7Z29
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_10,2023-10-12_01,2023-05-22_02
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Use LIBBPF_OPTS() macro to properly initialize bpf_map_create_opts in
test_maps' tests.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../bpf/map_tests/map_percpu_stats.c          | 20 +++++--------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/bpf/map_tests/map_percpu_stats.c b/tools/testing/selftests/bpf/map_tests/map_percpu_stats.c
index 1a9eeefda9a8..8bf497a9843e 100644
--- a/tools/testing/selftests/bpf/map_tests/map_percpu_stats.c
+++ b/tools/testing/selftests/bpf/map_tests/map_percpu_stats.c
@@ -326,20 +326,14 @@ static int map_create(__u32 type, const char *name, struct bpf_map_create_opts *
 
 static int create_hash(void)
 {
-	struct bpf_map_create_opts map_opts = {
-		.sz = sizeof(map_opts),
-		.map_flags = BPF_F_NO_PREALLOC,
-	};
+	LIBBPF_OPTS(bpf_map_create_opts, map_opts, .map_flags = BPF_F_NO_PREALLOC);
 
 	return map_create(BPF_MAP_TYPE_HASH, "hash", &map_opts);
 }
 
 static int create_percpu_hash(void)
 {
-	struct bpf_map_create_opts map_opts = {
-		.sz = sizeof(map_opts),
-		.map_flags = BPF_F_NO_PREALLOC,
-	};
+	LIBBPF_OPTS(bpf_map_create_opts, map_opts, .map_flags = BPF_F_NO_PREALLOC);
 
 	return map_create(BPF_MAP_TYPE_PERCPU_HASH, "percpu_hash", &map_opts);
 }
@@ -356,21 +350,17 @@ static int create_percpu_hash_prealloc(void)
 
 static int create_lru_hash(__u32 type, __u32 map_flags)
 {
-	struct bpf_map_create_opts map_opts = {
-		.sz = sizeof(map_opts),
-		.map_flags = map_flags,
-	};
+	LIBBPF_OPTS(bpf_map_create_opts, map_opts, .map_flags = map_flags);
 
 	return map_create(type, "lru_hash", &map_opts);
 }
 
 static int create_hash_of_maps(void)
 {
-	struct bpf_map_create_opts map_opts = {
-		.sz = sizeof(map_opts),
+	LIBBPF_OPTS(bpf_map_create_opts, map_opts,
 		.map_flags = BPF_F_NO_PREALLOC,
 		.inner_map_fd = create_small_hash(),
-	};
+	);
 	int ret;
 
 	ret = map_create_opts(BPF_MAP_TYPE_HASH_OF_MAPS, "hash_of_maps",
-- 
2.34.1

