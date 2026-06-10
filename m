Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7210313543;
	Wed, 10 Jun 2026 23:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781132621; cv=none; b=BAVjHezNNkw+nebIkR7KQyoGidXAQa7i5/v30KIywDIOMat4UFCe8ABwnlQ0oNwWWkEL1n/Y/8+nsgdPJnKy8qxNq5BrawoEuYrAmy48vu818zuz4EcbI6Q4UrbQzw5AApsD2NJrcINMfZxl3f1jFC1uLry1CQurKw+dYFlnK+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781132621; c=relaxed/simple;
	bh=hMeWMFzj9taXJMDRDqv3hHulJsnsNpyddj3+onbPBJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GOpqaCW7JepBAKCFJQadqFnJRtlga8hvJE+Mo3H0gD/XawGpCMtxOnsHBZS5q3YqtyJQTN8XIOAv7+eG/b3SabhupAvgLjdRx0khViknZj1GOTpmJ+Y2NZgJSIX7FsOIWRDVAkup8TNO55NrGyUDl+ysqPTID5RCpVxBdq8Ym3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=qvCYw3Ca; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="qvCYw3Ca"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=tZdSVw6Pp7csRdJWbkUwLlFlPGoNNT4hKvF+DYsc5qE=; b=qvCYw3Ca15odtilLHl+5qDlKPh
	ZehXRV5xZ/Hx1+x22rZvkQ6Kh4bIq9SOoIeYiZyhcn/TYxaP8uZ23MivSCQeiwgtS0ztjesXPVUpy
	E+4uUFMSBBMOsaOm8OCnaK1vKINoKUjQqwxp6JcKYzQOiTGSWrzCCU7HNfPmWlR9PWP0l9ilJ/Rdl
	B3hABwyOuy3A9mKpJ/XVDmYyPyBu0ePq6C3VAweqEMbnL3OXjZsOXXz5pXUwV0Z8L9eBPUtDExrFb
	00/cqP8nMg+xdS58r25l5dM1ONlu8VxezFpPnQE0BY4Yj4wv1IsALyMpiRWo9ZoPNa6Or7jVE+U+b
	DnAFsBlg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wXRxL-0008QQ-1A;
	Thu, 11 Jun 2026 01:03:31 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: kpsingh@kernel.org,
	James.Bottomley@hansenpartnership.com,
	paul@paul-moore.com,
	bboscaccy@linux.microsoft.com,
	memxor@gmail.com,
	torvalds@linux-foundation.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH bpf-next 1/5] bpf: Verify signed loader metadata at load time
Date: Thu, 11 Jun 2026 01:03:25 +0200
Message-ID: <20260610230329.727075-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610230329.727075-1-daniel@iogearbox.net>
References: <20260610230329.727075-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28027/Wed Jun 10 08:29:13 2026)

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
fd_array order, and verification completes in bpf_prog_load() before the
LSM admission hook and before the verifier runs.

A program is either BPF_SIG_UNSIGNED or BPF_SIG_VERIFIED, with nothing in
between. While collecting the fd_array maps, a non-exclusive map bound to
a signed program is rejected, so every map folded into the signature is
exclusive. A signed loader that fails to cover its metadata thus does not
load, and BPF_SIG_VERIFIED always means the instructions and every
exclusive map are authentic.

The maps must be frozen so the hashed bytes cannot change before the
loader runs; the map <-> program digest binding is enforced by the
verifier for every used map. Binding maps through fd_array_cnt makes the
verifier resolve and excl-check them (excl_prog_sha vs prog->digest)
before it would otherwise compute the digest, so compute prog->digest
up front in bpf_prog_load(), over the unmodified instructions the
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
 kernel/bpf/syscall.c | 164 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 157 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index d4188a992bd8..796e28e840d6 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2895,13 +2895,81 @@ static enum bpf_sig_keyring bpf_classify_keyring(s32 keyring_id)
 	}
 }
 
+static void bpf_prog_put_excl_maps(struct bpf_map **maps, u32 cnt)
+{
+	u32 i;
+
+	if (!maps)
+		return;
+	for (i = 0; i < cnt; i++)
+		bpf_map_put(maps[i]);
+	kfree(maps);
+}
+
+static int bpf_prog_collect_excl_maps(union bpf_attr *attr, bool is_kernel,
+				      struct bpf_map ***mapsp, u32 *cntp)
+{
+	bpfptr_t fds = make_bpfptr(attr->fd_array, is_kernel);
+	struct bpf_map **maps;
+	u32 i, n = 0;
+	int fd, err;
+
+	*mapsp = NULL;
+	*cntp = 0;
+
+	if (!attr->fd_array || !attr->fd_array_cnt)
+		return 0;
+	/*
+	 * Stricter than the verifier, which dedups fd_array entries against
+	 * used_maps: every entry here is folded into the signed data
+	 * individually, so cap the raw count.
+	 */
+	if (attr->fd_array_cnt > MAX_USED_MAPS)
+		return -E2BIG;
+
+	maps = kcalloc(attr->fd_array_cnt, sizeof(*maps), GFP_KERNEL);
+	if (!maps)
+		return -ENOMEM;
+
+	for (i = 0; i < attr->fd_array_cnt; i++) {
+		struct bpf_map *map;
+
+		if (copy_from_bpfptr_offset(&fd, fds, i * sizeof(int),
+					    sizeof(int))) {
+			err = -EFAULT;
+			goto err_put;
+		}
+		map = bpf_map_get(fd);
+		if (IS_ERR(map)) {
+			err = PTR_ERR(map);
+			goto err_put;
+		}
+		if (!map->excl_prog_sha) {
+			bpf_map_put(map);
+			err = -EINVAL;
+			goto err_put;
+		}
+		maps[n++] = map;
+	}
+
+	*mapsp = maps;
+	*cntp = n;
+	return 0;
+err_put:
+	bpf_prog_put_excl_maps(maps, n);
+	return err;
+}
+
 static int bpf_prog_verify_signature(struct bpf_prog *prog, union bpf_attr *attr,
-				     bool is_kernel, s32 *keyring_serial)
+				     bool is_kernel, s32 *keyring_serial,
+				     struct bpf_map **excl_maps, u32 excl_cnt)
 {
 	bpfptr_t usig = make_bpfptr(attr->signature, is_kernel);
-	struct bpf_dynptr_kern sig_ptr, insns_ptr;
+	struct bpf_dynptr_kern sig_ptr, data_ptr;
 	struct bpf_key *key = NULL;
-	void *sig;
+	void *sig, *data = NULL;
+	u32 i, off, insns_sz;
+	u64 data_sz;
 	int err = 0;
 
 	/*
@@ -2925,20 +2993,78 @@ static int bpf_prog_verify_signature(struct bpf_prog *prog, union bpf_attr *attr
 		return PTR_ERR(sig);
 	}
 
+	insns_sz = prog->len * sizeof(struct bpf_insn);
+	data_sz = insns_sz;
+	for (i = 0; i < excl_cnt; i++) {
+		if (!READ_ONCE(excl_maps[i]->frozen) ||
+		    !excl_maps[i]->ops->map_direct_value_addr) {
+			err = -EPERM;
+			goto out;
+		}
+		data_sz += excl_maps[i]->value_size;
+	}
+
+	if (bpf_dynptr_check_size(data_sz)) {
+		err = -E2BIG;
+		goto out;
+	}
+	data = kvmalloc(data_sz, GFP_KERNEL);
+	if (!data) {
+		err = -ENOMEM;
+		goto out;
+	}
+	memcpy(data, prog->insnsi, insns_sz);
+	off = insns_sz;
+	for (i = 0; i < excl_cnt; i++) {
+		struct bpf_map *map = excl_maps[i];
+		u64 addr;
+
+		err = map->ops->map_direct_value_addr(map, &addr, 0);
+		if (err)
+			goto out;
+		memcpy(data + off, (void *)(unsigned long)addr, map->value_size);
+		off += map->value_size;
+	}
+
+	bpf_dynptr_init(&data_ptr, data, BPF_DYNPTR_TYPE_LOCAL, 0, data_sz);
 	bpf_dynptr_init(&sig_ptr, sig, BPF_DYNPTR_TYPE_LOCAL, 0,
 			attr->signature_size);
-	bpf_dynptr_init(&insns_ptr, prog->insnsi, BPF_DYNPTR_TYPE_LOCAL, 0,
-			prog->len * sizeof(struct bpf_insn));
 
-	err = bpf_verify_pkcs7_signature((struct bpf_dynptr *)&insns_ptr,
+	err = bpf_verify_pkcs7_signature((struct bpf_dynptr *)&data_ptr,
 					 (struct bpf_dynptr *)&sig_ptr, key);
 	if (!err)
 		*keyring_serial = bpf_key_serial(key);
+out:
+	kvfree(data);
 	bpf_key_put(key);
 	kvfree(sig);
 	return err;
 }
 
+static int bpf_prog_check_excl_used_maps(struct bpf_prog *prog,
+					 struct bpf_map **excl_maps, u32 excl_cnt)
+{
+	u32 i, j;
+
+	for (i = 0; i < prog->aux->used_map_cnt; i++) {
+		struct bpf_map *map = prog->aux->used_maps[i];
+		bool folded = false;
+
+		if (!map->excl_prog_sha)
+			continue;
+		for (j = 0; j < excl_cnt; j++) {
+			if (excl_maps[j] == map) {
+				folded = true;
+				break;
+			}
+		}
+		if (!folded)
+			return -EACCES;
+	}
+
+	return 0;
+}
+
 static int bpf_prog_mark_insn_arrays_ready(struct bpf_prog *prog)
 {
 	int err;
@@ -2968,8 +3094,10 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, struct bpf_log_at
 {
 	enum bpf_prog_type type = attr->prog_type;
 	struct bpf_prog *prog, *dst_prog = NULL;
+	struct bpf_map **excl_maps = NULL;
 	struct btf *attach_btf = NULL;
 	struct bpf_token *token = NULL;
+	u32 excl_cnt = 0;
 	bool bpf_cap;
 	int err;
 	char license[128];
@@ -3129,10 +3257,17 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, struct bpf_log_at
 	/* eBPF programs must be GPL compatible to use GPL-ed functions */
 	prog->gpl_compatible = license_is_gpl_compatible(license) ? 1 : 0;
 	if (attr->signature) {
+		err = bpf_prog_collect_excl_maps(attr, uattr.is_kernel,
+						 &excl_maps, &excl_cnt);
+		if (err)
+			goto free_prog;
+
 		err = bpf_prog_verify_signature(prog, attr, uattr.is_kernel,
-						&prog->aux->sig.keyring_serial);
+						&prog->aux->sig.keyring_serial,
+						excl_maps, excl_cnt);
 		if (err)
 			goto free_prog;
+
 		prog->aux->sig.keyring_type = bpf_classify_keyring(attr->keyring_id);
 		prog->aux->sig.verdict = BPF_SIG_VERIFIED;
 	} else {
@@ -3187,12 +3322,25 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, struct bpf_log_at
 	err = security_bpf_prog_load(prog, attr, token, uattr.is_kernel);
 	if (err)
 		goto free_prog;
+	if (excl_cnt) {
+		err = bpf_prog_calc_tag(prog);
+		if (err < 0)
+			goto free_prog;
+	}
 
 	/* run eBPF verifier */
 	err = bpf_check(&prog, attr, uattr, attr_log);
 	if (err < 0)
 		goto free_used_maps;
 
+	if (prog->aux->sig.verdict == BPF_SIG_VERIFIED) {
+		err = bpf_prog_check_excl_used_maps(prog, excl_maps, excl_cnt);
+		if (err < 0)
+			goto free_used_maps;
+	}
+	bpf_prog_put_excl_maps(excl_maps, excl_cnt);
+	excl_maps = NULL;
+
 	err = bpf_prog_mark_insn_arrays_ready(prog);
 	if (err < 0)
 		goto free_used_maps;
@@ -3225,6 +3373,7 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, struct bpf_log_at
 	return err;
 
 free_used_maps:
+	bpf_prog_put_excl_maps(excl_maps, excl_cnt);
 	/* In case we have subprogs, we need to wait for a grace
 	 * period before we can tear down JIT memory since symbols
 	 * are already exposed under kallsyms.
@@ -3233,6 +3382,7 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, struct bpf_log_at
 	return err;
 
 free_prog:
+	bpf_prog_put_excl_maps(excl_maps, excl_cnt);
 	free_uid(prog->aux->user);
 	if (prog->aux->attach_btf)
 		btf_put(prog->aux->attach_btf);
-- 
2.43.0

