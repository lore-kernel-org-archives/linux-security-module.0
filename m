Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5270B36213E
	for <linux-security-module@vger.kernel.org>; Thu, 20 Nov 2025 22:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763677450; cv=none; b=dm5I+I1NxUuoA+XUcTLPAxozlGy2Up/kIH7u+CE2mcggOFyxncmN1qmdtrBIakVn/FlkLIU+AA14Na6Vix7TAvwv9qvH+Zhd15KxeNUgaVObifZM2eMMOFwi9xtdYmhtN/4WGQB/awa2ZWjQyyuUbVIeoZoJzipTVWIgB82txyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763677450; c=relaxed/simple;
	bh=Xhh+O3luqRxdN555Ci/bpIFEKRq2QjbwtvhK2ln/jkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h78oNdGQ31dvJJqwg1FRXl35ilcQs3cMMrBdowBg7YsnJWhG6srP8korW05gBGG+rxhbklrgZQgZ3X9YVycs42I2b1HShdljjzP7qqD9rtdKHkubSG4ixaxhGG2pEKBScV1bV065cc/2A4ZTPjIzlMdHpWp4T0ofjWw++nEny1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jInfo/n1; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jInfo/n1"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-787eb2d8663so22668417b3.0
        for <linux-security-module@vger.kernel.org>; Thu, 20 Nov 2025 14:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763677445; x=1764282245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2KNqWIBAx3zm8pyAs1G8s4JgD0/xDNLSye/8Ec9iBgg=;
        b=jInfo/n1NrrwkGd8115W0UYHfwvrgV8HJbh1wHHT3F8/fEj3d5jKfaNdjE0VdN4Ax0
         dwT0DqTUiEdxdkdkwvatoro4l7rx+GSqCf3CrOBcCVLNoYXNketMaDUu7k/0YvcQQJJ1
         BtDug3J3gtllz2o/Tx5QAEhT3a6OcGgEnfK6+PbtIfRYeLsXSbeBMpFb8D88DgCbj9if
         vQqwCYN6tUv2zAd+fLp9OB2oRdy0Dq2mMpaTSjCvIysEPj+8Y65Q51LoiYtL8xJKhaon
         OPBHsMXZIYMN8q33ybTx/TmVn0htPO8P3PhX4dR1iUIYjAPnkVqenY2C00rLsJPc0ib3
         qD0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763677445; x=1764282245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2KNqWIBAx3zm8pyAs1G8s4JgD0/xDNLSye/8Ec9iBgg=;
        b=ZRM5N3dCNC3OVW+E0cozMpyeKM2FBvasgRnoDFbx5Pkwl4x4dbPOAgC6G7fncssnqG
         mmznxxPg/7Oh9GIi7xYay/dEgMtANq4t2AJNGML3avci6YThHf7nCQXNZX/wr5Fcic3r
         09ZQ+EKXsMOy5LYptiJ9kh3L+OlWrklK23hTokR93p6CwIfHPPFdEnYLtq60g+oIzSyX
         u9jDd03qQmzsISajti1+Lkrx7GFDSBiVvGvtzjpQiDpM1nNiT/OnUdGP4wYaGkjSGsf3
         BLobQxATuoL6cT0yKk8x0xjtkwuj7RrqM5/h8GqE7IRYqIG16kBeDYUZGSMjz94ahSF2
         Pi3g==
X-Gm-Message-State: AOJu0Ywh47/UI0jZ7on9+Y+2gCQSTQeHXDsUPqd069+76q3xOAJiNhCK
	bKRqi+DU9z46J6Dul2SV6wNQmMk73uNsEKywk/zWcn1uXSHVln9gTc6mbCoDQh22SAXWDA==
X-Gm-Gg: ASbGncvHTal70RXAljt3mbDGtP8AVZ+m0EdGeU62uXa3xnbMeBuwiyR1DZ1SJpiOix3
	r4tbo2ivyy6EqItsjE4Y/esFrTq1i/xUmUz9pSWEdbdrYkF7XqHGnYsoMAFz7XvcF3MtzLOI05r
	JZaBpkTHE1LRasurbUEB+PrmTJ9PX0oTvY8GShtFjP9aI2gaqSYDuT9KZQU8HhMFqow5Vo2tAIp
	UKkqNY7sanoKi8oDVA2Z/KS150tIlrtLYvFUL1kK+TdxJDgT27oIJlpnzYiktAVplLI7fLo2reT
	MfJweajzQ2bQ8RN+e1uwDcZDag/zK5FC/0QzZuF20fIulrV4l7cv4lwstzDLWDGqNXvSpzkVzit
	4DDkR7YFYHbsOxD8/TRzqKACX2gvtKWAF1wWXm3LN/6fcqMc+SHsTSqVSHP39QXl04XcTsiQN5X
	WXBQVD1SHdhtmdWgibDbW698W4eQun4xNCqSS2oKr/5sUyTyn0DzqHd7QUqyLrvzHtV41FXHs=
X-Google-Smtp-Source: AGHT+IGGPhP0BBgm1PkUCfDQmu6p1XtJrgy4Xh/bM8c4UMC6WpDaPyyCcd1ZgzeDuOSzb3qWXWBY3w==
X-Received: by 2002:a05:690c:360e:b0:786:898d:4a8c with SMTP id 00721157ae682-78a8abaf69emr2263127b3.24.1763677444908;
        Thu, 20 Nov 2025 14:24:04 -0800 (PST)
Received: from zenbox (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a7993cedesm10954757b3.41.2025.11.20.14.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 14:24:04 -0800 (PST)
From: Justin Suess <utilityemal77@gmail.com>
To: linux-security-module@vger.kernel.org
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH 3/6] samples/landlock: Add LANDLOCK_ADD_RULE_NO_INHERIT to landlock-sandboxer
Date: Thu, 20 Nov 2025 17:23:43 -0500
Message-ID: <20251120222346.1157004-4-utilityemal77@gmail.com>
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

Adds support to landlock-sandboxer with environment variables LL_FS_RO_NO_INHERIT
and LL_FS_RW_NO_INHERIT. These create the same rulesets as their non-no inherit varients,
plus the LANDLOCK_ADD_RULE_NO_INHERIT flag.

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
2.51.2

