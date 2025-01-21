Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26E71EF0BC
	for <linux-security-module@vger.kernel.org>; Tue, 21 Jan 2025 23:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737502829; cv=none; b=HOvrdBqZw5t7CInxbnJe8ibQMwYRG8Udnt1ejEbaB5jwfsFObQEaLc8oF3Y1nBwOrnDwE/et8aXxMVn480iv3h/hedM+oIfzcpo4bShJSfDNnQIzlO4e3Ynf5Z5zMV+GVBi9e2siBBrH8uxTRoSJHkphJl6KxqlXhZdHZCxVhtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737502829; c=relaxed/simple;
	bh=r03QFes6IFOxhf/HJnwsOFl/NvyFoqtNJu4O16zG7P0=;
	h=Date:Message-ID:From:To:Cc:Subject; b=WZa2D2jiQs0ppvSJu2WzV5tLlBdDHjlWG5uRncOu60+rDADgVreEdSImbkNS2EqwS/UP9s409L/kz73l3VXPlTZDbmalOC7mm8nz3CllaF3aoUEn/GhgXjrTofSGF1yCkm8VmFLqCTZdgveP0NS0Okc/GDtqD5M3N/+1VZI6OWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HnikFCLy; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HnikFCLy"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-467a6ecaa54so56663461cf.0
        for <linux-security-module@vger.kernel.org>; Tue, 21 Jan 2025 15:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1737502825; x=1738107625; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JE0i6kb20DWpBSDBOpkyqoxMa6iQVxxTGWSIt0YyYu0=;
        b=HnikFCLykEeCsRwf47ZJTKm4SIIypC4ndjPjuMfVoeqO3/LUuaB3V8v8YiMzMe6+ln
         xhf48l+brL4oiE8LpCviUpxb2Hl2V7D3KxmYrT+pLdcGkQML+D4KL3sXG/bvF29wIiT0
         xs6ZHdqRWaSFhOE3byjl+AE79ggqMIWde4gzppyLTX0gW81JVUq+49SGaoXIEpL6Do2N
         HcAhGBl3kxTaXYf1SG2crek43YuOlEdEidTR7DgPF2nRsyCXiecAUjzRtqVOvI4CtDfb
         VvlcTHld1skSX0BgoZTFbeQCJbYYD8Tys6zTKA3PhtieiFy3zoxPrQO7qi1noMo1oiw2
         RNAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737502825; x=1738107625;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JE0i6kb20DWpBSDBOpkyqoxMa6iQVxxTGWSIt0YyYu0=;
        b=Y+Tm79iRWnvByx9hk2xM3iQWXnZgArjQiI4NN/mxra+2v7oVPNzW1ZBYkAmSmP9beM
         EBbQydxX++nZ23j9WX6LOSRlIAhMeXQlz7luMX925SyVM4nybxRXfd1cJztr3HpBfBDC
         BjSQF5DrsLT1uG/QGXRqm2Ap3hequXFweazz/0n80qrkMGN3DLOQd7YQeDytkDSPnWm+
         ejzOK2kYRdvjzjkqtVxrUkwkXqdGohajxMyIYexgndhDUKHCD1DO32Q+rAALVVFvaxEk
         EPcJpsZ/hZXOK3hOmDHrskETvntGr9FaTqyNpyNFgzbOqVaWjBJGKoQUpcYz2jmkAMV5
         b17w==
X-Forwarded-Encrypted: i=1; AJvYcCWUyHE26hAG9I7brkdg+iiGj15Rw3GVH/7RloPIx7vbFqbXf7lFglc3pzXVQmig6hFg/81Ph7p2PR6z3AVtbr1hKVuTUd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhSVJhnxvBSLYyH85i/aT9OftLXVaPQPMqGWk1wfjXDJu19nza
	hwdK+xJ/iEiCHW3GytvU0hmD79z1csBe11JiN5jeL1Y1Ob8UvcxManD9fOm0+rVQvzHpyr4M8LI
	=
X-Gm-Gg: ASbGnctZeA1/oRNIre8D/rGxpiWUHRHHe8T3J16W8ia0bpk5shU9xNDh99OmayS48jd
	J81mCt8fSYEpYSlS3BUl5gHfTf0uoCjBs44vM4KLQsTiMpe4P03jy7MWH3aoZyyKghSDdOSloC+
	FjX+oqhh+sYXRb9mK9REskHelU/GDvPlYAUG4+Vh5lZoiax1Y/PxsWFW/ptujBCMGBQjT7278OG
	4ohDSLNSleFSGCtTMNr37B9EinP3lxAlNyhAYjfCje3K6NAcMvsrMh0ZP2LGQrb
X-Google-Smtp-Source: AGHT+IG6/cDRy0NriMPIYCFbswoi8z+2V8sAu37Y+BrObvorJ6UJsoJR5PDz+/pbpj9GiVbLrTbp3g==
X-Received: by 2002:ac8:57c2:0:b0:46c:77eb:42d4 with SMTP id d75a77b69052e-46e12a96f28mr278054841cf.22.1737502825607;
        Tue, 21 Jan 2025 15:40:25 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-46e1030dffesm59301681cf.41.2025.01.21.15.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 15:40:25 -0800 (PST)
Date: Tue, 21 Jan 2025 18:40:24 -0500
Message-ID: <d6c372031669fb475858e5f296fc8222@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] selinux/selinux-pr-20250121
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Linus,

A lucky 13 SELinux patches for the v6.14 merge window, the summary is
below:

- Extended permissions supported in conditional policy

  The SELinux extended permissions, aka "xperms", allow security admins
  to target individuals ioctls, and recently netlink messages, with
  their SELinux policy.  Adding support for conditional policies allows
  admins to toggle the granular xperms using SELinux booleans, helping
  pave the way for greater use of xperms in general purpose SELinux
  policies.  This change bumps the maximum SELinux policy version to 34.

- Fix a SCTP/SELinux error return code inconsistency

  Depending on the loaded SELinux policy, specifically it's EXTSOCKCLASS
  support, the bind(2) LSM/SELinux hook could return different error
  codes due to the SELinux code checking the socket's SELinux object
  class (which can vary depending on EXTSOCKCLASS) and not the socket's
  sk_protocol field.  We fix this by doing the obvious, and looking at
  the sock->sk_protocol field instead of the object class.

- Makefile fixes to properly cleanup av_permissions.h

  Add av_permissions.h to "targets" so that it is properly cleaned up
  using the kbuild infrastructure.

- A number of smaller improvements by Christian Göttsche

  A variety of straightforward changes to reduce code duplication,
  reduce pointer lookups, migrate void pointers to defined types,
  simplify code, constify function parameters, and correct
  iterator types.

--
The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
    tags/selinux-pr-20250121

for you to fetch changes up to 01c2253a0fbdccb58cd79d4ff9ab39964bfb4474:

  selinux: make more use of str_read() when loading the policy
    (2025-01-07 23:14:40 -0500)

----------------------------------------------------------------
selinux/stable-6.14 PR 20250121
----------------------------------------------------------------

Christian Göttsche (10):
      selinux: use native iterator types
      selinux: add support for xperms in conditional policies
      selinux: supply missing field initializers
      selinux: avoid using types indicating user space interaction
      selinux: constify and reconcile function parameter names
      selinux: rework match_ipv6_addrmask()
      selinux: rename comparison functions for clarity
      selinux: use known type instead of void pointer
      selinux: avoid unnecessary indirection in struct level_datum
      selinux: make more use of str_read() when loading the policy

Mikhail Ivanov (1):
      selinux: Fix SCTP error inconsistency in selinux_socket_bind()

Thiébaud Weksteen (1):
      selinux: add netlink nlmsg_type audit message

Thomas Weißschuh (1):
      selinux: add generated av_permissions.h to targets

 include/linux/lsm_audit.h              |    2 
 security/lsm_audit.c                   |    3 
 security/selinux/Makefile              |    7 -
 security/selinux/hooks.c               |   10 -
 security/selinux/include/classmap.h    |    2 
 security/selinux/include/conditional.h |    2 
 security/selinux/include/security.h    |    7 -
 security/selinux/selinuxfs.c           |    4 
 security/selinux/ss/avtab.c            |   19 ++-
 security/selinux/ss/avtab.h            |   13 +-
 security/selinux/ss/conditional.c      |   24 +---
 security/selinux/ss/conditional.h      |    6 -
 security/selinux/ss/context.c          |    2 
 security/selinux/ss/context.h          |   14 +-
 security/selinux/ss/ebitmap.c          |   12 +-
 security/selinux/ss/ebitmap.h          |    7 -
 security/selinux/ss/mls.c              |    6 -
 security/selinux/ss/mls_types.h        |    2 
 security/selinux/ss/policydb.c         |  135 +++++++++++--------------
 security/selinux/ss/policydb.h         |   22 ++--
 security/selinux/ss/services.c         |   30 ++---
 security/selinux/ss/sidtab.c           |    6 -
 22 files changed, 170 insertions(+), 165 deletions(-)

--
paul-moore.com
