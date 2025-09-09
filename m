Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E578E33EAEC
	for <linux-security-module@vger.kernel.org>; Tue,  9 Sep 2025 13:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757423474; cv=none; b=h2wIkZUyvtxFP3KjYdDE4kaOK/+QqCs+ZnsQEz650dkA7k7EJYomCRikWGUsD8Ly/B/WpIWpFGfjWLWyC1EnCZSTtty7jKUvp22Zh6Cd+4q497IHq6BOlVDjqU0M63Q5OlKrUXKrvcdfWN8rPJjc0YjN1IJcyjxRWFc3VVPPdC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757423474; c=relaxed/simple;
	bh=Zo3oH4aw0tiSXOUVsgBT9EB9o0z8d/2riNIK+49I9S8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EfXVHPilMu2oBIlPq1Q22uKYF7mxuWTFv7mirEytdsVFDPRkWIzUaeFFkBt7rX6q4hzFTw/KCvOz3UBUY5bCtnomHl2C4OUhdK4GQMgCDUZPGveIYvrtDWsQ79+4mpFjdnNXIxwr0SZ287ALzHgQvtMS+6x/CRUv2xaN9BfUiuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Ef/R4DrD; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Ef/R4DrD"
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9BC423F282
	for <linux-security-module@vger.kernel.org>; Tue,  9 Sep 2025 13:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1757423462;
	bh=mTARHUNH6YPuN2/2Pw5N85BTAXOgi/Y6NWg4iRpTdcE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=Ef/R4DrDaTEPuviXTMb0yDYNgToLODEuTSrk7m9DGQiwviLWMc1lzM1KXCd8CEyLY
	 rRSjx9ir51l5622h9XLdWioDvC6CA9y7QMUAshsgpj4GOfkm5fAHmn3YsCLDPN0wOy
	 yC522+uj3wveGlHF+IjILEL/NC1MBuoypQIauQc2RAkyq0hzb2JvjCOl+cLRrEGVR1
	 NXz1niJ5T11coJSB3+yUc1wR7b8aNdeZ65RRZhx6brf5E6l7mvPsD7NQJ/Cdn0MYoY
	 tUeo/V+4vVgraxPJ4/bI5y+sW5r0a/grGriFRBlmBlpAwkmpcTFlWe8gfr5Xybg5AY
	 WbbNu9Tlc29/w==
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-76e2eb787f2so5894472b3a.3
        for <linux-security-module@vger.kernel.org>; Tue, 09 Sep 2025 06:11:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757423461; x=1758028261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mTARHUNH6YPuN2/2Pw5N85BTAXOgi/Y6NWg4iRpTdcE=;
        b=Nm/zYOWabIhXhpkhXf0Zsbs7WcFVfpdMTkmFHNFRJJR1JPjom7O7Cos1k9Hzdi+wA0
         8q3H3WvxwIWEHIcbuXhilUt23ATcSNbACFWPDdlsNHGCKKIX6x3piqLWXrYI1xavVoaG
         4WRRRKGU4Ripk30S+UYSkSL4lznANGjdyCluWh0QPeLoe+DuNOJLeNrHGAbDWzDV8ktZ
         HaEeMdTMyzb4tajICATKXAQs/JDPq1FMtOtbv1Fs2qAokglPtc2rqJ7AyxrivRkJ766W
         NSS4Gw7dqD37aaHqKf7jrDpzLpICfWtDW1wLyMzf6Q2oJfFu7B/YZtfaR21WN/95EAG+
         9+PA==
X-Forwarded-Encrypted: i=1; AJvYcCUeV/Gl8XuVjTDbWNyo4ewcAsHbn3rjq7KcxQnWkSOisSrxrEDS2c6UKYasnquh4AYXzwXlQ0q6nBlyOA1xqDCW66bfT60=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuKDbNLo3CYjBFn9kOpqXykLAPM+LBPxKjHgRPt3BWdyLEMxyH
	FNXBXbM+aW7/M+UmW05Kr6Tdf07k8PEbZSvbedLzS3XU6+AwILZD2REWzQXDUgKvo+8brGRi1Is
	suE9MzbYbS+NPEVld1jsOWySHntE2g3svO91Y+fTYyEFXrx3f27zyhEhO9yYb28ac31SmLpnPyu
	q5KvUYbDiQeyRJHEqU3g==
X-Gm-Gg: ASbGnctnKWGnhuk7z8UTA8yXM50au6W5ApVV5trPQidxNVApMWSkl/RabHUtEoQkQmI
	PEhIDduOIt4xmIcmf/m85DTe90+t8fDZn5HYTimAXtC1Ph2a78ZZYU9GSvetED+jpS4DOXU2Cr6
	YLRQJ1mdsjnM4GyJob827B23gtbzFgcIBCfBvzLOchM4undTPOmNzl+Y1rz0AniKkFw4XsCMwlv
	5F5z2clQ0E0DGybG7M7738wNAJmcnMmNQZQUGKVaXjfNsGudv+ZF/3Mh7uTzRxCz3X1qhwqjnam
	bA14+vv7ydxu1dFL5HSX8jddkcAXgIt2oiQCg1f3r59437rgFf9eFSB3+E7WHsZ8IBB3mIAnnRt
	X996ulKI=
X-Received: by 2002:a05:6a00:1821:b0:772:499e:99c4 with SMTP id d2e1a72fcca58-7742dddbe77mr15427276b3a.18.1757423461183;
        Tue, 09 Sep 2025 06:11:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9luBLssO1ocG8bZoCNKhOLSOO/E7cpZTqVelHzSs0SjLcBreTUD1zt4mInD7HeDgyEKmFpg==
X-Received: by 2002:a05:6a00:1821:b0:772:499e:99c4 with SMTP id d2e1a72fcca58-7742dddbe77mr15427222b3a.18.1757423460643;
        Tue, 09 Sep 2025 06:11:00 -0700 (PDT)
Received: from noble-c.lxd (118-163-61-247.hinet-ip.hinet.net. [118.163.61.247])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-774660e4dcfsm2171452b3a.18.2025.09.09.06.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 06:10:59 -0700 (PDT)
From: Gerald Yang <gerald.yang@canonical.com>
To: Casey Schaufler <casey@schaufler-ca.com>,
	Paul Moore <paul@paul-moore.com>,
	linux-security-module@vger.kernel.org,
	audit@vger.kernel.org
Cc: gerald.yang.tw@gmail.com
Subject: [PATCH] Audit: Fix skb leak when audit rate limit is exceeded
Date: Tue,  9 Sep 2025 13:10:52 +0000
Message-ID: <20250909131056.3395574-1-gerald.yang@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When configuring a small audit rate limit in
/etc/audit/rules.d/audit.rules:
-a always,exit -F arch=b64 -S openat -S truncate -S ftruncate
-F exit=-EACCES -F auid>=1000 -F auid!=4294967295 -k access -r 100

And then repeatedly triggering permission denied as a normal user:
while :; do cat /proc/1/environ; done

We can see the messages in kernel log:
  [ 2531.862184] audit: rate limit exceeded

The unreclaimable slab objects start to leak quickly. With kmemleak
enabled, many call traces appear like:
unreferenced object 0xffff99144b13f600 (size 232):
  comm "cat", pid 1100, jiffies 4294739144
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 8540ec4f):
    kmemleak_alloc+0x4a/0x90
    kmem_cache_alloc_node+0x2ea/0x390
    __alloc_skb+0x174/0x1b0
    audit_log_start+0x198/0x3d0
    audit_log_proctitle+0x32/0x160
    audit_log_exit+0x6c6/0x780
    __audit_syscall_exit+0xee/0x140
    syscall_exit_work+0x12b/0x150
    syscall_exit_to_user_mode_prepare+0x39/0x80
    syscall_exit_to_user_mode+0x11/0x260
    do_syscall_64+0x8c/0x180
    entry_SYSCALL_64_after_hwframe+0x78/0x80

This shows that the skb allocated in audit_log_start() and queued
onto skb_list is never freed.

In audit_log_end(), each skb is dequeued from skb_list and passed
to __audit_log_end(). However, when the audit rate limit is exceeded,
__audit_log_end() simply prints "rate limit exceeded" and returns
without processing the skb. Since the skb is already removed from
skb_list, audit_buffer_free() cannot free it later, leading to a
memory leak.

Fix this by freeing the skb when the rate limit is exceeded.

Signed-off-by: Gerald Yang <gerald.yang@canonical.com>
---
 kernel/audit.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index bd7474fd8d2c..89530ddf3807 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2615,8 +2615,10 @@ static void __audit_log_end(struct sk_buff *skb)
 
 		/* queue the netlink packet */
 		skb_queue_tail(&audit_queue, skb);
-	} else
+	} else {
 		audit_log_lost("rate limit exceeded");
+		kfree_skb(skb);
+	}
 }
 
 /**
-- 
2.43.0

