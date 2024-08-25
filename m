Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B1713E05C
	for <linux-security-module@vger.kernel.org>; Sun, 25 Aug 2024 14:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724594711; cv=none; b=VQdlH4hTD70KvmJXgKdFozyriIkt5swnK0dQF6H807WztS5HM5yesfFOeouDEPdAV4XK/oCpNm/SkbLojHm2xMjIxwc4QXaTPmxhxeETYcxTc1kNIhaDEsvuCKcjKwItrKuclVMO5N1ma7TYnBBrGcWD+ib4i2i96MUVFi5oM88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724594711; c=relaxed/simple;
	bh=QpIDUzmdL/q6UHl7VOuGEcvGD4w7lfs3dUTOB5W8tzg=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=tizQDTNAI9qtMwWteyXeR7eEpN7zInJ1JARpGO99qtYuyLyO7nyMqim2u5EA/L1pV3rXewJAR/Low13e89Y5Rv5nsueBVwt8y9ifvPG3CVnCJ/uR7BLjbfhWZ9+BQ14yVqCQ5YpB+1yvABMpdFUuWcSnOBBDU5qA9ZUBrxSu0s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav118.sakura.ne.jp (fsav118.sakura.ne.jp [27.133.134.245])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 47PE56Ja012915
	for <linux-security-module@vger.kernel.org>; Sun, 25 Aug 2024 23:05:06 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav118.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp);
 Sun, 25 Aug 2024 23:05:06 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 47PE55kl012912
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO)
	for <linux-security-module@vger.kernel.org>; Sun, 25 Aug 2024 23:05:05 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <5089fc1c-0172-4ccf-9ad1-28ff1b649597@I-love.SAKURA.ne.jp>
Date: Sun, 25 Aug 2024 23:05:04 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-security-module <linux-security-module@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] lsm: remove LSM_COUNT and LSM_CONFIG_COUNT
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Because these are equals to MAX_LSM_COUNT. Also, we can avoid dynamic
memory allocation for ordered_lsms because MAX_LSM_COUNT is a constant.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 security/security.c | 37 ++++---------------------------------
 1 file changed, 4 insertions(+), 33 deletions(-)

diff --git a/security/security.c b/security/security.c
index c30e8348c9e12..f570563a3d1eb 100644
--- a/security/security.c
+++ b/security/security.c
@@ -33,30 +33,6 @@
 #include <net/flow.h>
 #include <net/sock.h>
 
-/* How many LSMs were built into the kernel? */
-#define LSM_COUNT (__end_lsm_info - __start_lsm_info)
-
-/*
- * How many LSMs are built into the kernel as determined at
- * build time. Used to determine fixed array sizes.
- * The capability module is accounted for by CONFIG_SECURITY
- */
-#define LSM_CONFIG_COUNT ( \
-	(IS_ENABLED(CONFIG_SECURITY) ? 1 : 0) + \
-	(IS_ENABLED(CONFIG_SECURITY_SELINUX) ? 1 : 0) + \
-	(IS_ENABLED(CONFIG_SECURITY_SMACK) ? 1 : 0) + \
-	(IS_ENABLED(CONFIG_SECURITY_TOMOYO) ? 1 : 0) + \
-	(IS_ENABLED(CONFIG_SECURITY_APPARMOR) ? 1 : 0) + \
-	(IS_ENABLED(CONFIG_SECURITY_YAMA) ? 1 : 0) + \
-	(IS_ENABLED(CONFIG_SECURITY_LOADPIN) ? 1 : 0) + \
-	(IS_ENABLED(CONFIG_SECURITY_SAFESETID) ? 1 : 0) + \
-	(IS_ENABLED(CONFIG_SECURITY_LOCKDOWN_LSM) ? 1 : 0) + \
-	(IS_ENABLED(CONFIG_BPF_LSM) ? 1 : 0) + \
-	(IS_ENABLED(CONFIG_SECURITY_LANDLOCK) ? 1 : 0) + \
-	(IS_ENABLED(CONFIG_IMA) ? 1 : 0) + \
-	(IS_ENABLED(CONFIG_EVM) ? 1 : 0) + \
-	(IS_ENABLED(CONFIG_SECURITY_IPE) ? 1 : 0))
-
 #define SECURITY_HOOK_ACTIVE_KEY(HOOK, IDX) security_hook_active_##HOOK##_##IDX
 
 /*
@@ -130,7 +106,7 @@ static __initdata const char *chosen_major_lsm;
 static __initconst const char *const builtin_lsm_order = CONFIG_LSM;
 
 /* Ordered list of LSMs to initialize. */
-static __initdata struct lsm_info **ordered_lsms;
+static __initdata struct lsm_info *ordered_lsms[MAX_LSM_COUNT + 1];
 static __initdata struct lsm_info *exclusive;
 
 #ifdef CONFIG_HAVE_STATIC_CALL
@@ -242,7 +218,7 @@ static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
 	if (exists_ordered_lsm(lsm))
 		return;
 
-	if (WARN(last_lsm == LSM_COUNT, "%s: out of LSM static calls!?\n", from))
+	if (WARN(last_lsm == MAX_LSM_COUNT, "%s: out of LSM static calls!?\n", from))
 		return;
 
 	/* Enable this LSM, if it is not already set. */
@@ -345,7 +321,7 @@ static void __init initialize_lsm(struct lsm_info *lsm)
  * Current index to use while initializing the lsm id list.
  */
 u32 lsm_active_cnt __ro_after_init;
-const struct lsm_id *lsm_idlist[LSM_CONFIG_COUNT];
+const struct lsm_id *lsm_idlist[MAX_LSM_COUNT];
 
 /* Populate ordered LSMs list from comma-separated LSM name list. */
 static void __init ordered_lsm_parse(const char *order, const char *origin)
@@ -474,9 +450,6 @@ static void __init ordered_lsm_init(void)
 {
 	struct lsm_info **lsm;
 
-	ordered_lsms = kcalloc(LSM_COUNT + 1, sizeof(*ordered_lsms),
-			       GFP_KERNEL);
-
 	if (chosen_lsm_order) {
 		if (chosen_major_lsm) {
 			pr_warn("security=%s is ignored because it is superseded by lsm=%s\n",
@@ -525,8 +498,6 @@ static void __init ordered_lsm_init(void)
 	lsm_early_task(current);
 	for (lsm = ordered_lsms; *lsm; lsm++)
 		initialize_lsm(*lsm);
-
-	kfree(ordered_lsms);
 }
 
 int __init early_security_init(void)
@@ -653,7 +624,7 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 	 * Look at the previous entry, if there is one, for duplication.
 	 */
 	if (lsm_active_cnt == 0 || lsm_idlist[lsm_active_cnt - 1] != lsmid) {
-		if (lsm_active_cnt >= LSM_CONFIG_COUNT)
+		if (lsm_active_cnt >= MAX_LSM_COUNT)
 			panic("%s Too many LSMs registered.\n", __func__);
 		lsm_idlist[lsm_active_cnt++] = lsmid;
 	}
-- 
2.43.5

