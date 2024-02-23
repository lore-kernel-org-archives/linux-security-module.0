Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [45.157.188.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D979146E70
	for <linux-security-module@vger.kernel.org>; Fri, 23 Feb 2024 20:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708719578; cv=none; b=B5DHZlbBaEou+CbjSnTbfsSkY1N4/9JTvebZll+XLprf1QYI1CnbnDxrEQUEgMpylyAHlavLAKe8y4MtUB3G9q60TARoPNeCHV9tOlG+FsSK7y4eVqG2hp/DTfA04qyWh8hXaqqlLJiJ9ESd0uP451gdj0AvIJ7rQI0ppF7h1i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708719578; c=relaxed/simple;
	bh=qpzM6NBYR7WpVcp9/HBiZFKK8JElis+2lrx2b9BJFms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nttgu6UsMPU1V4vZoWRMXweCu1rhA1BTywMUuOxKmZtB0eeHvNyC8WaVMB22xDnBS4DXV2nmTacaz9OART+KHE3y12KH813CXnxqrfhhP/D2hyFP/8arNVqBUcrKPPpPRzzo3ofZYdt5s+jCnV5npCB9GrW9Uo5yx3L90tL9JXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=1N9Om1Cl; arc=none smtp.client-ip=45.157.188.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="1N9Om1Cl"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ThKGt4rmsz2TC;
	Fri, 23 Feb 2024 20:05:58 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4ThKGs49MCzjsT;
	Fri, 23 Feb 2024 20:05:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1708715158;
	bh=qpzM6NBYR7WpVcp9/HBiZFKK8JElis+2lrx2b9BJFms=;
	h=From:To:Cc:Subject:Date:From;
	b=1N9Om1ClO+r+L8Qkam4EJkqyN1SiVBZqs5lER3lgzN2iIjXSyXKUsBnEwslb1urAP
	 jw9IIgIu8sDs1Q4U5Oe/6uKx2AlVRr4rQwt/lIGGpkjJ1kHax1FNIiJsD+DMzXzo78
	 KnimjfuRbCak8dfFUJl1/GYfQfvSCPQEYotFWX+c=
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Casey Schaufler <casey@schaufler-ca.com>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] SELinux: Fix lsm_get_self_attr()
Date: Fri, 23 Feb 2024 20:05:45 +0100
Message-ID: <20240223190546.3329966-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

selinux_lsm_getattr() may not initialize the value's pointer in some
case.  As for proc_pid_attr_read(), initialize this pointer to NULL in
selinux_getselfattr() to avoid an UAF in the kfree() call.

Cc: Casey Schaufler <casey@schaufler-ca.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: stable@vger.kernel.org
Fixes: 762c934317e6 ("SELinux: Add selfattr hooks")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/selinux/hooks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index a6bf90ace84c..338b023a8c3e 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6559,7 +6559,7 @@ static int selinux_getselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
 			       size_t *size, u32 flags)
 {
 	int rc;
-	char *val;
+	char *val = NULL;
 	int val_len;
 
 	val_len = selinux_lsm_getattr(attr, current, &val);
-- 
2.43.0

