Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [185.125.25.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C0422B8A5
	for <linux-security-module@vger.kernel.org>; Thu, 20 Mar 2025 19:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742497669; cv=none; b=b1NzNDbzmcUiSodFBhHk+XEA+8c1zhvQ1yLdatbWRB5kqKVKUFfRqzII17eyFZWbFBdQjXef9DFVnR6IOHGzl9c95Ee0C1bwheLYGm+cx9uEF7ZlClR2uTj6AYBlWBitFXoSW3vFSIHI3nAepbpGequ0qjMQLyDxIMuR7nDyFAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742497669; c=relaxed/simple;
	bh=aIcyGngMiaXaoOMwuHIFOcHjupDaweLFlCjMU1tHEeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eGR92c1rTXIvfnTVWnvr7f14LVtrvXnNgmD6ImZqUeWbt4vop+OAIN6tXc87W3fHfmSI14eOB6eKs0ARCwII5Ysc+WnUPYh2nodL0pTp3H5gwoG8CJ9J1vm9xP9qFc6Tm1s1TvdP0A9/oymKv26jh1aHX8ndAMihQjRoerelruE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=WJhV/CnE; arc=none smtp.client-ip=185.125.25.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="WJhV/CnE"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZJZpT1Lzbzv4c;
	Thu, 20 Mar 2025 20:07:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1742497665;
	bh=6Lkeq+mPSJqRfm/8RusO0/af+PFqV8CCBD2/sGkcSvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WJhV/CnEVrHKVYGNAr8Fzpp0u0sK2WwkrsiF1LISApgXkAAnlV7oeYjWvR5Xivb26
	 Q1gz5KNCl3uN/Qq71jm1m9y9i4e9Ex+MlR4TJdBH9aFQRDzbcp+DMyV1W4wjwu7Pk2
	 pm84etgKWdwJlFigRQLHfisIav41GVD4djZE62qY=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZJZpS0y4pzFHF;
	Thu, 20 Mar 2025 20:07:44 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Eric Paris <eparis@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Ben Scarlato <akhna@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Charles Zaffery <czaffery@roblox.com>,
	Daniel Burgener <dburgener@linux.microsoft.com>,
	Francis Laniel <flaniel@linux.microsoft.com>,
	James Morris <jmorris@namei.org>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Jorge Lucangeli Obes <jorgelo@google.com>,
	Kees Cook <kees@kernel.org>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Phil Sutter <phil@nwl.cc>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Robert Salvet <robert.salvet@roblox.com>,
	Shervin Oloumi <enlightened@google.com>,
	Song Liu <song@kernel.org>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Tingmao Wang <m@maowtm.org>,
	Tyler Hicks <code@tyhicks.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v7 13/28] landlock: Factor out IOCTL hooks
Date: Thu, 20 Mar 2025 20:07:02 +0100
Message-ID: <20250320190717.2287696-14-mic@digikod.net>
In-Reply-To: <20250320190717.2287696-1-mic@digikod.net>
References: <20250320190717.2287696-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Compat and non-compat IOCTL hooks are almost the same, except to compare
the IOCTL command.  Factor out these two IOCTL hooks to highlight the
difference and minimize audit changes (see next commit).

Cc: Günther Noack <gnoack@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v6:
- New patch.
---
 security/landlock/fs.c | 32 +++++++++++---------------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index ba03439caab9..c67ef35248e3 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1698,8 +1698,8 @@ static int hook_file_truncate(struct file *const file)
 	return -EACCES;
 }
 
-static int hook_file_ioctl(struct file *file, unsigned int cmd,
-			   unsigned long arg)
+static int hook_file_ioctl_common(const struct file *const file,
+				  const unsigned int cmd, const bool is_compat)
 {
 	access_mask_t allowed_access = landlock_file(file)->allowed_access;
 
@@ -1715,33 +1715,23 @@ static int hook_file_ioctl(struct file *file, unsigned int cmd,
 	if (!is_device(file))
 		return 0;
 
-	if (is_masked_device_ioctl(cmd))
+	if (unlikely(is_compat) ? is_masked_device_ioctl_compat(cmd) :
+				  is_masked_device_ioctl(cmd))
 		return 0;
 
 	return -EACCES;
 }
 
+static int hook_file_ioctl(struct file *file, unsigned int cmd,
+			   unsigned long arg)
+{
+	return hook_file_ioctl_common(file, cmd, false);
+}
+
 static int hook_file_ioctl_compat(struct file *file, unsigned int cmd,
 				  unsigned long arg)
 {
-	access_mask_t allowed_access = landlock_file(file)->allowed_access;
-
-	/*
-	 * It is the access rights at the time of opening the file which
-	 * determine whether IOCTL can be used on the opened file later.
-	 *
-	 * The access right is attached to the opened file in hook_file_open().
-	 */
-	if (allowed_access & LANDLOCK_ACCESS_FS_IOCTL_DEV)
-		return 0;
-
-	if (!is_device(file))
-		return 0;
-
-	if (is_masked_device_ioctl_compat(cmd))
-		return 0;
-
-	return -EACCES;
+	return hook_file_ioctl_common(file, cmd, true);
 }
 
 static void hook_file_set_fowner(struct file *file)
-- 
2.49.0

