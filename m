Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DFB33F8D9;
	Mon,  6 Jul 2026 13:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783346219; cv=none; b=oplSCCoQoHWkVvNWd61yFJq7Rrqrpr77kk8GkpZ6bM1AXAWIrSSLB0pgaeEfQTODPqia3PNwxKyJ3VhiQSrL8+ktqPCQKdMFJ/qWBGUN2s+Jf9TNyfy+QVYCsJfc7ZHsPWO6936USto1XdPgSO6y7uyHCt0zAzgRjcvclELRTUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783346219; c=relaxed/simple;
	bh=AFobW6kCVrEgRfUSulWNJLmli01JdTw30DK4Sf7OEuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aEyVUa9IUDSLq9FvTvEY1reu11WIrIWkEQdMUXgJmOGsCdK2Pavyt6OW4pE4QqAc8PT3JO8MzQ2CFQHbSX2QLugtEHc/P61dvr5Bdl7mP7c65CiC2hnsozSjd9z1H8QMddwa//xZ1sdTD5vm+/7F15oa4o+Gw7KO/pgADF6GjoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=DaOG+g6d; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="DaOG+g6d"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=8Jf7d6iDFHmRodPXNGBE+C0ADnin4Cwn/EyvuNQ07L4=; b=DaOG+g6dHe9qR3jN/UZ2AngD0+
	Bf4J5NmY5vbRMUeSKcHPIGx+KWPZwG/fXoTHrY3JE7w6Qc1nMh+K1lyLfUBAdK2K9vdtU1drlxRbc
	VmbpMO+5ocxhozq4KAT5euLpNXU1xI66h+QhevalGx9Y8OSmUwYdjpD9xPRVbzQq7BgDKXuPyQ2pC
	tT8PNt9cogqxv8K98zzcVYBjynofNIjcCmrz4V0hS82Chqi7ap9OAV9z6dFJpZA8hXY1SD3lXcNeC
	svek4s2w/kOhOQHEZaZeZaIL918pQMADXZ1FaZNjV0rnh4cPsQWIfhCcgyauFUJEFVu6o72Bv3fSJ
	v+W+1ePA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wgjoW-000E21-20;
	Mon, 06 Jul 2026 15:56:48 +0200
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
Subject: [PATCH bpf-next v4 3/9] bpf: Verify signed loader metadata at load time
Date: Mon,  6 Jul 2026 15:56:38 +0200
Message-ID: <20260706135644.326006-4-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706135644.326006-1-daniel@iogearbox.net>
References: <20260706135644.326006-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28052/Mon Jul  6 08:24:35 2026)

A signed gen_loader program carries the programs, maps and relocations
it installs in a metadata array map. The loader instructions are covered
by the PKCS#7 signature, but the metadata map is not: Today the loader
compares the map contents from within BPF against a hash baked into its
(signed) instructions, using the kernel-cached map hash. The kernel
itself never actually attests that the metadata the loader installs is
the metadata that was signed.

This split is the core of the long-standing objection to the BPF signing
scheme from the LSM / integrity side: the integrity check of a light
skeleton only completes once the loader program runs, that is, after the
security_bpf_prog_load() hook, so at admission time an LSM observes a
program whose payload has not yet been verified. Auditing the chain
link is also not a purely cryptographic operation: whoever signs or
reviews an lskel has to disassemble the loader's preamble to convince
themselves that the embedded hash check is present and correct [0][1].
Two acceptable fixes were identified in those threads: Complete the
integrity check before the admission hook fires, or add a second hook
that collects the verification result after the loader ran [2]. Covering
both the loader and its maps directly with the PKCS#7 signature is what
Blaise Boscaccy's patchsets proposed in several forms. Let's implement
the former, without growing the UAPI, and in particular as a single
unified scheme where the signature spans the raw bytes rather than
derived hashes.

A signed loader binds its metadata map(s) through the existing fd_array,
and an exclusive map is already bound to a program digest (excl_prog_hash).
So when a signature is present, collect the exclusive maps from fd_array
and append their frozen contents to the instructions before verification:
The signature now covers insns || metadata_0 || metadata_1 || [...] in
the fd_array order, and verification completes in bpf_check(), once the
fd_array maps are resolved into used_maps, before the LSM admission hook
and the rest of verification. A program is either BPF_SIG_UNSIGNED or
BPF_SIG_VERIFIED, with nothing in between. While folding the fd_array
maps, a non-exclusive map bound to a signed program is rejected, so every
map folded into the signature is exclusive. A signed loader that fails
to cover its metadata thus does not load, and BPF_SIG_VERIFIED always
means the instructions and every exclusive map are authentic. The maps
must be frozen so the hashed bytes cannot change before the loader runs;
the map <-> program digest binding is enforced by the verifier for every
used map. Binding maps through fd_array_cnt makes the verifier resolve
and excl-check them (excl_prog_sha vs prog->digest) before it would
otherwise compute the digest, so compute prog->digest up front in
bpf_check(), over the unmodified instructions the signature covers, for
a load that folds metadata.

Unsigned programs are not affected by the signature path; for them the
LSM admission hook merely moves below fd_array resolution, with minimal
bounded work in between (see the previous commit). Note, signed loaders
generated by older libbpf/bpftool versions need to be regenerated; some
of the recent fixes we've had on the signed loader side require the
latter already to close gaps.

Finally, some remarks around the security_bpf_prog_load() placement
given there was pushback, demanding either a new hook or a reuse of
the existing security_bpf_prog() hook [3]: Just for loading a single
BPF program it would then need to pass through four layers of LSM hooks:

  1) security_bpf (cmd=PROG_LOAD): for gating various bpf subcmds
  2) security_bpf_prog_load: historical admission hook (CAP/token,
     prog_type, attach point), pre-verification
  3) security_bpf_prog_verify_signature: newly asked admission hook,
     same role as 2), plus the BPF signature verdict
  4) security_bpf_prog: gate handing the prog fd back to userspace,
     verification done & signature verified

The use-cases of 2) and 3) conflate, thus BPF community prefers to just
keep a total of 3 LSM hooks (as-is today): 3) makes 2) incoherent given
they are the /same class/ of hook, that is, access-control admission on
the load and split only by _what_ they can see. Worse, with the split,
for a signed BPF program security_bpf_prog_load 2) admits a program whose
signature has not been checked, so a policy gating at 2) is structurally
unable to express "admit only verified" and every such policy is forced
onto 3) *anyway*. In other words, one doesn't get two complementary hooks,
but rather, one real admission hook aka 3) plus a now-degraded /legacy/
hook 2) that can't answer the question operators actually want to ask.

Reusing security_bpf_prog() 4) for admission is no alternative either:
it fires only after the entire verifier (and JIT) pipeline ran, so
denying a not-yet-verified program at that point burns exactly the
work a denial is supposed to avoid, and by then the program has an id
assigned and the kallsyms/perf/audit load events fired. Policies are
free to also consume the signature verdict at 4), but admission control
belongs into security_bpf_prog_load(). Hence the latter remains the only
admission hook, merely moved past signature verification; with moving
large allocations further down into the BPF verifier, there is now only
minimal work between the old and new location.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Nacked-by: Paul Moore <paul@paul-moore.com> # (don't move bpf_prog_load LSM hook)
Link: https://lore.kernel.org/bpf/2f71d6c03698eb17d51f7247efde777627ee578a.camel@HansenPartnership.com [0]
Link: https://lore.kernel.org/lkml/ecf0521ed302db672672ebfbc670ecfba36a6e00.camel@HansenPartnership.com [1]
Link: https://lore.kernel.org/bpf/88703f00d5b7a779728451008626efa45e42db3d.camel@HansenPartnership.com [2]
Link: https://lore.kernel.org/bpf/DJOFY21DYUI4.19WKQ3NPZ4H5R@gmail.com [3]
---
 include/linux/bpf_verifier.h |   1 +
 kernel/bpf/syscall.c         |  76 +--------------
 kernel/bpf/verifier.c        | 175 +++++++++++++++++++++++++++++++++++
 3 files changed, 178 insertions(+), 74 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index bb57773cde37..317e99b9acc0 100644
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
index e227c76a8dd9..65f53128fc33 100644
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
@@ -17648,6 +17654,11 @@ static int __add_used_btf(struct bpf_verifier_env *env, struct btf *btf)
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
@@ -17930,6 +17941,12 @@ static int __add_used_map(struct bpf_verifier_env *env, struct bpf_map *map)
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
@@ -18013,6 +18030,10 @@ static int fd_array_get_map_idx(struct bpf_verifier_env *env, u32 idx)
 {
 	if (env->fd_array)
 		return fd_array_get_map_idx_continuous(env, idx);
+	if (env->signature) {
+		verbose(env, "signed program must bind maps via a continuous fd_array (fd_array_cnt)\n");
+		return -EACCES;
+	}
 	if (!bpfptr_is_null(env->fd_array_raw))
 		return fd_array_get_map_idx_sparse(env, idx);
 
@@ -18291,6 +18312,10 @@ static int check_and_resolve_insns(struct bpf_verifier_env *env)
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
@@ -19872,6 +19897,139 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
+	data = kvmalloc(data_sz, GFP_KERNEL_ACCOUNT | __GFP_ZERO);
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
@@ -19902,6 +20060,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	env->bypass_spec_v1 = bpf_bypass_spec_v1(env->prog->aux->token);
 	env->bypass_spec_v4 = bpf_bypass_spec_v4(env->prog->aux->token);
 	env->bpf_capable = is_priv = bpf_token_capable(env->prog->aux->token, CAP_BPF);
+	env->signature = attr->signature;
 
 	/* user could have requested verbose verifier output
 	 * and supplied buffer to store the verification trace
@@ -19909,11 +20068,27 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	ret = bpf_vlog_init(&env->log, attr_log->level, attr_log->ubuf, attr_log->size);
 	if (ret)
 		goto err_free_env;
+	if (env->signature) {
+		ret = bpf_prog_calc_tag(env->prog);
+		if (ret < 0)
+			goto err_prep;
+	}
 
 	ret = process_fd_array(env, attr, uattr);
 	if (ret)
 		goto err_prep;
 
+	if (env->signature) {
+		ret = bpf_prog_verify_signature(env, attr, uattr.is_kernel);
+		if (ret)
+			goto err_prep;
+	}
+
+	ret = security_bpf_prog_load(env->prog, attr, env->prog->aux->token,
+				     uattr.is_kernel);
+	if (ret)
+		goto err_prep;
+
 	bpf_get_btf_vmlinux();
 
 	/* grab the mutex to protect few globals used by verifier */
-- 
2.43.0

