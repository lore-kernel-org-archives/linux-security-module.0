Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD48086338
	for <linux-security-module@vger.kernel.org>; Mon, 16 Jun 2025 01:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750036081; cv=none; b=O2Z0CH9BtyPlJlaYiK547QRcjt7IY3T6vjZuNCjH/+U3hosbYq4c0SaDyeEfF0KfUMqD29B0roG5OAjoO5IawYQb4NXd00AjErMfO7uBxRaZomzx/V9q8i2D52KdctRDW4xdarIr9qxlmBsfI+B/Fo5Sfpp17SEOnBPQVRQh68w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750036081; c=relaxed/simple;
	bh=Sidm6+zvHHO97t2ggZN50DdRkq5Ink2NatsjB1Dhg1I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X03SJwQz/C9ZEpaUR53PgBMCqCJ3HLaiK6mnzFbTdkAR3Lv/z0EOHWM4erzeo2UCDx4fFKnxyACmlzzVzLOgkTgNFj1t9+87xWpZNeUgTIai6VG/RMR0b5FpqT38yEeQsVQW/+ZBUDUDq/xfVz7FdAbEQNaUAYkLej1P/s5j/Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=FwvmhQmF; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="FwvmhQmF"
From: Konstantin Andreev <andreev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1750036068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CQOJKFt0XJwlesjdDmoRHs32bbjZpBfNnZubEnLKU7U=;
	b=FwvmhQmFYJO/uAqdBvJrg14Ysa8VdWU9zYwdtv+4dboPtztf7k1QnW1+5Z9SKmyU5tDuaE
	6apI1/JcaQ5lkjvFFnQzxknxrVLi3FL/NFpdihiPussKudB0Gwm4qa8ubi/nCYMlU5x/Ek
	lDTD8OBb85bT6K6PXiaCitbnoMCsy50=
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org
Subject: [PATCH 0/5] smack: fix bugs: invalid unix socket label, invalid transmute attr
Date: Mon, 16 Jun 2025 04:07:27 +0300
Message-ID: <20250616010745.800386-1-andreev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Formerly, Smack inode security was initialized
by smack_d_instantiate() for all inodes,
except ones under /proc

Commit [1] imposed the sole responsibility for
initializing inode security for newly created
filesystem objects on smack_inode_init_security().

However, smack_inode_init_security() lacks some logic
present in smack_d_instantiate().

This patch series fixes 2 particular omissions
I faced directly:

1) special handling of unix socket files (5th patch)
2) S_ISDIR check for "transmute" xattr (2nd patch)

I did not check for other omissions,
but there may be ones.

Patches 1,3,4 are necessary optimizations
in smack_inode_init_security() made along the way.

I structured the changes this way to make the review
process easier.

The patch set applies on top of:
https://github.com/cschaufler/smack-next/commits/next
commit 4b59f4fd0a36

[1] 2023-11-16 roberto.sassu
commit e63d86b8b764 ("smack: Initialize the in-memory inode in smack_inode_init_security()")
Link: https://lore.kernel.org/linux-security-module/20231116090125.187209-5-roberto.sassu@huaweicloud.com/

Konstantin Andreev (5):
  smack: deduplicate "does access rule request transmutation"
  smack: fix bug: SMACK64TRANSMUTE set on non-directory
  smack: deduplicate xattr setting in smack_inode_init_security()
  smack: always "instantiate" inode in smack_inode_init_security()
  smack: fix bug: invalid label of unix socket file

 Documentation/admin-guide/LSM/Smack.rst |   5 +
 security/smack/smack_lsm.c              | 159 +++++++++++++++---------
 2 files changed, 107 insertions(+), 57 deletions(-)

-- 
2.43.0

