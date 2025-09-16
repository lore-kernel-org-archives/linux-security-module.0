Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239F323C4ED
	for <linux-security-module@vger.kernel.org>; Tue, 16 Sep 2025 04:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998130; cv=none; b=qYwJEjaqkHB3hoZ/iiYNWn2SpkftNDYhMU3vF0BJc7Le9bx83Cmmbf5C9scJBXSR3/DL60sG66MVRwW3D7/fHvPxQThV9XkAvZQIDlPJZnWGSPdwmXAzVo2t84xXnasco5ugMgPlyw8Yb9D5aY70Y3TshIHIxiYHLSrIfRJmY/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998130; c=relaxed/simple;
	bh=McKpF5pbp0B08HxMwaOQh+77moGljXjpv9ExEqMvqrY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rm88mZT1MRAPs+XlSNxOuNjL1iyMdL7M/K901XidgSL+5ownMSpBlrG7fmSXJDcjN1rUmenVjUfmE3B4soxWEtFgyq3U6bbn+7xjhc1iTH1HX1PzhmhVkR9fDCzrivprsnbRPeeDB3hLLwOlQG6UKZW/c8MxYTFww/V5x1uFa7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iAsxqDJG; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAsxqDJG"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b4d4881897cso3280141a12.0
        for <linux-security-module@vger.kernel.org>; Mon, 15 Sep 2025 21:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757998127; x=1758602927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KdSOTRlpcbSm77LoC5qTO7Qj2WXZD3913QNmAyohauk=;
        b=iAsxqDJGyK6tvzTorEsVSUEuBJHI7lzp/5BEV9Wux96nvmddvYxeJQ1Pxvpd2zxtF/
         odfGJC6i+MsiMQaqOK2xq8ZI0ARkBidTF5I5eqq1ZR8Qjn+DauG6LysiVeyKRFvX28EL
         w6ZcpLJnXs6zocIW71x6zkcJ5+FAND5iyun6X1dBQ46MVXBvupNiU+xnLnPuRzi43J08
         BA1c5fGxCyMnm79SP3kRQxMi+O6QScp7FJQkKJCIjiivp3mQfwQ1xz1JjfoSzAPM7acG
         j6yJZpPiCXYc7n4vedVIAlccqhiIo5yA+omWiEO/NiWZlviC3u17B0o+jpKhtDTDqd64
         n6Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757998127; x=1758602927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KdSOTRlpcbSm77LoC5qTO7Qj2WXZD3913QNmAyohauk=;
        b=SfuhBhsImfzHl3t9nDq44D7aLSkw+WDNmYtWOVKFCGw8CX3WM0GDN4i9bmgJeSiQeO
         4TeUE2lvkE7MIhGaRx+swQ/N390o1K84XFv66kIMu7TJAnfUuKOzhO+CpxDtMl0bYpnn
         Z6RsfYme2lk+9lNYbqr8taRmtR2wcTTpSj9Lw2N7AXp1umzpk+9uTpOdEQKqt7wjKy7q
         8mNnqgyON4FYAssxZX5nclwsTw0bxIVPZ5iLA1VSkGVpU4TEK78yf7ONVuKh+iqSCAMc
         H7wX5r9jZzX81BJ9+o38WB7XIskJ6F/jbQfXqjNknp8XYDT8QRoKgiBV0KJEgpGoogeW
         +I4A==
X-Forwarded-Encrypted: i=1; AJvYcCWD5S7nDu28vhLc8VKJ+QPKucLanBiZvz2GTnAdKHqHDmjX2cM5AidPmCAKUKxHCZtjNzEQubRL8P9t4iP6glGy5vF4OF0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7s5/CtBL4iLh2l82YNloOqIjeiog6Go2OeG8pTkXUl9Gcrn9e
	w4S5gSD9TzSQ+RKOBlOgIwsSPH7yB25QPpaTJ1HwFkGotPfKhcuAoXZ9
X-Gm-Gg: ASbGncv6BCPHgUCfrOjsDIdFz6GkwwtkzhrwV/+cbMeya2cPVQN/rjvK7ntdcLpEuJJ
	qgj1NBwjr6ZENYWZFBrKZMUq6KopMGKS6SMqLj7PtL9ePSW7USUTuj3ZdpbKjBxWrGmQdKN7nw7
	s0HA6IbJc7XYPnTQE1nAYTBFfNgQe+aGJtJvy9ulysjYBt+MX1aDM/RNUL0MBB2kwdnjc/Ee/AQ
	IlEomI4q5YghmIr+c0vL5QJ2ygyFrTr+EpM1RDb3tY9nsXlk2Uh3o/PavbcIbDU9An+6WvpaUFx
	8E2YiRMgfnD+5mUtt3SwgKrr77smNz6z9B57a4b81AezGw4g1jSZxtv2nWh9w5cqPVYXJ0Q0elI
	cJBFIA0/3tMk8sc1tIGspHfKsifl2AgJ64+nC0jA=
X-Google-Smtp-Source: AGHT+IGkIhcIMGh+oiZ/aDBZPsHwPAhQG69OhML0E/f2mr/YjQA5clLbS6Ua4uwzILjLJIA06eQ5gQ==
X-Received: by 2002:a17:902:d2c4:b0:25e:5d83:2ddd with SMTP id d9443c01a7336-25e5d832fdcmr159755585ad.45.1757998127447;
        Mon, 15 Sep 2025 21:48:47 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25ef09c77f8sm104600605ad.15.2025.09.15.21.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 21:48:46 -0700 (PDT)
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
	Holger Dengler <dengler@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [PATCH v3 05/14] s390/pkey: Remove redundant rcu_read_lock/unlock() in spin_lock
Date: Tue, 16 Sep 2025 12:47:26 +0800
Message-Id: <20250916044735.2316171-6-dolinux.peng@gmail.com>
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

Cc: Harald Freudenberger <freude@linux.ibm.com>
Cc: Holger Dengler <dengler@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
---
 drivers/s390/crypto/pkey_base.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/s390/crypto/pkey_base.c b/drivers/s390/crypto/pkey_base.c
index b15741461a63..4c4a9feecccc 100644
--- a/drivers/s390/crypto/pkey_base.c
+++ b/drivers/s390/crypto/pkey_base.c
@@ -48,16 +48,13 @@ int pkey_handler_register(struct pkey_handler *handler)
 
 	spin_lock(&handler_list_write_lock);
 
-	rcu_read_lock();
 	list_for_each_entry_rcu(h, &handler_list, list) {
 		if (h == handler) {
-			rcu_read_unlock();
 			spin_unlock(&handler_list_write_lock);
 			module_put(handler->module);
 			return -EEXIST;
 		}
 	}
-	rcu_read_unlock();
 
 	list_add_rcu(&handler->list, &handler_list);
 	spin_unlock(&handler_list_write_lock);
-- 
2.34.1

