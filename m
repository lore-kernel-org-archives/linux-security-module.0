Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794634145;
	b=3a+rr9t4yiiSJUViJ84ON1iszNTUkkL/HPx1fXhZrVv84s4i/RRxkHZkgqRPja/Y/Kbi
	 oHLeB4tSX+9MsJqcqF0B5Run2uTUDv8vdKehtbG3/MXg3wNMJ1nfIBHqdiv47LzpGJZdJ
	 9OQJj+2pBulT476/GV8d+PsA9V8vh9xWn4km7wWXdeUwThJSpquXMmBTmIkcZltEZwW8x
	 xFKNCF7/KqDR6ffko7R3kOBFJFWWmSAq6E4LtJG2KUL4EkxVzoIKkYDFPP937TIy0J7QD
	 vXj+pIoGlrQvB5nc7zIGeUgAmMjSP/TrFOc16M8iUBf4TiCYeDiX4UL1YuoAh2cGaaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794634145;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ve8LQXErwjekEnlC8HaEebRUb/hYJ6j4geIEUpqGkS8=;
	b=eIIM5/5TS7R2H0HJ3fM0ams0kcz4P+MAnJtAjG2exu6XJE2WVWheWIl6vm7O8LxMncW+
	 WhH61ajBDXoMzI3BqfBAaHjbdASPQeDCHY0nTfqyiUfZ8p2kjqYgeIz3YImcZNAtjE5tO
	 AsVle/KmsF2tpE7+pht+q6oASqHuMKn9kBvdDiFBw5jN+RpfflpdlO/mce4dkQYfpWAcu
	 zFyjdMFM78MpgYk643+nJiPbXKdjRyU1wn0BwAPJcN1YQ4gs6dpeUV2VtJOP3Bd0+oyS+
	 kxgR0R8SNLf4JCWQaCSTtsNX+gMDrj12szK1ceajPthXw2lDltYqLxz4paQNJx6WnPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Orn/JN7t";
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E62606A329
	for <linux-security-module@vger.kernel.org>; Sat, 14 Nov 2026 05:29:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07E62606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Orn/JN7t
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ae1da332bcso593161a91.2
        for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 21:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794634144; x=1795238944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ve8LQXErwjekEnlC8HaEebRUb/hYJ6j4geIEUpqGkS8=;
        b=Orn/JN7t9fOucPl7ceF3yd0u3iQTyWwHzGp8O+tD42xrqqhk4cObgjFazLsmjELN5Y
         ClCJ3ySaZeW758xChrCK9jipAJIpoNncFYu1MlL6YU1skCWDKKKRFWDKvgB/6sLm+HLv
         thnevQF3HvvKv9r9AicS54L446SdRWiD3o3ifL85pG/cKBZeCnItidCpFOHE3/6qTLnx
         CVrV5NJYLFnyOx84bstkwcrQO2toRAUnHtquL1PsGJBVX7NOUmWRUFUH8UYBRQmslFBr
         AJO10oOglbHsrVld0nQS8k4aqqazwhUN7Pv2gncZcTO4vYpoWltPBi7R1j29zxEDHosR
         vjkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794634144; x=1795238944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ve8LQXErwjekEnlC8HaEebRUb/hYJ6j4geIEUpqGkS8=;
        b=rRkP94+tbQvjNGSwxL656O0uLuMGUC0Uh8Zrq0TdnneqbL9H0P7pmOPicTHXR2IGO+
         Jb6ro3ONAnKrKor5y6KAO+iLlUMmJPl3pfiHX0ma7efK2kla7VcP04j8kpGueIgHDcE0
         1YOqh9eSlAh1puM3GhWDhmsMhPEslmdmJ/VreMX7um6YauJnGwRg1v3mRjOZF7lNaKC1
         Ok3S/ia5hBvNFYSFSWauKKYEm9hzYEtxzKENaebM4IFXX0Qg5JtZw1sczt7nBthsQhfl
         67oJw5fbc5bGkegNVTyKGCbz5floiY5xo8HH1tj+YH6TDyb81ASgnm7L5oX4Flq7I9Ji
         lBEA==
X-Forwarded-Encrypted: i=1; AL+hErE8oIgfz2ifhmhOYo9UNWwJn5qzaI6PxQ9xNvKD58/w9i3jMhIHZm+BsItLn7xtNhwg2g+ysKtYJ8eAVT8JUuxRKWfZ1NE=@vger.kernel.org
X-Gm-Message-State: APuU4Z88BQWhakAV7Qmlyh6O0gFmTlwcAdeHt5U4eYtdvXim2Y9spEhW
	huwMKmCkih21EDt5e2tQh5icf0jTXs0cdYyOFvuKF+9GMfHbiQiEIXRF
X-Gm-Gg: AYBFou28JNydRWeJrxeH0LVMXPIFxpeII35AjJulge6r/3vDXfEpEVB9aRQSl1S8VP9
	g72qSe37puoumlrzAV3H31KWIe27uI6ilU5xfjiCf4RKlSvs/BxcJpNl/SXv6oEwi2YUnMR4hgo
	/y/R75i/M6M570eIPkK6ysgUcdfZ8tu4K4mEjd4WqwLe7McU5Eys0NUJpuKFgsPJiBOoTmSg/qH
	kkmAV33fbe1tOaikVSwYJYI3SJpoIunTG9XGNEu0WHFgxgE7GyXctRgseAXkA4YLVAxngrAq/a0
	RIu3vSe3t7yh67V3cyy4mBJiMxlySvtCHC8jDiLkGXBVrDGmO+8/4ipQAr6LJYKyqGcnfF6ErDJ
	N4A/EgD+7ZHIjVhxqPtfUGTda5Kpci3Szdo2IStCIkpxsaT9OfMWDXNO79/9t/7+VQ0gb6udVEV
	EhV7nNAsI70bj4/6STknVhlN9ClgZynLqzem3Mt96wuGWumtit7ExuZu9mrH+BNUwMXYHjOOArq
	xE99Hn8vOJW2HTP6QlboqoZ7d4CfESoyoMBcgvO93oPnpA9A6PpP/DF8/HEtI5Ql1VSNYYkwSrg
	XspKhQnWR+tWcZpZpr/OpaRbT8d1N0KOHQmlraOZTP0/5eQlEOHceF7HQtMm3nE=
X-Received: by 2002:a17:90b:57c7:b0:3ac:9d26:5532 with SMTP id 98e67ed59e1d1-3b1b07fec19mr4789871a91.3.1794634144313;
        Fri, 13 Nov 2026 21:29:04 -0800 (PST)
Received: from localhost.localdomain ([108.180.159.198])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aed76f95sm7157339a91.17.2026.11.13.21.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 21:29:03 -0800 (PST)
From: Babanpreet Singh <bbnpreetsingh@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <sergeh@kernel.org>,
	Bradley Morgan <brads@mainlining.org>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Babanpreet Singh <bbnpreetsingh@gmail.com>,
	syzbot+ee58b040032d8bed63d9@syzkaller.appspotmail.com,
	syzbot+557fdc985d6ac3831e14@syzkaller.appspotmail.com
Subject: [PATCH v2] cred: annotate data race on non_rcu when copying a cred
Date: Sat, 14 Nov 2026 05:29:00 +0000
Message-ID: <20261114052900.7-1-bbnpreetsingh@gmail.com>
X-Mailer: git-send-email 2.47.3
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

prepare_creds() copies the current cred while another task can be in
get_cred() on it, clearing non_rcu. KCSAN reports:

  BUG: KCSAN: data-race in io_prep_async_work / prepare_creds

  write to 0xffff8881046cea68 of 4 bytes by task 3646 on cpu 1:
   get_cred_many include/linux/cred.h:222 [inline]
   get_cred include/linux/cred.h:238 [inline]
   io_prep_async_work+0x9b/0x3c0 io_uring/io_uring.c:367

  read to 0xffff8881046ce9c0 of 184 bytes by task 3645 on cpu 0:
   prepare_creds+0x71/0x550 kernel/cred.c:192

The race is harmless. non_rcu and usage are the only fields that change
on a published cred, and both are reset on the new cred right after the
copy.

Annotate the copy with data_race(). prepare_kernel_cred() makes the
same copy, so annotate it too and switch it to memcpy() to match.

Reported-by: syzbot+ee58b040032d8bed63d9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ee58b040032d8bed63d9
Reported-by: syzbot+557fdc985d6ac3831e14@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=557fdc985d6ac3831e14
Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>
---
Drafted with Claude, an LLM coding assistant, from the syzbot reports.

 kernel/cred.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/cred.c b/kernel/cred.c
index d01df40a9a386..d9ab1cb4230a8 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -189,7 +189,12 @@ struct cred *prepare_creds(void)
 	kdebug("prepare_creds() alloc %p", new);
 
 	old = task->cred;
-	memcpy(new, old, sizeof(struct cred));
+	/*
+	 * Another task can be in get_cred() on the old cred, clearing
+	 * non_rcu. That and usage are the only fields that change on a
+	 * published cred, and both are set fresh below.
+	 */
+	data_race(memcpy(new, old, sizeof(struct cred)));
 
 	new->non_rcu = 0;
 	atomic_long_set(&new->usage, 1);
@@ -573,7 +578,8 @@ struct cred *prepare_kernel_cred(struct task_struct *daemon)
 
 	old = get_task_cred(daemon);
 
-	*new = *old;
+	/* Same race as in prepare_creds(). */
+	data_race(memcpy(new, old, sizeof(struct cred)));
 	new->non_rcu = 0;
 	atomic_long_set(&new->usage, 1);
 	get_uid(new->user);

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.54.0 (Apple Git-157)

