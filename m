Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867794A07
	for <linux-security-module@vger.kernel.org>; Fri, 13 Sep 2024 01:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726190998; cv=none; b=jcGxbG/vE2noix1mg3GoEEQtfBr7BdVZLVxuqpx+V1Uq+2pflyRrHy6+lVlZ8eMiw80oYYyrY2/JKxV/ncI2ZI5+M/rh/tkxORAaSP6dIQnj8CKcUJhgW2U6O3hb2NZAxw7nJtWp6bCrsGMjkwuz1KEE8GgJrVBCw6HrPS01vNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726190998; c=relaxed/simple;
	bh=94OVKNo7+/2yX9lYKqNr+7qk9kQow0P186JyrepvVFI=;
	h=Date:Message-ID:From:To:Cc:Subject; b=SHSJSlx7SxfR0bdI/M2cqZWyBb+8Sv1lpJ4/kzXZO30e9RLrSDS8O37UCVwtVrInlgUy52e24ivb8AffVVZ0mQXf8Sh7Cd86YfDk9hffySfiJPtmwInJZQAkl1k3GJ2Qx973tduM5zbswaokWvdFHNAc3uYgjadjFDMhvimhKfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bURSXsvR; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bURSXsvR"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6c34c02ff1cso9703756d6.2
        for <linux-security-module@vger.kernel.org>; Thu, 12 Sep 2024 18:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1726190995; x=1726795795; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKsryRZxeeDHRG/BrSJmrMq93TR8VGtT1uFe4+enWiY=;
        b=bURSXsvRaY3/ZWscos6Jf/CpRPGuGnUdMvpLyVASdTP3cCL+NEN2cvZu4AqNfjuTGz
         qJEIpw1sKWX9OR5+hU7nJMWdXXHm0ggIk0fSSbVllXfP8uJevDedWu/hCVhqcfoWMwPq
         zfiR0dmrrWxpl1blC+fbKDvmqG84V4e7obeOcwnrYODVz3s3OKY3HiP6C0So7MfKvcrr
         hMP1ZNm5wZ5hEriP4e5tGy2JfjEDuHmwusFh9r2aRn9twtehOWdBwyK415LaE/9kLKDb
         B5T5rPJueAA0qBLoFUTGHjfhjs9wF0EwlusT7EY3iuBb2ASSdadfkX9rliC3Emcw/D07
         S2/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726190995; x=1726795795;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yKsryRZxeeDHRG/BrSJmrMq93TR8VGtT1uFe4+enWiY=;
        b=XEDY4w9l2RbNZLUOgPX5AJXX2Jl2pJm/kMbrKDQNsRNPYNwFQC8JxogjNwNrdT0fMu
         uEoO67Q/oXQl3KjAV7bKFQi3Ksi0s1McELc1NrZEpaCnU5Dhl7HD4wdECXNZ6/PEYxQ2
         5shSoNe2RsU67KupCfDKsrINt3kjzwXYyEs+HKwsks8auCHH/tdRspomtqqECVlqD8vW
         qMiPVqKaUOJEgAFBj+8jVbkIYaAO22nte9rbcECLew8smOOujRCguLmIK+xyCGd9JjM5
         wlSPVOnuum4YMhwt0vykmYgxV4vszbOdaSRQDYqXaGZIffPYmEqJUnIrFO5VjKfw2NXR
         C0bw==
X-Gm-Message-State: AOJu0YznhGhvWO+DB5dtM52sKxIcHZIWtF0kPN5gGmnUYwxXIo3/riog
	xTdpEYwlBxFCzXKA95Qh29tuwvZpNl8Sg+tiG1M/DNicqkVdVG+ztQwprnf5Yg==
X-Google-Smtp-Source: AGHT+IF3T7Zq8bcbhwTy6n0E+YB2QeEfjLstJF9RICxYJ5lNg2eFj8SjI4ixrEFSwXtAmv//s1r4rQ==
X-Received: by 2002:a05:6214:469e:b0:6c5:2fc7:a623 with SMTP id 6a1803df08f44-6c573543ccemr70624966d6.11.1726190994996;
        Thu, 12 Sep 2024 18:29:54 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c53433982esm60313976d6.42.2024.09.12.18.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 18:29:54 -0700 (PDT)
Date: Thu, 12 Sep 2024 21:29:54 -0400
Message-ID: <d15ee1ccfb91bda67d248b3ec70f0475@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] lsm/lsm-pr-20240911
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Linus,

We've got a reasonably large pull request for the LSM framework this
time (at least it's large for us), here are the highlights:

* Move the LSM framework to static calls

Based on some of our exchanges over the summer, it sounds like you
are already familiar with the effort to convert the LSM callbacks
from function pointers to static calls.  This pull request includes
that work and transitions the vast majority of the LSM callbacks into
static calls.  Those callbacks which haven't been converted were
left as-is due to the general ugliness of the changes required to
support the static call conversion; we can revisit those callbacks
at a future date.

It is worth mentioning that Tetsuo Handa is opposed to the static call
patches, some even carry his NACK, as they make it more difficult to
dynamically load out-of-tree LSMs, or unsupported LSMs on distro kernels.
Many of us have tried to explain that out-of-tree LSMs are not a
concern for the upstream LSM framework, or the Linux kernel in general,
and that decisions around what LSMs are enabled in distro kernels is
a distro issue, not an upstream issue, but unfortunately Tetsuo
continues to disregard these arguments.

* Add the Integrity Policy Enforcement (IPE) LSM

This pull request adds a new LSM, Integrity Policy Enforcement (IPE).
There is plenty of documentation about IPE in this patches, so I'll
refrain from going into too much detail here, but the basic motivation
behind IPE is to provide a mechanism such that administrators can
restrict execution to only those binaries which come from integrity
protected storage, e.g. a dm-verity protected filesystem.  You will
notice that IPE requires additional LSM hooks in the initramfs,
dm-verity, and fs-verity code, with the associated patches carrying
ACK/review tags from the associated maintainers.  We couldn't find an
obvious maintainer for the initramfs code, but the IPE patchset has
been widely posted over several years.

Both Deven Bowers and Fan Wu have contributed to IPE's development
over the past several years, with Fan Wu agreeing to serve as the IPE
maintainer moving forward.  Once IPE is accepted into your tree, I'll
start working with Fan to ensure he has the necessary accounts, keys,
etc. so that he can start submitting IPE pull requests to you directly
during the next merge window.

* Move the lifecycle management of the LSM blobs to the LSM framework

Management of the LSM blobs (the LSM state buffers attached to various
kernel structs, typically via a void pointer named "security" or similar)
has been mixed, some blobs were allocated/managed by individual LSMs,
others were managed by the LSM framework itself.  Starting with this
pull request we move management of all the LSM blobs, minus the XFRM
blob, into the framework itself, improving consistency across LSMs, and
reducing the amount of duplicated code across LSMs.  Due to some
additional work required to migrate the XFRM blob, it has been left as
a todo item for a later date; from a practical standpoint this omission
should have little impact as only SELinux provides a XFRM LSM
implementation.

* Fix problems with the LSM's handling of F_SETOWN

The LSM hook for the fcntl(F_SETOWN) operation had a couple of problems:
it was racy with itself, and it was disconnected from the associated DAC
related logic in such a way that the LSM state could be updated in cases
where the DAC state would not.  We fix both of these problems by moving
the security_file_set_fowner() hook into the same section of code where
the DAC attributes are updated.  Not only does this resolve the DAC/LSM
synchronization issue, but as that code block is protected by a lock, it
also resolve the race condition.

* Fix potential problems with the security_inode_free() LSM hook 

Due to use of RCU to protect inodes and the placement of the LSM hook
associated with freeing the inode, there is a bit of a challenge when
it comes to managing any LSM state associated with an inode.  The VFS
folks are not open to relocating the LSM hook so we have to get creative
when it comes to releasing an inode's LSM state.  Traditionally we have
used a single LSM callback within the hook that is triggered when the
inode is "marked for death", but not actually released due to RCU.
Unfortunately, this causes problems for LSMs which want to take an
action when the inode's associated LSM state is actually released; this
pull request adds an additional LSM callback, inode_free_security_rcu(),
that is called when the inode's LSM state is released in the RCU free
callback.

* Refactor two LSM hooks to better fit the LSM return value patterns

The vast majority of the LSM hooks follow the "return 0 on success,
negative values on failure" pattern, however, there are a small handful
that have unique return value behaviors which has caused confusion in the
past and makes it difficult for the BPF verifier to properly vet BPF LSM
programs.  This pull request includes patches to convert two of these
"special" LSM hooks to the common 0/-ERRNO pattern.

* Various cleanups and improvements

A handful of patches to remove redundant code, better leverage the
IS_ERR_OR_NULL() helper, add missing "static" markings, and do some minor
style fixups.

-Paul

--
The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
    tags/lsm-pr-20240911

for you to fetch changes up to 19c9d55d72a9040cf9dc8de62633e6217381106b:

  security: Update file_set_fowner documentation
    (2024-09-09 12:30:51 -0400)

----------------------------------------------------------------
lsm/stable-6.12 PR 20240911
----------------------------------------------------------------

Casey Schaufler (6):
      lsm: infrastructure management of the sock security
      lsm: infrastructure management of the key security blob
      lsm: add helper for blob allocations
      lsm: infrastructure management of the dev_tun blob
      lsm: infrastructure management of the infiniband blob
      lsm: infrastructure management of the perf_event security blob

Deven Bowers (13):
      lsm: add IPE lsm
      ipe: add policy parser
      ipe: add evaluation loop
      ipe: add LSM hooks on execution and kernel read
      ipe: add userspace interface
      audit,ipe: add IPE auditing support
      ipe: add permissive toggle
      block,lsm: add LSM blob and new LSM hooks for block devices
      dm-verity: expose root hash digest and signature data to LSMs
      ipe: add support for dm-verity as a trust provider
      scripts: add boot policy generation program
      ipe: kunit test for parser
      documentation: add IPE documentation

Fan Wu (7):
      initramfs,lsm: add a security hook to do_populate_rootfs()
      ipe: introduce 'boot_verified' as a trust provider
      lsm: add new securityfs delete function
      lsm: add security_inode_setintegrity() hook
      fsverity: expose verified fsverity built-in signatures to LSMs
      ipe: enable support for fs-verity as a trust provider
      MAINTAINERS: add IPE entry with Fan Wu as maintainer

Hongbo Li (1):
      lsm: Use IS_ERR_OR_NULL() helper function

KP Singh (4):
      init/main.c: Initialize early LSMs after arch code, static keys
         and calls.
      kernel: Add helper macros for loop unrolling
      lsm: count the LSMs enabled at compile time
      lsm: replace indirect LSM hook calls with static calls

Mickaël Salaün (2):
      fs: Fix file_set_fowner LSM hook inconsistencies
      security: Update file_set_fowner documentation

Paul Moore (2):
      lsm: cleanup lsm_hooks.h
      lsm: add the inode_free_security_rcu() LSM implementation hook

Tetsuo Handa (1):
      lsm: remove LSM_COUNT and LSM_CONFIG_COUNT

Xu Kuohai (2):
      lsm: Refactor return value of LSM hook vm_enough_memory
      lsm: Refactor return value of LSM hook inode_copy_up_xattr

Yang Li (1):
      ipe: Remove duplicated include in ipe.c

Yue Haibing (1):
      lockdown: Make lockdown_lsmid static

 Documentation/admin-guide/LSM/index.rst             |    1 
 Documentation/admin-guide/LSM/ipe.rst               |  790 ++++++++++++
 Documentation/admin-guide/kernel-parameters.txt     |   12 
 Documentation/filesystems/fsverity.rst              |   27 
 Documentation/security/index.rst                    |    1 
 Documentation/security/ipe.rst                      |  446 ++++++
 MAINTAINERS                                         |   10 
 block/bdev.c                                        |    7 
 drivers/md/dm-verity-target.c                       |  118 +
 drivers/md/dm-verity.h                              |    4 
 fs/fcntl.c                                          |   14 
 fs/overlayfs/copy_up.c                              |    6 
 fs/verity/signature.c                               |   18 
 include/linux/args.h                                |    6 
 include/linux/blk_types.h                           |    3 
 include/linux/lsm_count.h                           |  135 ++
 include/linux/lsm_hook_defs.h                       |   20 
 include/linux/lsm_hooks.h                           |  129 +
 include/linux/security.h                            |   55 
 include/linux/unroll.h                              |   36 
 include/uapi/linux/audit.h                          |    3 
 include/uapi/linux/lsm.h                            |    1 
 init/initramfs.c                                    |    3 
 init/main.c                                         |    6 
 scripts/Makefile                                    |    1 
 scripts/ipe/Makefile                                |    2 
 scripts/ipe/polgen/.gitignore                       |    2 
 scripts/ipe/polgen/Makefile                         |    5 
 scripts/ipe/polgen/polgen.c                         |  145 ++
 security/Kconfig                                    |   11 
 security/Makefile                                   |    1 
 security/apparmor/include/net.h                     |    3 
 security/apparmor/lsm.c                             |   17 
 security/apparmor/net.c                             |    2 
 security/commoncap.c                                |   11 
 security/inode.c                                    |   27 
 security/integrity/evm/evm_main.c                   |    2 
 security/integrity/ima/ima.h                        |    2 
 security/integrity/ima/ima_iint.c                   |   20 
 security/integrity/ima/ima_main.c                   |    2 
 security/ipe/.gitignore                             |    2 
 security/ipe/Kconfig                                |   97 +
 security/ipe/Makefile                               |   31 
 security/ipe/audit.c                                |  292 ++++
 security/ipe/audit.h                                |   19 
 security/ipe/digest.c                               |  118 +
 security/ipe/digest.h                               |   26 
 security/ipe/eval.c                                 |  393 +++++
 security/ipe/eval.h                                 |   70 +
 security/ipe/fs.c                                   |  247 +++
 security/ipe/fs.h                                   |   16 
 security/ipe/hooks.c                                |  314 ++++
 security/ipe/hooks.h                                |   52 
 security/ipe/ipe.c                                  |   98 +
 security/ipe/ipe.h                                  |   26 
 security/ipe/policy.c                               |  227 +++
 security/ipe/policy.h                               |   98 +
 security/ipe/policy_fs.c                            |  472 +++++++
 security/ipe/policy_parser.c                        |  559 ++++++++
 security/ipe/policy_parser.h                        |   11 
 security/ipe/policy_tests.c                         |  296 ++++
 security/landlock/fs.c                              |    9 
 security/lockdown/lockdown.c                        |    2 
 security/security.c                                 |  615 ++++++---
 security/selinux/hooks.c                            |  176 --
 security/selinux/include/objsec.h                   |   28 
 security/selinux/netlabel.c                         |   23 
 security/smack/smack.h                              |   12 
 security/smack/smack_lsm.c                          |  107 -
 security/smack/smack_netfilter.c                    |    4 
 tools/testing/selftests/lsm/lsm_list_modules_test.c |    3 
 71 files changed, 6063 insertions(+), 484 deletions(-)

--
paul-moore.com
