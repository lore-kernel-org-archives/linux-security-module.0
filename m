Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61A6346FB3
	for <linux-security-module@vger.kernel.org>; Sun, 12 Apr 2026 19:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776022355; cv=none; b=QJsxo8mngJNvRTRSWiRFlPEEND8uNmfAZGjwvsGLrQAG+wHbQLo82GQeJ88j1/TaeoRtoGsbcWzEedfTQaHi7OVkKZX8yEx1QQ5/hZjEYSg+ZnOYjdCwRY6ElyZvnTrjFb/035YD7iqUO5tjsK4/SX8WWSIlVq6m/LovQ07EWdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776022355; c=relaxed/simple;
	bh=HzgjBGJL8mlZipuxZKPuRGs7hgiEKjce8SeJqtWeXF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S9q7RCb7Rs2sP2X+o4kGgEWvK9B2L2qG0V2oNim4tIAx9DMR8clk0ymB5Wq82eex6t3qMqNFxzUz/4Hsg9/BISrz7LMsZHYm+R3G9EaWQSMdmqo42E+rFgxwDgER3mjsAKlnfME/X11SK0MVfxFDAtaeogiSpp99BTYydLJs7J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mVL3Hh2a; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVL3Hh2a"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-797ab169454so42383667b3.3
        for <linux-security-module@vger.kernel.org>; Sun, 12 Apr 2026 12:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776022353; x=1776627153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HEyMqYSg8snFq9sPZuhnT2t5BnIqsZznW6Z++dJScqI=;
        b=mVL3Hh2a4HQ0amCD15G/z+XRXGgFuxN9jtQzQN/5RxjkzKzhRhpSnUdR4kGfuau/1t
         G6gpyMYFxlNzkhtaL6nTyj2cfuuyXLPM5NeqAMIC9jlCVU8eJPzW4ZDOPtF3oInGJKNo
         fuKVPzAM5HBkwnIaM0OQ85dzySJXz1oY8G1YYwOB0rxkGauKUPJDv1LegX8/u3XiLuoe
         s+mrwa77UA5dJGKNGT6cG9FQXt4noZIE2Mw1XEqEkKz6NvsmzvvBXJtTo0X3iGy7gnkl
         yJwAoE2QGh1/2BP4j/F2jOzHtbJ6y5NDgEYsxAixpkJ9vCf2VmOXn5cs/t3HR1eJmPce
         cfuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776022353; x=1776627153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HEyMqYSg8snFq9sPZuhnT2t5BnIqsZznW6Z++dJScqI=;
        b=PQ5K9C82jDXjDKkGjSGo8bLGNShfEz0zBQavt2PKvRfArLDq49Zwqq/plNaGugQVEV
         i+d2EUSx6H0jwpToNzYHJN7mgz4mE5c9a7eXR6LH4Nn7DGY5gKJW05Fu2L/X4J8aCDuY
         4hOus+Am1tTwKWlBAx2TWrzRi3oDeTPEg0RkGdOMll+DUNDgkX3QjdGlxnEQh/wlG5VC
         cSVqs8JrIKhnSxTVMaskXPhNxqgnBVDKVnkfirMu77t5vbsJdffsKgHQzU8jfzws1lJp
         Zoyhz0HRMzvdvIqF/gZ8SZRU0TOWbVdANpNNGwOkYahR0HMeHNQk5RLLnA2oMSYzpryZ
         yHMw==
X-Forwarded-Encrypted: i=1; AFNElJ+K97tkiqWmP3V3cZzd9Pi3tzXhQUM5N0i8xy+JzkUQNfuupuEcs0m7pjJno5+evm/c3b66jkaGd9SNAItyb/GOWx0i7W4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcTBxpNPIEVdoQN6VfHnyngbgrGqyfZrGwIC4h2xohbA2Aj7Th
	54Bqy8Xirz0P9m6S6HpTfGR5OOS7IqwbX/8DLFrUr0EqJN+tiqeZHNdW
X-Gm-Gg: AeBDiesryISNKIXKIAQEc0KquCRV+UoaOR4lxoDKKayxrzUPSZxgJkb1yjJ+NOLdDGb
	44SsTBnbEAWjEi1QjytyLBdUAN6prTMxh5Sw2dGSzdl+0/kgz4mlvKUU+sTZ6wiPiumgj7mYkan
	DZPd4oEd1FJsWQvsvMjpuO4CCSLt/XYNy+KyWWn07uQm///dYV5hks0UoMYuW5HhDquBCKdQdtv
	IAGLDYjm4p5MPpF+Zza+wNMY0H/9aNRV8VEv5AWT6iMISDsGufPdjeMsRl1n2KONolwMmsDYhSQ
	IfH3DNzK6i912Dt5QIb8nTFAaYAMCO8tkpDXTriwpv+/iODUwBzbKG8BN0EwdzX+CfjNGaMXf72
	Um2jmXR15INj3jcuVfsWwvGtLL/vSkwxYVyNO1vXSMYGlbWby63+kU7MexXY5oPINmVH8XHb2OF
	Vzf5df7O4RMXsZZUYgW/qOLXm3BtKk/1RiKvsl8TlqNTm60jemL4sksnZHe5qih2H+9C3JAyG7
X-Received: by 2002:a05:690c:81:b0:79b:73dc:d30d with SMTP id 00721157ae682-7af6f228687mr124644107b3.3.1776022352633;
        Sun, 12 Apr 2026 12:32:32 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:1192:20dc:2cb3:dcdc])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7af3c8decbfsm42395807b3.8.2026.04.12.12.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 12:32:32 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v7 04/10] landlock: Implement LANDLOCK_ADD_RULE_NO_INHERIT userspace api
Date: Sun, 12 Apr 2026 15:31:55 -0400
Message-ID: <20260412193214.87072-5-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260412193214.87072-1-utilityemal77@gmail.com>
References: <20260412193214.87072-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implements the syscall side flag handling and kernel api headers for the
LANDLOCK_ADD_RULE_NO_INHERIT flag.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---

Notes:
    v6..v7 changes:
    
      * None
    
    v5..v6 changes:
    
      * None
    
    v4..v5 changes:
    
      * Moved syscall handling to this patch and moved out flag definition
        to allow independent build.
    
    v3..v4 changes:
    
      * Changed documentation to reflect protections now apply to VFS root
        instead of the mountpoint.
    
    v2..v3 changes:
    
      * Extended documentation for flag inheritance suppression on
        LANDLOCK_ADD_RULE_NO_INHERIT.
      * Extended the flag validation rules in the syscall.
      * Added mention of no inherit in empty rules in add_rule_path_beneath
        as per Tingmao Wang's suggestion.
      * Added check for useless no-inherit flag in networking rules.

 include/uapi/linux/landlock.h | 29 ++++++++++++++++++++++++++++-
 security/landlock/syscalls.c  | 15 +++++++++++----
 2 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 9a41c65623a1..290f76774e3f 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -127,10 +127,37 @@ struct landlock_ruleset_attr {
  *     allowed_access in the passed in rule_attr.  When this flag is
  *     present, the caller is also allowed to pass in an empty
  *     allowed_access.
+ * %LANDLOCK_ADD_RULE_NO_INHERIT
+ *     When set on a rule being added to a ruleset, this flag disables the
+ *     inheritance of access rights and flags from parent objects.
+ *
+ *     This flag currently applies only to filesystem rules.  Adding it to
+ *     non-filesystem rules will return -EINVAL, unless future extensions
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
+ *     parent subtree are denied up to the VFS root.  This prevents
+ *     sandboxed processes from manipulating the filesystem hierarchy to evade
+ *     restrictions (e.g., via sandbox-restart attacks).
+ *
+ *     In addition, this flag blocks the inheritance of rule flags from parent
+ *     directories to the object covered by this rule.
  */
-
 /* clang-format off */
 #define LANDLOCK_ADD_RULE_QUIET			(1U << 0)
+#define LANDLOCK_ADD_RULE_NO_INHERIT		(1U << 1)
 /* clang-format on */
 
 /**
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index a71068c41f76..fbab6573df70 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -360,7 +360,7 @@ static int add_rule_path_beneath(struct landlock_ruleset *const ruleset,
 	/*
 	 * Informs about useless rule: empty allowed_access (i.e. deny rules)
 	 * are ignored in path walks.  However, the rule is not useless if it
-	 * is there to hold a quiet flag
+	 * is there to hold a quiet or no inherit flag
 	 */
 	if (!flags && !path_beneath_attr.allowed_access)
 		return -ENOMSG;
@@ -414,6 +414,9 @@ static int add_rule_net_port(struct landlock_ruleset *ruleset,
 	/* Check for useless quiet flag. */
 	if (flags & LANDLOCK_ADD_RULE_QUIET && !ruleset->quiet_masks.net)
 		return -EINVAL;
+	/* No inherit is always useless for this scope */
+	if (flags & LANDLOCK_ADD_RULE_NO_INHERIT)
+		return -EINVAL;
 
 	/* Denies inserting a rule with port greater than 65535. */
 	if (net_port_attr.port > U16_MAX)
@@ -432,7 +435,7 @@ static int add_rule_net_port(struct landlock_ruleset *ruleset,
  * @rule_type: Identify the structure type pointed to by @rule_attr:
  *             %LANDLOCK_RULE_PATH_BENEATH or %LANDLOCK_RULE_NET_PORT.
  * @rule_attr: Pointer to a rule (matching the @rule_type).
- * @flags: Must be 0 or %LANDLOCK_ADD_RULE_QUIET.
+ * @flags: Must be 0 or %LANDLOCK_ADD_RULE_QUIET or %LANDLOCK_ADD_RULE_NO_INHERIT.
  *
  * This system call enables to define a new rule and add it to an existing
  * ruleset.
@@ -470,8 +473,12 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
 
 	if (!is_initialized())
 		return -EOPNOTSUPP;
-
-	if (flags && flags != LANDLOCK_ADD_RULE_QUIET)
+	/* Checks flag existence */
+	if (flags & ~(LANDLOCK_ADD_RULE_NO_INHERIT | LANDLOCK_ADD_RULE_QUIET))
+		return -EINVAL;
+	/* No inherit may only apply on path_beneath rules. */
+	if ((flags & LANDLOCK_ADD_RULE_NO_INHERIT) &&
+	    rule_type != LANDLOCK_RULE_PATH_BENEATH)
 		return -EINVAL;
 
 	/* Gets and checks the ruleset. */
-- 
2.53.0

