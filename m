Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DA823185E;
	Fri, 25 Jul 2025 09:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753437188; cv=none; b=ObibtdGVd/IuNlCGTN1p6OOWlM3zsxP/Ne1Cf4E+1pRwd7Z+kHaSSS72//H2b+SNHx3GYIbZKZN7GZ7L5HJiS/V4XXBNTrkyFAlzF2t5Nu7k1WeBSYrCShbykNqZS3XZfjdlwUBwW8mvyXl530A2XNs9YW3vTuqMjv1QGL4LarE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753437188; c=relaxed/simple;
	bh=Ugwk177H13GcpEHnEZCYmDha3qG6S8aQHSPAtlIMn6w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sbXoiCbf+v1iR+33nGEddj4pivDEzs92kfXslAu1F317k1usqVC7c4z8/550QyGaHnt9M1F6a/CzoerNp3248ZQlBKRGlYBSm7TDwuibJ9blIXdw1rEHH4YbzjTzWwuH3yOTdlUBAC3Ps0HRsFkfy4JHCSArqSf+9PO4s0eLz5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NgY/jneK; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NgY/jneK"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753437180; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=p06ac9oRSfMx4GRg8V1UKlF3V+R9G5Xp2LW5+k6ETns=;
	b=NgY/jneK5Ld8QaiNkINv/zXu24jRCfK2bbDphscdE1rLuOFDyW66FaKzOqf3VylWk+8Y1fHmLHqjTiNmr9hu/AI8lvj5Le9xJOXbjgp9wQ7JCtU9LPiZHt2OBZ9PHJyTZrWmkJeN7iz6IZ2xKUkFhQ2vCKVaEDtlmYhrSqRU0Is=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WjxlLh2_1753437173 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 25 Jul 2025 17:52:59 +0800
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
Subject: [PATCH -next] apparmor: Remove the unused variable rules
Date: Fri, 25 Jul 2025 17:52:52 +0800
Message-ID: <20250725095252.2087274-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Variable rules is not effectively used, so delete it.

security/apparmor/lsm.c:182:23: warning: variable ‘rules’ set but not used.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=22942
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 security/apparmor/lsm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 5b1b5ac831e8..182a0e55802e 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -179,10 +179,8 @@ static int apparmor_capget(const struct task_struct *target, kernel_cap_t *effec
 		struct label_it i;
 
 		label_for_each_confined(i, label, profile) {
-			struct aa_ruleset *rules;
 			kernel_cap_t allowed;
 
-			rules = profile->label.rules[0];
 			allowed = aa_profile_capget(profile);
 			*effective = cap_intersect(*effective, allowed);
 			*permitted = cap_intersect(*permitted, allowed);
-- 
2.43.5

