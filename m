Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7148354AF6
	for <linux-security-module@vger.kernel.org>; Fri, 17 Oct 2025 20:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760732957; cv=none; b=fwQqBSxSneVMmVKCauIBlJBG9XRAtf8h1Dl1cs5pUEoHTRlUqzw4ozvtdep3AVqCE6y/PAG4ja+hE1lylyX1OfYCTIHFYb8xi3+NVMcdQBa/usbLgHdk/zcXHo8zAjxtCv9Se43y0WYZsUgH+RzIqs11IjM1RnG5poOBiJ6FoLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760732957; c=relaxed/simple;
	bh=6LMMnOsqRoWXjuLyu6WmXY7pwvYY39UkYT2Eyvob+fk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NQFaKUZj0mwbzoizEWKPxPLtZQc6vdvDPjIweIdLbZ2QfoIx8IesPmbJmL+LjyTjq391j49QgIJ2XvHJ2+8R9I/tNn0BtTOpqAjmYYlEJ0dikEVg0YTeGgQDE5U2i9DwcqLSybYZxi34qngHWQmmmBGNN4KG1NZgoTR0dJpFhi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VXfX1wdk; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VXfX1wdk"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-890521c116fso235185885a.3
        for <linux-security-module@vger.kernel.org>; Fri, 17 Oct 2025 13:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760732954; x=1761337754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZnlSOct+pzks31iCd0Gr9fA3Y2W5QhAzmgtThmAhbok=;
        b=VXfX1wdkqBJ2D46uArFZPfkcmUfiuw+QT3Ns4y2EvmdzaMkQZK/pqntJTnH3aCOyi1
         CKW/Y/SfQIh7RkySj4kSYjkp6lIbnfQl6CBqScmepM9IpMUWXa8iyP0szrZ0hJKS+4Sn
         oyETgiQvUOvx581HsrIL7zgO1uTyQbDXaQNWelV4JpJPx5AA2ArVtyJ39GTJu8fq3qVd
         y+IrWZAGGJ5EzWMaQjAvRQPtOyh3RmZVC9EbF7QVV2nKczFsndK+dT4p9mYLv99edo7D
         SF2TQbKUaasbue7g9+G+HM4xj6NjAnzTu718S85fS/xukuDgLDzMjvLyQGJbL1UAIrBh
         mwIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760732954; x=1761337754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZnlSOct+pzks31iCd0Gr9fA3Y2W5QhAzmgtThmAhbok=;
        b=bD7Auc+VvY3BguOE7C1L3otIksnXWfTWWZjxcwvURtK2e1w3Njv1qz7lOmt53GbJDb
         /w/+dPI2IYbyB7Xccrem5nYus1pOsI4cZ0a8s/scfYA09X2z7PVXkzRqX2S6/e+a/pzR
         dlULlsQprbf13ypxt4ON3DjqSz6JyyeyBl6fUWR8mBAsmex04B0GzfWaqj41dufB15mM
         LUw6UGnlVgVoGMeVi0ZRw3Ig3oY/DWZYljN7xLlD/4h8JRLSuLCAw2+693au5pZbpNl9
         UZJgllhCYBrx1y+q5lmUt3wDfwTb+IsMQNkiXtuigE4Zl6voPwBEsz82C4oYCUbG/Oey
         /aww==
X-Gm-Message-State: AOJu0YzTp99RDzEgjaJIgt7VMm4tJCDi6wmQ9umncfAFhQ/N5QNOL/Gr
	UZth1LmQCtbiL3Xa9+2ywBcnl2cI8LwBdOllluGIfpLuiR/9R9wS27V48m/JNjw9Ey81IbAEW06
	qMpe6Kg==
X-Gm-Gg: ASbGncstAWy5CytFETjcKz+1tGAhozJtWb/mqbXxkvsArRSO3OLkfjjVCLvpUj/HIU7
	gVQ0a4jZhQGXVRyCDIzq0LbGXAZlQ0izwQgQlEgWLSGZx2ElpCDAqQTK6+MFUECdv6gZWDjjHEY
	LNO7cV0OyA8RYbSYrfNuDimY3ohC1EX//Z5e8pau4ncJz2T7GcDC93lfLYbtX8u9lHuP2p5pj5d
	iUFApkMel8qaQwpu2eukE41b3bdDzHH5W/+8Nm5TqPjeXlualS+htsNFSUNuKK1ujUNWeJJW4P2
	Y9iQcPd5k5WL8DkBGk+HGUi0WV5NjxbZKpEksPWzf00CY0Fe82pTE2ZM9ulvGAYvOQcpJKvRm/v
	DzBEWhJw84nIcUfvZq8Ax55DKzWXa+eND5/Q/618dLHa2HmIAyy1+TrlIVk6Js+8I9DmRaFEDfh
	HALc4Yt5v+hKw48mY1WeGzytXkTVs1pFYHqOlynvu1XqJcUOR9QqeARLq6
X-Google-Smtp-Source: AGHT+IFW82r20RPmJsmcBeQ8omShSRmDGqG8T0o1aR/tWOU2rqZ0vepdNUCX/XfqIa9WYicPk6/Xuw==
X-Received: by 2002:a05:620a:701b:b0:88f:ee0a:3d55 with SMTP id af79cd13be357-890707faad0mr623273185a.66.1760732953788;
        Fri, 17 Oct 2025 13:29:13 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cfa620b2sm38866085a.59.2025.10.17.13.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 13:29:12 -0700 (PDT)
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
Subject: [PATCH v5 15/34] lsm: rename/rework ordered_lsm_parse() to lsm_order_parse()
Date: Fri, 17 Oct 2025 16:24:43 -0400
Message-ID: <20251017202456.484010-51-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251017202456.484010-36-paul@paul-moore.com>
References: <20251017202456.484010-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4903; i=paul@paul-moore.com; h=from:subject; bh=6LMMnOsqRoWXjuLyu6WmXY7pwvYY39UkYT2Eyvob+fk=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBo8qZGkizGfwoLVJO78Z14Zamu2ERLvUVZMSOHh jKhE4ZyFhuJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaPKmRgAKCRDqIPLalzeJ c+rkD/sHy58AfVWrUKWcfh7PEPqKAE58gLBR9FYP0r9MF+iH4jZR1L31fXZq2L4eRQdOYMOCAew 9J24CKgOkeJ6eWRvj3cC20tvAZP5VO9B5gnWGw9uS4U0tfAqTIZWDvKt7Pd+/aqpyZ04bc4xnvZ mXlAve8Ysf3QbtBngXV+c6CixdgeH1C2yD5ackDjoNIfAtSpd+wt750TAwRZd5d9kWDcj0zR63G 2a9Sm261/a5IYj32K+EVreMAwzqnIXuEEEwTEb2JNg9N+SOpAkx/vrFPGvEN7fmh0yeQh4b73zB hLOhD/txh/ZNypK3GmFwf3ltj7/tJoRbfGZW8EP2z+g09vxekf+aEd6r4gi3vXMQusv4lCjuaYM smzm/8amuOKr0xo0k5hzshjKpSojpJKSztajDg0F2GQOjbddZia7H4sk1h3Jb8Cj9LB4TDyHQvH rX32BMBnL/b47jeQUqXr81ZQBVF0dV7B/O2suEJdx4u9lxu1ZMdD0gwK5pXadixF9kBIMX7pJnl 3lnWkXPD7JxdnbOm1LHWSlh1C7ns6mORo7/U4J0EFtBj7PpVMn+6nwENE7tE03yi7L3ClEdF8lq YTwd6ZunNMglhp+2sJWX5LwQBjNSWXu/d7KvyA/R6AgjY8lkqiMzq9HLPto+ANRh/wiFDJ90E6h 7MIrToPebpBqwcw==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Rename ordered_lsm_parse() to lsm_order_parse() for the sake of
consistency with the other LSM initialization routines, and also
do some minor rework of the function.  Aside from some minor style
decisions, the majority of the rework involved shuffling the order
of the LSM_FLAG_LEGACY and LSM_ORDER_FIRST code so that the
LSM_FLAG_LEGACY checks are handled first; it is important to note
that this doesn't affect the order in which the LSMs are registered.

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 82 ++++++++++++++++++++-------------------------
 1 file changed, 37 insertions(+), 45 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index 1881cd28f0a0..f0066857bd1a 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -228,83 +228,75 @@ static void __init initialize_lsm(struct lsm_info *lsm)
 	}
 }
 
-/* Populate ordered LSMs list from comma-separated LSM name list. */
-static void __init ordered_lsm_parse(const char *order, const char *origin)
+/**
+ * lsm_order_parse - Parse the comma delimited LSM list
+ * @list: LSM list
+ * @src: source of the list
+ */
+static void __init lsm_order_parse(const char *list, const char *src)
 {
 	struct lsm_info *lsm;
 	char *sep, *name, *next;
 
-	/* LSM_ORDER_FIRST is always first. */
-	lsm_for_each_raw(lsm) {
-		if (lsm->order == LSM_ORDER_FIRST)
-			lsm_order_append(lsm, "  first");
-	}
-
-	/* Process "security=", if given. */
+	/* Handle any Legacy LSM exclusions if one was specified. */
 	if (lsm_order_legacy) {
-		struct lsm_info *major;
-
 		/*
-		 * To match the original "security=" behavior, this
-		 * explicitly does NOT fallback to another Legacy Major
-		 * if the selected one was separately disabled: disable
-		 * all non-matching Legacy Major LSMs.
+		 * To match the original "security=" behavior, this explicitly
+		 * does NOT fallback to another Legacy Major if the selected
+		 * one was separately disabled: disable all non-matching
+		 * Legacy Major LSMs.
 		 */
-		lsm_for_each_raw(major) {
-			if ((major->flags & LSM_FLAG_LEGACY_MAJOR) &&
-			    strcmp(major->id->name, lsm_order_legacy) != 0) {
-				lsm_enabled_set(major, false);
+		lsm_for_each_raw(lsm) {
+			if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) &&
+			     strcmp(lsm->id->name, lsm_order_legacy)) {
+				lsm_enabled_set(lsm, false);
 				init_debug("security=%s disabled: %s (only one legacy major LSM)\n",
-					   lsm_order_legacy, major->id->name);
+					   lsm_order_legacy, lsm->id->name);
 			}
 		}
 	}
 
-	sep = kstrdup(order, GFP_KERNEL);
+	/* LSM_ORDER_FIRST */
+	lsm_for_each_raw(lsm) {
+		if (lsm->order == LSM_ORDER_FIRST)
+			lsm_order_append(lsm, "first");
+	}
+
+	/* Normal or "mutable" LSMs */
+	sep = kstrdup(list, GFP_KERNEL);
 	next = sep;
 	/* Walk the list, looking for matching LSMs. */
 	while ((name = strsep(&next, ",")) != NULL) {
-		bool found = false;
-
 		lsm_for_each_raw(lsm) {
-			if (strcmp(lsm->id->name, name) == 0) {
-				if (lsm->order == LSM_ORDER_MUTABLE)
-					lsm_order_append(lsm, origin);
-				found = true;
-			}
+			if (!strcmp(lsm->id->name, name) &&
+			    lsm->order == LSM_ORDER_MUTABLE)
+				lsm_order_append(lsm, src);
 		}
-
-		if (!found)
-			init_debug("%s ignored: %s (not built into kernel)\n",
-				   origin, name);
 	}
+	kfree(sep);
 
-	/* Process "security=", if given. */
+	/* Legacy LSM if specified. */
 	if (lsm_order_legacy) {
 		lsm_for_each_raw(lsm) {
-			if (lsm_order_exists(lsm))
-				continue;
-			if (strcmp(lsm->id->name, lsm_order_legacy) == 0)
-				lsm_order_append(lsm, "security=");
+			if (!strcmp(lsm->id->name, lsm_order_legacy))
+				lsm_order_append(lsm, src);
 		}
 	}
 
-	/* LSM_ORDER_LAST is always last. */
+	/* LSM_ORDER_LAST */
 	lsm_for_each_raw(lsm) {
 		if (lsm->order == LSM_ORDER_LAST)
-			lsm_order_append(lsm, "   last");
+			lsm_order_append(lsm, "last");
 	}
 
-	/* Disable all LSMs not in the ordered list. */
+	/* Disable all LSMs not previously enabled. */
 	lsm_for_each_raw(lsm) {
 		if (lsm_order_exists(lsm))
 			continue;
 		lsm_enabled_set(lsm, false);
 		init_debug("%s skipped: %s (not in requested order)\n",
-			   origin, lsm->id->name);
+			   src, lsm->id->name);
 	}
-
-	kfree(sep);
 }
 
 /**
@@ -322,9 +314,9 @@ static void __init lsm_init_ordered(void)
 				lsm_order_legacy, lsm_order_cmdline);
 			lsm_order_legacy = NULL;
 		}
-		ordered_lsm_parse(lsm_order_cmdline, "cmdline");
+		lsm_order_parse(lsm_order_cmdline, "cmdline");
 	} else
-		ordered_lsm_parse(lsm_order_builtin, "builtin");
+		lsm_order_parse(lsm_order_builtin, "builtin");
 
 	lsm_order_for_each(lsm) {
 		lsm_prepare(*lsm);
-- 
2.51.1.dirty

