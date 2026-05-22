Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12197310651;
	Fri, 22 May 2026 02:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779417163; cv=none; b=lfEf0a+Ei5JeoVLWxPPIPYAbu2oga13msPryq497AyTI+ttz0GyIROVYDi78hvhX98xbSmlhdD7xbwbnTaT4MRoDzclJzkFdZ4YJWYHNraexTM/LOeXYVifrXlnZAn7/WJVOQjkEgPi/Baz1MlVkQ1KCiws11PIEMyqGv7pL9QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779417163; c=relaxed/simple;
	bh=/1S6kTTpiq+atZi7BmLhEq2RSmMbRmRP0cRoe7WbVfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TElHvkRLBT89IG4/QCzwLLOFWh1Yk+ICwEtLfyRUDRcSdnwh44v9xxuXpLD8kwvzSVggQPIM4C9OG5Js86sgXyocoRwsd3i6WR3xZi/itFMCQjZiAw9FV/MiNywYpG1WdMXIFMEv1a0ImlsIaec8wi4NKOtSkqKEs84B+NFSe44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMdsIn8I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMdsIn8I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48D0F1F000E9;
	Fri, 22 May 2026 02:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779417161;
	bh=ttamW1ksl8Wv9KlaHuSdcczarxSX0ini4s/BXsHg/QE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZMdsIn8IXarpjRH/0iruC5PxJ/7VOYm8iwZpOnzp6qSXsRoGVbqWS1AxtmpEAKzs/
	 pgFKvaWxBZ0RnlE5iGcxmJ73up5sDzzURb99ezciyi0L/w4qgsCDi1MazC8dJgkfjJ
	 jKRu74DSYVABmtyaC6YFYuoaxNM/BP2O2i4r+XOxGTUzLZHq60FlrQpGWHRz/5+NAo
	 ypPm3cDTgYdZIwe1OFrNBJ1lSWKDWw8I9Ft0RIQRaLlcB0eeahAS4d/xosKxRmdyQs
	 B3sV7Jwn9gzHqvYqLLM2O6Iu/6uQJx1va0CvoBSN8+xKOXSU46prNvDyZu8rSHuxQt
	 +9QPS3a9na79w==
From: KP Singh <kpsingh@kernel.org>
To: linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	James.Bottomley@HansenPartnership.com,
	paul@paul-moore.com,
	KP Singh <kpsingh@kernel.org>
Subject: [PATCH bpf-next 02/13] bpf: include prog BTF in the signed loader signature scope
Date: Fri, 22 May 2026 04:32:22 +0200
Message-ID: <20260522023234.3778588-3-kpsingh@kernel.org>
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

bpf_prog_verify_signature hashes only prog->insnsi, so FUNC names
in prog BTF are not covered by the signature. Since we need to
support kfuncs for loader programs with prog BTF information, the
signature needs to cover BTF so that it can be trusted.

When attr->prog_btf_fd is set, build the verify dynptr over
insns || raw_btf so the signature covers both. Fall back to insns-only
otherwise so existing signed lskels keep loading. Hoist the
prog_btf_fd resolution into bpf_prog_load so the BTF is available
before signature verification.

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 include/linux/btf.h    |  1 +
 kernel/bpf/btf.c       |  8 +++++++
 kernel/bpf/check_btf.c | 18 +++-------------
 kernel/bpf/syscall.c   | 49 +++++++++++++++++++++++++++++++++++++-----
 4 files changed, 56 insertions(+), 20 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 48108471c5b1..ab1fe7c8df20 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -216,6 +216,7 @@ int btf_type_snprintf_show(const struct btf *btf, u32 type_id, void *obj,
 int btf_get_fd_by_id(u32 id);
 u32 btf_obj_id(const struct btf *btf);
 bool btf_is_kernel(const struct btf *btf);
+const void *btf_get_raw_data(const struct btf *btf, u32 *data_size);
 bool btf_is_module(const struct btf *btf);
 bool btf_is_vmlinux(const struct btf *btf);
 struct module *btf_try_get_module(const struct btf *btf);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index a62d78581207..6f1d9b3ba6a3 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8322,11 +8322,19 @@ u32 btf_obj_id(const struct btf *btf)
 	return READ_ONCE(btf->id);
 }
 
+const void *btf_get_raw_data(const struct btf *btf, u32 *data_size)
+{
+	if (data_size)
+		*data_size = btf->data_size;
+	return btf->data;
+}
+
 bool btf_is_kernel(const struct btf *btf)
 {
 	return btf->kernel_btf;
 }
 
+
 bool btf_is_module(const struct btf *btf)
 {
 	return btf->kernel_btf && strcmp(btf->name, "vmlinux") != 0;
diff --git a/kernel/bpf/check_btf.c b/kernel/bpf/check_btf.c
index 93bebe6fe12e..c52cc859abac 100644
--- a/kernel/bpf/check_btf.c
+++ b/kernel/bpf/check_btf.c
@@ -411,28 +411,16 @@ int bpf_check_btf_info_early(struct bpf_verifier_env *env,
 			     const union bpf_attr *attr,
 			     bpfptr_t uattr)
 {
-	struct btf *btf;
-	int err;
-
 	if (!attr->func_info_cnt && !attr->line_info_cnt) {
 		if (check_abnormal_return(env))
 			return -EINVAL;
 		return 0;
 	}
 
-	btf = btf_get_by_fd(attr->prog_btf_fd);
-	if (IS_ERR(btf))
-		return PTR_ERR(btf);
-	if (btf_is_kernel(btf)) {
-		btf_put(btf);
-		return -EACCES;
-	}
-	env->prog->aux->btf = btf;
+	if (env->prog->aux->btf)
+		return check_btf_func_early(env, attr, uattr);
 
-	err = check_btf_func_early(env, attr, uattr);
-	if (err)
-		return err;
-	return 0;
+	return -EINVAL;
 }
 
 int bpf_check_btf_info(struct bpf_verifier_env *env,
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 51fe8d77bb39..6d1db5eaad3c 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2816,9 +2816,11 @@ static int bpf_prog_verify_signature(struct bpf_prog *prog, union bpf_attr *attr
 				     bool is_kernel)
 {
 	bpfptr_t usig = make_bpfptr(attr->signature, is_kernel);
-	struct bpf_dynptr_kern sig_ptr, insns_ptr;
+	struct bpf_dynptr_kern sig_ptr, data_ptr;
 	struct bpf_key *key = NULL;
-	void *sig;
+	u32 insns_sz, btf_sz = 0;
+	const void *btf_data = NULL;
+	void *sig, *data = NULL;
 	int err = 0;
 
 	/*
@@ -2842,14 +2844,34 @@ static int bpf_prog_verify_signature(struct bpf_prog *prog, union bpf_attr *attr
 		return PTR_ERR(sig);
 	}
 
+	insns_sz = prog->len * sizeof(struct bpf_insn);
+
+	if (prog->aux->btf)
+		btf_data = btf_get_raw_data(prog->aux->btf, &btf_sz);
+
+	if (bpf_dynptr_check_size(insns_sz + btf_sz)) {
+		err = -E2BIG;
+		goto out;
+	}
+	data = kvmalloc(insns_sz + btf_sz, GFP_KERNEL);
+	if (!data) {
+		err = -ENOMEM;
+		goto out;
+	}
+	memcpy(data, prog->insnsi, insns_sz);
+	if (btf_sz)
+		memcpy(data + insns_sz, btf_data, btf_sz);
+
+	bpf_dynptr_init(&data_ptr, data, BPF_DYNPTR_TYPE_LOCAL, 0,
+			insns_sz + btf_sz);
 	bpf_dynptr_init(&sig_ptr, sig, BPF_DYNPTR_TYPE_LOCAL, 0,
 			attr->signature_size);
-	bpf_dynptr_init(&insns_ptr, prog->insnsi, BPF_DYNPTR_TYPE_LOCAL, 0,
-			prog->len * sizeof(struct bpf_insn));
 
-	err = bpf_verify_pkcs7_signature((struct bpf_dynptr *)&insns_ptr,
+	err = bpf_verify_pkcs7_signature((struct bpf_dynptr *)&data_ptr,
 					 (struct bpf_dynptr *)&sig_ptr, key);
 
+out:
+	kvfree(data);
 	bpf_key_put(key);
 	kvfree(sig);
 	return err;
@@ -3037,6 +3059,21 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	/* eBPF programs must be GPL compatible to use GPL-ed functions */
 	prog->gpl_compatible = license_is_gpl_compatible(license) ? 1 : 0;
 
+	if (attr->prog_btf_fd) {
+		struct btf *btf = btf_get_by_fd(attr->prog_btf_fd);
+
+		if (IS_ERR(btf)) {
+			err = PTR_ERR(btf);
+			goto free_prog;
+		}
+		if (btf_is_kernel(btf)) {
+			btf_put(btf);
+			err = -EACCES;
+			goto free_prog;
+		}
+		prog->aux->btf = btf;
+	}
+
 	if (attr->signature) {
 		err = bpf_prog_verify_signature(prog, attr, uattr.is_kernel);
 		if (err)
@@ -3148,6 +3185,8 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	free_uid(prog->aux->user);
 	if (prog->aux->attach_btf)
 		btf_put(prog->aux->attach_btf);
+	if (prog->aux->btf)
+		btf_put(prog->aux->btf);
 	bpf_prog_free(prog);
 put_token:
 	bpf_token_put(token);
-- 
2.53.0

