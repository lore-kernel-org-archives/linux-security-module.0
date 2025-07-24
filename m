Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BC72D3721
	for <linux-security-module@vger.kernel.org>; Thu, 24 Jul 2025 13:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753362634; cv=none; b=KSFliG1n+ryzEHDj/CLIWbyyrp+5bnPQ2+gI88gC2vIUV3NMNiRFLJhmEia/a0IwhOkxzoNUYvKPAubK1QGDGrYHmeXa0v55HKGd5itwQJaKOnq2Ihd3zD4CPJ/A3kq3uVJdTMU+s6jjIHjUD7MZ8rgt+1cAVTlYV/Fr87PuLL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753362634; c=relaxed/simple;
	bh=lOTTH/Qc0HmxGauxNNeFoFC7h5jxPK0LWrL89EUIHjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c9ayyvQHjFB1MuFn/B+Ln70s2fEfIhTO/PqJ9BDp3cvCjLHhhPRhgfvuKNi3l+IS4dxUwhNMfZjH5L+mGloQ8qVAxqORHFss5Lc6RIj2RxBwalFvmK3+GqggRD/AlkfxTUz/KaERae/OLOWoAdHAX6xrQUE5ovdWzwXcUmmSi9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=QERzfTDQ; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="QERzfTDQ"
From: Konstantin Andreev <andreev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1753362621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IanpvhQAfF5yXDHV/ioD2kiXYbZgIfntdRC/HHefiiQ=;
	b=QERzfTDQpr7zgeS203PmRK1RI2qWh1cPycSX1GRAWqz9C96MSJCIfVPwbHCuj0B7m0xk2U
	OZwaJrWbE4uycuonmrYuJXwFSkvzto6iCgUbmX59K4O8xOAlWhROYq/s9oYP7riselpY+3
	nV8unxKvp/3WP92PcFfKCpbvhRmgBRM=
To: casey@schaufler-ca.com
Cc: linux-security-module@vger.kernel.org
Subject: [PATCH 05/19] smack: restrict getxattr() SMACK64TRANSMUTE to directories
Date: Thu, 24 Jul 2025 16:09:38 +0300
Message-ID: <231488ef06b6b129ed1120fcf04ec720eb9bef6f.1753356770.git.andreev@swemel.ru>
In-Reply-To: <cover.1753356770.git.andreev@swemel.ru>
References: <cover.1753356770.git.andreev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since [1], every filesystem object in the system
has a security.SMACK64TRANSMUTE xattr attached:
regular files, FIFOs, sockets, device nodes, and directories.

  # getfattr -n security.SMACK64TRANSMUTE /etc/passwd
  security.SMACK64TRANSMUTE=""
  # getfattr -n security.SMACK64TRANSMUTE /run/initctl
  security.SMACK64TRANSMUTE=""
  # getfattr -n security.SMACK64TRANSMUTE /run/udev/control
  security.SMACK64TRANSMUTE=""
  # getfattr -n security.SMACK64TRANSMUTE /dev/null
  security.SMACK64TRANSMUTE=""
  # getfattr -n security.SMACK64TRANSMUTE /etc
  security.SMACK64TRANSMUTE=""

Most of these values are blank (""), because the xattr
is not set for most directories, and is irrelevant for
anything else. Additionally,
blank is not a valid value for SMACK64TRANSMUTE.

Having an irrelevant xattr with an invalid value
on every filesystem object seems odd.

It is more appropriate to return -ENODATA
(no such attribute) for SMACK64TRANSMUTE,
if it is not set or irrelevant,
like for any other non-existent attribute.

[1] 2023-05-08 roberto.sassu
commit 3a3d8fce31a4 ("smack: Retrieve transmuting information in
                      smack_inode_getsecurity()")
Link: https://lore.kernel.org/linux-security-module/20230508170234.3595105-1-roberto.sassu@huaweicloud.com/

Signed-off-by: Konstantin Andreev <andreev@swemel.ru>
---
 security/smack/smack_lsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 7bd47baac481..7a27c554ac56 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1661,7 +1661,7 @@ static int smack_inode_getsecurity(struct mnt_idmap *idmap,
 		if (ispp->smk_flags & SMK_INODE_TRANSMUTE)
 			label = TRANS_TRUE;
 		else
-			label = "";
+			return -ENODATA;
 	} else if (strcmp(name, XATTR_SMACK_IPIN) == 0 ||
 		   strcmp(name, XATTR_SMACK_IPOUT) == 0) {
 		/*
-- 
2.43.0

