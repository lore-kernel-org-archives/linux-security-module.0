Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06251A2875
	for <linux-security-module@vger.kernel.org>; Tue, 10 Sep 2024 17:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725990582; cv=none; b=cYqTCozmQw4jTF4DaDMBPSQ9lHmpnFb3otzGavhLmPBxOHnVRdN2v0pi1AYWBvpqak6DESswLqKsbQxOHxsiKDIKFr/zZ5EhruLnBGX5KSMrTKzkLSs99N14bnoliQTVYzt902ef8t3jjnL2RuxAzlU7J5ZTUzh8FGSs6DeVHME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725990582; c=relaxed/simple;
	bh=AXwpFuaMqL8AmfzXJ7qg4wzkx1fpxc97BQ6WENMs9eQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E75naUj45YYQOUVpFuZMI4cE3cD0uZceVWNqP4PmNGk2bYi6u6ov2a73bPzrSwll0KjjMb/5Sn7dK228jDwvx2AVQmXViihB99Sf33J85uX23DQUD4kX6Q1UNzlHefu466yfSl9WuclpRmSFjMxdM9BCXmujix5mOLyxI+GDl6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=nw3NQwii; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="nw3NQwii"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cb1866c8fso4850295e9.3
        for <linux-security-module@vger.kernel.org>; Tue, 10 Sep 2024 10:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1725990579; x=1726595379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gEMKhoKz265xTr0h6063lsKQJW8lu4nWZPLj+dKg/ak=;
        b=nw3NQwiik5dKfY1UJuTkEIsiTQcVAPS8LbiFrZjIwVMAHQtVLH2YQceQSrpl5M7inD
         jgdmyURelX+igy/+vGWlVfBp1hX/MVja/XI5+H5c8VEBeruCJm+/qwLVEAIMioeniZzj
         y76MdEtJEwIXUxZZM+gkHp81YopEa6+o9Rgjz8dz10JEIr5CvU7CipgMFuDqcgRB5XNS
         xbg+aq64mM7lX+Tfjnv/HIcxQ/cVNMaKFWMuwIfN+LnHnqCzdrBejLfsvvnk3LC2tSGZ
         GwdS2Lwi2dY3P4+S46aUX3VS2ewIGiFObfwO/68iEXu4eaemvuOYDZ1HjHFY2bs7C+Q0
         4QFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725990579; x=1726595379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gEMKhoKz265xTr0h6063lsKQJW8lu4nWZPLj+dKg/ak=;
        b=UhNkxYAnaENwD0Sqzzkn/rV7nxLZUN3wmIVvik15L1al/BKZSJwPQ4wt2FT8OLJSJE
         857D4lZj1POmJOD332GLXYPB/Ib3FgCizhYuf+U2hv54xc7/KvUJJLpLYGZbZiKqVMi3
         6kmtjIjVJef8oxQS9WAcLT9aoRdil0QlroO6T1kQdeiTPkRQGPbQRgWW+DuhmLBLmN20
         kiijMem36y1AuugLDseYRxIIvKS+t0PbKAunRN6aSLJo2qwp9NDHSG2s16A1njQNiR1M
         rTXuRoXLSxEEdRPzbn4d9JkIcDrfgQHDMXS5RzucVQKypbypbqN6k06fIAvoINEDNgAU
         dPfw==
X-Forwarded-Encrypted: i=1; AJvYcCUC/7n4RYIollv45l1SfMHVxWe0cZbpRWt5fxxE1ciGRDccGQjBIX17xoqbFn5rtSfR3IAzALQTJ1+6Z4eWyDoKp1wAfcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxJISqya65iUMYBMgNTJZEr3O2NtN3JdeTShobtfabl3bob0/o
	0kTa2pCP6osNTDljL3NI9AhLh6yGCE3lqhKChDc7FaSrvfnDbh7OkApG7vkLK8o=
X-Google-Smtp-Source: AGHT+IHelw/uYw52OYmIixy02tvwb5mK2pkTzmGN8qQjLqO8V8gMqDEZAl0lSTYgOrrjILVgYICXyg==
X-Received: by 2002:a05:600c:4506:b0:426:6cd1:d104 with SMTP id 5b1f17b1804b1-42c9fa0c6fbmr55373495e9.4.1725990578992;
        Tue, 10 Sep 2024 10:49:38 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-91.dynamic.mnet-online.de. [62.216.208.91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956dddacsm9399741f8f.107.2024.09.10.10.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 10:49:38 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: john.johansen@canonical.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] apparmor: Remove unnecessary NULL check before kvfree()
Date: Tue, 10 Sep 2024 19:48:37 +0200
Message-ID: <20240910174836.8966-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since kvfree() already checks if its argument is NULL, an additional
check before calling kvfree() is unnecessary and can be removed.

Remove it and the following Coccinelle/coccicheck warning reported by
ifnullfree.cocci:

  WARNING: NULL check before some freeing functions is not needed

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 security/apparmor/policy.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/security/apparmor/policy.c b/security/apparmor/policy.c
index 14df15e35695..ce1c96cb2aed 100644
--- a/security/apparmor/policy.c
+++ b/security/apparmor/policy.c
@@ -103,8 +103,7 @@ static void aa_free_pdb(struct aa_policydb *pdb)
 {
 	if (pdb) {
 		aa_put_dfa(pdb->dfa);
-		if (pdb->perms)
-			kvfree(pdb->perms);
+		kvfree(pdb->perms);
 		aa_free_str_table(&pdb->trans);
 		kfree(pdb);
 	}
-- 
2.46.0

