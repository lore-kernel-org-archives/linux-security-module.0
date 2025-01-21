Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31551F1515
	for <linux-security-module@vger.kernel.org>; Tue, 21 Jan 2025 23:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737502814; cv=none; b=jFpBqT5xLpBsgTh/baSNO2NtnqEDyKnUCz8WqvEKADOwIihiWRy1q4Cqp/V8LGxZCljOTOy1Pw4L/F5ju7S5+DUeQmNehOOWE7Wvf/Jj69mWnvDHkJeKcDT1qujg4oMUSbrwfjT7l/fpL99/l96VOHCkJrkWayAfznAxXy+051Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737502814; c=relaxed/simple;
	bh=pSwiYPlSqiDS39bXiWnOD9G7tmr+fbiAayyRrTmzXWA=;
	h=Date:Message-ID:From:To:Cc:Subject; b=dbNoVPliuGmxnP2bjFm6hMdLkcgUYt+7SMsBOeP2Kz60wAEfIn+HJezC0REbeBrgbRrqSdAq/pZLnVYT9t8bJ/aCCCTxhwEL5KRb0MnUHsPCzkCzupw7BfUOru7uOT+G4AuBdwqFc+acTuU9bPKd+eEgAS39a0uxcjqDfT8aST4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=UhsS6yA5; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UhsS6yA5"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7bcf32a6582so555772785a.1
        for <linux-security-module@vger.kernel.org>; Tue, 21 Jan 2025 15:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1737502811; x=1738107611; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZGKKV34zlfzM4tj8xlLWpq4U1VmTQkFTMB8ii94f/9g=;
        b=UhsS6yA50ColarU7JI2KN8hloO1FtXVg9cy2/rA/DOmDiERWbxnznG/O0cCRRXMIaj
         5ZMOKtWbGqqKz72/9wTBD3h6x1WGO1oMEUFbOMTvJW6E5yfFKWLeV9Id4xtGGp4y1uxP
         3NTe6AWTYo22XowvvRMh7DsjOMsSYyOpKjKP7T//fNLfSsW9mJK4+9rAsL34jO2Eu99w
         6RBwRMMYK8NHgD8XO0OmGlYbNxbbjD6411rxLymJyGww+iC+w9MiTKFQ+78CEcfee55R
         fNVmITX8D2cPhjYGC14fS/BaS4VC/p6XjTA4XwNchLSA9caXdAmjrKm1Lc+23jBclGdP
         Qzsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737502811; x=1738107611;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZGKKV34zlfzM4tj8xlLWpq4U1VmTQkFTMB8ii94f/9g=;
        b=tsJdutZxpoy8Y64FH5EqNOBBZgU9i0UY5RjbAvEjpux2/kS8JGo1lsto3wwijC8Q7C
         X6W9atRRM6x8xa9Gq2KKYE5gOpldxf2xsZbSBFYm2lRMFUkYeck8hDQQLQpaMmDHq9AE
         stXthe34BsaPKShfYMkfywPtVxCtBFDV47tkmOJ4+qD5aGWLPwExBrSLMMj3mjgvHmeU
         ik6dI08lm70J0hhDQjWCsbw0ORkMjYDLx7dvgCMsG8mG7KUvb4ecZsyGvpa+xknnNwf6
         TGkJqO16Uy/MNXvD6WL9iPMKFfmMvOH+Ywc49YNuIFu9mCVoxz3NxOPwHGeBoWEpUVVP
         zrJg==
X-Gm-Message-State: AOJu0Yzw66im333xVLGL8NZS3MgD1VjXwvXIYBi6lCVb6Nj53EFMUviG
	ucbJnpDGixuleyTerPS/hbi8s2on24GNdU55bU5lMSJlxWbAFbmnukywiQBJrA==
X-Gm-Gg: ASbGnct1aU2VvK0M0bGzNIml9lTzrQyVA4/MGqWw1QjaK5jYNF6Y5OVnW+z6xJ07DI3
	h8GfmM8N0UX15w0Vcc1mhEdxJxBVIsrSVqtDQypZLdgwzfKeqoY2BLZJJjftcMk3QLt+1VCrpXy
	6Ulr9eynMI35rcivO3HCA/Oo7j69P4d9T0fMX3msKHxKFOoKfocgwmkSJXgJ2CkhxQnM/hVZ7l3
	d7VI0XBmCrulP03sGOE2ELBNZZcNjJ0E4bMoGUspaV0UYAT+dZwB7yx5/A2OHI5
X-Google-Smtp-Source: AGHT+IFJLsePXH34LfvxbtHxCNvBgBr6oLI3+mxWJhHJgBIBGsLCQ6yYdKKnMk1LxIfB2VYBheRUrw==
X-Received: by 2002:a05:620a:4396:b0:7b1:48ff:6b56 with SMTP id af79cd13be357-7be6327979emr3166709485a.43.1737502811433;
        Tue, 21 Jan 2025 15:40:11 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7be614d98dbsm608942685a.74.2025.01.21.15.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 15:40:10 -0800 (PST)
Date: Tue, 21 Jan 2025 18:40:10 -0500
Message-ID: <da749e8ed1a18e2b14d9337a78749b15@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] lsm/lsm-pr-20250121
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Linus,

Fifteen LSM framework patches for the v6.14 merge window, a summary is
below:

- Improved handling of LSM "secctx" strings through lsm_context struct

  The LSM secctx string interface is from an older time when only one
  LSM was supported, migrate over to the lsm_context struct to better
  support the different LSMs we now have and make it easier to support
  new LSMs in the future.
  
  These changes explain the Rust, VFS, and networking changes in the
  diffstat.

- Only build lsm_audit.c if CONFIG_SECURITY and CONFIG_AUDIT are enabled

  Small tweak to be a bit smarter about when we build the LSM's common
  audit helpers.

- Check for absurdly large policies from userspace in SafeSetID

  SafeSetID policies rules are fairly small, basically just "UID:UID",
  it easy to impose a limit of KMALLOC_MAX_SIZE on policy writes which
  helps quiet a number of syzbot related issues.  While work is being
  done to address the syzbot issues through other mechanisms, this is
  a trivial and relatively safe fix that we can do now.

- Various minor improvements and cleanups

  A collection of improvements to the kernel selftests, constification
  of some function parameters, removing redundant assignments, and local
  variable renames to improve readability.

Paul

--
The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
    tags/lsm-pr-20250121

for you to fetch changes up to 714d87c90a766e6917f7d69f618b864d350f09d3:

  lockdown: initialize local array before use to quiet static analysis
    (2025-01-05 12:48:43 -0500)

----------------------------------------------------------------
lsm/stable-6.14 PR 20250121
----------------------------------------------------------------

Alice Ryhl (1):
      rust: replace lsm context+len with lsm_context

Amit Vadhavana (1):
      selftests: refactor the lsm `flags_overset_lsm_set_self_attr` test

Casey Schaufler (7):
      lsm: ensure the correct LSM context releaser
      lsm: replace context+len with lsm_context
      lsm: use lsm_context in security_inode_getsecctx
      lsm: lsm_context in security_dentry_init_security
      lsm: secctx provider check on release
      binder: initialize lsm_context structure
      net: corrections for security_secid_to_secctx returns

Christian Göttsche (2):
      lsm: constify function parameters
      lsm: rename variable to avoid shadowing

Colin Ian King (1):
      security: remove redundant assignment to return variable

Leo Stone (1):
      safesetid: check size of policy writes

Mickaël Salaün (1):
      lsm: Only build lsm_audit.c if CONFIG_SECURITY and CONFIG_AUDIT
         are set

Tanya Agarwal (1):
      lockdown: initialize local array before use to quiet static
         analysis

 drivers/android/binder.c                             |   25 +---
 fs/ceph/super.h                                      |    3 
 fs/ceph/xattr.c                                      |   12 -
 fs/fuse/dir.c                                        |   35 ++---
 fs/nfs/nfs4proc.c                                    |   22 ++-
 fs/nfsd/nfs4xdr.c                                    |   22 +--
 include/linux/lsm_audit.h                            |   14 ++
 include/linux/lsm_hook_defs.h                        |   13 --
 include/linux/security.h                             |   37 +++---
 include/net/scm.h                                    |   12 -
 kernel/audit.c                                       |   33 ++---
 kernel/auditsc.c                                     |   27 +---
 net/ipv4/ip_sockglue.c                               |   12 -
 net/netfilter/nf_conntrack_netlink.c                 |   20 +--
 net/netfilter/nf_conntrack_standalone.c              |   11 -
 net/netfilter/nfnetlink_queue.c                      |   26 ++--
 net/netlabel/netlabel_unlabeled.c                    |   44 ++-----
 net/netlabel/netlabel_user.c                         |   10 -
 rust/helpers/security.c                              |    8 -
 rust/kernel/security.rs                              |   38 ++----
 security/Kconfig                                     |    5 
 security/Makefile                                    |    2 
 security/apparmor/include/secid.h                    |    7 -
 security/apparmor/secid.c                            |   34 +++--
 security/lockdown/lockdown.c                         |    2 
 security/lsm_audit.c                                 |    8 -
 security/safesetid/securityfs.c                      |    3 
 security/security.c                                  |   67 ++++-------
 security/selinux/hooks.c                             |   49 +++++---
 security/smack/smack_lsm.c                           |   52 ++++----
 tools/testing/selftests/lsm/lsm_set_self_attr_test.c |    7 -
 31 files changed, 351 insertions(+), 309 deletions(-)

--
paul-moore.com
