Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568F620010A
	for <linux-security-module@vger.kernel.org>; Mon,  8 Jun 2026 05:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780896706; cv=none; b=b1Hb0jxq0+ZtPi9RthMkQ42fj4W1+H4SL4IvNKDJqIX/RZVqaZDOR2bCgRq616aETFRAJPiopUcBk9UvBan0Zsz+i7HXU76DoaPHxa2igp2CyhchdFHCnRA4lgbO0Fs2m1TJrjdsJVeTO0kinBaY3enJXU/F9s56LUcPknu1R9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780896706; c=relaxed/simple;
	bh=9ppVgDZ+U7TaJUies9zDuhV2krfxFDCefrzMocA3Pro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FkiKsqeTntXTDJnYAIN/8/7VH4jJCSy29tR0YND3Vsy1sjxE38hByGmPJMwMn4tedrUPmF5xV6hV6tTSHkTuuuFd5JoEVvFEHVLuW1jy/a8nzv+KneBZDB9lvW0fvk4ZMw9PEfIkulYs5G3zu6M3/3TOiOseUT6XwevjBJaVcKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BfHGR0Vv; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BfHGR0Vv"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-45ef4223be7so1948379f8f.2
        for <linux-security-module@vger.kernel.org>; Sun, 07 Jun 2026 22:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780896704; x=1781501504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9ppVgDZ+U7TaJUies9zDuhV2krfxFDCefrzMocA3Pro=;
        b=BfHGR0VvynO3NRE4POLJpC3e/XGiQ+nhGiO7Txg2LgNGhg0Q4fhNz3Chxpha+KYv/j
         ghV92s6w6RbcNmJQGvE6qzg4qENvR0QGnwqDNFGrvuqxt92ogTKFJMT00FnxO0AZENm0
         w3fMx1t7e1smKHDy/vSFibRTNyprp+SPVb7pgQfDfNjaYHCDCpA+EEd+lM0AvlkSJRTY
         +lUT348cVvGaTCm4IWNJlLsCGBPrI/9OblwegFQiW26PM/nH3zJ0+L4f42ReYj5zyxEY
         rpMI47SSvS2JabmM+lPMEjWMIZqup9FyrzPrrVEsrMcQe0FWrpSZ+Ua+tV/NlerZnelA
         K17Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780896704; x=1781501504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ppVgDZ+U7TaJUies9zDuhV2krfxFDCefrzMocA3Pro=;
        b=tJRNHXgXDnQ23QuGfM+gtcTnO1Ghl+/zkLLwoojYU5VWa7cB8Fu27ATk25rcff1Rin
         Tn/ND/zrVGTFOycwVx7zUg8WeenZ+3OLVRLDsx2kIf/YP7M6hVQ/xGODvbL/Ecppu+Rq
         ciHJOU1d/aI7HPIsT2zcaw40Q2ySmkG6t4DfmV7umA/WMe1GEwRnSvHoviWDSqHN1Lku
         Oykk/8EdaVfRSP6IINyxC68OEde9y7dThnFkAP9ivlZWIZ4d6UwJR59MjoWWO0Y0y2fN
         A288aJqRMrpngQh3v91RVqRC2paH6fmstn5AQCsq+sCBZZ7f4KfKvUq+kjeOuVhTl0o+
         asZw==
X-Forwarded-Encrypted: i=1; AFNElJ9JSKMPfmZT3bkRJQ7ZMtB9M/yzDhu+4crP1x2D5bqjjCvluPDFFAsNaXEMzyz+1JPl2dNS4dXjz4jgqEl66sSw5/rtPKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNo5B12lceDuKB5qkEJoZ0+PE2ZhpAaoLZtPk0L3I3oe8hzNp6
	QmekeTnJRoqDmGYmLZnEtF2IH4HyfNTkOr40tJYRMCfEjhRpH4MFoXDm
X-Gm-Gg: Acq92OF7lpGjvs4kT1aeEM17lehjcOzIEcRmlwFa1yoBocHj6ysbC5iKvcLyeeOTU+Z
	GNWGZLK9+xdYg2tnO9wCqtVwKecFd9RgaNKTUD6EEGIUhazj7cKNgwkPoTQKuIf3SBL4czCHpV1
	Kd+OWpuPqyeqd/iaEIYVOj5YXLTT5tSHv0ZnK1PfsboY6Zi0OYut0b9CkKBTAa1Tbav3y8KhZs3
	1061HLO+S+5Ds00qct7GoC5+cDI0g3WHM1Drd9c99fwvCrGMqyeAUKjBvERGluxrRsfbOZpJK6q
	kQKozRJEsO0GYyumFdTN2eqbEsq9RkUPcdf1jfUq4Ey0Bg+HqBV/j8GuET4bxRC2te66oyI0Gif
	Z51BNi8DiUb1V/baz70pjG2+uJ//bpbdWIhSljQy0v7I0asy5STytOVWubcdk2HEHgNAYtywLc6
	yT0kOqeqvKfomTrHAGCcZKzYfDMcJKf+KjRFBXL9c+g2VqbM2Uwz8kw88Wzei9uCC8HJxWYASmN
	ExQmCwjkdTj4WPv+2NKSN/A421SH/jz6atVg8F2/zyDHeYLjV1qP1396oPWGdbGg42pjsnhAuhc
	N2jtmf9hlnJxc9xTULfA
X-Received: by 2002:adf:f5c5:0:b0:460:18cb:8f9e with SMTP id ffacd0b85a97d-460304fec20mr17569371f8f.12.1780896703405;
        Sun, 07 Jun 2026 22:31:43 -0700 (PDT)
Received: from instance-20260604-012959.europe-west1-b.c.project-2c9d95d2-bf4e-4d5a-ac6.internal (250.69.76.34.bc.googleusercontent.com. [34.76.69.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dc577sm49241280f8f.3.2026.06.07.22.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 22:31:43 -0700 (PDT)
From: David Maximiliano Hermitte <davemadmaxxx@gmail.com>
To: paul@paul-moore.com
Cc: jmorris@namei.org,
	serge@hallyn.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Maximiliano Hermitte <davemadmaxxx@gmail.com>
Subject: security_inode_follow_link: KASAN UAF localization report
Date: Mon,  8 Jun 2026 05:31:25 +0000
Message-ID: <20260608053125.1088564-1-davemadmaxxx@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

I reproduced this issue locally in a QEMU/TCG VM and I can confirm a valid BEFORE signal.

Summary of the local evidence:

- Reproducer started: yes
- KASAN seen: yes
- use-after-free seen: yes
- target function seen: security_inode_follow_link
- target file seen: security/security.c
- Call Trace seen: yes
- RIP seen: yes
- BEFORE validation: true

At this point I am treating this as a localization report, not as a final patch submission.

The trace points to the security_inode_follow_link / link-follow path. I would prefer not to guess the final fix, since I do not yet have a validated AFTER patch for this issue.

I can provide the reproducer evidence and retest any proposed patch if helpful.

Thanks,
David
