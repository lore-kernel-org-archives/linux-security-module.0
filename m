Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECDC3242BD
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 02:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785464489; cv=none; b=m/QUjCXyBskqND0gOp2oMpS38zTEmjrfUX4wUraDgPIr7/62geYkpe3GrLDnJpYY//Xb1rZ0VbjazDBnT1nk6TP/0urZe5APoEQIvQ7IMlV7SlULxthqo8aaojskL03WlHqAGmfFn64jbIDdzIxUKj1syitIUmWEEe9w2fXT9XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785464489; c=relaxed/simple;
	bh=/VRKhMz6MNHP5GXT2Zjzxq2uq/8Y/syPrzNmmZIe/iM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TyymM9DtnjLR2+aca2RTWBHa2X8Te50c9lglieKcfFMlRWx7v4kP1ysFg18wBUk/V/YU2RP30zx5qtkM61+4RoLTEyT+cYetVVmpdjy4dK7VgxEpT0GnZMljK+pl2AgiIOC+oEDZXvWBBjXZyxT4nLCVVXPi8IGE1JSaCIc2bH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bDs3IgQM; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDs3IgQM"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-81eef95653fso4649447b3.2
        for <linux-security-module@vger.kernel.org>; Thu, 30 Jul 2026 19:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785464486; x=1786069286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i0Bw5xZyWZrxJDT+Nb2bq5E0YUztUMCAvYE7Jg2F4Y4=;
        b=bDs3IgQMr+k9uIE7pAkvI/dggadTInDnK4023pc8ud5wSefpDJDH2cT//JKxRZxFbQ
         8wu6SZ63N0cp2nhvUsSiFH3eb493u28XPygHJ/pKfKB/ez6id70uYPpTuIXyNwx4jVyU
         nCzU8eZuOu2Ri6yeZXN4wBdW7ealf8NT/PkepSYEfXD75f0ALxh1wieFSD0uGulbYKVD
         M3k0R+vOOHjQ4ey8ZEj21pY8phEnhy1Ja1nsyDVBm4QPYrxNjxVkcpXDCTBj+DORBsyQ
         9ncvDqEswZ1VjCuRC93wHI5uBnI43JJb5XJYaIZl5S8hwpSLmwa1q3XzCmfEJ0kF6Ta4
         cWIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785464486; x=1786069286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i0Bw5xZyWZrxJDT+Nb2bq5E0YUztUMCAvYE7Jg2F4Y4=;
        b=iefmCppTfVotokfFbFB1ja9uxLQpYFx9hsIQa3fzh/QnDNLrwaWtZreUq/ZsQYQB2R
         zyQP4KAag16Jdq0c0pszcxC3tpWnQhSFh3UKF/vIYuAG/y67Mvp5s9pZSTXR1dZgHJGj
         6dUY8s9Q/udhR1a59G+0tRIAf56DP1v3wFnaFUDirdT4DVPpHW/p1AKP7L6GGiQuwkBR
         kYnpa/PTUkrVXnNig+NLsS0Mloa659jVBu6OQrk8yC9U+/cWOAJGBzj1gnoWUnPnkMvp
         F31VhMps8FkEvYlOX3RqnjaJhVv0ffnT5edBbutD05r31tnmSpK2AH5+jEywVQPO/n7d
         upoA==
X-Forwarded-Encrypted: i=1; AHgh+RqovFd5vXLrmMaMRlXfF+bX44KiOqDomsVDJKF7c+od3m1uMy8D2/2SoxNRA5MD/+3R+lnFhyr+21mPWvLr6XWDireRm0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YycBJCm9XsgsFfrl/myUkyoxKSm7VRmdrDVl3bkjuOqNaeVx5e5
	iD2BhPJqlZIa5icw7wp2DUm5UDAWHxEJ/wPD+OAf6a95WSNWCPy6GRT5
X-Gm-Gg: AR+sD100vubJYGrnwWOdPkVA4GMnw4rkDBCHytiVPAJ0Dyp6jc4TP58daDcXzuS0IH6
	6IK94s2xZVZ0q+vSxXjz8+AYazZr8PlkNj85TVhBiUz1V2xPaQWMpxObvWIi4nXJjwQVhbbDCye
	ilSCxd+nAQMtqwtpzWxS6Wjr5m24jskvzVNdOy5cLcBJSpdh/PFhEvKDHqiyo04wmRiqzqPDdN3
	wTfBln6kIgR/G8ponfI8adNuVwp+9Rv+80OwAhmlmRSwxH6G42BarDorjEL8H9cQSQ/eoOV+wkc
	6ViCh4dTcKDYMVBdmFMV/DtytmgzSRjpmWC1pWWp+a0TInGVG5lSwUhVWp5TsNw6SuguVKcc1P2
	iEajwBBoItqb+XkWkFovVoqu2nqo1ybFf+NPjJ0KsRM3QLs5FJAjrtcc6gs2Rb7C3JHNAZGatUi
	qVYnpnHp7hA8uHKkJur0njufJ+a0kJZvbtO0jCF9NEPLq9CFFGJTy3gg/tuShQl4IYujC9T2mNZ
	MyVyhDBhR96R+XvJPdK0w==
X-Received: by 2002:a05:690c:3685:b0:80f:ddab:1cca with SMTP id 00721157ae682-81fcbbde12bmr429757b3.35.1785464485830;
        Thu, 30 Jul 2026 19:21:25 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:e94:8a83:feea:6720])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fb8b26e8bsm20519047b3.47.2026.07.30.19.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 19:21:25 -0700 (PDT)
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
Subject: [PATCH bpf-next 09/13] bpf: Add the bpf_landlock_get_ruleset_from_fd kfunc
Date: Thu, 30 Jul 2026 22:20:42 -0400
Message-ID: <20260731022047.189137-10-utilityemal77@gmail.com>
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

Add the acquire kfunc for Landlock rulesets:

  bpf_landlock_get_ruleset_from_fd(fd)          KF_ACQUIRE|KF_RET_NULL

It acquires a reference on the Landlock ruleset referred to by @fd,
as created by landlock_create_ruleset(2) and populated with
landlock_add_rule(2), through security_policy_kptr_from_fd() invoked
with LSM_ID_LANDLOCK.  When Landlock is compiled out or not enabled
in the LSM order, the call returns NULL.

A ruleset fd is only meaningful in the fd table of the process that
set the ruleset up, while an LSM program runs in the context of the
task it mediates, so the filter makes this kfunc exclusive to syscall
programs (BPF_PROG_TYPE_SYSCALL), which run in the context of the
task invoking them.  The acquired ruleset is meant to be handed over
through a map kptr field to an enforcement program, and must be
released with bpf_landlock_put_ruleset().

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 kernel/bpf/bpf_lsm.c | 46 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 877dd0352607..9ff1c35fcd6e 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -479,7 +479,9 @@ int bpf_lsm_get_retval_range(const struct bpf_prog *prog,
 /* LSM policy kfuncs */
 
 /*
- * Opaque handle for a Landlock ruleset.  Only Landlock resolves it.
+ * Opaque handle for a Landlock ruleset.  Only
+ * bpf_landlock_get_ruleset_from_fd() produces one, and only Landlock
+ * resolves it.
  */
 struct bpf_landlock_ruleset {};
 
@@ -494,11 +496,37 @@ BTF_SET_END(bpf_landlock_kfunc_hooks)
 
 __bpf_kfunc_start_defs();
 
+/**
+ * bpf_landlock_get_ruleset_from_fd - Get a Landlock ruleset from a fd
+ * @fd: file descriptor of a Landlock ruleset, resolved in the file
+ *      descriptor table of the task running the program
+ *
+ * Acquire a reference on the Landlock ruleset referred to by @fd, as
+ * created by landlock_create_ruleset(2) and populated with
+ * landlock_add_rule(2).  Only syscall programs may call this kfunc:
+ * they run in the context of the task invoking them, where the
+ * ruleset fd is meaningful.  The acquired ruleset can be handed to an
+ * enforcement program through a map kptr field.  The reference must
+ * be released with bpf_landlock_put_ruleset().
+ *
+ * Return: A referenced ruleset handle, or NULL if @fd is not a
+ * readable Landlock ruleset fd or the Landlock LSM is not enabled.
+ */
+__bpf_kfunc struct bpf_landlock_ruleset *
+bpf_landlock_get_ruleset_from_fd(int fd)
+{
+	union lsm_policy_kptr policy;
+
+	if (security_policy_kptr_from_fd(LSM_ID_LANDLOCK, fd, &policy))
+		return NULL;
+	return policy.landlock.ruleset;
+}
+
 /**
  * bpf_landlock_put_ruleset - Put a Landlock ruleset
  * @ruleset: Landlock ruleset to put
  *
- * Release an acquired reference on a Landlock ruleset.
+ * Release a reference acquired with bpf_landlock_get_ruleset_from_fd().
  */
 __bpf_kfunc void bpf_landlock_put_ruleset(struct bpf_landlock_ruleset *ruleset)
 {
@@ -519,6 +547,8 @@ CFI_NOSEAL(bpf_landlock_put_ruleset_dtor);
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_landlock_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_landlock_get_ruleset_from_fd,
+	     KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_landlock_put_ruleset, KF_RELEASE | KF_SLEEPABLE)
 BTF_KFUNCS_END(bpf_landlock_kfunc_ids)
 
@@ -526,10 +556,17 @@ BTF_ID_LIST(bpf_landlock_dtor_ids)
 BTF_ID(struct, bpf_landlock_ruleset)
 BTF_ID(func, bpf_landlock_put_ruleset_dtor)
 
+BTF_ID_LIST_SINGLE(bpf_landlock_get_ruleset_ids, func,
+		   bpf_landlock_get_ruleset_from_fd)
+
 /*
  * BPF_PROG_TYPE_LSM and BPF_PROG_TYPE_SYSCALL share their kfunc
  * lookup buckets with other program types, so restricting the LSM
- * policy kfuncs requires a filter.
+ * policy kfuncs requires a filter.  A ruleset fd is only meaningful
+ * in the fd table of the task that set the ruleset up, so
+ * bpf_landlock_get_ruleset_from_fd() is exclusive to syscall
+ * programs, which run in that task's context; an LSM program runs in
+ * the context of the task it mediates.
  */
 static int bpf_landlock_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
 {
@@ -540,6 +577,9 @@ static int bpf_landlock_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
 	case BPF_PROG_TYPE_SYSCALL:
 		return 0;
 	case BPF_PROG_TYPE_LSM:
+		if (kfunc_id == bpf_landlock_get_ruleset_ids[0])
+			return -EACCES;
+
 		/*
 		 * BPF_LSM_CGROUP programs run under classic RCU and
 		 * cannot sleep.
-- 
2.54.0

