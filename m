Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6F284037
	for <linux-security-module@vger.kernel.org>; Wed, 25 Sep 2024 19:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727292032; cv=none; b=FTmyulOlJ4EsvJE789Dr8upWhRTrwquL+HMRS0VwNkWUYar19d5WQZwDsfIvQvMMiMO0KuIlhj7QoiQY9n8ES6T5doNTp9YwoNZy8VLHzjN1RcqDRx76UBBpKHm9nQjOEmkghqAOUFD6HPH0fFyBlrbKcNf4YV2qWDY93/ePtaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727292032; c=relaxed/simple;
	bh=bUwyJE+2HB4BFiaxFSQQ5eh7au+JrhTrHh6hJ2Ml5f0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Hn2eJRBNd6/oqJHrmmQ60Y2J1kxEKmH09UjspINbECRrIJCjv/F7tGhngqXetDlEAjrcuVW9Jx/6IZmGjtmWhCfeQRfO8AhGTcBgnf2maLqZfydo5w9kkkx/idtEdahefaCna8eF2//Zz9tPChnuWLqrM1xXPsLudKVjPAnlnI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XXtraLGD; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XXtraLGD"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7a9a7bea3cfso14948585a.1
        for <linux-security-module@vger.kernel.org>; Wed, 25 Sep 2024 12:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1727292029; x=1727896829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=glGirgm+F5nwQC3LNIKP0kswh+8E+08E5znnFLU+t4Y=;
        b=XXtraLGDpT9V0pnRdCP5XA2bjK7Zyc650c6kGRBSXcMXPBzcQ+kvThWz9KnDQLeZOM
         1OM+Nu1q3DwP6c2VlwvXVFJhxUBtde5XNM2Z2Bm6JAG6MidlKOLu6ui3rWRi7f81PaRQ
         Zpg1PgMrErKylmOjcB57979CksSuQPlTtKFC/zIwLnuhwgGhsfopNyke/QZHJg69X1/L
         +xOqyg19enJVYvsF9q5h0OCzQ+EdEULDsh1ZISLM6yMrae/k/R/3DlQWXBq6tPlWvrDq
         ID3LFJ/7DK8imKx5Zpwly+I0nNEKGcrL5j4w41RSXACOcprO8YrYktXruPfpPRWzn4rb
         2/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727292029; x=1727896829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=glGirgm+F5nwQC3LNIKP0kswh+8E+08E5znnFLU+t4Y=;
        b=kZxpdgOv10Gr6ctCGUjDS9ZR4rR6iPowzRlpYmbcFpmoNKMv6eEf9Qw0d4Y3btYbYC
         q2cVKTgfh88Atrxc8ePzba62ULdi4rQ9JNTJgHpmxuL5TbsoiCrr/kmgqxzkJO8w6GDk
         0N9AZTSwfgQ/wYXVvk1yO8MGZs1BsfA/yynihqeLs7Cm9FHr29w9yWcAOiJkn+DNh5/g
         A2c/08pCV7RZxgk4SuzZVZGkcXnWt1+kMXH7dVkVBX792V+mnCn8DhtUvPlRC0/H3fyJ
         EX7QorgJ6gziWHxmq2opAbto2V8v/0601JA0ZZra9L2DFJMB2EJcKYyhccomwYV7Yxxa
         bdUA==
X-Gm-Message-State: AOJu0Yw0Djccc8Mrz0gXFdwajUF3Yd9Jj9uY+7k4aAvyeZiEkWZ6+5Uz
	NJunkOKMISTEFnnHEwk6wClR77AIxJr3I+L34+rMHBdjfbT7KRxDJbFsRgmyYdEct9Nglz3oJ24
	=
X-Google-Smtp-Source: AGHT+IEt5Vc4efcFyhe1HCk8ez5tzWlppLeI8khusQahmyiae2qGVRjhKhTEnz7BvGtG/ToLXjZZAA==
X-Received: by 2002:a05:620a:1a27:b0:7ac:9aa5:c5bc with SMTP id af79cd13be357-7ace744d90amr555821785a.47.1727292029469;
        Wed, 25 Sep 2024 12:20:29 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7acde5fcc98sm200134085a.117.2024.09.25.12.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 12:20:29 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	serge@hallyn.com
Subject: [RFC PATCH] capabilities: remove cap_mmap_file()
Date: Wed, 25 Sep 2024 15:20:19 -0400
Message-ID: <20240925192018.15290-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1174; i=paul@paul-moore.com; h=from:subject; bh=bUwyJE+2HB4BFiaxFSQQ5eh7au+JrhTrHh6hJ2Ml5f0=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBm9GJzVIDZ5kZv4QV5FHQdvRtatIJitq217QS3n 1VOWZY+C9KJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZvRicwAKCRDqIPLalzeJ c3Z/EAClFziXUbIcLj3qVdEB66thzEz+Tb+DIvvlGzp0RtERwa952Dl4b7qJrqFcPdgmiJhs+37 e3CCDb0+a9iNqKITB5v7J06gu6bqgmevXm/b3iBZNjsLdMY7OqD+bNaDPhnFCUmHBjO18UHOr4A WZs3HyXHW3TVIvvUwwbF5jRy6dHwj302+ihjHy6CFqqwl/D4Vaz2mbRlczx76n5UDbDf2K4WbIM jJfqRFNN/ztVvOXZ4x26sJpfP9Q677jPEu6N1Hok8uPcHvVN1OkAdFqVMBAMWOso769Uyry2Are xWD+gMTX6ppX9TRl+mKo4o2nGf7HOBtsjpcV6Suxqb6dvz8uML9K4l4zXfsS7cOcplXqvj/ezSt yDjf58SPfVFhqFgGDU6mQYhvrNTLbQc7fx4cm+kq0oxnnWDYlFs6J4GuBoJQaRiu+dlZb8j5N3F HRSa7WdKXvJR8pNqnp6zmBi4K1ekgyYhcJJ+xxvHlC8eoeScaEA032lh05GbpA//a8J7sIovZ2t D5cyodsG8Oi0v0dc+GujmT1MYWbPa0vo2Y6BMmmuA2Ws72X5RXBC4Cm4CbbU8i8R7AsNfYkHiU0 fhd7it8P/ywLubk70cXTfg4zRgzOXNeT1etOuz7da/H85Tseha4eJ4UbgP9kSVbv7q7xlriD1Xq ovWSTsKw4KVXv8A==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

The cap_mmap_file() LSM callback returns the default value for the
security_mmap_file() LSM hook and can be safely removed.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/commoncap.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index cefad323a0b1..3d103069903b 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -1428,12 +1428,6 @@ int cap_mmap_addr(unsigned long addr)
 	return ret;
 }
 
-int cap_mmap_file(struct file *file, unsigned long reqprot,
-		  unsigned long prot, unsigned long flags)
-{
-	return 0;
-}
-
 #ifdef CONFIG_SECURITY
 
 static const struct lsm_id capability_lsmid = {
@@ -1453,7 +1447,6 @@ static struct security_hook_list capability_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(inode_killpriv, cap_inode_killpriv),
 	LSM_HOOK_INIT(inode_getsecurity, cap_inode_getsecurity),
 	LSM_HOOK_INIT(mmap_addr, cap_mmap_addr),
-	LSM_HOOK_INIT(mmap_file, cap_mmap_file),
 	LSM_HOOK_INIT(task_fix_setuid, cap_task_fix_setuid),
 	LSM_HOOK_INIT(task_prctl, cap_task_prctl),
 	LSM_HOOK_INIT(task_setscheduler, cap_task_setscheduler),
-- 
2.46.1

