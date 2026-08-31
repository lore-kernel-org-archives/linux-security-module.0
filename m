Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3AB4A5ECD
	for <linux-security-module@vger.kernel.org>; Mon, 31 Aug 2026 14:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188394; cv=none; b=Fz/S2BWxVaj73VUGpm/erUmAYjoy8CkmThRUCLDp9ANOJ7Kv3fvzIpZQ5N2BNtWEZ8oe0FF4vEHo9PMy6fgRIfq04sVrKKduhfwRpkwfAwHzIOXu0w2pPRjiRULBsPLf3OckvVAbCrzKHCp6jeky25mRCoSbwRxBmPYSYzauB0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188394; c=relaxed/simple;
	bh=6UZqgo1pNVnRYUaLOBFpn2TGeofhqUttyRB0yoGXOFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CY3rVrzMP/o+awpMoDN+p1KsHS0EAnoEp0CKbw1ugRXgvTUtzs1fqNog0NdvDqckcbehG8iv53h4rLfi14ouRRqcXe52USGCtUA+qnS6Mp4vBo46lk8jrHOKqmLeLykoJHrRNbiiGB+8U1/YLLKM5CHvZ1+h+7d8RtZ6899HFz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nYkvfYRh; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYkvfYRh"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-865bdc6ed72so15669917b3.2
        for <linux-security-module@vger.kernel.org>; Mon, 31 Aug 2026 07:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788188392; x=1788793192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8vHIsNy/IN9t6970qY2+L8dSJ+0VAmbxT4VuLQXYbHc=;
        b=nYkvfYRh2kCVnaN0Tj2EhYB4/lWIH1hkSdlsFcbqjPxAEq5YMsvux0IdUOlHxORVhs
         OPs3zXVqr52d5DJJWQV/h/YDwG8JbGlo84KsmHEdYhfT8aRnxlKCATTYmLtY0PPyBFMX
         bDRFKFrunByFw4eiLcdi+Dtc0rIwgI7JDRAOt57HgFtVMiW1uwzxt0yHh1ysFckqKFeC
         Wx9K/9lPtaqDpXnkXMk6eTU70OnEU5y68Q2MGJGsPd53v5keBmKqsby9d9vyH4R3kW+J
         9VD4atWFGTx8rkwuin7omcU8cAbc19CluS1sDkXBGVopeKcIJ4TIvTWp+bVM6VvWfXaX
         S92A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788188392; x=1788793192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8vHIsNy/IN9t6970qY2+L8dSJ+0VAmbxT4VuLQXYbHc=;
        b=Sfk09mzkPT2MbAw40ryeKH05kJELErmMkNdhVJCN7Iqys+RkRhNcafrNGcW9uzOKkq
         UpLwzkOXTw5+tjiJuLCCgw0+SPURWq3JAlRWIB94Dwq54VnbpOvwdsqTCf4OjYJK1U8X
         ZHI6+H57belJexeWgGzNejPCzX/JSFT0vVWoAx7pmPH1cJd8UsfpXUJS65oWn6o8Obmd
         s1q4H4c/eCbXLezB7Wd3+bHYh6K+lxUreum4T6PM2zNmBgxceCSRgrFfnDDi4VU8FPQq
         pPX0s/BxhiLniyd77XcTbsB8YKJKzGiSmtPDPdjao0XOp8pqIwKSK17V/sadGqv1jvCV
         BWPQ==
X-Forwarded-Encrypted: i=1; AKwUvByzKETmiK+P+ycs0va8cPQ2RF4Dol1rhm8vv0wn7zi3QVOhKSjt7ydHLPiK6ZC7/ahH/Ibn+rR9yOAzuqlVKPOTsYhKv+c=@vger.kernel.org
X-Gm-Message-State: AFuF++nEhUWEZxHymvofnPCgf5FCOrWg8je1JKchgyIvV+cIOAN6kd7f
	5QBxC8srNSCtF5dUwuTzmZcf9riqOLR997oOzpclBMT2P2fidLyxY0R3
X-Gm-Gg: AYBFou223LztWrFOEDVPolD1Bn2nzc+TnE970meJdKvv/RHG6s+egsF+2KEbdqGCCHE
	dJ/MCEnDO6dn7Mlt8hq5h4ddHZH7PyYT9pJB9cS4dpegEIQO5IfEeEfx3Gq7dvCw8e3owaSbhCF
	VpcsNumPho+g8VSslC7hM75/vZckmiL7KHh3k8ra3y8ZzwHynnWLJsvUcLHrawUJcz7ZiUMAxB0
	Mf/kk2zdwGu2/fLxzs187xtJ2B+vccxyjiRA5s/lLurACEMz4ewVMm4YzOedx7ZxZsq6yBPz13E
	QjOrC1ee1Gpd2PJbjcP4SgWxPbdFDOhcc8kf4u+jOGUPuVjYI0aolwYuuQslcFtt4dTZMkwmWwF
	LHKLKmZjw9AO+Nas0WTaDU8sJmrmeuYIca9T3LPX3iIcIy7hq4AjGsw6CxMBWKH56HJDu3vQwO9
	nq9BNpcr+uR0ls7Zh03SMDFAU0MkPObP6IgybaNSgMsq6VdlrWEtktQevwwiz4BCDkChkvAsWr1
	TNaDJWIkri9rmox7PvCKra/xNtfBbUJWA==
X-Received: by 2002:a05:690c:c4e6:b0:7fe:4069:d3fe with SMTP id 00721157ae682-868747fe33emr6595577b3.30.1788188392315;
        Mon, 31 Aug 2026 07:59:52 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:f6fc:b424:b1bb:6ff0])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e58666e15sm53903827b3.0.2026.08.31.07.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 07:59:52 -0700 (PDT)
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
	Justin Suess <utilityemal77@gmail.com>,
	Casey Schaufler <casey@schaufler-ca.com>
Subject: [PATCH v2 03/15] lsm: Move the lsm_for_each_hook() macro to security/lsm.h
Date: Mon, 31 Aug 2026 10:58:45 -0400
Message-ID: <20260831145858.3869191-4-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831145858.3869191-1-utilityemal77@gmail.com>
References: <20260831145858.3869191-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the lsm_for_each_hook() iterator from security/security.c to
security/lsm.h, verbatim: a following commit adds a user outside
security.c, the file implementing the LSM policy object kfuncs.
No functional change.

Cc: Paul Moore <paul@paul-moore.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 security/lsm.h      | 6 ++++++
 security/security.c | 5 -----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/security/lsm.h b/security/lsm.h
index 32f808ad4335..264ae63290a8 100644
--- a/security/lsm.h
+++ b/security/lsm.h
@@ -24,6 +24,12 @@ extern bool lsm_debug;
 extern unsigned int lsm_active_cnt;
 extern const struct lsm_id *lsm_idlist[];
 
+/* Iterate over the active implementations of a given hook */
+#define lsm_for_each_hook(scall, NAME)					\
+	for (scall = static_calls_table.NAME;				\
+	     scall - static_calls_table.NAME < MAX_LSM_COUNT; scall++)  \
+		if (static_key_enabled(&scall->active->key))
+
 /* LSM blob configuration */
 extern struct lsm_blob_sizes blob_sizes;
 
diff --git a/security/security.c b/security/security.c
index 71aea8fdf014..0a6fa21cc31b 100644
--- a/security/security.c
+++ b/security/security.c
@@ -495,11 +495,6 @@ OUT:									\
 	RC;								\
 })
 
-#define lsm_for_each_hook(scall, NAME)					\
-	for (scall = static_calls_table.NAME;				\
-	     scall - static_calls_table.NAME < MAX_LSM_COUNT; scall++)  \
-		if (static_key_enabled(&scall->active->key))
-
 /* Security operations */
 
 /**
-- 
2.55.0

