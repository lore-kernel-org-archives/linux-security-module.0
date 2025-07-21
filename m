Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C8424633C
	for <linux-security-module@vger.kernel.org>; Mon, 21 Jul 2025 23:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140246; cv=none; b=Z/Kdw+PpTAHTFitB+uDSy3pCbAK3XK7uEeto4v8hm51/uIOIo8POVqL/F+wcsJFQt+19ZOm5hCauTI5zpgAFBVwTYAd/dDsQ3Dji1awzRaUvv86qyPYmBOSBoetQo16arS+CmoP73CAY9qs+VGt9sGLhnyRuu4lAh+Dt2yQ9PxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140246; c=relaxed/simple;
	bh=6RgNmUH+EYbQotD6C866/35hz7dG97Tkqs/eGMyrszg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VRkhxBp2zdyuFAyxrMk30LgfD+YGIE9GBiuCaPxK8Y+2qtXlTufUq9mG54baboXxPWvzCsZrFQXtW0WJaMUfKxax9UmoCE36n/NSSfobNuArVpzKapIU+N/JpXnADtjd1joQDgYZ0uztrbiDeDfTNoENZ9WIBIvxHny6sHde47k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QoqOAs5n; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QoqOAs5n"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6fabb948e5aso50143366d6.1
        for <linux-security-module@vger.kernel.org>; Mon, 21 Jul 2025 16:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753140243; x=1753745043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3i7cUK+/YhjelwYKvJENXThVSNWBL1wHW/Z/6SYoZBE=;
        b=QoqOAs5n4ud8tSo00Yam+bRwUla+ODps25LR7T4Hi8o4V/QImbPrITbLh/RFBvpqG7
         7/nuwiqo0zO+e8rXNfYProdNbPi2aNQjsYpXAP93JybUahIPfNSvaBTa8YWDRiTICB6V
         VSijtLjOI7fW+zQlXqc6BCxBrpnPh1aJnpz9E59KqjgZJL8CzLPIzyheThwXHNxVu7+v
         TqKAVNHemcDbtcf/3MoNElJUApEFfS+ygPyghHUzEI3s362lsd9rlS4b6Sk/YwRRvOLp
         IIZ8BAiypAy5fcjOEH/YOmuop5Hvy41dLBKs0zUBf6t4QRoGk2GSIo0K8c0tsFMxsIkz
         kcGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753140243; x=1753745043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3i7cUK+/YhjelwYKvJENXThVSNWBL1wHW/Z/6SYoZBE=;
        b=pLcUEHPJTm08PbuaQoN+EKVMjXzNLjpExxYh6fgvmxUHSGdepcD8q75dTNi84bZq7U
         RV4mxrMnMmtUJdW6Cot5CYVwqpVgr68kMaAdspSJl8duSDIAxojrVDMrwunPosRcir3m
         OgvORscM2lv8Fhx4Z6WaJ7Ap411+ILO64XEl2maJT4p5rS5B+grBNzT4lze/AXPej7y8
         dXiC9eNDQEVjO/tjp80Mf3/LENJNcp0ZLLiFjZCNbiEcaa7/+KhyCqwyNBYv2jbuNPCz
         vTCi+m01t5VyVG1N2CIKcyGd/enyBJCkZnxgyqWon919ieD/8/xxgLpTiUazS2fZGx6j
         LMNA==
X-Gm-Message-State: AOJu0YySV0zIx3+bBoSdoFSY+NKL6AFAe0nSgzYmHGzOpe24AF79OcDu
	/aYR3Xi0fYpJ6Y9O2F/LHsyvGS2WhW6gt31NLwqvB0HSwVyRBQ0MiGajQ21iWYXOyo0yYh1oPVa
	Do2E=
X-Gm-Gg: ASbGncto09RWdlFsjZtjkY3JFqYbKKDfHqGdMZea/iNoxancT9iJDZ/CN53Bc65HZSy
	3h+EyHrdKwhzvI5D29/p/58ClEmDPZYIMOjTwPMU7lSiIixXVvcihifPDm/d8MeQsPj0xG47Ybz
	mP9rN9qTrAMpiOWR5frlB/9FIM01UgBVMvKhVqf48nh0A0XJXxDufEDwXx54zlf2q1GVWhcEnhQ
	UvozYVq2TQAKUcX+W7pLpMeaLINpVZrUAhGQcAowhAymWbMyXOAYLvgwOPsH6w27CzBpFPyU3fM
	vX5eiFWbAdks54Wi8U4SZoxfj+UA540ilBR0KWASDBLrmXkEVrYUofMQfHsX+kGi6vt/cbWRw6e
	ZraWZBEaxoAg1/2+tMsFk6N3xJDESE9rklQ85l/9+/QpUuC6795yGsxJCc2OuMEtHy0I=
X-Google-Smtp-Source: AGHT+IHKh+56h8LoZRT0lZkb9HNQ7JGBPftYdh/sYyCxdtaS6sShFl89lpFYgiP4ynXdJ2Dmru7Dtw==
X-Received: by 2002:a05:6214:5f0a:b0:704:c686:3f54 with SMTP id 6a1803df08f44-704f6a5720emr262614286d6.15.1753140243564;
        Mon, 21 Jul 2025 16:24:03 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4abb499fea2sm47251361cf.22.2025.07.21.16.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 16:24:03 -0700 (PDT)
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
Subject: [RFC PATCH v2 04/34] lsm: introduce looping macros for the initialization code
Date: Mon, 21 Jul 2025 19:21:07 -0400
Message-ID: <20250721232142.77224-40-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721232142.77224-36-paul@paul-moore.com>
References: <20250721232142.77224-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5299; i=paul@paul-moore.com; h=from:subject; bh=6RgNmUH+EYbQotD6C866/35hz7dG97Tkqs/eGMyrszg=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBofsuYzrvTij5x3obvob+l9NAOFKV9WgCwPgp31 6Sq1apEVpSJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaH7LmAAKCRDqIPLalzeJ c+rUD/9bCgec7hWVBeynvdIOod6uQmtAUi1nTTaj0RMN4Xkl0h/d928J+Kn3zSrnofTYbamy1wL EEyu6Zfn7FIqrXV/sQzCK241wNr6tV3bd8btHOZBkVHOvrjJLzfvToQEpcZZNs1Lgr7oNKVrnLE x3PACFtMJbpVBlb28mDl6e6XzlqvTYAHujc2v4g7xIbQWGrckY+s/itpNeOsq5hZcOprzs1jHsM V1SkO4YrwkHrkU8u+nwiCQ+Kbp0VduZ56s8Pw7Rf8USOymFeAxookxgjgIDZirIzzIKmHBoV5wp 5dN8anqw/HHcOGz93cfPQOkE8+6+vTqy52LjaN2vjXB6vh5O8QHfKhcFF8NeLOaPoiGRgUPOuHn YPWcOtX9SiSAlhBuxY5ilarW6Rf3PpAr2MMKxGkY29YuXjEnT2kdK/yaWJ+Un31BjK9LG9FENiG 7o1L9bsOBcqNSDub+0yNxDE9laHzgOPohrPYtHGZlMvXIW5MFAiJqNOeW3YUR6HPu6GezSNhocv vXP6lCjRAYqOKXGIosHwOQZHRyHxgotnfIgOS3Tx08RtZyyz43qby+TZTI9eGsEKvSJ9STuN9td vaCVwjLcs32LPitNvNMdP5YQfPSlcXXCEfibptoOaEDCrs5JK5B/pqAJa/flZxj5ws7xwpXz8Qm 83duVDry+7wTiTQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

There are three common for loop patterns in the LSM initialization code
to loop through the ordered LSM list and the registered "early" LSMs.
This patch implements these loop patterns as macros to help simplify the
code and reduce the change for errors.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 42 +++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index 7beb028a507b..a73c3769dfea 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -32,6 +32,15 @@ static __initdata bool debug;
 			pr_info(__VA_ARGS__);				\
 	} while (0)
 
+#define lsm_order_for_each(iter)					\
+	for ((iter) = ordered_lsms; *(iter); (iter)++)
+#define lsm_for_each_raw(iter)						\
+	for ((iter) = __start_lsm_info;					\
+	     (iter) < __end_lsm_info; (iter)++)
+#define lsm_early_for_each_raw(iter)					\
+	for ((iter) = __start_early_lsm_info;				\
+	     (iter) < __end_early_lsm_info; (iter)++)
+
 static int lsm_append(const char *new, char **result);
 
 /* Save user chosen LSM */
@@ -96,9 +105,10 @@ static bool __init exists_ordered_lsm(struct lsm_info *lsm)
 {
 	struct lsm_info **check;
 
-	for (check = ordered_lsms; *check; check++)
+	lsm_order_for_each(check) {
 		if (*check == lsm)
 			return true;
+	}
 
 	return false;
 }
@@ -206,7 +216,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 	char *sep, *name, *next;
 
 	/* LSM_ORDER_FIRST is always first. */
-	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+	lsm_for_each_raw(lsm) {
 		if (lsm->order == LSM_ORDER_FIRST)
 			append_ordered_lsm(lsm, "  first");
 	}
@@ -221,8 +231,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 		 * if the selected one was separately disabled: disable
 		 * all non-matching Legacy Major LSMs.
 		 */
-		for (major = __start_lsm_info; major < __end_lsm_info;
-		     major++) {
+		lsm_for_each_raw(major) {
 			if ((major->flags & LSM_FLAG_LEGACY_MAJOR) &&
 			    strcmp(major->name, chosen_major_lsm) != 0) {
 				set_enabled(major, false);
@@ -238,7 +247,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 	while ((name = strsep(&next, ",")) != NULL) {
 		bool found = false;
 
-		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+		lsm_for_each_raw(lsm) {
 			if (strcmp(lsm->name, name) == 0) {
 				if (lsm->order == LSM_ORDER_MUTABLE)
 					append_ordered_lsm(lsm, origin);
@@ -253,7 +262,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 
 	/* Process "security=", if given. */
 	if (chosen_major_lsm) {
-		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+		lsm_for_each_raw(lsm) {
 			if (exists_ordered_lsm(lsm))
 				continue;
 			if (strcmp(lsm->name, chosen_major_lsm) == 0)
@@ -262,13 +271,13 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 	}
 
 	/* LSM_ORDER_LAST is always last. */
-	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+	lsm_for_each_raw(lsm) {
 		if (lsm->order == LSM_ORDER_LAST)
 			append_ordered_lsm(lsm, "   last");
 	}
 
 	/* Disable all LSMs not in the ordered list. */
-	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+	lsm_for_each_raw(lsm) {
 		if (exists_ordered_lsm(lsm))
 			continue;
 		set_enabled(lsm, false);
@@ -287,13 +296,14 @@ static void __init report_lsm_order(void)
 	pr_info("initializing lsm=");
 
 	/* Report each enabled LSM name, comma separated. */
-	for (early = __start_early_lsm_info;
-	     early < __end_early_lsm_info; early++)
+	lsm_early_for_each_raw(early) {
 		if (is_enabled(early))
 			pr_cont("%s%s", first++ == 0 ? "" : ",", early->name);
-	for (lsm = ordered_lsms; *lsm; lsm++)
+	}
+	lsm_order_for_each(lsm) {
 		if (is_enabled(*lsm))
 			pr_cont("%s%s", first++ == 0 ? "" : ",", (*lsm)->name);
+	}
 
 	pr_cont("\n");
 }
@@ -340,8 +350,9 @@ static void __init ordered_lsm_init(void)
 	} else
 		ordered_lsm_parse(builtin_lsm_order, "builtin");
 
-	for (lsm = ordered_lsms; *lsm; lsm++)
+	lsm_order_for_each(lsm) {
 		lsm_prepare(*lsm);
+	}
 
 	report_lsm_order();
 
@@ -376,8 +387,9 @@ static void __init ordered_lsm_init(void)
 
 	lsm_early_cred((struct cred *) current->cred);
 	lsm_early_task(current);
-	for (lsm = ordered_lsms; *lsm; lsm++)
+	lsm_order_for_each(lsm) {
 		initialize_lsm(*lsm);
+	}
 }
 
 static bool match_last_lsm(const char *list, const char *lsm)
@@ -479,7 +491,7 @@ int __init early_security_init(void)
 {
 	struct lsm_info *lsm;
 
-	for (lsm = __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++) {
+	lsm_early_for_each_raw(lsm) {
 		if (!lsm->enabled)
 			lsm->enabled = &lsm_enabled_true;
 		lsm_prepare(lsm);
@@ -506,7 +518,7 @@ int __init security_init(void)
 	 * Append the names of the early LSM modules now that kmalloc() is
 	 * available
 	 */
-	for (lsm = __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++) {
+	lsm_early_for_each_raw(lsm) {
 		init_debug("  early started: %s (%s)\n", lsm->name,
 			   is_enabled(lsm) ? "enabled" : "disabled");
 		if (lsm->enabled)
-- 
2.50.1

