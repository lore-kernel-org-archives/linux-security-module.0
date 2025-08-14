Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B549827A906
	for <linux-security-module@vger.kernel.org>; Thu, 14 Aug 2025 22:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212101; cv=none; b=P/9GEsb1CLlbU8g+D2qG+T/J0eo50fJlX6ZKJ++idtW94Aiea9RadMvUPbMdt8qUr/+XqcwKz+6RQCE8WcN5kIK7FRBouXgNTJ4MMAsl1oRk0QzktedZFQAa3tJU7qgX0t/WcSp78SmMIgOolA8TsRs9PT/b1xMQqHnK9EuTI6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212101; c=relaxed/simple;
	bh=fINgjLvR9vHRTLe7I5HnSqkWt2LFS3fXsX9vyACGxyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jqp2HJgHh+EaXsogxDZCKbYgnTqehMTaRvfwhaeAsFFO3+YckNAgO4qkQquGdacbXJAEutdY632XFjGV42xcDSYA/I2zGDiBNSTDaWfOcYvMy5/aM9E0LNWj1ynOjLqRz2Lr9mO+tkJenAVwNKrbePQ4cvlRt3NHkhhBJkUQJkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JdkTjRQa; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JdkTjRQa"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7e87050b077so170413385a.1
        for <linux-security-module@vger.kernel.org>; Thu, 14 Aug 2025 15:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755212098; x=1755816898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+qvcaR6bgG1oDs5Xnhcp2IPccAeb7IaTVMWUTCwZPk=;
        b=JdkTjRQaUEx3rvE/tmPBSDie+lIqbKCqMuPddPAq2g50I/EsEujjKxAK+u447T2932
         hmDqjiqHE/IJJv0B8IxWsBDZ1/dEFN5QW9zwUx64PJxo0Cxa0H0ouKu1e6Jz/NdEfR1y
         0XEa8U5dH6QHpqtHYobI4DCOjz5yIprgcYU+oo98KnygYZvxUG/p8hSgYQuS5Sg/3S/x
         KsAJPh8usGVPr1Lnp0o+Pht7m5++irjvddBa0UVHewfRfKOD2qpfjnnybdqQy90J3Fdh
         SQ6iMa0wEx6e/JYkNe9lgKyWBT/s6THIGWjJGEkpw7CZ8te/4xYCW+JTXobi+eL2BJiP
         aswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755212098; x=1755816898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3+qvcaR6bgG1oDs5Xnhcp2IPccAeb7IaTVMWUTCwZPk=;
        b=b0F0YKyWVdbxx4DfLuh1vn6yWZ3RD4Ppu08lZs2ONTgFOTTnfdUzj3kCaCCNlCRfKY
         uhwW0deQF97ZvbuSbFai824Ejcd9bnX+ZMAQH3peERIpkQpiULgiIlW4ACHR21QJ2y7e
         p8FWCJbxjauKgoYmG3STny/Cqx28ExCkyHaiGliselM2zkP+FywI7+B/Ma426N1VD2QO
         D8/TC72Ose1nxVzy5BA4Vaf95ekcUs8LzF9rBtJFWGywS4VYGtP3oVkqV6DPh6oaIhDG
         pkcEUOUK/uYJHyqSZzKPdWXm2k6ITp6loVpWB46756hE8vum6lvL3n7UXoevAGExklqJ
         GuAQ==
X-Gm-Message-State: AOJu0Yywvz8iUbn/kavrzAd/Vh1s4by9ZRk9GMvMqD0HUQilva5DeIpw
	tSGCbk8iNYlAQf1eLnXmF/FQnkocGau9IOuCkN4jVFFTr3aTNT1FLMf2fbA37W5uH65OKAZXPfH
	51GA=
X-Gm-Gg: ASbGncv414AIUx9XApXK/DfrB/G8XnopqrN72U3duPYTzOY5WA+IIwpBch9LRIKNq63
	N0NRbsWkDnuG3KBosx9uSA37CJNzJy5Y22gF+Slh3uUaCRoU3jSjg0RX07yGY7lGubKz4Cuo/iB
	8LC0F8hD597MHPPT2qeE68blZIGw/lgtJ++YXUpZaMf193gx0XOZAnjIDDQMlI0TcQxzphQhbOq
	DP6r5B6wopdiCgfSINIKxKkNQIyaJYeszwQ/vrfuvmYeE1E/KL722o799NoUpa7SokExKxslZ67
	xdGeK1l/PG6ypphl7xD3JOMfvU9Hegpgcvoi7fKTNcL6lc1rxkOaITvIlq11GRupB/hgIPOAG/t
	3+3//6XwM6orNAv1Y6DbwB7174ixNIlelowI7gcP41ICoUSSb57RcToJ0GCPuHTfTQ+A=
X-Google-Smtp-Source: AGHT+IFyuHvEfTTKuUEa6YrwUypNJMrELt+j2tMy3bXv/XBOD/MjGlOZ7JnhuH/KiolqDL/K/6corA==
X-Received: by 2002:a05:620a:708b:b0:7e8:6ecc:34e4 with SMTP id af79cd13be357-7e870474a38mr738480385a.19.1755212097988;
        Thu, 14 Aug 2025 15:54:57 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e87b32ef6csm44392085a.5.2025.08.14.15.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 15:54:56 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Fan Wu <wufan@kernel.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Kees Cook <kees@kernel.org>,
	Micah Morton <mortonm@chromium.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: [PATCH v3 29/34] apparmor: move initcalls to the LSM framework
Date: Thu, 14 Aug 2025 18:50:38 -0400
Message-ID: <20250814225159.275901-65-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814225159.275901-36-paul@paul-moore.com>
References: <20250814225159.275901-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3564; i=paul@paul-moore.com; h=from:subject; bh=fINgjLvR9vHRTLe7I5HnSqkWt2LFS3fXsX9vyACGxyc=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBonmjr3B/fgYtWsl/2TvI8r1DC3h2TvMeDwG5B0 ikj8vOV4fKJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaJ5o6wAKCRDqIPLalzeJ c9AVD/9/ukzzaeOHDfj484sz8me+GdinwypA9LKMkTkuX7kYGES+IY4jQdxmMqqdHHBzA6D7VNo 8utOfGU3x8gKoMGHmvqc2POAO4vfk8xcF/Lmn7c1pSJGcZnyapxVTvFl1n2zmNjSF3ZQVLAUKDm a81OGwl1Z/dyJUM11Qj+a7OU219AjZcZlovpQavxVhoHuYeu5IFqQsZGF/qe1G0OngRuHtC5hK0 E840mx8rdDFBbjIReeQSZWNP4w63FRhRo72Gzwnvc+c5/7xvewEbVcdaHLPEmuv02CP/gg8rJwY kRlDkPsgVBlqEFJ2ZcR3ESz9wyykdg8Gpd46nfonyRKcgVubhCfTN4L/lcxEE0/R/fZVCpaGpII tGIC1uDHPbipOWZgQMwU+NTKYP7VxDSJ2G38a4R79zOkRWgb8rQJvzLNv+DJz8LKkIJgVMc3akO BgYDF/E+zW9+z2DgPijLxLA0qAb2Sdm6LdXyti3o6uoyfLJFfLDWDLcCAQTMqqCJ7AYvdENnRjp +KmLTDG7HCJvUcDCJprxqVvNdIR+KD4W3mwtfn4G7DYXXGzplnuVbhr2tSf6RaYKsBAPMYTEvh1 oX7irszQ2GKhG8jAjW15+VzXXeqeFS2UqqYhXXm3zegEIkFw3snQguMP3CkE/y7jeMa4GMdK0Dy BiixpxrH8mH7tTg==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Reviewed-by: Kees Cook <kees@kernel.org>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/apparmor/apparmorfs.c         | 4 +---
 security/apparmor/crypto.c             | 3 +--
 security/apparmor/include/apparmorfs.h | 2 ++
 security/apparmor/include/crypto.h     | 1 +
 security/apparmor/lsm.c                | 9 ++++++++-
 5 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 391a586d0557..ee04c1ac9d6e 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -2649,7 +2649,7 @@ static const struct inode_operations policy_link_iops = {
  *
  * Returns: error on failure
  */
-static int __init aa_create_aafs(void)
+int __init aa_create_aafs(void)
 {
 	struct dentry *dent;
 	int error;
@@ -2728,5 +2728,3 @@ static int __init aa_create_aafs(void)
 	AA_ERROR("Error creating AppArmor securityfs\n");
 	return error;
 }
-
-fs_initcall(aa_create_aafs);
diff --git a/security/apparmor/crypto.c b/security/apparmor/crypto.c
index 227d47c14907..d8a7bde94d79 100644
--- a/security/apparmor/crypto.c
+++ b/security/apparmor/crypto.c
@@ -53,10 +53,9 @@ int aa_calc_profile_hash(struct aa_profile *profile, u32 version, void *start,
 	return 0;
 }
 
-static int __init init_profile_hash(void)
+int __init init_profile_hash(void)
 {
 	if (apparmor_initialized)
 		aa_info_message("AppArmor sha256 policy hashing enabled");
 	return 0;
 }
-late_initcall(init_profile_hash);
diff --git a/security/apparmor/include/apparmorfs.h b/security/apparmor/include/apparmorfs.h
index 1e94904f68d9..dd580594dfb7 100644
--- a/security/apparmor/include/apparmorfs.h
+++ b/security/apparmor/include/apparmorfs.h
@@ -104,6 +104,8 @@ enum aafs_prof_type {
 #define prof_dir(X) ((X)->dents[AAFS_PROF_DIR])
 #define prof_child_dir(X) ((X)->dents[AAFS_PROF_PROFS])
 
+int aa_create_aafs(void);
+
 void __aa_bump_ns_revision(struct aa_ns *ns);
 void __aafs_profile_rmdir(struct aa_profile *profile);
 void __aafs_profile_migrate_dents(struct aa_profile *old,
diff --git a/security/apparmor/include/crypto.h b/security/apparmor/include/crypto.h
index 636a04e20d91..f3ffd388cc58 100644
--- a/security/apparmor/include/crypto.h
+++ b/security/apparmor/include/crypto.h
@@ -13,6 +13,7 @@
 #include "policy.h"
 
 #ifdef CONFIG_SECURITY_APPARMOR_HASH
+int init_profile_hash(void);
 unsigned int aa_hash_size(void);
 char *aa_calc_hash(void *data, size_t len);
 int aa_calc_profile_hash(struct aa_profile *profile, u32 version, void *start,
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 45b3a304d525..647c13e13e63 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -32,6 +32,7 @@
 #include "include/audit.h"
 #include "include/capability.h"
 #include "include/cred.h"
+#include "include/crypto.h"
 #include "include/file.h"
 #include "include/ipc.h"
 #include "include/net.h"
@@ -2426,7 +2427,6 @@ static int __init apparmor_nf_ip_init(void)
 
 	return 0;
 }
-__initcall(apparmor_nf_ip_init);
 #endif
 
 static char nulldfa_src[] __aligned(8) = {
@@ -2557,4 +2557,11 @@ DEFINE_LSM(apparmor) = {
 	.enabled = &apparmor_enabled,
 	.blobs = &apparmor_blob_sizes,
 	.init = apparmor_init,
+	.initcall_fs = aa_create_aafs,
+#if defined(CONFIG_NETFILTER) && defined(CONFIG_NETWORK_SECMARK)
+	.initcall_device = apparmor_nf_ip_init,
+#endif
+#ifdef CONFIG_SECURITY_APPARMOR_HASH
+	.initcall_late = init_profile_hash,
+#endif
 };
-- 
2.50.1

