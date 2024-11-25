Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABDD193064;
	Mon, 25 Nov 2024 10:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732531235; cv=none; b=b6Dlejcz4+ob6Bd7VijiV4UqjR3JWR81dvN+oTlQ4o4mWtA8Ik5hRYAmX+keFmutjLGUZHytYtwtMkf/zOkerkc0ce1jF6ohmUJ5FQSvuzfyOGg3uONBJCb4NZYi4K/baQpQ8ZCUIaBWCQgqbsAC/hV9rzVcsrXVq0p1Ygi9TP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732531235; c=relaxed/simple;
	bh=VhnL2wmSb+pfgIHkp6bvcyX/tRAnbRI3P76lLhLZZrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JiNoiifgIoHbhXMbwzVc84NbL/ueGpyiXMo0OIroByecsPjdnrm5vd5jcxXe8dyjPvMvVEZ2VbOC88jDu9NgKO1OwmJFlSffhViatZdzg0GPXA0XeGKjP4NPyiUeBL36UoyHLfxV1JTBc2DU3bBJ9pd+li0DJOi6wUkFqa6RfM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=renzaNjY; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="renzaNjY"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1732531230;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BnJPwZBINKy4LES6pr7BNEYT4c7M8sYvf1DiqcmfvZQ=;
	b=renzaNjYJ9YJyG9gUtmjWqJwQ0VY7TQPB8AIE5W2eHdeqh2KtO/X4RlDCy1my/SVpQmQbZ
	wjNEjBd+3Nx5SYzGSi/4OwNEhlCfesxm4VNww0jT0OEYCfKsxUBHnyqFZjs4qmm0yXdPXf
	JQVxhmVSoR7oSv45zcTLYW4BjQnZhX+TQ9oYJfvSmhOwIXh5wbGCNS9yLVPQ//3K2TAHgl
	Eb4e91BrZZEw09F7m/z/76uD9fpDEgjnOst+2rcsjNChNW2KdjtqLgROIapy8OMfgZI/BW
	MreOsqodNcQhtkdGSCQM3CtyEM177zZSZrrnzTyeG6viMRNF26psOPQLgVZyPg==
To: linux-security-module@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Richard Weinberger <richard@nod.at>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Serge Hallyn <serge@hallyn.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-mtd@lists.infradead.org,
	cocci@inria.fr
Subject: [PATCH 06/11] ubifs: reorder capability check last
Date: Mon, 25 Nov 2024 11:39:58 +0100
Message-ID: <20241125104011.36552-5-cgoettsche@seltendoof.de>
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
 drivers/gpu/drm/panthor/panthor_drv.c | 2 +-
 fs/ubifs/budget.c                     | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index ac7e53f6e3f0..2de0c3627fbf 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -791,7 +791,7 @@ static int group_priority_permit(struct drm_file *file,
 		return 0;
 
 	/* Higher priorities require CAP_SYS_NICE or DRM_MASTER */
-	if (capable(CAP_SYS_NICE) || drm_is_current_master(file))
+	if (drm_is_current_master(file) || capable(CAP_SYS_NICE))
 		return 0;
 
 	return -EACCES;
diff --git a/fs/ubifs/budget.c b/fs/ubifs/budget.c
index d76eb7b39f56..6137aeadec3f 100644
--- a/fs/ubifs/budget.c
+++ b/fs/ubifs/budget.c
@@ -256,8 +256,9 @@ long long ubifs_calc_available(const struct ubifs_info *c, int min_idx_lebs)
  */
 static int can_use_rp(struct ubifs_info *c)
 {
-	if (uid_eq(current_fsuid(), c->rp_uid) || capable(CAP_SYS_RESOURCE) ||
-	    (!gid_eq(c->rp_gid, GLOBAL_ROOT_GID) && in_group_p(c->rp_gid)))
+	if (uid_eq(current_fsuid(), c->rp_uid) ||
+	    (!gid_eq(c->rp_gid, GLOBAL_ROOT_GID) && in_group_p(c->rp_gid)) ||
+	    capable(CAP_SYS_RESOURCE))
 		return 1;
 	return 0;
 }
-- 
2.45.2

