Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF8031E842
	for <linux-security-module@vger.kernel.org>; Mon,  8 Jun 2026 06:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780900599; cv=none; b=mqUbZvzXcURwzf+6S1m4ck5fgyJ55S+4ZZ6W44Y46oH7ID7apA/Z5ChKb8643wla4n6Vznxz+Zyysik2jK7UOxJ+d9XLmyL8ehYg2b6CyNM7Ek2uP8fYXLaz3Q3vPN33a7hXM586OP139st7sjJGBplbR4wFNeYPTy1hQUPpZ/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780900599; c=relaxed/simple;
	bh=85GIeYlRtIVw5fo/uWEqa/Od5gLR3z/2GhTv8spsaU4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KKVc4WkRTD8sPnsn3Zid2iy09y24UqjpvVbxb84d25ErWN0WPQFC77s6YpThCkcQNY24J6QP45mW45aw8BTcNSGE9tkZG3jqipCAh0qqJ3iCoBiGu+D6zJL0yCN+D72Miy6tPyckdUTFHMyyPPJP2o0rdQSmU/yGAeHmlYzTy1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R28fsS5Q; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R28fsS5Q"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2bf125989f2so27548405ad.3
        for <linux-security-module@vger.kernel.org>; Sun, 07 Jun 2026 23:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780900598; x=1781505398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XJdK+wFJTLh6vJvwVPBKkL/MaKsEcyHpUO9XLN9CTgM=;
        b=R28fsS5QtZc/mbhGx7l+RxrGHCvmYjMTVaAS82DxsXmJtJ3HBpD5hCw2azDGHemBkY
         jv3csLanNOAD+zlBwmEvD0bmF9fJEJUDi1tJish2nJ2stztrZxbbhKLRYX7ZXsy+8XQD
         Pqke3SRwNLiPNZ4i8ljD9LdiXrQZnjbCgkE0fs6ceuyJiwJN6T5rb7CGeYxfxxudjs64
         trVsd3+NjuNd2rRmtT0ePMGAM/JyAtECrtbbRQ5r8kaLyAGYBk6aEUe/wKnjhqsLkexB
         S6dIBdWJ52O5yYpRp79mtgeCWSZuQi1MkWciwqQk6flUfseOoFGck8LdSEXK9vnOJD31
         Z+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780900598; x=1781505398;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XJdK+wFJTLh6vJvwVPBKkL/MaKsEcyHpUO9XLN9CTgM=;
        b=glL95qQI1povD62a4FbYSpswA7e+Tmgvq1FLHiAr1+hMqyMofXT6PIx4IduGKssw9e
         /H2VIS3p5a7aTmB3NVao2IrzAMTqhDkMlmrGRLPXTPR2oLwA0/wLvCV1Z0cf/NwQL1Ic
         U8Cb2Aw0vvicdg6lfpe/jXg57gsu86FJeJgsHLuXBLY7hn9UeqAyf3bEiMy5ZHwcdgqr
         cbrzlvRBFvNY00et2tj5kq6IlPJFs5VLIUPypnr76Sx87rXWbIjcIJ3G4nwOqPZJUSz3
         czXkHrb3cwmyqMEWKMVCorC7oHfgAd6UGJGGn3q/7zG70lRZ1pI2B/IcBDGMxS6pTCZr
         g7mw==
X-Forwarded-Encrypted: i=1; AFNElJ/vjezRwrbjOHury0w38lgxRyzU3dly4PWdbT5eCzlAfZK6NWJaXsDrvCA0X84zhz7IHObu8OXY2vf6zxY0LhAp/igFTfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwobBjuNhWkSizDMTggqMig2VXaoluIoKL9zbGpjjqZgGvFsJ8z
	1SaKsS4YZ/IUM2Wp19/HDJ1f7EoKS50l+FEg8ct1u1BpGmDSoryaxuBn
X-Gm-Gg: Acq92OEtduUtTLPyiDOGyUcACiUFaBuOvh0BEMaIxdECeRIYRxJzBvOQ5R11j4LDo4o
	t8MXDiOOIlxhVzro9KZ9wvqHiV8SiCAzimn7mVTbUgRtXYr5B7LBVBVloBlOiSpYAY6FtUSZj1q
	fTplglgfFgrIv5oYXxtGO2zQs4Xpjjh8yuV3jCOZyYx9JpTPYDnEl+tzQwF2QoPcGO9eaclotqd
	kjKTrRLTd/YtW1nunaZ6y3ghC7od7hwhntyisbDwyOypWeWbnDOtLi/RBa2eYYj7zfamZWE/KUi
	cdG3ImT+Mh/N4VNecTYZXIA2ph0AhqlDS3wSKbX7I6frIlpkkgFk9s1pJUjeOVNiz38RBkikDWp
	RZnEON2iH0xyPXuG1WkIIhVy6eVqOHfP/Mgzu3CFSNp3JzeTRrJD91MMEVpq7z8EUvoyfZJfijF
	IoccZzloHbmPZyIu7OKZ/jALBYM2qHzmiSj7V2CkrnUMI9NgZlI62A
X-Received: by 2002:a17:902:cf11:b0:2c1:ea95:8297 with SMTP id d9443c01a7336-2c1ea958447mr162487235ad.7.1780900597708;
        Sun, 07 Jun 2026 23:36:37 -0700 (PDT)
Received: from haichao.tail057a43.ts.net ([2001:da8:e000:1206:9a2:954d:67fe:d9c2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16629d55esm171037655ad.63.2026.06.07.23.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 23:36:37 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: John Johansen <john.johansen@canonical.com>
Cc: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH] apparmor: check label build before no_new_privs test
Date: Mon,  8 Jun 2026 14:36:31 +0800
Message-ID: <20260608063631.9-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

aa_change_profile() builds a replacement label with
fn_label_build_in_scope() before the no_new_privs subset check. The build
helper can fail and return NULL or an ERR_PTR, but the result was passed
to aa_label_is_unconfined_subset() before the existing IS_ERR_OR_NULL()
check.

Reuse the existing target-label build failure handling immediately after
the build. This preserves the current audit handling while preventing the
subset helper from dereferencing an invalid label.

Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 security/apparmor/domain.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index f02bf770f6385..6748ac74b060b 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -1527,6 +1527,8 @@ int aa_change_profile(const char *fqname, int flags)
 		new = fn_label_build_in_scope(label, profile, GFP_KERNEL,
 					   aa_get_label(target),
 					   aa_get_label(&profile->label));
+		if (IS_ERR_OR_NULL(new))
+			goto build_fail;
 		/*
 		 * no new privs prevents domain transitions that would
 		 * reduce restrictions.
@@ -1545,16 +1547,8 @@ int aa_change_profile(const char *fqname, int flags)
 		/* only transition profiles in the current ns */
 		if (stack)
 			new = aa_label_merge(label, target, GFP_KERNEL);
-		if (IS_ERR_OR_NULL(new)) {
-			info = "failed to build target label";
-			if (!new)
-				error = -ENOMEM;
-			else
-				error = PTR_ERR(new);
-			new = NULL;
-			perms.allow = 0;
-			goto audit;
-		}
+		if (IS_ERR_OR_NULL(new))
+			goto build_fail;
 		error = aa_replace_current_label(new);
 	} else {
 		if (new) {
@@ -1566,6 +1560,17 @@ int aa_change_profile(const char *fqname, int flags)
 		aa_set_current_onexec(target, stack);
 	}
 
+	goto audit;
+
+build_fail:
+	info = "failed to build target label";
+	if (!new)
+		error = -ENOMEM;
+	else
+		error = PTR_ERR(new);
+	new = NULL;
+	perms.allow = 0;
+
 audit:
 	error = fn_for_each_in_scope(label, profile,
 			aa_audit_file(subj_cred,
-- 
2.51.0

