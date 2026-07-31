Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD3121255A
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 02:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785464475; cv=none; b=C78tZGLBdkfxK3d4vLolwaabVTbfEh3ElKfFwVfqiXsn1dsLvWOi9fDUbiuSFyaPwjIXDbju2/EhIE1Lw+eZ7kYFS+EePdaRy3SRDE542jkvBl8jdCMiyaNOObQTIpv3Oyc4bfwZF+30GntoWXxK9FXdlM1HaKXZOSVTsQQUSFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785464475; c=relaxed/simple;
	bh=JVIUapt3mXax8Zzvl5moEskJgWAHSXq0LtxR/fnDvOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nlQvBmvoAINQyLWwm5KTTMag8w1OC7NP10ZXjpnwqo0/uX0WPo8c9Cw1WOp/Im2fJEnDvKXqRNaBDZZc+DV7pbPi3LPDpvTP+FtyFpqEFsqlyzOteMb1cT0qv+w/jw4xTLxMgHEiqDdlobRUn0RgFGwWQl+id/BLCABVTkSP3ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iVnaw4OA; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVnaw4OA"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8111c0c7561so5996487b3.3
        for <linux-security-module@vger.kernel.org>; Thu, 30 Jul 2026 19:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785464473; x=1786069273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kln/oJiLAaRdTDOdng8Bb4F+q8mG/4pvdPDoCAUkB+k=;
        b=iVnaw4OARcyiwp17xlfVt4+M0Qln/nWfZh3V6PdoyeJDARWkLDsbBYfRGIXcR6/SDL
         d3x6lGmVgS42X8j5BvBW1rdFFjjSaDuHDEqczFPyQtlwB6PdXabQALbplYiEZWb0syAH
         wi0/qJ3m+QJOEWDEEIOvQ/lp9YSwK4ngN6bJqJ2swcD/8oaAWoPKRgE0yOgoaH1RVvPn
         HpfeG4z1tzlUc+447NhYmr3pAyEpXy96ft19d7JIe9XXUvmICg6AS2BRY/upe4WsjoUI
         tJz4C9CXOUMd63rLrGC7llWWpTW+ZO0XPx/rQhZ0C0+JEqXn5LTFkK1jzvvG2S170w56
         Zu6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785464473; x=1786069273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kln/oJiLAaRdTDOdng8Bb4F+q8mG/4pvdPDoCAUkB+k=;
        b=ID5MQQWv+zNwI/5eCKmOcCVy7pIozVBMdPOmLD/D2ztJguTCrV/JMRnPzkVIswaHro
         HFu1MuLWUZcYIF1eIzGDbfbwEZ+2ZEYExgk7Pyl+wgRowzXjE7dltOK7/X6yw9aBC4SJ
         3V6g3B9YSxKan+0uL29nfFsuHSUUntZNhNxlWRimecYmDLI/lGIuWBdlinJ9oKpYlxEz
         PPewKM3M5Yb3rBJLZzDPjwaAt9EPob1pSCW6EvFDSnsYstbob4wXytsDEM21QMf29rM3
         f20F5o4uIlm5R842MNOCGNz0MSRY8o8Ci+9MNxtWzYXSrtWHYVgVBlVu5V1GNTAZyjWb
         xH7g==
X-Forwarded-Encrypted: i=1; AHgh+RoLzgbqTRrmZDYx73gCVDzR47NUPvS7/BkUZASYWtWj6WhPSoEIisite+TnDesui50UtqW2Q1CeEVskpXrSrt5Q69qxc9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQUKODQ0m3bTYXGrDOtL7QYAAKM6TCEKoU/6HXTQqaUenlFvtw
	SuR4Wi9tI0hyBlEAs4fKWTnHakpVFFe3YdKwCu5XE1wU8kGLPmGl026t
X-Gm-Gg: AR+sD13Fn3cBVP25UAMiKCUEL99Cl2zvj60NnmilbM41o20UKCewM8J9EWw/fAP6M1p
	sOQMbv5GFKzOeiTfmUke4IJTRdDBXpacheCfHqoFmCgTaiRUB5kUslbfXSdpkb5gr5ITIONLAG/
	m2yju8ddGNIobeVcWkAKb6BTKkbSqKGCEwPu2lPvBFDhiCWdRl+zOcoIIftCQ5cVo3GpxdIXOBr
	4ziUUHg0BOVINWb6BK6EbuX1gZtRUfafWPv7wNfkKIkYDNHw9Zb0U9STiAytfqMxotudWAi4lIk
	wII4Pes2CBuWuR6yU83fVDsViBlv2qCht7bb7OFKvbhjdLtaB/3GWSYX691nf9Q5m4/MabO6Kil
	1M4Xn/MMXshUsHAeBWmPa6nlBbFfGVu3z97eXAz4oVSFSusGcHgDSBxfTsXS7eh3pq8eJ4keMgN
	soUGCmnmkJIAhPwHwKdYFOp3YsuZQDZ83tfjZwiTxv3+8bb7WZZbypligfcxF4L7aLWl2Su92pM
	ASyHfSXKqxXeSkqO9Pj2w==
X-Received: by 2002:a05:690c:9981:b0:81e:8a24:d5fe with SMTP id 00721157ae682-81fcb9727a2mr778437b3.2.1785464472839;
        Thu, 30 Jul 2026 19:21:12 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:e94:8a83:feea:6720])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fb8b26e8bsm20519047b3.47.2026.07.30.19.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 19:21:12 -0700 (PDT)
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
Subject: [PATCH bpf-next 01/13] lsm: Add LSM hook security_policy_kptr_from_fd
Date: Thu, 30 Jul 2026 22:20:34 -0400
Message-ID: <20260731022047.189137-2-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260731022047.189137-1-utilityemal77@gmail.com>
References: <20260731022047.189137-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a generic LSM hook handing out a reference to an LSM policy
object on behalf of a kernel-internal caller:

  security_policy_kptr_from_fd(lsmid, fd, &policy)

together with union lsm_policy_kptr, the tagged payload carrying such
a reference across the LSM boundary.

The union holds one per-LSM member; which member is valid is
determined by the lsmid the caller passes.  The pointers the
members hold are the BTF-visible handles whose provenance the BPF
verifier guarantees, i.e. referenced kptrs, hence the hook naming:
the reference stays strongly typed from the BPF program through the
hook to the owning LSM, which resolves the handle to its internal
policy representation.

This hook backs BPF kfuncs: it lets an LSM hand out a reference to
one of its policy objects (identified by a file descriptor created
through the LSM's own userspace API) without exporting any symbol or
defining any BPF interface itself.  The reference is released
through security_policy_kptr_put(), added by the next patch.

The hook uses targeted dispatch: the shim walks the hook list and only
calls the implementation registered by the LSM matching @lsmid,
following the security_getprocattr()/security_setprocattr() patterns
for generic hooks carrying LSM-specific payloads.  When no active LSM
matches, the shim returns -EOPNOTSUPP: a kfunc call for an LSM that is
compiled out or not enabled fails at runtime rather than being hidden
from the BPF program at verification time.  For the same reason the
union members are not guarded by the LSMs' CONFIG options: the
callers are built independently of any individual LSM.

The hook is excluded from the "bpf" LSM's attachment points.  The
targeted dispatch would only reach a program attached there for calls
with LSM_ID_BPF, which no caller passes, so the attachment point would
be dead.

Cc: Paul Moore <paul@paul-moore.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---

Notes:
    The hook naming choice of policy_kptr_from_fd and the other
    hooks is up in the air for me. I decided to include the kptr
    part in the name because it's relevant to the task being
    performed: we are simply getting a pointer to a kernel policy
    object from a file descriptor.
    
    I'm open to better ideas for the name...

 include/linux/lsm_hook_defs.h |  2 ++
 include/linux/security.h      | 25 +++++++++++++++++++++++
 kernel/bpf/bpf_lsm.c          |  1 +
 security/security.c           | 38 +++++++++++++++++++++++++++++++++++
 4 files changed, 66 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 65c9609ec207..afd5b3f932a9 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -452,6 +452,8 @@ LSM_HOOK(int, 0, bpf_token_create, struct bpf_token *token, union bpf_attr *attr
 LSM_HOOK(void, LSM_RET_VOID, bpf_token_free, struct bpf_token *token)
 LSM_HOOK(int, 0, bpf_token_cmd, const struct bpf_token *token, enum bpf_cmd cmd)
 LSM_HOOK(int, 0, bpf_token_capable, const struct bpf_token *token, int cap)
+LSM_HOOK(int, -EOPNOTSUPP, policy_kptr_from_fd, int fd,
+	 union lsm_policy_kptr *policy)
 #endif /* CONFIG_BPF_SYSCALL */
 
 LSM_HOOK(int, 0, locked_down, enum lockdown_reason what)
diff --git a/include/linux/security.h b/include/linux/security.h
index 153e9043058f..db807e61d310 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -168,6 +168,23 @@ struct lsm_prop {
 	struct lsm_prop_bpf bpf;
 };
 
+struct bpf_landlock_ruleset;
+
+struct lsm_policy_landlock {
+	struct bpf_landlock_ruleset *ruleset;
+};
+
+/*
+ * A reference to an LSM policy object, tagged by the LSM_ID_* value
+ * passed alongside: only the matching LSM's member is valid.  The
+ * members are not guarded by the LSMs' CONFIG options: the callers
+ * are built independently of any individual LSM and a call for a
+ * missing LSM must fail at runtime, not at build time.
+ */
+union lsm_policy_kptr {
+	struct lsm_policy_landlock landlock;
+};
+
 extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1];
 
 /* These functions are in security/commoncap.c */
@@ -2312,6 +2329,8 @@ extern int security_bpf_token_create(struct bpf_token *token, union bpf_attr *at
 extern void security_bpf_token_free(struct bpf_token *token);
 extern int security_bpf_token_cmd(const struct bpf_token *token, enum bpf_cmd cmd);
 extern int security_bpf_token_capable(const struct bpf_token *token, int cap);
+extern int security_policy_kptr_from_fd(u64 lsmid, int fd,
+					union lsm_policy_kptr *policy);
 #else
 static inline int security_bpf(int cmd, union bpf_attr *attr,
 			       unsigned int size, bool kernel)
@@ -2365,6 +2384,12 @@ static inline int security_bpf_token_capable(const struct bpf_token *token, int
 {
 	return 0;
 }
+
+static inline int security_policy_kptr_from_fd(u64 lsmid, int fd,
+					       union lsm_policy_kptr *policy)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_SECURITY */
 #endif /* CONFIG_BPF_SYSCALL */
 
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 3983b4ce73c8..9fa514204fb5 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -56,6 +56,7 @@ BTF_ID(func, bpf_lsm_xfrm_decode_session)
 #endif
 BTF_ID(func, bpf_lsm_ismaclabel)
 BTF_ID(func, bpf_lsm_file_alloc_security)
+BTF_ID(func, bpf_lsm_policy_kptr_from_fd)
 BTF_SET_END(bpf_lsm_disabled_hooks)
 
 /* List of LSM hooks that should operate on 'current' cgroup regardless
diff --git a/security/security.c b/security/security.c
index 71aea8fdf014..14fd8b878cd0 100644
--- a/security/security.c
+++ b/security/security.c
@@ -5441,6 +5441,44 @@ int security_bpf_token_capable(const struct bpf_token *token, int cap)
 	return call_int_hook(bpf_token_capable, token, cap);
 }
 
+/**
+ * security_policy_kptr_from_fd() - Get an LSM policy object from a fd
+ * @lsmid: LSM_ID_* value of the LSM asked to interpret @fd
+ * @fd: file descriptor referring to a policy object, resolved in the
+ *      calling task's file descriptor table
+ * @policy: receives the referenced policy object in the member of the
+ *          LSM identified by @lsmid
+ *
+ * Ask the LSM identified by @lsmid to translate @fd into a reference
+ * counted policy object.  The caller must not dereference the
+ * returned handle, must only hand it back to the same LSM, e.g.
+ * through security_bprm_enforce_policy_kptr(), and must release it
+ * with security_policy_kptr_put().  Only the hook implementation of
+ * the LSM identified by @lsmid is called.  The hook is only called
+ * from a context that may sleep.
+ *
+ * An implementation must fill its own member of @policy with a
+ * reference that remains valid until it is released through the
+ * policy_kptr_put hook, and must not assume anything about @fd beyond
+ * what its own userspace API created it with.
+ *
+ * Return: Returns 0 if @policy holds a reference counted policy
+ * object, -EOPNOTSUPP if the LSM does not implement the hook, negative
+ * values on other failures.
+ */
+int security_policy_kptr_from_fd(u64 lsmid, int fd,
+				 union lsm_policy_kptr *policy)
+{
+	struct lsm_static_call *scall;
+
+	lsm_for_each_hook(scall, policy_kptr_from_fd) {
+		if (scall->hl->lsmid->id != lsmid)
+			continue;
+		return scall->hl->hook.policy_kptr_from_fd(fd, policy);
+	}
+	return LSM_RET_DEFAULT(policy_kptr_from_fd);
+}
+
 /**
  * security_bpf_map_free() - Free a bpf map's LSM blob
  * @map: bpf map
-- 
2.54.0

