Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E793E6DCE
	for <linux-security-module@vger.kernel.org>; Tue,  9 Jun 2026 21:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.41.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781039767; cv=none; b=KEb252F7D423cO29pzSCJcgYXt7z40/fwlheuqXi6T/Zqq+SkGsZe8zzpbPDE6wVOEbNdTcxT+Dxd7m6gMeXggeWIWfrbcOCXa8t+VF2Wwd/TCMWphEp1ovJAFunlY4zYogfPqcnAaM2tGP162aD/sNXV5zJ7drQ4AH7xm46fVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781039767; c=relaxed/simple;
	bh=8esrGjXXtoSnqAOGFZcIVkj5YFacFT0gd/wFzNrQOK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OmsR2M/8d3P9h9gat5mAjGL8ovVrghmoMFHBOtHmIB6rUR5TmAb86KTJfRD36qI8LSfmY9kE+qqdFOQMDJmTCh5OoQXfiNy3Ln1IgcDo0E6KgXdS2f6ta7K+/y3M36/cFyva2t+vdOxBUykcZHHNgnHs3DCOQmV2yML4NjngJ4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=dTHu2cjH; arc=none smtp.client-ip=51.83.41.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buffet.re
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b="dTHu2cjH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1781039758; bh=8esrGjXXtoSnqAOGFZcIVkj5YFacFT0gd/wFzNrQOK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dTHu2cjHnPG1edHRybDETXwHf4K4cPTc4FP9KPAc3tJPA2wWO1dtCKgj+0NEb0s9e
	 2Hf8cwJHSQMcMcueLrtEWTv4XZOqjBlautZqWrLNff/zNRDEcSxA8zAxwlbaREIkW3
	 DQ/FR9xGkGEHHZN11DJwiO2FJokIBW9Ck3qhj1SVQkHAI5r3nR142vOLkWAFlLqDC2
	 NELXXLlHzEW2ZyKKhoQFwyaJvCv5WOvGO8ADyqIleZbmxyAsogaL/C4wX/Vm5TyxGC
	 XjCYOvDXeHA9HVWyxJ68p3k8T4zn9AvhDxxU3vLvaiq/JABvDWy4VFK+A7Kf0nzcHB
	 mkNqoSHaYOtHA==
Received: from localhost.localdomain (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPSA id 06509125933;
	Tue,  9 Jun 2026 23:15:58 +0200 (CEST)
From: Matthieu Buffet <matthieu@buffet.re>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Matthieu Buffet <matthieu@buffet.re>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Tingmao Wang <m@maowtm.org>,
	konstantin.meskhidze@huawei.com,
	linux-security-module@vger.kernel.org
Subject: [PATCH 2/2] landlock: replace __sk_common struct sock field accesses
Date: Tue,  9 Jun 2026 23:15:11 +0200
Message-ID: <20260609211511.85630-2-matthieu@buffet.re>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260609211511.85630-1-matthieu@buffet.re>
References: <e561a8c3-de10-45ba-a931-27b9a5751dc9@buffet.re>
 <20260609211511.85630-1-matthieu@buffet.re>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the proper macro to access __sk_common.skc_family like everywhere
else.

Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
---
 security/landlock/net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/landlock/net.c b/security/landlock/net.c
index 111e58fd9325..fc2acf8bd898 100644
--- a/security/landlock/net.c
+++ b/security/landlock/net.c
@@ -71,7 +71,7 @@ static int current_check_access_socket(struct socket *const sock,
 	 * The socket is not locked, so sk_family can change concurrently
 	 * due to e.g. setsockopt(IPV6_ADDRFORM).
 	 */
-	sock_family = READ_ONCE(sock->sk->__sk_common.skc_family);
+	sock_family = READ_ONCE(sock->sk->sk_family);
 
 	switch (address->sa_family) {
 	case AF_UNSPEC:
-- 
2.47.3

