Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4243B4A4C38
	for <linux-security-module@vger.kernel.org>; Mon, 31 Aug 2026 14:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188385; cv=none; b=A5ogUsAoMr2W/FlIc1WAe2SS9DCJ33Bzl3/M3zEnzYMY8FNgtUh3+ByWiuF95qXmHGHoZL2u8iHsdsyExhjUC3yjE1tHQ+ZY1zgnwbdxzXkYoYyyqgKf3LBDXHvbbgj5NowDSXgPaZHH93XMcPl5coozZ/X7J7vwZGxhCIDev90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188385; c=relaxed/simple;
	bh=87J7Hy9oybrEQ8VoZHjr4Dl0KQ9+NG/q3OT8MdhIFgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GtEOqqktj5QzaUikfGOgcZSO9uRD3UX8gtjtGOI4lNmxHsVEptv0LjIBDem7ql6y6AgvB3+0B8pNG+uljhUDzjYZS4JYmh39rNg7djfOSgnf9IOf3CWR0TXGGy8908iELOVZVF3CkqklLiMXUX3rUw2OleEEkODuTlXgP1NzUOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zi2w2VQ6; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zi2w2VQ6"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-85dbc24d398so29721037b3.2
        for <linux-security-module@vger.kernel.org>; Mon, 31 Aug 2026 07:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788188383; x=1788793183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mg1kKbDlTHOBJYnbAI3hLPf56gY3s9FmGuWH1KCaD1k=;
        b=Zi2w2VQ6xP3dTX57tl7ETXF19+gE7d6zgWqXy2oYWHdGXyWmJx5rOiHRLfzJSKy4gd
         FbvQOtBgzeduQQhaikTHfz7n4XOiQtLoIzFiOaRhQ+p4vYOsvqnW1woF9YarkPG1I0/K
         isxXbPMRtgJConu8CKWgn819sE3+9bjDUSHQyNAb20/SVMZfS8dfV6NDXxz5FJ/7C8Oz
         C5m44rbloUA3Jbzdw8ja/3Y6l2fXYfNQteAWZ8DfgtAm/IlTaYM8RulXdQcrcb2hccfT
         kambp5tNIFWg49Q2iYaSmlLZ/UHXFGcsjujpj3795gHh4J15FEB2MLrrzTkkSSC/vbpt
         FGxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788188383; x=1788793183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mg1kKbDlTHOBJYnbAI3hLPf56gY3s9FmGuWH1KCaD1k=;
        b=gSB5tuEIo2q76XAeaT0GZyNPs5yBb8LTc/5A+1Q1Uabu/HY/dYTnAt+xBd66jsYPWV
         HdkPbIPtZUK4yFQZ0UZY8QqGX0OlQSSOBKnBfaTNQ0wNAx8uDOGiCPP/VQBl2k2VzQM5
         3EOrn8rnS+9EDGLTFfGGa6edzbCRTLm6NNRXQg7LaeKyC3ppjgY9wwO6vV5nSI5KTano
         Wje92l9L7OcgjTE/qUJH2QhWs55hqOl+HebBVEYLfjzrl1hKYDfplITtT+Em7saf/obN
         Gr//1brTU30Lbcnsta41bpAYKgLnbJlxgFuLJ/+WNjcpSs7G6WtKQfdYoby8d3Td6fZg
         hzdQ==
X-Forwarded-Encrypted: i=1; AKwUvBwUrsZoUMyy0wVb5Abf7lVM4Cckj8uGm74rtsVJkh9p9y0TXwJEBrnBO9ZjhftMfFetev2Tdz8kDqGcZXYkZqGn8kj3Or4=@vger.kernel.org
X-Gm-Message-State: AFuF++luSFBv1FY5B5IajdlrmGi/toBV5S51LaryrLFxzgf6gF6dYAXG
	7YDPy3q9+T7mS/AG6roajZMLqAXg+O+ritwJW3AGhEsXBCuxaUvgtGJC
X-Gm-Gg: AYBFou2PXZb7PtmpDHkxwhUOt2TJ3+WLuPwkbyoagN+3zPGwP+IcvqFDfj/YZDUZQg/
	bAxD2ShzjjlLmNOykskUExIdqRXrVH2Of/Dv8pdYWjNx548WTxSpIP9m96cn0r/xNAIHZqPzjVV
	q+Ax9tjrQ5qwo0+OhwchDGx3EheX0YvEVSZo1zSBOPqOFHsv1Elnp6hNBxETN0PQpbN2EmTqVtB
	GyvDELv9yF77troEYE1I9xN5q1Au8J2tvWpk5OqTN42dPYxy9aB3INeyTsnBgHY90op+u+xQXl9
	zYX0gAjHtGh8Xfg9ca31eOvdwQHMEI+n0077ww5YseorFtVAe0qo7UQLp65jLA6xQqeXUu14IM7
	8B6yyq6t8eKrm189EaqjIgcU2on9DXwUOiRzJQ7KiZSNuR6sHzhHQYgIDV+sNKYxbLfdYjkVyIu
	pfhqr5ngOZZqdivmd9Pc8RKkSXLjrumCPFn/wXTVsztFDPnF1WjBRM+XedVbrtoDlfNG4lImgN2
	iziTWJGnWV6kfOGhaDKUgg=
X-Received: by 2002:a05:690c:4005:b0:856:98e2:6e9b with SMTP id 00721157ae682-85d69640f36mr78852557b3.5.1788188383108;
        Mon, 31 Aug 2026 07:59:43 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:f6fc:b424:b1bb:6ff0])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e58666e15sm53903827b3.0.2026.08.31.07.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 07:59:42 -0700 (PDT)
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
	song@kernel.org,
	yonghong.song@linux.dev,
	martin.lau@linux.dev,
	m@maowtm.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>,
	Casey Schaufler <casey@schaufler-ca.com>
Subject: [PATCH v2 01/15] lsm: Add the LSM policy object lifetime hooks
Date: Mon, 31 Aug 2026 10:58:43 -0400
Message-ID: <20260831145858.3869191-2-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831145858.3869191-1-utilityemal77@gmail.com>
References: <20260831145858.3869191-1-utilityemal77@gmail.com>
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
index 1433809bb166..d06744d72e04 100644
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

