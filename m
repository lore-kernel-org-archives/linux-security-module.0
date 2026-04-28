Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8F847CC80
	for <linux-security-module@vger.kernel.org>; Tue, 28 Apr 2026 19:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777404534; cv=none; b=JvLohCPLSXkWJymu5YeRX952RdO6Wu186n+51M1dvZbDTR4nFppnMmTr1n6kzDkdjXFP7RYfw1rjbA6pisksNbBRwBV9Bhwz0RsHPvxdCPl/MOFTfotRLigMV7aeJB7iRaLQNXe50VZ7/niNL2TItB7S4GpfIZPd/S6g5daXNd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777404534; c=relaxed/simple;
	bh=NuDqJGTOYHhRsQ9gakG/33fRFBaIncRipDI9L+xU6VE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZW+hsAN7cYubJNLST4GftRxeErwDVWKaPBZ4uWxdtztF22lap3dwUnaW/P6GOkXlaPejJmmBONEebj7Z17WzHTxtoQgjCrlvLdnG58PQqoC+t7+s130Dxrq7bMJ4tHLRXIaTXf/L3Wreg3TqE8VANwRaQACYypv5GrFXkSVA1NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zetier.com; spf=pass smtp.mailfrom=zetier.com; dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b=fMDzRzoD; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zetier.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetier.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b="fMDzRzoD"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8a016799d2cso129360256d6.1
        for <linux-security-module@vger.kernel.org>; Tue, 28 Apr 2026 12:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zetier.com; s=gm; t=1777404532; x=1778009332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1SF4aD6INk6fdsWXArAkTfVU/esaaz0J7oWltfvu4dQ=;
        b=fMDzRzoDPgZqKYH6oJLVxYyBGIX07Lh9ggOkiepe8GeKNivlK9sQMdBuXDBoA/J0HA
         +Gn8mB8txVsaR/PEVtAf278UdR+AzN3rB1WIKjN/x2SOndSU5k0goLvAKYkDGLqPdIXy
         kqPuBXyKEtZhOXZi2jd8aDla0KYHyZmWu54BjOiZBi29z9oqXgv7hwC+O/xaEK37HZcV
         2G0bfmw4fXko3/b6FoVcYDa0/NqnMbBRNsH7pkAgdaLeupxM8P7BB2RCEijVZvy0b0yU
         PKY0/uyiVE+5PCUXw8p+owYEo+mmjXd1JJ79h7a9iQerx/4UXe7NR7QwQ4Fn3TWnzKpf
         3C9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777404532; x=1778009332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1SF4aD6INk6fdsWXArAkTfVU/esaaz0J7oWltfvu4dQ=;
        b=DUiLiCJaAHW/rm4XMqqhDYHTln7yrNa2ghHFhtBO3z9wzx84PDf55ic+fYgqfFRohw
         8w7+i5BTze33xcv6r8VEg0RT/FIGKxH7bbeEdR06Dvto3Zf9ihW7yh68Yt2gyy/UM6/o
         AMIG4y/4TmGimrsqJFMiuyG+s9KLpnCuvhXhCEYnVtY/HKxfQuVBkO2+dBi/b2iksvS1
         MUUQ0BC8CfPqiq8+PGCISzJSB2vRQjnZMBXfp15qU+7k5C35dRDjxSzZZYIoG3ISUjqc
         9lu3KIylIC00YmltDCF5H8RsvK6wizKomLBWv2jvkqaikqKm6xvA5CQPRdYx0LafQqOz
         XMRQ==
X-Gm-Message-State: AOJu0YwFLvJLrdTTUneSEMgg6JyNCDAObqzPRtvrxvYPo2yd1UhdbPQX
	zkSqAN6UqLpg1Bdmi9cSUIjjbhfzfjYe0eC4+IZdr5Na5979x/yGpeVBfh80jQc89ZU=
X-Gm-Gg: AeBDietBx7G3kzIwafkiiA7/TBaq+8hObSX0R7eWxqDGro3XkWoP0KMcQwlaToLoE7x
	bM7mDXWqE3LpHj6EGv5pbZiO2LnNksb2iueK05TcwsrGDlrBhmULYMrR/ofSzTOA8nB3xWmncAm
	aPiWMLzaBSjkGMqZPz88DwBQ5a/Q9taIu11Xs51CRxDHRiMykumfZL1Kj0vYVa06oBsogijXS6K
	Nij4EYx6smjuWgRh/ZU0kbqyH5GjlUpk9mTxeFD6jqqiJq4Kp9gdqbLRxBjHVKMk7WDfmRSNmRD
	Cnjx3e/U1jEqLWQPc9APGIcMfX3PzaH83NwcwqaZCK316OxuDAfCBgzVhpWhNzvPhVgA4lQ8hRb
	ED199WpjkaFw+vie/cETy2D1FKCfjPOQGfWxLkv8hIaTyCl8Pv+iy4RZHtHXyaPu1MqgFCPcag0
	Fx9duCUezT6TvEnICNMnFXrFxHIEd27iCVncg8h3b20iGrKOj42zHAB6JK0Qz0oA1X6NJoAvbsR
	dxYdg8QpaVmnqg=
X-Received: by 2002:a05:6214:2404:b0:89c:ac72:2f6e with SMTP id 6a1803df08f44-8b3e31dfb7dmr75110446d6.43.1777404531618;
        Tue, 28 Apr 2026 12:28:51 -0700 (PDT)
Received: from warpstation.incus (243.69.21.34.bc.googleusercontent.com. [34.21.69.243])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b3ee9cec79sm1922826d6.15.2026.04.28.12.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 12:28:50 -0700 (PDT)
From: Ethan Ferguson <ethan.ferguson@zetier.com>
To: kees@kernel.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Ferguson <ethan.ferguson@zetier.com>
Subject: [PATCH 0/1] yama: clean-up ptrace relations upon activating YAMA_SCOPE_NO_ATTACH
Date: Tue, 28 Apr 2026 15:28:17 -0400
Message-ID: <20260428192818.1035760-1-ethan.ferguson@zetier.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Once yama's ptrace_scope gets set to it's max value (currently
YAMA_SCOPE_NO_ATTACH), all ptrace actions will forever be denied.
However, processes may still add ptrace relations, and the memory
to store these relations is still allocated, even though it is never
used again.

This patch cleans up all memory related to ptracer_relations upon
YAMA_SCOPE_NO_ATTACH, and additionally disallows further modification
of ptracer_relations from processes.

Ethan Ferguson (1):
  yama: clean-up ptrace relations upon activating YAMA_SCOPE_NO_ATTACH

 security/yama/yama_lsm.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

base-commit: cf2f06f7152d
-- 
2.43.0

