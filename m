Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252464F475F
	for <linux-security-module@vger.kernel.org>; Mon, 31 Aug 2026 15:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188405; cv=none; b=ogl4e2pHqj3/QN7Wc1GFmeQ9j4TNgwmD3/w52J+uptEJbwVf3vw8QWEdcIbPk58Oo+40LlIzOaGgj4akBhMFCY1MGTrbGzFISFS3MpkZjtPzT1N2fCEhU4YJNJ79J15LgrCgspchZOn9i5z763fgH+kP9lQKAJJzkgM2uCiqdxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188405; c=relaxed/simple;
	bh=b13IPf/84INpWuDI29q/RKRtrh98z2Lf1mSfFGTrgeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VcwHf3rin9cTgQis1ib1gyjMSOD3HNekOQHali0yI1hYGaC3GINlIsXNeuZdYYWF+P/lgvernoehyU5XBpBJBsedEeoQLc4SaIMI3gbNFw3FVrNSbnOSnQg3M76NG4isMSTpC72hTLrDZUeAehgEEGgtfFd9Kr/j8Y8Jm+4b/bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZbge3x0; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZbge3x0"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-836c4474028so44740267b3.0
        for <linux-security-module@vger.kernel.org>; Mon, 31 Aug 2026 08:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788188403; x=1788793203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rCFWN9c5DyvZlo6DEGKf40uISp6POIHTrkimV4mL3IQ=;
        b=kZbge3x06aKFzXNvf6cyjoA7yBvs5Ly+cX1WlfmDUoSnwqQih1TnNj2pK1iRia+5wb
         lpUl6uE5rzbRx4elvQdOtyUEerK2r9vxqATKZs9flWkMvmC+qATzcrIZtsx4Jyw1Fzx1
         zSxDQfo3FRwq9HCH5tgP3KdEXN2s8opCR8CsdY4PxE2GUYQbrQDPH271O9EBtuT0xk8C
         H+v95cOXvlRk0zUrAZy7RY+IjGRqcddqiSgdsAiKs8ykI8P6VsFqWA1ew9em/Zi+yy9v
         Z4039trmXpZocgF+eJtBnNQH+RMVI+Asn/VuBcbyjXi7ohefY91/w6SduZvFGRHFa7kb
         VzUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788188403; x=1788793203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rCFWN9c5DyvZlo6DEGKf40uISp6POIHTrkimV4mL3IQ=;
        b=E5DTe8G8sUKnPemGYVtrg3RtKXCQari9IL82BrxIcV5BEl9EIakN2Cb/5eew9qwWLm
         xUc3KxNVffIf9rVIKHl23z6IaNwWhvZpnkqCPs5a9pG8WAcqK80Wo9vfeNO09V30czVv
         X7gUgLKtfPDWC9DDIhmQUnIykMBwzVhmwzCluVGp/feNIurXdfteOrC5UKHOzgcl3q+L
         ZnG3icpEy3otvhKA64vPmy2V8V191cgaQjJFfuneuFaBiFMsuzswdFmaboHx5naJ1l4+
         DocXwx1ZmUfX/ecObNYUtIqtP8GIJb69V5P+nc2/cqm2ifXTHIcapx0i7YWu4y3qC5Ak
         FyCw==
X-Forwarded-Encrypted: i=1; AKwUvBx8xrdNsVvKVyv8arKL8T6LBAFowNvz+TaRZ9CeJ5nXWp3PVhTqMxIsgabpudxbR2wi9fi4CejeKR0dykttI7VHFz8K9o4=@vger.kernel.org
X-Gm-Message-State: AFuF++mGx5BwHy7zHnWif5Xq2u+/sg33cN0HWvFgMQBo2ihAvXU2Z1Fl
	WBFW8lJ/KmMz+Ug3lTvm6+ZoDgArogNfWbPdBbIQGuIaU3vaIW9sXMIF
X-Gm-Gg: AYBFou3qOp+Aksv6hcGuopA1ZBswXJEcpUz+gT9qDUqRzHHUTJ6TatxPVK5q3f4KRes
	0S9U37ilSgyWP8ZWXfUYXO20g2HCbOcgchSK01NPWM86N4w6Z+x6Btzj01T2w9g1iv6cNJADKKv
	zWpfWr08LkZtykcRPfqHN6BwqbtyEOII73YuEjXgRKll0emY8rOs6Fz5vfcb7Z/L9qiupZ2540p
	k6jNHEPt+GAr4H0Gw6Ka0Cgy020bkjszubQU2KTvENLYwRiP6nShUTEiVkxJbdnYjk+gfMxBRFm
	hdCGabeyyX36lhANDHzmyjWFVUgv+a8LRC11qaXFwZIYogYrbkgAzbBQCigEBdTyhRJC4IxlAHd
	k4qB0IiYRNg1v99je+Z3pUjr56HkMlCXqEqUAU+1wZGw6bYMWa3hOka+jQoWbuUQSHR0WWHzKbk
	yrmZRtgU2rJ/6jSYNBb98z7f6UfKSgCIPqUDFdIuo5Rsy8ploKIm2dUY4CrF4x/KK5L6I+KY7Jr
	RPnxinnt8vczO1LqQbvKqE=
X-Received: by 2002:a05:690c:93:b0:862:65f4:c8bb with SMTP id 00721157ae682-86265f4cb64mr46763897b3.3.1788188402897;
        Mon, 31 Aug 2026 08:00:02 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:f6fc:b424:b1bb:6ff0])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e58666e15sm53903827b3.0.2026.08.31.08.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 08:00:02 -0700 (PDT)
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
Subject: [PATCH v2 05/15] lsm: Add the bpf_lsm_policy_from_fd kfunc
Date: Mon, 31 Aug 2026 10:58:47 -0400
Message-ID: <20260831145858.3869191-6-utilityemal77@gmail.com>
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

Add the kfunc translating a file descriptor into a referenced policy
object:

  bpf_lsm_policy_from_fd(fd, flags)
      KF_ACQUIRE|KF_RET_NULL|KF_SLEEPABLE

No argument names an LSM: a policy object fd refers to a file set up
through the owning LSM's own userspace interface so the fd itself
identifies the LSM asked to translate it.  The kfunc offers the fd to
every policy_object_from_fd implementation in turn until one claims it.

Following the convention of the lsm_*(2) syscalls, @flags belongs to
the framework and is reserved: the kfunc returns NULL for @flags != 0.

A policy object fd is only meaningful in the fd table of the process
that set the object up, while an LSM program runs in the context of
the task it mediates, so the filter makes this kfunc exclusive to
syscall programs (BPF_PROG_TYPE_SYSCALL), which run in the context of
the task invoking them.  The acquired object may be released with
bpf_lsm_policy_release().

Cc: Paul Moore <paul@paul-moore.com>
Cc: KP Singh <kpsingh@kernel.org>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 security/bpf_lsm_kfuncs.c | 53 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/security/bpf_lsm_kfuncs.c b/security/bpf_lsm_kfuncs.c
index e1190215d477..988dcd6f4dd9 100644
--- a/security/bpf_lsm_kfuncs.c
+++ b/security/bpf_lsm_kfuncs.c
@@ -14,11 +14,50 @@
 
 __bpf_kfunc_start_defs();
 
+/**
+ * bpf_lsm_policy_from_fd - Get an LSM policy object from a fd
+ * @fd: file descriptor referring to a policy object, resolved in the
+ *      file descriptor table of the task running the program
+ * @flags: reserved for future use, must be 0
+ *
+ * Translate @fd, as set up through the owning LSM's own userspace
+ * interface, into a referenced policy object.  The fd identifies the
+ * LSM asked to translate it: each LSM recognizes its own fds and
+ * declines every other.  Only syscall programs may call this kfunc:
+ * they run in the context of the task invoking them, where the fd is
+ * meaningful.  The reference must be released with
+ * bpf_lsm_policy_release().
+ *
+ * Return: A referenced policy object, or NULL if @flags is not 0, if
+ * no enabled LSM recognizes @fd as one of its policy objects, or if
+ * the recognizing LSM fails to translate it.
+ */
+__bpf_kfunc struct lsm_policy_object *bpf_lsm_policy_from_fd(int fd, u32 flags)
+{
+	struct lsm_static_call *scall;
+	struct lsm_policy_object *object;
+	int err;
+
+	if (flags)
+		return NULL;
+
+	lsm_for_each_hook(scall, policy_object_from_fd) {
+		err = scall->hl->hook.policy_object_from_fd(fd, &object);
+		if (err == -EOPNOTSUPP)
+			/* Not this LSM's fd: let another claim it. */
+			continue;
+		if (err)
+			return NULL;
+		return object;
+	}
+	return NULL;
+}
+
 /**
  * bpf_lsm_policy_release - Release a policy object reference
  * @object: policy object to release
  *
- * Release an acquired reference on a policy object.
+ * Release a reference acquired with bpf_lsm_policy_from_fd().
  */
 __bpf_kfunc void bpf_lsm_policy_release(struct lsm_policy_object *object)
 {
@@ -44,6 +83,8 @@ CFI_NOSEAL(bpf_lsm_policy_release_dtor);
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_lsm_policy_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_lsm_policy_from_fd,
+	     KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_lsm_policy_release, KF_RELEASE)
 BTF_KFUNCS_END(bpf_lsm_policy_kfunc_ids)
 
@@ -51,10 +92,14 @@ BTF_ID_LIST(bpf_lsm_policy_dtor_ids)
 BTF_ID(struct, lsm_policy_object)
 BTF_ID(func, bpf_lsm_policy_release_dtor)
 
+BTF_ID_LIST_SINGLE(bpf_lsm_policy_from_fd_ids, func, bpf_lsm_policy_from_fd)
+
 /*
  * BPF_PROG_TYPE_LSM and BPF_PROG_TYPE_SYSCALL share their kfunc
  * lookup buckets with other program types, so restricting the policy
- * kfuncs requires a filter.
+ * kfuncs requires a filter.  A policy object fd is only meaningful in
+ * the fd table of the task that set the object up: the fd kfunc is
+ * exclusive to syscall programs, which run in that task's context.
  */
 static int bpf_lsm_policy_kfunc_filter(const struct bpf_prog *prog,
 				       u32 kfunc_id)
@@ -64,7 +109,11 @@ static int bpf_lsm_policy_kfunc_filter(const struct bpf_prog *prog,
 
 	switch (prog->type) {
 	case BPF_PROG_TYPE_SYSCALL:
+		return 0;
 	case BPF_PROG_TYPE_LSM:
+		if (kfunc_id == bpf_lsm_policy_from_fd_ids[0])
+			return -EACCES;
+
 		return 0;
 	default:
 		return -EACCES;
-- 
2.55.0

