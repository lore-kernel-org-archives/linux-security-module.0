Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A77728F3;
	Tue, 21 Jan 2025 02:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737427526; cv=none; b=WGnXuLBSBGIC/UUC5w576IH++aqVm6Z9at3/Cec11ti2aLRd8KdnGBE5AhkaNhwf/jzWW5hxY4obXkfF83EaUj7VIjELi6cBQ/kkyDS28UFbT4L0AubMLFpA3pRKaMcV7Enh5X5q72KueWOgeyCJ/APylofFRAvcj+DtP4LGc2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737427526; c=relaxed/simple;
	bh=WWg9zguIBK7tKjnjXA6PhbaKw/Szzrm3ikrTStFtpxY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dNCsmHS/ecneoE7PRqkJqgPnbiTT7q+vILiPvaVcZNM7UChfx00aO30pb8sHK3r0XJQLpoWwwiuL5ifsHr7i8KdkIWvvqNFAUG/JPnLjWKQWOuhltk9Ouaju5J9docA4z9rCLu7lj7Fn3IigDkUjSTFNdOeHjv5vBAfecwqx4h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=dLpY89Vy; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="dLpY89Vy"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737427514; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=pY42hVw6mUF0wz+i2uxDA39JdWN+afSDGBx1iNI7ztI=;
	b=dLpY89Vy9P2kF4gf/4iykkB25zjdE8DwSQkN5oUfcEi+gexVmK9Nudg2XvAslJJbd7D7s5dwL89e4TH0uUkRIi1vMGD4sBpPYRmqaR4Z/Cb0kIshsDRSy8LoQa///WWOL6dcpznIo8pORKzI+ZWbFIeMiyJNAhsASDQvsphE9IU=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WO3joNO_1737427486 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 21 Jan 2025 10:45:14 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: john.johansen@canonical.com
Cc: paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next 2/2] apparmor: Modify mismatched function name
Date: Tue, 21 Jan 2025 10:44:43 +0800
Message-Id: <20250121024444.88981-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional modification involved.

security/apparmor/lib.c:93: warning: expecting prototype for aa_mask_to_str(). Prototype was for val_mask_to_str() instead.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=13606
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 security/apparmor/lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/lib.c b/security/apparmor/lib.c
index dd5dcbe5daf7..325f26f39a63 100644
--- a/security/apparmor/lib.c
+++ b/security/apparmor/lib.c
@@ -82,7 +82,7 @@ int aa_parse_debug_params(const char *str)
 }
 
 /**
- * aa_mask_to_str - convert a perm mask to its short string
+ * val_mask_to_str - convert a perm mask to its short string
  * @str: character buffer to store string in (at least 10 characters)
  * @str_size: size of the @str buffer
  * @chrs: NUL-terminated character buffer of permission characters
-- 
2.32.0.3.g01195cf9f

