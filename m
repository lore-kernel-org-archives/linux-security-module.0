Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2F7155300
	for <linux-security-module@vger.kernel.org>; Tue,  7 Jan 2025 21:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736284132; cv=none; b=GF3sLGuAXGD5orWjeeQ4H6kRX72dTE5bhH/+/9er7iv3kssPOtVWIhkd752tfnRgH1/rtgpERMWVUL1ZXURGUtZ8uLoOdtQYeU3rtbWM/OZRqA/2nxtvPC0dUkkKmsEOubtfbviu/behxUG1SKxd9GRg7jKyFZ8dxi6bUYRRtgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736284132; c=relaxed/simple;
	bh=UmYpMqsgFp7ajUlGqgT4nC+RerPJh6mWPt1LC32ppE4=;
	h=Date:Message-ID:From:To:Cc:Subject; b=iN14wVrniZE3eLKM26rSCQ7UxTjqDqfuf0tZy7VsNrC6oXKE9ZgrNNdjBKbm/MRTjdQ0crv9bzKaF9JqxaTZmGHxlvfppeYvCI5cN6OZr0ZSMWhHCy1NjDJf8khpoEd3nY2gVvkj9asxhSZASaWcFOgWDO/Q/MtnPXiqlTYDjIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TXc1o96P; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TXc1o96P"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b85d5cc39eso1686540385a.3
        for <linux-security-module@vger.kernel.org>; Tue, 07 Jan 2025 13:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1736284129; x=1736888929; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGfiCoS1DlmnGkeIzaR9XAzcygC5mY6MEHB6jpv/RnQ=;
        b=TXc1o96PjprMpgpZ1tRYN3qxB69rVxutHPxZjv3xbXjOOdYIGYk6Rb08SqTRPhHVki
         ngYFSVWAR/9I7luOCBKQ17ICtpusE+lS1D69HPOZo4FqOUhNOObcG73zJ3OY6WG+Y++f
         W3dKDol9c8WUCJ7GpVaZ7d1eO48Ml+mC0kuNkx6O7bOqnLhYDujjsQcqwXaO4sTjLL2G
         szDzM5X6Zd1z3ODivAqHr0PZOSEHv9YgATprz5oNfQd+LS6VnVlorMmu28sM7oREwWN2
         JfKPnxU3OiARYwCJCFufspuFLc1JIjOM1/f25I55g+AN8iV2vePZz9Rfz5htJRvZLwMK
         UJ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736284129; x=1736888929;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CGfiCoS1DlmnGkeIzaR9XAzcygC5mY6MEHB6jpv/RnQ=;
        b=dDw2fTNeNYW2pNxJXo/BnBKLCnqMFcssGn5n7AvQpZNnzz8mR7C2x0uQQtzPi17kFW
         jiTXpQOYUbPCDZ2GRSHTEXYENkUhUnZp1N7NWmcIT8mFynKCIALDAqllpuViAUUQ3euD
         5JWLLCnwY84J0Lb9FdCsfu/tKZKANYctndRAZPVf4w2HFYN5xo2llWVK8MGHs9+rU+Mc
         /NxXz3xznsWbTu03cgoOWXF02mWIFkYt+iY5whvMqllmAVzK5Qa8JKb+S2El4WLmQ7gB
         vhrjYXd5D9+M0YNl0ibgxgpD5dvYsa87RDBbZxfZx3uc1RukMNXYn7PJgNOH81Yhf0ZD
         IPTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtA07AD2ItnMgi4EQyHADb2ehsAo9jF/o6HnPWF+/KOQFtT0NpFXjhZT8CtTI4KHHhI8FcYqhuzJctjvj5HcvVVeelZrg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+zvLAutc/Dy3uxYi+Gdn8Ox/raF0i52u5Sj7GuUj9vVG2xeyz
	bMWQR0gu7m3FYKMQ2/Xh6BL5hDCOvRA1q2Czy3vrlzkdd3nX22bdRkXHbtKgkQ==
X-Gm-Gg: ASbGncvoYf5fiHS3wftpoTBaUHNrdVVsboNFeve5Ck1w3qqhkOjopAJU5htmuVGk/cv
	sPLkILGDpp8BMKHkDcJFnHr4Xa0DvHrJlOPymgRNnbuSHmjol9ENMBR73CP6jLMib1ShLucBtDm
	RJ519cuycANI9KPZoltLjzp5ZVquYLxJHhV4HeENOcRj6cHeADsCUq3voDWnlNUDkpBQbVyXOo4
	45BxaMvMmF6o7zZZXDg8AyUrVOqjnxYKe65h6cxeEeDMIJj1hE=
X-Google-Smtp-Source: AGHT+IFGas+JxRm2YxJhoo4Z1fiUNC4KivtV2LvZ5+p0cpAU2PRONKlmEZNxym1SKrVl5TiEgPwePg==
X-Received: by 2002:a05:6214:252c:b0:6d8:adfe:4c73 with SMTP id 6a1803df08f44-6df9b2b0835mr8172006d6.27.1736284129290;
        Tue, 07 Jan 2025 13:08:49 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd7debcc33sm108115196d6.123.2025.01.07.13.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 13:08:48 -0800 (PST)
Date: Tue, 07 Jan 2025 16:08:48 -0500
Message-ID: <c3eecfb79581eed47b37aac6b1ab8432@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] selinux/selinux-pr-20250107
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Linus,

A single SELinux patch to address a problem with a single domain using
multiple xperm classes, please merge.

-Paul

--
The following changes since commit 900f83cf376bdaf798b6f5dcb2eae0c822e908b6:

  selinux: ignore unknown extended permissions (2024-12-15 21:59:03 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
    tags/selinux-pr-20250107

for you to fetch changes up to 5e7f0efd23238039bcd4fc72ff28d94f364ec26b:

  selinux: match extended permissions to their base permissions
    (2025-01-04 20:58:46 -0500)

----------------------------------------------------------------
selinux/stable-6.13 PR 20250107
----------------------------------------------------------------

Thiébaud Weksteen (1):
      selinux: match extended permissions to their base permissions

 security/selinux/avc.c              |   61 +++++++++++++++-------------
 security/selinux/hooks.c            |    6 +-
 security/selinux/include/avc.h      |    5 +-
 security/selinux/include/security.h |    3 +
 security/selinux/ss/services.c      |   28 +++++++++---
 5 files changed, 65 insertions(+), 38 deletions(-)

--
paul-moore.com
