Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170CC21CF9A
	for <linux-security-module@vger.kernel.org>; Tue, 12 Nov 2024 23:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731452538; cv=none; b=iAeAOeBiDIRIIli5d5K48//9fMl95NumpvJvFgrrLVbq7JHNfFmXSeB+oQyxEyBImeeX8HJr37nznGYvUJf/XL/iUdwmCK697ep/SAbOeYEIGlS00jqzw7qlm67o/UHMuJev4DOWtEnuN37j0jLBt9+LfTnZQU3+TS5jMrl/UEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731452538; c=relaxed/simple;
	bh=+/h/OVIt1xMoc+y3f5DsdExA+tfWxuS4CcvyCfSCZyk=;
	h=Date:Message-ID:From:To:Cc:Subject; b=TWhzLsgFXZ8D1UEc0BHXHdBqR93veC5ABIU5MizzfSauBimix/GbAKOa2Nzgr5+SR1V2k5BvvLh8xuqsxtfCQu9c9CC40fQ9FgFqkd0Z8IKaI8T5qkfbvJ5UWmbwK1J+qjyFnAxgLAl00T7RRWuoC03E8j26k5IQag6Zvcj3kUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FjulBd/e; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FjulBd/e"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b1467af9dbso420869585a.0
        for <linux-security-module@vger.kernel.org>; Tue, 12 Nov 2024 15:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1731452536; x=1732057336; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WUshJXvcMUR3pZ9oCVittkBd+qFJCly4hVcX+M04OM=;
        b=FjulBd/e/iUdQxvtWNmVy3oYDDIa7XxN9BavvfaUO/kJKADSL+/HU3yfw6s4u3+6+y
         7GcPeDDtrS/K54hIK7+XOi5/za40P3tRHZpNIdiwO0fkfRjLwtJ6RFyfeX7waIRFz/25
         qAXVG9pzstwSPS+EcFiflW96q0/UD/SvgcZGIAeOkDeUVzLcL2iX5QV3/k+BPCmM1Dqu
         oO+2m2ZfU1GZBrwiKBhG4hZMFeEAaBbknJdYR5vkRlq8x/rULE9Dj6L1jBmTxZhz/tdv
         hQm3UJbaJtGSyhO1a+qZwzmhlwU5guYVNP+kw/caD92M3sSmSEC9Hm+XlqTe5N86Xnvk
         XH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731452536; x=1732057336;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/WUshJXvcMUR3pZ9oCVittkBd+qFJCly4hVcX+M04OM=;
        b=fjE1Oe9bwKuIA7PCv3ae/a/JVCSWPfF9Hlq1e00AUEnNdI3iM1gPpeVhEVKHPC550g
         P28Cs1JCBFbusixOMeZdejuPNh3CYnMAr+eDEkgAj8zwEH/DTELoXz4VGy/bWzlM5Il6
         P1lszkEoqpn8FLlCTYl5Ad67C5+f2EBA1wvuTRcpP0gbt5WVM0sJgnixa3J3CiZ9sz8b
         Rarg5YdjH0hl9+Wcw0GFPY2RCnhy09r9PFbms/zOLOLuqHSflUAGO0iieBjgSeNGieo3
         PfCVuz7HeS7cMEU7S8Rr3xRlECob8MtnYopxjt9v8PJO50WTTB78iKt53s9E/gLYL7mk
         ARlQ==
X-Gm-Message-State: AOJu0YzA+ACe067HNwYZMtmR2AjKN4NA7PoBZjNHOJQMCIVzsHYut9Wc
	twNbXJm43rlHf4HG/4zipGzfErLK0YflDCUDtboXjhiXzwK8vgYaXmn11fM1iw==
X-Google-Smtp-Source: AGHT+IGmWV3BewoUGuZMjs2WfRC7N+PQJpHK1EgVdEb9hnOhW8uzO6oU4NQKg/X+r21KgPFHAYvNmg==
X-Received: by 2002:a05:620a:4502:b0:7ac:c348:6a52 with SMTP id af79cd13be357-7b34bb56079mr527666085a.34.1731452535892;
        Tue, 12 Nov 2024 15:02:15 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32acb2bc1sm636804985a.91.2024.11.12.15.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 15:02:15 -0800 (PST)
Date: Tue, 12 Nov 2024 18:02:14 -0500
Message-ID: <90954b9699f3d9f2a185f0b97ec2119a@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] lsm/lsm-pr-20241112
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Linus,

I'm expecting to have spotty network access later this week and early
into next so I'm sending my v6.13 merge window pull requests a bit
earlier than normal.  While the LSM pull request is composed of thirteen
patches, they all focused on moving away from the current "secid" LSM
identifier to a richer "lsm_prop" structure.  This move will help reduce
the translation that is necessary in many LSMs, offering better
performance, and make it easier to support different LSMs in the future.

-Paul

--
The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
    tags/lsm-pr-20241112

for you to fetch changes up to 8afd8c8faa24249e48f5007aee46209299377588:

  lsm: remove lsm_prop scaffolding (2024-10-11 14:34:16 -0400)

----------------------------------------------------------------
lsm/stable-6.13 PR 20241112
----------------------------------------------------------------

Casey Schaufler (13):
      lsm: add the lsm_prop data structure
      lsm: use lsm_prop in security_audit_rule_match
      lsm: add lsmprop_to_secctx hook
      audit: maintain an lsm_prop in audit_context
      lsm: use lsm_prop in security_ipc_getsecid
      audit: update shutdown LSM data
      lsm: use lsm_prop in security_current_getsecid
      lsm: use lsm_prop in security_inode_getsecid
      audit: use an lsm_prop in audit_names
      lsm: create new security_cred_getlsmprop LSM hook
      audit: change context data from secid to lsm_prop
      netlabel,smack: use lsm_prop for audit data
      lsm: remove lsm_prop scaffolding

 MAINTAINERS                           |    1 
 include/linux/lsm/apparmor.h          |   17 ++++
 include/linux/lsm/bpf.h               |   16 ++++
 include/linux/lsm/selinux.h           |   16 ++++
 include/linux/lsm/smack.h             |   17 ++++
 include/linux/lsm_hook_defs.h         |   20 +++--
 include/linux/security.h              |   98 +++++++++++++++++++++-----
 include/net/netlabel.h                |    2 
 kernel/audit.c                        |   21 ++---
 kernel/audit.h                        |    7 +
 kernel/auditfilter.c                  |    9 +-
 kernel/auditsc.c                      |   61 +++++++---------
 net/netlabel/netlabel_unlabeled.c     |    2 
 net/netlabel/netlabel_user.c          |    7 -
 net/netlabel/netlabel_user.h          |    2 
 security/apparmor/audit.c             |    4 -
 security/apparmor/include/audit.h     |    2 
 security/apparmor/include/secid.h     |    2 
 security/apparmor/lsm.c               |   17 ++--
 security/apparmor/secid.c             |   21 +++++
 security/integrity/ima/ima.h          |    8 +-
 security/integrity/ima/ima_api.c      |    6 -
 security/integrity/ima/ima_appraise.c |    6 -
 security/integrity/ima/ima_main.c     |   60 +++++++--------
 security/integrity/ima/ima_policy.c   |   20 ++---
 security/security.c                   |   96 +++++++++++++++++--------
 security/selinux/hooks.c              |   49 ++++++++-----
 security/selinux/include/audit.h      |    5 -
 security/selinux/ss/services.c        |    6 -
 security/smack/smack_lsm.c            |   96 ++++++++++++++++---------
 security/smack/smackfs.c              |    4 -
 31 files changed, 470 insertions(+), 228 deletions(-)

--
paul-moore.com
