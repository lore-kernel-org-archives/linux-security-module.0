Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42291307AC7
	for <linux-security-module@vger.kernel.org>; Sun, 21 Dec 2025 19:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766346196; cv=none; b=hwMhXmKu8s92y6A+6uPuz71XJWhUB0V0hoVczgAXqGWNmyMiWKgDTf0vtfJ37TdUSyVkgz07c9+7HZNu/Z6ZKuLM2SQgQYCJddpnIU7bTfP3LCh+kIu/SRDs1BWtosWCPLvcQgz4153BBDVRwKKMNDmQIqJDSNFGlSt/foJMsaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766346196; c=relaxed/simple;
	bh=6q+LKG5oOy1SK0jEdqVpfEMkxvqYDUGxCLvKBCsw874=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IsII0N/4CKksiaZc5+KJrfXMjIdjjggIG6dWbFjow4Mk4JWpnjiU4uZe8kTI08C15nwhrrnce8yQ9jcBjIhR9WB7h9Ara+F0mW44yuC9EoeOe6SFnr8xa9W5M9rELPbztsyoe1/0IIBoWh8NIe0MRfu/aIQquYFcGFdqGJP+a9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ldLFY2sj; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldLFY2sj"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-78ab039ddb4so31161867b3.3
        for <linux-security-module@vger.kernel.org>; Sun, 21 Dec 2025 11:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766346192; x=1766950992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NC9cxKmTDVSVePeXSiYmyobvgQg6Hz9iV2A9ZstjhJY=;
        b=ldLFY2sjvM/FHzdGbdYuFMoXrKP2riprOemyjOUC347QsL1vM5PYjamRfH+Cw/MTDo
         jCBmB4nJNuVEEGpyFYjawdjSgSDxIw/ANbwdGWs5AUGH6tU5KanDohbSfK2H591vmVgY
         O/Zebd8FuZeQ2KdFtprVFK5sJRwkWgNXazzq/tGRCpyT+G5PtistLjYzskXF3CfMCkMw
         c6uLdfVpZVXITT1heuQp7DYzalNZn1jFLfx3TYm9BO3dtK1oeKIiA/V0usKUf9Pou+Fd
         8xvnVdLnW8O+TwQ/OGQhzUkJr0VoqXKLZv4VD0ujg1yRLF8J6vyfheWTYq6CMLb1lKBe
         5HbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766346192; x=1766950992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NC9cxKmTDVSVePeXSiYmyobvgQg6Hz9iV2A9ZstjhJY=;
        b=Rs3M350vd5aWSNBHLPrEQyJm4MEBioI2/Uk7OBXyTpYYv2T8hSEzecDoHj8iYbSmgb
         t/KyO0DESqFuw0tRIwafuoV+dsFLwCnZXzppIhWwlPS0aYk7wiJ7C35saP1/AkGMXhR+
         N93LpBW1XaG1Vhq1jofyy7cMGq+7RYLmMFyN9N7tqeU6zFZtw6YAuQeO4zgedf5wzOur
         r2/nC1x5I5bgULGwqeZ0Rm3kbhEkybrdxHLnfGlmFWcktVK7oTB0nHANBHVpByPzdX4p
         dBXORUN5Bp0Om2hhNx+I69dnDBGI6RNbapDvza2M6RLMukg/2NgdGeO6ZejRT1qYvivm
         0OqA==
X-Forwarded-Encrypted: i=1; AJvYcCUJlrPw5iOmK2Y5IjvSqSAVKc7DSLIa3ettmVNrjlhW+c7w8UYIAFFEFawLSxwtMu4LnuvSk+kF7Et/jc5K7cbqp+PfI4U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2GpKgXk0692w6Q3v9GQiLSbS3klA9yvwByqoptCknPpuL9yy4
	+ytfMidZivwWU9Zfm57R++g1cy2vtA/ooTIT8s4DUSGzD8/efiYUUSUM
X-Gm-Gg: AY/fxX5KXz7JiXPctrKwPIYKz27oe+l1rdk4IXGovapOSf6dlEEDPwSi2AL32mKNd2a
	ByODREQzPFTKBH7EPDmUnGzxaZQgeJZLJHh9YTmRe1dOib9pObz+QJi7gJ1+3nXhgOudeLxyztR
	W86sK/7AtSExtSGfTSNftKlmWNgKmbqOQ1mhP8Sx6Anah0sh4bXqh3/EitSXdQlI6LsmRXbkq/G
	pu9RY5APdEb0/0unhfGT9Rd8aOdDyfr24yvj6pdse+euEqdPefFrx6WMurfqJnCtO5QYAUUBJsF
	tBcH/DAiCJtxfjouT8CoRVoVpjeNcsO4UXUg6qnLiCnj9U/u8IZ5HiQ5bZFaMte2HaFdpHFP6Cr
	lrwMDirc94Qas36Snfhe6pYMBB9YlGvD7okvWTpw6JQuYLAbbe7amPRThwXwsf9b+1pShsV+uL2
	M3wOKSWDs3amMkYxQCjDlPs9APrfDpdBAT33+up2mokeUrL/qiM5YjSj96TnywY5LIxGFTE6U=
X-Google-Smtp-Source: AGHT+IEpkpWJnIvrI6Ac1GXSAKNKgsYFLQNCR7o3DU0xr+z8WkXrL0UbPfiV9FCKaWRH3jxXf9XZjw==
X-Received: by 2002:a05:690c:4881:b0:78f:aeee:85de with SMTP id 00721157ae682-78fb400e7fbmr82509377b3.32.1766346191975;
        Sun, 21 Dec 2025 11:43:11 -0800 (PST)
Received: from zenbox (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb43701c7sm35628707b3.8.2025.12.21.11.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 11:43:11 -0800 (PST)
From: Justin Suess <utilityemal77@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v6 2/6] landlock: Implement LANDLOCK_ADD_RULE_NO_INHERIT userspace api
Date: Sun, 21 Dec 2025 14:42:57 -0500
Message-ID: <20251221194301.247484-3-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251221194301.247484-1-utilityemal77@gmail.com>
References: <20251221194301.247484-1-utilityemal77@gmail.com>
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

 security/landlock/ruleset.c  | 19 ++++++++++++++++++-
 security/landlock/syscalls.c | 16 ++++++++++++----
 2 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index a58af26db201..adc965de8e4e 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -254,8 +254,13 @@ static int insert_rule(struct landlock_ruleset *const ruleset,
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
 
@@ -314,7 +319,10 @@ int landlock_insert_rule(struct landlock_ruleset *const ruleset,
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
@@ -661,9 +669,18 @@ bool landlock_unmask_layers(const struct landlock_rule *const rule,
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

