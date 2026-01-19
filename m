Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A567127E1D7
	for <linux-security-module@vger.kernel.org>; Mon, 19 Jan 2026 12:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768825305; cv=none; b=kdFeeeUpUVVdId0Ll64thHd0ULBhP9uXn+tPW4NkXh48T8GWC1edInGrZv8r6knHj6G6WcjuODaWU/qkk0arbLLRdtB+EW94n8AkEpG9T5RYxqQi14TFKHKu3H4L/16/fp30NjqOTCeSOZQZbFsh/ZliAyWcUKBzeyl2OFnQqF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768825305; c=relaxed/simple;
	bh=Tx69mvC65DOjZMSxdCXvNva3L9SCwkWXxa5G1Zc5JDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BokQPLL4vQEIgufDCzklaEdvmEx8ydmz0Fc0yWzQkPgCjTfN3IKp2UJCl1JJbiRBbe6AfvYUtpumtAXh+f8jg/kMUwvtaW2uCbyJfnI8CS0kjBwXC1nxqb6Tkuohf0BPWkP1RRq8FNvrugmx9HJoTf3OhMr3caVuR9fk6YNCT3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h543gYg6; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h543gYg6"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-793fdbb8d3aso2745867b3.3
        for <linux-security-module@vger.kernel.org>; Mon, 19 Jan 2026 04:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768825303; x=1769430103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xpUlBJUkRI9BEvvEPmE2BefrFSelS9EOH7w/G+TnZM=;
        b=h543gYg6/dCw73cTR1zG0Dv5mRuuvf8pST9H8svO9s4+bolJf4YfTJ+gsgZhNP4rbN
         6fNHWXeRD581csJzweSUH5UqRPls8Eqoo/AkGkYYukay7jmRD0Tl8FKLziCOESKEd3ZB
         aHV2S9sGudmyilqSfw5EoIDyDZnrxP2iSx0oVois5mf4d0sCgSNuFjB85/lXfoMkowMv
         GWh0AC4zdC8yYtFl4txwpjshe5m7b2roYZbDQrhG6kcqXPqXjBx501+JXcQUC8f4Mo3Y
         zsWBkWVMqH3cgvWYAqJZ76HsayP8yj2pAowYeWAMzFYl8p/xRYaLrYxvtw8uQ5ADoIj8
         0B4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768825303; x=1769430103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4xpUlBJUkRI9BEvvEPmE2BefrFSelS9EOH7w/G+TnZM=;
        b=QEZI1Q50EJZiQME7qLuvh9uta83YnqtcoZDPhu59WfavVahBwIFx/wGmVqEPlnqLG+
         C60fZTPppNghq8Zp5x3p9EgF1uInE4HlK4Z0igghWMVtV9sruePThZ9sGR0p5yex6C9h
         KRdkqoX3W/LkC+M4DTa9MEgG8x9qRNjo7XrFY+0knOPMDdngiOwyicqjxvsi9SidXhsh
         Au6/aFTVNYhW03iXcndOKfSumlDZzoSOykBBaE2eM17+jJSQR17wu0c1caHJqK1FM+/s
         vm6Xpdc2cPpowJsmYWdNJHMdgPyYoAPVnmUV5afn01GUElJVZ20LEA8FU0grkn8FF8go
         kjSg==
X-Gm-Message-State: AOJu0Yx6Zk3qkdHv5uqyOgbOCQhvKXtxao7noR6AVPGfGgBQIGRAULbE
	EP+ooOCGizCjuFzG/3u/16A+I37VZ1kWbBveK+dkgQYTDuVgs9VwEdM/
X-Gm-Gg: AZuq6aJrB+z8y11tUV/3MatL6w2vX/juZ+CcrgDV+NYS1Mv30xCHkdGRmiydTB2g1P8
	VsQ0henQWP3/rQ5jO2OgVfMweXGX4Z7YZAbTjHAwWihDuN6fRqOOTia7iEYwVQADsTELaZ1bJQD
	ZQW/CS8t9vrDdNZKGGm+i5V2NAnXI3zZUFQapkbmCrVtsiHowTCCDcXYYs6KRGpB37uDfKUMHRj
	1OURLYNuBW2EOLrjGlkJr2pPCzxDiiK8le3pWPLQgs83sG9ilHjey5NGvLeZHAo2aCnGDfDKJCc
	1+Wgd+/QI1XfQxHDjXeXklTTmso5VixumMT7VOUb2sgHqmx/rpxiXDTOlxjoqAGSQf+IlRcpc+h
	GDJKasTL8pSdMck2ZQfbSVM8EBkKeAGm+pipJmyh3PSOZen7+iolMW7bPXrSe82tjSyk2TYpFRz
	NSQjJiQby4b0buCpIH7R8O9++Mn5Y=
X-Received: by 2002:a05:690c:60c7:b0:78c:2473:ae79 with SMTP id 00721157ae682-793c5393a8emr70353737b3.39.1768825302663;
        Mon, 19 Jan 2026 04:21:42 -0800 (PST)
Received: from msi2.sky.cl ([2600:1700:65a1:210::47])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-793c66f326bsm39600677b3.19.2026.01.19.04.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 04:21:42 -0800 (PST)
From: Zhengmian Hu <huzhengmian@gmail.com>
To: john.johansen@canonical.com,
	john@apparmor.net,
	apparmor@lists.ubuntu.com
Cc: linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhengmian Hu <huzhengmian@gmail.com>
Subject: [PATCH 1/1] apparmor: avoid per-cpu hold underflow in aa_get_buffer
Date: Mon, 19 Jan 2026 07:21:19 -0500
Message-ID: <20260119122119.3648154-2-huzhengmian@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119122119.3648154-1-huzhengmian@gmail.com>
References: <20260119122119.3648154-1-huzhengmian@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

