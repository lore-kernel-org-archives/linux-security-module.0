Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40833279359
	for <linux-security-module@vger.kernel.org>; Wed,  9 Apr 2025 18:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224834; cv=none; b=iW/ROZeAyh3l3YexFE7ENzX4yF9ZW4Pp/JOgbBs20B/O+UqVJWWhb4N2t3OiCRbFSHzxnau7ADP5DJVXEhwnM5G9Tmv12foc8KcFSuSk+oRYNkfe6zZ4hmG53/thIosoBf33Hkeksexi1hzHPHlEz2f6dcIATi2kAoU4wBNNZ/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224834; c=relaxed/simple;
	bh=o9kemQg2ZrcZ++q3g/lVrPZOr+jvZkLZMu//o1GFu5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O35YIe3FGl/7pmZTVEC4AsyTK9LjDW/Zyi7rxEgKbzPXbwVhNd5eeM8zRHbSdIni8t4dIG8zGNTRB1Nlc3ZRVf2KuuA46VJ1klcDnC8AeDvCCOc+j9pqPVOBGQY50ou3Zrni0Ifbb+e7Xu4pGKMIqkx3Y6m4vP8nlJc8CPjozMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=G1a+k6Ja; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="G1a+k6Ja"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6ecfbf1c7cbso119531866d6.2
        for <linux-security-module@vger.kernel.org>; Wed, 09 Apr 2025 11:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744224831; x=1744829631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5gq/nNyMiHZBvGSIX/mJ97n45zcpCP+F85FIHz03xjw=;
        b=G1a+k6JaaqG9O0j7MNju4IWQkRpQge5FRvBIOxORQbie3BR+GcRSPa8cvmVozw8MYT
         logS59QCLl8mGho7JFEmV31PGLoCr8hAgN2RiCAftrY455ikmDh2+OiBjiiZzwawASHw
         Y4U5sc5eKvNvB9Rj2K2bu5knqfbqZBHgPBcfySMm/qWMZjk2ocAezyAXBASSKFwR77EI
         Nj6p/3kjvB3koAlqWLAYTk5Kz41QjjPRM6aGWS+ejYNj+o+UED9U6A6pIpx8hFtLbvc+
         12iij14bqAuexP6Q1UZckbYrMXyvI2JQF8XqXv2fJVusAZWOAqsag/exp4MD9NKD9N3f
         Ntgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744224831; x=1744829631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5gq/nNyMiHZBvGSIX/mJ97n45zcpCP+F85FIHz03xjw=;
        b=ZYnN5uUiPEK6GS9dnSYBqo0TZUAq1WxJnhQU3mNx7+97qJ3anj5ADa2ybFcucJRM05
         naK4ER5vcBwQajrf/DCUZb/YjaEUgt9I8nSYzSj9oVIK/BMWf+4+NvWPD6IsRYbHFtfW
         EwcvSAFP/ObwAhwoKv/ERDlscB53l/Skfyk2pXY4SH+MKMmnNrKqfe43ks9KI8VNi2ZH
         8q7KdGVOuuyiPqgYiUnqGWMb4yInygsH+/9GRc/79j5A5MiaUfWIgVSkfUnRQB239Mte
         wWt3n0k7VkygqsQ5yMvdB8JU5GaTD8an8WEpcqa6D01vMaxKGsK5uk5J11pxsnjflCc0
         Pimg==
X-Gm-Message-State: AOJu0YwoCum722BzXvDisuBRhOx75Cl3fm3EIO3OV3bfqy0oxujnkdnl
	lSgmf/nneFg25gctWJEOFTIu1IFEOMaBung15YHlfiIiZQHCjM8Ifdfht2XCRAefW8FC79MwqYk
	=
X-Gm-Gg: ASbGncsNebNq1nAVOEU1cwOvNKR0ZPtLk7n8TSjDP5DsKfIW/DgMfpYvKRvZPb14Nhe
	TANr6KWvISSJk5U/V2VMKrBMJ4v7XLckI7HhEOWbEAikG5E429q0Rmqmzuhwbqy5PdOV07+KTr5
	TMuQZoY9M70VDlwI51bQfY0EbOldcFxDVlsHWJimXwIhCDOcf0NM4uQv+KrWvR2QPHL8VxI17nV
	sI8onbwD4z5EoXY1aL6IbEp8wfM4J0L7FCmMJDSrKT+ZTFuxuz7+ZYyavk9VMch86r9IZTF3mmW
	4Z30NFCWlCVwXxvS/b+mGYseUL0NedhA1UcPS94SWj08ZEZdte+Sm8jShei5Jjow33Su14rWNCv
	fnHwR4fzvqQ==
X-Google-Smtp-Source: AGHT+IERc47YhNjd68qKisl3YeXLOV6qZiNUCE9Ko7pcD1uZwQwJOKkg6wSZglwrVrKmilNNAGJuzA==
X-Received: by 2002:a05:6214:500e:b0:6e8:f99c:7939 with SMTP id 6a1803df08f44-6f0e5c4f53cmr364166d6.44.1744224831065;
        Wed, 09 Apr 2025 11:53:51 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f0dea07f3esm10479066d6.76.2025.04.09.11.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 11:53:50 -0700 (PDT)
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
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [RFC PATCH 23/29] apparmor: move initcalls to the LSM framework
Date: Wed,  9 Apr 2025 14:50:08 -0400
Message-ID: <20250409185019.238841-54-paul@paul-moore.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409185019.238841-31-paul@paul-moore.com>
References: <20250409185019.238841-31-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3522; i=paul@paul-moore.com; h=from:subject; bh=o9kemQg2ZrcZ++q3g/lVrPZOr+jvZkLZMu//o1GFu5E=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBn9sH03vin1FJAZpmk4yWHgdyKl0i3IYbWfCCjq 30OtauprY6JAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZ/bB9AAKCRDqIPLalzeJ c+14EADA1cR6Q/zr76e0c/96sV2AcfOQEoH+DEP8AgzvuEqodGyhZtP3555kNnu9iHrpw5NYGRg CMTnHuOIN3ILgP+KoUhfdQnmOFEUcORJFTPnL7+YT0dH4fWXTgFedGOEiq3+Yv/iP5VHvIVBg4p O3aU9hAmQQLFJ3PhnUNVAkGx3i9hmJ/OmTi68+pju7OF2FXL2/JPNNCXmF+nBI+vAkR7drGn/qk OyXutUnOOtDAuGWxbwm17tJFcuVJ9RWsg9lVN2ugqf94q0v9422QgcJNwJYHkE8SnRibL3pdu6h zuOVJ9kHtgZiw81K2QNTuimaojrHWOmGdC56kU3HDmlWRlGSfPM7Q3GkcWorxeZ7Ol5GfI9uBGX l+L2YaeiFFGE0xrcrq7WvWlkrdYn9HdQnyc8bz6kDp0sKpQ/yMR9YsRvIr8wflgxde2pVWaI3/d dZhFyJ3Ny917pu1YnaKetFstt4+U+UlXH70UWyh87hWi8WPuou2nvqnyUN+maRbpZGj/NqYpuyk wJraLkumWEPBr4bse8xkNevdWY6toA124oQG2RXhOAsYU3d+8of3MLOLnozBb+uPUf4MyvinH6n +ewpOjJy2fCl5YjuK9skj9ndgZUX4mf0DYXZGpfVONzlm71JL6qepc0+IHzXXcZZY6AldT9BCV5 IigqMnvdQqIAmWQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/apparmor/apparmorfs.c         | 4 +---
 security/apparmor/crypto.c             | 4 +---
 security/apparmor/include/apparmorfs.h | 2 ++
 security/apparmor/include/crypto.h     | 1 +
 security/apparmor/lsm.c                | 9 ++++++++-
 5 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 6039afae4bfc..0a7550a5bceb 100644
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
2.49.0

