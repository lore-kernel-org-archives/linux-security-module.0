Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B043876CD
	for <linux-security-module@vger.kernel.org>; Fri, 10 Apr 2026 23:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775863570; cv=none; b=FnU51lWJPjhkDhyJGpCzhiNgZbGsig1d2840RCMj1KjyvKdxzc+pzqQHmszjwp7WpB9QDfLU+sYF2IcinquXISlGKM4hT8EzS8t5PWbNxPyvE6BDrJOZ0SGZVT7FfB4J5uN2aH7KyKL1qfNlSI2QYWoHe4MhtGJcG/uzV0aYgmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775863570; c=relaxed/simple;
	bh=Nuzl7SzUb36RGtsiAcR1c9Ieru1jN8wMpzXLxPBpSoc=;
	h=Date:Message-ID:From:To:Cc:Subject; b=Di/ETQkHreFMd8KHgGB4scdWQZ6h2aRXH8TqTYmiH/QjL67Quq0engcRo+4f6jPTCPz7Jdfx+iUwp25WD3Eyaf4x2A5KjIhL70sMg0pvCI/NHRPtseSlJXH2/MFSjXIM8XWz5YJJEewYwORQRTadh6ktc1XHWRqua1rnQB0iekc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=gnoiI6AO; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="gnoiI6AO"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8d1b746f522so284411385a.0
        for <linux-security-module@vger.kernel.org>; Fri, 10 Apr 2026 16:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1775863567; x=1776468367; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHb6SI3b6dJgkA4ClKJYO+UN8/fHAXhAk0b1FfPTMyk=;
        b=gnoiI6AO6GUrIBABYHpZIbuAZvOto39W8JSyUVfp5SDDwf1VI4p4rulCpkrSEPWrex
         CghemwFXk1U2roNTywMN8G9YtEJqVtsGSSGK7dHsrSDXFlzs0bYm9LlvcVX1H87G6yBg
         OP7AKhnNsZ9xY6krmee1OBihC48EFkPVBGTmT7G7CALXdU6qUZPvCDoVnoDvQN0D0YS9
         TcALgPwWmagV86J06gPFdxvWH56Daw6aro5j3Owz6vR/m2hr1EiXgpcLtmnKXkjSy8Mr
         O67cG8PscBRJ42DLE/IQ/m2uHKeHlW7QwXulfbfb96bENYrpAejW1fOVf2MIKngzjrjt
         19QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775863567; x=1776468367;
        h=subject:cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hHb6SI3b6dJgkA4ClKJYO+UN8/fHAXhAk0b1FfPTMyk=;
        b=V5BJJE/XQIdqCmpdMhzFoQvqxF0+UKY+Nw2Q8stfJwTBrtbc37jCONAywoWQ4Ce4Q6
         umZD7syl+y+Cl1yIYgo71P6wbMSEyR8e0xivZA+pKpRl0UAUOqlQynb3m+EJRhw8+El9
         nyWFILPAZXTOfGVorip5J5dydOEx1sNDQZZxox7F10EmFT78P4Vsf8Z8Ff2y7W2t4o0D
         9PWlaacXDeJOgvtlh3gRYrAP9X9YcyMAluU9Chd1PZqTEloKf5OUhG+ybfVzGzdfkkQO
         JpsSP9SLezXrSpoY2GSny0r655q5BoZAIRDuHd8axqq18Vgrb/2YE0cerWJ4CzO3yqMU
         6nIQ==
X-Gm-Message-State: AOJu0YySBKKkWBlpLavTWBGRiuwDhGqVdwp5LjqLXTqAMf/rIVjxoIzW
	0RYmBzS8K/dik46SQ/EHCf81OXIBGHU5b0H1J3+4QYUcyZOUoKdTRtz0/r5lk4yWnKENHPVmb9s
	Xdu8=
X-Gm-Gg: AeBDiesR0zBaq5dlSl5QPD7g5jVwMTI+i5ndL+nkFlXC2ybLfTkNA35ja4Uajg4ytEl
	cSKwjRffvE2W+AroYEQetBnhTVPVGODeeKW67NV6euEc8EXh6rqo3SF8akqg55scbe1ZmClQOGj
	y0u/cktqASARtO5lm31dDdpnof+h8N6+C9vSHXHyAZNiBbwF2KsIEql07ydL12QQDpPS8SkRt2E
	bIfCi+IROyE7KtfJ4wcdqHIwR4vfAX4gMgLyxBrZEQ9rx9DQpNnB7ImTG95fTqa/nIEEMcXwtmn
	Y9Xd5tT/XuXAcD4qC7GfZX+/EKc1s+p70F2tfLQeO9srAR8ts/f6zJbxiOKLFpFgJfp+IwhPxMf
	d18z7UuKvlveJPFF4Ty55Dz3vBxgBaEGqcNxHuzHkGlcEGesHNMnavIJBC/K0sHl/KvblGsgrVx
	8zIa5Kj81qd8gNp1356wYDB80HuYVf1airmpnd9Q6iZGyi9dUugkymqcxQpt5lhMKsBqDy
X-Received: by 2002:a05:620a:17a7:b0:8cf:d565:fcb1 with SMTP id af79cd13be357-8ddcd21931fmr737017285a.5.1775863567058;
        Fri, 10 Apr 2026 16:26:07 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ddb5f88c82sm313385285a.2.2026.04.10.16.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 16:26:06 -0700 (PDT)
Date: Fri, 10 Apr 2026 19:26:05 -0400
Message-ID: <9a2a59bd8d9548fb5dab128f4859fa3d@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] lsm/lsm-pr-20260410
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Linus,

We only have five patches in the LSM tree, but three of the five are for
an important bugfix relating to overlayfs and the mmap() and mprotect()
access controls for LSMs.  Highlights below:

- Fix problems with the mmap() and mprotect() LSM hooks on overlayfs

As we are dealing with problems both in mmap() and mprotect() there are
essentially two components to this fix, spread across three patches with
all marked for stable.

The simplest portion of the fix is the creation of a new LSM hook,
security_mmap_backing_file(), that is used to enforce LSM mmap() access
controls on backing files in the stacked/overlayfs case.  The existing
security_mmap_file() does not have visibility past the user file.  You
can see from the associated SELinux hook callback the code is fairly
straightforward.

The mprotect() fix is a bit more complicated as there is no way in the
mprotect() code path to inspect both the user and backing files, and
bolting on a second file reference to vm_area_struct wasn't really an
option.  The solution taken here adds a LSM security blob and associated
hooks to the backing_file struct that LSMs can use to capture and store
relevant information from the user file.  While the necessary SELinux
information is relatively small, a single u32, I expect other LSMs to
require more than that, and a dedicated backing_file LSM blob provides
a storage mechanism without negatively impacting other filesystems.

I want to note that other LSMs beyond SELinux have been involved in the
discussion of the fixes presented here and they are working on their own
related changes using these new hooks, but due to other issues those
patches will be coming at a later date.

- Use kstrdup_const()/kfree_const() for securityfs symlink targets

- Resolve a handful of kernel-doc warnings in cred.h

Paul

--
The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f:

  Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
    tags/lsm-pr-20260410

for you to fetch changes up to 82544d36b1729153c8aeb179e84750f0c085d3b1:

  selinux: fix overlayfs mmap() and mprotect() access checks
    (2026-04-03 16:53:50 -0400)

----------------------------------------------------------------
lsm/stable-7.1 PR 20260410
----------------------------------------------------------------

Amir Goldstein (1):
      fs: prepare for adding LSM blob to backing_file

Dmitry Antipov (1):
      securityfs: use kstrdup_const() to manage symlink targets

Paul Moore (2):
      lsm: add backing_file LSM hooks
      selinux: fix overlayfs mmap() and mprotect() access checks

Randy Dunlap (1):
      cred: fix kernel-doc warnings in cred.h

 fs/backing-file.c                 |   18 +-
 fs/erofs/ishare.c                 |   10 +
 fs/file_table.c                   |   43 ++++-
 fs/fuse/passthrough.c             |    2 
 fs/internal.h                     |    3 
 fs/overlayfs/dir.c                |    2 
 fs/overlayfs/file.c               |    2 
 include/linux/backing-file.h      |    4 
 include/linux/cred.h              |   10 -
 include/linux/fs.h                |   13 +
 include/linux/lsm_audit.h         |    2 
 include/linux/lsm_hook_defs.h     |    5 
 include/linux/lsm_hooks.h         |    1 
 include/linux/security.h          |   22 ++
 security/inode.c                  |   10 -
 security/lsm.h                    |    1 
 security/lsm_init.c               |    9 +
 security/security.c               |  102 +++++++++++
 security/selinux/hooks.c          |  256 +++++++++++++++++++++---------
 security/selinux/include/objsec.h |   11 +
 20 files changed, 431 insertions(+), 95 deletions(-)

--
paul-moore.com
