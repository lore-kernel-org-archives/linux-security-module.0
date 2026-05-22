Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4A331326C;
	Fri, 22 May 2026 02:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779417161; cv=none; b=YwKGRk2f9pxkTmZUsoADCn0Ej+WVeOC/8N6Re+mD9M3NTpjGKyK8YB8ShnmFPCtAMqRj/NqfgZiy41r77umu2lEtW5uFh+vafxbpnqOFpKg3MZi+mNfdx58Sz0Cbf5DiBQFu6VJvefhrwTLK3BjIK8oTGhmoujfmGgT9n9r2fYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779417161; c=relaxed/simple;
	bh=PYaxEGTVPsjWc85WfmH+gTF5r2YEkQVFFlsBTVJNYb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kNen7xkWACgKlBBaKKkIR6eI9UMUUiUQILiAW0BCH5q13QqfKVKakl8eS9EwIQoeNrWLpux0y1MXeg7+l/+D9+pAi4MUc8exLd/2Cm4Hg33rkcsTKxwOHOG7YFse2PhAhRe8LEJNmXbkvIBQDlIyFUlbH3Lpon+PXJDKGdFzbBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a7onYY5y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a7onYY5y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC4F1F00A3D;
	Fri, 22 May 2026 02:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779417159;
	bh=6Ew8S9k0MQSkaYBneomVofBFDVvdHxbYnlc6sX6xOpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a7onYY5yDp8PIB8aqSAJ6ypk3QcGVmQrSzlgVDlVkRJzx8ltaA4eCPa2VgnTMGoDP
	 HslfPG9ptkJE5dQw4NZifX2GP1wH3eFmUqF1IOR8BeG22LmKogD92/EDwQshBY/aAM
	 TjsceFCQcHp4v2uvy35jOr38F2FKxdX+LzD7oPEg+VMQVdrLDrbFUdpOKgsizu6/0V
	 N7LN/XkZzElWzrVROAitpx9bxz843UvIA9YekhaGcmDR70fnk8Djf6ywArQ3JWO0Mu
	 aorOEyKSL1MTcKmzhcf8saB+8TbLfcgeFElJTsUxDJJEKpSz/EIClH8goKiR81W/20
	 PY00YlqzvV9iQ==
From: KP Singh <kpsingh@kernel.org>
To: linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	James.Bottomley@HansenPartnership.com,
	paul@paul-moore.com,
	KP Singh <kpsingh@kernel.org>
Subject: [PATCH bpf-next 01/13] bpf: expose signature verdict to LSMs via bpf_prog_aux
Date: Fri, 22 May 2026 04:32:21 +0200
Message-ID: <20260522023234.3778588-2-kpsingh@kernel.org>
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

BPF_PROG_LOAD verifies the loader signature but does not record the
outcome on the prog. LSMs and audit can read attr->signature and
attr->keyring_id to infer "was this signed, against which keyring",
but there is no canonical state for "loader signature + map content
verified". Only the in-kernel kfunc can confirm the latter.

Add prog->aux->sig (verdict + keyring) and prog->aux->is_kernel,
populated by bpf_prog_load before the LSM hook. Failed verifications
reject the load before the hook runs, so it observes only UNSIGNED
or OK. The bpf_loader_verify_metadata kfunc promotes to
METADATA_VERIFIED later.

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 include/linux/bpf.h  | 19 +++++++++++++++++++
 kernel/bpf/syscall.c | 20 ++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 11bec73db199..14f65259f414 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1656,6 +1656,20 @@ struct bpf_stream_stage {
 	int len;
 };
 
+enum bpf_sig_verdict {
+	BPF_SIG_UNSIGNED = 0,
+	BPF_SIG_OK,                  /* loader signature verified */
+	BPF_SIG_METADATA_VERIFIED,   /* loader signature + map content verified */
+};
+
+enum bpf_sig_keyring {
+	BPF_SIG_KEYRING_NONE = 0,
+	BPF_SIG_KEYRING_BUILTIN,
+	BPF_SIG_KEYRING_SECONDARY,
+	BPF_SIG_KEYRING_PLATFORM,
+	BPF_SIG_KEYRING_USER,
+};
+
 struct bpf_prog_aux {
 	atomic64_t refcnt;
 	u32 used_map_cnt;
@@ -1698,6 +1712,11 @@ struct bpf_prog_aux {
 	bool changes_pkt_data;
 	bool might_sleep;
 	bool kprobe_write_ctx;
+	struct {
+		u8 verdict;
+		u8 keyring;
+	} sig;
+	bool is_kernel;
 	u64 prog_array_member_cnt; /* counts how many times as member of prog_array */
 	struct mutex ext_mutex; /* mutex for is_extended and prog_array_member_cnt */
 	struct bpf_arena *arena;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 630d530782fe..51fe8d77bb39 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2798,6 +2798,20 @@ static bool is_perfmon_prog_type(enum bpf_prog_type prog_type)
 	}
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
 static int bpf_prog_verify_signature(struct bpf_prog *prog, union bpf_attr *attr,
 				     bool is_kernel)
 {
@@ -3027,7 +3041,13 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 		err = bpf_prog_verify_signature(prog, attr, uattr.is_kernel);
 		if (err)
 			goto free_prog;
+		prog->aux->sig.verdict  = BPF_SIG_OK;
+		prog->aux->sig.keyring = bpf_classify_keyring(attr->keyring_id);
+	} else {
+		prog->aux->sig.verdict  = BPF_SIG_UNSIGNED;
+		prog->aux->sig.keyring = BPF_SIG_KEYRING_NONE;
 	}
+	prog->aux->is_kernel = uattr.is_kernel;
 
 	prog->orig_prog = NULL;
 	prog->jited = 0;
-- 
2.53.0

