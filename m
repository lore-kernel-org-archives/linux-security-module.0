Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B8B1426C;
	Mon, 25 Nov 2024 10:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732531236; cv=none; b=EWuKFtJbUE2AdFPp8xBuvnkcewWG4rBIiciA+U9oBsqHt95nBo3hhO6W1+7IslQFtjqyFLURr4BNl9FV3/yD4aukBPTb9C9ohAvEieHPN2Rwvwjk5KTZ6duyLoZhH300xFS1kQnVYxba8piciX19lQj9Bd74prmbxMrQlrDykZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732531236; c=relaxed/simple;
	bh=RiX1qAPwXOtMydW3Bf48L9hzhNoJhOnr+55MkoLjnyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WEwHpd2b7xsN4Fgak6CTMmG++kOi5KWJ05g4X5RrR6O5StsoQtgUgso74HRldCr2hb/Dsue/GwgkWSyOoB477BQ0X89IDHT6SzYJIUwUcMbiHVN8J0tNcTcvJypfQYIDOCgI4pxlkCNTKIWAB0A8zWKT3XNXg1xPiBS4+S755t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=Mdb4xOeL; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="Mdb4xOeL"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1732531225;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uXJbjp9TEMr3wvQ+2vZpGMNVJ7tkSZTdw7fouyXGnz0=;
	b=Mdb4xOeLmRxHgooUx3JOijX3+LMSlj4GRxvTHEPWd1og60SnG27YZkYD2Ceyjx+7B333QM
	ZyLgYWtMHFmpAS4jQ0VS7zdfJq9cQ9qMI1VXAh2OJqLOjuiladwhEQxhs5QkMpM4d+88/j
	YY61kw6/zF9K2N5hNSbT40SYIj6CvC8CdzV+bU9xHoZrZXIDj3azO4Pssrl2ovpBnSmIzD
	Mv0etwsaWtD04zX2lsGfDFSxo61zYM7APvut1Mn8G6dTOzCPF4BW7lPtuQElc1iacTmQXf
	8qW38Pn8ScwYATLiIG45X5y8yS2CZ7A99XQg1RtL/r9qa9EeW8r4/TzXlS2Ylw==
To: linux-security-module@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Muchun Song <muchun.song@linux.dev>,
	Serge Hallyn <serge@hallyn.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	cocci@inria.fr
Subject: [PATCH 04/11] hugetlbfs: reorder capability check last
Date: Mon, 25 Nov 2024 11:39:56 +0100
Message-ID: <20241125104011.36552-3-cgoettsche@seltendoof.de>
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
 fs/hugetlbfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index a4441fb77f7c..e4f6790c1638 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1508,7 +1508,7 @@ static int can_do_hugetlb_shm(void)
 {
 	kgid_t shm_group;
 	shm_group = make_kgid(&init_user_ns, sysctl_hugetlb_shm_group);
-	return capable(CAP_IPC_LOCK) || in_group_p(shm_group);
+	return in_group_p(shm_group) || capable(CAP_IPC_LOCK);
 }
 
 static int get_hstate_idx(int page_size_log)
-- 
2.45.2

