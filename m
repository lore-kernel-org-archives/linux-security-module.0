Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C727B36405A
	for <linux-security-module@vger.kernel.org>; Fri, 29 May 2026 01:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780019553; cv=none; b=D9py/TbSAmfHCQYU2Pyj9zPCylHz0Ga2bxf2vw5IIIecI0WherIZZZV4xpSMKIOcA24fHIZEOd/1Y/yqV5iDsFYgb7kS2AYmPPZrRE1IrbPCKSSpV1oi+1ivDorLEATlFwtCaCrO4koFpf2lHCDKGfbVZ+fcx/Cm6BVzl62ZTpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780019553; c=relaxed/simple;
	bh=FhoN1qEV4juRr7BI4kFjz/UOTAM5HIAT6zECoIPKxXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JxXfwmShIwwWbzCtrpydmf0faqlztgeYnE5dHdP/he97MeM4j4U4kzBpUelILvMxHXoJ7/1WALMzAFASwHAXLV2HyTlOcLWpQiBnmAVEpgz4snHV0yaUpYc7FDQc0GoZdbeN4owFg5B6mC7QyPpFxPAVI3TbdTeKzC1LS8OJsDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rfWm+hfD; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rfWm+hfD"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7c0dea734b8so133896107b3.3
        for <linux-security-module@vger.kernel.org>; Thu, 28 May 2026 18:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780019551; x=1780624351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DBdvQt1aBRAc7GeMjYU8mb1pyck4wJw9l4x/B5fftoQ=;
        b=rfWm+hfDAFliuBx5j5P84o8gtZdJ7wh7KVClmsDELcbWbJDVHNnF8V6VXQN1XgtY+q
         24UUtmQG5MCX/6OVEUKZhjgz+CpjR/IsRhSOAHIbCYQmNy/kVqvcVvKLHutOZwLjOblL
         f9NP8TB6rbYa5FFOCudesox8AvVF8WIF0ZwbuvOVZQxAlBp1ROGwG+kbtdFLPUrSASPW
         dMoyPOXPOoPJoowSLJeenkAIH2ARLHaBJMZnDc5VfwMRZPdSg69IxT/SbYwcvyjsBx9G
         WMeCQcP1VFY1yxVT8R38+LUbT1Ujd0AxrkXXje2f776ovG8H3EFk0k0NX7I5MsjEP/Gh
         /gfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780019551; x=1780624351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DBdvQt1aBRAc7GeMjYU8mb1pyck4wJw9l4x/B5fftoQ=;
        b=YCnfqQ64ubRGjE4M/SOaTQM+kjlYtVi1WHF8VG2J3w/nhrYog4D/M2Oijo7PYnEX/M
         DRJgmhdwdiFM5zvUgfuRLThuuylenNFqVXeLjGDscNz3BAh/PfMgVfWMI4D3S7d0UKnL
         80nou+plKVqTw5NL4my4kERFJQluBmp8Jqndp9cr+dzWy0l2QWAGo9neCK0UQgSqhikH
         2P5eZjGPHjbisJMz24rB2OIXuEuA5XeGwho3Cni5CbiuIzv1FniUkRHDpzglLF3byrTm
         DT3hqfYRM+N6PzLZib+01fWznwefl20/xl461xbENO7G49Te2Rw+BGu7Igc008i8IpEc
         PXWQ==
X-Forwarded-Encrypted: i=1; AFNElJ+sgArhiZeeIvMPw/ufySyFUpEcjlYNiGcoqo1y7ZjH1XQypUZ2rHpHw452ZD9y8LRV5hWff1chLTBKpNT35RWlQ3FVu/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQOqUmGYkjWSRDz4H5qvclRyUmQ0U1WoGAPlbIVHqegRHHMMDK
	JaHbvgPaOU/USyH9eoMUcY2d3N7Yc1JovFvxulG4jOQ85JM0KSfAJ5jE
X-Gm-Gg: Acq92OH4m9EAGCDCk87pxrWOmzwMCDZr9sTsz1jFBKw6tI6b8E6xewQMPAxe5GyKaZ6
	vSOcmHbOFVG3NLbOijhi7bd9uCleGmDGzvC+HyJOACXCUuQgxA4xSxrTXjTRMWzUx9w3uswuac7
	QPqk62uD1bWy9WbwhwwL+ZjSKKkIY+7F8WnazbSmMoaanFqkMbniVBP75KopokTPXMUAYGXjCqD
	DVugZglw3LQYb1swZh2tw3nSB0LOvHX7syTuxt9IrBBecPq4ZnxyUwL37sqhHV0DRcXOGUA+HKg
	xeYi44otWNKiMWdQvy9ht9UB+d6WE7ErUg6Ol/73kqC1c5KPZmNRgQDb8WAXBys58TfNIsE/95y
	/XuNmMOQbmvDVTzZropAr+WL+Qb1EsstBKOfgU01jMMDhwyGlmgNqk+nI13/L3MBgyir/3BGiWH
	/UryE/vqPf1ziDlJ/77RlQZ8gMGkyLo9SoMQg9/Ue7+VObMSRSY6ftAHpf/hrB0hSOKa25XurdC
	6NzQvx/80Q=
X-Received: by 2002:a05:690c:4803:b0:7bd:577f:56bf with SMTP id 00721157ae682-7de489ca65emr6913457b3.33.1780019550714;
        Thu, 28 May 2026 18:52:30 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:7a41:d368:8442:1cb2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7de6d1f3943sm1284717b3.26.2026.05.28.18.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 18:52:30 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: gnoack3000@gmail.com,
	mic@digikod.net
Cc: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH v8 04/10] landlock: Add LANDLOCK_ADD_RULE_NO_INHERIT user API
Date: Thu, 28 May 2026 21:52:03 -0400
Message-ID: <20260529015210.500291-5-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529015210.500291-1-utilityemal77@gmail.com>
References: <20260529015210.500291-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Wire up the new LANDLOCK_ADD_RULE_NO_INHERIT flag for
sys_landlock_add_rule().  Define the constant in the UAPI header with
its documentation, accept it from user space for
%LANDLOCK_RULE_PATH_BENEATH only, and update the path-beneath useless-
rule check so that an empty allowed_access is still accepted when a
flag (quiet or no-inherit) is present.

The flag has no enforcement effect yet; that is added in a subsequent
patch.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---

Notes:
    v7..v8 changes:
    
      * Renamed patch from "Implement LANDLOCK_ADD_RULE_NO_INHERIT
        userspace api" to "Add LANDLOCK_ADD_RULE_NO_INHERIT user API".
      * Reworded the UAPI documentation for LANDLOCK_ADD_RULE_NO_INHERIT
        in include/uapi/linux/landlock.h for clarity.
      * Centralized flag validation in sys_landlock_add_rule(): rejects
        unknown flags with a single ~(QUIET | NO_INHERIT) mask, and
        rejects NO_INHERIT on non-path-beneath rule types from the
        syscall entry point.
      * Removed the now-redundant LANDLOCK_ADD_RULE_NO_INHERIT check in
        add_rule_net_port().
      * Documented the new EINVAL case for NO_INHERIT on unsupported rule
        types in the syscall kernel-doc.

 include/uapi/linux/landlock.h | 24 ++++++++++++++++++++++++
 security/landlock/syscalls.c  | 14 +++++++++++---
 2 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 90a0752b61bf..d6de209ab961 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -124,10 +124,34 @@ struct landlock_ruleset_attr {
  *     allowed_access in the passed in rule_attr.  When this flag is
  *     present, the caller is also allowed to pass in an empty
  *     allowed_access.
+ * %LANDLOCK_ADD_RULE_NO_INHERIT
+ *     Disable the inheritance of access rights and flags from parent objects
+ *     for the rule's object and its descendants.
+ *
+ *     This flag currently applies only to filesystem rules.  Passing it with
+ *     any other rule type returns ``-EINVAL``.
+ *
+ *     By default, Landlock filesystem rules inherit allowed accesses from
+ *     ancestor directories: rights granted on a parent directory also apply
+ *     to its children.  A rule marked with %LANDLOCK_ADD_RULE_NO_INHERIT
+ *     stops this propagation at its object; only the accesses explicitly
+ *     allowed by the rule apply.  Descendants of that object continue to
+ *     inherit from it normally, unless they too carry this flag.
+ *
+ *     This flag also enforces parent-directory restrictions: rename, rmdir,
+ *     link, and other operations that would change the immediate parent of
+ *     the rule's object or any of its ancestors are denied up to the VFS
+ *     root.  This prevents sandboxed processes from manipulating the
+ *     filesystem hierarchy to evade restrictions (e.g. via sandbox-restart
+ *     attacks).
+ *
+ *     Inheritance of rule flags (such as %LANDLOCK_ADD_RULE_QUIET) from
+ *     ancestor directories is also blocked at the rule's object.
  */
 
 /* clang-format off */
 #define LANDLOCK_ADD_RULE_QUIET			(1U << 0)
+#define LANDLOCK_ADD_RULE_NO_INHERIT		(1U << 1)
 /* clang-format on */
 
 /**
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 08b6045d6926..04dacfdfc9f3 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -361,7 +361,7 @@ static int add_rule_path_beneath(struct landlock_ruleset *const ruleset,
 	/*
 	 * Informs about useless rule: empty allowed_access (i.e. deny rules)
 	 * are ignored in path walks.  However, the rule is not useless if it
-	 * is there to hold a quiet flag.
+	 * carries a flag (quiet or no-inherit).
 	 */
 	if (!flags && !path_beneath_attr.allowed_access)
 		return -ENOMSG;
@@ -433,7 +433,7 @@ static int add_rule_net_port(struct landlock_ruleset *ruleset,
  * @rule_type: Identify the structure type pointed to by @rule_attr:
  *             %LANDLOCK_RULE_PATH_BENEATH or %LANDLOCK_RULE_NET_PORT.
  * @rule_attr: Pointer to a rule (matching the @rule_type).
- * @flags: Must be 0 or %LANDLOCK_ADD_RULE_QUIET.
+ * @flags: Bitmask of %LANDLOCK_ADD_RULE_* flags.
  *
  * This system call enables to define a new rule and add it to an existing
  * ruleset.
@@ -451,6 +451,8 @@ static int add_rule_net_port(struct landlock_ruleset *ruleset,
  * - %EINVAL: &landlock_net_port_attr.port is greater than 65535;
  * - %EINVAL: LANDLOCK_ADD_RULE_QUIET is passed but the ruleset has no
  *   quiet access bits set for the corresponding rule type.
+ * - %EINVAL: LANDLOCK_ADD_RULE_NO_INHERIT is passed for a rule type
+ *   that does not support it (e.g. %LANDLOCK_RULE_NET_PORT).
  * - %ENOMSG: Empty accesses (e.g. &landlock_path_beneath_attr.allowed_access is
  *   0) and no flags;
  * - %EBADF: @ruleset_fd is not a file descriptor for the current thread, or a
@@ -472,7 +474,13 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
 	if (!is_initialized())
 		return -EOPNOTSUPP;
 
-	if (flags && flags != LANDLOCK_ADD_RULE_QUIET)
+	/* Rejects unknown flags. */
+	if (flags & ~(LANDLOCK_ADD_RULE_QUIET | LANDLOCK_ADD_RULE_NO_INHERIT))
+		return -EINVAL;
+
+	/* LANDLOCK_ADD_RULE_NO_INHERIT only applies to path-beneath rules. */
+	if ((flags & LANDLOCK_ADD_RULE_NO_INHERIT) &&
+	    rule_type != LANDLOCK_RULE_PATH_BENEATH)
 		return -EINVAL;
 
 	/* Gets and checks the ruleset. */
-- 
2.53.0

