Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AEB3EF0A2
	for <linux-security-module@vger.kernel.org>; Tue, 20 Jan 2026 14:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768920630; cv=none; b=ojYnDLL6lqfv6tamDpBmcZp9n0hZsu0k2X2Fd8BtWXkdiIHfBQrDiePDw4QVTQ1YKGkQOqyp9Pe8zWzQiEnoG5fh6ozNlaNXcfGCUxZJbTSwxxqAir5PnpwRJh0bCHK/B6EhkcQaE0a6FqVKruPH1nbibKjiA61aX3fM4tfgWbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768920630; c=relaxed/simple;
	bh=rjzdkuHG5AX2vB5T//SBT1BKUn5LcL3vNP4mq/GbCIg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SRWTxs74iEkzTD+0nf6PtNb9JvTa+d6M9sjJLl5b5PI76bHeq1HU1PALpPsd4UTDW5SM0KsYwyi7QkakOCvAoddTadLhDO8hSGCS9GPAPhKAqSPURHL+AJKm2TOHVuacJk79OoxEaexUU3BGNM+Kh07rug8vIZCcZyKPeIrB9So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aYVtzbm9; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYVtzbm9"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a07fac8aa1so41243265ad.1
        for <linux-security-module@vger.kernel.org>; Tue, 20 Jan 2026 06:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768920629; x=1769525429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B8hFGxkidyH1x7WVOh/MmDC5refkrkaMi3SKwdLwH6Q=;
        b=aYVtzbm9BOtxmw1qpwaDa4U7sFh07+uBWARP7kypRiF/DFbvnPnx31bwGk4gxsLoKn
         juXH+8tzwTXrtvdQInlZxLFzCf09ntGo01FLPzbT3oHmgYce7xKCZFol6s6Pvsj+ENUa
         V1Ewual+5mHTjDe5u+6rTfeVWRleW9d5DN8Rlyjk0Pp0zt1yuYKm70X//iDhCHjcOPB+
         hn6oWk1UZ0lcIY7TXMHdS0elKz9T8rndoALdidsmviflIE+J2VUPhSrQj8gkkRhD02cd
         yAyUnznE94kawJWw6vVdDiuppRybimSptX2qOEsJRxutaccFFNDzPmMdzmJKzjwXEn3k
         vf5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768920629; x=1769525429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8hFGxkidyH1x7WVOh/MmDC5refkrkaMi3SKwdLwH6Q=;
        b=fKEiwEPgTC5Al/EDfizNO1aR0TaLlYi+bl9KlX2Zi9cFaVvTY/o4uIZZjiwa5+lr4U
         uifjmHZ1MMDzDuPik2tGNNPoINW9+pUrexI/5CMitRaxd1uTnSCTN8qx7w3ShGLatBFM
         2xtrd3S5UfBiM/jmogeB3NUtcxE9QBEcY8sKbPt/MzTF6OqSWEDj/XEg51LvQhODNr0s
         Hfj4TpinLTjxLY85zuM9RbTslyCDYgI3jQ0FhUII9vz5uqLl6xce2fifuISjB/VtqG1f
         t03Tu5GmnlhWN21xyjhiBcb5jj2HR7eomMxvSyjRXL8y+jkiF5EsrV1RHEKjfhF+EjLz
         bUeA==
X-Forwarded-Encrypted: i=1; AJvYcCVqRidWi3k1nK4YpFUUA3zXHGvwAWnwvHH2tEWtlt71SQ6Bl7ruRflYwb1WD++Kb0MgNoBNwz8wdmcODDlxebAHS38ofPs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0FH+JbM0MACRA1dz5DOrN3GKcySGwIRn+bgLx4TUiWSzXEajP
	vc9sZdCiSqIlLKaNZ+PHO1hizUJW0lZmoQXAh47jiZ6BFIRuqccng6fPesju0D8u
X-Gm-Gg: AZuq6aLLicV647u3D4yU98lQZq0yhl8MAhvCyhbOhey6NJKRqtT51AZsgTfyJi5OBsT
	LQfFa9yH2dy5K8vDV38yTNqTSGezY0/FYMieUYprz5KIzq2XM7fgeu6jD58w+3hPhX1yCP0mBbF
	yuP0erDxa68O9FYLJ8Wae3ukvZ3Lu57OnnFBI3Ee5Nxgf3rjTTlkr5GITwVk9oJ4Ufv5ldlUyVp
	3GR6EUMYZeEJ96phfqsW2Nh4tksLlK/5Z6mF2FrQhaGCOe2hKjEEly8jOncYk6aWCQsnaqnFxof
	tMbQIWqi1mtHmM1W8nrkZZxVVLeC8jOlikZPc2k8CAQlVY6oMaoQb09gy1E1nZG6eZxVTT3Ry6z
	LQtnE8Ue8kcXJGRNbpQloWVDEfuyLDZ4yp5BGK7PqsuvqxKeiHUcQmKQve+NJpvB+wQtA8xb0cG
	lMmmOCRx+Yg7HOSymVZ09SLR99hw/RwMI6nRMiTaFnCcI5YCcEvXT/
X-Received: by 2002:a17:902:cf41:b0:29e:c283:39fb with SMTP id d9443c01a7336-2a76b16a396mr20182525ad.52.1768920628516;
        Tue, 20 Jan 2026 06:50:28 -0800 (PST)
Received: from kailas.hsd1.or.comcast.net ([2601:1c2:1803:3ab0::2e2b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7193dd523sm127679975ad.62.2026.01.20.06.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 06:50:27 -0800 (PST)
From: Ryan Foster <foster.ryan.r@gmail.com>
To: john.johansen@canonical.com
Cc: paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ryan Foster <foster.ryan.r@gmail.com>
Subject: [PATCH] apparmor: replace strcpy with strscpy
Date: Tue, 20 Jan 2026 06:50:24 -0800
Message-ID: <20260120145024.261806-1-foster.ryan.r@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Found by checkpatch. Replace strcpy() with strscpy() for safer
string handling per KSPP recommendations.

Two changes:
- apparmorfs.c: gen_symlink_name() uses tracked buffer size
- lib.c: aa_policy_init() uses exact allocation size

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Ryan Foster <foster.ryan.r@gmail.com>
---
 security/apparmor/apparmorfs.c | 2 +-
 security/apparmor/lib.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 907bd2667e28..f38974231df2 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -1614,7 +1614,7 @@ static char *gen_symlink_name(int depth, const char *dirname, const char *fname)
 		return ERR_PTR(-ENOMEM);
 
 	for (; depth > 0; depth--) {
-		strcpy(s, "../../");
+		strscpy(s, "../../", size);
 		s += 6;
 		size -= 6;
 	}
diff --git a/security/apparmor/lib.c b/security/apparmor/lib.c
index 82dbb97ad406..7cb393f91a10 100644
--- a/security/apparmor/lib.c
+++ b/security/apparmor/lib.c
@@ -487,7 +487,7 @@ bool aa_policy_init(struct aa_policy *policy, const char *prefix,
 	} else {
 		hname = aa_str_alloc(strlen(name) + 1, gfp);
 		if (hname)
-			strcpy(hname, name);
+			strscpy(hname, name, strlen(name) + 1);
 	}
 	if (!hname)
 		return false;
-- 
2.52.0

