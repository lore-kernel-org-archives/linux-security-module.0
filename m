Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F573911A8
	for <linux-security-module@vger.kernel.org>; Thu,  3 Sep 2026 20:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788467739; cv=none; b=QBOOuOgbMcQsnyO709DvUp94r962lBs19HdIwkKi83C0fD1+T0Lv59zkVxLBWrzSz+Dd4h3dFX+RAFM0Cjghp6phgRLcI+kAo49o4+b3zCMiULhleVgRMJR8GvXIYJY/09mbjRv1zkL+oeQbYhWGR7DD6TAGZ3vLhc5uZv84K+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788467739; c=relaxed/simple;
	bh=9uWd0iWTHtgoOPQrB8sodf7NrxSHcMYqSafeXFsJ/Mg=;
	h=Date:Message-ID:From:To:Cc:Subject; b=JERn0SfC988V49NRG5DFV90K2SRIWN8s3jMd2IWXqCfymGSl67mMHF6wdKx3zOMZ7uzATtJUjPo5EkaJoED9eqG0Mj20yxvZPAUjmEkzm8kj9zQ+bsG90aojFuthkHWgk9v+jM7Fy24qctooZOv54FEPh2ZSVTh7bMY2uVkrM1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RHQF0cjB; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RHQF0cjB"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-90e9ad1a373so16283906d6.0
        for <linux-security-module@vger.kernel.org>; Thu, 03 Sep 2026 13:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1788467729; x=1789072529; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BgZOKPlak6pP0U7KmyWbsU79GCeGbr4ZhDTeyjd+peY=;
        b=RHQF0cjBtrfmsK62fMliV4TZPzmAVUhmbKA1iOju8Cp7W+ECT152FENTL6yKbQ5Mqm
         ANOJnsaEn5ihqrsFfDdNDbKzsYNDuFn+5/hIp+SPxMZfCauOmvxtq956CQrD3mdqh7qy
         4R+3GTIjFpQnnS9kIcJTq+iizD4IK6riW/LV3wIVeGFh3OlzYnTBwF4Q9GdOd7eat2V5
         3dCUmlN2GfrLvUF9daY+yA6eiTK4E4jXj+0NkdWakob9xHz5H62012NbKdRxIDdILSiN
         pHay5oBoC5/0lNC3uihAVkmnenH3KUZ9FP85bg3TPmBXlpyRhfFW9NedQNhYW9krIYHd
         GgDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788467729; x=1789072529;
        h=subject:cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BgZOKPlak6pP0U7KmyWbsU79GCeGbr4ZhDTeyjd+peY=;
        b=eKPXAkX+NLVoMIw9DDsoMAcBBy+dXtVIw1B+g2drKo+/44PuHZdIOIVl7ilyCYIOH9
         bThqN/zH4bCYbqstpJ1+I3t0n1f/xKKu+kfGKc6h7thEImNcIEyK41IZCtxUsQv0C3bw
         xbzh7ZfzcbmlnzLkL5LO6H8YfavMFYgG05bR26ousmXEXyLKHI2yMWOvzLMiQZAhQ0a3
         jBprFeqHAr3R+OJyCLompFAOx95cLvn7GRdFNwDTWMhW/bjVkx9UCRekYtHSpW0v+jZM
         iAEa/mLkFi62LvVWaegJWWqmZb7EvVOAnvfvIvrMad4GqNxrsTM+KoSUi94y3kWoiD7D
         Db8g==
X-Forwarded-Encrypted: i=1; AKwUvBz1tV5SRz5QGMnNsLP3C1Bb/b+/lmdlcalxSbcQnCBLkwHWkeTb9rT9RR+qqh4rpf/+Whd718exDMRjJvr4Kl3lbnQUSgY=@vger.kernel.org
X-Gm-Message-State: AFuF++kj+sq2jEi0cx2zPB9+QDF5mVS3ck6XxzTrziOdOY9m01oRo372
	ANKD7kkCrEGYvawq5R6Dk+70W6mQbAqL/GHnw5VKyg74/bsHyEHzMmtSDkH34hjRi0h/fO1CgtM
	bj0ozDg==
X-Gm-Gg: AYBFou0sym9KmX7t1sdRUHhq+Gm8Hbi2QWySGQuskwwHIKqYH39hvzYUKR7IuOpOfjR
	cc295E54fV+GqUW9LpCxpN4f8FCU2zKyMU+K8D/OO0NLTXUZThcjM1ighuAk4fBdjSL216cuZks
	U1osTAhSImHgN3mig89gvuKSNsFJxyGZspW2pmD0JxBfXzQy0G+8M/yRgY/s/fmwns59D6u6lOf
	L8WxspDi+/8Z1DIqZ/XmSRDivWsSGg3MkwNiZslLDRRB/93vcXW+UsOVPgiooxKyDlBJPSbZ3y7
	d3VTOEPgO7J7g0nwz0QY16vKcQraRqzZUk5F8+Tu++f92drJ/9tGvJPvWjle1tYBOMl49mteHeC
	1WcE8QClaAko61S2IrUyV13spbp+n1nUFoTql5La7jMjGbIePsAgi2YZpuB8cSdpkUrPyKDmx4F
	7k4d7KD8lntceiDh5s7ioH50jyfCcl7USASs+HrFn8T/8R32MzgXnDPGPVOdgT2kGkeSYok/MZ+
	J+txYlYmXMDhDOSE7baVxopfaroGFrGhDARDjClsYrjoS/JMGOeQ/ux
X-Received: by 2002:a05:620a:2856:b0:939:cda:46ac with SMTP id af79cd13be357-93981737ffamr29121885a.17.1788467728670;
        Thu, 03 Sep 2026 13:35:28 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9397fb70fbdsm50115485a.32.2026.09.03.13.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 13:35:27 -0700 (PDT)
Date: Thu, 03 Sep 2026 16:35:27 -0400
Message-ID: <8c72adc9e5a9d3ce854fab61ec5f66df@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] selinux/selinux-pr-20260903
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Linus,

Two SELinux fixes for the next Linux v7.3-rcX release: one to fix how we
lookup a BPF token's creator label to prevent a possible TOCTOU, and one
to update Ondrej's email address.

Paul

--
The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
    tags/selinux-pr-20260903

for you to fetch changes up to 4299767d772d4e498998e32157e45841178ab192:

  MAINTAINERS, mailmap: update email address for Ondrej Mosnáček
    (2026-09-03 16:24:05 -0400)

----------------------------------------------------------------
selinux/stable-7.3 PR 20260903
----------------------------------------------------------------

Ondrej Mosnáček (1):
      MAINTAINERS, mailmap: update email address for Ondrej Mosnáček

Paul Moore (1):
      selinux: fix BPF token permission checks

 .mailmap                 |    1 +
 MAINTAINERS              |    2 +-
 security/selinux/hooks.c |   36 ++++++++++--------------------------
 3 files changed, 12 insertions(+), 27 deletions(-)

--
paul-moore.com
