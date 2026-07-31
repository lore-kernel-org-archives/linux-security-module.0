Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5466A33A9D6
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 02:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785464490; cv=none; b=bnF2MRIa9vU6vfbxaYokdL9/C55INo7qb8rCwrMCBsYsZBV/e3P85oQciBRAQahM0mOwgS605wIWTZDnxZ7D3upR1r6LS8XofzBd+daWdPY0AghfjRF3TmodORf0Y6Ebp4cactLpQKWhlnMYqeDZAM9/ZEGcyvPR/Ug5lGBug4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785464490; c=relaxed/simple;
	bh=8CZuZUF4yZqOhhlu7a9VfiLoBIOnNth3ho1a5v4N4nI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NcqHAbg2rTm62mWZxwaTpb0T02MkgBZ15lXBHi1+8oz4yJDGSO/B2vfizQI/uTTXy0/p1zUH8D0y28woZXGF76WKEXnhtzgUfeGqQMF6jMGi4qgo5yfeOR8CT1sCxPLVXiT0J/VujDozIro7vIPNuq2ldmIepE1m3JsdCzjUC/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j0+zv721; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0+zv721"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7ff05e5d009so6388477b3.1
        for <linux-security-module@vger.kernel.org>; Thu, 30 Jul 2026 19:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785464487; x=1786069287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pGCBiJwuFidm0XWVpVouPl8UKmEaO4aYAkoooI4m9uE=;
        b=j0+zv721AWeSEmTALkJ0kPOdOHyKhV9W34sTdS5GsT1Vgruk7Hz3ys5tFci0qYH0P9
         P36SFeQ1jxomG/Dvb2D81Lr+YLUh9oMO17ddIFKjH+0R5mRT5yQRKhtbQahodkXlU3BT
         KVXiulkhC7woioK3whqqHsoGSnquIppOYbHvyVekBp8fCzUhNc078XoX0ZjbCVEmtb2C
         J7l2S1pIuUFF/uMrLV5vWPf8gGCsjU/UQ8PpMAYMriqRQfMQza+V1c/LdsSo9AGDMyMX
         zz84w6gcjZ96Rk5wxvqyzl3IoKC2mxl6QiT8yCqBXMjojEtYTh9O7kC+5gKFFTj6HJXZ
         0kAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785464487; x=1786069287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pGCBiJwuFidm0XWVpVouPl8UKmEaO4aYAkoooI4m9uE=;
        b=PAtr/TEmBI3Y7h5J6Gbod+rmbCKg4Ph1u5lIlVOCyr/OOdx++WnFDJWBcjybJOfxve
         bxPv2Sio/iCpKDyxSVZd2X+zYrYt29tSTofW4FMvTjLPWGTktcm2KGMjRXBk1ZCNRMQl
         Tfj1mHf2CTpr++CZqS42d19T7qk0RDlFaAu101bMi4qeqkAXYMV3HjLiJW9aRch4SGJI
         e8cicAICueK9GTWnwOymokTEQrHa/E220hpPTWPvnB8oArPIOXTPTYiZsMw6BCasWwao
         YdDKJrd2AFCszkO4uNUHHfwddCRfMazRqCVuvdZsC47UUo+DbVjPb1vIa9iu4hPkdoxg
         ckmw==
X-Forwarded-Encrypted: i=1; AHgh+RrKO/3ka9RDrfqmR2WDvGuPq7bripJq65m1N7DoW8uYWoDnYV8RyKp0SWzYleI3foKdM4ekK9Z81+TKgF3mEV/M0iwzjVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPMC/mFjVwzlIbNd0psG8UVBcWInkWstpsDAPAfVOc/SHAM9Wu
	RR0y6keXa/eKtBMNNVvdEu2ci/hjKxgEHjFVwSXy1PR4mEkndINJqFH3
X-Gm-Gg: AR+sD10/T8b1fCN3HX+n93fscncp5/miPILu3mLME25I2u+2cvdtp7rJfOzi4dJq44x
	Y/AdL48ezrCteERTn4+xv0U05fMykJ6A4yVv/Z2+5Rzv3xpl9wH0WvKNHswvZk7wLEoLB2znjp7
	iBdkJPL9FEHQtYTw9cix5gUAtT5Pc3+shcX+Ypsa82lI2J6Wn2niUPMRVSEZ4OiBzIxTgMxYYtT
	I+HIEl1dwugZ2t6ohBbG/T1ELNasGEOeb1v12jvXd6bfD4afmyW5Ctv/1e7C285t4Tc/5OFNKOw
	psWsTXLBf/hqTXuvwH2qPJ+QFCgBvA+SsuqQ0aaXj/mz3AehezhvW8vnzqMp31NpoG/fWrTzpHW
	RhTrQcz4plWLiO4Xq0orsxwscNbRBCKrRviXr57dOacTefWSw01a1eP6zKInTNZjtat7uhlplzM
	HOmG5MHUhkkDYV7zmHguaFIkBTfPJg3Ode+MPCsROqzVQ7bhHkIMd8ySwz5EOHQPI9ue4NstAyl
	Kqpp8Xl1Thfh+uWihVZ1Q==
X-Received: by 2002:a05:690c:c02:b0:81e:a425:fe7d with SMTP id 00721157ae682-81fcb9cdbc1mr766227b3.28.1785464487279;
        Thu, 30 Jul 2026 19:21:27 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:e94:8a83:feea:6720])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fb8b26e8bsm20519047b3.47.2026.07.30.19.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 19:21:27 -0700 (PDT)
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
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH bpf-next 10/13] bpf: Add the bpf_landlock_restrict_binprm kfunc
Date: Thu, 30 Jul 2026 22:20:43 -0400
Message-ID: <20260731022047.189137-11-utilityemal77@gmail.com>
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

Add the enforcement kfunc for Landlock rulesets:

  bpf_landlock_restrict_binprm(bprm, ruleset, flags)

It restricts the credentials prepared in @bprm with @ruleset, so that
the executed task starts confined by it, through
security_bprm_enforce_policy_kptr() invoked with LSM_ID_LANDLOCK.
When Landlock is compiled out or not enabled in the LSM order, the
call fails with -EOPNOTSUPP.

The kfunc keeps the BPF-facing interface strongly BTF-typed: with
kfunc arguments trusted by default, both the binprm (from the LSM
hook context) and the ruleset (an acquired reference) must be trusted
pointers whose provenance the verifier guarantees, not merely
type-matching ones.

The flags take the landlock_restrict_self(2) flags with their usual
semantics.  Only LANDLOCK_RESTRICT_SELF_TSYNC is rejected (-EINVAL),
as it targets the calling threads rather than the execution.

The filter makes enforcement exclusive to the sleepable LSM programs
attached to the bprm_creds_for_exec() or bprm_creds_from_file()
hooks.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 kernel/bpf/bpf_lsm.c | 50 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 9ff1c35fcd6e..67aa902f1257 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -486,8 +486,8 @@ int bpf_lsm_get_retval_range(const struct bpf_prog *prog,
 struct bpf_landlock_ruleset {};
 
 /*
- * The sleepable LSM hooks bpf_landlock_put_ruleset() may be called
- * from.
+ * The sleepable LSM hooks bpf_landlock_restrict_binprm() and
+ * bpf_landlock_put_ruleset() may be called from.
  */
 BTF_SET_START(bpf_landlock_kfunc_hooks)
 BTF_ID(func, bpf_lsm_bprm_creds_for_exec)
@@ -535,6 +535,42 @@ __bpf_kfunc void bpf_landlock_put_ruleset(struct bpf_landlock_ruleset *ruleset)
 	security_policy_kptr_put(LSM_ID_LANDLOCK, &policy);
 }
 
+/**
+ * bpf_landlock_restrict_binprm - Enforce a Landlock ruleset on exec
+ *                                credentials
+ * @bprm: execution context providing the prepared credentials to
+ *        restrict
+ * @ruleset: Landlock ruleset to enforce
+ * @flags: landlock_restrict_self(2) flags, except
+ *         %LANDLOCK_RESTRICT_SELF_TSYNC
+ *
+ * Restrict the credentials prepared in @bprm with @ruleset, so that
+ * the executed task starts confined by it, following the same domain
+ * composition rules as landlock_restrict_self(2).  The restriction is
+ * staged and only committed at the execution's point of no return: an
+ * execution that fails before that point is unaffected, and a later
+ * call on the same execution replaces a previously staged
+ * restriction.  @ruleset is only borrowed: the caller keeps its
+ * reference.
+ *
+ * The landlock_restrict_self(2) flags apply with their usual
+ * semantics.  Only %LANDLOCK_RESTRICT_SELF_TSYNC is rejected, as it
+ * targets the calling threads rather than the execution.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if the Landlock LSM is not
+ * enabled, -EINVAL if @flags contains an unsupported flag, other
+ * negative values on failure as for landlock_restrict_self(2).
+ */
+__bpf_kfunc int bpf_landlock_restrict_binprm(struct linux_binprm *bprm,
+					     struct bpf_landlock_ruleset *ruleset,
+					     u32 flags)
+{
+	union lsm_policy_kptr policy = { .landlock.ruleset = ruleset };
+
+	return security_bprm_enforce_policy_kptr(LSM_ID_LANDLOCK, bprm,
+						 &policy, flags);
+}
+
 /* Destructor for referenced bpf_landlock_ruleset kptrs. */
 __bpf_kfunc void bpf_landlock_put_ruleset_dtor(void *ruleset)
 {
@@ -550,6 +586,7 @@ BTF_KFUNCS_START(bpf_landlock_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_landlock_get_ruleset_from_fd,
 	     KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_landlock_put_ruleset, KF_RELEASE | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_landlock_restrict_binprm, KF_SLEEPABLE)
 BTF_KFUNCS_END(bpf_landlock_kfunc_ids)
 
 BTF_ID_LIST(bpf_landlock_dtor_ids)
@@ -558,6 +595,8 @@ BTF_ID(func, bpf_landlock_put_ruleset_dtor)
 
 BTF_ID_LIST_SINGLE(bpf_landlock_get_ruleset_ids, func,
 		   bpf_landlock_get_ruleset_from_fd)
+BTF_ID_LIST_SINGLE(bpf_landlock_restrict_binprm_ids, func,
+		   bpf_landlock_restrict_binprm)
 
 /*
  * BPF_PROG_TYPE_LSM and BPF_PROG_TYPE_SYSCALL share their kfunc
@@ -566,7 +605,10 @@ BTF_ID_LIST_SINGLE(bpf_landlock_get_ruleset_ids, func,
  * in the fd table of the task that set the ruleset up, so
  * bpf_landlock_get_ruleset_from_fd() is exclusive to syscall
  * programs, which run in that task's context; an LSM program runs in
- * the context of the task it mediates.
+ * the context of the task it mediates.  Enforcement is exclusive to
+ * the sleepable bprm LSM hooks the policy operation is specified
+ * for, and the release kfunc is allowed wherever a reference can be
+ * held.
  */
 static int bpf_landlock_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
 {
@@ -575,6 +617,8 @@ static int bpf_landlock_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
 
 	switch (prog->type) {
 	case BPF_PROG_TYPE_SYSCALL:
+		if (kfunc_id == bpf_landlock_restrict_binprm_ids[0])
+			return -EACCES;
 		return 0;
 	case BPF_PROG_TYPE_LSM:
 		if (kfunc_id == bpf_landlock_get_ruleset_ids[0])
-- 
2.54.0

