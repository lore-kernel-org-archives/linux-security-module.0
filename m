Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DDA26ED5F
	for <linux-security-module@vger.kernel.org>; Wed, 26 Nov 2025 12:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764159668; cv=none; b=ZBfw2Dpo9pIJ2dbFk/VPagddycwWMPZJi9iFv8Rrv545O8nAXPsgJMRYnodFWO2XLvEJjQi+3JO7NzQt2SSZOGELFC9YtU/yG5CSr9iqIONSylDJG5b0a7OGIvjfs5Xj4DkOpk/SEMwbsbbs+42qabnqSLKEE6qGqRoGWQItmPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764159668; c=relaxed/simple;
	bh=ItFn/XuGrJOWTowD0M/S3tbzP91i7irJnSwOIBK1gyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AiKMjB56gMHkKX87nnQcdu7vuvWPFTNf2ez9T9RUr0651tR/cakQ/JnWpDnLL7AQ6d3dfwlHF+qejy6I5i70JQ7ibVKkUbfRy/7vzowCJtUa30vvmHscwq86Cs6LU3lBwi3GIaLh5qbNWRwE8OlQzL8RFu7DdjBBCHhJdrceeFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=knTUyRKs; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knTUyRKs"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-641e4744e59so6929889d50.2
        for <linux-security-module@vger.kernel.org>; Wed, 26 Nov 2025 04:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764159662; x=1764764462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClUZeXLkHIzjOz+gIerE1H1yDZXEfvYWg406WJpW1DA=;
        b=knTUyRKsZNHQbUen5Lvd1dUxNZmmlTqiUCc8VN+PxgXBCQctqb/BsDikabAoPTZNJa
         o99wBK1wKCaJQFOlkZ1sv9/o86NbsSowijS92eRFPr2MdgbQ8Fd5XQ2+m0hjACDbPz/O
         iR7LMPBklMDHeB+1NhahxMSmPmrbZs1vfmfD4CvSzV+7WOPVvcYq3iIOmYw7PL9l0YlF
         IJ7XLnU+SlIv1m0TSNQNvI80JnDwEKWAFoFNT166WTxBv+dOq/b/raObXUc0aDGOVCb8
         SR5ujh00o5mIARbPd+05HUGGe8LxElK6KMjP6bJgkneHRYTwB9YNgzpdq2i+sMmVyb7k
         6a7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764159662; x=1764764462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ClUZeXLkHIzjOz+gIerE1H1yDZXEfvYWg406WJpW1DA=;
        b=U8VwqmHkrYDTWflWYUATKnC2/zv+i4o/C7/B8HrthVQRyjj7YIu99Tp9dfIdH8ePvC
         j7rAiKRmYLM4XBcxe5zTNnp5sjhk4dI2RVnn1Rw2/ACiwfvnWMbuSvLRtVxp5LVFth5K
         KS20qy8c1LFKBBDN4puMAoPefByX/LZsxgUxEv6GZvfRDjT0zTR9uAzYh3y1fZd36kzG
         0NncdlKcuiLPyxKnyt4e7ZdjI8Q2fNxcE+6QYkbTxzrjiKrGTfcN4RWrYun73WLxfQRV
         Qt/6UhOfgqxfwiqxCy6hIH7opHJKUZNLGTLesbgbJOUs22J4h8WFqqDsKVc6qvEMHtpX
         G92g==
X-Gm-Message-State: AOJu0YyQwfRvYUvemmiLoInEieQfQmLctoQYu3BYTaezz9Lw+DyRR2uV
	P2Zlerc/TgezR5stCouke8hLm0E5fS17xu7wa9NreVJjBtNVTU1jDSBmnE1cYwa9
X-Gm-Gg: ASbGncvwMLGlHPkaruOeAEkMw/zgl5/WkjFG12D+IXfWSFPOSIdUpDCtNziLYK7k9Ba
	3MULMGpFWjFOfxqhK+ENEGC7VZp0TO9X/jJrLtQxVN+RCHVy9LXwE9+hFIyHuKWLVH4ELn8tAlp
	1wKDOTAQ37i4E9yZeynbrIfVa7L0FZ7n5ole+2qeL2knDLKXBI4Eby8Ej/jEQD/A3z0Qpv2Ukgq
	Fvtpk+H3daKNDxeXMVVIMHTz1BemqoHkcEF11l53x5cjDwHhZgi0MFBv6TvZPinV+DirNir+2Mp
	7ehecmItbYbf1BGMxozXnW5Tu/xk7TPeKZ00awzk7e5KzUmWs9uq/QrbGsbhDdA/fKBeNfCIFGM
	fMZpd1a643fbRKbwLNRrNJ2VetNXT1mk9dDz9WqSeRkzeUGpHFrc5IFi4cev8h9lHswH7O2HHS3
	S8L7CMFTgIQvzHD1wtsX3h94x9ocO0tTRZDVL+RhWYV7OnAMSWa9xsmnNjQTM9D/XsjhExzvY=
X-Google-Smtp-Source: AGHT+IFtoZ6Cm0TAmEmXEaeEYDixRDeOYu1wX+LGel0YT2AcGHj2B1swxIobMRjXMm7iHozT9NdWdA==
X-Received: by 2002:a05:690c:3388:b0:78a:6e23:2542 with SMTP id 00721157ae682-78a8b5288a9mr148114747b3.35.1764159662491;
        Wed, 26 Nov 2025 04:21:02 -0800 (PST)
Received: from zenbox (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a7992799dsm66318057b3.33.2025.11.26.04.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 04:21:02 -0800 (PST)
From: Justin Suess <utilityemal77@gmail.com>
To: linux-security-module@vger.kernel.org
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH v3 2/5] landlock: Implement LANDLOCK_ADD_RULE_NO_INHERIT userspace api
Date: Wed, 26 Nov 2025 07:20:35 -0500
Message-ID: <20251126122039.3832162-3-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251126122039.3832162-1-utilityemal77@gmail.com>
References: <20251126122039.3832162-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implements the syscall side flag handling and kernel api headers for the
LANDLOCK_ADD_RULE_NO_INHERIT flag.

v2..v3 changes:

  * Extended documentation for flag inheritance suppression on
    LANDLOCK_ADD_RULE_NO_INHERIT.
  * Extended the flag validation rules in the syscall.
  * Added mention of no inherit in empty rules in add_rule_path_beneath
    as per Tingmao Wang's suggestion.
  * Added check for useless no-inherit flag in networking rules.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 include/uapi/linux/landlock.h | 29 +++++++++++++++++++++++++++++
 security/landlock/syscalls.c  | 14 +++++++++++---
 2 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index d4f47d20361a..cf5c8068f513 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -127,10 +127,39 @@ struct landlock_ruleset_attr {
  *     allowed_access in the passed in rule_attr.  When this flag is
  *     present, the caller is also allowed to pass in an empty
  *     allowed_access.
+ * %LANDLOCK_ADD_RULE_NO_INHERIT
+ *     When set on a rule being added to a ruleset, this flag disables the
+ *     inheritance of access rights and flags from parent objects.
+ *
+ *     This flag currently applies only to filesystem rules.  Adding it to
+ *     non-filesystem rules wil return -EINVAL, unless future extensions
+ *     of Landlock define other hierarchical object types.
+ *
+ *     By default, Landlock filesystem rules inherit allowed accesses from
+ *     ancestor directories: if a parent directory grants certain rights,
+ *     those rights also apply to its children.  A rule marked with
+ *     LANDLOCK_ADD_RULE_NO_INHERIT stops this propagation at the directory
+ *     covered by the rule.  Descendants of that directory continue to inherit
+ *     normally unless they also have rules using this flag.
+ *
+ *     If a regular file is marked with this flag, it will not inherit any
+ *     access rights from its parent directories; only the accesses explicitly
+ *     allowed by the rule will apply to that file.
+ *
+ *     This flag also enforces parent-directory restrictions: rename, rmdir,
+ *     link, and other operations that would change the directory's immediate
+ *     parent subtree are denied up to the mount point.  This prevents
+ *     sandboxed processes from manipulating the filesystem hierarchy to evade
+ *     restrictions (e.g., via sandbox-restart attacks).
+ *
+ *     In addition, this flag blocks the inheritance of rule-layer flags
+ *     (such as the quiet flag) from parent directories to the object covered
+ *     by this rule.
  */
 
 /* clang-format off */
 #define LANDLOCK_ADD_RULE_QUIET			(1U << 0)
+#define LANDLOCK_ADD_RULE_NO_INHERIT		(1U << 1)
 /* clang-format on */
 
 /**
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 93396bfc1500..1ea9bf95ef61 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -352,7 +352,7 @@ static int add_rule_path_beneath(struct landlock_ruleset *const ruleset,
 	/*
 	 * Informs about useless rule: empty allowed_access (i.e. deny rules)
 	 * are ignored in path walks.  However, the rule is not useless if it
-	 * is there to hold a quiet flag
+	 * is there to hold a quiet or no inherit flag.
 	 */
 	if (!flags && !path_beneath_attr.allowed_access)
 		return -ENOMSG;
@@ -407,6 +407,10 @@ static int add_rule_net_port(struct landlock_ruleset *ruleset,
 	if (flags & LANDLOCK_ADD_RULE_QUIET && !ruleset->quiet_masks.net)
 		return -EINVAL;
 
+	/* No inherit is always useless for this scope */
+	if (flags & LANDLOCK_ADD_RULE_NO_INHERIT)
+		return -EINVAL;
+
 	/* Denies inserting a rule with port greater than 65535. */
 	if (net_port_attr.port > U16_MAX)
 		return -EINVAL;
@@ -462,8 +466,12 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
 
 	if (!is_initialized())
 		return -EOPNOTSUPP;
-
-	if (flags && flags != LANDLOCK_ADD_RULE_QUIET)
+	/* Checks flag existence */
+	if (flags && flags & ~(LANDLOCK_ADD_RULE_QUIET | LANDLOCK_ADD_RULE_NO_INHERIT))
+		return -EINVAL;
+	/* No inherit may only apply on path_beneath rules. */
+	if ((flags & LANDLOCK_ADD_RULE_NO_INHERIT) &&
+	    rule_type != LANDLOCK_RULE_PATH_BENEATH)
 		return -EINVAL;
 
 	/* Gets and checks the ruleset. */
-- 
2.51.0

