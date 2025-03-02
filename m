Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD041E7C32;
	Sun,  2 Mar 2025 16:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740931629; cv=none; b=LTkhffUlUO81UJpt29xuZXKkpK5mrtC9GEHYQ4JUUlw7g6PjZ2eSXMSv6tSFTv3PVVasczjquY9zwnxbPYIoVI88qbe0guMRb6ak6MPxkL5CoDGt7kCueU2hgWhI6yGRNLkGMxuKw8Uz+VDDLhhH2RugU/1r1UnannoDBAHvwQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740931629; c=relaxed/simple;
	bh=OLtEwpQ7kc/v2nO4iZrLWQivq+0Sn82iOiuaRwES+s8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cP4vh+qKsWYNu9yLzgpPg2GDPTl4ta9/VlF7IJDNhsDYUAVQHI6wPE9AVmTYBS5N+8S1avtaqX64yNGH7pq3jMa0TLNMfRbf+8QvsLyPMXwroWGDBgSGYXq0q3As2ZwPoD2/nB3aOQ1/yEqSWn5a6+DVdq4+wtTwV3edYOTw0Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=SdoKH+0E; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="SdoKH+0E"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1740931625;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=psW6cnDKJDfMxUnzR9ln5khjNnX+9pHtPh2iqMJCG30=;
	b=SdoKH+0EzYCBj4vtLHksHZyyUfjYZYKyFPGkljGjoi+IHVmwQJ3uge+Qp04jAU2zNFI1/r
	Dekh52KkrWPJJMvDFFExflW3hppm4mZV0sc15sZZK2HTv6+l5y3KhSCzHU3A5o3qYyULJv
	MZwMwXtHFShVOr28DbUn+7Ftijj5pjZb7fJH/BtLcuuvkqUnFqwiabiztFppznggEGbSmA
	6hd3QK1owK3/DJH0JeVy9v3vUAT3hZv04FH+cEaTKd7APURmHNhTWRbHEhkSKYohna2m0j
	Ej2/5LFCvfcNkzt4mOEXcBtGX4Dy+dqNKXoJTGBtjw9zV0U+RefdjINmHf0O+Q==
To: 
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Serge Hallyn <serge@hallyn.com>,
	Jan Kara <jack@suse.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	cocci@inria.fr,
	Muchun Song <muchun.song@linux.dev>,
	linux-mm@kvack.org
Subject: [PATCH v2 04/11] hugetlbfs: reorder capability check last
Date: Sun,  2 Mar 2025 17:06:40 +0100
Message-ID: <20250302160657.127253-3-cgoettsche@seltendoof.de>
In-Reply-To: <20250302160657.127253-1-cgoettsche@seltendoof.de>
References: <20250302160657.127253-1-cgoettsche@seltendoof.de>
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
 fs/hugetlbfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 0fc179a59830..e36b0e6df720 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1503,7 +1503,7 @@ static int can_do_hugetlb_shm(void)
 {
 	kgid_t shm_group;
 	shm_group = make_kgid(&init_user_ns, sysctl_hugetlb_shm_group);
-	return capable(CAP_IPC_LOCK) || in_group_p(shm_group);
+	return in_group_p(shm_group) || capable(CAP_IPC_LOCK);
 }
 
 static int get_hstate_idx(int page_size_log)
-- 
2.47.2

