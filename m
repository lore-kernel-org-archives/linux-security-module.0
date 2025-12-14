Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E3B24113D
	for <linux-security-module@vger.kernel.org>; Sun, 14 Dec 2025 17:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765731958; cv=none; b=OTpGR0289aqME8+L0R3GrGi/wfht3wM/f2n02zwmT9Q2o3RFUnyIqmxu8XgKm6zt3WVtSFJTJWuICpOj9idwCLRnVb2mTjAnulNFl5aUpybQ2vGUsGSn6sJSVDxa9V2jD/gADLg7cE+8ryXo9gZVE9uWDmvmOSIJQO5yoPWBpcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765731958; c=relaxed/simple;
	bh=aFqFR4VSIMAYCRMlSfyU8svydH1fFkSlTOGOzqGLP7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V6VGu0NCvXdYBMxHBeWoyaI0DAXNX+NSKJQMjx9+dapK8KYj0Wkh/5JUDelovtnzDtm3Ry2m89tSHwBrBxR+IHqshCPAX1WFJ0vXytnpUsbbTNgW+PLejDhm0vCXLVflP/W/y3oTjUzGamtK8+ekzVV0NQ+fKxJwezBD3YYDvhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6118LY4; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6118LY4"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6420c08f886so2937724d50.3
        for <linux-security-module@vger.kernel.org>; Sun, 14 Dec 2025 09:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765731956; x=1766336756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFgc5/YXPLEMZo8qo1VW/NGAnEBquG/oP4O2q7YLWpg=;
        b=P6118LY4QMCZRppAyyVGo5vkMxOPSfXc/HYaUIHO82x1mkDt/HB6Tv79GexnJb5C2c
         j831VF1h8L0u9N56HMJAdSyLXwX0FAS3VyuT3bu2qzJrf/3jhUw40Z6XlcN2h03ltLkV
         5GQy2+8VXlpkfzW8KIoEPYJFCagSkk/nDAK8K/ZaVptnKcjMsGNNxpKOmclfVyvkums9
         OXto95zMdFM+36RVNAH1sLMpWFEosTq7hYarIkiguYYDAsGhzaHf1zaMqEUHy675tKFc
         +1R1V/aU7H+rAtzAYLVSkmlaw0a8eq4DxVhjgwzY0ZrfXzFiZap3TEL+185Fjwn1C+Yc
         cgsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765731956; x=1766336756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VFgc5/YXPLEMZo8qo1VW/NGAnEBquG/oP4O2q7YLWpg=;
        b=ryDJNTc+Wb/8xbSO8uXXlrFvexVwPlNxuGUS++Upt2BnF+cr1kcLeH0AgaBbJQMx3o
         BsgvRPGXkeFBxg7qukz2o55QzrTVlptpvbNFH9xkk8z4dOHkG0OqJAOIffxEGzXqct1k
         u8UBgMDf7yFi4NuZy6OgBQ11jv2rKUMne5elv4Mah1mMxf1Y2G2Y3kNomlADVyHA08NN
         2sJc/XGmZ7+I0Rtm3v1DTvEyLJcDwdwVRzKkW6eWbXuQCOcV0YQVvRqz8C170MdDwnD0
         DeGUOtkk2Y8Xb8RNcPoPk3aQ9YtJBRt31x5YRLNEopASQzvgcu7I1rrW8ObFJpN+PRAm
         cK2A==
X-Forwarded-Encrypted: i=1; AJvYcCWWn2NLPi+r0ceOVW9L1kZ4Z7mnAbckGGXqBo/r6doIB+6ej5BLzS/g6uW9ghyuh6g5bjD8BvWrx1uY99eH/idrqLXFBUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvDVjrCbG9lCKVnkkxBLanUJpvPVqjLyIn/hJuR9vAWiHN/gRy
	sFwjeM6c5PsRVT9aCVCI0uWVIbAHJgMcHbhOkNLp4xxlt5n8K6XSM3yo
X-Gm-Gg: AY/fxX44IZ0Y/0lMNTAr4s6V0P7gMtnmTLNOCzV9oxaG98FNZdASHCwc5Kzge4pRJZV
	+NOF+IJd7Uto9vJljN/rIBSC+S2QJdO77O5FtZ9PZAn6LjJEYJNU60yB83qpwnOQf/Oq1SIYGWF
	JJBY8JLMXh0ip7kLr8BAclreADV7KB4mTh+rmTPB+9iG4K/nogEJBG7pZ82yVjW6mSfX1lyn0R0
	JhGPFHKVcosDwuC+dNW+xLDEbzxCQVr6AOnIr7fzME0+o9LH/PZVfDK5lpiWhZ5FNIHgmQAmLXx
	PGnEIoOqfqcCqrgsG/wO7w6u1bR1VoKmFS16R960ntfEfbrhduma0NhMYaIU+5d+tjSqVf68mPY
	XrXWgdQPAmQ6CQP9X9Mz/dFlRUWR6wwbXkCzt5Rl1SoFFeXLh1S/A0lCiV0LbYtGvvya4nE4+3v
	zio00qTrg0MsOf3HLeNuPVpnb20PYgP2UmBT/YMQmjfuB15B1dVoP0CJLcqho2
X-Google-Smtp-Source: AGHT+IHcaV/xJuodgagobvtU6i0U8wI7Quh1AP5UNxR8U/pI5A52Grry7Hj83w+UAlFGmymkPm9oVA==
X-Received: by 2002:a05:690e:128c:b0:644:7822:95cb with SMTP id 956f58d0204a3-6455565138fmr6174372d50.60.1765731955859;
        Sun, 14 Dec 2025 09:05:55 -0800 (PST)
Received: from zenbox (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78e749e7683sm19401117b3.32.2025.12.14.09.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 09:05:55 -0800 (PST)
From: Justin Suess <utilityemal77@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v5 2/6] landlock: Implement LANDLOCK_ADD_RULE_NO_INHERIT userspace api
Date: Sun, 14 Dec 2025 12:05:42 -0500
Message-ID: <20251214170548.408142-3-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251214170548.408142-1-utilityemal77@gmail.com>
References: <20251214170548.408142-1-utilityemal77@gmail.com>
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

 security/landlock/ruleset.c  | 19 ++++++++++++++++++-
 security/landlock/syscalls.c | 16 ++++++++++++----
 2 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index 750a444e1983..9152a939d79a 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -255,8 +255,13 @@ static int insert_rule(struct landlock_ruleset *const ruleset,
 				return -EINVAL;
 			if (WARN_ON_ONCE(this->layers[0].level != 0))
 				return -EINVAL;
+			/* Merge the flags into the rules */
 			this->layers[0].access |= (*layers)[0].access;
 			this->layers[0].flags.quiet |= (*layers)[0].flags.quiet;
+			this->layers[0].flags.no_inherit |=
+				(*layers)[0].flags.no_inherit;
+			this->layers[0].flags.has_no_inherit_descendant |=
+				(*layers)[0].flags.has_no_inherit_descendant;
 			return 0;
 		}
 
@@ -315,7 +320,10 @@ int landlock_insert_rule(struct landlock_ruleset *const ruleset,
 		.level = 0,
 		.flags = {
 			.quiet = !!(flags & LANDLOCK_ADD_RULE_QUIET),
-		},
+			.no_inherit = !!(flags & LANDLOCK_ADD_RULE_NO_INHERIT),
+			.has_no_inherit_descendant =
+				!!(flags & LANDLOCK_ADD_RULE_NO_INHERIT),
+		}
 	} };
 
 	build_check_layer();
@@ -662,9 +670,18 @@ bool landlock_unmask_layers(const struct landlock_rule *const rule,
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
+		if (rule_flags && layer->flags.has_no_inherit_descendant)
+			rule_flags->no_inherit_desc_masks |= layer_bit;
 
 		/*
 		 * Records in @layer_masks which layer grants access to each requested
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 5cf1183bb596..cffe7d944ae5 100644
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
@@ -424,7 +428,7 @@ static int add_rule_net_port(struct landlock_ruleset *ruleset,
  * @rule_type: Identify the structure type pointed to by @rule_attr:
  *             %LANDLOCK_RULE_PATH_BENEATH or %LANDLOCK_RULE_NET_PORT.
  * @rule_attr: Pointer to a rule (matching the @rule_type).
- * @flags: Must be 0 or %LANDLOCK_ADD_RULE_QUIET.
+ * @flags: Must be 0 or %LANDLOCK_ADD_RULE_QUIET and/or %LANDLOCK_ADD_RULE_NO_INHERIT.
  *
  * This system call enables to define a new rule and add it to an existing
  * ruleset.
@@ -462,8 +466,12 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
 
 	if (!is_initialized())
 		return -EOPNOTSUPP;
-
-	if (flags && flags != LANDLOCK_ADD_RULE_QUIET)
+	/* Checks flag existence */
+	if (flags & ~(LANDLOCK_ADD_RULE_QUIET | LANDLOCK_ADD_RULE_NO_INHERIT))
+		return -EINVAL;
+	/* No inherit may only apply on path_beneath rules. */
+	if ((flags & LANDLOCK_ADD_RULE_NO_INHERIT) &&
+	    rule_type != LANDLOCK_RULE_PATH_BENEATH)
 		return -EINVAL;
 
 	/* Gets and checks the ruleset. */
-- 
2.51.0

