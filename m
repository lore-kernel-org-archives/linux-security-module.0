Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3A41DDDD
	for <linux-security-module@vger.kernel.org>; Sun, 23 Nov 2025 17:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763917268; cv=none; b=a5R3lszhH7HOjGOIinzBr+mZfYHQmSsKf6qkdIcy+HcZKyg6W22W/R60YSWHw4WPnQoz5tOAWtF4GdDohwy5QyXEOym/MQntzUESnSZ21kYpKKfSv4w1DFaXbkZC+WEzmsWX0gJRLBUex8B1AlxxlqQ1gUluJ2OE0X/2VyHPxes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763917268; c=relaxed/simple;
	bh=tTuTPMkQUvj3LIrqtt5k2SYuwliP8i2ksSZa10Ghr8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VcvvlimH2cjhAFAZ0SrQonQluIjCSUplBV4FriXgH34S90e5v+LcHB4Hj50vI97AqYSIUH+SYdEb5DWoOqPtO9KDSKUnL3MEoUN2vhA1kbADf1HllrxXFvPT7FKXWBC8pAl98dveY9ZQ47DHjZHli4yVamfWdfRU+PYlrEqGuwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zu5A3K7N; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zu5A3K7N"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-78aa49cde3dso2381637b3.1
        for <linux-security-module@vger.kernel.org>; Sun, 23 Nov 2025 09:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763917265; x=1764522065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mX3oz0rhdPBQoFled+ozAJuxvtRMqIdDm0DrYDvd4n4=;
        b=Zu5A3K7NKw9Xa84wC+7WOep/M9YkT3rNGXZJDJZE/cnRmgxsIvPXbKbqMMK56L7ydW
         aWTDsq5XYclGAdiCY7Ti4i8f19OwCYaAQAVoe67Rc9+2YyAQYdr2Ug2om5LrdC1lOgN5
         DlY8tzgD9PErSuC11Z+yXr0eAkMvvU7FO4d/r5slidmLMhPgBF3y9+AesWf6cuSWVgAp
         mJ+GfCRvJeX8txC4JR6pGXQ552GbDlNWK9F0dYUBAIlZi/rpp6dxYlHRY8CMDtq809H1
         qR72QHPTGqqH11y3BDcaA3P2NsdPmej6zj+ufEl77KddSBbo/Ps/dgctJlBUnfqkyeKP
         Jswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763917265; x=1764522065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mX3oz0rhdPBQoFled+ozAJuxvtRMqIdDm0DrYDvd4n4=;
        b=UAmnO5QOSbVeG5yKUlTCMBjr36gV3Jt+qEC+jTSABa9lnbv+idoNd78obP/1p86gcj
         xboF7uiiBzWMr/EpQXDIO+gcP7agOXGSVY1SFRNzgInK8N9nSvwGeTBnyraudz2JjO25
         lBCq6ehmh+ATlxObUQ4pWs52o9IUio0ZNi22twEHA63kmPXvcD2TrHD00BUWT/bg5cio
         khXriA2m8GRZJ9hJp9DvDudMsMFPkjBW0W+iDftzme6XeP/kLA+xdJy7PQjXafg8OxC+
         ZuH8fxb4Uzmf592Qf7Y4REfXmrglmZxlUPzP+zPMvpnvVxBlUiizE8G4BIlfMgR3kpWD
         RWrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwLvV/a4utFvcIkjX1FyUvhvQqQzQcINQ2I61FEyJXlF3I7gDA2vd6B0sMOdEJgIQY1dPH2cKCbWxncXUUOLV9T1kuoWA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcvo0w2oBOJxh06MJQlqovFWbZoBgP/txXM7y57M6PDmeVGJBq
	MyCkgEtcB7vRBRw6d/+0JBxdki/by6OyJA02btcpqzuELx1fPQIOZkbIEk6dqBsPZbU=
X-Gm-Gg: ASbGncu1oSmXJNyOfpNVl7dOgtrVvLei2K+8i35BKl2DZZucUFl0Tot4sR+s0a1GybR
	PMO3pxKog0wMbrvF1seTm4kYfOwx2f1sxMUTWBS23GUA2iXSLZlRl6chjah9ui9t2VOIf8THQK7
	Uz2yXys2WtFau+T77TxDoVmgKjPWB+NG6acDry6iY21Spn5gSeORI3a2uNEe+i2qYUTglefpzwg
	iA5D0OW0+uj8ReNnS9O2v5GAMd6FoePysf3tO4Yuz3RDtmjTorn3WE0GleJeOaEl4WnXfY6b+/+
	VPp4rH/SZ9KaiEUqQ6M4ELRKkRZzzfT4f73aNid4x/gFQaVvenV7WUd/BR1B67nigZyQEyl5sVM
	Zy4FmQu4pSJ8bPQPb8rZzbiHZdKE0VJtDSiLVJOr+O59wWP6ONYnaqA049FYzSuv7I8kQ/ciGfi
	h+GOiBAsMdOMpALylrv34L3G+RK6GnY5jQeKWeWBlfdhScBF0lfGPMwOk6lSTw2fc4Oe6rvPo=
X-Google-Smtp-Source: AGHT+IG3xCMtLQ4WupMTNJrAVZbMFwjDtRzSLxUx8KqP9BDEsXUWShN/L3zuzWS91gTOKAIsESzwfg==
X-Received: by 2002:a05:690c:b83:b0:731:1bc7:7830 with SMTP id 00721157ae682-78a8b491ff3mr68864567b3.23.1763917265334;
        Sun, 23 Nov 2025 09:01:05 -0800 (PST)
Received: from zenbox (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a7993e2d6sm36143777b3.39.2025.11.23.09.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 09:01:05 -0800 (PST)
From: Justin Suess <utilityemal77@gmail.com>
To: m@maowtm.org
Cc: gnoack@google.com,
	jack@suse.cz,
	linux-security-module@vger.kernel.org,
	mic@digikod.net,
	utilityemal77@gmail.com,
	xandfury@gmail.com
Subject: Re: [PATCH v4 00/10] Implement LANDLOCK_ADD_RULE_QUIET
Date: Sun, 23 Nov 2025 12:01:03 -0500
Message-ID: <20251123170103.2640561-1-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <5c0de8ee7e00aff1aceb3a80f5af162eeaaa06db.1763330228.git.m@maowtm.org>
References: <5c0de8ee7e00aff1aceb3a80f5af162eeaaa06db.1763330228.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I had a question in regards to the quiet flag in how it 
should interact with my proposed flag LANDLOCK_ADD_RULE_NO_INHERIT.

Should this flag block inheritence of the LANDLOCK_ADD_RULE_QUIET flag?
It seems to me it should block inheritence of this flag, so you can
create more fine grained audit-suppression rules.

So for example you could quiet logs on /a/b with the exception of /a/b/c
by setting LANDLOCK_ADD_RULE_NO_INHERIT on /a/b/c.

If so, as we add more flags, should this be a general policy that
LANDLOCK_ADD_RULE_NO_INHERIT blocks access right inheritence AND flag
inheritence? With the obvious exception of LANDLOCK_ADD_RULE_NO_INHERIT
itself.

Alternatives could be a new flag to control whether NO_INHERIT also
suppresses flag inheritence.

Or simply having LANDLOCK_ADD_RULE_NO_INHERIT continue to only apply to
access masks. 

The latest version of LANDLOCK_ADD_RULE_NO_INHERIT is below for
convienence.

v3:
https://lore.kernel.org/linux-security-module/20251120222346.1157004-1-utilityemal77@gmail.com/T/#t

Kind Regards,
Justin Suess



