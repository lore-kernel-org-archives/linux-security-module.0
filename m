Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377CE34FF62;
	Fri, 17 Apr 2026 17:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776448698; cv=none; b=GQNlNWr7MYbj6l1ogyg7TMG9mqdh+PUdA9GzJPxDJbXc5rmwYPylL/xkgFBi8y02ogcl9n3rZQZGQ0dlNdYYkV9Y22WPjIxp+KWm3JB1V6wu8zCyTyh4mUpvYGJSo0Qmq0TbcH9so9v5XsVFj5reW+hJNB/5MJciVbgGTmNYeTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776448698; c=relaxed/simple;
	bh=OznS5k+Y9tBwswJLbKpzM/l10Fd+kOv7XSaKZ/Nsp/A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TCY4OO+9qQBtmLluHXlcACxFrmR2ESMtQIPzXbOM5jTBn90c0xMb2btBCEWaxq+qUL7jHe2OzAFP7W8F9ZbJkKZ9I9IQ3mMenB1IfLlTm2mzgfMu5gGt6c9psmHeu00T2YfFBYegCKnHUsU0SP/9fzBZxEnY4um3RvFHJkp+sOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=KD6wLOy3; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="KD6wLOy3"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD1251D70;
	Fri, 17 Apr 2026 10:58:09 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 31E563F7D8;
	Fri, 17 Apr 2026 10:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1776448695; bh=OznS5k+Y9tBwswJLbKpzM/l10Fd+kOv7XSaKZ/Nsp/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KD6wLOy3E7HTI+2ROb0L8q+IvHNRcfw8dyUJ/3sjB3mKLsebV+E/FDlTtn4k73EW3
	 CtWJVnAlL1JGRCVWAMM+bw/M+1RabxCbjEUD2nsbDxFEy+GG+vUJhpjXofMiRezwnJ
	 cYN9pFXK8e4HOnZZA8LUXSNFNUZ73nNf39F6Jv2c=
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev
Cc: paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	peterhuewe@gmx.de,
	jarkko@kernel.org,
	jgg@ziepe.ca,
	sudeep.holla@kernel.org,
	maz@kernel.org,
	oupton@kernel.org,
	joey.gouly@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [RFC PATCH 3/4] firmware: arm_ffa: revert ffa_init() initcall level to device_initcall
Date: Fri, 17 Apr 2026 18:57:58 +0100
Message-Id: <20260417175759.3191279-4-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417175759.3191279-1-yeoreum.yun@arm.com>
References: <20260417175759.3191279-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 0e0546eabcd6 ("firmware: arm_ffa: Change initcall level of ffa_init() to rootfs_initcall")
changed the initcall level of ffa_init() to rootfs_initcall to address
an issue where IMA could not properly recognize the TPM device.

However, this introduces a problem: pKVM fails to handle any FF-A calls
because it cannot trap the FFA_VERSION call invoked by ffa_init().

Since the IMA init function level has been changed to late_initcall_sync,
there is no longer a need to keep ffa_init() at rootfs_initcall.
Revert it back to device_initcall.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index f2f94d4d533e..02c76ac1570b 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -2106,7 +2106,7 @@ static int __init ffa_init(void)
 	kfree(drv_info);
 	return ret;
 }
-rootfs_initcall(ffa_init);
+device_initcall(ffa_init);

 static void __exit ffa_exit(void)
 {
--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

