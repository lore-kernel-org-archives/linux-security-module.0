Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE88C369206;
	Mon,  6 Jul 2026 13:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783346217; cv=none; b=Fb0Xd7lS1YlX6/a/9ZLGNXjihwpio67swMZJqTTjUnfEcrqTw9t2FjY8YfLBh7uTGdcXUPIjuGkFbrSu8smADqDrcUoz2gLt5CgAXVONlxPbrzJY7u605bxFIyF3QbEKZYmoSiI+zwVJQgnd1tBm9FRGjy3iO6ElaruGYPhGZWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783346217; c=relaxed/simple;
	bh=pgA/ujVkUdfCXG0kecihorYgQ8VN59d25r9elNdyNS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GxT87E9f0EuyRquE3BhotNfTh358Yg3NYA4RKcjYPBea9fTzrdZgaNGiqfct8yUuujC/eJ/Wrxywb33bszfei2EVNAUCN/xxCEbyWSVdTJA1wZ1QghLLXmAMuS0GK8Hm+IsCo1k4qgL/7fXJRJ0bl7/HA9wpkraDMfp3Jjgj9Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=NNaxeGDf; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="NNaxeGDf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=q8qawat4SkBLaOrtoMwnWGfgTi/JJBolResV8W9bqxE=; b=NNaxeGDfO71YZ+6gVDHBVVa8KV
	12kLawTbPfgCpmFYvP2e1jOFMPS5tMIQE4OCv/GgCZV0KxD8ltB1EOU5Y1t62m7gQQwN9YNngnhBH
	bWpQ84NHEx1c06eDMWi9UyiRFs5dDJ7gwWYYPJ1Z47D1w3Uco/fOA3UsMQ209QjuCj4pLf2mT9h/x
	auCKuLuiw9YadIQpR/dPM5NfnN2dLf1E5mod9K8UjyXzAb5brvv49JPUfOLQZcnNhjjcJ84wJdGm6
	GA7k319T+iOmPwvNPUqYo7b4S9eAdg/bGxPY72INxX5Evic4++GtqbjqzwZawO2e/CMbdoqvCi78T
	sMfhbtoQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wgjoV-000E1i-2h;
	Mon, 06 Jul 2026 15:56:47 +0200
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
Subject: [PATCH bpf-next v4 2/9] bpf: Move bigger allocations below fd_array resolution
Date: Mon,  6 Jul 2026 15:56:37 +0200
Message-ID: <20260706135644.326006-3-daniel@iogearbox.net>
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

Reorder the preparation work in bpf_check() such that only the minimally
necessary setup happens up front: allocating the env, initializing the
verifier log and resolving the fd_array that a signed BPF metadata map
needs.

The worst case allocation (until hitting the security_bpf_prog_load()
admission hook once placed after fd_array) for this preparation part is
~90K which is the env itself (~54K) plus the continuous fd_array cache
(at most 32K). The insn_aux_data array is moved into a later stage in
the verification process.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/verifier.c | 52 +++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 33f9c47ee197..e227c76a8dd9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19894,18 +19894,6 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 		return -ENOMEM;
 
 	env->bt.env = env;
-
-	len = (*prog)->len;
-	env->insn_aux_data =
-		vzalloc(array_size(sizeof(struct bpf_insn_aux_data), len));
-	ret = -ENOMEM;
-	if (!env->insn_aux_data)
-		goto err_free_env;
-	for (i = 0; i < len; i++)
-		env->insn_aux_data[i].orig_idx = i;
-	env->succ = bpf_iarray_realloc(NULL, 2);
-	if (!env->succ)
-		goto err_free_env;
 	env->prog = *prog;
 	env->ops = bpf_verifier_ops[env->prog->type];
 
@@ -19915,21 +19903,33 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	env->bypass_spec_v4 = bpf_bypass_spec_v4(env->prog->aux->token);
 	env->bpf_capable = is_priv = bpf_token_capable(env->prog->aux->token, CAP_BPF);
 
-	bpf_get_btf_vmlinux();
-
-	/* grab the mutex to protect few globals used by verifier */
-	if (!is_priv)
-		mutex_lock(&bpf_verifier_lock);
-
 	/* user could have requested verbose verifier output
 	 * and supplied buffer to store the verification trace
 	 */
 	ret = bpf_vlog_init(&env->log, attr_log->level, attr_log->ubuf, attr_log->size);
 	if (ret)
-		goto err_unlock;
+		goto err_free_env;
 
 	ret = process_fd_array(env, attr, uattr);
 	if (ret)
+		goto err_prep;
+
+	bpf_get_btf_vmlinux();
+
+	/* grab the mutex to protect few globals used by verifier */
+	if (!is_priv)
+		mutex_lock(&bpf_verifier_lock);
+
+	len = env->prog->len;
+	env->insn_aux_data =
+		vzalloc(array_size(sizeof(struct bpf_insn_aux_data), len));
+	ret = -ENOMEM;
+	if (!env->insn_aux_data)
+		goto skip_full_check;
+	for (i = 0; i < len; i++)
+		env->insn_aux_data[i].orig_idx = i;
+	env->succ = bpf_iarray_realloc(NULL, 2);
+	if (!env->succ)
 		goto skip_full_check;
 
 	mark_verifier_state_clean(env);
@@ -20153,18 +20153,26 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	*prog = env->prog;
 
 	module_put(env->attach_btf_mod);
-err_unlock:
 	if (!is_priv)
 		mutex_unlock(&bpf_verifier_lock);
-	bpf_clear_insn_aux_data(env, 0, env->prog->len);
+	goto err_free_env;
+err_prep:
+	err = bpf_log_attr_finalize(attr_log, &env->log);
+	if (err)
+		ret = err;
+	release_insn_arrays(env);
+	release_maps(env);
+	release_btfs(env);
 err_free_env:
+	if (env->insn_aux_data)
+		bpf_clear_insn_aux_data(env, 0, env->prog->len);
+	vfree(env->insn_aux_data);
 	kvfree(env->fd_array);
 	bpf_stack_liveness_free(env);
 	kvfree(env->cfg.insn_postorder);
 	kvfree(env->scc_info);
 	kvfree(env->succ);
 	kvfree(env->gotox_tmp_buf);
-	vfree(env->insn_aux_data);
 	kvfree(env);
 	return ret;
 }
-- 
2.43.0

