Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B83CDB483
	for <linux-security-module@archiver.kernel.org>; Thu, 12 Oct 2023 22:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443025AbjJLWca convert rfc822-to-8bit (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 12 Oct 2023 18:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443024AbjJLWc2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 12 Oct 2023 18:32:28 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D008CA
        for <linux-security-module@vger.kernel.org>; Thu, 12 Oct 2023 15:32:27 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39CLtvl5019886
        for <linux-security-module@vger.kernel.org>; Thu, 12 Oct 2023 15:32:27 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3tp16ck25p-19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Thu, 12 Oct 2023 15:32:27 -0700
Received: from twshared11278.41.prn1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 12 Oct 2023 15:32:24 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 971AF39A3A5CF; Thu, 12 Oct 2023 15:29:29 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <brauner@kernel.org>, <lennart@poettering.net>,
        <kernel-team@meta.com>, <sargun@sargun.me>
Subject: [PATCH v7 bpf-next 13/18] selftests/bpf: fix test_maps' use of bpf_map_create_opts
Date:   Thu, 12 Oct 2023 15:28:05 -0700
Message-ID: <20231012222810.4120312-14-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012222810.4120312-1-andrii@kernel.org>
References: <20231012222810.4120312-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: _ij35dci08QPtB6Lug3x4b6hZLOj4KKH
X-Proofpoint-ORIG-GUID: _ij35dci08QPtB6Lug3x4b6hZLOj4KKH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_14,2023-10-12_01,2023-05-22_02
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

