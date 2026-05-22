Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02885306D3F;
	Fri, 22 May 2026 02:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779417169; cv=none; b=itD/V8nhwYkGt1tuBc/jIIUU6nS7qDb5LEsir0QIYZD4AR0+MnP0dUNU3DSc0wHTO676gJP/Bq7J4nwkzuNUO83qNnvDmgg/o/bvMA5oqlQNxl2NNHu2YntS3En5n99thTXsO7p7aR2KB+1y3S/YqFcxXY3GA/3IJBMpJBXLAKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779417169; c=relaxed/simple;
	bh=pkzEbbqK5S3wJtJWu+aI9D34yrFsnanGT/JBKg8VrHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sidL/J8xmOnFP3aX/QuLRJ78AQPq+uMXxWZ0kwbExlCyeafzRxJs9Lp24p/9MCy7ETmgLv4YsqkXfQgBd+h9JcF/eiKxUJGjH90iEPEE4zggtOTpNeFodyDJrjMpAKqYtm366VEVMBrEMGk8xAthYYClfyZkDsvo0OAu9vguio0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+ZO6GOl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+ZO6GOl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5F01F00A3D;
	Fri, 22 May 2026 02:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779417167;
	bh=+TYTNR4yv1nLu5iw0NrGMgV5v0wKGxA9i7eU3q1ovPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a+ZO6GOlgKxAgB7kaT6YSLJPs2bOXrjDj1HlJuHvemRdbO5+0m3A+Xd6naT8J5kxk
	 DAWen3m9GBxK2nzWmCj5dYkHlmciJly7FSc/Mb2RLjdwaI+FRiP249TzVputrDsLOz
	 hvq65d1SJegsrV2OfUW9zgeOQ1okRSYbHcjOub1oKkLFOkbmDIv9UHvqcNKg422dMQ
	 mHBmIkIjg4mO69p2EcgINVRKZJEQkhLB4Amvn4u91ZJGMnS1LVmazZ4AXT5XDw+PNf
	 H6MMhlfmEdzpwXn3kdvuB7FJUFGo6mhIkEKb7/1TvlavNAoPQM2eX/Y+XdaYSuFWYi
	 9FvGNWLzIP9PQ==
From: KP Singh <kpsingh@kernel.org>
To: linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	James.Bottomley@HansenPartnership.com,
	paul@paul-moore.com,
	KP Singh <kpsingh@kernel.org>
Subject: [PATCH bpf-next 05/13] bpf: compute prog->digest at BPF_PROG_LOAD entry
Date: Fri, 22 May 2026 04:32:25 +0200
Message-ID: <20260522023234.3778588-6-kpsingh@kernel.org>
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

add_subprog_and_kfunc relocates kfunc CALLs by patching insn->imm
and src_reg, and bpf_prog_calc_tag has no rule to mask kfunc CALL
fields. The tag has to be computed over the unmodified user-supplied
insns to match the excl_prog_hash userspace signed, so move the call
to bpf_prog_load right after signature verification.

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 kernel/bpf/syscall.c  | 7 +++++++
 kernel/bpf/verifier.c | 4 ----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 6d1db5eaad3c..39ebd825c136 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3086,6 +3086,13 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	}
 	prog->aux->is_kernel = uattr.is_kernel;
 
+	/* Hash insns now, before any verifier-side rewrite, so prog->digest
+	 * matches the excl_prog_hash userspace computed.
+	 */
+	err = bpf_prog_calc_tag(prog);
+	if (err)
+		goto free_prog;
+
 	prog->orig_prog = NULL;
 	prog->jited = 0;
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7fb88e1cd7c4..f0e45cfa5b34 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18434,10 +18434,6 @@ static int check_and_resolve_insns(struct bpf_verifier_env *env)
 	int insn_cnt = env->prog->len;
 	int i, err;
 
-	err = bpf_prog_calc_tag(env->prog);
-	if (err)
-		return err;
-
 	for (i = 0; i < insn_cnt; i++, insn++) {
 		if (insn->dst_reg >= MAX_BPF_REG) {
 			verbose(env, "R%d is invalid\n", insn->dst_reg);
-- 
2.53.0

