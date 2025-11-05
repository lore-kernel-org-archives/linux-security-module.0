Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BBD285060
	for <linux-security-module@vger.kernel.org>; Wed,  5 Nov 2025 18:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762365645; cv=none; b=aMRgajqaA2pSSK9yUJg308jBEZee6BRaybD64ETrRjmapIlnvNAEDH8MLgZ2vDjGYRlwsRTAKvDi9zaqlFDJ12cQF/TQdvnZn1vjwvykuFO7ZydF1XQdKa9Ot0tjTZWK7zG7ueIO4cSin7PldMI6obknpg+tauJozWLcvNX5jlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762365645; c=relaxed/simple;
	bh=EyRRL8HR158xRp+xVU4agbtjfw6REnyMeWJwxXKKLFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JBHa18WYPYr/z4aIQ7cgIS6UyS3Lu2+neoEzFiW4UBdfoGETAhl0oeQUCsRRYbPY7PRjroBGVCyx0Z4F/ziMDKHzd8ColNdawbN67Msam4nuRIm/So7ZEwXT3Zc8g3K6YY/eOu/doRL4i1wAWC1G8BDhsBBEhKiDTD/wqOFV42Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IchMEyMg; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IchMEyMg"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-71d71bcac45so713947b3.0
        for <linux-security-module@vger.kernel.org>; Wed, 05 Nov 2025 10:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762365642; x=1762970442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=seO13+9Vfbpc5naRs4awsmmR33X/mtP1C3v3Ga/E65M=;
        b=IchMEyMgXKUZNHhHzqJD2Sd7wwtBZUjUcqquJCscbc/X4bLYNYRO/8PqexRyjJz4n/
         G342PTMQ/QBygZ7JA52bhGpWBHykdKzQcbc2XLCzjuImWMXDj18QAqLFqgIgFELPeSXn
         WRRE6ByywtDY3N5tAbwN0ifW15FpLIjnvtFubQ6o9qE1/lyV4dbVGKrGs7L4LZYEypu6
         duSluczIwMCuQIuhiV1uveZqantt1S9ugc0jxPDL4nd9YU17Pa44H3SwbRHQhZHL4CpG
         vuEF8E54yp6cfqZIczqoPksyGjeR8qXr4fonBNucABEvsceGpNqZjquBwIsEv/jxoeqW
         yroA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762365642; x=1762970442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=seO13+9Vfbpc5naRs4awsmmR33X/mtP1C3v3Ga/E65M=;
        b=Ff/cj+80581hxRSAgWVyEcvK6jr7gINkJ3/hlGNpVi8GPHWePi9ZnS0S1WJ66fYuNK
         W7phFNXKGusqrFHUFxt4IgpiYNMURGhurf8cPzckTN4+kWvUE0HdkiLOc6R2cgGSqaDF
         e128WZD2L8x5G8Zt0D9at5DEn3tRce12GewYSzNCnDBJxkCj7tOdCdiQAz+ilIlZKVmb
         TIsmfgDPoJqnihOTx5ybDVG9OzFLy/cem0yOAMCNBhFBg0+9KAKeUWsU1ceuMJ3BDQjY
         gIrDuWDqM7aKupldEFjC4Gyc0yHTQ0v9sF7cddbIiZ634oCJur2HBcTK8qVxlIw8LJUu
         KvWw==
X-Gm-Message-State: AOJu0YwPMhDVbNe/h7r2ONFPDE3ibhvC7UUYg+wUfKWxV3Thik1jbzt8
	YF+87gLLT03AmINVAn5WP1BzAehVIXWqDpDsBCWg0ml2k6EXj6asiStHnHJx3NJQ
X-Gm-Gg: ASbGncu1tDsNiv21vV0brOxoBxGp2dczbOVUoS+uJwtRdTi9VFrUwZP78DCDaa2itRH
	XoDYFFm5UzDjj4HHPQEIPNleHq0i3pzQIdfWiVI7y0/n/qVkKwBwPOZCV1050YeAoNDmQh5gKKU
	vHb3e81RXBArSDOhd4+PP0Tk8ZGmNhnnZwkt4O1yRE3GDVeLhrTuiMXnlhHd+uHs1hUgsLGP+0M
	h5YQPQxDMRlApl+d2F6agl1jLILKVcgXD+viJaSwPauVwVhx+SccnGX4Rr+rEActBFz4Ag0rVRE
	nHVVGpUzfdiLnYnLvLpl5DBGhF/3n6Wp0m+GgVogJsMGzj63yHUX7c5q8VFi9ipniiALrxDR+fc
	H2NFO6vp2MD+7e46ESg+BN7UQ/J28GKgUglrpMVFHbrcBTe7i+1v7pu5VRc05srXBC5j/p7ZdBl
	g5VAkGBlle/3LeesXE47jQEo2MqGp6lAd9doCImvtzq91ew3XegIBA3NIk0JZG
X-Google-Smtp-Source: AGHT+IEZT3ooVWPOTaR7btzgKHU89dK5/YebM2h9G08QblFMTNKVrKK6/SjayjR0UFWMF9FZgOc2lw==
X-Received: by 2002:a05:690c:c8f:b0:786:758e:d7c5 with SMTP id 00721157ae682-786a41a7a78mr40076777b3.42.1762365642117;
        Wed, 05 Nov 2025 10:00:42 -0800 (PST)
Received: from zenbox (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787b13faf56sm756657b3.19.2025.11.05.10.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 10:00:41 -0800 (PST)
From: Justin Suess <utilityemal77@gmail.com>
To: linux-security-module@vger.kernel.org
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH 2/3] samples/landlock: Add no inherit support to sandboxer
Date: Wed,  5 Nov 2025 13:00:18 -0500
Message-ID: <20251105180019.1432367-3-utilityemal77@gmail.com>
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

Adds two new environment variables LL_FS_RO_NO_INHERIT and LL_FS_RW_NO_INHERIT
to test the new LANDLOCK_RULE_ADD_NO_INHERIT flag

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 samples/landlock/sandboxer.c | 39 +++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index 2d8e3e94b77b..2b40b2df83b4 100644
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
+			/* Prevents users to forget a setting. */
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
-				false)) {
+			0, true)) {
+		goto err_close_ruleset;
+	}
+	/* Optional no-inherit rules mirror the regular read-only/read-write sets. */
+	if (populate_ruleset_fs(ENV_FS_RO_NO_INHERIT_NAME, ruleset_fd,
+			access_fs_ro, LANDLOCK_ADD_RULE_NO_INHERIT,
+			false)) {
+		goto err_close_ruleset;
+	}
+	if (populate_ruleset_fs(ENV_FS_RW_NO_INHERIT_NAME, ruleset_fd,
+			access_fs_rw, LANDLOCK_ADD_RULE_NO_INHERIT,
+			false)) {
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

