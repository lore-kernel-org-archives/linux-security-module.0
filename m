Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE783A8C2
	for <linux-security-module@vger.kernel.org>; Wed, 31 Jan 2024 23:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706744779; cv=none; b=MBfCiB1TQi4joks1zryoB+AwXBOwMkfuWy3Z+Uoh/dps6RrksWJiVGinHbFOhnzWa2rxu4wnToIcAMeH0EffRxiRzOI+PxKnBxfxEYPRNqR+U7FCqqZ+V3uU9L0658bfdhp6Z5xYUYA/kkG4y6FQT/vTl8zJTr9F6xi0u2bOpMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706744779; c=relaxed/simple;
	bh=hTDaYZJrU10SSTugPzsW6XZg1W6hwvEaLg7CFxa9ytM=;
	h=Date:Message-ID:From:To:Cc:Subject; b=Bc4SF0LiTniC3mvjo6pZOyNW/LYCMVlssX5yxH9mjUAEKMNGr9oDFb3TFJCpSKVq0pkcWAmyS3Vg2YZ4LogE04V6YkOlVFbStWI0VC4w8QFz5GdGBnU7WUdK4Q4srjHHlnaFftr06ImHjt28P8z1xLdxt2ZKMD1w3J/5TbJvSm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TJ/o3Tgv; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TJ/o3Tgv"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-46b165745deso185593137.0
        for <linux-security-module@vger.kernel.org>; Wed, 31 Jan 2024 15:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1706744776; x=1707349576; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjS2NBBVk3rrsqe7JY+MoxAFjS7cR/H8vNXo8eECAdI=;
        b=TJ/o3TgvNLw+wSxoJlLQ9T9k7AZw+yKSgUI65EJpCrUgzM0wWYf5S+8mUdMoWpQ7FN
         YyO0TT/PtuXzbGxDSrOLdpFfcn/tmD3vfeMVFmMVfhht4Tq8DpgjH3XRftA+dJSC4okL
         6PLWwCwrX451RGedKziE3anPFAyoqEqV3msIOo/JpUiuM/bsyEXM0BbPM7vXFTRW7J48
         +BQhsB5qXCqWcO7pJv/+2f5c4yO+uoUpOdayO6qZ5YVviYL7ydcbapQ6VXOQeAoQDpJi
         IHJRAkyqjNF79KR7KP5inwl1TOO5VP3hWq7IMtEp1/z2MJtczx+0xNN0XnEzbz+U0T9F
         8CQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706744776; x=1707349576;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wjS2NBBVk3rrsqe7JY+MoxAFjS7cR/H8vNXo8eECAdI=;
        b=B8gvupbVT+XWtPOffNWVXVBdfXl1afl5IFJWJuRDmkfkSUCT85AmpQATCDQsm2tEJ+
         4nE4PsqPZSKuiElK8H82HNOYVyjVmZ0i5cq2o7B1fHNehf564FDAy0xcDPD9o44WTB5R
         BtnaL8+SkgNNDbqBdAkv4RZ69UnNkbOX06Zu36m4NW9YC+RZlCgkcXYJqb1i3bgofyGO
         JeMw88km7lBcNYg6VN4+D6U6XCPKT1x1/D0zxYZ9ojmkyK5csFXwz5U+tjeAZA8v8f/A
         GtQFhr6VGA5CEPIbJWaFSbWgZXG20mhdRgVC4M3aJsxTTeIQ/VLioIOg3+Ai83Kmf8lB
         JDfg==
X-Gm-Message-State: AOJu0YyatdB+xWcfpGEdrF8qASV8qDAxNBlcDY8GdNzFop461aarnthm
	qXh/Km5/dQ1SW7F3orknpT6maK0XrS5oYKnmRBaJauu0xOoygGcByc876mpJlA==
X-Google-Smtp-Source: AGHT+IGL8wTif13k+ed9Fv3XbFrArv/wu1eXBE9mOS/Gx3ijLXNOBKQFQxPkb0FLFyDGzaheN//xDw==
X-Received: by 2002:a67:f316:0:b0:46c:a3fc:e899 with SMTP id p22-20020a67f316000000b0046ca3fce899mr2879922vsf.26.1706744776340;
        Wed, 31 Jan 2024 15:46:16 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVhaFwtu9H5XhEll3EcwxPmJW2p+Yal/8RNJ863SUTIl1qflt+90wQRNbgKUrV4XGilm576/M2kWHyuHjfecd6xn2b7NKBVD5EAEbj0
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id na2-20020a0562142d4200b0068c717f758asm698418qvb.11.2024.01.31.15.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 15:46:15 -0800 (PST)
Date: Wed, 31 Jan 2024 18:46:15 -0500
Message-ID: <8b9583bc21af9323bf40a53b7f62c5c9@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] lsm/lsm-pr-20240131
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Hi Linus,

Two small patches to fix some problems relating to LSM hook return values
and how the individual LSMs interact.  I expect you'll probably see
another pull request similar to this in the next week (two?), to address
some remaining issues, but these two patches were ready and I wanted to
get them into your tree sooner rather than later.  Please merge.

Thanks,
-Paul

--
The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
    tags/lsm-pr-20240131

for you to fetch changes up to 5a287d3d2b9de2b3e747132c615599907ba5c3c1:

  lsm: fix default return value of the socket_getpeersec_*() hooks
    (2024-01-30 17:01:54 -0500)

----------------------------------------------------------------
lsm/stable-6.8 PR 20240131

----------------------------------------------------------------
Ondrej Mosnacek (2):
      lsm: fix the logic in security_inode_getsecctx()
      lsm: fix default return value of the socket_getpeersec_*() hooks

 include/linux/lsm_hook_defs.h |  4 ++--
 security/security.c           | 45 +++++++++++++++++++++++++++++++++-----
 2 files changed, 42 insertions(+), 7 deletions(-)

--
paul-moore.com
