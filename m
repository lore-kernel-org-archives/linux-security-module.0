Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DDE4FB9B7
	for <linux-security-module@vger.kernel.org>; Mon, 31 Aug 2026 15:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188412; cv=none; b=onQu0GAb290a7wW8iDuNCvZBcFw5u1g1dcSI1wkKwF1YYOp14S8h3rtGYP1tDDg+8WjU+6PPprvo7V+5r047InQ1NAVebTZm2WWgMXOvypA96bmAqj/hSAC4NXCU0dqdJfWFxQKx3js6+XtZDcudqIbHP51mHVeWFnxu0uIfx1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188412; c=relaxed/simple;
	bh=ZSuaHxdeSmdK1XVdgW9I78FY4WiLUsxPZgAk1jSE970=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WjQ4A9azTZ7x4a/pIfmzHRwJ5SU9nQr9XAWWF3zyqkMl9VQg/vomwZ0wwNVM2ifApNToFZiXpvJBJVvV67nH9fGpxu52zIqvLfNxczrzdID3rJgGczCHO0lpf1UPf8ZsL40fAw99eETK+DGh5NVuHgD94Xq7ds4ZMD8hto0fEnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2/Vm0nU; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2/Vm0nU"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-81f36179d72so40915147b3.2
        for <linux-security-module@vger.kernel.org>; Mon, 31 Aug 2026 08:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788188409; x=1788793209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xKtb+s5mvwWHR2Dm56oQU87T2PX0PUH0OEkGW4x95GI=;
        b=Y2/Vm0nUmzXzhAQjDw/2Y5pc/FwY5dIj308vVT12yAbmD6fVCV68CiTqI/nRoKK+to
         fhf7XtN5CWyG/ydMSnekty57XGpqqI8mDNg+OMiJarRYCjocUGVwFypCNmj96Q3PZjuf
         mPZ7yqpuqyPWnTfzje3Q2SjPE3qM0Mbq+wT8XfEXr4d3mnVWgt9UIlcyOQcJgrD9yWpu
         1LbqAdnvzdIWd5x7BiesnOp/b6SWJWrEbLMaHLryZ7VczXWEIRBpfcWd0fDWNCaDRfjx
         1SvaajZ5iaOmCXDr+DHbtTpm3RQxW7pY7QMMMeAuWMGdHbavFNsE+hAugDlJ0apH2uQB
         Vs/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788188409; x=1788793209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xKtb+s5mvwWHR2Dm56oQU87T2PX0PUH0OEkGW4x95GI=;
        b=f6cTua3XcZxihCmrf/sGYrcNWPNXDI33OGWsQnfqwX65Mxu0ZaOVED3sgXTJEtFted
         4zbI8izgcFclASALtvTFd7oZYTLISL6bQn9P1q3W9MVPXVTlZHIP3zUrpi2HUH2kxOwl
         W7lpKXvlJmtv5RZjKvvjWLCzunq1XOIhgpcOPanS4fp3lBMAz4LYvebA7eWrHgyDS928
         pC36yxFSSlq7I6RtfKe8wkKxXjrR+FmwMHAa+Ui26PHCmDfP9r3+3+jgPbRpQvutaLc/
         C/yAJalNbs7YpWUJ1XOnxeWdUO3ZoB06ntS/bRvcEz31Z8MucMlyfEiyxoYDxjpA3H9a
         8V9Q==
X-Forwarded-Encrypted: i=1; AKwUvBwZsafu3SXD5/YyP2EA/3IgzQml/fXivaltZU8uSQzj9dC0x664ifBLiDzWpIMTUqetIFHyvsPGVTscB4YHVtTifINadxQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mR1QfedcmM8J6ncvVszCoG5uzRW6ZGCQWklGiWRddaGF5gOM4E
	bjkjwdMk4uaTiPHhrC8uf9cm8BCIa5XjZfCqJnXRf/d7meS/FRKbXesM
X-Gm-Gg: AYBFou3u93XU47pgKnyPuG66rD9r1lq/H0whGVa9574BgTk08h6dcaQ5hRfHXluqRFK
	VX84mpZoZI54n7i1N91D56IWapUfzl6RtJnTPvV82rbomfLG8xRTf5wTArsEMbibu7lKu6XLQ0d
	yrfmMDftZP8ylKLAmxeS0326ap6GBxMpanOfjwp0PpmQaeRsz+aTf2fWF8Zb1Yjs2yiaqX0JsAh
	jFIjnuCc1D9D9hX9Sdb+NSX7vWACtbWfoEs/uJLsEe1Dj53LUOabWxKW+j6l3MIJVxodgzpBKEb
	cuDVZvbgVHhuy/xYFsvAZHof5kPbI/GuKAPqAUV8qsH8LDAH5pijO+LBgfg7p3fM2QB/JKJcVdh
	LX504i+LtVV760oD146ffWdOFODSc7p+oGRBxNXioO/fFzaaCrFfhNOA5svl5wT69dAEX7RONin
	LHAK8CjrC1FcjTEyR59zjAFUPF0uCfFJguEIPDcRQnBqp8PFycQfxS0fTprDSBI3kYTN1U0VNl0
	hhqo17RECtOZGDvnSX8w0g=
X-Received: by 2002:a05:690c:c6c5:b0:85c:79d2:91a4 with SMTP id 00721157ae682-85d6b275eacmr80105927b3.17.1788188408827;
        Mon, 31 Aug 2026 08:00:08 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:f6fc:b424:b1bb:6ff0])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e58666e15sm53903827b3.0.2026.08.31.08.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 08:00:08 -0700 (PDT)
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
Subject: [PATCH v2 06/15] lsm: Add the bpf_lsm_policy_acquire kfunc
Date: Mon, 31 Aug 2026 10:58:48 -0400
Message-ID: <20260831145858.3869191-7-utilityemal77@gmail.com>
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
 kernel/bpf/verifier.c     |  3 +++
 security/bpf_lsm_kfuncs.c | 34 +++++++++++++++++++++++++++++++++-
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7aa47342dc65..ba9972c572e1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4394,6 +4394,9 @@ BTF_ID(struct, task_struct)
 #ifdef CONFIG_CRYPTO
 BTF_ID(struct, bpf_crypto_ctx)
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

