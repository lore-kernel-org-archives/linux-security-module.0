Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1798C50095C
	for <linux-security-module@vger.kernel.org>; Tue, 20 Jan 2026 00:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768867416; cv=none; b=t/caEa3nDOXemnUuQjP66qHuzoDpAzRhcOnkE2Lc1Oi9iBAF14Q4YxlW9GlmbXfKVS6zvias9EStaVYaj9Av7mv5XxLBssKmpgWmR2QVu30kMXPHB8YS76LAe8t2sJLXV2RI9w+tUsT9JC0wOn3x1sez6KQlELzK5WD9bJ7D2zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768867416; c=relaxed/simple;
	bh=UsYDjnmX9e7JvJmWYndGrxPI04j9tsjJvekfV9fNQsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pk9FFpqAhPKvxLLRMm9g2C7k+zv1bDdLyaJ8ojxgB4W1e2E8ArV3TiTcjWnzejNMPVhW3cN1d9HTXdCSYwsJsHrjx7K9YKEKMtbgf/PmIGGcD9wg6IEmqHBicAma2Bil/ME+pMmwLdkF5XtfXXGeMzb2BpCcmo3WzWjXOiFuBqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jzBFtSKb; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzBFtSKb"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-79273a294edso47419037b3.3
        for <linux-security-module@vger.kernel.org>; Mon, 19 Jan 2026 16:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768867414; x=1769472214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+GqBvHxIb9Q9z4zhQuYRXNX+z8KyHXZOtzf8aziexY=;
        b=jzBFtSKb08VT7ORDYwy8yVvgRiYlr9xQOIPv1yi+xEZw4OzGIZTUiQC8E+isXwLHm5
         Uw7/5X2YYyMWdKvlysLnrPVVfEksZVbFB1mHRh9tI8VaoXYss01+yE3YzFpYKWEYlVAU
         99B/d27a6F3w70Nq85GFtTgh6gFOMmwcv/s/E3IIJIuAlSAoaJrx3OV7SQh1heCAjhTN
         8mIOBwBDutYssJhbJ0AwFAM3usFzHfwKdWa6JGwEMatpi6dLczOd4MDlhoQLX03Lqkh5
         CgMrBjBds+JTikL3r4zgMTF9eUbPkCiwkGtyGESr6sk4lAezbfIzJH0esdGiFqNBGIml
         xKJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768867414; x=1769472214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f+GqBvHxIb9Q9z4zhQuYRXNX+z8KyHXZOtzf8aziexY=;
        b=HWqksm0dUKuhRP7kS9u0YJZofIGN5MVVFZDF8TiTASfeV5oVu/6go8pj6NyruS+Qcy
         4JSoqP1J1d3C8DvFPtroigimTqy0OiO89egdStu3sePetQDUo2LmYGn/BuoVMRZL0OGx
         oqKlYi9n0dq5iIGhos5NIltyUyEsCDeuAQ8l1FQq9wJzdX3B2Q/wRX6n5LspU/ccM3RW
         ZWWcc1kXuaWT/MjZH71ixN02BcdIARjroDMRkF8I2ook4/snOya0pjIIjeptDHWXQcn9
         T8eEdyZoEULPZc1opZ4nyvdXNnShZGrwlNih50qu/kcI+sxBm1EfueEUqdPy17HVAatJ
         5D4g==
X-Gm-Message-State: AOJu0YxVmxP+eJRmtLGQAL/Xr5GWzydyHnOcus/ABLGuvIwIOf8a8TCl
	Li1ibYqnHBpCZe247/81uRRfhto6U003x0/0NIG32kJMVheqjiX/Q7I5aIReBA==
X-Gm-Gg: AZuq6aLJuQ04VYoqJk9exI5742KDH5WN9ei4aw9L1rl4vzWvxiwRn6XGaxGZKZ13Y3g
	ITXnQpvQetMXS8w2DaAEGwZ2PmLKWA9RhAaFFX5vpcVTSGFHsw79uo7Usr7d4hETcSWfInXWVT5
	4PxKAUu/xYh2mu0/LBxGGN0kcAkyMM44tDQT+C4QFtIqr76fMiG9UpqVsDnvIlunVTdzFXpmtuf
	JrOigTsDHBPpi1XHhS4zh0VNSQyv2FdZHsB90zNw3+krPGV3syuP442zMgy+nSFjz0j9i6P6v2x
	/z8MvzzF21ABKNTUULyvLfP9R75ZidrNW4ui7UDRF6B2hs4Zovm0YHy0RDWPVV+3gWfXwKc0Gq2
	RExzOw4UsNQUABjRI2I5ngVxJvaz9Ngqg3y1FwvQ8XFTEc5qFdSlSZZLsT5zBAoZKh18oZBem5l
	nNwaZQ3wR1lO/IBTxKtzhdVB7uthU=
X-Received: by 2002:a05:690c:4d0a:b0:786:7017:9511 with SMTP id 00721157ae682-7940a122c2emr1603977b3.23.1768867414097;
        Mon, 19 Jan 2026 16:03:34 -0800 (PST)
Received: from msi2.sky.cl ([2600:1700:65a1:210::47])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-793c66c729fsm45933607b3.12.2026.01.19.16.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 16:03:33 -0800 (PST)
From: Zhengmian Hu <huzhengmian@gmail.com>
To: john.johansen@canonical.com,
	john@apparmor.net,
	apparmor@lists.ubuntu.com
Cc: linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhengmian Hu <huzhengmian@gmail.com>
Subject: [PATCH v2 1/1] apparmor: avoid per-cpu hold underflow in aa_get_buffer
Date: Mon, 19 Jan 2026 19:03:07 -0500
Message-ID: <20260120000307.369587-2-huzhengmian@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120000307.369587-1-huzhengmian@gmail.com>
References: <20260120000307.369587-1-huzhengmian@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When aa_get_buffer() pulls from the per-cpu list it unconditionally
decrements cache->hold. If hold reaches 0 while count is still non-zero,
the unsigned decrement wraps to UINT_MAX. This keeps hold non-zero for a
very long time, so aa_put_buffer() never returns buffers to the global
list, which can starve other CPUs and force repeated kmalloc(aa_g_path_max)
allocations.

Guard the decrement so hold never underflows.

Signed-off-by: Zhengmian Hu <huzhengmian@gmail.com>
---
 security/apparmor/lsm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 9b6c2f157..a6c884ba6 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1868,7 +1868,8 @@ char *aa_get_buffer(bool in_atomic)
 	if (!list_empty(&cache->head)) {
 		aa_buf = list_first_entry(&cache->head, union aa_buffer, list);
 		list_del(&aa_buf->list);
-		cache->hold--;
+		if (cache->hold)
+			cache->hold--;
 		cache->count--;
 		put_cpu_ptr(&aa_local_buffers);
 		return &aa_buf->buffer[0];
-- 
2.52.0
