Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C999318EC8
	for <linux-security-module@vger.kernel.org>; Wed,  4 Feb 2026 04:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770178250; cv=none; b=c6cay1lvfWlKiWzT1qIuRXjs6pUqsc+EDiinF/ToU2WJahOuQrEyS8MqpVl6jRAzipyAC6GpvIh3SLrPBp1iQIm7BoX9XS/HjirLJrg2GQGQ0NLBPBvpH//R2h5VpOe/nwxxm5rJ9rPNnCJA9fLMTgNn1VHCO62yqKI58CBNrFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770178250; c=relaxed/simple;
	bh=3d4WK7cXu87rv+0w7aIpFTpvOJY9SVSJLhSDEHH9AL0=;
	h=Date:Message-ID:From:To:Cc:Subject; b=Q+q2KqqF/tdUJRVo9UOOAhrdcajJ/oF2Pbn8YB7bC0qI2r8LMLCAltEETvhGgl9SVHlj+3mrdH5yHr+k+Rb94uIWagxc7Yyv2/647FTh30+UzzN7kA4HjmUps4Ut/cXWs180HGjlM1GA0/Fg0utkh5MDD2yyKlG5RVwTKtdVesc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=a0VOHyCZ; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="a0VOHyCZ"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5014b7de222so66287411cf.0
        for <linux-security-module@vger.kernel.org>; Tue, 03 Feb 2026 20:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1770178246; x=1770783046; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZFRceGxvBzFcH6WGaDcQ3OC3vFEVf3fqeA7vx8wzJo=;
        b=a0VOHyCZXRV306SyyvPLqMAKKC9EmxB4EA0/pLlIg5DcROIVASnpfXLc6gcRUiFMkc
         nOPMrOSLzdo5HT6yGHoGu+BMnns6rCj1zWnTbfSjy0GpAR1KcJVwfS3njd3p0bbHH3Wh
         vdl01GsKDqU+bhDoi7LIWbwDVIIRSnnRgNAQfYixHmC30z3Rnez/a4xkrBTn9KU9L1Ir
         kF6YNY+roH8DstV7fZq7lEB2jBr0Ss4uAgGVEenChh24de9KDfKTn67P6AjnBXZ5ttf5
         iTtbsrhIwmqrZbTGyM2v4jPz43o1qEDe15pWjc0uT7xMRnby6Ctjc1adCiqMdwpKbPcv
         bHBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770178246; x=1770783046;
        h=subject:cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rZFRceGxvBzFcH6WGaDcQ3OC3vFEVf3fqeA7vx8wzJo=;
        b=uYjgVM/FIqsAELHDCnchQOKTanOZGkoHzB5Xrn6NMLoOioeG/nSylwVStFHEiKFl7O
         X1rxQ53JBCiTY1ARY7uGXbsp6tv1Vtia29mYYiYGxIwUXmmKZXgXGPRkfmXkukUPEGtS
         qj9uejslhlaAjte4K7frKJ6TUuKHsFbqCmXk38mu0LS/RH3AB3e/A6ka47oXthDRRQWw
         djn+d46PLrMSyuoPlZcVFKrCIKIzmFKpeN84EOI79qZar5O2OAc69vYhVBUao5ZYCK5b
         6qwqlTbblgBsLt6/KFXx8NN0g8MMRwazWkN45LtRur2AUGl2vGpv+Pgq0uO+ArYmeug4
         RMhQ==
X-Gm-Message-State: AOJu0YzVwQfoQGhsp6Zga/X++3KBAihH++bPrY5mCWb1sZsrD5r0ehFk
	8Xt1diUBHKdeLvqyqny5962NxtoT75TJSzcl9ae3vUy35yBQORNVpPkdZDB1OxW8haD3NysG/HR
	KNG/NPw==
X-Gm-Gg: AZuq6aJMLMqu6HN1AmXrpzwSZXNNoLp/c+s0q9qi3UlPou88UZhB2gQHG6cFFYhMnyP
	sSQxkqslvzVKvmgsx0yA8LBn0hvU/XCVZmFkhTYcAZY4VB6mX9/SfxO8DEHrzbPVvrG25OBlLiQ
	/rOojm7kWiWK8iJ8tIz0c7XuHAj0wHsG5K2fQq5Q2sJ18Z6VcRfF28ehrLCKvfs2pFxWUtaaMhT
	qHXOpj4PldpdzBkKhBJ0/n8pou92pz6jDoS0ezUfh3crsLh0VFUTWvIuwJg5/sGT1PQ4Q9NFcBJ
	yr15m0Lvqh0RKh/GyklGUlNrd3m+ZGlbA55OUuLGtSS4P/Vm9VNA5nZXwdNluu4ysZhkBJQRSf6
	Ljr/juECcumd9GUtq9piihS4gz33R0spoN+MA0VK15HKZMxUmGUdkvZPlU8m+E0eXcDXaEpShyO
	2MSSqJgIKOT4BwKV3MuWvUyYhpkze48Br96fNbfG8N27FMGc9WNQvU6V51
X-Received: by 2002:a05:622a:249:b0:4ee:173e:c73 with SMTP id d75a77b69052e-5061c1927e7mr20845791cf.60.1770178245899;
        Tue, 03 Feb 2026 20:10:45 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5061c15f435sm9381881cf.9.2026.02.03.20.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 20:10:45 -0800 (PST)
Date: Tue, 03 Feb 2026 23:10:44 -0500
Message-ID: <d6f1f788f25b30ddc05703b97146f6ad@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] lsm/lsm-pr-20260203
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Linus,

This is a bit early, but due to some personal scheduling I'd rather send
this to you now, and you always mention you prefer to get pull requests
early (perhaps not this early?) so here is hoping this is a win-win.

Here are the highlights for the LSM changes queued for the Linux v7.0
merge window:

- Unify the security_inode_listsecurity() calls in NFSv4

While looking at security_inode_listsecurity() with an eye towards
improving the interface, we realized that the NFSv4 code was making
multiple calls to the LSM hook that could be consolidated into one.  We
attempted to engage the NFS folks on this multiple times over several
months to get input, ACKs, etc. but never recieved any comments.  While
this commit does touch NFS code exclusively, it is directly related to
the LSM hook, so I've gone and merged the commit into the LSM tree.  It
has been in linux-next for almost a full month without any comments or
complaints from the NFS folks.

- Mark the LSM static branch keys as static

This helps resolve some sparse warnings.

- Add __rust_helper annotations to the LSM and cred wrapper functions.

- Remove the unsused set_security_override_from_ctx() function

- Minor fixes to some of the LSM kdoc comment blocks

Paul

--
The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:

  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
    tags/lsm-pr-20260203

for you to fetch changes up to 472711068fa950642b9b471aaebcc82e9930eb8c:

  lsm: make keys for static branch static (2026-01-06 20:57:55 -0500)

----------------------------------------------------------------
lsm/stable-7.0 PR 20260203
----------------------------------------------------------------

Alice Ryhl (2):
      rust: cred: add __rust_helper to helpers
      rust: security: add __rust_helper to helpers

Ben Dooks (1):
      lsm: make keys for static branch static

Casey Schaufler (1):
      cred: remove unused set_security_override_from_ctx()

Randy Dunlap (1):
      lsm: fix kernel-doc struct member names

Stephen Smalley (1):
      nfs: unify security_inode_listsecurity() calls

 fs/nfs/nfs4proc.c         |   38 +++-----------------------------------
 include/linux/cred.h      |    1 -
 include/linux/lsm_hooks.h |    4 ++--
 kernel/cred.c             |   23 -----------------------
 rust/helpers/cred.c       |    4 ++--
 rust/helpers/security.c   |   26 +++++++++++++++-----------
 security/security.c       |    2 +-
 7 files changed, 23 insertions(+), 75 deletions(-)

--
paul-moore.com
