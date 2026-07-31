Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAB930B502
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 02:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785464487; cv=none; b=EwKdqHV4Vetc/9nMJDcOG0ubAhxHXBm24onX5sPEvj1Dyh5tN2ACVINpgFfafu8IKsJcBqb/XHL1HGtc3QBfpRF6Fxj3KmW/0iew62KgKlApJZYLnvCID/N6rvgI/64IL0MOwsE7owTQQ4eIG41ddJr7WYbxo1Yh9sHkoqmF4tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785464487; c=relaxed/simple;
	bh=NL8mBC7WHXg65243KavwzxselJ8EusI6R5QSuWKlbs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rwk7aDCZW/Chz6SxsExlmXgxMe6eVNieAyjr8y2hjkI8xeaPtFUM4bEpS7oPQR8MS83/NV13pknVEREloMzWSsdUfhDMi5bRaqQn8UH7qMLT2pgRnpmk466DBBJ+PXHSNickNPpvDaEmx1Z5Q0JUl6iB8rqvmJdgjO5BcIiv4wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oiFkuMY3; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oiFkuMY3"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-81eaf3709b4so7391157b3.0
        for <linux-security-module@vger.kernel.org>; Thu, 30 Jul 2026 19:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785464484; x=1786069284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vTtFKNvHB2/Ojp2xHTtFD0mxvMCw7gVj2kPcAk5LXGw=;
        b=oiFkuMY3lsVKuL5Qqrwgzh1oEskSwGwnF/VvkkRpNEVvd7Ze1SZ7Sr6sFaEQP8VM1u
         +h5CM+4Mr3xQxgfXpsjb+lnScR40QZyEJ+4YzDr/LEyKL7uobe3hKZdfuN/K39k0ad/W
         JBClrrfN+8u3bU3jJfPLgDreaVabggDWRmMNcwISOKOZ7WmbTNAyn0lvt0zPIYM33dHA
         Nz38dwhtYkaEnZQoCbGkyr2M8zEk0zIAVspRyZt6H7iPbMYPFd/X++htTZUOkCdRmzBc
         kcIWZqDYX9VDa8LxGRu3rm/O2275AjVeiyQpVceoj2Y+G3uGe+SkX28InW5FQQnWKaJp
         Xqwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785464484; x=1786069284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vTtFKNvHB2/Ojp2xHTtFD0mxvMCw7gVj2kPcAk5LXGw=;
        b=S91qPi/djAPwYdxxBZvONfv72kFFwEddw1OR+tNvj8FhXMiigRNGWkdVTRfp5E9+5C
         agOeYUumVkGg7FeDmNoCYnsVLDd0hPpgIqU/iRknXmcOR02OerG47JN+VyxHZdUOPV55
         HRCh9930pEVV0Hqf6gYxyVDIsNuH5Efx9m8ri1+HE5bTS3bu022OwOxnl5wLSdzHgd+q
         csNKOs0Chm+7VhsygQvjanCcoZMFtaTu+U1FeUpoUBNrproay95/mTnZ5Gnj0NHcj+r3
         0H4Rn5GBJrTLLBNk+nGxrBxsP5BcryMXnFwwbYBjT1qCNRHHUIiJOUW58Yumy3xCn1uZ
         BXlg==
X-Forwarded-Encrypted: i=1; AHgh+RrXSoFFWLs1l24FUrTBaLzDM/ghnFYSxBfx7DSi71BnSf/CvYGaqyxl8u45CcTvxTcYe8lS/20mjIkUwonQOwO8PZyHEpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ9MH48uBRtu22RtnPILWyOT2dRiwRRDwPBOr9B9Qh/qi5/auc
	ymX6PejdfP11EXVpv5XborfbVrnVrpPWoom320TC7MuPdbzhr7Kiw4fP
X-Gm-Gg: AR+sD10nZy259f1BebKfiJzg/JIDWWH9OmoYFJu8GKl64x9sDlKDm+5lvRZMUuf8dPZ
	LdBnqbv1BADMMpW0Ol1AiOuG8+AcimEytIQim2N1C/gCKhnKaMzoenZc/hzDpMbRKDztFQr2eZF
	jFg5vOiA0rbqYSf6nK2rfSnReoeG5BtSni8hapbWv+Ppwr2k+VjrMJubR8CQu42GapwvmNDF/mJ
	oc9vku+i50Wd2r0VJUkeEgSZTn16WdEhyFkv1gMwwyTNLI5ns6SJ7eeNMhw9hRcMFS1jFeFKw/g
	UNMpHO0XCKyeVqdfJRuF2W1Gufgw2C4yPGvTjamrfuPn4JJ9efaoww7OU9IZ+wIfBaH/2cJLLS5
	3oZUiMPWojN4hP679z9RxRGUXJZoDVxz7DuiFIiHd/BX/Zbnr4HHxuP/l4ONUhB9N1Fe+vejcWk
	SK4lD6frfwCdekoEFFX9H6+nsZgkhv0mQD0UYsECJx2EXPBaFhENYoAoD3yW0oAG8RGwDWQ63Kk
	6cq1Ue68wCMpYWgaCZCq/w=
X-Received: by 2002:a05:690c:3705:b0:80d:66b2:850 with SMTP id 00721157ae682-81fcc1238e6mr120377b3.42.1785464484423;
        Thu, 30 Jul 2026 19:21:24 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:e94:8a83:feea:6720])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fb8b26e8bsm20519047b3.47.2026.07.30.19.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 19:21:24 -0700 (PDT)
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
Subject: [PATCH bpf-next 08/13] bpf: Add the bpf_landlock_put_ruleset kfunc and ruleset destructor
Date: Thu, 30 Jul 2026 22:20:41 -0400
Message-ID: <20260731022047.189137-9-utilityemal77@gmail.com>
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

Add the release kfunc for Landlock ruleset references:

  bpf_landlock_put_ruleset(ruleset)             KF_RELEASE

It is a thin front end to security_policy_kptr_put(), invoked with
LSM_ID_LANDLOCK; the handle travels in the Landlock member of union
lsm_policy_kptr, staying typed end to end.

A ruleset reference is meant to be handed over through a map kptr
field, so also register a destructor for struct bpf_landlock_ruleset:
map-held references are dropped on map teardown.  The release path
may thus run from a context that cannot sleep, which the
policy_kptr_put() hook contract requires implementations to support.

The release kfunc is available to both program types the kfunc set is
registered for.  For BPF_PROG_TYPE_LSM, the filter only accepts
programs attached to the bprm_creds_for_exec() or
bprm_creds_from_file() hooks, where the upcoming enforcement kfunc is
specified to operate, and rejects BPF_LSM_CGROUP programs, which run
under classic RCU; KF_SLEEPABLE limits the callers to sleepable
programs.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 kernel/bpf/bpf_lsm.c | 67 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index dd58c5bd0119..877dd0352607 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -14,8 +14,10 @@
 #include <net/bpf_sk_storage.h>
 #include <linux/bpf_local_storage.h>
 #include <linux/btf_ids.h>
+#include <linux/cfi.h>
 #include <linux/ima.h>
 #include <linux/bpf-cgroup.h>
+#include <uapi/linux/lsm.h>
 
 /* For every LSM hook that allows attachment of BPF programs, declare a nop
  * function where a BPF program can be attached. Notably, we qualify each with
@@ -481,9 +483,49 @@ int bpf_lsm_get_retval_range(const struct bpf_prog *prog,
  */
 struct bpf_landlock_ruleset {};
 
+/*
+ * The sleepable LSM hooks bpf_landlock_put_ruleset() may be called
+ * from.
+ */
+BTF_SET_START(bpf_landlock_kfunc_hooks)
+BTF_ID(func, bpf_lsm_bprm_creds_for_exec)
+BTF_ID(func, bpf_lsm_bprm_creds_from_file)
+BTF_SET_END(bpf_landlock_kfunc_hooks)
+
+__bpf_kfunc_start_defs();
+
+/**
+ * bpf_landlock_put_ruleset - Put a Landlock ruleset
+ * @ruleset: Landlock ruleset to put
+ *
+ * Release an acquired reference on a Landlock ruleset.
+ */
+__bpf_kfunc void bpf_landlock_put_ruleset(struct bpf_landlock_ruleset *ruleset)
+{
+	union lsm_policy_kptr policy = { .landlock.ruleset = ruleset };
+
+	security_policy_kptr_put(LSM_ID_LANDLOCK, &policy);
+}
+
+/* Destructor for referenced bpf_landlock_ruleset kptrs. */
+__bpf_kfunc void bpf_landlock_put_ruleset_dtor(void *ruleset)
+{
+	union lsm_policy_kptr policy = { .landlock.ruleset = ruleset };
+
+	security_policy_kptr_put(LSM_ID_LANDLOCK, &policy);
+}
+CFI_NOSEAL(bpf_landlock_put_ruleset_dtor);
+
+__bpf_kfunc_end_defs();
+
 BTF_KFUNCS_START(bpf_landlock_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_landlock_put_ruleset, KF_RELEASE | KF_SLEEPABLE)
 BTF_KFUNCS_END(bpf_landlock_kfunc_ids)
 
+BTF_ID_LIST(bpf_landlock_dtor_ids)
+BTF_ID(struct, bpf_landlock_ruleset)
+BTF_ID(func, bpf_landlock_put_ruleset_dtor)
+
 /*
  * BPF_PROG_TYPE_LSM and BPF_PROG_TYPE_SYSCALL share their kfunc
  * lookup buckets with other program types, so restricting the LSM
@@ -498,6 +540,17 @@ static int bpf_landlock_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
 	case BPF_PROG_TYPE_SYSCALL:
 		return 0;
 	case BPF_PROG_TYPE_LSM:
+		/*
+		 * BPF_LSM_CGROUP programs run under classic RCU and
+		 * cannot sleep.
+		 */
+		if (prog->expected_attach_type == BPF_LSM_CGROUP)
+			return -EACCES;
+
+		if (!btf_id_set_contains(&bpf_landlock_kfunc_hooks,
+					 prog->aux->attach_btf_id))
+			return -EACCES;
+
 		return 0;
 	default:
 		return -EACCES;
@@ -512,6 +565,12 @@ static const struct btf_kfunc_id_set bpf_landlock_kfunc_set = {
 
 static int __init bpf_lsm_policy_kfunc_init(void)
 {
+	const struct btf_id_dtor_kfunc bpf_landlock_dtors[] = {
+		{
+			.btf_id = bpf_landlock_dtor_ids[0],
+			.kfunc_btf_id = bpf_landlock_dtor_ids[1],
+		},
+	};
 	int ret;
 
 	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM,
@@ -519,7 +578,13 @@ static int __init bpf_lsm_policy_kfunc_init(void)
 	if (ret)
 		return ret;
 
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
 					&bpf_landlock_kfunc_set);
+	if (ret)
+		return ret;
+
+	return register_btf_id_dtor_kfuncs(bpf_landlock_dtors,
+					   ARRAY_SIZE(bpf_landlock_dtors),
+					   THIS_MODULE);
 }
 late_initcall(bpf_lsm_policy_kfunc_init);
-- 
2.54.0

