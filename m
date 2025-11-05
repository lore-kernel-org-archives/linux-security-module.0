Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FD22609D6
	for <linux-security-module@vger.kernel.org>; Wed,  5 Nov 2025 18:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762365643; cv=none; b=RJpwWu5WyN8en28S2zuh5RdXlBVtq38OPFdqTpMzLntQBhJYcZnW8p6Q1UYKvUZedl55M8Bk4f/bkJ4XlCQzpEl7m9V5Yn5BIC2M5o8RUwl4XnMBRASkAKomjgc2MNKwo82ogvKIRdsZFX91utxsUOJfNqw+JMcpAArojqj0xEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762365643; c=relaxed/simple;
	bh=hdUCiDT7Z4HuqOYVbAqcP5PX/JnkSllkQJgYA/PsS58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MZT1er+led5uz9e4qAWQmlR6aGvNrUZkV3fZF194Vg+hN0YUBYy5Z6RGT4dJekPwVn3lFJFYjB67JZ6dr+WkwPtut9OYhqzfzhe+5klNjKR26Zt/GqMmCuyHWxN1E/7fw7Msq7lG2JMqRQ5VrAP9A/eJT/vRa+DQbleIv0/iEFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IA6bquNI; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IA6bquNI"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-78682bab930so1588937b3.1
        for <linux-security-module@vger.kernel.org>; Wed, 05 Nov 2025 10:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762365641; x=1762970441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WspBg7IeccTdLV1am3H4Pgb5RkK1Ohk4Wiro+t6dZas=;
        b=IA6bquNImqkogzwIuZdQNNmjqOw2xGL53s1ivtnTBr+FAhMWkVEODqqR3i0QY+JrlF
         r/QGgSpwuC83/h5ylYYsVKTYqKLcX/x4hPmOSXPiOrSgiGtBjSks2dpt4z2FZjFGXBg3
         8KfMExhgooWh1QB1Ur9C5hrTtVv9GDNg30kwuzcs/MuCoUu0VfjnrFXNgXQJZETIkna1
         ZgC1qGUjcZEJiwkLFfakfV5bEPfMnfY3Sai9yi2Bmr+VbeiVsAdB2yJItdd5ZbvHL+9F
         i9rXRJRXbjXA3740hxeInVbbLW1lDcGMa9wnERrUF3BI83tN/nkNtvRhZ7fO1eZYHq8I
         BIoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762365641; x=1762970441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WspBg7IeccTdLV1am3H4Pgb5RkK1Ohk4Wiro+t6dZas=;
        b=UEGHP6fkncRLO/CIs3c7fH/j/tU2Z0e/CXV9q6ULdRh8Ju4JWqjBi5Qn1VbRBWsoyE
         VJUOt0HsNTUxUu9LNY8ohGbWQj4qOxlqrPCxlqEqCvOJx0XEm9X6ZQvYz2/HeJ7lA97X
         uVvd3v3nN0PvrP+EhLC0uIIZWA5zZBvkAGFKl367Fp8Nfuoyq2MGbC2J8lLdfbX0FTOz
         OG0SRgfZG+KcK/gM5H90Uc2ApPD3sHOctTphgeoxqBWcYdH3wtGTH8x2oXc8ORhH6oof
         2v9JXynzdvVAOzbO39/LOvwTqKcTCXMyjkMM59qVq5dQCox5EMMxu2xMiCYbW5Yd5aCR
         m84Q==
X-Gm-Message-State: AOJu0YxpdWOqzH+wPDG8V1wH845z2JE/IHGN2zwLJj0atIswYrjlM1xz
	ytNcpQzS4bby4P/KBXr7MUG9oJ0fwaCuMiyg1UoRWOo+EBcELBte37DFlOyrmW2h
X-Gm-Gg: ASbGncvD7YN5y6dVE1ts8RS28cVAQ/nftTCb+nt33I+DdP7V+MduKYyhtsz8GcWTHqd
	1syiQIEbk248CzOY1oR30+O68YJiZu5QBvg7d5m5963KmRq/jFIdJ90BfubXbr0yOTB7TrikhRr
	yxTXzV3m9e7ZRvTCR0x88N32vLnytBUYUn/8Wo/Tda86PIteEQWOQTPTYrCz3T5C1H0WUdDOjWS
	d/lFJs6XXKQ3EqldzBJ3cMLyXo8+wFHTi7b7i1NnvhQEnVybl7d0fldylPWLo3pOQtKBmhoka40
	eqlUwYK3b5HIcItqFjsJvcJ5fM93PfRoLjKMvyZ5aU8sdErcVBK6V3iSO2dNaF95JGMuBu1bV6w
	g19WLH1E1I8JS6IWOPfMW2YWmPlU8uYLwsjjKGHYdP2khrURJkM8tSi0sNO2bwluWr87HGYpCQ7
	SLp8hAfsaKHba/fh6Q1KeKsAtKOH/i2UyJ4Xn2wzEzTVpPtNs0/w==
X-Google-Smtp-Source: AGHT+IG/L+kt9IoFL+RjPuPFjJ5iV3CMIVdhmiNliT4C3/l0y+9ME5GNFBpy1nD6/4JhOEJoidEhwQ==
X-Received: by 2002:a05:690c:a71a:b0:786:7842:b3e1 with SMTP id 00721157ae682-787b1241da5mr2486237b3.12.1762365640712;
        Wed, 05 Nov 2025 10:00:40 -0800 (PST)
Received: from zenbox (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787b13faf56sm756657b3.19.2025.11.05.10.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 10:00:40 -0800 (PST)
From: Justin Suess <utilityemal77@gmail.com>
To: linux-security-module@vger.kernel.org
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH 1/3] landlock: Add flag to supress access rule inheritence within a layer
Date: Wed,  5 Nov 2025 13:00:17 -0500
Message-ID: <20251105180019.1432367-2-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251105180019.1432367-1-utilityemal77@gmail.com>
References: <20251105180019.1432367-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Creates a new flag that prevents inheriting access rights from parent
objects within a single landlock layer. For example /a/b = ro + no inherit
and /a = rw results in /a/b recieving ro and not rw permissions.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 include/uapi/linux/landlock.h |  9 +++++++++
 security/landlock/ruleset.c   |  8 ++++++++
 security/landlock/ruleset.h   | 10 ++++++++++
 security/landlock/syscalls.c  |  3 ++-
 4 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 50f0806b7e33..d9daef551d96 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -127,10 +127,19 @@ struct landlock_ruleset_attr {
  *     allowed_access in the passed in rule_attr.  When this flag is
  *     present, the caller is also allowed to pass in an empty
  *     allowed_access.
+ * %LANDLOCK_ADD_RULE_NO_INHERIT
+ *     When this flag is set while adding a rule to a ruleset, the rule
+ *     will not inherit allowed accesses from rules on parent objects
+ *     within the same layer. (currently only applies to filesystem objects)
+ *     By default, Landlock rules added to a ruleset inherit allowed accesses
+ *     from parent objects, meaning that if a parent directory has been granted
+ *     certain access rights, those rights will also apply to its child objects.
+ *     This flag prevents such inheritance for the specific rule being added.
  */

 /* clang-format off */
 #define LANDLOCK_ADD_RULE_QUIET			(1U << 0)
+#define LANDLOCK_ADD_RULE_NO_INHERIT		(1U << 1)
 /* clang-format on */

 /**
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index e0bb7e795574..8fab8222fc30 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -315,6 +315,7 @@ int landlock_insert_rule(struct landlock_ruleset *const ruleset,
 		.level = 0,
 		.flags = {
 			.quiet = !!(flags & LANDLOCK_ADD_RULE_QUIET),
+			.no_inherit = !!(flags & LANDLOCK_ADD_RULE_NO_INHERIT),
 		}
 	} };

@@ -660,9 +661,16 @@ bool landlock_unmask_layers(const struct landlock_rule *const rule,
 		unsigned long access_bit;
 		bool is_empty;

+		/* Skip layers that already have no inherit flags. */
+		if (rule_flags &&
+		    (rule_flags->no_inherit_masks & layer_bit))
+			continue;
+
 		/* Collect rule flags for each layer. */
 		if (rule_flags && layer->flags.quiet)
 			rule_flags->quiet_masks |= layer_bit;
+		if (rule_flags && layer->flags.no_inherit)
+			rule_flags->no_inherit_masks |= layer_bit;

 		/*
 		 * Records in @layer_masks which layer grants access to each requested
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index cd0434d8dc63..7759151ce727 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -40,6 +40,12 @@ struct landlock_layer {
 		 * down the file hierarchy.
 		 */
 		bool quiet:1;
+		/**
+		 * @no_inherit: When set, this layer's rule does not inherit
+		 * allowed accesses from parent objects within the same layer.
+		 * (currently only applies to filesystem objects)
+		 */
+		bool no_inherit:1;
 	} flags;
 	/**
 	 * @access: Bitfield of allowed actions on the kernel object.  They are
@@ -56,6 +62,10 @@ struct collected_rule_flags {
 	 * @quiet_masks: Layers for which the quiet flag is effective.
 	 */
 	layer_mask_t quiet_masks;
+	/**
+	 * @no_inherit_masks: Layers for which the no_inherit flag is effective.
+	 */
+	layer_mask_t no_inherit_masks;
 };

 /**
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 93396bfc1500..ed7304d53894 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -463,7 +463,8 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
 	if (!is_initialized())
 		return -EOPNOTSUPP;

-	if (flags && flags != LANDLOCK_ADD_RULE_QUIET)
+	if (flags && flags & ~(LANDLOCK_ADD_RULE_QUIET | \
+		LANDLOCK_ADD_RULE_NO_INHERIT))
 		return -EINVAL;

 	/* Gets and checks the ruleset. */
--
2.51.0

