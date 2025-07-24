Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60366267B9B
	for <linux-security-module@vger.kernel.org>; Thu, 24 Jul 2025 13:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753363213; cv=none; b=CBQrnbMkIoQjeAJmJqz7terGNNqiLbU0/sJhOu9ypn4PpW96qs6qNVw4C6Mjuw3s53E201EJPpWx9ScpzCc6107fpLGNFZXhzmx/89Rj2LBFJRO3MoIPZBvw/g6G0YqdUByr+qcd1C5FFbWJ/AkHFMcspugN/ngebMziVce2BeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753363213; c=relaxed/simple;
	bh=oG/DsAwFDCTbp0l2B3usokGhizVfBRXogzvqsy+9VJg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BmuN+lxVpEDHhxcMuuOhcqQSHtDqk2VesBsxYyF7goNRm/XIQDY4LqbDN9siJDpg+L5eltKh7a/DYJk4j48Dv36qJaLr/RtE6TPhrI35ejc6OoH0C2EUc+bEK4j2KRbhrLyzjycIO14eW8ftQEH4EBWp+LRDZZPmsgmoOtHst2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=kg8Mz3R/; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="kg8Mz3R/"
From: Konstantin Andreev <andreev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1753362619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0Xox2g9UldDiSOWvjLLVt7vJF9+PobGEqyMI12P0Ot4=;
	b=kg8Mz3R/CCTf0Vjus5ZXDn/Aa+ews9JsyqxKxFR0dbqv0WOo9A9lDwq1t6KQPbHOWCSvrS
	1rAQjzQ3MgdC88QYFTKo43hS84xExcYUzU9fJ+znW/e8WRgfeHHone1Da1ZWi0uc+Ixsun
	boohuQjRWv6bnDCa52HLrgFp13XLLZ8=
To: casey@schaufler-ca.com
Cc: linux-security-module@vger.kernel.org
Subject: [PATCH 00/19] smack: clean up xattr handling
Date: Thu, 24 Jul 2025 16:09:33 +0300
Message-ID: <cover.1753356770.git.andreev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A set of minor bug fixes and optimizations in Smack xattr handling.
Logically independent, but with the code dependencies.

The patch set applies on top of:
https://github.com/cschaufler/smack-next/commits/next
commit 6ddd169d0288

Konstantin Andreev (19):
  smack: fix bug: changing Smack xattrs requires cap_sys_admin
  smack: fix bug: changing Smack xattrs requires cap_mac_override
  smack: fix bug: setting label-containing xattrs silently ignores input garbage
  smack: stop polling other LSMs & VFS to getxattr() unsupported SMACK64IPIN/OUT
  smack: restrict getxattr() SMACK64TRANSMUTE to directories
  smack: fix bug: getxattr() returns invalid SMACK64EXEC/MMAP
  smack: deduplicate task label validation
  smack: smack_inode_setsecurity: prevent setting SMACK64EXEC/MMAP in other LSMs
  smack: smack_inode_setsecurity: prevent setting SMACK64IPIN/OUT in other LSMs
  smack: fix bug: smack_inode_setsecurity() imports alien xattrs as labels
  smack: fix bug: smack_inode_setsecurity() false EINVAL for alien xattrs
  smack: restrict setxattr() SMACK64IPIN/IPOUT to sockets
  smack: restrict setxattr() SMACK64EXEC/MMAP to regular files
  smack: return EOPNOTSUPP for setxattr() unsupported SMACK64(TRANSMUTE)
  smack: smack_inode_setsecurity(): skip checks for SMACK64TRANSMUTE
  smack: smack_inode_notifysecctx(): reject invalid labels
  smack: smack_inode_post_setxattr(): find label instead of import
  smack: smack_inode_setsecurity(): find label instead of import
  smack: deduplicate strcmp(name, XATTR_{,NAME_}SMACK*)

 Documentation/admin-guide/LSM/Smack.rst |   3 +-
 security/smack/smack.h                  |   2 +
 security/smack/smack_access.c           |  22 +-
 security/smack/smack_lsm.c              | 492 +++++++++++++++---------
 4 files changed, 324 insertions(+), 195 deletions(-)

-- 
2.43.0

