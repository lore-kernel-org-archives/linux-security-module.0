Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602E6354AF8
	for <linux-security-module@vger.kernel.org>; Fri, 17 Oct 2025 20:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760732971; cv=none; b=daZB9cAUzlQP4H7NVSAaxRsO2mMwGj+Pc7zeJVy3ydKaXEBRAG1uTg+qW3ZdfqV/c+3J67jjV86BU+a0jVmJHAVxZNJkzzhSB29YpemeHRVjAfsDeDL078VxVxq6ApZlOJntSTLzBw4zaF8OmsVGTm1II1q73LffMxiQrUZCjXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760732971; c=relaxed/simple;
	bh=buJBnNY6xRAiYvKynjWYzclkfyX8UJG0i5UEwl0AnV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kaTlHHyInGPGD6NwQ2WAPB2msaWB5VQyZg2Hkesnz0EcEDq5oZb5jLdeNMM1GD7up33bf0J6E5MDcTSf8TuY6FmOWq+I0szrM+K5Gcw5mjvtT85XGqOGrxvY0OZvoIF95RwlF5dIOhJOaqb0nPHmTheSQKo+1Z7JFgqOVKgV9Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=F1vEkAyg; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="F1vEkAyg"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-79a7d439efbso30980456d6.0
        for <linux-security-module@vger.kernel.org>; Fri, 17 Oct 2025 13:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760732967; x=1761337767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CmouHXyAlCdfISQnPeQnDz4oV75mD2MuR+ljlGK2IOQ=;
        b=F1vEkAyg1e6B5Yg/sE57JcdnfFjW3i7I0F+T0rJFNNgTHzySkxfiMgTkuBmsfZdaDo
         rok2NREvEFlzy7shzLqfoMvuk6JarOBOT0bxN95/bHzkwgP37xJe3PSnFtt+kP8tXOtk
         7qQjvkMO4ZFC/qX3+zIhidXB5Z9o3a7tmYvllpxMFtoz7a5vI+mqyQCtgcszfghuIfu4
         nBC0Y8q7/kJf1lybkUMRL8ejTNVJjNWNKO7PXgCrCvutS0CbmHZ2kBbMLLuvmjOvUamY
         /03dNZjPuQ/N/BC7qghzEbm7QXiyJAPMK4AvjKiyb+hOSrOCdagGeOcWTlpxiOKRjhU0
         poMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760732967; x=1761337767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CmouHXyAlCdfISQnPeQnDz4oV75mD2MuR+ljlGK2IOQ=;
        b=qIDek4xO1PSvqkeagVihbb219j/nFsCwXPokBcRqdh8srDQTvsuv9WMr3QDRlHAb6e
         QlZAHX02AWBTfOBJNrDqLwwGkXhrvhhypTd/HEOpT45uRnI/HrbX7YfBV7oiEMkxZOfp
         i4UMQT1WpaoPjyJAHcaV8zahbHdhtJ6Wxl+2pHYAgLQe+NSUq/7TJBvYAC310qke9Ywo
         Rmd1YuHMa2sIo8kPN8vrdPrjfFIzgSz4VfdRJi0qQBYx57nC+sVhmr4P7Az0GFvAcYxH
         VUk802sCl2jcX8S+v+4aZBUGvE5osl33m0dWtPN0G5GBnXp8WEx3xmgF3YtTclbYv42C
         y0YA==
X-Gm-Message-State: AOJu0YyTQ9DiIpJ/+mq+kuVNwynb7et0mcfKoTQDyTnAWTrp2pRF43tC
	3oKRPecsvXzzdgnvlLt/2rC76Z6k5QDJkFvWgmwthNw5OyoSDRNyN6sHfI7h0BEb/Z90xq5Rhqm
	fLWXayg==
X-Gm-Gg: ASbGncscZcekqzRSmIduRHmVsbvIgijHGxlt5MaXIexdpO662jtOaMWzZRuuBr7PoXk
	PvEH51ZeRDWSG49a3M9pyLBT/XoVpW0TfymHH4EHsAr7+fmFfKGIjx1HJlGzyTJjG7FIvkOjRvx
	JYE11DJd/OrOaSaJGxkr0xtyGRY1HfnJE3p6c4TQmSejWvxU19CB1eNDXDBOUaqGxt9+yI5h0dK
	PtehQte/QrwTirvV+kIhwYN0gAd1jbAeg0Uc4W3jJD3ngBgU0yixqDhdFoHmsVUxLqiakzZuvSQ
	DXAajM9lIjhU6nWD9hjdJfn7t3cqammkhblIwULoCWERofgGP/2Bu2m3A4KsZ3mPjsSJoKGE+FI
	ZV2hHwLh1OfeLmIEqi4HscTmXWZFt+dftzXBl1Y7qIA7cVW1lRlUH1e8fYb/EeTz6foiV9bwVD9
	7HwiFH3AhiuCzWzBAFIRXZSLeKtMNPN61x9i1u9JS83WYjbw==
X-Google-Smtp-Source: AGHT+IHt88Q+YL16jUiFmmJzbYiEQoNtpomEOX1cPRjTwZv3ZHJJRwPN8CCSxJ1NxsMWtIwIICJG6g==
X-Received: by 2002:ad4:5be2:0:b0:87c:1ec5:8424 with SMTP id 6a1803df08f44-87c2061009amr76069636d6.31.1760732967544;
        Fri, 17 Oct 2025 13:29:27 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87d028932d3sm4757226d6.41.2025.10.17.13.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 13:29:25 -0700 (PDT)
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
Subject: [PATCH v5 22/34] lsm: group lsm_order_parse() with the other lsm_order_*() functions
Date: Fri, 17 Oct 2025 16:24:50 -0400
Message-ID: <20251017202456.484010-58-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251017202456.484010-36-paul@paul-moore.com>
References: <20251017202456.484010-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4966; i=paul@paul-moore.com; h=from:subject; bh=buJBnNY6xRAiYvKynjWYzclkfyX8UJG0i5UEwl0AnV8=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBo8qZdkJO6Oogbr1vQS8mGfhhQxCbYl8GnYlQz1 729sjBbxCeJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaPKmXQAKCRDqIPLalzeJ c8j3D/sFucwJ2ywzEBVUhSowcPHTVOF/6QaJIo9KtEII007FfdvHhxiDQLpVALzQzjQ+1+cYpHZ Efy6HmBmuZUCdG9xKUiNB32eRbB0fZ7PSfgFgOriR0Xl1JTijxIKYVmG7eBaUqvoycxKmCFUlTr NnXQ8/hSdMMFHY7VUT+rcBSVpU5Gk7zykFp6RnyqGVES/z1uG806a7dilAXXCC5UX87fgBdPeGi dsL7MsLUoGN0WpSbC6fNbv5g3la8WAE+AdHvYONwG8zTdt0EQC+hZ5fM8Z1CNlp52eiqfLyNFC2 9xZv0IpF65om3XmD86OsdAV0thxI7mahdthhn2uTugbKjOewx93A+zK4/XeVIKu/CGYJElt84r/ S7b7zOoMxtPlHl4REcuEKBKtbVfgORes+3canXRpZ8WzvKulF0rCHLIEPSRC/ENBixXfua/oDGx JdalhSykE1aMuE9Ej8kuvZ4AOo2ZBrZmiVcHRRTVD9HBc8J8HW68kTrBC2khwJhKap8pnDZqLKh NxrtpplQfUALhya/7/CYGJ+YcBwqIw6IZPvzmLeWfCn989gKJ8cRTvViEhIH045Zhn7WIg9pQYM ZLOQVxC/CkcHIeg70NgeTTuvQ0KsuP0Y0xURIIEBtCsrE9zMsgiM2HNSRfXuqtr0LwK14DUHe7M edhleZs7AQqFzEA==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Move the lsm_order_parse() function near the other lsm_order_*()
functions to improve readability.

No code changes.

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 140 ++++++++++++++++++++++----------------------
 1 file changed, 70 insertions(+), 70 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index cfcf3bf7127f..fd69bde9112e 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -169,6 +169,76 @@ static void __init lsm_order_append(struct lsm_info *lsm, const char *src)
 	lsm_pr_dbg("enabling LSM %s:%s\n", src, lsm->id->name);
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
+				lsm_pr_dbg("skip legacy LSM conflict %s:%s\n",
+					   src, lsm->id->name);
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
+		lsm_pr_dbg("skip disabled LSM %s:%s\n", src, lsm->id->name);
+	}
+}
+
 /**
  * lsm_blob_size_update - Update the LSM blob size and offset information
  * @sz_req: the requested additional blob size
@@ -241,76 +311,6 @@ static void __init lsm_init_single(struct lsm_info *lsm)
 	WARN(ret, "%s failed to initialize: %d\n", lsm->id->name, ret);
 }
 
-/**
- * lsm_order_parse - Parse the comma delimited LSM list
- * @list: LSM list
- * @src: source of the list
- */
-static void __init lsm_order_parse(const char *list, const char *src)
-{
-	struct lsm_info *lsm;
-	char *sep, *name, *next;
-
-	/* Handle any Legacy LSM exclusions if one was specified. */
-	if (lsm_order_legacy) {
-		/*
-		 * To match the original "security=" behavior, this explicitly
-		 * does NOT fallback to another Legacy Major if the selected
-		 * one was separately disabled: disable all non-matching
-		 * Legacy Major LSMs.
-		 */
-		lsm_for_each_raw(lsm) {
-			if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) &&
-			     strcmp(lsm->id->name, lsm_order_legacy)) {
-				lsm_enabled_set(lsm, false);
-				lsm_pr_dbg("skip legacy LSM conflict %s:%s\n",
-					   src, lsm->id->name);
-			}
-		}
-	}
-
-	/* LSM_ORDER_FIRST */
-	lsm_for_each_raw(lsm) {
-		if (lsm->order == LSM_ORDER_FIRST)
-			lsm_order_append(lsm, "first");
-	}
-
-	/* Normal or "mutable" LSMs */
-	sep = kstrdup(list, GFP_KERNEL);
-	next = sep;
-	/* Walk the list, looking for matching LSMs. */
-	while ((name = strsep(&next, ",")) != NULL) {
-		lsm_for_each_raw(lsm) {
-			if (!strcmp(lsm->id->name, name) &&
-			    lsm->order == LSM_ORDER_MUTABLE)
-				lsm_order_append(lsm, src);
-		}
-	}
-	kfree(sep);
-
-	/* Legacy LSM if specified. */
-	if (lsm_order_legacy) {
-		lsm_for_each_raw(lsm) {
-			if (!strcmp(lsm->id->name, lsm_order_legacy))
-				lsm_order_append(lsm, src);
-		}
-	}
-
-	/* LSM_ORDER_LAST */
-	lsm_for_each_raw(lsm) {
-		if (lsm->order == LSM_ORDER_LAST)
-			lsm_order_append(lsm, "last");
-	}
-
-	/* Disable all LSMs not previously enabled. */
-	lsm_for_each_raw(lsm) {
-		if (lsm_order_exists(lsm))
-			continue;
-		lsm_enabled_set(lsm, false);
-		lsm_pr_dbg("skip disabled LSM %s:%s\n", src, lsm->id->name);
-	}
-}
-
 /**
  * lsm_static_call_init - Initialize a LSM's static calls
  * @hl: LSM hook list
-- 
2.51.1.dirty

