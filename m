Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4FE4349B2
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 20:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791493087; cv=none; b=q2UR4N6XDQmaZSD7H1g6tegmqlDWe/foFLlL+TF+19OdN375ppP14fYHucPW8gJABaQcxCiYKNXAnkY9tUVvi4xjzgyJzEENVwXSEa0uPhhHMNHcmKc7jD4st+FRySWnMuGlZrqSfs1G7H2NMtqa/7iwbFasus3oCBh/jWlM7jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791493087; c=relaxed/simple;
	bh=vpbeEaPR3E1pmaT/xNDC5hjULFUimCv8YKxCMpWM/dg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=p7t+GmDfueW4gUQ6t7LU/DbooEL8m20BV9/H62UfobWhz0/3P/5AKvNWAbta0oi7k0Bt63syi8gQcse6yAUdEP31QCpFl+NpRtDwosqFcwlHl8LciGoDc9RwHiaMtMENRo/L/1v4Mqh1clgphRMxMYnteWsYENGs0H47/zswxmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com; spf=pass smtp.mailfrom=amutable.com; dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b=ZGQjSkiv; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b="ZGQjSkiv"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-675676afc3cso4058108d50.3
        for <linux-security-module@vger.kernel.org>; Thu, 08 Oct 2026 13:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20251104.gappssmtp.com; s=20251104; t=1791493083; x=1792097883; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=V0S61SflNz3PvfgcGBGx11GkE7hBo5diSyO3i89hlIg=;
        b=ZGQjSkiv2AEUSaNPDRvhadrbCMs1ALgftpyqaSsdg83snUiUpmwdtkPBHcPjXcMSW5
         WTxrlWiKiSu+EiohigdEJyvDyhVbn64MLu/fV8wqp16F9oO2eu3g6wku9vB9EbmI0EB2
         LB0WiT2LDRLnb7pQca7cTWOuOr3HtS8ca1rVms1p3iMuRVnxHkLTRYX3M3TWpvURtRSj
         eBE8oMrgkHViifnMrhbObPdyBF9FhNEDWhglMesj5txF1bXZB9bHgf9B+uyEAXeKEaH8
         Mq4q1kDoBNvoY68r5QfLqMIsyxdPRH8aGDwENlYI12C3ehEf5R+UOFa5poKnY/LbpfB0
         fynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791493083; x=1792097883;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=V0S61SflNz3PvfgcGBGx11GkE7hBo5diSyO3i89hlIg=;
        b=osbUUuvcCngCIE3hFtXzRKdtHzruh7YxWZyOvdTdKFXWy08oDqqS0LYQFwln/vs61D
         7wz0COaDRXh7hpThu9UHXZhxbOP58rfidSCrGNj0veFYT5SwasOLtuak/Fyo8wNHW2IQ
         efrEKMIHcumHHYZLm1p7t3yWrBLZE2frWCLVeHIW39pmoPvOj8dvJpdynYiltsXXNQQB
         VXlh/zvugQCKqQOivmKvW3WAHov191acSKOLA0GjGJ3lBfyfq/ROajk6OOCiLfjFcXpI
         BDW5E9F1GV2/bmps3KspdI2e/yO4LnFpPKo6r/5zCG1WiX74myX0eBb4wbJ67RrfTAqq
         7u8A==
X-Forwarded-Encrypted: i=1; AKwUvBwfmm0Ek51Dv78U+YO7QwpvnXGOvGScajV9xCWCnrhjpCPRMDjWf0+1D7rLWhFdPsGya9b2JLPA/kCUc0AlwEuhdHqddzU=@vger.kernel.org
X-Gm-Message-State: AFq9FYK4XTM2VJ8ogR6agPLbeociqhWTHDOXWrrD397OgLHq/aRTvRmM
	1bRcM3EGf1c8WIWiHuxj8XYup+o+BrY3Jl0j5WbKimjmO+WYF/+XMnvcn5oOjMkHgoQM
X-Gm-Gg: AYBFou2NDM8XzPzIKubUCD2Bmg9/JLZVnqfIIsYhLdYBsZhGP692+NVQdoSiJSq7bEc
	d1nJDFqcKtXbJdmFUeprNSWOCrIEZuqtdQQQ8qnSKjQIj+Y/W8zkSvfSBWApSEtK2r75iiu7z6N
	SMRV0baP//w7ypdldATy9FNUK0o01+eDD6eGvQ013slOqH0mUrTcBbN5ogn5E9ZYwWpjvLy9iq5
	p+12ViOtyMoyOzGu94Gdyxl7dM2LB2dA/mcSd6qg028bZzBC5WRWQYhCv2XUdRkqNIrCM6VP6Y+
	SdX88qb6r4bvw/WDlMXZcf4nkx59jsX169K9N7t/YpKDVBkdFSSYB7lYWK6pm+5rfFTrcaeIB44
	o82+4W1iDN5GhKXJ0s7DPk5cx97vh1AJOV7s+H/UK50B7cofPowXZANpP3E5f3xxXA/mAyujc47
	/XJ1Lj3m5rBctAXbiXjgF3X+U2aQ5CvJeQBE+ZAsHUA3T+GZTzv79cLTYcj9eQR8JV60Qr9Tdt0
	5v+j2B0zGl3F2DSrRWl29vVn15/lF2igdBso0OOPGe0J5dgKp22zgIB
X-Received: by 2002:a05:690e:d06:b0:678:4671:d9d1 with SMTP id 956f58d0204a3-679360087aamr34732d50.21.1791493083618;
        Thu, 08 Oct 2026 13:58:03 -0700 (PDT)
Received: from [192.168.1.110] (104-53-165-62.lightspeed.stlsmo.sbcglobal.net. [104.53.165.62])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67935707401sm78814d50.24.2026.10.08.13.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 13:58:03 -0700 (PDT)
From: Andrew Halaney <andrew@amutable.com>
Subject: [PATCH bpf-next v2 0/3] keys: Add well known IDs for
 fs-verity/dm-verity keys
Date: Thu, 08 Oct 2026 15:57:34 -0500
Message-Id: <20261008-ajhalaney-dmverity-key-identifier-v2-0-008456d189cb@amutable.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WNQQ6CMBBFr0JmbU1bsIor72FYtHSQUSikrQ2Ec
 HcbbuDy5eX/t0FATxjgXmzgMVGgyWWQpwLaXrsXMrKZQXKpeC0qpt+9HrTDldkx5W1c2ScDWXS
 ROkLPKnG7GiXL0uAF8s/ssaPlaDzBzB1zuERosukpxMmvRzyJw//RSYJxxkUtpW1FqZR+6PEbt
 Rnw3E4jNPu+/wBcIMGP3wAAAA==
X-Change-ID: 20260914-ajhalaney-dmverity-key-identifier-4187b6233be5
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
 Mikulas Patocka <mpatocka@redhat.com>, 
 Benjamin Marzinski <bmarzins@redhat.com>, 
 David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, Eric Biggers <ebiggers@kernel.org>, 
 "Theodore Y. Ts'o" <tytso@mit.edu>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
 keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, 
 bpf@vger.kernel.org, fsverity@lists.linux.dev, linux-doc@vger.kernel.org, 
 Andrew Halaney <andrew@amutable.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.14.3

This more or less follows the bpf keyring approach, allowing userspace
to easily find the keys instead of having to parse /proc/keys.

Signed-off-by: Andrew Halaney <andrew@amutable.com>
---
Changes in v2:
- Rebased / target bpf-next/for-next since 264d8fd2794f ("bpf, keys: Add a bpf
  keyring for program signature validation") only exists there.
- Grabbed Reviewed-by trailers.
- Link to v1: https://lore.kernel.org/r/20260914-ajhalaney-dmverity-key-identifier-v1-0-01922dc1366a@amutable.com

---
Andrew Halaney (3):
      keys: add KEY_SPEC_DM_VERITY_KEYRING
      keys: add KEY_SPEC_FS_VERITY_KEYRING
      Documentation: keys: document IDs added since KEY_SPEC_REQKEY_AUTH_KEY

 Documentation/security/keys/core.rst | 13 ++++++++
 drivers/md/dm-verity-verify-sig.c    |  3 ++
 fs/verity/signature.c                |  2 ++
 include/linux/key.h                  |  2 ++
 include/uapi/linux/keyctl.h          |  2 ++
 security/keys/process_keys.c         | 58 ++++++++++++++++++++++++++++++++++++
 6 files changed, 80 insertions(+)
---
base-commit: e1d84a37cba984388988d2f1ddc84561413f0db2
change-id: 20260914-ajhalaney-dmverity-key-identifier-4187b6233be5

Best regards,
-- 
Andrew Halaney <andrew@amutable.com>

