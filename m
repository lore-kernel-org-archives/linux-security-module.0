Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7B51E9B0D;
	Tue, 21 Jan 2025 10:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737454308; cv=none; b=kMHdJncpUmzRI1Ot3c2ZhsqVnKilDsZDT5XEWW8OnRlYGa+HLjXsCFg3LGdTukRqqyMNgrFHdhyDOuUJXfonJJxbLJou1XuxrN4owTd2krZtSRNe/KplwA09g2fsmulwF+27EgzBN8kvD4v4gVPzhXq6eTk009WE/Rd+Jg8pRUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737454308; c=relaxed/simple;
	bh=fcSh4AxZ27ZgC4b06I+jDz8xOha1g9su88HEf3I7ObE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tyYF3dMOQmPT8g05bbw3D+jnOMd8niJ5j7r9uJxtf6gF38chciYdniGwu4ko1BktygHYEoHXRz4m57x6bBn7mAifZWdrs8quIwkPFFBMapfak15cQu2HAcZL8jjOjp9jOy7st3dxf3EsYk/Fdt3ipRcDilc3ZHRY45rPmb/0AqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aWjiTs2O; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWjiTs2O"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2163dc5155fso101172685ad.0;
        Tue, 21 Jan 2025 02:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737454306; x=1738059106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u4GhAgdGPJao5oBQSTGd+M55EpKH1+oHBv+vxevMflk=;
        b=aWjiTs2Oky77K98RCfT0WEXezH09matXSnaj98XZ1Nhhs0Pi31vzdShYRgwtbBZ/3R
         TOgpfNFrKmqhJlotDJJotJw09/ADwBUbFNZ2fhwBaaiyQ6UkL1xONeUbdsBk+AP92el8
         eoxfuOqNwkimy+2O8FqG3C8ulcG/O4qz2xNx4XN3yyr7txSI7N1bulIDMSueN475uJjz
         TkjxLxgfFaZNjvbpZEI6C/6qFLBDJGpwy/ccBgEvy3KbkCgvlZQzeLdUuE/JPMzekD/u
         4NWsfJeKM5bHVM59sCgPvCaP3XyH3VWSlPHxw5tvBn9UYDP5HrC/cuihYOgPBV68tvvM
         fotw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737454306; x=1738059106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u4GhAgdGPJao5oBQSTGd+M55EpKH1+oHBv+vxevMflk=;
        b=HzBGOPjgzeME9sQnokRL7dhuTkxELR+SFGGTpgfZVvB8WjTjhH/dn0L9xM8fMn/dos
         qdDlO4jYic6G0z7XiwLGz7d/CCaMXA9EQ/EXObM3xu415gBvKRRkBMB91dgOK+jnSPNQ
         j1CF22VftP1akdjRxoGGlKEVoIfQiKTqkIugmt9qQGjlODoLejWwLIlXmSb7M/VdGfW0
         eykBxSWXZcn+j+jnXeMrLLaq9RYnZs6zZ3y8P6VlMZeGqZgUMPsHDfXz/s5EV5+yX04k
         b46Y+JAYYoCQXO3AKWlo1zBmrvORJtqlD/CaZ1v7NR/L4vT3Mf52Ds5v+G6rRJD+frz2
         e1aw==
X-Forwarded-Encrypted: i=1; AJvYcCVBPQNunW9Heumj5ip1sW7yPAMBDqfN+ItbvAN1q2SffvfccvhM2x/Dib3+ilRGVUCp8GX20d7Er0Blx4KiyJNOSrAgg7Cu@vger.kernel.org, AJvYcCX9DFQ3vKSkRNOCo39rBcyKad4RaHSjG/b3QQ0TC1LsVtdh9VEoU7G4HAeBoAoPD6T2pJIC9iHdoVAQirM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFZesdmqeC/Uiv0572WHmSNnhnswYQtxg7J/DUbRg2tWqKhfW/
	+bTMX/vr8VQropwgmGVJjUDBkGhBJFpe5eDwfCdZiGBFKHop9dGc
X-Gm-Gg: ASbGncsnybubfvJi7QCKS4vQT0WPiTezdMvD2xU8/NdutQi2Bm6fYXoQ3PEuiiWUIku
	rUOzJVrbTr0vYNrGXwLGfr5oj7LkAwNAghugn4qZu8lDmmujKEG2+aRnT4yXmS8J2UxWG2GTKbr
	J6PRRimNr6puIJCYEaYm4xsQeIsDzwaWBuHGwOBs4eKrWCBnCtf3g6BKBGUe1ZQf6MT5U1wA0fL
	Vt2FJn5yv4Tdt5GcAdg+fqH97k1e+vTddb2jkFaPMUUUQ7lmZDSNxzmMZnSwNJ5qCJUSvJS/A==
X-Google-Smtp-Source: AGHT+IF6jOOijDRlgAzivw8DReYi5rs58LTDAI7B2+ElM37sm5S/cFLuCYJWzorRK9MfaRj2u+IjKQ==
X-Received: by 2002:a17:903:1ce:b0:216:4a06:e87a with SMTP id d9443c01a7336-21c355dc64bmr254887485ad.40.1737454306461;
        Tue, 21 Jan 2025 02:11:46 -0800 (PST)
Received: from HOME-PC ([223.185.135.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d402d61sm74580295ad.229.2025.01.21.02.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 02:11:45 -0800 (PST)
From: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
To: john.johansen@canonical.com,
	apparmor@lists.ubuntu.com
Cc: paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
Subject: [PATCH security] apparmor: fix logical error in signal range validation
Date: Tue, 21 Jan 2025 15:41:38 +0530
Message-Id: <20250121101138.116675-1-dheeraj.linuxdev@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix logically impossible condition in unpack_profile() that made the
signal validation code unreachable. The function was using && instead
of || when checking if the signal value is outside the valid range,
making it impossible for both conditions to be true simultaneously.

Update the condition to ensure proper range validation.

Fixes: 84c455decf27 ("apparmor: add support for profiles to define the kill signal")
Signed-off-by: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
---
 security/apparmor/policy_unpack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index 73139189df0f..e643514a3d92 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -919,7 +919,7 @@ static struct aa_profile *unpack_profile(struct aa_ext *e, char **ns_name)
 
 	/* optional */
 	(void) aa_unpack_u32(e, &profile->signal, "kill");
-	if (profile->signal < 1 && profile->signal > MAXMAPPED_SIG) {
+	if (profile->signal < 1 || profile->signal > MAXMAPPED_SIG) {
 		info = "profile kill.signal invalid value";
 		goto fail;
 	}
-- 
2.34.1

