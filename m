Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293FC70804;
	Tue, 12 Nov 2024 12:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731415536; cv=none; b=BqgXWeFCtInV9NL+e4pZkRcopWZB+HhFK3DsQsMPjyVOAprdEy2+/DqL9amcDCjM0JhE8wqBsrAYAFXNuw07LDxuTSncX8apBN80fj/C7Fi+5Chqf9og+6paDssjPx4rESeidmbY4MB/inqNHjdyiVfQCkJtUn7bVz51j5bPHxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731415536; c=relaxed/simple;
	bh=3jPo/hPLxy18G3/7lM+1vnDBqvWDkPEahkFK1YwVnxQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=g85kOc5G2O8LfL6qNCFdm/xiP69UukM9T+SjD+r0u9T/Yh+idqU0CKsRfx09qhfo0hLVS1ju7vrpRcEvtlw0EBtvJ6b5HDUiU/OHI+QSZP0VjqpWf9QIRz4BMsdqpK79rluFPd0y2Y03ysf7s4R01rVp9HHrL5aRzqHkQmtMzx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H7FhbTuS; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7FhbTuS"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d4b0943c7so3481959f8f.1;
        Tue, 12 Nov 2024 04:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731415533; x=1732020333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DQJrTzfiTbTU45YUcLfDbe9cQCR+0FsREp/24hFbpxk=;
        b=H7FhbTuSIbwCuze9dHhIDk6OTGEs4N/Ssq/RWZh9+0mtX3AtUq9Uo9YluRqNO0TqDG
         VHazC0yPDGfg5PtvJ/z5+2MnuIIfoRiDXfwJprW7cg0abvB7gkBu/L6c201aawlFEX2E
         abBs10rz/pXSf9+qArELBGeq3G4aFVc7A4Nt5ntTI1jhcH+RaKkXv22nVI+pEoyYZOrm
         Vt15a63yoAcL9S3ZLvWAwD5MNQWUyNtpn0TSkd+T3zBxl6bGR2KSITjJezmkQ6eS9pUv
         TJFnrwc7wPo8BY5J7jw9Z2sLbvMVot6zCU5pMqTwKQwzsCrCybcoLduNRagAGrvgOzJY
         kaqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731415533; x=1732020333;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DQJrTzfiTbTU45YUcLfDbe9cQCR+0FsREp/24hFbpxk=;
        b=atKCIpRTrGotqf+WCPSzEqGtEFY9RZyIqSqplLY6zue8Y66kYZ96rTXfcqgDy5DPdb
         WBlXejmkahnmtsDSqXX8Hl26/Ob4lD6EFkqMfIF/s2z8/wYlp3wkPp1e3qmEkK6qVSk0
         l13TbOQ5Kr0C43Q4hxkg4RCTQvpVHWJQyQ6uA/cs7shWqcApn0BflBWepDRBiHZcJDdV
         qLkSauf2zsTVf/BFuS0z8r2Qq/rLPg7AQDelXzh6IvdCu87V1H0KNIUBwMTu5svpEtmC
         U6vNYEsqG8gK9Jd1JCEf0nrW55G3sBUCnD/9XH4DWSDyC3rYdttQ7EwlYAlK/Nv1mHIM
         cN9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVbhCxaq6QlrEBstVzVCmPbKcPQ2fNeIY10DnDgHEICs3TlaDmrvYC+fjO6YLTYPIZ4ATvl74bp83v5PoU=@vger.kernel.org, AJvYcCVlytYnLpdoT9HeLbYN8zMH2xhNGF6VsYK0j0dnS5pJHvPeDYgmKoxKfBxwjx5DXnddV4HescwDU75CuVsNr+QWFpVqrLJi@vger.kernel.org
X-Gm-Message-State: AOJu0YwaDtOf12so21khB5bRYUSYNeR1T8I9mzc54aFSzXK5bZkOGHNt
	opuON8P69OnAuAgRn+soPTE59r71FdcZ8j5vJHBkvPFcXA9nwqy8KeQ8gAbW5sJHTA==
X-Google-Smtp-Source: AGHT+IFTg2bdLzOuaT1pnUou0vkJijeCrd2Y5c4F7zej9PYJkoysjOZgeIcOly8IFtPdiifdjTbQkA==
X-Received: by 2002:a05:6000:1787:b0:37d:5026:f787 with SMTP id ffacd0b85a97d-381f1885612mr13293930f8f.38.1731415533270;
        Tue, 12 Nov 2024 04:45:33 -0800 (PST)
Received: from localhost ([194.120.133.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed998e6esm15434904f8f.55.2024.11.12.04.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 04:45:32 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] security: remove redundant assignment to variable rc
Date: Tue, 12 Nov 2024 12:45:32 +0000
Message-Id: <20241112124532.468198-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

In the case where rc is equal to EOPNOTSUPP it is being reassigned a
new value of zero that is never read. The following continue statement
loops back to the next iteration of the lsm_for_each_hook loop and
rc is being re-assigned a new value from the call to getselfattr.
The assignment is redundant and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 security/security.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/security/security.c b/security/security.c
index 09664e09fec9..6147f27ea92a 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4139,10 +4139,8 @@ int security_getselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
 		if (base)
 			uctx = (struct lsm_ctx __user *)(base + total);
 		rc = scall->hl->hook.getselfattr(attr, uctx, &entrysize, flags);
-		if (rc == -EOPNOTSUPP) {
-			rc = 0;
+		if (rc == -EOPNOTSUPP)
 			continue;
-		}
 		if (rc == -E2BIG) {
 			rc = 0;
 			left = 0;
-- 
2.39.5

