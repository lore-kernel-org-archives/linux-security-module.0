Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16663603C9;
	Thu,  2 Jul 2026 14:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783002979; cv=none; b=Xf9ZnjwEnWHpLpHE4LN824hAu0tyLAJ1MRnpP6djjPhS3NgXdjuXf/zKoeHr+x0njhXE7v/mLGifFIM0WgDB/132jhfHHY01i+B1tsLi1jNOLSUoaQmnIepTjx9MMAtghtv4utG284ow5vcOwlvoNRY4ZnBnfVhd+pLE0tOVfx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783002979; c=relaxed/simple;
	bh=ddEklEOZCAZZJfOgOX4usK7VhqjTrH0vK7leGBVIzhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UX73sg/88cHEd/iAY9CIho5A6TIAz/hOznmJe0yiAsMAtOLpbB2n1sPreeHnW0rc3DRC0lBGDy/XupZmuAAlvXEGrAjvRNbAsDPA92iFLwL33gVvZM/KMnJfHVJUAkD7BtXe26v71JkL1xslG9pvj0oQR32BZH8fAHAMZsweILs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=XxXEeklf; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="XxXEeklf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=2nU1hvEILx5p/GR6zPLyYKhyfeyXQFmMGYadI9X4Yeg=; b=XxXEeklfoghsURwdnUeKzkQGwQ
	3TpcjYNjry0fFHTO2WNhOVhOme6ritG9t/tdyseNHL6zW3a5Epu6O2sOEuyEocn7nfzcsFLXYNbo6
	8z/QpfV3bmEPzAW3DstTXayi+Lr09gV/Aclhx68t1qDJHBXzLIZXk8m4nqnPdIcsG7Vg519j6Ru9x
	b5ObRGtiiB6ZRMZQj8cdkC7PE7K0jwAIUEI+7r5bYs5ggWv51Ndv84G60v+8zfW12wBYvfkebPRiC
	iLLYwgnxICnYhiMdoDKphBNj04kiH+fHyPflXxEW1aG1YzNm7Dnppnpz3ikP/PO8HGZVVDAqjuTD5
	ig/jwR7w==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wfIWO-0004rm-1V;
	Thu, 02 Jul 2026 16:36:08 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: kpsingh@kernel.org,
	James.Bottomley@hansenpartnership.com,
	paul@paul-moore.com,
	bboscaccy@linux.microsoft.com,
	memxor@gmail.com,
	torvalds@linux-foundation.org,
	a.s.protopopov@gmail.com,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH bpf-next v3 2/6] bpf: Verify signed loader metadata at load time
Date: Thu,  2 Jul 2026 16:36:01 +0200
Message-ID: <20260702143605.252797-3-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702143605.252797-1-daniel@iogearbox.net>
References: <20260702143605.252797-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28048/Thu Jul  2 08:25:04 2026)

A signed gen_loader program carries the programs, maps and relocations it
installs in a metadata array map. The loader instructions are covered by
the PKCS#7 signature, but the metadata map is not: Today the loader
compares the map contents from within BPF against a hash baked into its
(signed) instructions, using the kernel-cached map hash. The kernel itself
never actually attests that the metadata the loader installs is the
metadata that was signed.

This split is the core of the long-standing objection to the BPF signing
scheme from the LSM / integrity side: the integrity check of a light
skeleton only completes once the loader program runs, that is, after the
security_bpf_prog_load() hook, so at admission time an LSM observes a
program whose payload has not yet been verified [0]. Auditing the chain
link is also not a purely cryptographic operation: whoever signs or reviews
an lskel has to disassemble the loader's preamble to convince themselves
that the embedded hash check is present and correct [1][2]. Two acceptable
fixes were identified in those threads: Complete the integrity check
before the admission hook fires, or add a second hook that collects the
verification result after the loader ran [3]. Let's implement the former,
without growing the UAPI.

A signed loader binds its metadata map(s) through the existing fd_array,
and an exclusive map is already bound to a program digest (excl_prog_hash).
So when a signature is present, collect the exclusive maps from fd_array
and append their frozen contents to the instructions before verification:
the signature now covers insns || metadata_0 || metadata_1 || [...] in the
fd_array order, and verification completes in bpf_check(), once the
fd_array maps are resolved into used_maps, before the LSM admission hook
and the rest of verification.

A program is either BPF_SIG_UNSIGNED or BPF_SIG_VERIFIED, with nothing in
between. While folding the fd_array maps, a non-exclusive map bound to
a signed program is rejected, so every map folded into the signature is
exclusive. A signed loader that fails to cover its metadata thus does not
load, and BPF_SIG_VERIFIED always means the instructions and every
exclusive map are authentic.

The maps must be frozen so the hashed bytes cannot change before the
loader runs; the map <-> program digest binding is enforced by the
verifier for every used map. Binding maps through fd_array_cnt makes the
verifier resolve and excl-check them (excl_prog_sha vs prog->digest)
before it would otherwise compute the digest, so compute prog->digest
up front in bpf_check(), over the unmodified instructions the
signature covers, for a load that folds metadata.

Unsigned programs are not affected. Note, signed loaders generated by
older libbpf/bpftool versions need to be regenerated; some of the recent
fixes we've had on the signed loader side require the latter already to
close gaps.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/CAHC9VhSDkwGgPfrBUh7EgBKEJj_JjnY68c0YAmuuLT_i--GskQ@mail.gmail.com [0]
Link: https://lore.kernel.org/bpf/2f71d6c03698eb17d51f7247efde777627ee578a.camel@HansenPartnership.com [1]
Link: https://lore.kernel.org/lkml/ecf0521ed302db672672ebfbc670ecfba36a6e00.camel@HansenPartnership.com [2]
Link: https://lore.kernel.org/bpf/88703f00d5b7a779728451008626efa45e42db3d.camel@HansenPartnership.com [3]
---
 include/linux/bpf_verifier.h |   1 +
 kernel/bpf/syscall.c         |  76 +--------------
 kernel/bpf/verifier.c        | 175 +++++++++++++++++++++++++++++++++++
 3 files changed, 178 insertions(+), 74 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 9f0a4e9a15d7..961efb903141 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -947,6 +947,7 @@ struct bpf_verifier_env {
 	bool bypass_spec_v4;
 	bool seen_direct_write;
 	bool seen_exception;
+	bool signature;
 	struct bpf_insn_aux_data *insn_aux_data; /* array of per-insn state */
 	const struct bpf_line_info *prev_linfo;
 	struct bpf_verifier_log log;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 6db306d23b47..e898fad01aaf 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -40,7 +40,6 @@
 #include <linux/tracepoint.h>
 #include <linux/overflow.h>
 #include <linux/cookie.h>
-#include <linux/verification.h>
 #include <linux/btf_ids.h>
 
 #include <net/netfilter/nf_bpf_link.h>
@@ -2886,64 +2885,6 @@ static bool is_perfmon_prog_type(enum bpf_prog_type prog_type)
 	}
 }
 
-static enum bpf_sig_keyring bpf_classify_keyring(s32 keyring_id)
-{
-	switch (keyring_id) {
-	case 0:
-		return BPF_SIG_KEYRING_BUILTIN;
-	case (s32)(unsigned long)VERIFY_USE_SECONDARY_KEYRING:
-		return BPF_SIG_KEYRING_SECONDARY;
-	case (s32)(unsigned long)VERIFY_USE_PLATFORM_KEYRING:
-		return BPF_SIG_KEYRING_PLATFORM;
-	default:
-		return BPF_SIG_KEYRING_USER;
-	}
-}
-
-static int bpf_prog_verify_signature(struct bpf_prog *prog, union bpf_attr *attr,
-				     bool is_kernel, s32 *keyring_serial)
-{
-	bpfptr_t usig = make_bpfptr(attr->signature, is_kernel);
-	struct bpf_dynptr_kern sig_ptr, insns_ptr;
-	struct bpf_key *key = NULL;
-	void *sig;
-	int err = 0;
-
-	/*
-	 * Don't attempt to use kmalloc_large or vmalloc for signatures.
-	 * Practical signature for BPF program should be below this limit.
-	 */
-	if (attr->signature_size > KMALLOC_MAX_CACHE_SIZE)
-		return -EINVAL;
-
-	if (system_keyring_id_check(attr->keyring_id) == 0)
-		key = bpf_lookup_system_key(attr->keyring_id);
-	else
-		key = bpf_lookup_user_key(attr->keyring_id, 0);
-
-	if (!key)
-		return -EINVAL;
-
-	sig = kvmemdup_bpfptr(usig, attr->signature_size);
-	if (IS_ERR(sig)) {
-		bpf_key_put(key);
-		return PTR_ERR(sig);
-	}
-
-	bpf_dynptr_init(&sig_ptr, sig, BPF_DYNPTR_TYPE_LOCAL, 0,
-			attr->signature_size);
-	bpf_dynptr_init(&insns_ptr, prog->insnsi, BPF_DYNPTR_TYPE_LOCAL, 0,
-			prog->len * sizeof(struct bpf_insn));
-
-	err = bpf_verify_pkcs7_signature((struct bpf_dynptr *)&insns_ptr,
-					 (struct bpf_dynptr *)&sig_ptr, key);
-	if (!err)
-		*keyring_serial = bpf_key_serial(key);
-	bpf_key_put(key);
-	kvfree(sig);
-	return err;
-}
-
 static int bpf_prog_mark_insn_arrays_ready(struct bpf_prog *prog)
 {
 	int err;
@@ -3133,17 +3074,8 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, struct bpf_log_at
 
 	/* eBPF programs must be GPL compatible to use GPL-ed functions */
 	prog->gpl_compatible = license_is_gpl_compatible(license) ? 1 : 0;
-	if (attr->signature) {
-		err = bpf_prog_verify_signature(prog, attr, uattr.is_kernel,
-						&prog->aux->sig.keyring_serial);
-		if (err)
-			goto free_prog;
-		prog->aux->sig.keyring_type = bpf_classify_keyring(attr->keyring_id);
-		prog->aux->sig.verdict = BPF_SIG_VERIFIED;
-	} else {
-		prog->aux->sig.keyring_type = BPF_SIG_KEYRING_NONE;
-		prog->aux->sig.verdict = BPF_SIG_UNSIGNED;
-	}
+	prog->aux->sig.keyring_type = BPF_SIG_KEYRING_NONE;
+	prog->aux->sig.verdict = BPF_SIG_UNSIGNED;
 	prog->orig_prog = NULL;
 	prog->jited = 0;
 
@@ -3189,10 +3121,6 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, struct bpf_log_at
 	if (err < 0)
 		goto free_prog;
 
-	err = security_bpf_prog_load(prog, attr, token, uattr.is_kernel);
-	if (err)
-		goto free_prog;
-
 	/* run eBPF verifier */
 	err = bpf_check(&prog, attr, uattr, attr_log);
 	if (err < 0)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 44bb6ce17a1c..1609053a0eeb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22,6 +22,8 @@
 #include <linux/ctype.h>
 #include <linux/error-injection.h>
 #include <linux/bpf_lsm.h>
+#include <linux/security.h>
+#include <linux/verification.h>
 #include <linux/btf_ids.h>
 #include <linux/poison.h>
 #include <linux/module.h>
@@ -2554,6 +2556,10 @@ fd_array_get_btf_sparse(struct bpf_verifier_env *env, u32 idx)
 
 static struct btf *fd_array_get_btf(struct bpf_verifier_env *env, u32 idx)
 {
+	if (env->signature) {
+		verbose(env, "signed program cannot bind any BTF\n");
+		return ERR_PTR(-EACCES);
+	}
 	if (env->fd_array)
 		return fd_array_get_btf_continuous(env, idx);
 	if (!bpfptr_is_null(env->fd_array_raw))
@@ -17636,6 +17642,11 @@ static int __add_used_btf(struct bpf_verifier_env *env, struct btf *btf)
 		if (env->used_btfs[i].btf == btf)
 			goto ret_put;
 
+	if (env->signature) {
+		verbose(env, "signed program cannot bind any BTF\n");
+		ret = -EACCES;
+		goto ret_put;
+	}
 	if (env->used_btf_cnt >= MAX_USED_BTFS) {
 		verbose(env, "The total number of btfs per program has reached the limit of %u\n",
 			MAX_USED_BTFS);
@@ -17918,6 +17929,12 @@ static int __add_used_map(struct bpf_verifier_env *env, struct bpf_map *map)
 		if (env->used_maps[i] == map)
 			return i;
 
+	if (env->signature &&
+	    env->prog->aux->sig.verdict == BPF_SIG_VERIFIED) {
+		verbose(env, "signed program cannot bind map '%s' not covered by the signature\n",
+			map->name);
+		return -EACCES;
+	}
 	if (env->used_map_cnt >= MAX_USED_MAPS) {
 		verbose(env, "The total number of maps per program has reached the limit of %u\n",
 			MAX_USED_MAPS);
@@ -18001,6 +18018,10 @@ static int fd_array_get_map_idx(struct bpf_verifier_env *env, u32 idx)
 {
 	if (env->fd_array)
 		return fd_array_get_map_idx_continuous(env, idx);
+	if (env->signature) {
+		verbose(env, "signed program must bind maps via a continuous fd_array (fd_array_cnt)\n");
+		return -EACCES;
+	}
 	if (!bpfptr_is_null(env->fd_array_raw))
 		return fd_array_get_map_idx_sparse(env, idx);
 
@@ -18279,6 +18300,10 @@ static int check_and_resolve_insns(struct bpf_verifier_env *env)
 				map_idx = fd_array_get_map_idx(env, insn[0].imm);
 				break;
 			default:
+				if (env->signature) {
+					verbose(env, "signed program cannot reference a map by fd, only via fd_array index\n");
+					return -EINVAL;
+				}
 				map_idx = add_used_map(env, insn[0].imm);
 				break;
 			}
@@ -19846,6 +19871,139 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	return 0;
 }
 
+static enum bpf_sig_keyring bpf_classify_keyring(s32 keyring_id)
+{
+	switch (keyring_id) {
+	case 0:
+		return BPF_SIG_KEYRING_BUILTIN;
+	case (s32)(unsigned long)VERIFY_USE_SECONDARY_KEYRING:
+		return BPF_SIG_KEYRING_SECONDARY;
+	case (s32)(unsigned long)VERIFY_USE_PLATFORM_KEYRING:
+		return BPF_SIG_KEYRING_PLATFORM;
+	default:
+		return BPF_SIG_KEYRING_USER;
+	}
+}
+
+/*
+ * Verify the PKCS#7 signature of a loaded program. Called from bpf_check()
+ * once the program's metadata maps have been resolved into used_maps, so
+ * the exact maps folded into the signature are the ones the program binds.
+ *
+ * The signature covers the instructions followed by the frozen contents of
+ * each map, in @maps order: insns || map_0 || map_1 || [...]. On success the
+ * verdict and keyring info are recorded on prog->aux.
+ */
+static int bpf_prog_verify_signature(struct bpf_verifier_env *env,
+				     union bpf_attr *attr, bool is_kernel)
+{
+	bpfptr_t usig = make_bpfptr(attr->signature, is_kernel);
+	struct bpf_dynptr_kern sig_ptr, data_ptr;
+	struct bpf_prog *prog = env->prog;
+	struct bpf_map **maps = env->used_maps;
+	struct bpf_key *key = NULL;
+	void *sig, *data = NULL;
+	u32 map_cnt = env->used_map_cnt;
+	u32 i, off, insns_sz;
+	u64 data_sz;
+	int err = 0;
+
+	/*
+	 * Don't attempt to use kmalloc_large or vmalloc for signatures.
+	 * Practical signature for BPF program should be below this limit.
+	 */
+	if (attr->signature_size > KMALLOC_MAX_CACHE_SIZE)
+		return -EINVAL;
+	if (system_keyring_id_check(attr->keyring_id) == 0)
+		key = bpf_lookup_system_key(attr->keyring_id);
+	else
+		key = bpf_lookup_user_key(attr->keyring_id, 0);
+	if (!key) {
+		verbose(env, "cannot resolve signing keyring with keyring_id %d\n",
+			attr->keyring_id);
+		return -EINVAL;
+	}
+
+	sig = kvmemdup_bpfptr(usig, attr->signature_size);
+	if (IS_ERR(sig)) {
+		bpf_key_put(key);
+		return PTR_ERR(sig);
+	}
+
+	insns_sz = prog->len * sizeof(struct bpf_insn);
+	data_sz = insns_sz;
+	for (i = 0; i < map_cnt; i++) {
+		struct bpf_map *map = maps[i];
+
+		if (map->map_type != BPF_MAP_TYPE_ARRAY ||
+		    !map->ops->map_direct_value_addr) {
+			verbose(env, "signed program metadata map '%s' must be an array\n",
+				map->name);
+			err = -EINVAL;
+			goto out;
+		}
+		if (!READ_ONCE(map->frozen)) {
+			verbose(env, "signed program metadata map '%s' must be frozen\n",
+				map->name);
+			err = -EPERM;
+			goto out;
+		}
+		if (!map->excl_prog_sha) {
+			verbose(env, "signed program metadata map '%s' must be exclusive\n",
+				map->name);
+			err = -EPERM;
+			goto out;
+		}
+		data_sz += map->value_size;
+	}
+	if (bpf_dynptr_check_size(data_sz)) {
+		verbose(env, "signed payload too large: %llu bytes\n", data_sz);
+		err = -E2BIG;
+		goto out;
+	}
+	data = kvmalloc(data_sz, GFP_KERNEL | __GFP_ZERO);
+	if (!data) {
+		err = -ENOMEM;
+		goto out;
+	}
+	memcpy(data, prog->insnsi, insns_sz);
+	off = insns_sz;
+	for (i = 0; i < map_cnt; i++) {
+		struct bpf_map *map = maps[i];
+		u64 addr;
+
+		err = map->ops->map_direct_value_addr(map, &addr, 0);
+		if (err) {
+			verbose(env, "failed to read signed metadata map '%s': %d\n",
+				map->name, err);
+			goto out;
+		}
+		memcpy(data + off, (void *)(unsigned long)addr,
+		       map->value_size);
+		off += map->value_size;
+	}
+
+	bpf_dynptr_init(&data_ptr, data, BPF_DYNPTR_TYPE_LOCAL, 0, data_sz);
+	bpf_dynptr_init(&sig_ptr, sig, BPF_DYNPTR_TYPE_LOCAL, 0,
+			attr->signature_size);
+
+	err = bpf_verify_pkcs7_signature((struct bpf_dynptr *)&data_ptr,
+					 (struct bpf_dynptr *)&sig_ptr, key);
+	if (err) {
+		verbose(env, "signature verification failed: %d\n", err);
+	} else {
+		verbose(env, "signature verification passed\n");
+		prog->aux->sig.keyring_serial = bpf_key_serial(key);
+		prog->aux->sig.keyring_type = bpf_classify_keyring(attr->keyring_id);
+		prog->aux->sig.verdict = BPF_SIG_VERIFIED;
+	}
+out:
+	kvfree(data);
+	bpf_key_put(key);
+	kvfree(sig);
+	return err;
+}
+
 int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	      struct bpf_log_attr *attr_log)
 {
@@ -19888,6 +20046,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	env->bypass_spec_v1 = bpf_bypass_spec_v1(env->prog->aux->token);
 	env->bypass_spec_v4 = bpf_bypass_spec_v4(env->prog->aux->token);
 	env->bpf_capable = is_priv = bpf_token_capable(env->prog->aux->token, CAP_BPF);
+	env->signature = attr->signature;
 
 	bpf_get_btf_vmlinux();
 
@@ -19901,11 +20060,27 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	ret = bpf_vlog_init(&env->log, attr_log->level, attr_log->ubuf, attr_log->size);
 	if (ret)
 		goto err_unlock;
+	if (env->signature) {
+		ret = bpf_prog_calc_tag(env->prog);
+		if (ret < 0)
+			goto skip_full_check;
+	}
 
 	ret = process_fd_array(env, attr, uattr);
 	if (ret)
 		goto skip_full_check;
 
+	if (env->signature) {
+		ret = bpf_prog_verify_signature(env, attr, uattr.is_kernel);
+		if (ret)
+			goto skip_full_check;
+	}
+
+	ret = security_bpf_prog_load(env->prog, attr, env->prog->aux->token,
+				     uattr.is_kernel);
+	if (ret)
+		goto skip_full_check;
+
 	mark_verifier_state_clean(env);
 
 	if (IS_ERR(btf_vmlinux)) {
-- 
2.43.0

