Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08821DF248
	for <linux-security-module@vger.kernel.org>; Sun, 21 Jun 2026 03:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782013956; cv=none; b=ATgkAgiROCprEJ0/NXXZZIlqGNaZ0ykQhPxktwX6CyBuvXUc8zyejKUXnicR2XSHxpK2052wXhYjI8PDDRfVDnhYpd85yC9+NCarmEZCPsdXQY+7HmvFvy2oE+x32gA6MiX/AS3kVB6uABhL5KbKtmx/2IYSLuO/VP/ID07HLTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782013956; c=relaxed/simple;
	bh=ed2h1gWPZVSNd0xoPX/Eiw7CGGb+dj2CS9R47WlYI+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cFRWiOuOhBBwy5T6uNSzwht7W097uDXvKWzxhRkYIS+gNjseno60KG3mg32UqnyGl63NFZjkSF+/aimQ6uASXH7zBnCxrDVLXNVXYjF1jfaonHkBAUCNSHHcyc/1Q8Bht2QM5sKxaeLybB+AXG2fZlUmyqWfa8P5gH1hF5oMTiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FwePNwc8; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwePNwc8"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7fd3801ca22so24168387b3.1
        for <linux-security-module@vger.kernel.org>; Sat, 20 Jun 2026 20:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782013955; x=1782618755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5BbHaERqu+SSiXDIt2Os9ftFfBdWgCKksDMq7JUvKIQ=;
        b=FwePNwc89znqnisY/FoO+R5A1rjMqOe1NJnKlhLJPEJt/cLA64NZ+fKuWObPj9sThB
         bcEgbr86TQ2HmoTNpxwyRZVkOH9/AtuvqPF4AKWVqZFCVf0aRh01yq7oHLXtxFd0AHWG
         BlNgo++ALuN1yiz5Nd2dWrVk6bmP3bNO2f/5wsWKE+w4G6DfJ8+aOrMMDhAFjwjb0ODv
         rWxlKrGG0A/mWrJLeU23h65fjZ0bvLFV4lpOQShMNpeAFPINk9uS0i/Vd850NRdX2xDH
         ZaHiDePnjPJmf9fO6d3D50G8IJESfRt2AutKK2Z59SeGH+7OhF8Kf2d5qFdIjIyUAjuB
         g/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782013955; x=1782618755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5BbHaERqu+SSiXDIt2Os9ftFfBdWgCKksDMq7JUvKIQ=;
        b=F88doJrRefXVOZIxiRofmuTA4GJwnonxeVehGtXjrJKn9okugx4erinPMvuev91NcN
         3EtXV1v9J5k7KjKNKT9JrIGXmf9dzDa5MRdtywIqJiwTnupgreBuJgTVJDtC/dS6Dr4x
         yR++Di5Sm3ChChNyNpZkezMrxYiYQnvUJMKcjJzj/X6/jTIxlx2k4+yQ5XCUDHNxzJ9H
         Vo27b6bQgUUMsVdC0aoSOKla2kWrMZSKg/RYcdX6OGd87OZ1IAGT7Mj8j1yAzjYdQ2eW
         cQmcQzLlVkkuYY7UQBahND3ZWEtrs/yCDiCM8jV+FmRWvU76o67vQ1FOZBvuCyEsIfbd
         68Iw==
X-Gm-Message-State: AOJu0Yzwnpt6JlaiPPr/Pj29RzopNRBznzgkSFy3kqwBYrbM26kRgZFf
	9CtI7fSQA34FSsduWMpCMv180g9CCT0lUONxe2RdgU8KFSrFdtiRIEKN/nVIGA==
X-Gm-Gg: AfdE7ck/15yGEiDlnKKUbtn+g640254quzpAku6tePrpqEDBWueVTpsCdwSnmBMWtQH
	w32cfNxQWcVjvJ5l1eMxmLfvEkl5/DuWBZGLZM9x455eQacyxxXSu+Bl/T9zpruQJpUl+/SJkvh
	L303leaw5Ay31VxnRj8Y5j1y9IbZnbb905QJF8KaJPY4/QV2BclSwlk+1bYC4TifA70zEzUIX/y
	uCelnprYsoTtMywwJFcauslPgZ9yX9w/Cz7/quXmFnRiI5oUej2o2Ftai6oqOCSpT0KfgEzUu8B
	q9/6oNJKRgzfVJ5ghrBi2/XMHwCzpd+CACehSGhcQWp0ls81gCUwUAEVgR+qabvrN+ZCcL8wwfg
	ntnsp7fa2i7pkCG7GuJV+ShckG6FjskZ6DLdAhp9OtHQapnPJ1EhHJAdgpUo3U3XSVSWWdT//J0
	tSvhhAJfr94iubbeVD0iXBkIAR7NBlF/h2ScI7cFT4JkPhyA==
X-Received: by 2002:a05:690c:688e:b0:7db:ba77:899e with SMTP id 00721157ae682-80260c89cbdmr60288877b3.0.1782013954798;
        Sat, 20 Jun 2026 20:52:34 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:2de9:628a:4b2:9b39])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8025cf61d36sm17155677b3.11.2026.06.20.20.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 20:52:34 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: linux-security-module@vger.kernel.org,
	mic@digikod.net
Cc: m@maowtm.org,
	gnoack@google.com,
	gnoack3000@gmail.com,
	matthieu@buffet.re,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH v9 4/9] landlock: Move log_fs_change_topology_dentry() above current_check_refer_path()
Date: Sat, 20 Jun 2026 23:52:17 -0400
Message-ID: <20260621035223.2651547-5-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260621035223.2651547-1-utilityemal77@gmail.com>
References: <20260621035223.2651547-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for a new caller (the no-inherit topology-change check)
that sits earlier in fs.c, move log_fs_change_topology_dentry() above
current_check_refer_path() so that caller does not need a forward
declaration.  Reflow its signature to match log_fs_change_topology_path()
while moving it.

No functional change intended.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---

Notes:
    New patch in v9.
    
    Splits the code motion out of the implementation patch: moves
    log_fs_change_topology_dentry() above current_check_refer_path() so the
    new no-inherit topology-change check does not need a forward
    declaration. No functional change.

 security/landlock/fs.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index fd829e06835d..34d1c245af92 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1115,6 +1115,20 @@ collect_domain_accesses(const struct landlock_ruleset *const domain,
 	return ret;
 }
 
+static void
+log_fs_change_topology_dentry(const struct landlock_cred_security *const subject,
+			      size_t handle_layer, struct dentry *const dentry)
+{
+	landlock_log_denial(subject, &(struct landlock_request) {
+		.type = LANDLOCK_REQUEST_FS_CHANGE_TOPOLOGY,
+		.audit = {
+			.type = LSM_AUDIT_DATA_DENTRY,
+			.u.dentry = dentry,
+		},
+		.layer_plus_one = handle_layer + 1,
+	});
+}
+
 /**
  * current_check_refer_path - Check if a rename or link action is allowed
  *
@@ -1427,20 +1441,6 @@ log_fs_change_topology_path(const struct landlock_cred_security *const subject,
 	});
 }
 
-static void log_fs_change_topology_dentry(
-	const struct landlock_cred_security *const subject, size_t handle_layer,
-	struct dentry *const dentry)
-{
-	landlock_log_denial(subject, &(struct landlock_request) {
-		.type = LANDLOCK_REQUEST_FS_CHANGE_TOPOLOGY,
-		.audit = {
-			.type = LSM_AUDIT_DATA_DENTRY,
-			.u.dentry = dentry,
-		},
-		.layer_plus_one = handle_layer + 1,
-	});
-}
-
 /*
  * Because a Landlock security policy is defined according to the filesystem
  * topology (i.e. the mount namespace), changing it may grant access to files
-- 
2.54.0

