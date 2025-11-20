Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D99C25F988
	for <linux-security-module@vger.kernel.org>; Thu, 20 Nov 2025 22:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763677450; cv=none; b=moiRMTujYqZRAdiBMzHT3tm+r668VPvPGtFFkGgKErNd0ZMgClTEURVf1yuTqBwmpK3aZf+7AdQgM2C9jd/JImT1gzFApLQ26WomjOKNU9PAz07AOC5gaWnGVN9xxQSoT/C8wSkLc5hMxGxN1fOuazXkYzYqMrhU+wgdgHZpa7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763677450; c=relaxed/simple;
	bh=7qaJgsm5bXfEX5hk6jpcAN7LvDs2TU5mdDP/qE0Jlfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m40EAeKdHuiZ4dmtDHqhzkAP5rM6f6NITDxe45DTnoLYGLWCQEbAwig2lGq0+UqGf3APo2Xrp/U4hCLCf6WrkkcsNehOwfXXmpOUAMmTbw3jCTfiBTqsB6GRoczPK/WEExfT9b/Raqt9qFnUHfl2HS9KJ1E4oaol8pzfr6/juKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MxZiqdjd; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MxZiqdjd"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-640d790d444so1295878d50.0
        for <linux-security-module@vger.kernel.org>; Thu, 20 Nov 2025 14:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763677448; x=1764282248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qkkAo4A2esazo/V25/sXTz6NfoKHbt609C8UisXhN1U=;
        b=MxZiqdjdwLfliA34VIRZxfxRfl/EX+jtPyUwVyZNN6Zsmewu5xeGqaJhz5wHziaM+W
         b94/Yjy8XdwSRDnN5/dlWWvdOawlGay/pTC9Hz32GxvWPBKDJjEsQ+4JHWmvBXdTY6JD
         zyQXXbIS5Y1zrTPvbsdLThA4JeTAZG2+puvPlbNMgSlyXw1MknxHsXQX+e8Wj4pvgyMo
         OZEpwHGzBTSSPpRbiz8WWzC7iLIhw01xqdX2HnevFevhYSB4XcL9l0iHgfyqZ7+jxs7e
         TheEQpcSrdzvaPtEgMCuO4/60bQEfhTbVxz6V0HhH2c4GZ6Zpobhbo62aCRcdQwpAz3M
         kLDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763677448; x=1764282248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qkkAo4A2esazo/V25/sXTz6NfoKHbt609C8UisXhN1U=;
        b=uTMQ/pd3eahOw6d/lL8SCTYju+Os7+v5eA1Nzq+I+keY8QUI/R2vGiD+wuzIq7n9ky
         LaPG5U5EVjJf8by6NIjbsy+J20ZypZtkSvZ7/VIle/dltJE7fnqGnAuJoMcSMH139H0L
         SivFzkdfjmCm/QM5BzNGkT3ZvIOWgO6t8/BRfa9lnAzgVqC4fCiDip5qTsTwT/oWiMrP
         tFXD91U8AxCg3oLHCYfzXeylOvYsjnDgWqYqyoeZ1njxTwMCp8jgHmA9PYgTLb52qbxp
         WrHSPXZipJUWB8rzrlZEDmfyLC754WVhWOlz26v6kWNoe8Bpi+bz+XkEtiEEbeqtg/i/
         4q3Q==
X-Gm-Message-State: AOJu0YzQ5P4p7Uib2tKTJVhbV7XICsNQ4w2AY5eOUMYezGxCS7RoLrEW
	GtkJ3Lk5NcNpDBeAwKUqmbKt+xfofCjpfKBMGvti/hMSTGVo6akdn1ak8QdywRH4Pml/iw==
X-Gm-Gg: ASbGncsDJ/ZEPctsM3BJ1u1309KtWOyiuNAssEfCeky46LtykTX25eHepvRg+X2A4fq
	tUMyqod/U2CwUN7eggCkBbQbjQnVw3VF3HJCxhVHOCMNm5JwF37/+KeBAEctfEO564QQbInvk1U
	TVfMRpIABjPyziUZI8dNhQwL843i7krPbpxoOXmuDUp4tGp/mO2JSLGn2Bqc+BElYQbajrdCsZk
	VONlNQjGDHgXLzaSe/8HJPg/93T95nTS4zU9Pc+UKoR9y6TzcewFdoFze1HmDgEL4Gkf05pxm2G
	1wRsr330kToS4VRfxHLcoeCs1ebdGEBEKka0MNjpabyvrXNEDsuBD8QFlqv3DER7kPx9C8nBQGu
	qtiKrm+k3ysw7XthRNrHrR6xv+41Wx+MZJlBR33Tqd5b5zQL6hSgI+ULKgXvLLjNUAijy05ddrp
	1i8g52Q0obGqUBDauTCdCJr6wcVWoWtzr2Y+uLjO+8cJsjbzEyUuAkN1FULF/F
X-Google-Smtp-Source: AGHT+IFBTFlQgeJgPzglPyNjYsm3OZCg2Gl8KjcdTvCbABJK7fJ2av+QMvFZGNehTX1iNQAyi0U3ew==
X-Received: by 2002:a05:690e:4297:20b0:63f:556b:5b7 with SMTP id 956f58d0204a3-64302a2dc96mr23362d50.15.1763677447984;
        Thu, 20 Nov 2025 14:24:07 -0800 (PST)
Received: from zenbox (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a7993cedesm10954757b3.41.2025.11.20.14.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 14:24:07 -0800 (PST)
From: Justin Suess <utilityemal77@gmail.com>
To: linux-security-module@vger.kernel.org
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH 5/6] landlock: Fix compilation error for kunit tests when CONFIG_AUDIT is disabled.
Date: Thu, 20 Nov 2025 17:23:45 -0500
Message-ID: <20251120222346.1157004-6-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251120222346.1157004-1-utilityemal77@gmail.com>
References: <20251120222346.1157004-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This was necessary when fixing the no inherit patch in the implementation of kunit tests.

When compiled without the audit flag enabled, kunit tests would fail to compile because of
the missing quiet flag field. This fixes this issue.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 security/landlock/audit.h   | 3 ++-
 security/landlock/fs.c      | 4 +++-
 security/landlock/net.h     | 2 +-
 security/landlock/ruleset.c | 2 ++
 4 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/security/landlock/audit.h b/security/landlock/audit.h
index 950365cd223d..1a5a9cd28cf4 100644
--- a/security/landlock/audit.h
+++ b/security/landlock/audit.h
@@ -69,7 +69,8 @@ landlock_log_drop_domain(const struct landlock_hierarchy *const hierarchy)
 
 static inline void
 landlock_log_denial(const struct landlock_cred_security *const subject,
-		    const struct landlock_request *const request)
+		    const struct landlock_request *const request,
+		    const struct collected_rule_flags rule_flags)
 {
 }
 
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index ebeee080ea7a..20a24f3988bc 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -2094,7 +2094,7 @@ static int hook_path_unlink(const struct path *const dir,
 	const struct landlock_cred_security *const subject =
 		landlock_get_applicable_subject(current_cred(), any_fs, NULL);
 	int err;
-	
+
 	if (subject) {
 		err = deny_no_inherit_topology_change(subject, dentry);
 		if (err)
@@ -2155,6 +2155,7 @@ get_required_file_open_access(const struct file *const file)
 
 static void build_check_file_security(void)
 {
+#ifdef CONFIG_AUDIT
 	const struct landlock_file_security file_sec = {
 		.quiet_optional_accesses = ~0,
 		.fown_layer = ~0,
@@ -2171,6 +2172,7 @@ static void build_check_file_security(void)
 		     __const_hweight64(_LANDLOCK_ACCESS_FS_OPTIONAL));
 	/* Makes sure all layers can be identified. */
 	BUILD_BUG_ON(file_sec.fown_layer < LANDLOCK_MAX_NUM_LAYERS - 1);
+#endif /* CONFIG_AUDIT */
 }
 
 static int hook_file_alloc_security(struct file *const file)
diff --git a/security/landlock/net.h b/security/landlock/net.h
index 799cedd5d0b7..72c47f4d6803 100644
--- a/security/landlock/net.h
+++ b/security/landlock/net.h
@@ -25,7 +25,7 @@ static inline void landlock_add_net_hooks(void)
 
 static inline int
 landlock_append_net_rule(struct landlock_ruleset *const ruleset, const u16 port,
-			 access_mask_t access_rights)
+			 access_mask_t access_rights, const int flags)
 {
 	return -EAFNOSUPPORT;
 }
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index 63aa420ab593..5d190d6779da 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -660,7 +660,9 @@ landlock_merge_ruleset(struct landlock_ruleset *const parent,
 	if (err)
 		return ERR_PTR(err);
 
+#ifdef CONFIG_AUDIT
 	new_dom->hierarchy->quiet_masks = ruleset->quiet_masks;
+#endif /* CONFIG_AUDIT */
 
 	return no_free_ptr(new_dom);
 }
-- 
2.51.2

