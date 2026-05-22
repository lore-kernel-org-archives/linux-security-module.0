Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9801F32B112;
	Fri, 22 May 2026 02:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779417176; cv=none; b=XGFrS0BjiEmhcFXv5VNkiFoKMOac7oLVhIulL4IxoUITaSw42j63yvmTR6lTBSk9dJ+5weA4Uvu0HRqD8jCMUq0OzssfdrFCZpeZthJAMzGhGp6RYDHg2wGTEVAAbh6ZhxGYx+0sQmPEJSpGMl6K8FNQXxR3JntryV2jiYsZh5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779417176; c=relaxed/simple;
	bh=/Sx61ZXSz8jm3mSgv9G4SCFX0wYElsShc6KXlUI3A/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bA9kq/5zsXTD8E/MogUhKn2XZ2vsCN62WvRpVQLKs6RlX14YOCls819ElISLizK6YWxusaNo7Oxv8ibqVr5IAuVF/h5nbtTW3lgEUtKtXcv3KLpVrUv57glFcF2bdarMwL3Zc1NnyO3ERL+jmBsZNfGxFTutFVMw6iHtwpmG++g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9ztG1rX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9ztG1rX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B67971F00A3D;
	Fri, 22 May 2026 02:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779417175;
	bh=fbbiK9WrxdGtldBg4TnhmAMV6V67w0jn6+7nUQX7l1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S9ztG1rXoYZighA+DqDpGulJFCTjjSPdFjli8x7MzmfSeC019vW3D4WQmNiBsT7Ij
	 n5ny9+ATMFb1itQ6tg53AbS1UeBUfTwqXl4nHwscWYz0HMBV8h9JkRPmdUkA383HQ4
	 mSGim1Zvkx9guhMcV2YHBGrWgnfHlmTCTAVYTKtPhnl42USXx0oCBvUb3g69WCMZoi
	 tjB346lU7ngPB2rLpjuKO5zOKWo3scaRgDDsIinnoMSIKsQkJprcwxPj4L2qCcy0y+
	 1ZfU551Na3pfz2GmwOBjokWuYRkBljvJOcXzhYEYAJoshqG9yu9GZRyCY9E2U3Lyji
	 ckRjK8rnvdq4A==
From: KP Singh <kpsingh@kernel.org>
To: linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	James.Bottomley@HansenPartnership.com,
	paul@paul-moore.com,
	KP Singh <kpsingh@kernel.org>
Subject: [PATCH bpf-next 09/13] lsm: add bpf_prog_load_post_integrity hook
Date: Fri, 22 May 2026 04:32:29 +0200
Message-ID: <20260522023234.3778588-10-kpsingh@kernel.org>
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

Add a companion to security_bpf_prog_load. The existing hook fires
at PROG_LOAD entry where the verdict is at most BPF_SIG_OK; the new
hook fires from bpf_loader_verify_metadata after the in-kernel
metadata check, just before sig.verdict is promoted to
BPF_SIG_METADATA_VERIFIED. Policy LSMs that want to gate on
metadata verification (not just signature presence) register here.

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 include/linux/lsm_hook_defs.h |  1 +
 include/linux/security.h      |  6 ++++++
 security/security.c           | 17 +++++++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 2b8dfb35caed..c0e7899756d4 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -446,6 +446,7 @@ LSM_HOOK(int, 0, bpf_map_create, struct bpf_map *map, union bpf_attr *attr,
 LSM_HOOK(void, LSM_RET_VOID, bpf_map_free, struct bpf_map *map)
 LSM_HOOK(int, 0, bpf_prog_load, struct bpf_prog *prog, union bpf_attr *attr,
 	 struct bpf_token *token, bool kernel)
+LSM_HOOK(int, 0, bpf_prog_load_post_integrity, struct bpf_prog *prog)
 LSM_HOOK(void, LSM_RET_VOID, bpf_prog_free, struct bpf_prog *prog)
 LSM_HOOK(int, 0, bpf_token_create, struct bpf_token *token, union bpf_attr *attr,
 	 const struct path *path)
diff --git a/include/linux/security.h b/include/linux/security.h
index 41d7367cf403..3a8f2c50f7be 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -2305,6 +2305,7 @@ extern int security_bpf_map_create(struct bpf_map *map, union bpf_attr *attr,
 extern void security_bpf_map_free(struct bpf_map *map);
 extern int security_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr,
 				  struct bpf_token *token, bool kernel);
+extern int security_bpf_prog_load_post_integrity(struct bpf_prog *prog);
 extern void security_bpf_prog_free(struct bpf_prog *prog);
 extern int security_bpf_token_create(struct bpf_token *token, union bpf_attr *attr,
 				     const struct path *path);
@@ -2343,6 +2344,11 @@ static inline int security_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *
 	return 0;
 }
 
+static inline int security_bpf_prog_load_post_integrity(struct bpf_prog *prog)
+{
+	return 0;
+}
+
 static inline void security_bpf_prog_free(struct bpf_prog *prog)
 { }
 
diff --git a/security/security.c b/security/security.c
index 4e999f023651..05153e8496c9 100644
--- a/security/security.c
+++ b/security/security.c
@@ -5383,6 +5383,23 @@ int security_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr,
 	return rc;
 }
 
+/**
+ * security_bpf_prog_load_post_integrity() - Notify LSMs that a signed loader
+ * has just verified its metadata map.
+ * @prog: the loader BPF program whose metadata check passed.
+ *
+ * Invoked by bpf_loader_verify_metadata() after the kernel-side hash check
+ * succeeds, before prog->aux->sig_verdict is promoted to
+ * BPF_SIG_METADATA_VERIFIED. A non-zero return aborts the kfunc and leaves
+ * the verdict at BPF_SIG_OK.
+ *
+ * Return: 0 on success, negative errno to deny.
+ */
+int security_bpf_prog_load_post_integrity(struct bpf_prog *prog)
+{
+	return call_int_hook(bpf_prog_load_post_integrity, prog);
+}
+
 /**
  * security_bpf_token_create() - Check if creating of BPF token is allowed
  * @token: BPF token object
-- 
2.53.0

