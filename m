Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9FC8F5B
	for <linux-security-module@vger.kernel.org>; Fri, 25 Jul 2025 20:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753476546; cv=none; b=CRT9FbOPBCENqbUpoJodvchl4aU0p1atQie+IbGSGzE/fFp50B87x18Ywcpl4NhRwxfZTCjOkF/rOUs6U9po5I3p9aSf0WybH/d2ekymLuPnrMnUXBPnzw8KoHXYIzEeXX30gO5qLCvYm1XZxgLzKPUB0yhRJTxYm4scI1lRqWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753476546; c=relaxed/simple;
	bh=lyxZL2T6toBw8OY84aCqoZTXj6QaFAi3cQGkFOnokFM=;
	h=Date:Message-ID:From:To:Cc:Subject; b=tlZtzviXDEa9bks9VJ7UQ+tKTxGD6EiPd4eSYMWqk+FFvvOtrA6VTizO2bRVKbU2e6vFeHqnHuECu9pY1DhbE5z6+PTabwvUyhsR+NcelvE3KV3ta8Jo+mjl9HjQbFlvU6h0fmGg1iIOoSCZ01ZLrMFkvw5CNOKpJdvIGSR/RIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=UvHIUo2S; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UvHIUo2S"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ab6b3e8386so27638051cf.3
        for <linux-security-module@vger.kernel.org>; Fri, 25 Jul 2025 13:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753476543; x=1754081343; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1M1cP+MULrl+CVh37saJ8iMa6fKqjPBOJaZIE1vokI=;
        b=UvHIUo2S+WISoIRRefsIbvjJbrQKhHj7z0TTzrCsOAecC3dpveDS2Bm/crYQ030btH
         9CGn7dBjNBG0HQh06G1BFfsqKYb+nc43KGK5wi/Q6aB8DpavxKo7h6LNxYuAKDFm4/pk
         J9KJKKlp3Cfi2+tTlcVwBh9RbSXmUTD59gbaXRoGTImEKIVKh67CiJKut8XfOtrxkgWW
         iVPYRi7wib3y+GT/nBtpuPzcoccCejhmtsp5wMV4Z3iumjhAPkhf/HwGh8y2qQBv3wjb
         PbT6hAb8dx6OSW0wrnG9UAOWxEyPXPNkcXD1eZ2yNT3CcKe53EBuS0KLA2R7rLj7y+1O
         2UvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753476543; x=1754081343;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n1M1cP+MULrl+CVh37saJ8iMa6fKqjPBOJaZIE1vokI=;
        b=WfUyWQjUlFr6W+BdvYcvLQ+aemIWnpALkFR9MSP/CKJbkyYb2nVbK5bIs0jADqA/2E
         hxwWlAoi5QNx0Ddr0dG6LchfJMf2olLttZ6nEMkvgGRAMZOetbUSiXCQ03zlAV46CLoz
         DtXh5GrJk6j1QOmVUnL5W/QmBBcbYtedLOeF0lJysaoIhsbiYeDAqu0X906Z3g4klxx4
         bURecMByqoJBX/QrgpJhQO/uwF1HobCvda/CUDcqzN7OMvD5SFaaUD64BEmXzc2wB1A3
         XOm+3K+D6A/+oLoRmmIaC58UsMzUZYJzCl6vQtplX7xem3rlk3xmwFqRCt2He0yqXkm1
         LvqQ==
X-Gm-Message-State: AOJu0Yw2zv5o/FVQvOLkTY+6WX9D6IeYQ36dzfbbe0Xqa+Hyz1Joj+Oi
	VbYWZV12rTN8GMLjPBuFfoblLY87RZo32f/dqpZlZFqXFF0zoHbYInJcPGPVJDdNOwfbl5761vB
	gSzQ=
X-Gm-Gg: ASbGnctfkc8QWnCgiY7dHIZMZgRVraEyq6tsHmTPP792RAzxhLmg+sIqFK57GsnajLl
	14LsypKiRBY72PsukZS/eI32uU7NA8TWDxsHEnnm3xB16Kc52aEpeePX3GBrGk4s/F1z0NeH5GC
	0SFklAUIzPI2B/QqP2GhH/tmf8vqj1u/bWRyLUg3N2a82U2f0bvkFcd299/4WCDHoX4B9siatd4
	xDyGRt8l9YoCAXwm/LnOEYPuivmIREwPDW7HCJiQpcUtAhuAlblAa+Ir6ntNZE8C+iOy/JppssA
	w1OxneXjw4i7lE4CmB9ciEVcPpXhKz5mPmE5/grEeD2eCU2lAfemA8ud/xc4INuhCm88ezvFkSC
	NO5TdFvtp9R6usZMcALC0RvFlVmYM19ywt9hU4lMHqViZco8bBwAEEgiZzlskuUF4ZHA=
X-Google-Smtp-Source: AGHT+IFPs/TGlyud/MH4FHrsKYoh28z2RodeIQw/4AflnPEY0g0M7yhSEjwOWkUQozucxcIuEV+dkg==
X-Received: by 2002:ac8:5a53:0:b0:4ab:62f0:3ba3 with SMTP id d75a77b69052e-4ae8ef33304mr35631521cf.16.1753476543456;
        Fri, 25 Jul 2025 13:49:03 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4ae9969335asm4245661cf.61.2025.07.25.13.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 13:49:03 -0700 (PDT)
Date: Fri, 25 Jul 2025 16:49:02 -0400
Message-ID: <a981f40c12a45fe974beb197fa7b86dc@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] lsm/lsm-pr-20250725
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Linus,

Three fairly small LSM framework patches for the upcoming merge window,
but I wanted to mention that this pull request isn't based on the usual
-rc1 tag, but rather on a VFS merge that happened shortly after -rc2 so
we could pick up an important xattr/LSM fix.

- Add Nicolas Bouchinet and Xiu Jianfeng as Lockdown maintainers

  The Lockdown LSM has been without a dedicated mantainer since its
  original acceptance upstream, and it has suffered as a result.
  Thankfully we have two new volunteers who together I believe have
  the background and desire to help ensure Lockdown is properly
  supported.

- Remove the unused cap_mmap_file() declaration.

  Included in the LSM framework pull request with Serge's ACK.

Paul

--
The following changes since commit fe78e02600f83d81e55f6fc352d82c4f264a2901:

  Merge tag 'vfs-6.16-rc3.fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs
    (2025-06-16 08:18:43 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
    tags/lsm-pr-20250725

for you to fetch changes up to 5d8b97c946777118930e1cfb075cab59a139ca7c:

  MAINTAINERS: Add Xiu and myself as Lockdown maintainers
    (2025-07-10 17:56:09 -0400)

----------------------------------------------------------------
lsm/stable-6.17 PR 20250725
----------------------------------------------------------------

Kalevi Kolttonen (1):
      lsm: trivial comment fix

Nicolas Bouchinet (1):
      MAINTAINERS: Add Xiu and myself as Lockdown maintainers

Yue Haibing (1):
      security: Remove unused declaration cap_mmap_file()

 MAINTAINERS              |    4 +++-
 include/linux/security.h |    2 --
 security/security.c      |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

--
paul-moore.com
