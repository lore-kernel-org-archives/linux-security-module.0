Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF5924113D
	for <linux-security-module@vger.kernel.org>; Sun, 14 Dec 2025 17:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765731961; cv=none; b=DLSMZYeCF3r4MSEMbjN222By8O1jGUepDcY6lpAtvDWLulNV7fhn5ko+Czs32T7Jtv865aBVOU/APj8YTLkxKGaZ0ZxVVFJftQn89GRvETr3stPGKNh1QJh5j5/m6rLWAPbahVcQ6bULcO91fkX5cfQ09Tx96n45vYvC0Q1d95o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765731961; c=relaxed/simple;
	bh=GUqr6uDq07FBHSk8BUsNzBbQBnMXOou5GyNav5lazn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CwccW99aGtDE5q4djYZahU/ZDo5RUN/t3GyjyjZ0goCZFpi612Jx3RljtXkOjrvIYhNxXHs+C99hPU92A3/3v6SLm9+5PnPLXx+UXL77LMYH7gQALZfMD2pq7iy3XIrsu1HzAA+n4RwFSAeBzaRpwK0Ppb79pqtQAb1g+z1RhxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lT9Cr25e; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lT9Cr25e"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6446d7a8eadso2540700d50.0
        for <linux-security-module@vger.kernel.org>; Sun, 14 Dec 2025 09:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765731958; x=1766336758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zlF+WYCyWf3bnU9919UPZnFtBsX+0YUSjSTVHFYx064=;
        b=lT9Cr25eY6sZO4mGRXJ0b+6ZHSMu8/paEhVlTBlZSoEm4Ac1AtBycnME+f48mhgFKt
         oCqxnZEr3pkdYT+O492LJvkwAn6UPnATae9tw+oaCFbeegICqMbdqYkjNFcpttmJG34+
         h9PscxmUx50e4NUsLRD6iMwHtYdWLB0orua3QFE2T62dT+E/6fBTzdpjf7Zj1ll+RDoQ
         H7rywJBShlJ9R7J92p7ZyUYPVznBPdNswojxe8M9k+2vxwPnH8qEUyQACJR+bkSH7HOw
         Bt+qQBRbgsHDxIzFRuv7SvzaA2v4t2a3zKsGTaEWGtocCvczJsWfdMeHz8p2bEKqBnr3
         Zykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765731958; x=1766336758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zlF+WYCyWf3bnU9919UPZnFtBsX+0YUSjSTVHFYx064=;
        b=xAtHlUomvPY8+JLgVWjRGWayhB1ux93udZNhtk2MPbGtaVgPgklxQk7bWDhtBmTr3e
         3d+CSBUsIUcJeIk4tMARBdNXLiC56WKikR7fYte+3LOw/2JbUgIYRL2F5fv0CgqpEKFT
         WpokHa/r709LlhJWxeR/xE3sb7xYNXctb7hQGuSIh9rySdPYAZqrNjb1kjyKqnIj7Mrf
         bHIy5+jEWPWUDJyGtbqvWi/kRwr+7+gGAq8qn+rCU8xzDGMNeHHa70FbeWnMkN1LETZu
         R170LQlUXj4KJ49KyUq2m+QrV0VJTXnPwvDvYq+dm7qaGtyJEWq7jSqn/7hU4OOIOtM/
         /6WQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjhPlKgLSQteP0VD0HXcKXo+KjKqygaIfuaqpEgp8mVL/YR89AI7HlOD6B6Ox7GjMSI/gblrVSs71UKSfu3CdrxLbCQuA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx2f9gxi1jkMyBioVd+M9nOD9Hrua7hJsPjPcPbPRGt5ybqTP9
	BlhBx4HZJAvbwdNBzvbtjSKktnkHCBt+N2oPNoVysEtv4Cx4pqN5nLgc
X-Gm-Gg: AY/fxX5dyWe0pyGinFwtS6hXV2oTeCxgVbJkLZE4vXGLKb8wZqVBkamFtYWL/FK/6Rp
	bkAOGETFzWwzFLTI4BM5tAu/vt4lWo6Z1BtHzq+zmw1T2duEgKkSg3fAw4FsqUrylpYqCvY2Mh7
	Rrcg3sSQpBnhOQ6WjKq2QH46h5fUChpUwOZdnMDpC4uB2rBz88OxNZR1eY1V2Ge4EYpmojl/bK4
	vloHszaLTYUl4+4GgeERttu0r3Va3j0mh6QXX911hLfDv8ouH1Ojueq5ZuDgMbRjUkVflXIKl53
	yxKdonw1BHAjPVH6xNxdtaIuvKAyuBineSGbrMZtkyol1YCJdjFEcvu4/sgTv/VeOeyBFj/hZe7
	E/fjGCeKVVpeW5WSajB6lpcUGKHqCd5dzBAiR5YlA6a/GYA/5k9TcO2STuDZ9GJFB8k0l6LnsJ9
	B8nCbMhqgeTzypjHSHxXCETqVqw/uf468ztEalgiBEyoy5jXTWInDnHRV/jn3t
X-Google-Smtp-Source: AGHT+IG/p8p+ucaZ/fGmfevGswX9uV2kIZjDhYSqyeQ7HXA8Q/lYvizo12xVCEcu70pWsloPVNZhgA==
X-Received: by 2002:a53:c651:0:b0:63e:18d6:72c1 with SMTP id 956f58d0204a3-6455564f1d4mr5463524d50.46.1765731958060;
        Sun, 14 Dec 2025 09:05:58 -0800 (PST)
Received: from zenbox (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78e749e7683sm19401117b3.32.2025.12.14.09.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 09:05:57 -0800 (PST)
From: Justin Suess <utilityemal77@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v5 3/6] samples/landlock: Add LANDLOCK_ADD_RULE_NO_INHERIT to landlock-sandboxer
Date: Sun, 14 Dec 2025 12:05:43 -0500
Message-ID: <20251214170548.408142-4-utilityemal77@gmail.com>
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

Adds support to landlock-sandboxer with environment variable
LL_FS_NO_INHERIT, which can be tagged on any filesystem object to
suppress access right inheritance.

Cc: Tingmao Wang <m@maowtm.org>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---

v4..v5 changes:

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

