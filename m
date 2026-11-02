Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793630855;
	b=cJFXQtIxtA3mtZwzriwqfoCZVt84IFaU/YNaA3aOszZDPxcqYzcx4GKxGDeiNdeukd3r
	 VpLUEnJItHA5R4SsdsuYC2fOHBBXD51RV01GUNNVo7WcGfRYqPQzMta+4H9REyEVcqnke
	 EgqSxpc3LDTa352EY+DvLJ5hZZNBqAzT2MCXGhom4Gat6EjcedjwFbggadjYLgDs8otvZ
	 UYi5aGzIBQklSRubD+oji9tM93NW9QpTTY/dPCyvMIooWmKjXPE6qf1lLb/E+eAjvzRWb
	 P+CZQuRUwi5tcVU0/lXcT96oMO9GHwmxn1TiczOsNClJ7kHVYn9J71rmPDTc+6xFgqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793630855;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oT4Jbe6Fru25zhLhLEJ1T9RC7Hvj88zj5H1iBQsA278=;
	b=MSISTE0KdeCEpVs78S0Zu/U5vEK5dDsEd8sNQYE62ncSRmJ5kfGrM5oJTd16wOtl9nfj
	 gJbPuFNIfRKDAwf3hqBPuAqQHNOAP5ifUAjdSihOvNlhMxoC/quYiQZ5zQmZwBNWu0eSX
	 mJNLS4ASi31M59ZzWCo3mutzLabuIJXUUa32zv8fYQC1i1WDehsIvxv7fkf5/y0P8rfG9
	 trHhqcaFS8jSHrlkxdCTfZ9Bt8hr1Ldo8Rjt3gT9dS6+68lf3MzYvnWFrPUWofSl0wiNE
	 sfz582KTTt2JZ1oUYUcNu7gx5zY9//OoraYvB8vM6t2d7OI0KB86nAaiExz9PBn6M6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0MPQtbUF;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB706070CB2
	for <linux-security-module@vger.kernel.org>; Mon,  2 Nov 2026 14:47:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFB706070CB2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0MPQtbUF
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso31389395e9.3
        for <linux-security-module@vger.kernel.org>; Mon, 02 Nov 2026 06:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793630853; x=1794235653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oT4Jbe6Fru25zhLhLEJ1T9RC7Hvj88zj5H1iBQsA278=;
        b=0MPQtbUFiIYqMYA5nkKT3jgVlsrDXFMLqLQG0cAkdVprvoGXa7fmPw74/hlGHHIpD1
         l7A1+FXZkEpL3a6cu9WXmcdZkGxQfHRoDORVZVhJkQK7Rn7tcfJhI+ZpYku2kh0YLmbO
         gRgmqtPpjxfZz5YWZNfSJ6tOOJiv6YBFcIowVZtBOmM3erF+BLvsHVrkKly9+baLFh+E
         xKoYCCOJbQjQCDqZHIHY8jOVQy+hHVb34aO8HF1o+uGDjG7iI7YpEg6ui4POZgvy4ZTC
         FMG5AbnqovPt4OotR/0vRTriJHvIlbm9/JVUjwJAu2R8pMQg9H/WQcRJIXD8uqXparxJ
         XASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793630853; x=1794235653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oT4Jbe6Fru25zhLhLEJ1T9RC7Hvj88zj5H1iBQsA278=;
        b=l5vQvr4bnxEQZIaiWdsJeBdq9bUlGJphV4GR6eE8f2QK3DstMBrWrqi08wGD/0SMwU
         HriSHA5A6SKzVB3rQVN8j1jJt70MR+9fUWsgHe4x7itY8jXrjBfaCE+4vr0gUuc1mDDm
         +rapUWx7psddDz0fDWqVSnUaqJzIST95cM9FrYlQtXSjNCmJS+6v6SIwqa98HtUcR2Rn
         h8/k01ekygeRU6L0zhlXeWyhUNCXdl44eroQ3zNs7DF3eCoc1fCHSA36+73RErCwiWO5
         lY7keNNXRYbS7Sq+cunoguRZU/dD0GNDlF+75/yNlnVy7b9B9Om5sALxZtSo9vREq5hw
         WFrg==
X-Gm-Message-State: AFq9FYIR3zg+hwWdwQFFD0ZHtHq4OOvKNBCpIJRNkkGEHVAMtouBHw+F
	NCLAN6aI+Y+d1MdCdtoR6nathJEyUU0CA9xYyA3SVUrcsgESUEHMJis+
X-Gm-Gg: AYBFou0CvwdBg3Lp8CZ780XHNW5AgCM2y8Cd8ML8MY1V2U0GnXXZpwrG0q7sluFuhAX
	CHTIO9AZPSlHJ1Eua/eAXZUvuSyTWrv6JNkjADT/CC7dSsNVXgl626L+Ek1e/BhipBcMQqhznb5
	8Usw9hHbx75X2fvm3rVI5odBP6MFtIiMoWiz064LUMwdhtZKVMHSUg9iQzzICrU3DETGyyAFAct
	Nlhqog70gma4zKgwRWUoHHLbGc8mqo6XIMwi/98Gzjez2dE6x+M6UP4wdKPbK9qXtMd1fNAnQzP
	UquBj2oaF2q5exFvmYiXnnZK6q+4g4XysWC61qYB24ZzEjNnujUQ20/KSTSp00UEbAb9/iNA7Bg
	pK5dSPNKB12gyh+f23eU3wMRpVzxWuLCwOBb3EgBzvZNtqzmehkyLaDHkwbtHVDtbwkbdX6aeJ3
	6y9679xJz7jQpuVRR293XMpmV7teUYBFoyopFIryhBgLarfOxQeNGOrGI+eOdFUNzRcuAtHJ9vg
	5IdDNgSC+uJhn+dhVzPgvd/pxjTj6v+UPbG9mMYFR4FBEnzS3pUdFbREn9nv+KDZ40BT9YHf5IY
	HTWFW6bUy4Q14ChmZW9E6pDspUmEk+TdISVLMjSn
X-Received: by 2002:a05:600c:1387:b0:4aa:2339:a375 with SMTP id 5b1f17b1804b1-4ac1793fa6bmr245939905e9.13.1793630853040;
        Mon, 02 Nov 2026 06:47:33 -0800 (PST)
Received: from penguin-ubuntu.lan ([2a00:23c6:6410:5d01:8464:9a6f:2d42:8827])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abe7700c3bsm254289965e9.0.2026.11.02.06.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 06:47:32 -0800 (PST)
From: Oxana Kharitonova <webprosto@gmail.com>
To: mic@digikod.net,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	gnoack@google.com,
	utilityemal77@gmail.com
Cc: linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	webprosto@gmail.com,
	landlock@lists.linux.dev
Subject: [PATCH v2 1/4] ipc: Move MQUEUE_MAGIC to a shared header
Date: Mon,  2 Nov 2026 14:45:57 +0000
Message-ID: <20261102144708.920232-2-webprosto@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102144708.920232-1-webprosto@gmail.com>
References: <20261102144708.920232-1-webprosto@gmail.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move MQUEUE_MAGIC from ipc/mqueue.c to include/linux/ipc_namespace.h so
it can be shared by code outside of ipc/mqueue.c without duplicating
the constant.

Signed-off-by: Oxana Kharitonova <webprosto@gmail.com>
---
 include/linux/ipc_namespace.h | 2 ++
 ipc/mqueue.c                  | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/ipc_namespace.h b/include/linux/ipc_namespace.h
index 12faca29bbb9..8a15ffe38e9a 100644
--- a/include/linux/ipc_namespace.h
+++ b/include/linux/ipc_namespace.h
@@ -15,6 +15,8 @@
 
 struct user_namespace;
 
+#define MQUEUE_MAGIC 0x19800202
+
 struct ipc_ids {
 	int in_use;
 	unsigned short seq;
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index d1dd36a651b0..0f00e4efcb60 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -47,7 +47,6 @@ struct mqueue_fs_context {
 	bool			 newns;	/* Set if newly created ipc namespace */
 };
 
-#define MQUEUE_MAGIC	0x19800202
 #define DIRENT_SIZE	20
 #define FILENT_SIZE	80
 
-- 
2.43.0

