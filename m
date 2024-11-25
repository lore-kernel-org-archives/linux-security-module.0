Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9FB192D70;
	Mon, 25 Nov 2024 10:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732531234; cv=none; b=I7h1Hs2DAKJAfbJ2MUd2aqPl6bvM8iXjH3oJ2ry/tX3Lw3AtFP/Auvoq0m+2Fu7NW+oOqmNL2hhRIJMte9tohN0ifjg2ZqRO6V+86uncEW10nkhp2cCrTE6H6o7f7NYVq5Y/qjcAFRUcCV4iw96CF+FhBbFWPf8+WqHZYSSf65I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732531234; c=relaxed/simple;
	bh=/RTyild0b7BT+76FJnjYMZVk+Wy7NGYbYU493r0v9V0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Eoo6EvbHoZTW5hiYhdp3fTNN5oxajpp0CRRUl77T3j23x5+8lqG8mvda5PvndlhDovwFOVrLekethEuQfoe6oT86fqaQBBSqg3/BRRg+I70QdYY6uiGdVvqe6w6trTOEdYTCmUM2TdxLGEZqkjaNG+mhPtQZq8J7Yhwt81D7spA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=jFlHUnSJ; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="jFlHUnSJ"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1732531222;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=17lhHTnnZGmrh/UycwQ7pmOcwP/SDxseygpcnk52sbc=;
	b=jFlHUnSJvVahXsR69S9gj5XhwOZOsx5mApFRT8497wpNJyGwwA7cfg7pEHClwY3EqMnwJS
	16s13rukrF0jxcnU4oJZse0adk+QnpoVnIrLGjWT3Z3v1hqD0/rz3cKNL4icom2QnisO+O
	52mTcwDrpYGSSIO5tMsUSRk249MQUpqXOxopVq4MvMOHI2hNIrgmXrIQ4lMEIPLvaLvo1o
	eil+6vDCkSBuqJtZei1xOBeQ6SmFf5x8awUZo6AhLqGdzAdbtqT6DNM4/LYTdsN+RzomRg
	Pa94yEk0S+pz6JHp2rzZRP/L46XO6/mQecqyF7JlaS9Ty2QdWS9rygJkL3FXeA==
To: linux-security-module@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Jan Kara <jack@suse.com>,
	Serge Hallyn <serge@hallyn.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	linux-kernel@vger.kernel.org,
	cocci@inria.fr
Subject: [PATCH 02/11] quota: reorder capability check last
Date: Mon, 25 Nov 2024 11:39:54 +0100
Message-ID: <20241125104011.36552-1-cgoettsche@seltendoof.de>
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
 fs/quota/dquot.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 3dd8d6f27725..a2dddffeaac5 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -1281,9 +1281,9 @@ static int ignore_hardlimit(struct dquot *dquot)
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
2.45.2

