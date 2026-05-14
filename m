Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AC4361DC1
	for <linux-security-module@vger.kernel.org>; Thu, 14 May 2026 17:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778778382; cv=none; b=jTama4W40N0MZD775hwuG7REpn/iPKY/u+XGpDwm4kzXeGBaM83c/6EAVZsw2QBS/ZU8jrJLoncYrlNv/M2rseScrnjV8MZuav4Aara+oyTNIeIQM8PaXS8nBnekHuoPeyFKs3vPhKlY38I2L+raQsZbqySpIxDJ+MziOGiusOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778778382; c=relaxed/simple;
	bh=J+qjlNG7yCfPi70a30kgJbcx9ouEfqYTcUcggQ3HxqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LGpWkXeIIf4EeJnBDmBqY5colS5QHvjPd5FztLClyrY8w04iCvxmXD/YTZoohUE2Ca/ltLw4LFaARP+wLdBSJ2C+Mxegnskddjd9i6ARK9ZUh1iR0kZYlW4zl2mAdv63UZA9+VqJOOmtiACVHycll1HlKhNcGYUMpY8UrPPuUP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g5EPzIWT; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5EPzIWT"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12c19d23b19so13727392c88.0
        for <linux-security-module@vger.kernel.org>; Thu, 14 May 2026 10:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778778381; x=1779383181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xsBBm4ZuQ5MGBzgA0ddyoKX5Ai5E3Bfgkd3FNlRPfrc=;
        b=g5EPzIWTEnYC9BWKWbN0rt6f3IbnYn4vkaTKUumPdGr2nICHJaiBUBbFwPTb0YPaqp
         6DcJBg2tkjj0D+6PBWCmjOnHN71B+p/mp+1yeOdlL1wcaXzUuAr4JHta6uIYMZG7nS3n
         WTQZuEeSY+mILnc28yeFy22gpbPCnQAr8WotDeR52/78ll2oiKiUckoeymGvVIMsNxqF
         IqXX+zDvLFrMMpoZeozoKPuEWckySWE9kUlysrrSlF35/JN9D6dgXLAI/B9ZKYxZxILb
         WZyFHoVbbiocMDbUD5QYEHV42t/CoLdbgEPRgm1KvWt5et7dB8LBYrKi7v1+Xem/LU1i
         Frmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778778381; x=1779383181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xsBBm4ZuQ5MGBzgA0ddyoKX5Ai5E3Bfgkd3FNlRPfrc=;
        b=E4EtoFZacivuhfERYw27J9bS+ZR/6A8zj6NbbqCOf1GloqExA+iq6wsfQHUx/StMgL
         uNPvXB+MmTAIEQm7l8tmxME3qjaWK7s9LPNxfIfJW1Uo2WpUO9Ozt1jZDCVr9nfTp4WS
         pNmu27kPUVTTPyzeiTFNGLi7auno+lDive14H+OJrij8JselluzObktU3OL0nf/zoXJN
         7sIZ5hevpXnMoT458bqjq8gy2eBCHp9bVLBiXOYtjKlEE2QdVamRqAcftX0J2PMk/szs
         fzv7Fn/OQOVzbWnIWjYhqyMTVlqB5KXZnRZ4l1fzuHQUPSdTen8+axbWSeohL06hCntI
         JHuQ==
X-Forwarded-Encrypted: i=1; AFNElJ9BE737ElmYgTUNKXHfap9myuQl6bQJPmGUq9R0h2I9PZn4PY6Uy7r2WJrDAPQgYuCccf5wETCMuwUH0psPMmRmzIQXE3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTGmTjbUQ6BHNJgFmCuMO6o0OXUFAcjfgMm/j/jDszNRqCH1QP
	kATcJLM5A0zcosMrSCLtnzKa2KXyVEGIrV+av67k59D0OOC7GStvtUpp
X-Gm-Gg: Acq92OG0VIzDv44Dhsu7yik6PNfp/O/ql6JSJ2o5HMa25sAe1qLR0nAiUHQ1Cood3O9
	ci0A1bc4fjirOTaEVNdiG9W+JTE8HMS8AX/U8euZ2sufU/c7Lb09iIPWtFvUyph4Z1OoGqnoY17
	gqj8/gWxNkSCc2dfSwR9hLbH/3QiFc8nX9ndsTb6VFi+bD0HicT7UeKEwJFAjShpKX7+LYnQhb6
	jUE169wk8GlVk93Yucq/98WobTnZpxAIacuYM8Bh8UJjM75seiZJMFa/i0AzSWDtXQ5VBhMtNCN
	nuzpg7Ya4n+9wHxo4zceKEw3CPEpkyNiU1c9c2UJKCx7WtOc0d4/cLznEDAwXtZumRQ7jOyeW7Y
	spBQ/2yG3NrAULZMNgYrNobESW3aI3zhg+3e/x+g42sZX4YIhdG6ngcbU8oyijq7ejShrMJpuTi
	lvAjzb0Xj6jJ1thZeoincs/9QTVU4kcLMf4Q==
X-Received: by 2002:a05:7022:670e:b0:130:c9cc:3384 with SMTP id a92af1059eb24-1349ac64a08mr4862213c88.30.1778778380849;
        Thu, 14 May 2026 10:06:20 -0700 (PDT)
Received: from localhost.localdomain ([148.135.103.3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbed531esm5349141c88.8.2026.05.14.10.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 10:06:20 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: netdev@vger.kernel.org,
	lyutoon@gmail.com,
	dsahern@kernel.org,
	idosch@nvidia.com,
	horms@kernel.org,
	paul@paul-moore.com,
	huw@codeweavers.com,
	linux-security-module@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>
Subject: Re: [PATCH net 0/4] net: trust-after-modification fixes for IPv4 options + netlabel
Date: Fri, 15 May 2026 01:06:13 +0800
Message-ID: <20260514170613.4098569-1-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260514165139.436961-1-tpluszz77@gmail.com>
References: <20260514165139.436961-1-tpluszz77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sorry, v1 went out unthreaded and 1/4 was duplicated.  I will
resend properly as [PATCH net v2 0/4] in ~24h.  Please ignore
the v1 thread.

Qi Tang <tpluszz77@gmail.com>
Tong Liu <lyutoon@gmail.com>
