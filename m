Received: from beta.bencteux.fr (114.ip-51-178-41.eu [51.178.41.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308A536A017
	for <linux-security-module@vger.kernel.org>; Sun, 12 Apr 2026 10:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.178.41.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775988520; cv=none; b=alHv8Xg8shC6DJoy45GdSGM59uKh1yBL/GictKCYVJHC8DcHZfvkWVaMWejmSZmacEq18daVh9vvZ5zXexaSZiqr4nZsTWo+8s1Ju5peTkzQLjySQzlPo1p0PlDUk57SybMn9cWPKwYbeAB1XjdT9SFQjdGKajYz7/HnXmxA6Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775988520; c=relaxed/simple;
	bh=FpSPdWmJtuazv70bTEgPhPMXrU0BCQdp+ED6z2cZgYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n+PUSTF5mdN+5oi4CNXBZgIicBgj9g9ruoEpoCUxYFfbG058SaqVYLceoQRjdAOV4I42zZ8AcxWraZuiRabA7ghou8C5UO2QRtpI1qOcFY6xe9uGToAlrrHMgMjPKUQdBU7IJ3faMSOVcjBsn8oLsv68CxlvmqifZEy+tQZQhus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bencteux.fr; spf=pass smtp.mailfrom=bencteux.fr; dkim=pass (1024-bit key) header.d=bencteux.fr header.i=@bencteux.fr header.b=v9D9ypfu; arc=none smtp.client-ip=51.178.41.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bencteux.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bencteux.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bencteux.fr header.i=@bencteux.fr header.b="v9D9ypfu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bencteux.fr; s=mail;
	t=1775988108; bh=FpSPdWmJtuazv70bTEgPhPMXrU0BCQdp+ED6z2cZgYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=v9D9ypfuruyRrNhdHTn6IoZ0HGdN2/0Aw4AhixCG2Rf2JIz9Iz1aWlA6+iXMPaGB8
	 gEhal3i0KyKT09jUdbbJxFqMD2lfmrcxD8PZ6THFwxo+rJiBSMJcumh5W4scF86g9c
	 mXQOGXqZLUGQA8prwr8XEFuUWJTV9TP5zo29Ht+Q=
Received: from localhost (lfbn-idf3-1-911-123.w90-3.abo.wanadoo.fr [90.3.226.123])
	by beta.bencteux.fr (Postfix) with ESMTPSA id 9740740336;
	Sun, 12 Apr 2026 12:01:48 +0200 (CEST)
From: Jeffrey Bencteux <jeff@bencteux.fr>
To: mic@digikod.net,
	gnoack@google.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-security-module@vger.kernel.org,
	jeff@bencteux.fr
Subject: [PATCH 4/5] samples/landlock: add support for chown and chmod
Date: Sun, 12 Apr 2026 11:50:43 +0200
Message-ID: <20260412095233.34306-5-jeff@bencteux.fr>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260412095233.34306-1-jeff@bencteux.fr>
References: <20260412095233.34306-1-jeff@bencteux.fr>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update sandboxer.c sample code with restriction for chown and chmod
system calls families

Signed-off-by: Jeffrey Bencteux <jeff@bencteux.fr>
---
 samples/landlock/sandboxer.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index e7af02f98208..551e9a33665a 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -111,7 +111,9 @@ static int parse_path(char *env_path, const char ***const path_list)
 	LANDLOCK_ACCESS_FS_WRITE_FILE | \
 	LANDLOCK_ACCESS_FS_READ_FILE | \
 	LANDLOCK_ACCESS_FS_TRUNCATE | \
-	LANDLOCK_ACCESS_FS_IOCTL_DEV)
+	LANDLOCK_ACCESS_FS_IOCTL_DEV | \
+	LANDLOCK_ACCESS_FS_CHMOD | \
+	LANDLOCK_ACCESS_FS_CHOWN)
 
 /* clang-format on */
 
@@ -295,7 +297,9 @@ static bool check_ruleset_scope(const char *const env_var,
 	LANDLOCK_ACCESS_FS_MAKE_SYM | \
 	LANDLOCK_ACCESS_FS_REFER | \
 	LANDLOCK_ACCESS_FS_TRUNCATE | \
-	LANDLOCK_ACCESS_FS_IOCTL_DEV)
+	LANDLOCK_ACCESS_FS_IOCTL_DEV | \
+	LANDLOCK_ACCESS_FS_CHMOD | \
+	LANDLOCK_ACCESS_FS_CHOWN)
 
 /* clang-format on */
 
-- 
2.53.0

