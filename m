Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2869527C15D
	for <linux-security-module@vger.kernel.org>; Wed,  9 Apr 2025 18:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224825; cv=none; b=BqUksEyoToBJp3g3L7sUoCurPpk7o15nuXFCNW1t0bnYUaSJfmZIEROk6nMb6ff0MPSS1bLPSJAWXzTyTeQBIIBz24N4rmUTbh+KWl++q0DLpjpEMW9aDSItg+vVUzC/l/AQXO7vYxvuXPkZA5pTp1DgRLGj6n64kulI16MM1oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224825; c=relaxed/simple;
	bh=GDQ3patH56A9RhEqZVZHzhNee3+KKTm6tdMzSkvZ8pU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h+Fuoyl82zzvrWDjAalHopRRr497KZVGxK8JC6McTpF7ojmAaG+Kz/htVMH6SlOniWqCukv/eWFAuzZt9UwWo25Je0PObLlvC/RUDwQxEqOOIoewIH1gUzOjNWaaFEhoXeOTAgBMKfC1D2VcNAeF1A4yC5RQ9moi6v84VUCsh3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LWzYAFzL; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LWzYAFzL"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4768f90bf36so65139701cf.0
        for <linux-security-module@vger.kernel.org>; Wed, 09 Apr 2025 11:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744224821; x=1744829621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CFj14GGZWVRk3rTnUcPsbyI6H25LTwJVhFQZJQhFWBE=;
        b=LWzYAFzLkGAskcs/xGOpRoBKqoWW6s9IeQsQH0C52om/Rkjndsju9+0kitna2Zdx4E
         MkKDyrfUmNtoVcEAEv4Ntwtf1I41MqRIpG+vCBiC0TRr18DZAb5gtyfrROlIai7h7HbP
         Fd1xGcD+Z+9jVhGHAZJ5zWCyHn9knTEQrkkob+AA6XMszcAmfFKXiyGaPdK2PhD2w/co
         novPOMBYVxslBu3YgivqmvWIoRYeFNUTcwJZNj40iicRkEjzXILxOp+IoMcu4qhxUij4
         jUZmyP9aBCTJ9ZWzG9S8evcO7yTbIHEPapkyIpgSVgKNou1iBciSVAfv6JMdFEURDB6y
         iHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744224821; x=1744829621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CFj14GGZWVRk3rTnUcPsbyI6H25LTwJVhFQZJQhFWBE=;
        b=bvcccnmWOVjI4IxsEYYQEHugF7ItlSt31DRWK6O3l1OQL52pYFrarh82rKq+TGDVQm
         au8Zq/i4PNb6iv3U4x0WcchHQxCbsyBspFUTg5YNda/AfyaY8zQ8QjgJKU2Wi8gS2til
         DyB7yWnBivHeaWf6le7JEid7eGNnICAzqmgl18ipeTQXS60UmX+MYCTBosG9hChStkQN
         oi/peIy9UAnwYaAL9BD3PwCBbO9EaZarZApFU/FH+A7jFUdaU1njiYyR1iObdkSkE1Cv
         SzCo0f5Dq3Y2AlBolq/6JPZ3brUueaZ3myn6zq2B8bdgQxtG6FY3sVemT0myju0Qkjv2
         US6Q==
X-Gm-Message-State: AOJu0YwYZmMsiW0SWHBVqFV4cT4WATDDvGBhmjZHBv8LaUu1JRrKa5h5
	iak0FlqacJU5hDvRkmuaZhuLNFcQQFPeLwxtMhdOU2CT9zVYr+hEGZrd8enQoivBnYfpke36DrA
	=
X-Gm-Gg: ASbGncs3jHab/r9/y3NPLXt5So9sqc6tWybR4TzNZKfbUGnw6IuqArwirjgWReu8/rf
	SR8gZIfiwIptyxYyq0y/E0GYVleTN4Eh17y2X/oTQFDSJhPlXHKL9G4amXYVBYaCzhgdiuw7eeP
	6Asljet4AekFkaDONILkJU9pZLpyIUSjBOsvdznqfhRTdCUiem8UO7HpAQeXN3glp5BlQduz0ut
	fmm2PMOCyXk/FfkRE9VcCP2iM8CPfpgFup2IkoOKr9TcQwlzIdQGvALuX1sX41bpzPZlsDbLzkp
	Ox6fzzbLOCjiCIbOHU6VZjopLOM36GCFqRAHpzpJCR6DeH9oDlfjGOGu4mJnL2Xzonfaw6qh9kv
	k2b7W3K1D8g==
X-Google-Smtp-Source: AGHT+IFTzmyMQ9p2FmWUI2/O9PnrefJmwWU5semsY5oW9WRr16w43wZAgR7DXh6QX1NkvvkaNrCueA==
X-Received: by 2002:ac8:5ac3:0:b0:477:c04:b512 with SMTP id d75a77b69052e-479600a349amr57411931cf.16.1744224820929;
        Wed, 09 Apr 2025 11:53:40 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-47964d75b56sm10482841cf.13.2025.04.09.11.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 11:53:40 -0700 (PDT)
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
Subject: [RFC PATCH 12/29] lsm: cleanup the LSM ordered parsing
Date: Wed,  9 Apr 2025 14:49:57 -0400
Message-ID: <20250409185019.238841-43-paul@paul-moore.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409185019.238841-31-paul@paul-moore.com>
References: <20250409185019.238841-31-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8760; i=paul@paul-moore.com; h=from:subject; bh=GDQ3patH56A9RhEqZVZHzhNee3+KKTm6tdMzSkvZ8pU=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBn9sGy1rkxQ1IaeMg1pBvKosIqlnhN4dRB3tMT1 YqrF1VOc/mJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZ/bBsgAKCRDqIPLalzeJ c/RrD/4rF3KhJOE3kPV3qGx8NmJ2zM6FW+cGBEsRoEtkCh0yx+xwvZbrZ71LpmCsG7oDpGNasf9 VFOPo+Z4LLV9/hgy4AJrk7QWBn37UutngKA8XVgxDwFc3H376mJA66kcQnI01ushxfqTmIf7MJc gCRBJYBiEIlJXdCRhbVLcRBRckB2hqvKxagfZ0RrPRU1rDIJHNJQqwbsOfBBHhrBmRQca2VDrE2 BZFkAGD1jxucc1C+9tyxdsnnE2UmMxejUTJMXUdwilaz+DYWEseGdzU6mFpAm6UX3u0urHbXN14 FYs/yj2Kz5eGhDPDKkKzBuLFsmqmkwJt3MBMai2UPd4Jga8CM4ZuHVbcvUfjETtt1/D3vebZIwk QpzMTKJmx2BESXm2qnpTkbSs+Us1zfsVVTbCmXjfhpAg551r4r8cA8XQ3L6RdXVsNLc8F9rAgC5 VPmS6un4mi7+Tt9lSs57N3APnLOCDgTA2GgOQOSA0V8oKm55yNDAHTR0eQV+sOTEdAuGQhC6eT5 ADAnwDD4Hj1gGOU8037A42Oj38s7K0dlyA/xXYYJkT2vSVgrCA0/zuCnr1c/aVPSYSsAMu4Bx5z m7SKw++Idy7sHd79LHWbfiCEobYNm96dXdWeBZHfEoWaRLkUNLVfGLItQ0xB1JoILw7WWevEExq Rxo/4Nb+B4P0s6g==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

One part of a larger effort to cleanup the LSM framework initialization
code.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 211 ++++++++++++++++++++++----------------------
 1 file changed, 106 insertions(+), 105 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index 163fc2a1a952..e07fd4d2a16a 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -36,6 +36,9 @@ static __initdata bool debug;
 
 #define lsm_order_for_each(iter)					\
 	for ((iter) = lsm_order; *(iter); (iter)++)
+#define lsm_for_each_raw(iter)						\
+	for ((iter) = __start_lsm_info;					\
+	     (iter) < __end_lsm_info; (iter)++)
 #define lsm_early_for_each_raw(iter)					\
 	for ((iter) = __start_early_lsm_info;				\
 	     (iter) < __end_early_lsm_info; (iter)++)
@@ -127,6 +130,10 @@ static bool __init lsm_order_exists(struct lsm_info *lsm)
  * lsm_order_append - Append a LSM to the ordered list
  * @lsm: LSM definition
  * @src: source of the addition
+ *
+ * Append @lsm to the enabled LSM array after ensuring that it hasn't been
+ * explicitly disabled, is a duplicate entry, or would run afoul of the
+ * LSM_FLAG_EXCLUSIVE logic.
  */
 static void __init lsm_order_append(struct lsm_info *lsm, const char *src)
 {
@@ -135,19 +142,106 @@ static void __init lsm_order_append(struct lsm_info *lsm, const char *src)
 		return;
 
 	/* Skip explicitly disabled LSMs. */
-	if (lsm->enabled && !lsm_is_enabled(lsm)) {
-		if (WARN(lsm_count == MAX_LSM_COUNT,
-			 "%s: out of LSM static calls!?\n", src))
-			return;
-		lsm_enabled_set(lsm, true);
-		lsm_order[lsm_count] = lsm;
-		lsm_idlist[lsm_count++] = lsm->id;
+	if (lsm->enabled && !lsm_is_enabled(lsm))
+		goto out;
+
+	if (WARN(lsm_count == MAX_LSM_COUNT,
+		 "%s: out of LSM static calls!?\n", src)) {
+		lsm_enabled_set(lsm, false);
+		goto out;
 	}
 
+	if (lsm->flags & LSM_FLAG_EXCLUSIVE) {
+		if (lsm_exclusive) {
+			init_debug("exclusive disabled: %s\n", lsm->id->name);
+			lsm_enabled_set(lsm, false);
+			goto out;
+		} else {
+			init_debug("exclusive chosen:   %s\n", lsm->id->name);
+			lsm_exclusive = lsm;
+		}
+	}
+
+	lsm_enabled_set(lsm, true);
+	lsm_order[lsm_count] = lsm;
+	lsm_idlist[lsm_count++] = lsm->id;
+
+out:
 	init_debug("%s ordered: %s (%s)\n", src, lsm->id->name,
 		   lsm_is_enabled(lsm) ? "enabled" : "disabled");
 }
 
+/**
+ * lsm_order_parse - Parse the comma delimited LSM list
+ * @list: LSM list
+ * @src: source of the list
+ */
+static void __init lsm_order_parse(const char *list, const char *src)
+{
+	struct lsm_info *lsm;
+	char *sep, *name, *next;
+
+	/* Handle any Legacy LSM exclusions if one was specified. */
+	if (lsm_order_legacy) {
+		/*
+		 * To match the original "security=" behavior, this explicitly
+		 * does NOT fallback to another Legacy Major if the selected
+		 * one was separately disabled: disable all non-matching
+		 * Legacy Major LSMs.
+		 */
+		lsm_for_each_raw(lsm) {
+			if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) &&
+			     strcmp(lsm->id->name, lsm_order_legacy)) {
+				lsm_enabled_set(lsm, false);
+				init_debug("security=%s disabled: %s (only one legacy major LSM)\n",
+					   lsm_order_legacy, lsm->id->name);
+			}
+		}
+	}
+
+	/* LSM_ORDER_FIRST */
+	lsm_for_each_raw(lsm) {
+		if (lsm->order == LSM_ORDER_FIRST)
+			lsm_order_append(lsm, "first");
+	}
+
+	/* Normal or "mutable" LSMs */
+	sep = kstrdup(list, GFP_KERNEL);
+	next = sep;
+	/* Walk the list, looking for matching LSMs. */
+	while ((name = strsep(&next, ",")) != NULL) {
+		lsm_for_each_raw(lsm) {
+			if (!strcmp(lsm->id->name, name) &&
+			    lsm->order == LSM_ORDER_MUTABLE)
+				lsm_order_append(lsm, src);
+		}
+	}
+	kfree(sep);
+
+	/* Legacy LSM if specified. */
+	if (lsm_order_legacy) {
+		lsm_for_each_raw(lsm) {
+			if (!strcmp(lsm->id->name, lsm_order_legacy))
+				lsm_order_append(lsm, src);
+		}
+	}
+
+	/* LSM_ORDER_LAST */
+	lsm_for_each_raw(lsm) {
+		if (lsm->order == LSM_ORDER_LAST)
+			lsm_order_append(lsm, "last");
+	}
+
+	/* Disable all LSMs not previously enabled. */
+	lsm_for_each_raw(lsm) {
+		if (lsm_order_exists(lsm))
+			continue;
+		lsm_enabled_set(lsm, false);
+		init_debug("%s skipped: %s (not in requested order)\n",
+			   src, lsm->id->name);
+	}
+}
+
 /**
  * lsm_blob_size_update - Update the LSM blob size and offset information
  * @sz_req: the requested additional blob size
@@ -172,26 +266,12 @@ static void __init lsm_blob_size_update(unsigned int *sz_req,
  */
 static void __init lsm_prep_single(struct lsm_info *lsm)
 {
-	struct lsm_blob_sizes *blobs;
+	struct lsm_blob_sizes *blobs = lsm->blobs;
 
-	if (!lsm_is_enabled(lsm)) {
-		lsm_enabled_set(lsm, false);
+	if (!blobs)
 		return;
-	} else if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && lsm_exclusive) {
-		init_debug("exclusive disabled: %s\n", lsm->id->name);
-		lsm_enabled_set(lsm, false);
-		return;
-	}
-
-	/* Mark the LSM as enabled. */
-	lsm_enabled_set(lsm, true);
-	if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !lsm_exclusive) {
-		init_debug("exclusive chosen:   %s\n", lsm->id->name);
-		lsm_exclusive = lsm;
-	}
 
 	/* Register the LSM blob sizes. */
-	blobs = lsm->blobs;
 	lsm_blob_size_update(&blobs->lbs_cred, &blob_sizes.lbs_cred);
 	lsm_blob_size_update(&blobs->lbs_file, &blob_sizes.lbs_file);
 	lsm_blob_size_update(&blobs->lbs_ib, &blob_sizes.lbs_ib);
@@ -230,86 +310,6 @@ static void __init lsm_init_single(struct lsm_info *lsm)
 	WARN(ret, "%s failed to initialize: %d\n", lsm->id->name, ret);
 }
 
-/* Populate ordered LSMs list from comma-separated LSM name list. */
-static void __init ordered_lsm_parse(const char *order, const char *origin)
-{
-	struct lsm_info *lsm;
-	char *sep, *name, *next;
-
-	/* LSM_ORDER_FIRST is always first. */
-	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
-		if (lsm->order == LSM_ORDER_FIRST)
-			lsm_order_append(lsm, "  first");
-	}
-
-	/* Process "security=", if given. */
-	if (lsm_order_legacy) {
-		struct lsm_info *major;
-
-		/*
-		 * To match the original "security=" behavior, this
-		 * explicitly does NOT fallback to another Legacy Major
-		 * if the selected one was separately disabled: disable
-		 * all non-matching Legacy Major LSMs.
-		 */
-		for (major = __start_lsm_info; major < __end_lsm_info;
-		     major++) {
-			if ((major->flags & LSM_FLAG_LEGACY_MAJOR) &&
-			    strcmp(major->id->name, lsm_order_legacy) != 0) {
-				lsm_enabled_set(major, false);
-				init_debug("security=%s disabled: %s (only one legacy major LSM)\n",
-					   lsm_order_legacy, major->id->name);
-			}
-		}
-	}
-
-	sep = kstrdup(order, GFP_KERNEL);
-	next = sep;
-	/* Walk the list, looking for matching LSMs. */
-	while ((name = strsep(&next, ",")) != NULL) {
-		bool found = false;
-
-		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
-			if (strcmp(lsm->id->name, name) == 0) {
-				if (lsm->order == LSM_ORDER_MUTABLE)
-					lsm_order_append(lsm, origin);
-				found = true;
-			}
-		}
-
-		if (!found)
-			init_debug("%s ignored: %s (not built into kernel)\n",
-				   origin, name);
-	}
-
-	/* Process "security=", if given. */
-	if (lsm_order_legacy) {
-		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
-			if (lsm_order_exists(lsm))
-				continue;
-			if (strcmp(lsm->id->name, lsm_order_legacy) == 0)
-				lsm_order_append(lsm, "security=");
-		}
-	}
-
-	/* LSM_ORDER_LAST is always last. */
-	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
-		if (lsm->order == LSM_ORDER_LAST)
-			lsm_order_append(lsm, "   last");
-	}
-
-	/* Disable all LSMs not in the ordered list. */
-	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
-		if (lsm_order_exists(lsm))
-			continue;
-		lsm_enabled_set(lsm, false);
-		init_debug("%s skipped: %s (not in requested order)\n",
-			   origin, lsm->id->name);
-	}
-
-	kfree(sep);
-}
-
 /**
  * lsm_init_ordered - Initialize the ordered LSMs
  */
@@ -324,9 +324,9 @@ static void __init lsm_init_ordered(void)
 				lsm_order_legacy, lsm_order_cmdline);
 			lsm_order_legacy = NULL;
 		}
-		ordered_lsm_parse(lsm_order_cmdline, "cmdline");
+		lsm_order_parse(lsm_order_cmdline, "cmdline");
 	} else
-		ordered_lsm_parse(lsm_order_builtin, "builtin");
+		lsm_order_parse(lsm_order_builtin, "builtin");
 
 	lsm_order_for_each(lsm) {
 		lsm_prep_single(*lsm);
@@ -426,6 +426,7 @@ int __init early_security_init(void)
 
 	lsm_early_for_each_raw(lsm) {
 		lsm_enabled_set(lsm, true);
+		lsm_order_append(lsm, "early");
 		lsm_prep_single(lsm);
 		lsm_init_single(lsm);
 	}
-- 
2.49.0

