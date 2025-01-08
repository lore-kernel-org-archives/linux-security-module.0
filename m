Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [83.166.143.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48982204C2A
	for <linux-security-module@vger.kernel.org>; Wed,  8 Jan 2025 15:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736351071; cv=none; b=XpovOJASf9dZk2GzyD3tU6n1DaKj0EOv7EFNbWYcmNEQhjr8SuLKrCgPK1dKvDeApG/u2oAHJQOj87mdOOWvvEcaCC/cIAntsGeVws1ffvbEDrzHgI8glrZt2ql4VfBSREypqaV/nPx5IerVC6hHCLdJU3C392Mv/1ZYmXH1370=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736351071; c=relaxed/simple;
	bh=pW499YWVaRnWVTNaXtUOgQ7lkzGTPh+Wwe+6wiE8Ohg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ii9pn4Vv0J9o+1TUXZQIbDJFH9CL0ixy0t1cv/Eio4Ub06yuOlNHlk+wEGIgBPBwHCBywE+JJA1+IgrOdmaVni3MbEE8ukiU/I49WbfON44ngQAr8lo13TsvzxlT9v6DEFCKGPp04N8+xyDNg5IFl2uchk9T1ek17YyuV1bPoo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=DOXHg6Bq; arc=none smtp.client-ip=83.166.143.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="DOXHg6Bq"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YSsfg53yHztsy;
	Wed,  8 Jan 2025 16:44:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1736351067;
	bh=E2Dmree0e1EpVbxU6ktNYpMoszkVcilFnXqplxTgABI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DOXHg6Bq2lz9wQDlSrRroKlF694ur8X7I+fK9hTTfl6RY1QEIIcUSgEyp3YDpMgzD
	 u1OsD3fGRqXNK/Ab7xlfsoV2Orctoi3WoEIvjIobIUyifJVOFMzp5L/izMKAOmo1UO
	 i2r9Z03M1kn5GZzh6jydRGUaLvB6v1WwagHwGOpY=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4YSsfd6q13zFc4;
	Wed,  8 Jan 2025 16:44:25 +0100 (CET)
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
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Phil Sutter <phil@nwl.cc>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Robert Salvet <robert.salvet@roblox.com>,
	Shervin Oloumi <enlightened@google.com>,
	Song Liu <song@kernel.org>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Tyler Hicks <code@tyhicks.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v4 27/30] fs: Add iput() cleanup helper
Date: Wed,  8 Jan 2025 16:43:35 +0100
Message-ID: <20250108154338.1129069-28-mic@digikod.net>
In-Reply-To: <20250108154338.1129069-1-mic@digikod.net>
References: <20250108154338.1129069-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Add a simple scope-based helper to put an inode reference, similar to
the fput() helper.

This is used in a following commit.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20250108154338.1129069-28-mic@digikod.net
---

Changes since v3:
- New patch.
---
 include/linux/fs.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 7e29433c5ecc..bd5a28b0871f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -47,6 +47,8 @@
 #include <linux/rw_hint.h>
 #include <linux/file_ref.h>
 #include <linux/unicode.h>
+#include <linux/cleanup.h>
+#include <linux/err.h>
 
 #include <asm/byteorder.h>
 #include <uapi/linux/fs.h>
@@ -2698,6 +2700,8 @@ extern void iput(struct inode *);
 int inode_update_timestamps(struct inode *inode, int flags);
 int generic_update_time(struct inode *, int);
 
+DEFINE_FREE(iput, struct inode *, if (!IS_ERR_OR_NULL(_T)) iput(_T))
+
 /* /sys/fs */
 extern struct kobject *fs_kobj;
 
@@ -3108,8 +3112,6 @@ static inline bool is_dot_dotdot(const char *name, size_t len)
 		(len == 1 || (len == 2 && name[1] == '.'));
 }
 
-#include <linux/err.h>
-
 /* needed for stackable file system support */
 extern loff_t default_llseek(struct file *file, loff_t offset, int whence);
 
-- 
2.47.1

