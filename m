Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB8FC7EE25
	for <linux-security-module@archiver.kernel.org>; Wed,  7 Jun 2023 23:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbjFGXyZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 7 Jun 2023 19:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233441AbjFGXyY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 7 Jun 2023 19:54:24 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971B5268F
        for <linux-security-module@vger.kernel.org>; Wed,  7 Jun 2023 16:54:19 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357H82Cq004332
        for <linux-security-module@vger.kernel.org>; Wed, 7 Jun 2023 16:54:19 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3r2n4cxjqj-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Wed, 07 Jun 2023 16:54:19 -0700
Received: from twshared16556.03.prn5.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 16:54:17 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id AE69E32857D8A; Wed,  7 Jun 2023 16:54:04 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>
CC:     <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <brauner@kernel.org>, <lennart@poettering.net>,
        <cyphar@cyphar.com>, <luto@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v2 bpf-next 05/18] bpf: inline map creation logic in map_create() function
Date:   Wed, 7 Jun 2023 16:53:39 -0700
Message-ID: <20230607235352.1723243-6-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607235352.1723243-1-andrii@kernel.org>
References: <20230607235352.1723243-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: zpNIHxsVKkZqsGuElHz_kFMDD7qs7OwS
X-Proofpoint-ORIG-GUID: zpNIHxsVKkZqsGuElHz_kFMDD7qs7OwS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_13,2023-06-07_01,2023-05-22_02
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Currently find_and_alloc_map() performs two separate functions: some
argument sanity checking and partial map creation workflow hanling.
Neither of those functions are self-sufficient and are augmented by
further checks and initialization logic in the caller (map_create()
function). So unify all the sanity checks, permission checks, and
creation and initialization logic in one linear piece of code in
map_create() instead. This also make it easier to further enhance
permission checks and keep them located in one place.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/syscall.c | 57 +++++++++++++++++++-------------------------
 1 file changed, 24 insertions(+), 33 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index b7737405e1dd..20b373dce669 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -109,37 +109,6 @@ const struct bpf_map_ops bpf_map_offload_ops = {
 	.map_mem_usage = bpf_map_offload_map_mem_usage,
 };
 
-static struct bpf_map *find_and_alloc_map(union bpf_attr *attr)
-{
-	const struct bpf_map_ops *ops;
-	u32 type = attr->map_type;
-	struct bpf_map *map;
-	int err;
-
-	if (type >= ARRAY_SIZE(bpf_map_types))
-		return ERR_PTR(-EINVAL);
-	type = array_index_nospec(type, ARRAY_SIZE(bpf_map_types));
-	ops = bpf_map_types[type];
-	if (!ops)
-		return ERR_PTR(-EINVAL);
-
-	if (ops->map_alloc_check) {
-		err = ops->map_alloc_check(attr);
-		if (err)
-			return ERR_PTR(err);
-	}
-	if (attr->map_ifindex)
-		ops = &bpf_map_offload_ops;
-	if (!ops->map_mem_usage)
-		return ERR_PTR(-EINVAL);
-	map = ops->map_alloc(attr);
-	if (IS_ERR(map))
-		return map;
-	map->ops = ops;
-	map->map_type = type;
-	return map;
-}
-
 static void bpf_map_write_active_inc(struct bpf_map *map)
 {
 	atomic64_inc(&map->writecnt);
@@ -1127,7 +1096,9 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 /* called via syscall */
 static int map_create(union bpf_attr *attr)
 {
+	const struct bpf_map_ops *ops;
 	int numa_node = bpf_map_attr_numa_node(attr);
+	u32 map_type = attr->map_type;
 	struct bpf_map *map;
 	int f_flags;
 	int err;
@@ -1157,6 +1128,25 @@ static int map_create(union bpf_attr *attr)
 	     !node_online(numa_node)))
 		return -EINVAL;
 
+	/* find map type and init map: hashtable vs rbtree vs bloom vs ... */
+	map_type = attr->map_type;
+	if (map_type >= ARRAY_SIZE(bpf_map_types))
+		return -EINVAL;
+	map_type = array_index_nospec(map_type, ARRAY_SIZE(bpf_map_types));
+	ops = bpf_map_types[map_type];
+	if (!ops)
+		return -EINVAL;
+
+	if (ops->map_alloc_check) {
+		err = ops->map_alloc_check(attr);
+		if (err)
+			return err;
+	}
+	if (attr->map_ifindex)
+		ops = &bpf_map_offload_ops;
+	if (!ops->map_mem_usage)
+		return -EINVAL;
+
 	/* Intent here is for unprivileged_bpf_disabled to block BPF map
 	 * creation for unprivileged users; other actions depend
 	 * on fd availability and access to bpffs, so are dependent on
@@ -1166,10 +1156,11 @@ static int map_create(union bpf_attr *attr)
 	if (sysctl_unprivileged_bpf_disabled && !bpf_capable())
 		return -EPERM;
 
-	/* find map type and init map: hashtable vs rbtree vs bloom vs ... */
-	map = find_and_alloc_map(attr);
+	map = ops->map_alloc(attr);
 	if (IS_ERR(map))
 		return PTR_ERR(map);
+	map->ops = ops;
+	map->map_type = map_type;
 
 	err = bpf_obj_name_cpy(map->name, attr->map_name,
 			       sizeof(attr->map_name));
-- 
2.34.1

