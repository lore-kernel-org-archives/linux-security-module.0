Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB544F3919
	for <linux-security-module@vger.kernel.org>; Mon, 28 Sep 2026 17:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790615206; cv=none; b=QiEWqP4lpIvzmV2HGiNxDj3lUM76DU58JhPZcubLcPdsJgACAO0QRb6d1DFcrl4vJcdOBJC28zEcZzCk69GB42stcw9kgCBncA5pyfoy5EAesZgU4PQbQzwoNoKfHiBhUBec7/qA3N5QOkqo+XUmtRluPGh0lwRQ5vgkJTIfFWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790615206; c=relaxed/simple;
	bh=uChUTreZM9DjWLtWdqF97wlSLIW9onV+Eq5lCV7/kDg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pO6Z7dVT2GYxA/74+/3esZO6pNBgFVuV3oXzgahD12Tp2VUX9WK6Er64BRsXvQyAMji+G/XQ1Ra0kCGP7mx7eINkcJ/8c6iyRwH+Duu2egj6Bshz76UMWZJm1d8femAxScX53pmM8cQkHtbMZacvJvRWyRbiq8xs/yekXEQODqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJtoPnSc; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJtoPnSc"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747f066d8so8818375ad.1
        for <linux-security-module@vger.kernel.org>; Mon, 28 Sep 2026 10:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790615205; x=1791220005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3CiF+deL5rORB6fprCctgwEm0oaIPMhbyCbEcoF6Cfg=;
        b=GJtoPnSczqAyjd2j6wz3pFnrJnDQb3UUzktIf4wUac1tDXry5rYgWkuiAz3GQO6V4o
         ij9zX5ji9UNhsJ3ljsWJjLwxX1QV/3LbVBCcmhGvqTCSPSIbGdSlcyZXdQlCzbRZZTlz
         LlfmHJRyfueFklZnNSCsnXRe6LMVqp/ghYcWOIvqfFBjqW71OiPRqOUQ+YFMlIBY/+Nq
         Ndyrtrt45jI0+qxksx/gcel9qEmU8dZiqV9slyOesW1E3VGFRPt29bIvzErk/fw5Fi3O
         8ZM1FYGS0n7HW7v3Nm7xNra1qw1ZVE/an7O5VAne5TEJ7HYQXeV/4PjGc6+DK5Nw9Z8W
         X52Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790615205; x=1791220005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3CiF+deL5rORB6fprCctgwEm0oaIPMhbyCbEcoF6Cfg=;
        b=q5ABz/rPve3Idx8ONdwe1Fc5lAmBW4UTzxmFLfaz2q+l+wk/+uM1PmR6O6JBKiALTr
         oQWn3paZCz4uNoPiI2DNx8J6DKukkG7zQ3RQd9X314Ehosdk+cOzK9AR9AHyHph9ev2m
         d1neZfdFGNLZm2aMqSiRAlZ+ZqzyhTA0d+boEUBzygos/U4KHrOrZS3gkF6kGgJ0EJX5
         2xYneE+vvVToeD2pJSo6TyVJ7iTg/ECkSUrF8A3ezIMFck6UQ07a5t03fdJoSa+yoe85
         de7eRLhQWeDJ29q5ByYeTWzB15X/e3qYThpQLgFRKOJgiYY17ry/6ZCfeiO73b71UV2B
         0APw==
X-Gm-Message-State: AFq9FYIAkYMhSYL2DaVNR/XRxiUNwYU/SZawSrLuvD9JbIMdZ1UY8P7S
	kjhmo+D8uGqCfIqxxu4DE10mkkZp13UvIlssZD1tClwTxxnH1wW4zqZSjSJRlF3a
X-Gm-Gg: AYBFou071aGiSeyrWjWhsahru0OrHtc4BZpyuqPhe8+4XMrmhJHFNT0rVUNi6K0Y8jx
	YGN6WexorBPNylmFbP4SNLigshptEEO/N8ZmVcpWnC3dEMHDgRRGutE8uGpnFMZWnC/RQViUWx8
	ahCU84LWMZp6FISzvQFSzrnP9yLbqhfLmPQVTJ6S8TTieHxnYb7m4XbTUj5r8zarOBa9q20LZYE
	7evdb7q2m7zjJG7YBc5eHb80H8WFKa9VVTLGWfrGV+vmVozyEqnoqSt2Fja3Nq3TM0vHgHK5b8C
	xG6hPyGgeyE8xlTrjWALdN8lvEQIwUkpNdMx9vcuvJq+h5IykvcDde0h6ezsdZimopmUySUUWkO
	Q/yBgZPGXvfj8nYuSIPQDszNRYnuGxmhfn1ujoqNwLmeR4N0aCRt6QbIHUzaKIXKp+kISyJNp1J
	3eBVHqH/q0FtXZba3tolnA6TPqSbpJp9yMmV9vJZpOu70V6Se2YwP5GUUjjgJp0KqX
X-Received: by 2002:a17:903:1210:b0:2df:8c4d:a2be with SMTP id d9443c01a7336-2e2c48c6ce3mr90575ad.39.1790615204411;
        Mon, 28 Sep 2026 10:06:44 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df91423df7sm44957605ad.43.2026.09.28.10.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 10:06:44 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: James Morris <jmorris@namei.org>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org
Subject: [PATCH] lsm: remove redundant NULL check in security_init()
Date: Tue, 29 Sep 2026 02:06:37 +0900
Message-ID: <20260928170639.413560-1-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 5137e583ba26 ("lsm: cleanup the debug and console output
in lsm_init.c"), the NULL check for lsm_order_legacy in security_init()
has no effect.

So remove the check.

No functional change.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 security/lsm_init.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index dbda7771013b..8d5ecea99c46 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -431,8 +431,7 @@ int __init security_init(void)
 	}
 
 	if (lsm_order_cmdline) {
-		if (lsm_order_legacy)
-			lsm_order_legacy = NULL;
+		lsm_order_legacy = NULL;
 		lsm_order_parse(lsm_order_cmdline, "cmdline");
 	} else
 		lsm_order_parse(lsm_order_builtin, "builtin");

base-commit: 63b4c8561b436e8950409d6041fce43f12936f59
-- 
2.43.0

