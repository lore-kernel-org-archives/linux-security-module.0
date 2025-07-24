Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62022D5C6A
	for <linux-security-module@vger.kernel.org>; Thu, 24 Jul 2025 13:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753362634; cv=none; b=hPxLkweAvjOk7Zon7ysSeWV5PVQkc9xUzOmIV3FPabUZarkEw5lZ1OcKpo4bUNZtPLK1MzeLFfcUTjc9b0C0Q0dmDuU4vHQF6HXt+PyCjd6IC1/4nOl54f+C8Nht+FfZvXr+C/SbOn5hbSZozcvwjnfLED/HUyhdb3R3hshz2+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753362634; c=relaxed/simple;
	bh=ZGSRMdHTAYg0xIqYvQa42aLUMIQAu9r9GpcdnngrEuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mCoBVcC/7XZ2lyoqxFJI7mZG/nSysoG31CixW0XyoSPnF2Jru8GLKZFOyw3Ze2dnzgCv7zsQ3lHQAAnmUl90mf8ENODS7l/UznczLwTOucnSLUkc812DPzj6K8s3WGUkSUkWAEEX8/I0kcWB6fiHASzdoVDAquqJ9ODAgon/vkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=bJ1k6LCx; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="bJ1k6LCx"
From: Konstantin Andreev <andreev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1753362623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XR7D4r5m7BOcZfYF6Nf5+a53yKd7FbHvvfTY4ig0Ryc=;
	b=bJ1k6LCxyusfybFB65EJSbvATJ7xA232dlBVQWDEUUU478mgncwR7hNc4oiYnuv4oIkogY
	ANXMkpiZylEgOgOn289ugs5p+mEJbM9sesrsa+f9BvpdCs56apyTWZOB6Gk+wQdnkv2iyZ
	qF9d5q+HYbrlPOPg9VdBCoDWshAFZxw=
To: casey@schaufler-ca.com
Cc: linux-security-module@vger.kernel.org
Subject: [PATCH 14/19] smack: return EOPNOTSUPP for setxattr() unsupported SMACK64(TRANSMUTE)
Date: Thu, 24 Jul 2025 16:09:47 +0300
Message-ID: <4c7cf8accc533becc52ff2576069e3c8b6b9df21.1753356770.git.andreev@swemel.ru>
In-Reply-To: <cover.1753356770.git.andreev@swemel.ru>
References: <cover.1753356770.git.andreev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SMACK64TRANSMUTE is supported only for directories.

"The standard return value for unsupported attribute names is
 -EOPNOTSUPP, as opposed to undefined but supported attributes
 (-ENODATA)" [3]

Smack follows [4] the convention
for get/setxattr() SMACK64IPIN/IPOUT

It is more appropriate to return -EOPNOTSUPP
instead of -EINVAL when attempting to set SMACK64TRANSMUTE
on a non-directory object.

A Unix domain socket (UDS) with a BSD address, and
the inode of a socket file descriptor (sockfs inode)
have fixed (*) nominal SMACK64 label [2]

Likewise, it is more appropriate to return -EOPNOTSUPP
instead of -EINVAL when attempting to set
the SMACK64 xattr on either type of socket inode.

The commits being fixed [1,2] are recent enough
so this change should not break userspace.

[1] 2023-11-16 roberto.sassu
Fixes: 9c82169208dd ("smack: Set SMACK64TRANSMUTE only for dirs in smack_inode_setxattr()")
Link: https://lore.kernel.org/linux-security-module/20231116090125.187209-2-roberto.sassu@huaweicloud.com/

[2] 2025-06-16 andreev
Fixes: 78fc6a94be25 ("smack: fix bug: invalid label of unix socket file")
Link: https://lore.kernel.org/linux-security-module/20250616010745.800386-6-andreev@swemel.ru/

[3] 2016-09-29 agruenba
commit 971df15bd54a ("sockfs: getxattr: Fail with -EOPNOTSUPP
                      for invalid attribute names")

[4] 2008-02-04 casey
commit e114e473771c ("Smack: Simplified Mandatory Access Control Kernel")

Signed-off-by: Konstantin Andreev <andreev@swemel.ru>
---
 security/smack/smack_lsm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 6712fa047722..113371887b4d 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1412,7 +1412,7 @@ static int smack_inode_setxattr(struct mnt_idmap *idmap,
 		 * UDS inode have fixed label
 		 */
 		if (S_ISSOCK(i_mode))
-			return -EINVAL;
+			return -EOPNOTSUPP;
 	} else if (strcmp(name, XATTR_NAME_SMACKIPIN) == 0 ||
 		   strcmp(name, XATTR_NAME_SMACKIPOUT) == 0) {
 		/*
@@ -1429,8 +1429,9 @@ static int smack_inode_setxattr(struct mnt_idmap *idmap,
 			return -EOPNOTSUPP;
 		task_label = true;
 	} else if (strcmp(name, XATTR_NAME_SMACKTRANSMUTE) == 0) {
-		if (!S_ISDIR(i_mode) ||
-		    size != TRANS_TRUE_SIZE ||
+		if (!S_ISDIR(i_mode))
+			return -EOPNOTSUPP;
+		if (size != TRANS_TRUE_SIZE ||
 		    strncmp(value, TRANS_TRUE, TRANS_TRUE_SIZE) != 0)
 			return -EINVAL;
 		label_inside = false;
-- 
2.43.0

