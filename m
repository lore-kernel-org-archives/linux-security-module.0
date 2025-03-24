Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B889A1DC9BB;
	Mon, 24 Mar 2025 20:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742849436; cv=none; b=GZ1F/f4QckyzEbFJhnC5XcoRfgt3rwj+lCfLBWWnkQJR6vUZXvPxrrtCUPnPfa4gs3WviSHMXXFPryx26qxcQyBbdZdnE+C59pElAcrfhkCzZmxLZhWrjwxdYzAK0Vtwfu+r28QY8iVJwZ7Ka7BvUHGW8AfgtGuJ3QG/1qgp3rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742849436; c=relaxed/simple;
	bh=mk8wlYjaUGveE5OrW4hhvleivR5X97FVKei5tSxhurk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ZgI5RFDN+y0/WMl3Q5F6NVG60LcrhPvCZkt0ijRK+vLPkM2B886wLTrRaasTsozPHktrwIWkRrPiUtI3wNi1rVvbDbWosswKxe8/LP6AhLQnmXNKfEeEwP9DIUUFxcbRy6KxkvtXxQ11MuofMYR/qhM56Fu1SV0V/onHaq7YD1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHpCSSk5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHpCSSk5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD0AC4CEDD;
	Mon, 24 Mar 2025 20:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742849436;
	bh=mk8wlYjaUGveE5OrW4hhvleivR5X97FVKei5tSxhurk=;
	h=From:Date:Subject:To:Cc:From;
	b=eHpCSSk5bNY9/A27SdU2YshDsb4MVVj/f99VoYx5sHWs/WU/+uqco7pFC6lEvlUIl
	 yupUtTsMZGtuCQAPvFH93/m+OpbEO5+upwy4RvMXObtukIRodW6dvMnTKcQL3TYTe1
	 XZtSc4fIr1lyZCvCmlA7hKEZPOCYpF2+RYEkJOkQhtm9Th1AIs5w5iAj5HFqcqOl+X
	 KHdgjoNoaUTbjD3Qn3clEJvBaVA1ZjcspoTfrALEKF7FhKAYaqd4rXrniHolOtibmm
	 X9EGmTZM4kYowlBkbLuTJZnQFA8CwOuD/XB3fG91CpiwX27EziVbbqtMagxN93wW9O
	 e5BsenGuk5Evg==
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e5ad75ca787so4173916276.0;
        Mon, 24 Mar 2025 13:50:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXZhi5eGguNg/ClviPRT6SQOIqsR+tswDvON6rUCC+SQAMGKBZogt7RJ/okT3aQ2pEResHjU8GM8INTznw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+unnT2CHV5+8/yVqzVSb+k64mHBq79W5A5gNv8LTv1vMMWNn/
	c7x2ZeMSdJynzRJ4R7zuchHr1M8IqZ3jUGoSKYAvPN5EciZfVy6RZBYD6B58TaXgf2N4cTG1fPX
	Hh5+XA+y/TtlRlPD0tDFXRZGlbt0=
X-Google-Smtp-Source: AGHT+IE4EE4XOQrsJMyGF2OM431UMvL4+tgZd6Db5EzoxzmWIAO/SIBxrq2PJG+BwgYIIWxpHvcNCPk57yH+wCVtvF4=
X-Received: by 2002:a05:6902:1887:b0:e60:9cf3:5a51 with SMTP id
 3f1490d57ef6-e6690e98687mr24133265276.17.1742849435564; Mon, 24 Mar 2025
 13:50:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Fan Wu <wufan@kernel.org>
Date: Mon, 24 Mar 2025 13:50:23 -0700
X-Gmail-Original-Message-ID: <CAKtyLkFq-4vHbinAjsTyxU=BTNR-yFfy-i0nvLSF_xWQ-awrMQ@mail.gmail.com>
X-Gm-Features: AQ5f1JoNGJXAFX9WiKI30a6UcbUWfqspH_GfXZ_4K1syzihepKoC_qopImxSMb0
Message-ID: <CAKtyLkFq-4vHbinAjsTyxU=BTNR-yFfy-i0nvLSF_xWQ-awrMQ@mail.gmail.com>
Subject: [GIT PULL] IPE update for 6.15
To: torvalds@linux-foundation.org
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please merge this PR for the IPE update for 6.15.

This PR contains only one commit from Randy Dunlap, which fixes
kernel-doc warnings in the IPE subsystem.
This commit has been tested for several weeks in linux-next without any issues.

Thanks,
Fan

--

The following changes since commit 38fec10eb60d687e30c8c6b5420d86e8149f7557:

  Linux 6.14 (2025-03-24 07:02:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wufan/ipe.git
tags/ipe-pr-20250324

for you to fetch changes up to 6df401a2ee4a91f4fd1095507d6f461f1082d814:

  ipe: policy_fs: fix kernel-doc warnings (2025-03-24 13:36:00 -0700)

----------------------------------------------------------------
ipe/stable-6.15 PR 20250324

----------------------------------------------------------------
Randy Dunlap (1):
      ipe: policy_fs: fix kernel-doc warnings

 security/ipe/policy_fs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)
