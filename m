Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A7F155326
	for <linux-security-module@vger.kernel.org>; Wed, 26 Nov 2025 12:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764159667; cv=none; b=B4kwRzFUKj3rjCQrxD0v6VA0XiN2VagXuD1tfWJgbIiEARmx5MBFl/pThL1xbXi0RRMNMAU6+UCER/+JKzNMxPPq8WuNCB/4lZPSG7hyKGezQpAzUo01fyB7N3sHMqm3IltB4t8nOQWVA4XP6yvG6C3reokrn9embK0Qh3fFGxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764159667; c=relaxed/simple;
	bh=m4Z9VgrwtoK6kAPKO68+Gkn/7vLXlWtribVKd1/JHLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Km48ut2xj26Uu16IQ5HdS49oT8I23wiBR+tzeQkbMJG/aictRoAanhMsYskq4RmGr9o7+8zB4MpE1JPGkaxkm/NsSRlVN25SRmBL9LLIJwLOcrBqETwiGncenyHFgteJf8XZKyltPRdqOVOsfiO5IAaUjRlxnopS51viatlqY4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkpymL0v; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkpymL0v"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-640c857ce02so6138406d50.0
        for <linux-security-module@vger.kernel.org>; Wed, 26 Nov 2025 04:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764159664; x=1764764464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KpmT0wpyK8nkeSvUxcDsWAgS4FZrQuPuFZEMzZtJx4c=;
        b=dkpymL0vUjOIptuI78XVdZdyfZYQCJnl/L+WOIH6a8/bpDQXWE4CNSL4bF/Up80B4i
         uQv80yciwe4KjxHnN5WbWVkiPDMkFqP3PDDx3qocDO8iSJvxT7ipo4aaZtWThRubd8a3
         QsPdgwzCqYfBdR+jSOwelsCW+vOOnnt3wJenp2nGJhWb3HLJb2ltnYzfDDDdvW14jFip
         kvmspzsNl8N9IySpkpRdg+UlJNVDKitbSkEcif+up/QPS8UJI8gN/lSZJk6tWSW/HDYx
         KXm0lrA1iGnBcEFdy3epotUT3jUH1uTAcZwx1+8qHnm89wHKz7x1HZj6Sa+djKbceey9
         eIKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764159664; x=1764764464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KpmT0wpyK8nkeSvUxcDsWAgS4FZrQuPuFZEMzZtJx4c=;
        b=KyBkewojckA1JxfdJGkFiU0EXq/KaaO8Ow3ltqmBZApCiiCuOentgs1QawGEURPNxl
         8eWug1OGN4MRLuMgQM6J99DJomkez9X+/ceJRm0gHC3KGcqszjE4LpiybIyFPEYpVRT/
         XtDpTKrrC1Hy4ZPSPWJtR0Utpt8WECflSRqld+DIHed9jtCoHQPPw5kZb10CtrWiK767
         L8yAehyf762fDw1Wh/4VzB2hDegbtT973j4j0Tzonbq8Mekmdpw89pCmAMM8IVGXYNcN
         1x24qTDQ/csxz6EOJVme+kwJhD+edawxlvLI639lHn720YXrRN0ifvnz+tMm3gsDvWOi
         pRSA==
X-Gm-Message-State: AOJu0Ywg4G8mCwOOQJvgbK1HNrZtrEXKZtrXf1EGRaCTeosFyxO+DAA9
	9b/gvnwacxCHmyMARYRrgkzI0/C0MwQeKeD0LVBsEenTsEASGO5RrqkwreULc5ev
X-Gm-Gg: ASbGncvR3GHWWqB2/VKANQQcRVgMitOhlFUimdJ4PG65iBYdkOKMtRulWoa9vFjHChH
	wd5VHysTH/hkvDXn+DrzYItBsAm0ZruPscp1vLYdxADE2tXuRBxC5Qd9XwS5196gefFNEjzC0C7
	IYvkd8gIxEiH8D3K+Y1Zl+EM+aIlur1dMdXFyJn23I+1b0lLlVr6n+5JRUNy/f1E6ma9VQaZYK/
	07QQw3//mJClEzolxpAnnbJ5leHQ6mJ9lI266yV5AwEOo60SySTBbWQfqVwUWNAL9k39E2JgEBA
	VFGnQAuns4let3AtpnDAXZJJlUiWttYc7Zc4fyNSoAIpwdVS87OixvaDHerncpMVITOqeUb8mJd
	t6fx5tEm46eBxTC2VHXU0Fea6C6aHWQH8i3nldg3XzYfJLAGBMC9nRDFWchB8ZugWkQL5X6XstB
	quPYrSdGOQIIDTLQX3ixZ8JhNKuybMrPB9luez+uzh3g17MoHb2n4Hjl1gX7QwK1fIaq2yfKA=
X-Google-Smtp-Source: AGHT+IEsT/MQJ/l1xJ/aGIeNqhOlhkuX0YY8og/ks0y0eggfXexNIS3lhwmQciguqdGWlzMdEWXZag==
X-Received: by 2002:a05:690e:2513:20b0:63f:b9d1:b153 with SMTP id 956f58d0204a3-64302af0a7cmr10997356d50.40.1764159663638;
        Wed, 26 Nov 2025 04:21:03 -0800 (PST)
Received: from zenbox (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a7992799dsm66318057b3.33.2025.11.26.04.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 04:21:03 -0800 (PST)
From: Justin Suess <utilityemal77@gmail.com>
To: linux-security-module@vger.kernel.org
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH v3 3/5] samples/landlock: Add LANDLOCK_ADD_RULE_NO_INHERIT to landlock-sandboxer
Date: Wed, 26 Nov 2025 07:20:36 -0500
Message-ID: <20251126122039.3832162-4-utilityemal77@gmail.com>
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

Adds support to landlock-sandboxer with environment variables LL_FS_RO_NO_INHERIT
and LL_FS_RW_NO_INHERIT. These create the same rulesets as their non-no inherit variants,
plus the LANDLOCK_ADD_RULE_NO_INHERIT flag.

v2..v3 changes:

  * Minor formatting fixes

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 samples/landlock/sandboxer.c | 37 +++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index 2d8e3e94b77b..6f6bfc4e5110 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -58,6 +58,8 @@ static inline int landlock_restrict_self(const int ruleset_fd,
 
 #define ENV_FS_RO_NAME "LL_FS_RO"
 #define ENV_FS_RW_NAME "LL_FS_RW"
+#define ENV_FS_RO_NO_INHERIT_NAME "LL_FS_RO_NO_INHERIT"
+#define ENV_FS_RW_NO_INHERIT_NAME "LL_FS_RW_NO_INHERIT"
 #define ENV_FS_QUIET_NAME "LL_FS_QUIET"
 #define ENV_FS_QUIET_ACCESS_NAME "LL_FS_QUIET_ACCESS"
 #define ENV_TCP_BIND_NAME "LL_TCP_BIND"
@@ -121,7 +123,8 @@ static int parse_path(char *env_path, const char ***const path_list)
 /* clang-format on */
 
 static int populate_ruleset_fs(const char *const env_var, const int ruleset_fd,
-			       const __u64 allowed_access, bool quiet)
+		       const __u64 allowed_access,
+		       __u32 add_rule_flags, bool mandatory)
 {
 	int num_paths, i, ret = 1;
 	char *env_path_name;
@@ -132,9 +135,13 @@ static int populate_ruleset_fs(const char *const env_var, const int ruleset_fd,
 
 	env_path_name = getenv(env_var);
 	if (!env_path_name) {
-		/* Prevents users to forget a setting. */
-		fprintf(stderr, "Missing environment variable %s\n", env_var);
-		return 1;
+		if (mandatory) {
+			/* Prevents from forgetting to set necessary env vars. */
+			fprintf(stderr, "Missing environment variable %s\n",
+				env_var);
+			return 1;
+		}
+		return 0;
 	}
 	env_path_name = strdup(env_path_name);
 	unsetenv(env_var);
@@ -171,8 +178,7 @@ static int populate_ruleset_fs(const char *const env_var, const int ruleset_fd,
 		if (!S_ISDIR(statbuf.st_mode))
 			path_beneath.allowed_access &= ACCESS_FILE;
 		if (landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
-				      &path_beneath,
-				      quiet ? LANDLOCK_ADD_RULE_QUIET : 0)) {
+			      &path_beneath, add_rule_flags)) {
 			fprintf(stderr,
 				"Failed to update the ruleset with \"%s\": %s\n",
 				path_list[i], strerror(errno));
@@ -375,6 +381,8 @@ static const char help[] =
 	"Optional settings (when not set, their associated access check "
 	"is always allowed, which is different from an empty string which "
 	"means an empty list):\n"
+	"* " ENV_FS_RO_NO_INHERIT_NAME ": read-only paths without rule inheritance\n"
+	"* " ENV_FS_RW_NO_INHERIT_NAME ": read-write paths without rule inheritance\n"
 	"* " ENV_TCP_BIND_NAME ": ports allowed to bind (server)\n"
 	"* " ENV_TCP_CONNECT_NAME ": ports allowed to connect (client)\n"
 	"* " ENV_SCOPED_NAME ": actions denied on the outside of the landlock domain\n"
@@ -596,17 +604,28 @@ int main(const int argc, char *const argv[], char *const *const envp)
 	}
 
 	if (populate_ruleset_fs(ENV_FS_RO_NAME, ruleset_fd, access_fs_ro,
-				false)) {
+			0, true)) {
 		goto err_close_ruleset;
 	}
 	if (populate_ruleset_fs(ENV_FS_RW_NAME, ruleset_fd, access_fs_rw,
+			0, true)) {
+		goto err_close_ruleset;
+	}
+	/* Optional no-inherit rules mirror the regular read-only/read-write sets. */
+	if (populate_ruleset_fs(ENV_FS_RO_NO_INHERIT_NAME, ruleset_fd,
+				access_fs_ro, LANDLOCK_ADD_RULE_NO_INHERIT,
+				false)) {
+		goto err_close_ruleset;
+	}
+	if (populate_ruleset_fs(ENV_FS_RW_NO_INHERIT_NAME, ruleset_fd,
+				access_fs_rw, LANDLOCK_ADD_RULE_NO_INHERIT,
 				false)) {
 		goto err_close_ruleset;
 	}
 	/* Don't require this env to be present. */
-	if (quiet_supported && getenv(ENV_FS_QUIET_NAME)) {
+	if (quiet_supported) {
 		if (populate_ruleset_fs(ENV_FS_QUIET_NAME, ruleset_fd, 0,
-					true)) {
+				LANDLOCK_ADD_RULE_QUIET, false)) {
 			goto err_close_ruleset;
 		}
 	}
-- 
2.51.0

