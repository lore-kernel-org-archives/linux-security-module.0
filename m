Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CF51E9B20;
	Sun,  2 Mar 2025 16:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740931627; cv=none; b=Ybb3qzCCWZiXML6Axp89w7i4oIPUlJIBQmdemEEfUVJIxz7fG4slO6d8l3ir170x5mps2P0ZVx+dH9b+cp9OeeR3gK+9dX3ktfnxga918L8sbYTlAXb80HTebUJcE3BLT9YV8YJ+q8X4lK/NK6y9jhmGYMuWQaqL0tmRbk+AR1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740931627; c=relaxed/simple;
	bh=Jl1OONU/HPYf7/P1zk30SJXk1bcmft8tcRaTvFtTY6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QApefA4HTuoAd9f0AJBi7RhALpr+Bkm4WoLrwG5rFW1BXluK5xtAjHKpLsqPNDmMqtbsIvcM2QOlGxnQ5UDxlAyqa9PC0H0OgE8N0Zp9Fs1rtV+pUBZnfrA0syt+WYmvGxDDmAj2gavKUGxnsfkRC0m166Lx8usprUH1LT9S6/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=PiWSfiie; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="PiWSfiie"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1740931622;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=O6DE7DCpJw4TB8feyeSd8BWfUFVAmf0EuvvRwHMeulI=;
	b=PiWSfiieggVS+NN774Yowdm3BHp08bxuRLv4yBIU7WPvptO1S3gmmiHLeYXYmtpJQbuxHE
	tl+oUyQ+zI2i7B8Fn2bEToyS9YLGcjJU2dHkRupFBaT4ALGWcaV8pJowicqwQQlvB2W4ql
	MxoMfrj07KDalLy6DIrunO6hBwM8CcszdwW65tv2rj1krx1nyFWPyI4gvzcL9r7FVn78E/
	jlYF4VMCNL/G7PK40V/u0UhZOFkGs/jnixY6Rm+Q0yggOaJszuLy5jRKKljTFboNhwyxMX
	spm1dWYccPY499VqDlbImT/va1d+AtfepabQe8ew7e7bZ+uTckZrB8diqJ8DEg==
To: 
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Serge Hallyn <serge@hallyn.com>,
	Jan Kara <jack@suse.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	cocci@inria.fr
Subject: [PATCH v2 02/11] quota: reorder capability check last
Date: Sun,  2 Mar 2025 17:06:38 +0100
Message-ID: <20250302160657.127253-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

capable() calls refer to enabled LSMs whether to permit or deny the
request.  This is relevant in connection with SELinux, where a
capability check results in a policy decision and by default a denial
message on insufficient permission is issued.
It can lead to three undesired cases:
  1. A denial message is generated, even in case the operation was an
     unprivileged one and thus the syscall succeeded, creating noise.
  2. To avoid the noise from 1. the policy writer adds a rule to ignore
     those denial messages, hiding future syscalls, where the task
     performs an actual privileged operation, leading to hidden limited
     functionality of that task.
  3. To avoid the noise from 1. the policy writer adds a rule to permit
     the task the requested capability, while it does not need it,
     violating the principle of least privilege.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
Reviewed-by: Serge Hallyn <serge@hallyn.com>
---
 fs/quota/dquot.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 825c5c2e0962..5c56babf581c 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -1283,9 +1283,9 @@ static int ignore_hardlimit(struct dquot *dquot)
 {
 	struct mem_dqinfo *info = &sb_dqopt(dquot->dq_sb)->info[dquot->dq_id.type];
 
-	return capable(CAP_SYS_RESOURCE) &&
-	       (info->dqi_format->qf_fmt_id != QFMT_VFS_OLD ||
-		!(info->dqi_flags & DQF_ROOT_SQUASH));
+	return (info->dqi_format->qf_fmt_id != QFMT_VFS_OLD ||
+		!(info->dqi_flags & DQF_ROOT_SQUASH)) &&
+		capable(CAP_SYS_RESOURCE);
 }
 
 static int dquot_add_inodes(struct dquot *dquot, qsize_t inodes,
-- 
2.47.2

