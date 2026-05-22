Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C9B30DD1B;
	Fri, 22 May 2026 02:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779417167; cv=none; b=pvofHyDjRXYYH0L8ic2de71YjvrYaVsw9qg5egl9zmgpB+Qd8YB4JlTBWhaF2jgVWqaKbfOC/1/DFRUS7wy7B+mJ31pmck9juUENsRpQ42PJmGhIas1KVSgdijOONxHa945wNF8ysridsrCctfEZJj1WahCmh8VMH3j+roopFtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779417167; c=relaxed/simple;
	bh=oNviT82ouKYd7gcaTWaNCqfptDCyhWuoI+NYYh8+V3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ijL8qy7/aSAu20RJ6UYBhzztNWavsWGmKuNHtJgyFC296VJmo4ils/zUmgnUc2+u9xINHQXAHQ0SZg945IZ505IZYZ26zEt6kRE04hBqDTeK5H6Hx+IZinLrgVooS/237wIokHfDdQ4z5t8a3hVK8wGSOGq9glcMPVB0G2WIdhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kq41XN50; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kq41XN50"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A691F000E9;
	Fri, 22 May 2026 02:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779417165;
	bh=T5mQswb/t8vNLJDpePifc7b+gPathn1p2XoYgnCd9XI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kq41XN503YOzWNRQ3Zy+9aIN0nXovKvoboali2YrwnwvuGHcnweEKidg8Byd7nICE
	 F2DejSnf8nXTf5EiateWx/sj5csH4iKBypYQJySLPWXFtdYCdJEcTOGtz9ttNhlrw6
	 opPMOflzc/Qxrm/gaMt5Z4GNP7tjCyQXOQl0/XC0bBPYenIfdV0WBV6hJwvNdGVBKO
	 JXHLDPZ69I/0r6eEReUvF8dDPFCFtVjfH0693GXPSmOykhHTw1ejevtD9VDFVNMRP5
	 SIgdSDvvv9FKF06o70h5dBUmTqMKydgyrXl5nxNU3IWDgqaGdGDca1DE0Jz9e+L+s0
	 ftrac3wXaCbdg==
From: KP Singh <kpsingh@kernel.org>
To: linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	James.Bottomley@HansenPartnership.com,
	paul@paul-moore.com,
	KP Singh <kpsingh@kernel.org>
Subject: [PATCH bpf-next 04/13] bpf: add bpf_loader_verify_metadata kfunc
Date: Fri, 22 May 2026 04:32:24 +0200
Message-ID: <20260522023234.3778588-5-kpsingh@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522023234.3778588-1-kpsingh@kernel.org>
References: <20260522023234.3778588-1-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A signed loader reaches sig.verdict = BPF_SIG_OK after PKCS#7
verification, but the metadata map content the loader writes has not
been checked against its expected SHA256. The map carries that SHA256
in the signed instruction stream, spilled to the loader's stack at
runtime as four ld_imm64 immediates.

Assert the map is exclusive, compare its frozen content hash against
the spilled SHA256, and promote sig.verdict to
BPF_SIG_METADATA_VERIFIED. The verifier injects the calling
prog->aux as an implicit argument via KF_IMPLICIT_ARGS so the kfunc
can read the prog digest and signature verdict directly.

Drop skel_obj_get_info_by_fd from bpf_load_and_run since the kfunc
computes the map hash itself via map_get_hash; the prior
BPF_OBJ_GET_INFO_BY_FD call to populate map->sha is not
needed.

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 kernel/bpf/helpers.c          | 57 +++++++++++++++++++++++++++++++++++
 tools/bpf/bpftool/sign.c      | 17 ++++++++++-
 tools/lib/bpf/skel_internal.h | 25 ---------------
 3 files changed, 73 insertions(+), 26 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b5314c9fed3c..9afa71fbcac3 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4257,6 +4257,53 @@ __bpf_kfunc int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_p,
 	return -EOPNOTSUPP;
 #endif /* CONFIG_SYSTEM_DATA_VERIFICATION */
 }
+
+/**
+ * bpf_loader_verify_metadata - perform the signed loader's metadata-map check
+ * in a single kernel-side step.
+ *
+ * Asserts the metadata map is exclusive, compares its frozen content hash
+ * against the expected SHA256 carried in the loader's signed instruction
+ * stream, and promotes sig.verdict from BPF_SIG_OK to
+ * BPF_SIG_METADATA_VERIFIED.
+ *
+ * @map:       metadata map bound to this loader via excl_prog_hash at sign time
+ * @hash:      pointer to the expected SHA256, spilled to the loader's BPF stack
+ *             from signed ld_imm64 immediates
+ * @hash__sz:  byte length of @hash (must equal SHA256_DIGEST_SIZE)
+ * @aux__ign:  verifier-supplied prog aux; BPF programs do not set it
+ *
+ * Return: 0 on success, -EPERM if not called from a signed loader,
+ * -EINVAL if the map is not exclusive or the hash buffer is the wrong size,
+ * -EBADMSG if the hash does not match.
+ */
+__bpf_kfunc int bpf_loader_verify_metadata(struct bpf_map *map,
+					   const u64 *hash, u32 hash__sz,
+					   struct bpf_prog_aux *aux__ign)
+{
+	u8 sha[SHA256_DIGEST_SIZE];
+	int err;
+
+	if (!aux__ign || aux__ign->sig.verdict != BPF_SIG_OK)
+		return -EPERM;
+	if (!map->excl_prog_sha || hash__sz != SHA256_DIGEST_SIZE)
+		return -EINVAL;
+	if (memcmp(map->excl_prog_sha, aux__ign->prog->digest, SHA256_DIGEST_SIZE))
+		return -EPERM;
+	if (!READ_ONCE(map->frozen))
+		return -EPERM;
+	if (!map->ops->map_get_hash)
+		return -EINVAL;
+	err = map->ops->map_get_hash(map, SHA256_DIGEST_SIZE, sha);
+	if (err)
+		return err;
+	if (memcmp(sha, hash, SHA256_DIGEST_SIZE))
+		return -EBADMSG;
+
+	aux__ign->sig.verdict = BPF_SIG_METADATA_VERIFIED;
+	return 0;
+}
+
 #endif /* CONFIG_KEYS */
 
 typedef int (*bpf_task_work_callback_t)(struct bpf_map *map, void *key, void *value);
@@ -4764,6 +4811,15 @@ static const struct btf_kfunc_id_set generic_kfunc_set = {
 	.set   = &generic_btf_ids,
 };
 
+BTF_KFUNCS_START(syscall_btf_ids)
+BTF_ID_FLAGS(func, bpf_loader_verify_metadata, KF_SLEEPABLE | KF_IMPLICIT_ARGS)
+BTF_KFUNCS_END(syscall_btf_ids)
+
+static const struct btf_kfunc_id_set syscall_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &syscall_btf_ids,
+};
+
 
 BTF_ID_LIST(generic_dtor_ids)
 BTF_ID(struct, task_struct)
@@ -4893,6 +4949,7 @@ static int __init kfunc_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &generic_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &generic_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SKB, &generic_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &syscall_kfunc_set);
 	ret = ret ?: register_btf_id_dtor_kfuncs(generic_dtors,
 						  ARRAY_SIZE(generic_dtors),
 						  THIS_MODULE);
diff --git a/tools/bpf/bpftool/sign.c b/tools/bpf/bpftool/sign.c
index f9b742f4bb10..13f256546cf0 100644
--- a/tools/bpf/bpftool/sign.c
+++ b/tools/bpf/bpftool/sign.c
@@ -134,10 +134,24 @@ int bpftool_prog_sign(struct bpf_load_and_run_opts *opts)
 	EVP_PKEY *private_key = NULL;
 	CMS_ContentInfo *cms = NULL;
 	long actual_sig_len = 0;
+	void *signed_buf = NULL;
+	size_t signed_sz;
 	X509 *x509 = NULL;
 	int err = 0;
 
-	bd_in = BIO_new_mem_buf(opts->insns, opts->insns_sz);
+	signed_sz = opts->insns_sz + opts->btf_sz;
+	if (opts->btf_sz) {
+		signed_buf = malloc(signed_sz);
+		if (!signed_buf) {
+			err = -ENOMEM;
+			goto cleanup;
+		}
+		memcpy(signed_buf, opts->insns, opts->insns_sz);
+		memcpy(signed_buf + opts->insns_sz, opts->btf, opts->btf_sz);
+		bd_in = BIO_new_mem_buf(signed_buf, signed_sz);
+	} else {
+		bd_in = BIO_new_mem_buf(opts->insns, opts->insns_sz);
+	}
 	if (!bd_in) {
 		err = -ENOMEM;
 		goto cleanup;
@@ -212,6 +226,7 @@ int bpftool_prog_sign(struct bpf_load_and_run_opts *opts)
 	X509_free(x509);
 	EVP_PKEY_free(private_key);
 	BIO_free(bd_in);
+	free(signed_buf);
 	DISPLAY_OSSL_ERR(err < 0);
 	return err;
 }
diff --git a/tools/lib/bpf/skel_internal.h b/tools/lib/bpf/skel_internal.h
index 0b6b1ecedd45..d194f4e23d12 100644
--- a/tools/lib/bpf/skel_internal.h
+++ b/tools/lib/bpf/skel_internal.h
@@ -335,25 +335,6 @@ static inline int skel_link_create(int prog_fd, int target_fd,
 	return skel_sys_bpf(BPF_LINK_CREATE, &attr, attr_sz);
 }
 
-static inline int skel_obj_get_info_by_fd(int fd)
-{
-	const size_t attr_sz = offsetofend(union bpf_attr, info);
-	__u8 sha[SHA256_DIGEST_LENGTH];
-	struct bpf_map_info info;
-	__u32 info_len = sizeof(info);
-	union bpf_attr attr;
-
-	memset(&info, 0, sizeof(info));
-	info.hash = (long) &sha;
-	info.hash_size = SHA256_DIGEST_LENGTH;
-
-	memset(&attr, 0, attr_sz);
-	attr.info.bpf_fd = fd;
-	attr.info.info = (long) &info;
-	attr.info.info_len = info_len;
-	return skel_sys_bpf(BPF_OBJ_GET_INFO_BY_FD, &attr, attr_sz);
-}
-
 static inline int skel_map_freeze(int fd)
 {
 	const size_t attr_sz = offsetofend(union bpf_attr, map_fd);
@@ -400,12 +381,6 @@ static inline int bpf_load_and_run(struct bpf_load_and_run_opts *opts)
 		set_err;
 		goto out;
 	}
-	err = skel_obj_get_info_by_fd(map_fd);
-	if (err < 0) {
-		opts->errstr = "failed to fetch obj info";
-		set_err;
-		goto out;
-	}
 #endif
 
 #ifndef __KERNEL__
-- 
2.53.0

