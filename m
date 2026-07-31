Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7360F32E696
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 02:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785464486; cv=none; b=FrBrw/Ka25k17zHnkjbsAm2yxQXkVpb03K0KdXRuBoL2c8dQtSmACM26UNd/i3unUnBQ5267ObznFEvtd5FkM/vkZnMxjLH2HFiDFfmESi5SiPHawq+ba3n19Pgx/HOdmUpWSAoJJnRsoO7Xiqf+p89g4v/PL0DtfmetkEMFpJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785464486; c=relaxed/simple;
	bh=Wl2UCxtNmzLVXv7d2dxNGx2+o2cZF0FTl7baGMMo3wE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=if8NIbfGAQCI+AqZVOmkOldqnjgmsPqALiyCJKdM2ivttm5m8/r9RiLPS2622cW0+fI3BJK+7I9yxpLucJ1g2CniRcYDbMgPAf67H97Vwir9bgkbxWNxf+7jGe1EE5qJHbTDvfl6xJbug6X0SEg8EUsdQXqkfosP4xPa8l9bpjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FXAGKQJQ; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXAGKQJQ"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-81f3b227a4aso7493317b3.1
        for <linux-security-module@vger.kernel.org>; Thu, 30 Jul 2026 19:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785464483; x=1786069283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LFpwdBGwLOjN+6goU5qnqwdSehafEaJ80d3ncvWusC4=;
        b=FXAGKQJQOec3WtYjgKHjZBbm7/p5t+f7eLzZyKh+0LOPDJDbUXO+pHp4VVPs31Yk1i
         Py76tUQvd+h6kOe4Lo33ooIJ4emHwrokYRXbHoNmzy/Q96UlJPak8CftJiHPJlJJfYdk
         +BnbH0A7rFMhFT92Zo037zIfHUeGOX8Gpv1WXg6lJkMZnez0Nh36JGyxWhesM8dGZTh9
         2N7JKmSqdVa7qWvgm7a2Km03RjWkVHdlfpZUC8GWJ5cBs/FeuAWZCozfjGyxKY6/Poxq
         xUC78orml7jaDczQ/LXvsvWrD4LwqrHfjLQqqigvk0jmO5gbzfWDyeIPPgERcs4u5gQ+
         sYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785464483; x=1786069283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LFpwdBGwLOjN+6goU5qnqwdSehafEaJ80d3ncvWusC4=;
        b=MDNyscVykCyJC1OJCzoVS+Lcx5Db0T8yBIWwr7WEHtOMolzPZyYd51dSv3FOymqh4s
         uNBIzSRRo0eJAIoC6rANKJEuPwriggI3+q6R6sUEX+O2lMO4+pSwESoSo4LSMSr0L5/1
         EgY6LUWvGQksqaAVEjfWUeAMsV0sgwhpll0azM2q3MqqPWLo1a/dOywu7PKa5TPbVoHX
         zfQL7koll1dwsvgkvPW+7LqWEcU7N/denE6h+eA+g7oBNERWwEAZwuCWiWz3fCyATHTd
         adXh3FImZUYEuE1uGKK33JCb6kh3exKsB06UNmvOD3grGB5DGi44nRODAS1rHKJyEHA/
         5Pbg==
X-Forwarded-Encrypted: i=1; AHgh+RpyUUZgkbajQBFbmCF0mjn8o9Jjv70ADrEhvtgWa1NoExcW20XSfFQrxbKE0Z2byXRTuy/ER45WkDoN1IchEdKm3usbleQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6Z7YBp0morLEZN+2eLlGV7Cvweg5xzcLHoWycJrPzZnP2iJEZ
	3cBNCkeXHf140dJ0UF00dZfrJC1FiE6VfrSLKBuRANgCmaVcJIseM0mC
X-Gm-Gg: AR+sD12Bd52XeU6E26sRWm/0wVgkHv1gGHQVMXRmJ3qNxsWACdwI68K0aRGJ8DTfyvL
	M4H96sovSJCOU9Bk2JoFKkYn1QdtQGxIfADk3SlhZnmt/JGW74zwEXDSaMQtsgCQM2knrUPFuV9
	fhLGBYyFPETf0eLqD86svmlsXI8vDlv1xMEl2ALMomLlvWXMsBj6nnuisOWdgdZlyzFt9u2Q5AP
	VcB25dY/fElyJtYiuKewwVdVgVHPqz3dOD071qccgKYpAP+oSXgw1ynbHA1iPj0BW8hFV02pGLb
	yqIyMqhP/FsCpN5ydnv6iqyD71ErT4swSWT/x830KrfEV5TuSCZSQA48d5Eukc1Pl3KaBDfHXAv
	YZtOOanAa7eZaa97Niu0ZciRhSG9k5vNzfYFcWfmg6Zl3JYZ5XBVJF7kc8FHo+86lzTf8TjuKFX
	MwsA2+8gm454waT/0P5MgOiFwxRGoLKRkXhk5zzMduP0meJswtfaNIBzR5p+genYRIO3Lfh5CrY
	iCcxqulScNiCmVdQ0DVaA==
X-Received: by 2002:a05:690c:9688:b0:80c:85c6:897f with SMTP id 00721157ae682-81fcbb332a6mr451497b3.62.1785464482738;
        Thu, 30 Jul 2026 19:21:22 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:e94:8a83:feea:6720])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fb8b26e8bsm20519047b3.47.2026.07.30.19.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 19:21:22 -0700 (PDT)
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
Subject: [PATCH bpf-next 07/13] bpf: Add the LSM policy kfunc infrastructure
Date: Thu, 30 Jul 2026 22:20:40 -0400
Message-ID: <20260731022047.189137-8-utilityemal77@gmail.com>
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

Prepare kernel/bpf/bpf_lsm.c to host kfuncs that let BPF programs
apply a userspace-created Landlock ruleset to an execution. The
kfuncs will be thin front ends to the generic LSM policy kptr hooks
(security_policy_kptr_from_fd(), security_policy_kptr_put(),
security_bprm_enforce_policy_kptr()), invoked with LSM_ID_LANDLOCK
so that the LSM framework's targeted dispatch only ever reaches
Landlock's hook implementations.

Because of the hook indirection, kernel/bpf/ has no build-time
dependency on Landlock: the kfuncs are registered whenever
CONFIG_BPF_LSM is enabled, and calling them while Landlock is
compiled out or not enabled in the LSM order fails at runtime with
-EOPNOTSUPP through the dispatch miss, keeping BPF program loading
independent of the boot-time LSM configuration.

Add the section hosting the kfuncs: struct bpf_landlock_ruleset, the
opaque BTF-typed handle for a Landlock ruleset that only Landlock
resolves; the kfunc id set, registered for both BPF_PROG_TYPE_LSM and
BPF_PROG_TYPE_SYSCALL; and the kfunc filter.  The two program types
share their kfunc lookup buckets with other program types, so
restricting the kfuncs to them requires a filter.  The set starts
empty and the filter has no per-kfunc rules yet; the following
patches add the kfuncs together with their filter rules.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---

Notes:
    I decided to put the kfunc implementations in kernel/bpf to better
    delineate the separation between the BPF facing interface and the
    LSM framework. Since this file contains things like the BPF contexts
    the kfuncs are allowed to be called from, it's important for BPF to
    control that aspect.
    
    I'm open to moving it if there is a better preferred location for
    these under kernel/bpf/ other than kernel/bpf/bpf_lsm.c.

 kernel/bpf/bpf_lsm.c | 50 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index d847a180489f..dd58c5bd0119 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -473,3 +473,53 @@ int bpf_lsm_get_retval_range(const struct bpf_prog *prog,
 	}
 	return 0;
 }
+
+/* LSM policy kfuncs */
+
+/*
+ * Opaque handle for a Landlock ruleset.  Only Landlock resolves it.
+ */
+struct bpf_landlock_ruleset {};
+
+BTF_KFUNCS_START(bpf_landlock_kfunc_ids)
+BTF_KFUNCS_END(bpf_landlock_kfunc_ids)
+
+/*
+ * BPF_PROG_TYPE_LSM and BPF_PROG_TYPE_SYSCALL share their kfunc
+ * lookup buckets with other program types, so restricting the LSM
+ * policy kfuncs requires a filter.
+ */
+static int bpf_landlock_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
+{
+	if (!btf_id_set8_contains(&bpf_landlock_kfunc_ids, kfunc_id))
+		return 0;
+
+	switch (prog->type) {
+	case BPF_PROG_TYPE_SYSCALL:
+		return 0;
+	case BPF_PROG_TYPE_LSM:
+		return 0;
+	default:
+		return -EACCES;
+	}
+}
+
+static const struct btf_kfunc_id_set bpf_landlock_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set = &bpf_landlock_kfunc_ids,
+	.filter = bpf_landlock_kfunc_filter,
+};
+
+static int __init bpf_lsm_policy_kfunc_init(void)
+{
+	int ret;
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM,
+					&bpf_landlock_kfunc_set);
+	if (ret)
+		return ret;
+
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
+					&bpf_landlock_kfunc_set);
+}
+late_initcall(bpf_lsm_policy_kfunc_init);
-- 
2.54.0

