Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BF037B41C
	for <linux-security-module@vger.kernel.org>; Tue,  7 Apr 2026 20:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775592146; cv=none; b=J7AeKUIgdp7F9p8Oj8fXMBWtJGWlymGkbrwZirax8azijwZlTHw5sHtg6zRvb/ZtJbDkPO7GMvppYK6dUDkm3rVVCTyZMztK6fU1Wkk/0fCoztK8KaRfsBeDRxWG5YQxYV7gZ+/JbIpvKiUg0eA6IqjyROV3gKZ+nHv+Aib209I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775592146; c=relaxed/simple;
	bh=Vsih0b+o/jg8UkqUGlmWwwA82DsXh+PPInY0bCs+d9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g1UeKm76b41wUAmj4GT8ac+hrL3ytTROPxbqJQey3/zpWMGOz4oxlOV8W1FzUdi3b3gUbzUYo0auhsLt+BdYubopd4Sa9LbRSPqA7GtO/yhbDDR+jTQmxD6/eoEM1GFjH+U9j8G4wHEO+vHRv3SO7SivI1DraI3ox93+SseJpFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ld7ijPzN; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ld7ijPzN"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-65003f40a22so2739782d50.2
        for <linux-security-module@vger.kernel.org>; Tue, 07 Apr 2026 13:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775592142; x=1776196942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OdNRllWWd15mEvEF9vUAARg/W2nP/JkoUMdUtCOL1a0=;
        b=ld7ijPzN6UwZa317Y+pOrcJPZLHllDYofuCiEtkh2WGlXHu7+66DI74qz/bVwYWrlD
         8xwxYBr94m9hNQTO0VWx/6r2zlI51BAXuiM4eBlH9exuAR/BKXnZuCtF2U7mWjJiCQ+u
         o9qBFlOyfJ5ZBHGQrxDlJhkXFlh8cZ6/J9psBZ9ODZAD1LAxy2Lm3gjFX3OWgTrJRufF
         Ke5MQt9E+srEUL1McBkZINq8vOZe2gUM16dABU31bK6VJQWOnUnZ7RNfq00jpUAjEmEh
         NrQr8M67os/5AKHOf22jEy1U0ImU6u2BBYm6t2D+qpejx4aPcvKxlzkbcBjMcOO/yBmm
         +RCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775592142; x=1776196942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OdNRllWWd15mEvEF9vUAARg/W2nP/JkoUMdUtCOL1a0=;
        b=VS8PtFBUveG2mzNPjrHUAMBESyal89fcj0L4I7rc1Sgs8gYyIR7nDPy75oe5dIB1tZ
         dsV0uvND0+Tj9TAPra5x7fDNdtLwBNHZ8C5wTegdW2OoHyVzLBtavZx/DLm77DcXtkxF
         aojG2VdbMw6l4eGqb4NbMwghmLvoZdmsATafffkrV8lb3TmmnegU0iHeDUKSuY03mXM4
         aK+tkKpOdZBYAmYtBWW1ahfPEI//kcPFbloMofI4IZrcXiMTpUIS+kQqCG0ubC18qIDY
         wS6W3olMDz0NhV4OvhuwZCKSVEF/uBDCUdKzDt3qNg9g0JfQr3wfWU5qtiB5KZRV7Pv2
         u3Ng==
X-Forwarded-Encrypted: i=1; AJvYcCUEfdqyPyIJ/56WcL2tw37qZRxyQLqxTVRNSC8Yt0RuVCOTVPUb857GNz5fUHK58FIY8Tp4nRWcmnX7zogZDQxvIPPOQdo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHfNzcyFT1qMcEp/ffoyVYMIeazJo50CAxpjynmDcSILIg46JV
	H68d5R3uCmIdjWBPieUdlx61A1i1vRrT/pHcgMlAtTUYHfEvPNkEayZ3
X-Gm-Gg: AeBDieuVvKxgKvJdkUvBxIqZmB4Quku21EqAQiy78Nyrg6lth/HJEh1OeIh8zQHqqpT
	+tfjdcR6V7hyW+G/G0aPMEdrtaWfMYKFwRyt2RSsiLG1+1E5VSi538j5EX/F9pjy4Rn7bogfylU
	vIuEtuA6uBnyJlvCyW67Nb6sKSg6avZNvf6eRSBf020N49Gg+UHuEvOVNfMklWg2cpxKe5fl2P0
	BS+gXaEtUGABEnJjcz4JwCY1MdLNtOLz/mfxh0DZ0TyTxlk9kVhAZZtbKmbQQr2+TVycZnrl5vS
	q0nLC45XSUrvo7hBA/nwt0JpPBxL5Vi0LFReDwW36mKOdEZsyZnaZu6F7Kf7yb+mkc6yHiDUvgo
	M0XtyxlVyc0ivcYfcHtwTzXQYDubpIy1rGDqUmPEpcrWBAB8jUf+iFx+3yCy4maM4b0ScLh3Uvw
	owH5aivI4aLvI43Y6ZfGPAqq6IYvoX19a0Yn3E5b78upxfI42Nq75vvcmnYFyeB3BWltwSP99q
X-Received: by 2002:a05:690e:1557:20b0:650:3a28:4359 with SMTP id 956f58d0204a3-65048745b32mr13895318d50.22.1775592142319;
        Tue, 07 Apr 2026 13:02:22 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:92f8:8594:e84e:1d9a])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a828f3csm8354078d50.3.2026.04.07.13.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 13:02:22 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kpsingh@kernel.org,
	paul@paul-moore.com,
	mic@digikod.net,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	kees@kernel.org
Cc: gnoack@google.com,
	jack@suse.cz,
	jmorris@namei.org,
	serge@hallyn.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	martin.lau@linux.dev,
	m@maowtm.org,
	eddyz87@gmail.com,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	skhan@linuxfoundation.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [RFC PATCH 06/20] bpf: lsm: Add Landlock kfuncs
Date: Tue,  7 Apr 2026 16:01:28 -0400
Message-ID: <20260407200157.3874806-7-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407200157.3874806-1-utilityemal77@gmail.com>
References: <20260407200157.3874806-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create 2 kfuncs exposing control over Landlock functionality to BPF
callers. Export an opaque struct bpf_landlock_ruleset preventing callers
from accessing unstable internal Landlock fields.

1) bpf_landlock_put_ruleset releases a reference on a bpf_landlock_ruleset.
This is properly passed to the verifier with the KF_RELEASE annotation.

2) bpf_landlock_restrict_binprm alters the pre-committed credentials in the
linux_binprm struct, ensuring the program will start with the specified
landlock ruleset. Normal domain inheritance, for existing and future
domains apply as normal.

To enable proper reference counting and destruction, a destructor is
registered for the bpf_landlock_ruleset.

Additionally, both kfuncs are restricted to LSM programs attached to
bprm_creds_for_exec or bprm_creds_from_file, and only sleepable varients
of these hooks. Landlock may block because a ruleset is protected by a
lock, so both of the above kfuncs may sleep and are KF_SLEEPABLE.

If RESTRICT_FLAGS_NO_NEW_PRIVS is set, and the task doesn't have
CAP_SYS_ADMIN or is not already running with no_new_privs, we set the
set_nnp_on_point_of_no_return to ensure that the next execution
transition (but not the current one) will be subject to no_new_privs.

Running task_set_no_new_privs directly is unsafe in this path, as a
failed execution will result in a lingering side effect of no_new_privs
being set on the original thread.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 include/linux/bpf_lsm.h |  15 +++++
 kernel/bpf/bpf_lsm.c    | 145 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 160 insertions(+)

diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
index 643809cc78c3..1fc019c0db44 100644
--- a/include/linux/bpf_lsm.h
+++ b/include/linux/bpf_lsm.h
@@ -31,6 +31,21 @@ int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
 bool bpf_lsm_is_sleepable_hook(u32 btf_id);
 bool bpf_lsm_is_trusted(const struct bpf_prog *prog);
 
+/*
+ * Opaque type for BPF landlock ruleset.  This is used to prevent BPF programs
+ * from directly accessing the landlock_ruleset structure, which is not designed
+ * for external use and may change in the future.
+ */
+struct bpf_landlock_ruleset {};
+BTF_ID_LIST_SINGLE(bpf_landlock_ruleset_btf_ids, struct, bpf_landlock_ruleset)
+__bpf_kfunc void
+bpf_landlock_put_ruleset(const struct bpf_landlock_ruleset *ruleset);
+__bpf_kfunc int
+bpf_landlock_restrict_binprm(struct linux_binprm *bprm,
+			     const struct bpf_landlock_ruleset *ruleset,
+			     u32 flags);
+__bpf_kfunc void bpf_landlock_put_ruleset_dtor(void *ruleset);
+
 static inline struct bpf_storage_blob *bpf_inode(
 	const struct inode *inode)
 {
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 0c4a0c8e6f70..5da9950aa555 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -16,6 +16,7 @@
 #include <linux/btf_ids.h>
 #include <linux/ima.h>
 #include <linux/bpf-cgroup.h>
+#include <linux/landlock.h>
 
 /* For every LSM hook that allows attachment of BPF programs, declare a nop
  * function where a BPF program can be attached. Notably, we qualify each with
@@ -447,3 +448,147 @@ int bpf_lsm_get_retval_range(const struct bpf_prog *prog,
 	}
 	return 0;
 }
+
+BTF_SET_START(bpf_landlock_kfunc_hooks)
+BTF_ID(func, bpf_lsm_bprm_creds_for_exec)
+BTF_ID(func, bpf_lsm_bprm_creds_from_file)
+BTF_SET_END(bpf_landlock_kfunc_hooks)
+
+BTF_KFUNCS_START(bpf_landlock_kfunc_btf_ids)
+BTF_ID_FLAGS(func, bpf_landlock_put_ruleset, KF_RELEASE | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_landlock_restrict_binprm, KF_SLEEPABLE)
+BTF_KFUNCS_END(bpf_landlock_kfunc_btf_ids)
+
+BTF_ID_LIST(bpf_landlock_dtor_ids)
+BTF_ID(struct, bpf_landlock_ruleset)
+BTF_ID(func, bpf_landlock_put_ruleset_dtor)
+
+static int bpf_landlock_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
+{
+	if (!btf_id_set8_contains(&bpf_landlock_kfunc_btf_ids, kfunc_id))
+		return 0;
+
+	/* BPF_LSM_CGROUP programs run under classic RCU and cannot sleep. */
+	if (prog->expected_attach_type == BPF_LSM_CGROUP)
+		return -EACCES;
+
+	if (!btf_id_set_contains(&bpf_landlock_kfunc_hooks,
+				 prog->aux->attach_btf_id))
+		return -EACCES;
+
+	return 0;
+}
+
+static const struct btf_kfunc_id_set bpf_landlock_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set = &bpf_landlock_kfunc_btf_ids,
+	.filter = bpf_landlock_kfunc_filter,
+};
+
+static int __init bpf_landlock_kfunc_init(void)
+{
+	const struct btf_id_dtor_kfunc bpf_landlock_dtors[] = {
+		{
+			.btf_id = bpf_landlock_dtor_ids[0],
+			.kfunc_btf_id = bpf_landlock_dtor_ids[1],
+		},
+	};
+	int ret;
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM,
+					&bpf_landlock_kfunc_set);
+	if (ret)
+		return ret;
+
+	return register_btf_id_dtor_kfuncs(bpf_landlock_dtors,
+					   ARRAY_SIZE(bpf_landlock_dtors),
+					   THIS_MODULE);
+}
+
+late_initcall(bpf_landlock_kfunc_init);
+
+__bpf_kfunc_start_defs();
+
+#if IS_ENABLED(CONFIG_SECURITY_LANDLOCK)
+
+/**
+ * bpf_landlock_put_ruleset - put a Landlock ruleset
+ * @ruleset: Landlock ruleset to put
+ */
+__bpf_kfunc void
+bpf_landlock_put_ruleset(const struct bpf_landlock_ruleset *ruleset)
+{
+	landlock_put_ruleset((struct landlock_ruleset *)ruleset);
+}
+
+/**
+ * bpf_landlock_restrict_binprm - enforce a Landlock ruleset on exec credentials
+ * @bprm: execution context providing the prepared credentials to restrict
+ * @ruleset: Landlock ruleset to enforce, may be NULL only with
+ *	LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF
+ * @flags: landlock_restrict_self() flags
+ *
+ * When @flags contains LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS, the request is
+ * staged through @bprm and committed only after exec reaches point-of-no-return.
+ * This guarantees that the resulting task cannot gain more privileges through
+ * later exec transitions, including when called from bprm_creds_from_file.
+ * The current execution is unaffected, and may escalate as usual until the next
+ * exec.
+ */
+__bpf_kfunc int
+bpf_landlock_restrict_binprm(struct linux_binprm *bprm,
+			     const struct bpf_landlock_ruleset *ruleset,
+			     u32 flags)
+{
+	int err = landlock_restrict_cred_precheck(flags, false);
+
+	if (err)
+		return err;
+
+	err = landlock_restrict_cred(bprm->cred,
+				     (struct landlock_ruleset *)ruleset,
+				     flags);
+
+	if (err)
+		return err;
+	/*
+	 * Stage no_new_privs through @bprm so exec can honor it without
+	 * mutating the current task before point-of-no-return.
+	 */
+	if ((flags & LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS)
+	    && !task_no_new_privs(current)
+	    && !ns_capable_noaudit(current_user_ns(), CAP_SYS_ADMIN))
+		bprm->set_nnp_on_point_of_no_return = 1;
+
+	return err;
+}
+
+/* We define stubs for these to allow ebpf programs using landlock kfuncs to load
+ * even when CONFIG_SECURITY_LANDLOCK is not enabled.
+ */
+#else /* IS_ENABLED(CONFIG_SECURITY_LANDLOCK) */
+
+__bpf_kfunc void
+bpf_landlock_put_ruleset(const struct bpf_landlock_ruleset *ruleset)
+{
+}
+
+__bpf_kfunc int
+bpf_landlock_restrict_binprm(struct linux_binprm *bprm,
+			     const struct bpf_landlock_ruleset *ruleset,
+			     u32 flags)
+{
+	return -EOPNOTSUPP;
+}
+
+#endif /* IS_ENABLED(CONFIG_SECURITY_LANDLOCK) */
+
+/* Destructor does nothing when Landlock is not enabled */
+__bpf_kfunc void bpf_landlock_put_ruleset_dtor(void *ruleset)
+{
+	bpf_landlock_put_ruleset(ruleset);
+}
+
+CFI_NOSEAL(bpf_landlock_put_ruleset_dtor);
+
+__bpf_kfunc_end_defs();
-- 
2.53.0

