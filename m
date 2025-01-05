Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00612184F;
	Sun,  5 Jan 2025 07:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736060776; cv=none; b=lLP2QgFF+85hh96A0b407INpKg2QHH8CrAjA+pwomrR3seoXXRSH0e+eaA5jsZWSb9ISkDKSmoK0fe03j7FOFd/+BS5u/0LhiLzyh4BlwrxelM4u4Xv1Fc5j+8kvImRiTmfo0Y7rSB1heAWAd18cb3CK5Qdc5/Hunqr6COzHu+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736060776; c=relaxed/simple;
	bh=us0By0+czy/IeA053DQK1Gv63DXcM15dSP6E+/+U1xg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZmvsAYixxOjgAngsdqblIu+HJQ5pk+OS7f2TsXW+zlyqMW33N5ul30wINcX5U2oBPghESozldXwMLN7I6XkAio0o0HWSWpsEyaDzT6hsr8I3eKBPxGp5TVA5K1KWB3VgnMeCLAkaVSOG5lsFASlUaJR5zhTZxv812KjGiMIlOWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jnBWzKXo; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnBWzKXo"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2162c0f6a39so197621025ad.0;
        Sat, 04 Jan 2025 23:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736060774; x=1736665574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WWaGLO8BLkY0SXFBPiNHcnaHCt4FeeQz559YhzEDB6g=;
        b=jnBWzKXoFNPrt4X7C0dKdgo14pAX1ozqr5ifsO+uBwuDjPj/jt6w/b35La7yfiPCGX
         yU4eoxFu85rfpehEH4o2S0Q1kVJVvGWwdVRVPImnVdQHx0F2a7IpjsGxnl4ghoIbUP80
         UvV7doyB3TutFIGEJBPV9OFAY/6NRc3bs3QJ0zaZCunG6K6XlBDjW2eaX1ra67pjb1qU
         OVkOMYUzfMq1D/nlaKB/G3uL8YyBDTsTx60q1ArnpbME/m8wkuYMZsbTNGby8ZmcpJns
         vkpVxVQtX/zH5Xrr+XWGi1EEP+uzkDXMj5CXaidoH5tO8cmQ6ngGl0opsMBheQdU90RK
         fLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736060774; x=1736665574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WWaGLO8BLkY0SXFBPiNHcnaHCt4FeeQz559YhzEDB6g=;
        b=xRCuJHasgFgSZwXqaDRiQgOIiCuh8Sna0Q0gOrN4uNgaZsO8gmrspUrnA1L95YmsWt
         zkUfL0MiLmKYED63E1q5teSj1D/TVc0YE9PmIelFvAUEMxMZFuLbsuXIp4vbRY8I45ZY
         cXnPE035eOKXPz8rH+bY/MGWdiiLa5U5Hh/B745ZB9dSUjWNZB4+STCMKnuHZGXeaLOm
         Pqj2CW+YbP6n2hUXAfoUa736tlO7fLWqydP2Pbd1AzoElJYUydLwz8auvHuF4g1lE2Be
         Rur5kQZqBvhehchn36YR+nmJmji2L3K+mFHpdYmh0NnOmdD/NTXt6JAdRIyER3lRXpHi
         6r6w==
X-Forwarded-Encrypted: i=1; AJvYcCVDoXvU+PlPy8xHVAfU8n0jOSp3lA6Wt4x67ae5204lwuJqe3n8s9NuCQN7XzzLdkh+LZODehWiByjvEK3b7CU2+EToMiGt@vger.kernel.org, AJvYcCWEtaEhmdRiQ8mPP6AjnHLVQZRVsRZd4gbppOWvN0j35okYdE44zo/wdrFU3Z+73Ngd4466W10f0+yYzMM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx8mDz4rsQgXs6NQKJQKvmHV6r+CEcJblgMJ6o+u8R8usq3zfg
	x2nOHRztZjyB46UIN4WtMQca67FoV0MEtyaPRXgs0iXDVDUMbndW
X-Gm-Gg: ASbGncvII+4DyccSTrVcihKo3aLATetwd3xeX+ZXhdiuYUTK0OFmvifDSNqx5luK4aL
	B+iVQsee5K9s3VNo1pZspZ7RmPUemQDf9mh9XfT5Mdxnp/dm3s1dgtW+vlEstFLGXW85UORytIz
	FSVDYO+Z1FobeDzeBeacJ8kYxX7Wvrq83vOuQ6MLyUhqUyAXIm0yPLhygSswVZABOitvQ6KcM9/
	S9ecIbBXDx3RonD44XqM27QptwEL/CYuec1UDUK5RzgFyQVNFMJ4+o=
X-Google-Smtp-Source: AGHT+IHTvpwPIYM6njOz+4/OuRjY2dxHVHcif+t21Tv/f8XBC/VUYi3gkX0MrXMII7HxNHpmWRjiiQ==
X-Received: by 2002:a05:6a20:7345:b0:1e1:adb8:c011 with SMTP id adf61e73a8af0-1e5e1f57c8cmr81665710637.18.1736060774113;
        Sat, 04 Jan 2025 23:06:14 -0800 (PST)
Received: from localhost.localdomain ([223.230.110.17])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-72aad836d22sm29099223b3a.77.2025.01.04.23.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 23:06:13 -0800 (PST)
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
Subject: [PATCH V3] lockdown: Initialize array before use
Date: Sun,  5 Jan 2025 12:35:38 +0530
Message-Id: <20250105070537.58334-1-tanyaagarwal25699@gmail.com>
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
Initialize array before use in lockdown_read() to satisfy the static
analyzer.

Fixes: 000d388ed3bb ("security: Add a static lockdown policy LSM")
Signed-off-by: Tanya Agarwal <tanyaagarwal25699@gmail.com>
---
V2: add Fixes tag and reword commit description
V3: use "" initialization instead of {}

Coverity Link:
https://scan7.scan.coverity.com/#/project-view/52849/11354?selectedIssue=1486102


 security/lockdown/lockdown.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index f2bdbd55aa2b..cf83afa1d879 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -96,7 +96,7 @@ static int __init lockdown_lsm_init(void)
 static ssize_t lockdown_read(struct file *filp, char __user *buf, size_t count,
 			     loff_t *ppos)
 {
-	char temp[80];
+	char temp[80] = "";
 	int i, offset = 0;
 
 	for (i = 0; i < ARRAY_SIZE(lockdown_levels); i++) {
-- 
2.39.5

