Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428B3175B1;
	Mon, 16 Dec 2024 03:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734318163; cv=none; b=YbCVQLV/am61gAkZhutfCrd89KQxt2DU72yzGrLDdoUCIkTGWvaa5opPQRxzp/ZIb642jkP2udGeHPt1kWKOGqlNcPD+Fkz7Gp9i1syighhrc2FQPNI2DXf2aFmLlqmX5hjJZPR8oj+1lYT5xQgZTSR/IIGRHOkMY8dh5s2oOVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734318163; c=relaxed/simple;
	bh=wZSF/1Moz2fJ8cmJfElnDgiqM6ILDkxCuvgUaTDyYQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lk5+kxhT7hXw1hMwq4n29bbela48t/ibTA/4i3URVSEyK8f5UmsYkr4L7Dmc1lQRQtpfsuF0QU4gLk24HKJWH6nO1QuD8ZcPrwWrgw0Q/2wJXtwECeaiihMbwZ/rbdIB0q+rQgFmmbM7atQmMFp6jBiWimvOzjoK+zjneH0jjrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWNRbPrr; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWNRbPrr"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21636268e43so44295845ad.2;
        Sun, 15 Dec 2024 19:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734318161; x=1734922961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=//C1ShOl3HMrG7+AaGRFnMR1DR2xz1w/54bVQBlCj6Y=;
        b=iWNRbPrr/EUphvhLMEob0hLjvR0HMi7EbLEWT3SIvPUC3N5RXsXmnm94Pi2s4TsY4t
         kiOkx6NDNfUExnnBjiAVYI6qTSk80V7iPpWz/UvNmmfZLkPWmlhNEXwFaDu75/X1wMiB
         uqfgjSSip3XUo4Bdy7DVSLk/m1WX9Csyv7Cn56cwQbfEymJUlGK+xNuuSCQjjsMtAwQ7
         1KYP1KfYRE5CuE93e8oLiUucQcVTiPFhO9cSU9d1baixyY6zcALCplPnmej7UuAOv5lv
         iyVHqxQpBlvvsXbaZNJfm0heKNWPI3QcTUl8MJlKoRdmfsu/vTjRLu0OPtwR6UN37rTb
         9Fjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734318161; x=1734922961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=//C1ShOl3HMrG7+AaGRFnMR1DR2xz1w/54bVQBlCj6Y=;
        b=PgIquntdnU5e4jqzN890O3XwcLSMBuKlR3PckoMYyGCdwu2IYgDhS/OshgMx2c0/tx
         /ryzUufGSAkTdgH8WVUuRPbY+d3jNPO1iEkTigpLACu0vsxcO1PvxP8T/SyyMDHCgwOY
         tuRwH+nhNj3fbEAiBe2RI0Z1E4Dtr/d8Ad7qv6JMt5kc26YyoRx3nxmZRN9V8RJZLFKs
         37EfnHFKV0Ho5oXu/a1A9OQPqVhXpJQ8v8HnK93Ui1FzB4oY1YabWj1ZH6ikxe7NYXmp
         CN8X8qWG8hLXDVZsgat4VRUJJASchGKeYA9RVFiaD8mplrGzAPDFfyEEdpDOw/EWLk3X
         UKzg==
X-Forwarded-Encrypted: i=1; AJvYcCXCs5dXLj1mVQvGSI0bFO6Xjt/JOJLrZNU4LHKKZPExf82GEkuUzrgERb5ax9WkKCvr8/B6cZqGxvgWeCI=@vger.kernel.org, AJvYcCXdTffijJzE0agKK8ngXO4RcrT/LrvPXY0sLjk90cHpx57YVEyjDImhKGcpWOVhMnStC29Rb2XsxRS/Nh4lG66j73vVULIu@vger.kernel.org
X-Gm-Message-State: AOJu0YwSisYwqj2P0xKlYhSBOt0Xe56K77LVDZwSRVJXuQS2pIjcQiB6
	PjS2XCyzDxDyQbts0WZol7V+DjbL9WakFXmY7EP5Fdpbr+Y6v6y9
X-Gm-Gg: ASbGncs0a6aoPMYE4KsAh62HHfiGDTIc4FDZb8G8S3ZlHkwzg5Eo7n+w58ES+3IYWYm
	0ppMZ4OxD3XK7KRuZFvWAM75uFTGeQF8jwQ5oMeiY0sAYSnQh4+u4okuSCq3Ife4Ys1Msuu1Tcg
	OkUT67XvRGMzcuaRbZ6l6BmvhtO8VvQE+xp0OKjWvgPmTeyT/yN0n7C+TZZikWzR/vsb3exJFsr
	fCxKGNK+ntxTLWSAq1zBiaQ77uc9loofKQDe3D93axBHtdLza7Sv23CN5OOptIWcYk84bjr
X-Google-Smtp-Source: AGHT+IGw2rx0VBojBUA7chJeZwjuHK7yo5V98FM0S3GHGQDraiwOaBRtEu+HvvJdrM2/BVpK6uNvSA==
X-Received: by 2002:a17:902:ecc9:b0:215:a3fd:61f5 with SMTP id d9443c01a7336-21892981131mr142938915ad.5.1734318161410;
        Sun, 15 Dec 2024 19:02:41 -0800 (PST)
Received: from tc.hsd1.or.comcast.net ([2601:1c2:c104:170:d782:c275:5ae5:7e7b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e6d918sm32600035ad.262.2024.12.15.19.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 19:02:41 -0800 (PST)
From: Leo Stone <leocstone@gmail.com>
To: syzbot+4eb7a741b3216020043a@syzkaller.appspotmail.com
Cc: Leo Stone <leocstone@gmail.com>,
	jmorris@namei.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	mortonm@chromium.org,
	paul@paul-moore.com,
	serge@hallyn.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] lsm: check size of writes
Date: Sun, 15 Dec 2024 19:02:11 -0800
Message-ID: <20241216030213.246804-2-leocstone@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <675f513a.050a0220.37aaf.0106.GAE@google.com>
References: <675f513a.050a0220.37aaf.0106.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot attempts to write a buffer with a large size to a sysfs entry
with writes handled by safesetid_gid_file_write(), triggering a warning
in kmalloc.

Check the size specified for write buffers before allocating.

Reported-by: syzbot+4eb7a741b3216020043a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=4eb7a741b3216020043a
Signed-off-by: Leo Stone <leocstone@gmail.com>
---
 security/safesetid/securityfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/safesetid/securityfs.c b/security/safesetid/securityfs.c
index 25310468bcdd..5eba4c7f8d9e 100644
--- a/security/safesetid/securityfs.c
+++ b/security/safesetid/securityfs.c
@@ -254,7 +254,7 @@ static ssize_t safesetid_gid_file_write(struct file *file,
 	if (!file_ns_capable(file, &init_user_ns, CAP_MAC_ADMIN))
 		return -EPERM;
 
-	if (*ppos != 0)
+	if (*ppos != 0 || len >= KMALLOC_MAX_SIZE)
 		return -EINVAL;
 
 	return handle_policy_update(file, buf, len, GID);
-- 
2.43.0

