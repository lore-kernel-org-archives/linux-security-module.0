Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8E3C4167D
	for <linux-security-module@archiver.kernel.org>; Fri,  3 Nov 2023 19:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjKCTFw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 3 Nov 2023 15:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234492AbjKCTFu (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 3 Nov 2023 15:05:50 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891E5D6A
        for <linux-security-module@vger.kernel.org>; Fri,  3 Nov 2023 12:05:47 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 3A3J2OoD003692
        for <linux-security-module@vger.kernel.org>; Fri, 3 Nov 2023 12:05:46 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3u4twdmq7j-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Fri, 03 Nov 2023 12:05:46 -0700
Received: from twshared32169.15.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 3 Nov 2023 12:05:37 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 7583C3AE383C9; Fri,  3 Nov 2023 12:05:32 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
        <paul@paul-moore.com>, <brauner@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <kernel-team@meta.com>, <sargun@sargun.me>
Subject: [PATCH v9 bpf-next 04/17] bpf: add BPF token support to BPF_MAP_CREATE command
Date:   Fri, 3 Nov 2023 12:05:10 -0700
Message-ID: <20231103190523.6353-5-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103190523.6353-1-andrii@kernel.org>
References: <20231103190523.6353-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: arvVo8wYBhVYOJUZMH41q8f5_VpkhILW
X-Proofpoint-ORIG-GUID: arvVo8wYBhVYOJUZMH41q8f5_VpkhILW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_18,2023-11-02_03,2023-05-22_02
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Allow providing token_fd for BPF_MAP_CREATE command to allow controlled
BPF map creation from unprivileged process through delegated BPF token.

Wire through a set of allowed BPF map types to BPF token, derived from
BPF FS at BPF token creation time. This, in combination with allowed_cmds
allows to create a narrowly-focused BPF token (controlled by privileged
agent) with a restrictive set of BPF maps that application can attempt
to create.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h                           |  2 +
 include/uapi/linux/bpf.h                      |  2 +
 kernel/bpf/inode.c                            |  3 +-
 kernel/bpf/syscall.c                          | 52 ++++++++++++++-----
 kernel/bpf/token.c                            | 16 ++++++
 tools/include/uapi/linux/bpf.h                |  2 +
 .../selftests/bpf/prog_tests/libbpf_probes.c  |  2 +
 .../selftests/bpf/prog_tests/libbpf_str.c     |  3 ++
 8 files changed, 67 insertions(+), 15 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5ab418c78876..0d8d88c1939c 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1581,6 +1581,7 @@ struct bpf_token {
 	atomic64_t refcnt;
 	struct user_namespace *userns;
 	u64 allowed_cmds;
+	u64 allowed_maps;
 };
 
 struct bpf_struct_ops_value;
@@ -2217,6 +2218,7 @@ int bpf_token_create(union bpf_attr *attr);
 struct bpf_token *bpf_token_get_from_fd(u32 ufd);
 
 bool bpf_token_allow_cmd(const struct bpf_token *token, enum bpf_cmd cmd);
+bool bpf_token_allow_map_type(const struct bpf_token *token, enum bpf_map_type type);
 
 int bpf_obj_pin_user(u32 ufd, int path_fd, const char __user *pathname);
 int bpf_obj_get_user(int path_fd, const char __user *pathname, int flags);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index f75f289f1749..0f413e4d4771 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -984,6 +984,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_BLOOM_FILTER,
 	BPF_MAP_TYPE_USER_RINGBUF,
 	BPF_MAP_TYPE_CGRP_STORAGE,
+	__MAX_BPF_MAP_TYPE
 };
 
 /* Note that tracing related programs such as
@@ -1431,6 +1432,7 @@ union bpf_attr {
 		 * to using 5 hash functions).
 		 */
 		__u64	map_extra;
+		__u32	map_token_fd;
 	};
 
 	struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 3418a0edf7b4..9c4e30cd4f2e 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -613,7 +613,8 @@ static int bpf_show_options(struct seq_file *m, struct dentry *root)
 	else if (opts->delegate_cmds)
 		seq_printf(m, ",delegate_cmds=0x%llx", opts->delegate_cmds);
 
-	if (opts->delegate_maps == ~0ULL)
+	mask = (1ULL << __MAX_BPF_MAP_TYPE) - 1;
+	if ((opts->delegate_maps & mask) == mask)
 		seq_printf(m, ",delegate_maps=any");
 	else if (opts->delegate_maps)
 		seq_printf(m, ",delegate_maps=0x%llx", opts->delegate_maps);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0565e46509a6..99085f2a558e 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -984,8 +984,8 @@ int map_check_no_btf(const struct bpf_map *map,
 	return -ENOTSUPP;
 }
 
-static int map_check_btf(struct bpf_map *map, const struct btf *btf,
-			 u32 btf_key_id, u32 btf_value_id)
+static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
+			 const struct btf *btf, u32 btf_key_id, u32 btf_value_id)
 {
 	const struct btf_type *key_type, *value_type;
 	u32 key_size, value_size;
@@ -1013,7 +1013,7 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 	if (!IS_ERR_OR_NULL(map->record)) {
 		int i;
 
-		if (!bpf_capable()) {
+		if (!bpf_token_capable(token, CAP_BPF)) {
 			ret = -EPERM;
 			goto free_map_tab;
 		}
@@ -1101,11 +1101,12 @@ static bool bpf_net_capable(void)
 	return capable(CAP_NET_ADMIN) || capable(CAP_SYS_ADMIN);
 }
 
-#define BPF_MAP_CREATE_LAST_FIELD map_extra
+#define BPF_MAP_CREATE_LAST_FIELD map_token_fd
 /* called via syscall */
 static int map_create(union bpf_attr *attr)
 {
 	const struct bpf_map_ops *ops;
+	struct bpf_token *token = NULL;
 	int numa_node = bpf_map_attr_numa_node(attr);
 	u32 map_type = attr->map_type;
 	struct bpf_map *map;
@@ -1156,14 +1157,32 @@ static int map_create(union bpf_attr *attr)
 	if (!ops->map_mem_usage)
 		return -EINVAL;
 
+	if (attr->map_token_fd) {
+		token = bpf_token_get_from_fd(attr->map_token_fd);
+		if (IS_ERR(token))
+			return PTR_ERR(token);
+
+		/* if current token doesn't grant map creation permissions,
+		 * then we can't use this token, so ignore it and rely on
+		 * system-wide capabilities checks
+		 */
+		if (!bpf_token_allow_cmd(token, BPF_MAP_CREATE) ||
+		    !bpf_token_allow_map_type(token, attr->map_type)) {
+			bpf_token_put(token);
+			token = NULL;
+		}
+	}
+
+	err = -EPERM;
+
 	/* Intent here is for unprivileged_bpf_disabled to block BPF map
 	 * creation for unprivileged users; other actions depend
 	 * on fd availability and access to bpffs, so are dependent on
 	 * object creation success. Even with unprivileged BPF disabled,
 	 * capability checks are still carried out.
 	 */
-	if (sysctl_unprivileged_bpf_disabled && !bpf_capable())
-		return -EPERM;
+	if (sysctl_unprivileged_bpf_disabled && !bpf_token_capable(token, CAP_BPF))
+		goto put_token;
 
 	/* check privileged map type permissions */
 	switch (map_type) {
@@ -1196,25 +1215,27 @@ static int map_create(union bpf_attr *attr)
 	case BPF_MAP_TYPE_LRU_PERCPU_HASH:
 	case BPF_MAP_TYPE_STRUCT_OPS:
 	case BPF_MAP_TYPE_CPUMAP:
-		if (!bpf_capable())
-			return -EPERM;
+		if (!bpf_token_capable(token, CAP_BPF))
+			goto put_token;
 		break;
 	case BPF_MAP_TYPE_SOCKMAP:
 	case BPF_MAP_TYPE_SOCKHASH:
 	case BPF_MAP_TYPE_DEVMAP:
 	case BPF_MAP_TYPE_DEVMAP_HASH:
 	case BPF_MAP_TYPE_XSKMAP:
-		if (!bpf_net_capable())
-			return -EPERM;
+		if (!bpf_token_capable(token, CAP_NET_ADMIN))
+			goto put_token;
 		break;
 	default:
 		WARN(1, "unsupported map type %d", map_type);
-		return -EPERM;
+		goto put_token;
 	}
 
 	map = ops->map_alloc(attr);
-	if (IS_ERR(map))
-		return PTR_ERR(map);
+	if (IS_ERR(map)) {
+		err = PTR_ERR(map);
+		goto put_token;
+	}
 	map->ops = ops;
 	map->map_type = map_type;
 
@@ -1251,7 +1272,7 @@ static int map_create(union bpf_attr *attr)
 		map->btf = btf;
 
 		if (attr->btf_value_type_id) {
-			err = map_check_btf(map, btf, attr->btf_key_type_id,
+			err = map_check_btf(map, token, btf, attr->btf_key_type_id,
 					    attr->btf_value_type_id);
 			if (err)
 				goto free_map;
@@ -1272,6 +1293,7 @@ static int map_create(union bpf_attr *attr)
 		goto free_map_sec;
 
 	bpf_map_save_memcg(map);
+	bpf_token_put(token);
 
 	err = bpf_map_new_fd(map, f_flags);
 	if (err < 0) {
@@ -1292,6 +1314,8 @@ static int map_create(union bpf_attr *attr)
 free_map:
 	btf_put(map->btf);
 	map->ops->map_free(map);
+put_token:
+	bpf_token_put(token);
 	return err;
 }
 
diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
index 32fa395f829b..c6eb25fcc308 100644
--- a/kernel/bpf/token.c
+++ b/kernel/bpf/token.c
@@ -70,6 +70,13 @@ static void bpf_token_show_fdinfo(struct seq_file *m, struct file *filp)
 		seq_printf(m, "allowed_cmds:\tany\n");
 	else
 		seq_printf(m, "allowed_cmds:\t0x%llx\n", token->allowed_cmds);
+
+	BUILD_BUG_ON(__MAX_BPF_MAP_TYPE >= 64);
+	mask = (1ULL << __MAX_BPF_MAP_TYPE) - 1;
+	if ((token->allowed_maps & mask) == mask)
+		seq_printf(m, "allowed_maps:\tany\n");
+	else
+		seq_printf(m, "allowed_maps:\t0x%llx\n", token->allowed_maps);
 }
 
 #define BPF_TOKEN_INODE_NAME "bpf-token"
@@ -147,6 +154,7 @@ int bpf_token_create(union bpf_attr *attr)
 
 	mnt_opts = path.dentry->d_sb->s_fs_info;
 	token->allowed_cmds = mnt_opts->delegate_cmds;
+	token->allowed_maps = mnt_opts->delegate_maps;
 
 	fd = get_unused_fd_flags(O_CLOEXEC);
 	if (fd < 0) {
@@ -195,3 +203,11 @@ bool bpf_token_allow_cmd(const struct bpf_token *token, enum bpf_cmd cmd)
 
 	return token->allowed_cmds & (1ULL << cmd);
 }
+
+bool bpf_token_allow_map_type(const struct bpf_token *token, enum bpf_map_type type)
+{
+	if (!token || type >= __MAX_BPF_MAP_TYPE)
+		return false;
+
+	return token->allowed_maps & (1ULL << type);
+}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index f75f289f1749..0f413e4d4771 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -984,6 +984,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_BLOOM_FILTER,
 	BPF_MAP_TYPE_USER_RINGBUF,
 	BPF_MAP_TYPE_CGRP_STORAGE,
+	__MAX_BPF_MAP_TYPE
 };
 
 /* Note that tracing related programs such as
@@ -1431,6 +1432,7 @@ union bpf_attr {
 		 * to using 5 hash functions).
 		 */
 		__u64	map_extra;
+		__u32	map_token_fd;
 	};
 
 	struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
diff --git a/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c b/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
index 9f766ddd946a..573249a2814d 100644
--- a/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
+++ b/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
@@ -68,6 +68,8 @@ void test_libbpf_probe_map_types(void)
 
 		if (map_type == BPF_MAP_TYPE_UNSPEC)
 			continue;
+		if (strcmp(map_type_name, "__MAX_BPF_MAP_TYPE") == 0)
+			continue;
 
 		if (!test__start_subtest(map_type_name))
 			continue;
diff --git a/tools/testing/selftests/bpf/prog_tests/libbpf_str.c b/tools/testing/selftests/bpf/prog_tests/libbpf_str.c
index c440ea3311ed..2a0633f43c73 100644
--- a/tools/testing/selftests/bpf/prog_tests/libbpf_str.c
+++ b/tools/testing/selftests/bpf/prog_tests/libbpf_str.c
@@ -132,6 +132,9 @@ static void test_libbpf_bpf_map_type_str(void)
 		const char *map_type_str;
 		char buf[256];
 
+		if (map_type == __MAX_BPF_MAP_TYPE)
+			continue;
+
 		map_type_name = btf__str_by_offset(btf, e->name_off);
 		map_type_str = libbpf_bpf_map_type_str(map_type);
 		ASSERT_OK_PTR(map_type_str, map_type_name);
-- 
2.34.1

