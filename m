Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A23C3D669A
	for <linux-security-module@vger.kernel.org>; Sat, 13 Jun 2026 13:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781355867; cv=none; b=QOU2D9QMRZPfsdeCZzhsw9hmkUx3GV7sySfg/2qbtlkGlccfg8k3w+8mZT8uw8sUsjbnohXhzcTjk99/IcppmBKSe48HzIjH7PisiCC89YW59Q2/Es3wQdDNOJFSeRZ6ozUmS3VgcS1iwgnY4efLW/QQi/H/E4k6al55bnvqbM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781355867; c=relaxed/simple;
	bh=X7OGScrPB3yY8v+4SZVfnqVCa1sJajXf6ntS0Kunqn4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hpMW/sjnGUwZMr8YxprD9n7B6kKRgQeWTImPDFp56ObAw40eyB7D/p1O/ZD0TolQd3O/kZFoRFUA51AiBzi4+9hJt5rUKzVKdh+4p+bQfFzbvF1ILnUkwYL52WQKDNAOCT1+uqZVJLVeeJKg08EttPkfCDVbmi+noGEmE/UEA64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HdgTrQux; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HdgTrQux"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490c1915793so15637705e9.2
        for <linux-security-module@vger.kernel.org>; Sat, 13 Jun 2026 06:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781355863; x=1781960663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/sWTmGnPy5CRS6c/b3mIiUaSM3PjZW8cDV1skgU0XaQ=;
        b=HdgTrQuxBX0a9R0xmrm79S2dgCu1FuaEXA/I9BFzMezhBNTv/1qerlhfbLsZ9BjGEZ
         GeUd7416IKRwDogARZJGqIRdbSKIm8RrVulXYSvx4bKPyTSUYkKYd0074lpDlKZ3Unqz
         DATHvCXHN9PyNzprUgDqCRLAc2ZzDkIp8DyFHoJnqrye1SeNtGtV5OEw/uCyelL3iMvX
         OWJFoYpO8iVToVKoQnv02OUy/pHejGTB7TyWNwGHQ6vgKugC1GXxuBxomD3iutW1iVVg
         VpQnLNf6FC/6B+iFD4sfDNhyIBIjhbsic7aPVwNCGPXlCrzcME9l+OdYh+CNjftrmwvS
         lKWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781355863; x=1781960663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/sWTmGnPy5CRS6c/b3mIiUaSM3PjZW8cDV1skgU0XaQ=;
        b=JZT526wIyJIdI0JH+NfLD3/kc1QazMLgdi+biPTq7qMSg+qMElTAh+jwHc7j16xInn
         WYb1K7x99SNXvUUwGnLyav/ugz5j2CbOzdoGVzu1WkocGQpQCjmnrFAraE2Ie2d/jf7D
         ukjlC3weNf9hX32UZu8TWyCeqDZ4m1ZRY/YKdG8OaPpHVfTuf2roQQUB4AWuWAy72I/+
         X5LrplNpMS7WkhhgU11LDKt4OXMNzWYH2/FhIqsitd4FPkiDMQMdgHu81WDXGAGG20Xj
         VkxqfpsZvZ2g2A8Z8BVzi8tn2zfiIVcAHIfrGqNgGfr3M0im3YGDbN2dBeMV+/eaif2y
         fwqA==
X-Forwarded-Encrypted: i=1; AFNElJ+aWVUGolrcJfKKPiiCX+Xa1/vVN8tvzd1OfzD+jEHIH44Llm2v7Ncsen1dljDuK8qt6wBihkjE9ft9ettz66EWLgAzNEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlxOfyCj96TuYY8giioObIGYQqI8XFK+kySguVfD+czafIGNE2
	32DNFkgAinK0U6fOmnVFqxmwBP4f7vmLYATRjbQucZ56i13N+N3fLr4=
X-Gm-Gg: Acq92OGwN02+qoH0DwRMZy3H6BmFnTaA8QOYkCiSwWsKbdJq0oV7zu0SC1BzMpb4cCA
	g5T9h/yrg8O3tcCGIjce0xyRLkTLYQxRd3BkvqQglgEfZINmz2ppwl7fE5YC0F8D/EdO/kwixEq
	py1adLIJTV6OhW9DxMpS/AJc2Qguhr7OiMODSh0vsh5CcD5Vnjwn6jrshtrflAz1zDq4OgL5eDw
	Py01q/KiK1uL0gIHjpk6j/+QdObl8tiLKOeSk7RvKR0PBccYCMY3edhU0RY3WFPXSqWRKqUrE+T
	WIA5P/ExmImwVhmgYGmNvSphBz9PnN5Yuf1j0fs96HlMdDWHuRrr5IZEENgNX5xr5jj9dBsRMlP
	Vh37oeq+Dujig68G1OSLM0DxT9YZXHL4mGXZV/BU7L3iGFs5I4m7GxOxp3+24Vji3VRklqq7K7V
	/wJKvGC0PCSQO+KupbN1ywXluKlIHI+tC96FGJRjW2ynrpJL21akCPZh3a8mJy7gDP7gwgTqV2q
	aEP8P6q10jnPMkEWjDgW4HjC6sZuBdzWO1gbNX9
X-Received: by 2002:a05:600c:190b:b0:490:adb6:7957 with SMTP id 5b1f17b1804b1-490ec524ed1mr86995835e9.33.1781355863112;
        Sat, 13 Jun 2026 06:04:23 -0700 (PDT)
Received: from hp-ubuntu.. ([41.140.217.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492203c0801sm66259515e9.10.2026.06.13.06.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 06:04:22 -0700 (PDT)
From: Mohammed EL Kadiri <med08elkadiri@gmail.com>
To: jarkko@kernel.org,
	dhowells@redhat.com
Cc: paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	kees@kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Mohammed EL Kadiri <med08elkadiri@gmail.com>
Subject: [PATCH 0/2] security/keys: replace BUG() in unreachable default cases
Date: Sat, 13 Jun 2026 14:04:06 +0100
Message-ID: <20260613130408.13709-1-med08elkadiri@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace BUG() in two switch default cases with proper error
returns.

Mohammed EL Kadiri (2):
  keys: request_key: replace BUG with return -EINVAL
  keys: keyctl_pkey: replace BUG with return -EOPNOTSUPP

 security/keys/keyctl_pkey.c | 5 +++--
 security/keys/request_key.c | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

-- 
2.43.0

