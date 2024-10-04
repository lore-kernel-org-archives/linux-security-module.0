Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA74D1CACC0
	for <linux-security-module@vger.kernel.org>; Fri,  4 Oct 2024 17:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728061466; cv=none; b=lPf8Mog8h/l2Q9PMsg8zJl2QMzolYVC1dR4tgrPO5iC23s1KI6spJSuJcaOjA2DhbEVv3v2nJWgRqYc5whBugVaix34eCfOw3cpFjFxHlTdLxASH41ygbOjaHuzprA71F993jptAtWuf6sdhPhkz5dIq3LwFwiJyw23/oqmJciI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728061466; c=relaxed/simple;
	bh=/bPZOo5ftCUQCx1+u79k3npMjvV++5WUJXtH24xcfs8=;
	h=Date:Message-ID:From:To:Cc:Subject; b=aZbSuFfLh4i6raBGUuANAXdrbrp40O6cpLW896Y5WJiugXdtH7KGyhMHG1utq5ZfVrcEOLpuWasChojzvkGNmn7kIGCrmYZsP4NyYLR/Vdrvu4w9UFxCh9ABsm+LXTB4feoCzz2Jc+QChfxLyP78+IAAHtHxifQla6vFq2Pwx4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=avpm4ird; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="avpm4ird"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7acd7d9dbefso202531985a.3
        for <linux-security-module@vger.kernel.org>; Fri, 04 Oct 2024 10:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1728061462; x=1728666262; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBY4ItyzwqG9KiWzbNSgXF5ZKCYULObRiMPoCiH0Wpo=;
        b=avpm4irdkOz5wpUtrzm+jdmieMeRdxjbIWKzI1NI72dsvDdNa6kwDELJg6ty9fZdGP
         W31CtkS84ubYiKpoO/Y343m/2itDgU6lCb9V9UdB98O1KWp/gHedcGDcCLvgKa0TYmO/
         3etuR9hU9v14ARCMsGiwmFpVN+Q4qoys/2H1OVMmZnrDpXXAH1eAIxOSv1nKGxyiLGIT
         6+W4xQTKuZtvXKS2u/brB5pK0oX3LKexVu1IIdba5Mddfv15AmO0Qj2+vSxFH6Jnr7/4
         Q9lZZfhCot3iq9POBqGKp1lshZO4YcOrU03O+2S+A/hmYX+eL/We6+8zJbem33tneNdY
         u/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728061462; x=1728666262;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pBY4ItyzwqG9KiWzbNSgXF5ZKCYULObRiMPoCiH0Wpo=;
        b=KcKMnLSCFcLnmdg/oMB7ghFqbE2bW5eHRyJyCE7x9e1Gfda+4CrJspKdQ46vbU9Rx3
         uyob4mRRBj3PQ+tYPNmA4nbg99lXSJ4Ga1GK7Ieeiiev7v2CAApJMz3LJly92Z/A94in
         UPpzngLCjluHC0xkpIZIDZivXoU6oiQYJMqrW5rwY2YsyEGawTsRphbAc5XMz2j4td7/
         HYksugB7FOGMDXsXWORhxcojB06nh9v/vorVQg0nz5guounh8wRNRyAuRNToASfkUC/o
         YHcaWov02lrfjgRNCWYhKNlAUtTQ4CV9qPAPySh0a2PYDBoLQtgWRCgQTkeADkBS7tmd
         5rmQ==
X-Gm-Message-State: AOJu0Yw4MBthZjOdTi57kZK8YQy8B7avnw/lXPBu7kcIfRsX1n/cX47p
	16SGAJdgKEiCdXyMUlNwrO7T0UQHqmbOw07U+dgvZfW5uwSkATpEMn/Do/OAYUfCoKzhL1o6sZI
	=
X-Google-Smtp-Source: AGHT+IFD9IuPnccoZlSjhYqXrJlLB28tnWkEcno497ozIMsWIdkkP77e/SSc29k/nA3kcuxjgMtoHQ==
X-Received: by 2002:a05:6214:5d0a:b0:6c5:a40c:52ee with SMTP id 6a1803df08f44-6cb9a49d087mr56730856d6.45.1728061462567;
        Fri, 04 Oct 2024 10:04:22 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cba46cad70sm914646d6.28.2024.10.04.10.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 10:04:22 -0700 (PDT)
Date: Fri, 04 Oct 2024 13:04:21 -0400
Message-ID: <a68d32deab61b1c4b1be66e5346ef547@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] lsm/lsm-pr-20241004
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Linus,

Here is the CONFIG_SECURITY_TOMOYO_LKM revert that we've been discussing
this week.  With near unanimous agreement that the original TOMOYO
patches were not the right way to solve the distro problem Tetsuo is
trying the solve, reverting is our best option at this time.

Please merge for v6.12-rc2.

-Paul

--
The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
    tags/lsm-pr-20241004

for you to fetch changes up to c5e3cdbf2afedef77b64229fd0aed693abf0a0c4:

  tomoyo: revert CONFIG_SECURITY_TOMOYO_LKM support
    (2024-10-04 11:41:22 -0400)

----------------------------------------------------------------
lsm/stable-6.12 PR 20241004
----------------------------------------------------------------

Paul Moore (1):
      tomoyo: revert CONFIG_SECURITY_TOMOYO_LKM support

 security/tomoyo/Kconfig         |   15 -
 security/tomoyo/Makefile        |    8 
 security/tomoyo/common.c        |   14 -
 security/tomoyo/common.h        |   72 ------
 security/tomoyo/gc.c            |    3 
 security/tomoyo/init.c          |  366 --------------------------------
 security/tomoyo/load_policy.c   |   12 -
 security/tomoyo/proxy.c         |   82 -------
 security/tomoyo/securityfs_if.c |   10 
 security/tomoyo/tomoyo.c        |  110 +++++++++
 security/tomoyo/util.c          |    3 
 11 files changed, 118 insertions(+), 577 deletions(-)

--
paul-moore.com
