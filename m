Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7DB245012
	for <linux-security-module@vger.kernel.org>; Sat, 22 Aug 2026 00:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787357752; cv=none; b=COJn+IE+tVisUjuJP0zZKeipyH4bPzgcSUPFS5WbsX0j/ah6ZhnPzjzUdPlTNd1amVaq1ZZ3LJrhcaFSNJoZ25aUjWM7w7HUizImKTrNTJZ+S18GUVbay5ltJ2kq1bKtgnwsW/XKCAM8AWLFPqO9mA5X7eknEne1iKEE/zB8JYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787357752; c=relaxed/simple;
	bh=1TA2bio4/II8+zwpwrc2qqpC4JhhhuR3h2RWPm5OjLw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XcojHLs2WValEe4mmO9ZvT3Qy4jVBH+dsdFrQm5MeS0lE+T6fMLlvfyvxD/031vANUXjqB46E+h3bBTmLYTQPbBU/wNrvIhnTacKqKk6miJwX+G65HMCCEH1y7i16+r8tLo54Xi88ib6fQndiuL7IFayZrNunH1SGUSQUbGxGYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M4sQVwgp; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4sQVwgp"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47f93b2fe4cso697420f8f.0
        for <linux-security-module@vger.kernel.org>; Fri, 21 Aug 2026 17:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787357749; x=1787962549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D4nn8Adu34scllPu0PVpeNyTmxzz7pa6nBrXKjE6XjA=;
        b=M4sQVwgpKSzyHi/WYFF2MDekN/8zvNv5wwAxNLtWOI6LIFbaw7THm1hJOFouboWre/
         tiLQuoLJgtEvi/XWE32fWxHvcjNrN6JXSgOA08HUIMD3gVf1XjDF+kr8UkquC6QBW5/N
         FJ9Frc9ng5bRDOzeTDlmEvWUZ5GFbmsfGtL8z30X8D3Wg+apdUrgFxT34mSfr9LSVAkv
         TIHIhieBF9LubggBAi4f96ksUBF0kfh3aNPFbdknS43w2x21XVYvVN2G4P3OjrrV/QdQ
         W3zUpH1GKk6oJVQbu1l8wYEfDo/mqAANcMmOqRNVzd24gsMN0o707hPlWIYspyalYfrK
         jEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787357749; x=1787962549;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D4nn8Adu34scllPu0PVpeNyTmxzz7pa6nBrXKjE6XjA=;
        b=YhvDkYi3Sb4ISbi506v70CXxEXzk+w6Oju9Mo5jvyLDOBiLWZJZmJL1mdey6Noq+Oy
         1OThdqVQfgGe0TJb3l8hj3MGlFbDbFsTQr7Q9u+NUCnP+MZ+eFXafk91YxGyk7IEc5h0
         jTfvG47hdpQL1e405CrbmId3uKj4VOkrpck5sIkIE3siiWr0VHrfXrgNo8Yf2t8BpomU
         utre4vWKEQkvsT3r2jVIPd6iBRVyuZT3Qgxmj5CKD6zrEt0imhy4r1JuqSDsidFElSNc
         Cw9d+YWg7T7a50HoYEcokjIs3fZ/D0f84vLG83qPR/DcVa2bWJrtl1qAVzb8LSQ8VBmo
         ioNA==
X-Forwarded-Encrypted: i=1; AHgh+RoM7dfsceH1tDxTSZvpUHPQa9UizVQk72dT4I0vPZ4Km+SV1iY3XI7FDwz7jtXtviYOrvcJSYaVTxxb342Mucgrg11n3c4=@vger.kernel.org
X-Gm-Message-State: AFuF++lgxmYXoFnIrUXMpS+MZKonnq1tzQrWqcUCbIksTf3StmrXRG3b
	soxZEp2WRb3tFU/cyg/lTheKf9zTciEG9vVy+eBTDm6UN0OZ2NUSIvVk
X-Gm-Gg: AR+sD12+5Oz7lBSyUphwSTUXcrJ4WGfwKepBiJjgPOi8+iUJaygGlzyOnxchLcipa5C
	BY40MIkciEL2ru2UZTe4ikRO9tV4QlJRDhTR3sR4xlMpEP4T8nc+bc7R45OAsgzzBrh0oQZklyQ
	5rFgv+THty1qUWIBcORhJ/fwEvgZCJGZN1GmpN9PydcyrYu4M6zuZLpYEoOaQSmnwaMtIRxQddV
	4oofBO0uEkzLe2KOZ+EJxyaGl8CLWQaAnhVOuVsFPr31L6jW9Glomk//PeHce/6E3qiElRU/C5U
	baMOptaOvx4O6s0eBhx7JiB1GroN/Y6dZbMaAB+rrBbiWKBYATsjR982scuvwTc87X6pRe0z/5o
	PBmdi/cGfCxBedw3JO66tD9ton/hgABmaVAQS6Ze/X0L2HgTMYqNQ6L49E8o35zioc9hP854b43
	LDraUHGsWrfwSeJeNOWkM6XQ6hMAgEOi4MiAd8ewMNBA8z5s1Yej9rBzNNNmAOiU6igynOBRG6v
	dzugGYnJ/fDV7V6Czr6Nm9Qpn7dHKYAi+g39jLFoO1pGf9c2S9D
X-Received: by 2002:a05:6000:601:b0:482:a8b1:aa6d with SMTP id ffacd0b85a97d-482c81bd354mr1785152f8f.10.1787357748724;
        Fri, 21 Aug 2026 17:15:48 -0700 (PDT)
Received: from nixos-office (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482c9b855cdsm445514f8f.16.2026.08.21.17.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 17:15:48 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From: Julian Braha <julianbraha@gmail.com>
To: zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: eric.snowberg@oracle.com,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Julian Braha <julianbraha@gmail.com>
Subject: [PATCH] ima: clean up IMA_MEASURE_PCR_IDX in Kconfig
Date: Sat, 22 Aug 2026 01:15:45 +0100
Message-ID: <20260822001545.354195-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IMA_MEASURE_PCR_IDX option is not visible for users to set, so it
always uses its default, 10. This means that the 'range 8 14' is dead
code, and the "If unsure, use the default 10" in the help text is
misleading because the user *has no other choice*.

During the first patch submission to add this option in 2008 [1],
the submitter originally gave this option a prompt:

"PCR for Aggregate (8 <= Index <= 14)"

then later removed it in the revision, without adjusting the rest of the
option accordingly [2].

Let's clean up this of this IMA_MEASURE_PCR_IDX config option to be
consistent with its current, non-visible state.

This dead range was found by kconfirm, a static analysis tool for Kconfig.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 security/integrity/ima/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index b3a9f86809b0..8a67bc1faa4c 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -46,12 +46,11 @@ config IMA_KEXEC
 
 config IMA_MEASURE_PCR_IDX
 	int
-	range 8 14
 	default 10
 	help
 	  IMA_MEASURE_PCR_IDX determines the TPM PCR register index
 	  that IMA uses to maintain the integrity aggregate of the
-	  measurement list.  If unsure, use the default 10.
+	  measurement list.
 
 config IMA_LSM_RULES
 	bool
-- 
2.55.0

