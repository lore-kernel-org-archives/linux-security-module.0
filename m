Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763C52459D1
	for <linux-security-module@vger.kernel.org>; Sun, 21 Dec 2025 19:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766346197; cv=none; b=iIyO8xGFCYnGrvsmFTlm5R0mbJAhFa5F8+BI6Hpzixsb2lmxyrYlpguguVeUD7lBdmOHVPRD7yQNMQ9Ig7qu/cCDxAyqJ/1hROPzLsOtXzuPx+09QlisusfUU6cuHsQtQaiQAdgBejcN6lgVy5yn/qIkFxKxkSinXWy9T9a/cwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766346197; c=relaxed/simple;
	bh=Rup7pnonu5HABSkRgZO3ZGPXc67NIkztQXrZWaR7GRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mDCtJv67fq05BLilu3fof2lPPYhaIXoGbUAyvj2GfM1ozP9qW7fW65nWnCIx3A++KmtUE0SpsWdWkjnwZO6IzI3mwooK02jx+JN7ah2VfjYK5eF6F5s3pfPNIZDBlG/ur2LEduY0glbwy2jO5EkGrDixBQ+thxfoc+OXPLbWPRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZkcwzHzM; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkcwzHzM"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-78ac9f30833so22867557b3.0
        for <linux-security-module@vger.kernel.org>; Sun, 21 Dec 2025 11:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766346194; x=1766950994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z2bosXWL2KxPzrHYqcbSg48If1UfkUGvRPJ2Dh1rrpU=;
        b=ZkcwzHzMVMngw8geEOWxmsqx1df85CdaOmOh0yy0RU2aI5LR49/zrtd6935Y4MQdHW
         k2XHplau83vsZSgH2t3jFnHd+YFCl73as65Jxmpod9YVjX0suncCFS4NsTyjUNkLaFvW
         PaKalUmAwNNDEs5vTH69oFUJ2T/ZssXrbt9F8skULuOdPieKfWaZxCh4UgYErUKQo/j9
         5PVqvq3E4zLy53j1SGuqj2owxIg0/cY4PO6jPyMvPss75Qm8AJNDr+QJlECvcIxKpv+q
         jmF+mQRGPGMc0LLF7cOI1t++O+5Mg8TgFYT909ZuIJaaprjPoBzF2/5WoVl5s4rlwdzk
         JShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766346194; x=1766950994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z2bosXWL2KxPzrHYqcbSg48If1UfkUGvRPJ2Dh1rrpU=;
        b=hS9JkRq1xyxIf11koAdyaYLpbWlPHBCSXDfgHy/OAZq/eCGr4C/K7h9G5TJyjf6Taa
         L9eN1orO5s7NM2fRFyXl1TUMwunnau4a1ZjdSbN0zJZMuSNXnxzfg1h0KIfnZ9/s+yFF
         arXwq5bMSeUqLJz2sLgrUqMHMjKw329fAtryjmzZRIPIbQttM8V14PV7CAWnAbEtbonJ
         4wHIpm8zyFbx/55pf7Wg4HsFhc1rPTfaLuX2Z0+fjw/x2t/MJKfJIoKcYWr70XAYUwee
         bweubztHn9wKUIbjrdMGefRdGOCClNNIHDtYmc+FgKzfnvAFJf0BLHa9k/5WOcCsBEGa
         +3EA==
X-Forwarded-Encrypted: i=1; AJvYcCVm8DTnkaoOQTgvRLail2gwmS49flS5aQH0M+pg1+Dlh1cZ/e6pXcWd2LudHVSb18+K6y16ZFgj80eehKIsKKzF5G1HE6A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0/xHTWyt7bAD1KMD6LmwLHN2OTNuWq9S9fGvDYKfymZsXuGqm
	Hjl46VnXoveoqrmfHVx9/u9U+KoyX4xoOfsNL/dcMWeR4G5WYmRwXxuF1wZT5A==
X-Gm-Gg: AY/fxX6J/RR9iP21AEYG70OZWUfKBnpY6tNugyrmNBZohicY2ggZJ1HYG4PokxkUrzk
	cZxTWmXRpV+4hr4zRRt0VIeIsX2VCya/zYUjuP5ZxObEeovMb97kDpvJKR19+U/YkpetQOEpIso
	P30/YBd9dHA3K4fq8rz7ywlLVbI4XJhc6FQ3oJwORYLv0GHGYrSmhkQFPL5rsl50TV65PpJx3hX
	FGuydXO9H+U5OxuiHv1L8udPsOIioajzZMY0D8smyWHYDSggUyCYHZCYXWyvBSs3RlX29NjR68x
	0aDqaDBWOIen3hW6aA/4FnAtQznbdP9XcfMod789V5Cjl3Qk8UZff5eyXYYe0yvBFkw0lP3nVi3
	OKx07Nv7kSdD2PO0uFLdmlFG6qfgWC5fl07w3P9PNTEZgRLPqNoOL++TLRQh/Twu7JjWE+7slQw
	SeqFspNusrpEb2WP93D02X6Slo3KAdG5aSGDHsWLlnW3H2ukcnJRD4/gS6GSRC
X-Google-Smtp-Source: AGHT+IE4sqQ5oYL1ALKzIFET5LclD8M8u3ISkFKTO+2pvsqQxk5ZfGlYbpkh50QFW6EfdrNmkJv45Q==
X-Received: by 2002:a05:690c:6e13:b0:78f:a6e7:76d8 with SMTP id 00721157ae682-78fb3f241eemr79539947b3.18.1766346194442;
        Sun, 21 Dec 2025 11:43:14 -0800 (PST)
Received: from zenbox (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb43701c7sm35628707b3.8.2025.12.21.11.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 11:43:14 -0800 (PST)
From: Justin Suess <utilityemal77@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v6 3/6] samples/landlock: Add LANDLOCK_ADD_RULE_NO_INHERIT to landlock-sandboxer
Date: Sun, 21 Dec 2025 14:42:58 -0500
Message-ID: <20251221194301.247484-4-utilityemal77@gmail.com>
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

Adds support to landlock-sandboxer with environment variable
LL_FS_NO_INHERIT, which can be tagged on any filesystem object to
suppress access right inheritance.

Cc: Tingmao Wang <m@maowtm.org>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---

Notes:
    v4..v6 changes:
    
      * None
    
    v3..v4 changes:
    
      * Modified LL_FS_R(O/W)_NO_INHERIT variables to a single variable
        to allow access rule combination. (credit to Tingmao Wang)
    
    v2..v3 changes:
    
      * Minor formatting fixes

 samples/landlock/sandboxer.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index 07dc0013ff19..852ffa413c75 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -60,6 +60,7 @@ static inline int landlock_restrict_self(const int ruleset_fd,
 #define ENV_FS_RW_NAME "LL_FS_RW"
 #define ENV_FS_QUIET_NAME "LL_FS_QUIET"
 #define ENV_FS_QUIET_ACCESS_NAME "LL_FS_QUIET_ACCESS"
+#define ENV_FS_NO_INHERIT_NAME "LL_FS_NO_INHERIT"
 #define ENV_TCP_BIND_NAME "LL_TCP_BIND"
 #define ENV_TCP_CONNECT_NAME "LL_TCP_CONNECT"
 #define ENV_NET_QUIET_NAME "LL_NET_QUIET"
@@ -383,6 +384,7 @@ static const char help[] =
 	"but to test audit we can set " ENV_FORCE_LOG_NAME "=1\n"
 	ENV_FS_QUIET_NAME " and " ENV_NET_QUIET_NAME ", both optional, can then be used "
 	"to make access to some denied paths or network ports not trigger audit logging.\n"
+	ENV_FS_NO_INHERIT_NAME " can be used to suppress access right propagation (ABI >= 8).\n"
 	ENV_FS_QUIET_ACCESS_NAME " and " ENV_NET_QUIET_ACCESS_NAME " can be used to specify "
 	"which accesses should be quieted (defaults to all):\n"
 	"* " ENV_FS_QUIET_ACCESS_NAME ": file system accesses to quiet\n"
@@ -430,6 +432,7 @@ int main(const int argc, char *const argv[], char *const *const envp)
 	};
 
 	bool quiet_supported = true;
+	bool no_inherit_supported = true;
 	int supported_restrict_flags = LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON;
 	int set_restrict_flags = 0;
 
@@ -517,8 +520,9 @@ int main(const int argc, char *const argv[], char *const *const envp)
 			LANDLOCK_ABI_LAST, abi);
 		__attribute__((fallthrough));
 	case 7:
-		/* Don't add quiet flags for ABI < 8 later on. */
+		/* Don't add quiet/no_inherit flags for ABI < 8 later on. */
 		quiet_supported = false;
+		no_inherit_supported = false;
 
 		__attribute__((fallthrough));
 	case LANDLOCK_ABI_LAST:
@@ -605,6 +609,13 @@ int main(const int argc, char *const argv[], char *const *const envp)
 			goto err_close_ruleset;
 	}
 
+	/* Don't require this env to be present. */
+	if (no_inherit_supported && getenv(ENV_FS_NO_INHERIT_NAME)) {
+		if (populate_ruleset_fs(ENV_FS_NO_INHERIT_NAME, ruleset_fd, 0,
+					LANDLOCK_ADD_RULE_NO_INHERIT))
+			goto err_close_ruleset;
+	}
+
 	if (populate_ruleset_net(ENV_TCP_BIND_NAME, ruleset_fd,
 				 LANDLOCK_ACCESS_NET_BIND_TCP, 0)) {
 		goto err_close_ruleset;
-- 
2.51.0

