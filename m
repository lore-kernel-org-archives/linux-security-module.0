Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722BB2773E5
	for <linux-security-module@vger.kernel.org>; Fri, 17 Oct 2025 20:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760734147; cv=none; b=iogrGefOCGpnpeqoQ2eY/Z9o8ub+5Bfi1Y3IRfQBFQbzEyehs3U1mpnqAGXrxSsScKfE2Q1V3HcW7fgzc4km3y1UUemwL1k14bo4SmNd3na7cOg1HewTTU1+tNOGBoANZOlSD5OcwoW/9/aXjRJTmzmmQOZ9C4vGt34qu+cgNiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760734147; c=relaxed/simple;
	bh=OLELdDFfhMbHi0pVm5NnWQWxFQFlODpkZDMVPFQ4JEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a5uHs+9ZMKD6Lz9WttXh6fGQHs+Ksl3chHMnLaExI4fxQsffjghOwPeJCmjC2wTp+AisqRQ3kb+wBZuuaMm5bY5piOYVCTGQKiZ8jThkkg203/7OqUbv5XLm7TplBswGL5gpBCR6egckjMb3uWyXjhqLhVeG56yafoxDBvcBwH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Up3Id0MX; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Up3Id0MX"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-88fca7a60cfso391140085a.2
        for <linux-security-module@vger.kernel.org>; Fri, 17 Oct 2025 13:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760734142; x=1761338942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+mPR5Z2Gcc0qWocHencxRkWKoEfhfiz98yuE4PxUUj0=;
        b=Up3Id0MXQaFZcUopKknIjzOGON1uskV2rnU13nSso9haNBJsX8lrBbehjsK4jbhawQ
         eguPR2B8tSAYKJ/RQIfHZv1yZEyGl7zH0PkaZdFIjTVIbgkwrMq0EDerjUvzdtht/MIW
         pgT4fg16Xy1e4CpxpILkSzWR+7WBq3UQSsYtHMYsstwkUCGkdb7gSdn7oXevGQ20cXZ+
         OPAga/lqracHFFsMYuQQVGG2F5reCHxHdvr35pHvIx2NgEUr+rwASj3uazSHt8lEqxvs
         jamm/cJybmQtSVA4/aXn/vl7fBLp1QtE9KeoRMiFxxA+sgufVyXa36e6yOesIgWBlrLk
         aWgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760734142; x=1761338942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+mPR5Z2Gcc0qWocHencxRkWKoEfhfiz98yuE4PxUUj0=;
        b=gSUq7L08zq0WVapzMu1rJGgWRw8moHOi/t9pUMzzkQHHe8mL2cZ18GqQ/krONAKo28
         mAefFf9QbsfZWpwGzRFxXhxqG7lobf8VpNQBl6Tc9DCVuwBVs5XP1kbgVsQH/z/AKyzP
         dkEEl3lNa9F85z8zuqFOht9mHKFKc14p/9d82K/PLuZw/c7R/rofcDMHD0cvaKKW6SK+
         ufEmEas9S6XGBls5qi2/MZA1dsO3penpFnZnEMF/2/dEu7Ya3WlxlEvGwsQdBc1P/j1a
         CrTLUXp8aNtnNvh1qzesuFNh2P9CgNr+GqrDGFflrh70QcSZnSlhXOS6C+qCMumSSR4/
         fPwA==
X-Gm-Message-State: AOJu0YzDOM2rB1/AxYcwvphdmlCAw79dzr6qQmTqNAQZdj1OPB6KoR7G
	UonUNq+a4a/37le7NFyPHMBsbHU9Fbrt3XDS9578/SCTB/h3RRGt43hZ/5XD7YxzYtVj4Y0OZE+
	6vNXlnw==
X-Gm-Gg: ASbGncuhtFriR5sGRV93HLDO+zX5vEfxi/IXLhdtzk3rR6ocAfx9L8kRv2E6BsPlA7F
	9Q1y+GiCDVHWRLonmooDbP+ZmBojarHWONx2plC1F+HDHzdph+BVN6XKHQI97mulZeXI1D9/ODC
	nfbJZLzfI5nnz41JYQglqIvprrGCLolbxzrhE00gRGnB7ym8Kd44p1YRAxOqUtflE8d6BF77DuO
	mgF7bSqwV9Xz/6Qe3AG1sfIwG4XGq1jE5qdKoTlMAKJSJ5AdBfOVvZKvtbSQp7wDOC3Vgo4cjE0
	hdm0OMpRgFBWVaEpOYD93OiaCSgyljBXtoJ7cCsRmftiVaHpGbNSTHuWflCkequRvC4+/Z52R6R
	5Lm8B+8d9byiAEffzZQwpB1dodyawzrO9nXpq2beNYri7eBiHuqJaWKYgtJUxX40d57ip715v6N
	J4C3tJMUtTh+if0pVM5T7Vat4Om1lqJyHOKWxOQce0LRltlw==
X-Google-Smtp-Source: AGHT+IFgGvDKMg2kdGEzMfJ1PJCEdg2a1D2Jw5VT8/dDH35M3p3PY8ya206z/fh4X16Z1L5b1IQMgA==
X-Received: by 2002:a05:622a:11c7:b0:4e5:8cc4:4784 with SMTP id d75a77b69052e-4e89d29a9b9mr64829751cf.37.1760734142403;
        Fri, 17 Oct 2025 13:49:02 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e8ab10da83sm5063521cf.39.2025.10.17.13.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 13:49:01 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Cc: john.johansen@canonical.com,
	zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	wufan@kernel.org,
	mic@digikod.net,
	gnoack@google.com,
	kees@kernel.org,
	mortonm@chromium.org,
	casey@schaufler-ca.com,
	penguin-kernel@I-love.SAKURA.ne.jp,
	nicolas.bouchinet@oss.cyber.gouv.fr,
	xiujianfeng@huawei.com
Subject: [PATCH v5 06/11] apparmor: move initcalls to the LSM framework
Date: Fri, 17 Oct 2025 16:48:20 -0400
Message-ID: <20251017204815.505363-17-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251017204815.505363-12-paul@paul-moore.com>
References: <20251017202456.484010-36-paul@paul-moore.com>
 <20251017204815.505363-12-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3625; i=paul@paul-moore.com; h=from:subject; bh=OLELdDFfhMbHi0pVm5NnWQWxFQFlODpkZDMVPFQ4JEA=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBo8quftjQ7TZEQi0O8JLfy9rNLVJEY0sRKSwolN 0fKCQ+45nmJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaPKrnwAKCRDqIPLalzeJ c7vpEACwZZ0pEDFYUcAO3OdvT28s/OiFsoZ+CPvGzGRLhAyA8SKMt2U2khiP7IJgMY20xlYyNap p3N0qP9h8xAW0gWWIWSdjUTOMzG5Hhok74pULPNq3ESQsOmwBhwBQByMdKTN8ZeBTLyJfaSlpT1 QoQe/Bxic8Uem/VYGZTXns5TD2J/hgjUEKeynjgm4fr+vm5ufmXRG4gVI21oIW7UvhkVEvnEROO g9PsuXvs65NmfBjVPgpRmiq/UqccwlDlyqcmPCP6bpQ1F1E8YxapEzCksEjhRCLg4B064YUPYJ5 /7zor320pg6TiYVbpFbk7rMlByWdD75/CqKS8R1/tv60FTnoASVjtMqtWLN2n631XKQAn4bXDI8 mIcB9wfdBk5QQW4xOAeyZlJB1hm9tPSTO3oLzy8ox6tYHIs/pmoRbyOAUnddzZ3HHgAUYTBZ7n8 eZ3FO6CCXlQOJg7iCqIFzVZemeWfuqvh+JQp3OmU2bYacHzFKeFYu5gWutl8u5qyOxHAQPk4feM OCRU8LTHHPHEi80sYYgn7xc0ju1N6ARa8ZFpn+h3hKsC4dcRVjlLioeeM56RLaopIC66/AQYLgO 2q3mJa4pltRUlbtvKH+ad2nOeGibAHbNToXNmTBOA+cXn/fia++txcEqupGuWH0R3as6Tu65K9K 5lI4X/9Cw66Z4Lw==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Reviewed-by: Kees Cook <kees@kernel.org>
Acked-by: John Johansen <john.johansen@canonical.com>
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
index f6798144234b..a87cd60ed206 100644
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
@@ -2560,4 +2560,11 @@ DEFINE_LSM(apparmor) = {
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
2.51.1.dirty

