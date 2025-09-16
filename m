Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F148265CA8
	for <linux-security-module@vger.kernel.org>; Tue, 16 Sep 2025 04:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998117; cv=none; b=Tip36mP1UFDJ7ZeXtAGnIEZWEYtaLX6z9yWnzJFSPPuX6ke2kn/7Rgjkcv2vJdBuGBZJq2E3bIZGaIMx9JOK++FhHSMmNz6zXPqaueMq0artxg0zTeZVwYxbHIDxjT6o0EgYLHe6MD+mxqlU/3R/o9MnLbBuToCtM6mF/Nko58c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998117; c=relaxed/simple;
	bh=ivk1kCPJFe/BzZPF72WSq3DpdkZ7hkdmk3r9ydq31tg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MrcD0l3MbQ7AP8m0/0cynRL31elq8I2/9JBF/dq72Pm7Uz1m84x8Z2+YK7qFgK9WMl7eFOo1MhfNq9aiuLCQSEK95y3x0ukt3tw3P4bWkJLXuC58AS73yWAGgr6rCiuomyNfrm2r10ZDC5m+WOUECXaWY0HgoLK5lp6dftgh48o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ldcgaDct; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldcgaDct"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-32b8919e7c7so6774957a91.2
        for <linux-security-module@vger.kernel.org>; Mon, 15 Sep 2025 21:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757998114; x=1758602914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lT9DsPVy8x0mlOTAyxJueu7zb5O+t3UCUBl9ED2OMzE=;
        b=ldcgaDctXOfgSLf64W5XTkXL3DEk6cNTh/hZtEwwAoIMEXJ7nBBWetX01vNPBw3b9W
         jZDo/ihzinvGc71TxgSzbCWg1MkINwXVj+isFkr0JB682qWP40CLk9GcO4jjh8/pDWu7
         KuRU9hXBGyaKtbD3e/8dqL4Vb9A8A1Cl1Ci87LIjq6sFmpY+k+tnzg67+pGgYhPjGDUQ
         ++nwCK/Qi6G1Yem5BVlYpjZZKxqRdvGMMs6FpSW/SQlCGwMbnWL0p7yJ4CdB+XR1KlBY
         zgLgJHEOAdHxuTL+O/NFH4O8mWv/mnq4ZzNT2O8rhaM3p0qyK/3C9A2C2JE/av0S2fQt
         IGdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757998114; x=1758602914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lT9DsPVy8x0mlOTAyxJueu7zb5O+t3UCUBl9ED2OMzE=;
        b=stP8GGChxt06cq+3ltXlAdAUdv2rMcNaPiYtOGo90FzBS85ClUmCYT+7F/MyRfM4MD
         0k0JHJ0DBL7g3aSOzfifGEPJ8LndJaz/be9cHVSb0gn6p0whCavLlk9YmFkYTS5hVMLr
         kXWyIWHfCSFyLgDziGW/30CH9SQwVLlhzqRV8iDuExBV7DD3X6XhYRQmJXL8AvDACUlC
         YYOqVyGulXThHDGySOsfItJPPtDR+DBESUK76KKTSqvDp9+x5okaB+b05k6OqWZsHOFG
         cxq+N7zONLb6DJICBCiXvWUszBEabZmlIaaxl7bXW/KEZepXzUPGcrXGpnVlmuSxdhik
         uBag==
X-Forwarded-Encrypted: i=1; AJvYcCU/HO2wavGxu5hSy5uwi+dpYEG0rC2bR212b4YOJcaWJ8N6WdTv8Oya4GCW4JIpbDOoTp7I0ZkEYJ2dLJaEU9xpEOlggu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbiPEBrP2l0SFU7AO8/mF26qvcvwKoCjrbxn3ostSe0dlATdTa
	XHiaSmRZmD3/AEAVNTFUR+/cao5GJZtIcPlWOUevjHMNDhGK7cBhzz73
X-Gm-Gg: ASbGncvRw08QhLRrQNs6u0E/vXAjbd7IVFiDgTREuFO2Wg+GUxKt0eoGGynEqXnrHgK
	48pStZnnu9MiakQEwjYMUprddElIJyxmjtFbAA2sh/OGfyxO3Ura7efqXSfQgRsnPdfcTYP9zrc
	xvuQIMoQqKbeb+AJwNJbGzMDNK1vsqq1xgs9dd4zN5bQpS5Rn5mt232oUCulXWGrNt5S4gSfw1B
	CVgKQWB3Fdh8zIFZ7KQsWGHboY7Ai5WSx3EEVX4rrUsbeCvz9u7YIBcpG3ST9OgueG00SZYJ5UC
	DgtEfVSkZ/KZ1SO6n11szZYb3/g+notuX/Mzgv5VX+ntfIWBzDUPpBt6UCZX+iN2rFvHrFHp0Mz
	dAr4ELTSkIrOee6Ji/Lm0vL9ZK0ARu8GFgt+t4/M=
X-Google-Smtp-Source: AGHT+IF+n/WS6RKuYlQuLpfTYPIbA2M/p4imTXrTMvTksxJg/G6gJFeTxjjE/2igpzRcFyrC5Ibdeg==
X-Received: by 2002:a17:903:3585:b0:24c:ca55:6d90 with SMTP id d9443c01a7336-25d2771f4admr137080665ad.61.1757998113981;
        Mon, 15 Sep 2025 21:48:33 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25ef09c77f8sm104600605ad.15.2025.09.15.21.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 21:48:33 -0700 (PDT)
From: pengdonglin <dolinux.peng@gmail.com>
To: tj@kernel.org,
	tony.luck@intel.com,
	jani.nikula@linux.intel.com,
	ap420073@gmail.com,
	jv@jvosburgh.net,
	freude@linux.ibm.com,
	bcrl@kvack.org,
	trondmy@kernel.org,
	longman@redhat.com,
	kees@kernel.org
Cc: bigeasy@linutronix.de,
	hdanton@sina.com,
	paulmck@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	linux-wireless@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-s390@vger.kernel.org,
	cgroups@vger.kernel.org,
	pengdonglin <dolinux.peng@gmail.com>,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [PATCH v3 03/14] fs: aio: Remove redundant rcu_read_lock/unlock() in spin_lock
Date: Tue, 16 Sep 2025 12:47:24 +0800
Message-Id: <20250916044735.2316171-4-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916044735.2316171-1-dolinux.peng@gmail.com>
References: <20250916044735.2316171-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

Since commit a8bb74acd8efe ("rcu: Consolidate RCU-sched update-side function definitions")
there is no difference between rcu_read_lock(), rcu_read_lock_bh() and
rcu_read_lock_sched() in terms of RCU read section and the relevant grace
period. That means that spin_lock(), which implies rcu_read_lock_sched(),
also implies rcu_read_lock().

There is no need no explicitly start a RCU read section if one has already
been started implicitly by spin_lock().

Simplify the code and remove the inner rcu_read_lock() invocation.

Cc: Benjamin LaHaise <bcrl@kvack.org>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
---
 fs/aio.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 7fc7b6221312..e3f9a5a391b5 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -359,15 +359,14 @@ static int aio_ring_mremap(struct vm_area_struct *vma)
 	int i, res = -EINVAL;
 
 	spin_lock(&mm->ioctx_lock);
-	rcu_read_lock();
-	table = rcu_dereference(mm->ioctx_table);
+	table = rcu_dereference_check(mm->ioctx_table, lockdep_is_held(&mm->ioctx_lock));
 	if (!table)
 		goto out_unlock;
 
 	for (i = 0; i < table->nr; i++) {
 		struct kioctx *ctx;
 
-		ctx = rcu_dereference(table->table[i]);
+		ctx = rcu_dereference_check(table->table[i], lockdep_is_held(&mm->ioctx_lock));
 		if (ctx && ctx->aio_ring_file == file) {
 			if (!atomic_read(&ctx->dead)) {
 				ctx->user_id = ctx->mmap_base = vma->vm_start;
@@ -378,7 +377,6 @@ static int aio_ring_mremap(struct vm_area_struct *vma)
 	}
 
 out_unlock:
-	rcu_read_unlock();
 	spin_unlock(&mm->ioctx_lock);
 	return res;
 }
-- 
2.34.1

