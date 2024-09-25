Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBDA13E02E
	for <linux-security-module@vger.kernel.org>; Wed, 25 Sep 2024 21:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727298103; cv=none; b=mzl1TVBGbhR2QsDtZ6T87fQXz85cpJqY86I1IERQOfYzlVrLXuHUr44LMMP8+77phz6f5JqeNzP4CgQOk7ET9tH0CgwcWmF8sAx3IdejvJ+VM3X5taKIAI72sLzGUI+MHhTCbtb6KASWRbcGoufiitY81cEM6H90HMmUDVjY8xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727298103; c=relaxed/simple;
	bh=IGuaEh7SZwi+km/GMz56FzfRfRnFFNwk2dfSyQ87CLo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kAjG6Ovr5itjgGAc2MbT5JReBZCNE854kqPLgFFza0KoX8XcgBcauWA30AktwcNO3HlHwHzQmKSTyzjcN3YR/kUUlksy5TyiC9xJBatOicuk21tCAx739jJMEBvIt1spO/IQEKdAuJG9O+BcqMRpc2aRv+YeLTw80yCgfd5YOtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cuy5Ur7B; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cuy5Ur7B"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7aa086b077so39491266b.0
        for <linux-security-module@vger.kernel.org>; Wed, 25 Sep 2024 14:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727298100; x=1727902900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5wcEeJn2cIbEJUhk3ZFpl0EbMiTQ8EzAdKf/AWxLhx8=;
        b=Cuy5Ur7BsucMHZI/zBxVlYEavWSAMzqzNc9QZg2vl/l/bj1Q4ZL+SSqqF3hBYLab2s
         G4IJGJvY4T/blooNGk3D1CUBogTTzX9lxYfvCHh7eHMxbOF3+8T4oVtuXOaLTn8u2Ga2
         H2D0caYRE1C7n0aYLbXx211aL5umnrlmTzklvsfFI7U7MWBzMttDy5xTfad/tR0W5vBf
         NP6d+NdBhSXc1y3AhTyrJCjnlzoxJgtL1Hxr+oPU/2iTkHUQPcIWW9ge1kFNt6ltsc9F
         6pIYBA7dopyG7HHnOPSR3pzU8gkeN994eudcszaacTQrGS553i2O/qd6WYgqKrbhqMds
         cQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727298100; x=1727902900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5wcEeJn2cIbEJUhk3ZFpl0EbMiTQ8EzAdKf/AWxLhx8=;
        b=FYUHV0tXjH7HcWandxPIQoprvzbGCfoXP0z1vwg5WrOOmI2xacWUHA3SX7r8dD4K6j
         eHxWxuNuAdkLd/ghjiffxtwyl2BJhZJrehKCFAsR4wGLCPXBTqciiwH1QACovL22fWc/
         gHmsBUusDbGivlsGtuAri2Dczgsz5wJ3qkRmrAN2O/A2b6slLn7LNFhLt01yjE82Pwn4
         urRBwq2IFlOVxDMWd1gXd5MVu4XEaRL67/GyvtS4hMFD8DcTQZcFGGHNIlHejeCl1yT7
         9L/60Q7jS+g7LA6SL0jFl0MLH87pxwQHGYWSU1FL7ouzESqpZpTb0/PbSNLFCP8cFqE5
         Y2/A==
X-Gm-Message-State: AOJu0Yy5KgJqxF56jVofSi1cy1y1GrIdtreu4g/B80kSA9hIvqnJ9+7l
	q0KaTRFSTSqdvdkKihrTnk8aYUOjxHjAz1G6ZAOw+qVQinfn2SNcxc5Ws6jTbZ8=
X-Google-Smtp-Source: AGHT+IHZLlayRjcU46kHh1fHf1z+Vrex4bX6UcSsMWOL24pPdvs/N6q6Cd1mXpPgKCPukt5y8InyiQ==
X-Received: by 2002:a17:907:3d90:b0:a7a:b070:92c6 with SMTP id a640c23a62f3a-a93a05f5faemr380961266b.50.1727298099446;
        Wed, 25 Sep 2024 14:01:39 -0700 (PDT)
Received: from localhost ([82.144.39.243])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93a25d2cadsm144452566b.6.2024.09.25.14.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 14:01:38 -0700 (PDT)
From: luca.boccassi@gmail.com
To: linux-security-module@vger.kernel.org
Cc: wufan@linux.microsoft.com,
	paul@paul-moore.com
Subject: [PATCH v3 1/2] ipe: return -ESTALE instead of -EINVAL on update when new policy has a lower version
Date: Wed, 25 Sep 2024 23:01:33 +0200
Message-Id: <20240925210134.530989-1-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luca Boccassi <bluca@debian.org>

When loading policies in userspace we want a recognizable error when an
update attempts to use an old policy, as that is an error that needs
to be treated differently from an invalid policy. Use -ESTALE as it is
clear enough for an update mechanism.

Signed-off-by: Luca Boccassi <bluca@debian.org>
Reviewed-by: Serge Hallyn <serge@hallyn.com>
Acked-by: Fan Wu <wufan@linux.microsoft.com>
---
 security/ipe/policy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/ipe/policy.c b/security/ipe/policy.c
index bf5aa97911e1..3a0069c6d5af 100644
--- a/security/ipe/policy.c
+++ b/security/ipe/policy.c
@@ -107,7 +107,7 @@ int ipe_update_policy(struct inode *root, const char *text, size_t textlen,
 	}
 
 	if (ver_to_u64(old) > ver_to_u64(new)) {
-		rc = -EINVAL;
+		rc = -ESTALE;
 		goto err;
 	}
 
-- 
2.39.5

