Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54756255F31
	for <linux-security-module@vger.kernel.org>; Mon, 21 Jul 2025 23:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140275; cv=none; b=GgJkn5lJnLIV9iGbl7aWB7r23UGApRzOpzIU/KR8V+qoSdWJYA5oNFoWp4eaIxoSS5fXzq8b0OXymdNgUTc3dynrQ4sb0EmgJHrTG7Wsm363qvFG2yaNWrKLZYVTSEuzTvKlYfoobvnwdS1gduhGu1/kkWkEuRuyx6FbDu5M990=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140275; c=relaxed/simple;
	bh=+gdQ1Czu7rv7jdTTczvi1RYieE4Tkxnqe62OiAJK00s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nYbtBc6xv4CMUbHPGjo3BtgOz7DWjh0606A05WxqEyFTxoJIeV+C1s6aRjJ37IS+jIPrCOAv51UGX1zTFUDR0dvCjjFMlodsGHWxjPTKOYtgX6ccP2s0jTFiewYQGj94ZLZJ6Po3ZfJUAiknfuyxl3OKlU/rTLgNR6f6pAg8qIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RMO6Rapk; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RMO6Rapk"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6facf4d8e9eso40379886d6.1
        for <linux-security-module@vger.kernel.org>; Mon, 21 Jul 2025 16:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753140271; x=1753745071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FiA+OJUaAzDTv5PHcF3sh1p3tu3Ya4mB63tPg4bKqH4=;
        b=RMO6RapkzDCyp+WnyVhxL7lNRuTSKPP+nXFeL+OTf/lfhokG5yndvPPuerJBYJmxtI
         PYYWLF/3T4BKDasNOp0J21UIEAnizRFmI3AkKb8FoMpeCnFJuFpej1UOygr3jB79C8QN
         yyKAtLQiHgPJ2+0PY/LuXAlEsbp5LiZsnAss57R8MCT5rbik2ZzPyB9JXe3EXclwnvza
         k8e2J2/uSqGxESC2vSug0tY25hLqi07frR9V1RW6ictSr16h3YVM2hd9ts+9uEV1Hoy4
         UyCaiAovie3Lns+wUdt4ji/kT/s8kKmvWR58UBiRgsuO0MzDAXH7PxyxwW5+Cgoe5USW
         gFrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753140271; x=1753745071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FiA+OJUaAzDTv5PHcF3sh1p3tu3Ya4mB63tPg4bKqH4=;
        b=v7oMWtglzGSfYhBkIRqqPMF5UDDs9qS45g8LulyAkAXflco3pP19C+1QH2xd+Djup5
         runG6WYah6X4mpgYx+d4VUxmZFCopmwZ6YWVwONE8j2WMqT7ZgqQmUOjup2ZSc55Moc3
         LQxljQtMoDchP2fqXos2zvXQ+GVsIYL73GDx5Qf5ZY6LV3/dzwOfpna7AYnwxjAj14l8
         H31Y+HO30d7Z15geX/Fg+H78iEASDxukmWKyZNHAD5lD+FJMH8orSVAsqIBtl1PFPzEO
         dvT6SUO5rPVu+f/IyaMK9iR4eUiFd9+MV9AjayxORgJEmG43qHEyYUF4Q35WebqFADdD
         qXBg==
X-Gm-Message-State: AOJu0YyJqJ0XXRCmfWM/wnLy77FfMHEe1H+z6r86evHfUCqrR+4x2hMw
	wB15q85Y89VKNCt9ksvum9nFLfPB3QMke2ZoTuKZBpZPAxjz/uItbkosGysgU/4w7HZ0RSHTBUp
	PRr0=
X-Gm-Gg: ASbGncuW1qJDAl0OtBBEQ1qcAEL067lPG3MaI1Ku/bncRfJaJRRkVu4nCDLyN2ayRe7
	aLfkMKd8nQC1fN5Y84shMI3JSSxtLQRvK0BXR9mJW74ntUbPpuepwmA8GbOUTosFMkueliz6NKe
	0ZYqymNqaO0V1Z2SegpvS8lMpk3RliLgAn1i0pye8ygba/qOdHIqfmZFrap9ZuLeyxBoQ3L5TMl
	s5c0DnZ/NYgQ/hot65lfUr4NRGNuJf3Z3Xud2r/SZx11jES4W5GA+lDVyfeSxixGRTg/VRuiqc3
	3OqI1zWgly/pMtK2KCkSX4LnnDyiWjjkvZjpf8SJ3akI2kj3zsNIG7Fdxf4YPVss5vTElH/Hn1k
	3j92qbEX5VbCcmsLNRZETYKQZ3iyyF2lKj4IoNoz8xIp0b9rYVXDSr6uRSmflwyzBjmM=
X-Google-Smtp-Source: AGHT+IEJYlolQFTaUn6HdlFtxzYbq+OWBtBbLKQwUX9IaoI3NSxY1nHpuB/NK8zVy0VsghQAZOws0g==
X-Received: by 2002:a05:6214:c2f:b0:704:9bc2:be36 with SMTP id 6a1803df08f44-704f69fdcefmr429300856d6.7.1753140271240;
        Mon, 21 Jul 2025 16:24:31 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-7051ba8df3fsm45917276d6.79.2025.07.21.16.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 16:24:30 -0700 (PDT)
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
Subject: [RFC PATCH v2 29/34] apparmor: move initcalls to the LSM framework
Date: Mon, 21 Jul 2025 19:21:32 -0400
Message-ID: <20250721232142.77224-65-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721232142.77224-36-paul@paul-moore.com>
References: <20250721232142.77224-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3564; i=paul@paul-moore.com; h=from:subject; bh=+gdQ1Czu7rv7jdTTczvi1RYieE4Tkxnqe62OiAJK00s=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBofsvv6v4jeR0i1ABMksbYtivuhAW46UQ0diKcZ EBKoa+lOO6JAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaH7L7wAKCRDqIPLalzeJ c3m6EADW6MDxdj8pJsfgiw/fl7aMHs4m700QgWzXJYmHHH7HRXEV/xeooRmyRUFw7+5oKTVwoD/ YPrhY/PiSRlNJqDdjLXBiuoWUwFmpP21JfDNd9noEE9k4qE5AbrUKlPro+y1Py22uoytXogWXty 8LBplAGhdPIInIEzZcjhsps88bpB6Vk/vTVyiL2xVIzec5BOfq8XD7+XEYETDqvIId1TRjvNWew ERknhdwCk09irU9Vo9wYIeTak867TvWff5v1KFgC2UkQN0QmHXFsxvU/a7RBE5ghJiENvRhS9oI cn7PS3D1dX8q5Wh1lFD3tUWdD81tA/uBLLX1ZyU99vDg55mg72M3k9NIQo93PoPiNPhb2niq5Cv RgAanmcx76UBs4VVN/IMBeXd0K0DbMEspFb1HU1rtjzVbOljNFDoyIZY3iB7iirt/8ZYfx/UuLg 63qpJ0SBeg3Hn0hvbkpYnG2ZSzdSQZYMG6R/LGwojPkyWkBIdcXY7ouSvZgnuAJkbc41uecM1P/ p7rZc7J5eQeE9XRABYr4sndvtwV2P5U4T0rqt5LRS+U+JIQ8JZumj8RVDDfot/vz1YWY30+xhwN v3zUYgUXoLO4lUf9A9xedmC5JEQNikht9/1lQb6UrLNtdzKQMaOVRoQ0v5+L+dQ7ffqRqdxjGdz SrZguKNQPcNs61w==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Reviewed-by: Kees Cook <kees@kernel.org>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/apparmor/apparmorfs.c         | 4 +---
 security/apparmor/crypto.c             | 4 +---
 security/apparmor/include/apparmorfs.h | 2 ++
 security/apparmor/include/crypto.h     | 1 +
 security/apparmor/lsm.c                | 9 ++++++++-
 5 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 0aef34b9609b..02fbc7aa072c 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -2632,7 +2632,7 @@ static const struct inode_operations policy_link_iops = {
  *
  * Returns: error on failure
  */
-static int __init aa_create_aafs(void)
+int __init aa_create_aafs(void)
 {
 	struct dentry *dent;
 	int error;
@@ -2711,5 +2711,3 @@ static int __init aa_create_aafs(void)
 	AA_ERROR("Error creating AppArmor securityfs\n");
 	return error;
 }
-
-fs_initcall(aa_create_aafs);
diff --git a/security/apparmor/crypto.c b/security/apparmor/crypto.c
index aad486b2fca6..e4395c1bfac5 100644
--- a/security/apparmor/crypto.c
+++ b/security/apparmor/crypto.c
@@ -99,7 +99,7 @@ int aa_calc_profile_hash(struct aa_profile *profile, u32 version, void *start,
 	return error;
 }
 
-static int __init init_profile_hash(void)
+int __init init_profile_hash(void)
 {
 	struct crypto_shash *tfm;
 
@@ -119,5 +119,3 @@ static int __init init_profile_hash(void)
 
 	return 0;
 }
-
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
index a7f6a3274682..2fefaab6349f 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -31,6 +31,7 @@
 #include "include/audit.h"
 #include "include/capability.h"
 #include "include/cred.h"
+#include "include/crypto.h"
 #include "include/file.h"
 #include "include/ipc.h"
 #include "include/net.h"
@@ -2146,7 +2147,6 @@ static int __init apparmor_nf_ip_init(void)
 
 	return 0;
 }
-__initcall(apparmor_nf_ip_init);
 #endif
 
 static char nulldfa_src[] = {
@@ -2277,4 +2277,11 @@ DEFINE_LSM(apparmor) = {
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

