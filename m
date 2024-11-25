Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D654194AEE;
	Mon, 25 Nov 2024 10:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732531238; cv=none; b=pUBR5sxmDjKMewZKTmdhGw2lr6DghJ2bQUTkKVp/vrrVNr+dn1ocThhA4S5BTvoK4SeV/g0MZkN7at5f7nL/ZO3gSOG2hnSRF3FNO1bMC02DxYl9sk9XxH/Guphd0wZLk7cIVlopU9Y9Jhv5AAIXjkfbhqfQ4nxbQE4vv45hzk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732531238; c=relaxed/simple;
	bh=sqRRylGkLtbdHiY0aJnVCbtjNbB4VGS+linaOHS6NsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jf/HXENEzliS5uJPlhsNyJIJy6mT5G/B2F9FhBLe5inYRb7bnh+Jt62DbFhg1UK+0J0loEs/YMx+B+cr8aH3wNJPzvhy24hjo5fHS/s3KWeMG5yJhvHscuNruqcwH/9uaGPfKD3ed9Gzec7aoK49lbjSaV6mNzjM10VAVaSZISU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=htLbeYks; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="htLbeYks"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1732531232;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wEUm66qIu8PkMwOxCNnnSHqwyJubiCsERAs4lb+4vxc=;
	b=htLbeYksaORg5/HvEg6PKAtZC4kv17t058Wj3CTukaT/twqcgszc31G/pliYnDXAeXwBbx
	QMLvNRwy/9JY/gwAElTZUIR+VhYroro5VjcvBj36kROIgytwGOorYZM1uE3ah7VuglSwNJ
	AJxkQfGe5n5pbNgcZ1Rwi9TZs8GGnAWKUcc1cdRJgOLc8JE647oNbHFT07b/NW6yQe/mw8
	9LPEjY1zZnx1vLvmbV8hw3+OasVI71Nk4ieD3f9NOoxnejq/Anz920QM/DOTM6uO7hcHXU
	5BCkR9dAKb3kUbIeYS+K2wGlLZ4Z+FtponRFMBmBu3IkMFi7cKP95/dBb8x2Cw==
To: linux-security-module@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Serge Hallyn <serge@hallyn.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	linux-kernel@vger.kernel.org,
	gfs2@lists.linux.dev,
	cocci@inria.fr
Subject: [PATCH 08/11] gfs2: reorder capability check last
Date: Mon, 25 Nov 2024 11:40:00 +0100
Message-ID: <20241125104011.36552-7-cgoettsche@seltendoof.de>
In-Reply-To: <20241125104011.36552-1-cgoettsche@seltendoof.de>
References: <20241125104011.36552-1-cgoettsche@seltendoof.de>
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
---
 fs/gfs2/quota.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/quota.h b/fs/gfs2/quota.h
index f462d9cb3087..988f38dc5b2c 100644
--- a/fs/gfs2/quota.h
+++ b/fs/gfs2/quota.h
@@ -44,8 +44,8 @@ static inline int gfs2_quota_lock_check(struct gfs2_inode *ip,
 	int ret;
 
 	ap->allowed = UINT_MAX; /* Assume we are permitted a whole lot */
-	if (capable(CAP_SYS_RESOURCE) ||
-	    sdp->sd_args.ar_quota == GFS2_QUOTA_OFF)
+	if (sdp->sd_args.ar_quota == GFS2_QUOTA_OFF ||
+	    capable(CAP_SYS_RESOURCE))
 		return 0;
 	ret = gfs2_quota_lock(ip, NO_UID_QUOTA_CHANGE, NO_GID_QUOTA_CHANGE);
 	if (ret)
-- 
2.45.2

