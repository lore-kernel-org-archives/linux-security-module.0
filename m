Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9B6409121
	for <linux-security-module@vger.kernel.org>; Wed,  7 Oct 2026 20:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791405772; cv=none; b=u3ZPhKRqftNpRRJdizsWWLxc1PL6vXPgAA2N9m3DSEjVg9gKPCWz4sUwHxmyryO/R+2Et0sgtjZZ72nglo7kLtpqGFTXztdsh9jKp3h1n/Rpe5uRYsLfjDd10mGwyQ7yKjnW2IACKbynjJ3uThEueZO/shSV9m8XonASXURboJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791405772; c=relaxed/simple;
	bh=TFY9tOSQZG6cW9Xz19R1Fsu14/FrS6A0ND2sm7laFW4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=utKyJggSUBQKcFDvljj64R9x0XdI9sXsxLumO/7WR1SfkF0MeIrRjJVC3Zp2YyyzjxKZAoeaEDN2kz4Yd57ai9Kf+ZKRlHFTNA5sAJ7+O754laMoBgAkQiIJMkwT00vxO/1JIqoMX8RFhnSlOOnhCTHXIQSdY3stTlnann7DHVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=eBCnAp8c; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="eBCnAp8c"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1438d9363fbso1648128c88.0
        for <linux-security-module@vger.kernel.org>; Wed, 07 Oct 2026 13:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1791405771; x=1792010571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2w44cogeP+44QvieTFJ7kjVK03e1YaQy1nQzOi9xKiA=;
        b=eBCnAp8cjMxB/xqiy0AqummU7qNdD+P0rnAm3da40rx0RbUi1iIYCP8l6jYraUfBT2
         Nx2bWgviVV17/JeoOJt5KT72lpYX91nPb5gheTWq9njdCARPeiDbQdu5JsuIAnNhkMGZ
         /XZzhXiVM+VL+Qv0JgHBqYfea1esAmG6QBQA2MGuDoqXuVlzhAoWbtkrsHEApxfVWCA+
         4fCIck7ErAlXq8gfVUUlsW8n1Vbfhba7zNpttLA87nF/PsCgEqcKZXAmbb2WHZSVYMgR
         HmbJyiVfv71qCkTXT966yn0IXowRKPCh/K3YiuUFTMXwlVf6Kf85xj6tF13bI7trBJU7
         3iLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791405771; x=1792010571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2w44cogeP+44QvieTFJ7kjVK03e1YaQy1nQzOi9xKiA=;
        b=qRaQsTOu2XJNLUxaeOmpLgBjkonSAR95IKyKOmAzTU8Wt+CioUMSK48MYWaXethojj
         YN0oeB5PZthNGU6hSAiT0Ws49LgtpaahMBurFbaMspt9wvS4jiu+ULB44IrofyO4+s53
         UolQ4RHZQdYsFDYYqYRknM9/D03FHoVzpzCq1Ax6r27aGTtg87Sy1idk7q0LKkv2o74L
         Ojqg75GsAYQqK2JE6afyMYR8EJZ9hRDAgMEy7dJQ/+DOyEubaXYoo/WVOr4byQ4MGwAx
         9T214IS9CmMG0sz/+/pj+JqZUQALgGnn3hYxW464i7hSPuWfXorZvR1hPsZmq6wKUh33
         Xstw==
X-Forwarded-Encrypted: i=1; AKwUvByM2Hq6fHYqFou9gd3WAiDhPeowdHUyHDmpZt5M4covEW5giJbstbBg7+vS7lUWbXhICylOrDokGC2j4BHKlYCU4Ko7LuQ=@vger.kernel.org
X-Gm-Message-State: AFuF++niOEXitKV9VX0acGEUZjlRg1LVMu6dRlv41qb55tAET+4/M8sY
	uDnPbErBk6mtH415AsGLoT+sxqDyhXyk0bHKmTSLma6mv19C0TfqYvkOQC3U1n2X4eY=
X-Gm-Gg: AYBFou0bfe37XNo51lSf9DioNfJ1EMTBwLl6/gQ0ajTSDwjdE66hR1tZw9Qj0dr1Soc
	PWVn07M8trxkQ7n15PnjteGWwvqaePV+wPcoSWAaQd4RWxAhAwlTnqNboG+rxnHXFCxIwM5I1ZZ
	CfTlgiL6ZV2oG7b8A50dnVGBoYz86CYonnkZ9n3mTB0o4/N5LQ8T0OoiR2UR3f0jmsBg2voYkYp
	LHLoSYMfACmlanAG302zvb7U0rqbx1NPrGZtY1i2xVnHY7ici7t3KzeysqsW7DwJKSVZZtUAs7k
	XgUtMezS2x8KvEaWjQ2pdYOhgML6oLlqUw36A9X6JImkhrJxzd6Pv6USICT5txbGxU+VemMFD7e
	z9DU08sdf/6kbAepUvOJuVkzlul7u5Spx3fm+Fb9s6IoQ6F3/gaCv7fEm1Q8t/e4ZWaa9pOH+h/
	8gfak4NzXPbH46f96lwWIagBn7eeTUd8MZjpwk12BHMunO16BovdoXtxSjXsqUjXGVpcFuPCZXX
	DYxz6NdUYAKfDRkJkTGKmpCKljGfVD3J2oRkwwG1epbxVCt0rMWXktE85lZ3IBBT/EChCwIC68I
	5dNc0e4=
X-Received: by 2002:a05:7022:b0d4:b0:14c:c588:ac21 with SMTP id a92af1059eb24-1659f86d360mr411370c88.9.1791405770312;
        Wed, 07 Oct 2026 13:42:50 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:7854:1520:fd4f:2a94])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-16167ef2e54sm7586938c88.10.2026.10.07.13.42.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 07 Oct 2026 13:42:49 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Helge Deller <deller@kernel.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Helge Deller <deller@gmx.de>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Georgia Garcia <georgia.garcia@canonical.com>
Subject: [PATCH 6.6.y 0/2] apparmor: backport CVE-2026-45893, CVE-2026-46254
Date: Wed,  7 Oct 2026 16:42:21 -0400
Message-ID: <20261007204226.47033-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg, Sasha, and maintainers,

I'm working through the smaller CVE backports still missing from 6.6.y.
These 2 upstream changes belong together for CVE-2026-45893,
CVE-2026-46254. They must be applied in this order because the later change
depends on or completes the earlier one.

The complete series is already present in 6.12.y, 6.18.y, and 7.2.y.
These fixes also affect 6.1.y, which will need a separate backport; this
series is only for 6.6.y.

Could you please consider this series for 6.6.y?

Thanks,
Artem Dinaburg

Series:
  1. AppArmor: Allow apparmor to handle unaligned dfa tables
  2. apparmor: Fix & Optimize table creation from possibly unaligned memory

