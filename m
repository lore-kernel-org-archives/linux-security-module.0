Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0B23AFD03
	for <linux-security-module@vger.kernel.org>; Wed,  9 Sep 2026 19:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788982683; cv=none; b=hC/YFtlrACpmfZR0o26OExAHV58XYp9+A9bwH9S/2DIg6OiI+AtLeBeEgO7btySGOFw0OsrfDRfm6EUx02S0GumNL/0wNnM/3fl9/q4V3LoRkuoyyvwUXXm5+rmuvuSTxsz0zJkMPiuiAOgjlTJlRv8S67Gi1UQelM/lJobp9P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788982683; c=relaxed/simple;
	bh=BExP6Uc0CAqt4PblTM1vCa+4tjOKYHzmWABKQ8gVc50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VjuVr/oH6vzpLTTAyPkeXBTYakFdRBa2Awg1q4k4XqJ1bcgsXBOkWuSDpAKlxnKTz7ItaNUdJSfySkv7bzdQbBXe3TlUPaPUijorlTOSIj8T7yfJt7nuL1N1qaYIhh66vcJkGXdudMLB/4rDYtQZpsSHz3OtH3te924eUfQwxQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/y+X3/K; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/y+X3/K"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-66f78cba2e1so6643078d50.3
        for <linux-security-module@vger.kernel.org>; Wed, 09 Sep 2026 12:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788982680; x=1789587480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/JJ/f47awfp4tzzCzgVlCBrXa77/+V7TaH/K3Hj08jM=;
        b=J/y+X3/KmzNOU4d4WZpf8v544xqstJlaUVOln4L+uebNmOzQSjR7d+B42fPeobQK/k
         V9hS26KQXcB57idq/0UlZ1wgHlUAgoeaUeqSDpOnDSzHU8anhI2GY8QWfRBk6YFXVCjT
         fMZJDodD6a+qe0sjUFsM3NclNZPeKShCDlfJNvYxZYGlCNt5etRDneZqyfjEgJA/Mnjs
         mi3BZy5Afqnw+NM/LrqDqhsRz0+8E5ygi6L842av6nSVD0+GJ3uZiDvjDH3z4fJSK0tl
         w30EJkF13YUzi9CkfTn/25mqr0zE0YO9U5rQ4JlwoCoCExJX9s1M3FN7/hVVBS8eGgY8
         Ncqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788982680; x=1789587480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/JJ/f47awfp4tzzCzgVlCBrXa77/+V7TaH/K3Hj08jM=;
        b=djJaXVasCJ69aorfGIY/NlHjru6WE+wp44JVFpkFIoe+4y/r6Ibldhc2mVcu/kswY/
         Xi1CCPYMDVQcss0t7c3SIzsZuMGGRnTlZDffSHXUpcx2glsfQ4yOkq47H4/UmnU31kQy
         qYC0ZxVm7Vxuzzc39I1WqIRN7FPTBqEm1YS1OnkcbeAft/graPL6p0xMWBnRBgh5u2kk
         KpdI+8J1C9KEtrNsSq7YosQt7p0YSSDG14WgcBum0Se78o1srFu++fik1y/YqUodirwC
         DucjUqYRlzdLBXXRDKjheytqQPH19tQrwlN7RTD8LWFrGEyL/jBfehkRYMQOknRtC36Z
         VAcw==
X-Forwarded-Encrypted: i=1; AKwUvByx0eQkVyFyiH1HL+JfrI/hpkyk70P4pdw2s5Bx08lGxyjK60vjwO/NcRhfBhO1JSLW5kWYof/s1N4goV4dHMguEGTAjs8=@vger.kernel.org
X-Gm-Message-State: AFuF++lsaa/4m7OTCXUDOuJIONwDpp51P6gO4z1PFzH1Kb+hgXejX6/i
	J8zpOZudUKNXWWZ59mqdLaKOKeqn/X2JWjXwM+6fBi8yyhZPSNOVGxTK
X-Gm-Gg: AYBFou10iEog0wH+koFAVUUiH0Agq3AxvtFGLgonQ/C0zLmLareE+ynGTKdBuHCSgWL
	0aEw1ea+yUE6cyzpt66JIl1FhxCPTWW09hZ+s6h3czfoRbrpzRY0gGsakKCaqCitv89WBksS5m7
	8GdDVLJMOGEZYSDMIn0pjgGIZYQoC2dCqGESpG6X14HrAsiNHDyRiySRExGrHy2/X+ZFZUZJYnr
	eGSQnTbt8iD2wwHhfjTuEpZ53eIvROwX6FnrADAS8w5lCqg0LJQXzDNSxNbyNDxjG9abgLMahBu
	1zxxmE0S5cMHGbdR/ItM1aMvpsK3SIairKnzfgsEqaUixkUVL2l+9wkbF2Qt04fNcgdL/eW2lR1
	4HHPJHJjkDTi4Xk59DLQwLl8WazmGsN0TSl2tDur+AQ+AzJEe92P99HDE17hIfAJHInOea2pWUk
	nkiHNWOYKUXPr3w2SXMQNL5JXK/wNtuJxvyhIdzhCg62LLHohrCnX37x/RjYF+iLvLX15E1P6Lw
	9zU13h46sARIZH9LuCM0vWLGXWo2lKU
X-Received: by 2002:a05:690c:e3c1:b0:86f:c1db:14c7 with SMTP id 00721157ae682-8712259664fmr133356567b3.7.1788982680038;
        Wed, 09 Sep 2026 12:38:00 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:bae:bfc2:7e96:e5c8])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-871493155d3sm115277577b3.16.2026.09.09.12.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 12:37:59 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 06/15] lsm: Add the bpf_lsm_policy_acquire kfunc
Date: Wed,  9 Sep 2026 15:37:09 -0400
Message-ID: <20260909193719.518517-7-utilityemal77@gmail.com>
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

Add the kfunc acquiring a reference on a policy object the program
does not own:

  bpf_lsm_policy_acquire(object)        KF_ACQUIRE|KF_RCU|KF_RET_NULL

bpf_kptr_xchg() is the only way to take an owned pointer out of a map
kptr field, and it empties the slot: concurrent executions of an
enforcement program would race for the one stored reference.  Modeled
after bpf_task_acquire(), this kfunc removes the exclusivity: a
program loads the kptr field with a plain read under
bpf_rcu_read_lock(), acquires its own reference through the
policy_object_get hook, and leaves the map slot untouched.  The
acquired reference survives bpf_rcu_read_unlock(), carrying over to a
sleepable bpf_lsm_policy_apply_bprm() call, and is released with
bpf_lsm_policy_release().

Adding struct lsm_policy_object to the verifier's rcu_protected_types
set makes the plain load yield an RCU-protected pointer instead of an
untrusted one.  This is where the policy object contract's RCU
requirements become load-bearing: the kfunc and the get hook examine
the object concurrently with a possible last put, which is safe
because implementations free only after an RCU grace period and
acquire with inc-not-zero semantics.  A failed get makes the kfunc
return NULL, per KF_RET_NULL.

The kfunc does not sleep and is meaningful wherever a policy object
pointer can be loaded, so the filter adds no per-kfunc rule.

Cc: Paul Moore <paul@paul-moore.com>
Cc: KP Singh <kpsingh@kernel.org>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---

Notes:
    v2->v3:
        - No change.

 kernel/bpf/verifier.c     |  3 +++
 security/bpf_lsm_kfuncs.c | 34 +++++++++++++++++++++++++++++++++-
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9e79750e2480..d1af0090d38f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4660,6 +4660,9 @@ BTF_ID(struct, bpf_crypto_ctx)
 #ifdef CONFIG_INET
 BTF_ID(struct, bpf_ksock)
 #endif
+#ifdef CONFIG_BPF_LSM
+BTF_ID(struct, lsm_policy_object)
+#endif
 BTF_SET_END(rcu_protected_types)
 
 static bool rcu_protected_object(const struct btf *btf, u32 btf_id)
diff --git a/security/bpf_lsm_kfuncs.c b/security/bpf_lsm_kfuncs.c
index 988dcd6f4dd9..43a4bf57fd31 100644
--- a/security/bpf_lsm_kfuncs.c
+++ b/security/bpf_lsm_kfuncs.c
@@ -14,6 +14,36 @@
 
 __bpf_kfunc_start_defs();
 
+/**
+ * bpf_lsm_policy_acquire - Acquire a reference on a shared policy object
+ * @object: RCU-protected pointer to a policy object, e.g. loaded from
+ *          a map kptr field under bpf_rcu_read_lock()
+ *
+ * Acquire a reference of its own on a policy object the program does
+ * not own, so that any number of concurrent program executions can
+ * use the object shared through one map kptr field, without emptying
+ * it as bpf_kptr_xchg() would.  The returned reference stays valid
+ * after bpf_rcu_read_unlock() and must be released with
+ * bpf_lsm_policy_release().
+ *
+ * Return: A referenced policy object, or NULL if the object's
+ * reference count concurrently dropped to zero.
+ */
+__bpf_kfunc struct lsm_policy_object *
+bpf_lsm_policy_acquire(struct lsm_policy_object *object)
+{
+	struct lsm_static_call *scall;
+
+	lsm_for_each_hook(scall, policy_object_get) {
+		if (scall->hl->lsmid->id != object->lsmid)
+			continue;
+		if (scall->hl->hook.policy_object_get(object))
+			return NULL;
+		return object;
+	}
+	return NULL;
+}
+
 /**
  * bpf_lsm_policy_from_fd - Get an LSM policy object from a fd
  * @fd: file descriptor referring to a policy object, resolved in the
@@ -57,7 +87,8 @@ __bpf_kfunc struct lsm_policy_object *bpf_lsm_policy_from_fd(int fd, u32 flags)
  * bpf_lsm_policy_release - Release a policy object reference
  * @object: policy object to release
  *
- * Release a reference acquired with bpf_lsm_policy_from_fd().
+ * Release a reference acquired with bpf_lsm_policy_from_fd() or
+ * bpf_lsm_policy_acquire().
  */
 __bpf_kfunc void bpf_lsm_policy_release(struct lsm_policy_object *object)
 {
@@ -83,6 +114,7 @@ CFI_NOSEAL(bpf_lsm_policy_release_dtor);
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_lsm_policy_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_lsm_policy_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_lsm_policy_from_fd,
 	     KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_lsm_policy_release, KF_RELEASE)
-- 
2.55.0

