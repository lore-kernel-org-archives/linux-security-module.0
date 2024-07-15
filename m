Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA9F131BDF
	for <linux-security-module@vger.kernel.org>; Mon, 15 Jul 2024 19:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721071061; cv=none; b=k4xGrBgJ7rusGx+1Txk8JSnriP33lg4GyvMKfUiStBtBj6hqHG3cChpwNyuRSp5BpVqKzaERVySDDoqyQ/rmgJszjgdPG/VtpJme03Q9XSLQkO/xUpPfkdUJpjIKGOVzbltVeL3xSEu5IBGYAAhx3UGnX8YwXut15kf7I+IfQt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721071061; c=relaxed/simple;
	bh=8FVx2tZPqhojymGX9qIwrEjs4K8cSI4h2T5qI3BJmyc=;
	h=Date:Message-ID:From:To:Cc:Subject; b=VJDwZuQ8OVWRRHVDcKDSPxU+Md/pl/lArRpuIkiLb1CGCacnLwSrxssTpXxUi8fva/tKxA+xtD0BluzZp6mRee8KkP/U9sbveFFARcOUzlfUQoBlkc8FjWZsURfWg9XBo90w5knTvJySTuS3ZoJcuCh++58d9BkqakaZLRkyny8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=SZ3FQV1q; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SZ3FQV1q"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6b5d42758a7so29292996d6.2
        for <linux-security-module@vger.kernel.org>; Mon, 15 Jul 2024 12:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1721071059; x=1721675859; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dKdU6iu+Xt48TBuET3nQ3Tnr7L7phoXtIQAwUj08O3E=;
        b=SZ3FQV1qzv1IOVm8HCRneGftHiujkFp07cTJg0qFsxfb3wJt6UhdrnaIr7it92tCyN
         nUpzLzhD6sykDPesiFH9NGvIZSz4rX4dK96E3M0eeuBvdtt5YRpgGLgM4JwwGO6r8XiH
         r8nb8Ns8CATTEcuqXXQZ9Y7o1P2PqdJmDN71lAfmC4aAkjBDQIi+LFmeBzcUVMaGC1DC
         oLgJnRPELWhdjbCtKzjKcL2NfUpVYCWonoXM2e8ZRI0H8e7X9xOaF1FU7b79LoBDTQlW
         ypty0UxqSPaRSfb7RXYYdJFZgQ1Okih6XVD3uNg7Z3zO5STNqcacnKqb8y+6HiwSL+t5
         UyMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721071059; x=1721675859;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dKdU6iu+Xt48TBuET3nQ3Tnr7L7phoXtIQAwUj08O3E=;
        b=qREinE3FMYKA/m6fMxO/pVHw0pn41DkiUBVQyfJPf1LXUyhBtcYMxyX1TeFqqO477W
         7pIff0RLkwG0xK01/ND9uDjTc0mT6oDEOd9jaxD+LfnbnuC34/dN1kfRoNN3Rar4BKe6
         9cz0PhXVkJe9vYV/ciNN1ygL8p+GuHa9PoFeUyTXdQVvG1/Sln/InZcaEIxDcTML2j2/
         SJ0LpDSsJHyCoO2vGbKAe0vhMpLRbMyfDaolzmZpodhjpWhQsnuOv2z/2H0EPvupJUMB
         Z2i3m43HqIju7f8H49uN9NE/tiUB0Wl4bRsQgTZCDlQ8XAWC97HJ7lpwO/077EEgDna3
         diDg==
X-Gm-Message-State: AOJu0YzCitgrRqF/EPpCR5ywSvBh7uyjZYLl5Q/116euOzmfgtUvLxJh
	ft8CqZ1a8V/0y9q844jkpKWisnSR4rnG/baLrBdhBqaVoQEWdtFQD0cAIohGtw==
X-Google-Smtp-Source: AGHT+IH0dyJ59WnF598Vp8RgP+ecd8Srjjc4KL+3+xkUBmXbsc/IlSnIVvOU7UmyPfeHL2bFjSbwMg==
X-Received: by 2002:a05:6214:2585:b0:6b5:e852:7273 with SMTP id 6a1803df08f44-6b77f525c34mr1413786d6.36.1721071058753;
        Mon, 15 Jul 2024 12:17:38 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b76194f5acsm23914666d6.20.2024.07.15.12.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 12:17:38 -0700 (PDT)
Date: Mon, 15 Jul 2024 15:17:38 -0400
Message-ID: <549ba0887cc2b0d606940b7d788f0367@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] lsm/lsm-pr-20240715
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Linus,

Two LSM patches for Linux v6.11 both focused on cleaning up the inode
xattr capability handling.  There is more detailed information in the
individual commits.  Please merge.

-Paul

--
The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
    tags/lsm-pr-20240715

for you to fetch changes up to dd44477e7fa15ba3b100dfc67bf7cf083f3dccf6:

  selinux,smack: remove the capability checks in the removexattr hooks
    (2024-07-09 15:15:57 -0400)

----------------------------------------------------------------
lsm/stable-6.11 PR 20240715

----------------------------------------------------------------
Paul Moore (2):
      lsm: fixup the inode xattr capability handling
      selinux,smack: remove the capability checks in the removexattr
                     hooks

 include/linux/lsm_hook_defs.h |  1 +
 security/security.c           | 70 ++++++++++++++++++++++++++-----------
 security/selinux/hooks.c      | 38 +++++++++++++----------
 security/smack/smack_lsm.c    | 34 ++++++++++++++++++---
 4 files changed, 101 insertions(+), 42 deletions(-)

--
paul-moore.com
