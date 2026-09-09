Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70463C1961
	for <linux-security-module@vger.kernel.org>; Wed,  9 Sep 2026 19:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788982663; cv=none; b=G+/Y7JDjSNYQ+MccoikNJUtxT1FGzMEYAoFn6XGhM9ACBRRmSv+Kc1B/4sG/37mM5RNbXM/NkaPv5SLC1T/LzidYmoPjOqRirYn6pnWt84dLUqja+Hjy7sQIk+kkVXzhGILxKCA7TWrozEW63/k87gxYJjqnB2aK6bx4SehFMUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788982663; c=relaxed/simple;
	bh=UJsvgSwI/yDoGvCnBHSm45ONH9EJW/+m6j0M3SFXO1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cfpfdGVtChCjJkVZmEtRQXB5/+9Gjz7vAfrTHvZUstv+QAaTWxp94FnXIwF3voyS1RAyDixuEYwm112RQqVfLMdVCr95WHg+uxrnW8I/uIIxXBmhWWeLQNZXuhPsta85WJXcjAnPLXuqGL3hlPqFuXvlefmDH4FcN60sTD1dyqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jSq6klI/; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSq6klI/"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-86cba60d4f2so48975277b3.1
        for <linux-security-module@vger.kernel.org>; Wed, 09 Sep 2026 12:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788982660; x=1789587460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bDAYkmuiKuVgFzeoHlRDXquGRrGJTz+CZkotRusPofE=;
        b=jSq6klI/FnOeO8ChMRiRfjLJQ8OnNjnNQtUHoQLorKMQn6AbkZHXWZ0pIsEQRBA9zJ
         D7gFvtm3bqCOcQXN0spoSW4PYST5DqE/HeAkh5SHXfhOhRvNF+efREK0pVpo+VIuaHbG
         6cYZ/3HCrDEXwSnJ3ni7NGkMj/MnsgNBl4joVWw20bq/7fWRJCDQAu9HtHH058UdAgqU
         VmNS1pT240snKUlDJe8lGM0QLNunYGy6DwRjb++rs0WkwUFSGwVSTG5ZoZByN7zUJqHb
         MJA6aVrh0v9FJb/7u1/Qx95VmEfQft3+gtpPlkq0Kfvk8b3wRB7yHKM1qfT9R6C3/N4Q
         AKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788982660; x=1789587460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bDAYkmuiKuVgFzeoHlRDXquGRrGJTz+CZkotRusPofE=;
        b=BYSPKAuJUMjEMf+R4pRFF+XSiAxrg5Y7HSqaMv+XTFPzg5kgBLXri9Iuws+w19tRne
         WouuiIN+NyZTbwtX5ZKg2d3rXGeovoEi4M8SJxj781DLruWoTSNgD8cJhz/Zwd5x6d/l
         I8PcY/4syx3mj1vzUPalH6O/n84Y7TthTikA8Wa3wK3UvTpuvyKV32KMVj5JTPps8onp
         VPo3nfKt9Y5KXj46fQB9JZwqgY4MnVludGsNR5OFrJk8006uY+12/tT87EejKCZeGixP
         8aFcCSepgR6Qc4/pGM8l3lnCiXyq/e3CWUpw9/J9aENCSgDo3QZmUEYjxELcaZftAVVd
         KpoA==
X-Forwarded-Encrypted: i=1; AKwUvBxuWLgkhmKN1ysX5Q2DAL+++aWTvUjIi5/ZwBg1nPoba5lFGPR6Dms7zfBaaNFqIPWHhoRZA7AQdVlnfJiR+iu/A/P01l0=@vger.kernel.org
X-Gm-Message-State: AFuF++lEQBGR2uL4bMLk9ykOGMRQKuUriEkkEVt07cnnypuAMUfqBGwr
	g2TqbiNzCtjwvWpf46vgYeUYRY96qXx2Uw6zTJ38YOt6JNq00L1/3Wcn
X-Gm-Gg: AYBFou3am17A0K1hvpYKE9Z2CtXWwo2DZ26CNdym3BlUydsDrGFebbdUiIMxN64yEFl
	TvbOjq2DTOcgWRgNGIF4Sex14y60eThWIR4O7PVf8bK05JJCnYtM5bczftQrGQ6eRhbNg8WQ/nO
	Q49ZF6D/h2TbplqbNW80DHM16NJV95Z2MwlWBbCNiEnti8HUYhInuxpCfeF7HHg/+z3ClZuvL3D
	ZNj3iGJlLyxMBA9/2PmPgoXob6+lPVZMqn9bWkc382tKKFiPGafIyMhyjI16761n19CkonE3NAW
	GWwBC3e3oh2DMqH7E16Ysv9/3a4u0EeupZQGjLOwVixrmwCNjtR+NrpQPusvRQ+ckS4b33Olljs
	PFLeuX2Oxgz7TpshUPGb/NjleF+NGBau+uGTBEC+UrPCRI6Oqp3PAaznujPp48YxSAl6UOozP+Y
	7Z9Am4DbIgVE+x6KTIug1hJrKc9N3geCG80EGVCwLSp1ZwSLKGWQl/Wve9daas7Z5uoYkm6TT+j
	iC/hX9XToQpmvBazu5Vwa1rHjp0Fo9MaS//kn56wm4=
X-Received: by 2002:a05:690c:6a01:b0:81e:abe2:9a3b with SMTP id 00721157ae682-8712314032cmr152621237b3.10.1788982660585;
        Wed, 09 Sep 2026 12:37:40 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:bae:bfc2:7e96:e5c8])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-871493155d3sm115277577b3.16.2026.09.09.12.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 12:37:40 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kpsingh@kernel.org,
	matt@bobrowski.net,
	paul@paul-moore.com,
	mic@digikod.net,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	kees@kernel.org
Cc: casey@schaufler-ca.com,
	gnoack@google.com,
	jack@suse.cz,
	song@kernel.org,
	yonghong.song@linux.dev,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	jolsa@kernel.org,
	m@maowtm.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH bpf-next v3 01/15] lsm: Add the LSM policy object lifetime hooks
Date: Wed,  9 Sep 2026 15:37:04 -0400
Message-ID: <20260909193719.518517-2-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909193719.518517-1-utilityemal77@gmail.com>
References: <20260909193719.518517-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add struct lsm_policy_object, the identity an LSM embeds in a policy
object it shares with BPF programs, and the three hooks managing such
an object's lifetime:

  policy_object_from_fd(fd, &object)
  policy_object_get(object)
  policy_object_put(object)

The object records the owning LSM's LSM_ID_* value.  The BPF kfuncs
built on these hooks dispatch each call on an object to the one LSM
matching its lsmid, which resolves the containing object with
container_of(); the framework never interprets an object beyond its
lsmid.  The type field discriminates between the owning LSM's own
policy object kinds and is private to it, with 0 reserved as "unset"
so a zeroed, untagged object fails every type check.

from_fd has no object to route by: the fd refers to a file set up
through the owning LSM's own userspace interface, so the fd itself
identifies its LSM.  The framework offers the fd to every
implementation in turn; an LSM declines a fd that is not one of its
policy objects with -EOPNOTSUPP, and any other error is a definitive
translation failure.

The hooks back referenced BPF kptrs, which imposes the same lifetime
contract on every implementation: from_fd returns a reference on a
live object, get acquires with inc-not-zero semantics and fails with
-ENOENT once the count dropped to zero, put may be called from
contexts that cannot sleep (BPF drives it from map destructors), and
the containing object is freed only after an RCU grace period, as
programs load policy object kptrs from maps under RCU and may examine
an object concurrently with its last put.

The hooks are excluded from the "bpf" LSM's attachment points.  The
object-routed hooks are unreachable there, as LSM_ID_BPF policy
objects cannot exist; for from_fd, whose walk visits every
implementation, a BPF program cannot fill the object out parameter,
so an attachment returning 0 would hand the caller an uninitialized
pointer.

Cc: Paul Moore <paul@paul-moore.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---

Notes:
    v2->v3:
        - No change.

 include/linux/lsm_hook_defs.h |  4 ++++
 include/linux/security.h      | 11 +++++++++++
 kernel/bpf/bpf_lsm.c          |  3 +++
 3 files changed, 18 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 65c9609ec207..d7684407737a 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -452,6 +452,10 @@ LSM_HOOK(int, 0, bpf_token_create, struct bpf_token *token, union bpf_attr *attr
 LSM_HOOK(void, LSM_RET_VOID, bpf_token_free, struct bpf_token *token)
 LSM_HOOK(int, 0, bpf_token_cmd, const struct bpf_token *token, enum bpf_cmd cmd)
 LSM_HOOK(int, 0, bpf_token_capable, const struct bpf_token *token, int cap)
+LSM_HOOK(int, -EOPNOTSUPP, policy_object_from_fd, int fd,
+	 struct lsm_policy_object **object)
+LSM_HOOK(int, -EOPNOTSUPP, policy_object_get, struct lsm_policy_object *object)
+LSM_HOOK(void, LSM_RET_VOID, policy_object_put, struct lsm_policy_object *object)
 #endif /* CONFIG_BPF_SYSCALL */
 
 LSM_HOOK(int, 0, locked_down, enum lockdown_reason what)
diff --git a/include/linux/security.h b/include/linux/security.h
index 153e9043058f..5e423bea080e 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -168,6 +168,17 @@ struct lsm_prop {
 	struct lsm_prop_bpf bpf;
 };
 
+/*
+ * Identity of a policy object an LSM shares with BPF programs,
+ * embedded in the LSM's own object.  @lsmid identifies the owning
+ * LSM; @type discriminates that LSM's policy object types, with 0
+ * reserved as "unset".
+ */
+struct lsm_policy_object {
+	u64 lsmid;
+	u32 type;
+};
+
 extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1];
 
 /* These functions are in security/commoncap.c */
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 82c5988417a0..f762cac6838b 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -56,6 +56,9 @@ BTF_ID(func, bpf_lsm_xfrm_decode_session)
 #endif
 BTF_ID(func, bpf_lsm_ismaclabel)
 BTF_ID(func, bpf_lsm_file_alloc_security)
+BTF_ID(func, bpf_lsm_policy_object_from_fd)
+BTF_ID(func, bpf_lsm_policy_object_get)
+BTF_ID(func, bpf_lsm_policy_object_put)
 BTF_SET_END(bpf_lsm_disabled_hooks)
 
 /* List of LSM hooks that should operate on 'current' cgroup regardless
-- 
2.55.0

