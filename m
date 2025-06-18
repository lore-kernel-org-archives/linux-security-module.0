Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490F42F0031
	for <linux-security-module@vger.kernel.org>; Wed, 18 Jun 2025 16:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750264483; cv=none; b=PTwnwfFFwt1WcSS2wJ9ZnKhu/k4j5ASuuT++5f6gIm6GAYhT4rW7Dagl+Jjqzsz9V6Wn95j1WWlnh/V1GGN2qYNJuH083fAw5wrcsYVUBfU9P5NJFDnOYU2NJC/9ugLFu907ztE+9zpYqetpS85KeRsjJabma//elhGAH0g77mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750264483; c=relaxed/simple;
	bh=ZzkADdvrUYp2iBklNDWW6xzN0gMHXVooR4VxL/q0Dq0=;
	h=Date:Message-ID:From:To:Cc:Subject; b=CQ8E+ugBYnEWeh8V8AePlzOPcYoIGnLWgH570g9AaxhpQhUV8lmNv8tXWySwJhtpyz8UBVuCOTAeFSGJ10kMbkE8qntKbu5QWc6YunwmrZdn5IGrSKDXTckM+YtUcjTc5H2GyLSusqT00hzFpnUwijhh9UbiOdzHUeBVWkzFN8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VCt6yaDd; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VCt6yaDd"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7d3e7641b76so81097985a.3
        for <linux-security-module@vger.kernel.org>; Wed, 18 Jun 2025 09:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1750264479; x=1750869279; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imh5Ssw3G0KGFdr40XoL+KWm94eOloF5qrtOJ+fWZB8=;
        b=VCt6yaDdn3tqn0oi6o/OUg9dN5QKBmB1+CSNLD9T/Mectqsiw5Di3ihKtFq9VSUip0
         kbDXiVw/zk1i4+lb4XiCVMm/f7+/POeF192NrrnAr1Eh1Zve117g2SUqk6CSWt2SxLQ7
         6/+3UGaQ1t3JCUJmM3T1nXnLtoKnFYcViqYa5b4EUiMnwXBQe5HTgYWOqyrmt3coebGW
         ++6Fqj2GzJdfc2cgvZLYpDUmscDPg+Lsy9lcIwKuj/ssNssd0q5UiC/z7KsEsPxVh/cP
         yVtIHcCBMfWh2KLMIKFz08KYQAlR3b2FrPWk/5YlTq+NUMCeZV0g5Tkv5z8UdErLNnyR
         njBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750264479; x=1750869279;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=imh5Ssw3G0KGFdr40XoL+KWm94eOloF5qrtOJ+fWZB8=;
        b=F2KdXVzkIwKBq/1FRdxTiEBaDFhqtvDViC2zoCC3fW3y325VVqx4StcW6fMVBkg5ER
         0Mtwvnj/R1NWnFXzGJ3BOvWRYxaqHVcRiZdPQJUXmfooBKf+wfLVEs5fKMaI/+7/0Tka
         FpgtM0SDRz0/MguPoWFM1D5qxuTYOejYtxvugkoevCGFJwj+5mSJneXQeu+M/X0f0Kim
         Ml73ko9wdXww6p21WyFEb8xvE1nqn94yQz1qITp9lBdTvhfumWaQmnggBS0SYLetPbYn
         1ITPgeipusjSkfxlur6Z8Ay/soY1NbIzWCNYZu5j2kBVyXGRcVupEVRsWw0fgQCRkHIa
         BS0g==
X-Forwarded-Encrypted: i=1; AJvYcCUIqUcjG/0HU/YBSuk4YwjKaQrcTiG8FibZWkJTSQNLLRWEnmlR53IJT0mK2glqaTOicA3qRMQuAkSgVEVU1Z1coYXFT3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJv/yGXTR75Iztzl9Yal0ENbBhzmFq6NWbvfQAuvvRiuuLnNyy
	pLk/l3FFQipLQUsoHmWYkTspDtEQCBfAncCKJRk8SRDMePUPCHcuvQE3eWZJuQKWZw==
X-Gm-Gg: ASbGncvAgTql1eEZWBqxfISAFhV+nDHJRzsOyXdKQt6DLs7m9IHNHlqGUOEAPTyt9Av
	e+NA0AVP65J83wLoCRrrSQ1X42QqL3zcm+xiauZ/C7jxF8XZhI6j6jE9WlFrrS81RidkKbmk0QH
	miv97jM58EfLWOGQ4eKn4nTLkeXngf3CZ9IOI5We8ncge248Qovnt5oqxK0z01JbdcWicRCm4mc
	3dvGxS4iLHhD7hTXZ7wd6nqCwa6T2DL+TRP4li8ucGdMZjWy57Xbk5Ate7tBfQHSjq9D9aj6FJX
	D0TQPbInfAgFUoWfe7kP2D1pV0gGO9rs9kpSpbM102efeyighcPa9G+xHSU3RuVx0mjBQn9v+kR
	mVpe8pf5Oef30FpJGK85So1S/VGuZGSE=
X-Google-Smtp-Source: AGHT+IHr8FvKf71qQwRs4UPz7p47lfWchWTy4Nt0DInVpS3n1BfVZvOZGMOilRzif8doAl9RkPjI0g==
X-Received: by 2002:a05:620a:3725:b0:7ce:f58e:7e9c with SMTP id af79cd13be357-7d3c6c0c72bmr3217588185a.7.1750264479031;
        Wed, 18 Jun 2025 09:34:39 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7d3b8f114absm778879985a.106.2025.06.18.09.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 09:34:38 -0700 (PDT)
Date: Wed, 18 Jun 2025 12:34:38 -0400
Message-ID: <5894f2f11a7a4741ba0279c703160e82@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] selinux/selinux-pr-20250618
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Linus,

A small SELinux patch to resolve a UBSAN warning in the xfrm/labeled-IPsec
code.

-Paul

--
The following changes since commit e04c78d86a9699d136910cfc0bdcf01087e3267e:

  Linux 6.16-rc2 (2025-06-15 13:49:41 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
    tags/selinux-pr-20250618

for you to fetch changes up to 86c8db86af43f52f682e53a0f2f0828683be1e52:

  selinux: fix selinux_xfrm_alloc_user() to set correct ctx_len
    (2025-06-16 19:02:22 -0400)

----------------------------------------------------------------
selinux/stable-6.16 PR 20250618
----------------------------------------------------------------

Stephen Smalley (1):
      selinux: fix selinux_xfrm_alloc_user() to set correct ctx_len

 security/selinux/xfrm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--
paul-moore.com
