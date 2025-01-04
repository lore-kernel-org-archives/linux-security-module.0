Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76ACA1BC3F;
	Sat,  4 Jan 2025 19:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736017851; cv=none; b=TqVjJV2vF050GUZVPzS/uycjW72W5nK5h5sCLif9VrVtJbDR4sb/TuS3Ygt3Narg9IqZ2u/zDFL/PaJYpZ0zR/8TkNzhKKwHnJc+uyaoO1K9R4EM7SHxFFgVoeAibsbAf5GICHaAFLAtXtteDNrzCtn5ElHu5KV9nzaHjfWt8ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736017851; c=relaxed/simple;
	bh=yMgJodIbUsRJ7wab04YnOdHoEsRbT/OaiWaAd7LhxPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Thc6R6YXXU04w1QbQ0mA3sdcU0jg94HrYqrx0aQ6v0FsznXBT9DVfkn+wh0MVCo8q8NO+Beb6QrxfAYULvIwPcQiDx3dVjPS/DLYgpRdOKeG+Tp0SLvaBVcpnfEOu6HcFmfhzVrJYpzBXGzatPYRg2PzDTy9t1Qqk9FRvbRHmag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esceN1bL; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esceN1bL"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2f43d17b0e3so19116777a91.0;
        Sat, 04 Jan 2025 11:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736017850; x=1736622650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nCp1LctgbtIsrhfT5VEdZDpJzdvD9HslTNDKIgXraSQ=;
        b=esceN1bLZhrKKELQf6S79ITwTmsA22YmgTqla+RuSQO19qo07K/ycSkRH8C3Zn/IPM
         B9Z3iGr8RGCRxr04txNOWmNceUEquOeve1JZD+jP3w7LL/G/gGZYsfzRMLsTRLx3fbEK
         tkbuetmNDfyfESqkhcETrodzc4oR5KX2frJ0OGcrrhOfzEr7sQ4NxwgT4tHpU9rTl6A6
         zDGrqnkQO3hxCyYZSasi3TAbSIYcHCcr6PsyfFwuycxZibDK6mGvbQhnSY8htbO8uIh8
         bXL6YNTLwW/pnk5LMhlYer5GQS8O/WmMwAyotRsX5+7MF5wDGUZa/QCrr9uNSMLrTEv2
         leEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736017850; x=1736622650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nCp1LctgbtIsrhfT5VEdZDpJzdvD9HslTNDKIgXraSQ=;
        b=LWSyKeZAwWBfXao5EIQbZJj2UHYdDj+9BGuxST5QUN4AInqOjKCcaU8AeWgvD9tEz4
         IMoqs4iw2fhQg5DvDDYHr+i9f0pivyufgNujtNC0N+QmSfttHYdrpqsTCaYuTN1bKhr4
         jk5WibbYruNcyP1AMzj7YXOpNGvwxQiApxp9FYbouf6lei+rMvZ4qrnc7txsQy0qWSTs
         OgFjW3iM6N+/QYMNBoHc9aDwKHzx8HiXQM4ubrNlQUNRxb4d7KG75eS49SCSOCPD9ufn
         ciNufVCoYM855VNb80u8Spi3MLtdgPg49z7ZfaSW3W58Hy+pa4UqN2hoDT0POl5eJ+pV
         0ddQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/gnQbw6n4jK1gqCL0jvZohZ3bGhMxPBrFmhYv18KHFbrJjXmL/hNA4yyyuFczKgzNDBxdqQ5goNGLhegZMQSd56s+Ujy5@vger.kernel.org, AJvYcCVfxGUhi0/NUy3eCv6taCOU4tNiEr7AoVGmdYUe/cNWuL6kD6OW+VE42tzTqbx4zDPn1+io1aTT6nGIXGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxQE/8QMdwI2sGFvo9eGeoRcGqXc8mrf+eeJ5gdjEIvNDEPg5J
	9fqG1qI233XlUCuEM88OvqvksDvImd+AsLNVzU4w7TR2hIorYUDD
X-Gm-Gg: ASbGncvIG4Qj3bTyRf09lxMFoR9RjdzgcfAGZvxeDbBSod5spNQNTqvOnL6vCM5o3JB
	QvoHrXdVetE6Gzvz16PaeO95lgdKv5GD4Pl/rHvfjyqwr1rTZtHR1KCgYHBnecF2gHi+wpumH3Y
	ONfzGiPul794J2y0ESsiQnawc2eK+3KUxnmxCLAWSfSyFN1FboYM/mjdKogZVBqUDX5UZ2RNbBm
	soYZCq+LNwy02RUDPk4Et05Cioik3y7CHtY6RADOgLWFyORwAFEGFI=
X-Google-Smtp-Source: AGHT+IEtQrqh+Im8CD5IidFvIYbYD8UjigmThMKh5DxDwHSeiAvu18FU2z0qsKXIbMrrOP1YJwH5Sw==
X-Received: by 2002:a05:6a00:240d:b0:71e:6b8:2f4a with SMTP id d2e1a72fcca58-72abde04f6fmr72906061b3a.12.1736017849762;
        Sat, 04 Jan 2025 11:10:49 -0800 (PST)
Received: from localhost.localdomain ([223.230.110.17])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-72aad816459sm29287716b3a.23.2025.01.04.11.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 11:10:49 -0800 (PST)
From: Tanya Agarwal <tanyaagarwal25699@gmail.com>
X-Google-Original-From: Tanya Agarwal <tanyaagarwal25699@gmail.com
To: paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: kees@kernel.org,
	yuehaibing@huawei.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	matthewgarrett@google.com,
	skhan@linuxfoundation.org,
	anupnewsmail@gmail.com,
	tanyaagarwal25699@gmail.com
Subject: [PATCH V2] lockdown: Initialize array before use
Date: Sun,  5 Jan 2025 00:40:07 +0530
Message-Id: <20250104191006.3807-1-tanyaagarwal25699@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tanya Agarwal <tanyaagarwal25699@gmail.com>

The static code analysis tool "Coverity Scan" pointed the following
details out for further development considerations:
CID 1486102: Uninitialized scalar variable (UNINIT)
uninit_use_in_call: Using uninitialized value *temp when calling
strlen.

Conclusion:
Initialize array before use in lockdown_read().

Fixes: 000d388ed3bb ("security: Add a static lockdown policy LSM")
Signed-off-by: Tanya Agarwal <tanyaagarwal25699@gmail.com>
---
V2: add Fixes tag and reword commit description

Coverity Link:
https://scan7.scan.coverity.com/#/project-view/52849/11354?selectedIssue=1486102

 security/lockdown/lockdown.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index f2bdbd55aa2b..df2c8435a7a9 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -96,7 +96,7 @@ static int __init lockdown_lsm_init(void)
 static ssize_t lockdown_read(struct file *filp, char __user *buf, size_t count,
 			     loff_t *ppos)
 {
-	char temp[80];
+	char temp[80] = {0};
 	int i, offset = 0;
 
 	for (i = 0; i < ARRAY_SIZE(lockdown_levels); i++) {
-- 
2.39.5

