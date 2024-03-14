Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEA67440C
	for <linux-security-module@vger.kernel.org>; Thu, 14 Mar 2024 20:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710448269; cv=none; b=ImNQEWK0VBgc0ghsOGKPCaS5C5nt+D9gEK2FydHx7ziSLU35sNEydh9RgKX1WyS9LeASqLsYu6WcaL9UttCcWjRNYpsQm6xe7ZTOnpUVK15qiEDi9Ffh8P+iDQC/AESE3B+g5xsN4eIiebczUJOlfLrhe7ensCbMiKLEiNqrFtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710448269; c=relaxed/simple;
	bh=X3BPVZ/DcbXSd1Z85mVrD8Y1cBbSZCOTowwFiOB4ceo=;
	h=Date:Message-ID:From:To:Cc:Subject; b=ROq/z7zDv1hN5q/kKzuUtr+Y6+siNa4g3EA56FDXZLW/tVNZxvfIht2tMhaeIDR3AZMWYHTN/7RK9THN1ZTm+WxGFwzaGtUfcJe2olmnkHa4FFEwucep+sB7ZQiHJI82q6x7L47EPxjQVgVlSAL4WAHixP2Mf6526pRkcgJk2iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ILAytvyh; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ILAytvyh"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-789d0c90cadso86602085a.3
        for <linux-security-module@vger.kernel.org>; Thu, 14 Mar 2024 13:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1710448267; x=1711053067; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jOVFHO8NoQqbd9uiDZWB2S1iwARLFd/3K1hhx95Fs68=;
        b=ILAytvyhqin3VyXbxc2FKVdVT6zhUT61Mq5skbXw35JB/e6T5or1p0JwG92Xp4hpep
         WwgzWsrVRnnV6KF/WmQF1XNQWCPvrGELlGOhSMFNsYU+xVqCg01CWy7icO5ADUgn8Szl
         Yk/I8XAHwterYpta2zFi40ckvg0GuDC3l8ctoVbegkedTOSFb2eYKiANNuSeiUAHYPl9
         B8XlGnfqYVvYBuBeOV8pEPYhpIuxaN6zo0MO2QRHuUgAzm38BHmTJ0CQmGtibQ5mOi+2
         6Mc8T/qgbakVedd9bX9pQABecANUp0O6kYB3qphxo5NrF6n2otmVmaXWlF2yTsnMICdC
         nFZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710448267; x=1711053067;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jOVFHO8NoQqbd9uiDZWB2S1iwARLFd/3K1hhx95Fs68=;
        b=PoiCHrVM8PcS7hgGXGBQmAqB1E6Vg8rohdSnahPJbHtkDeTSM0minnjhViRcZKfY9j
         Y4S3SsSFsRqzXFs2Zp0YocZv5uNy/8/XE2QYav1AYDb61f3iDHAXxLT3t3k/jjh/OixU
         vdeoirJ2lTdrXpy2rDZfOTp6vkjdpcP+bjOVpfnQ1uf54KlLd6rzpCgrTYr8WTdIjc3n
         BzZJ3i3YVfX28i6oey0SglUFuWxcinfrIlrF/2VweG81qVt82SN9Lkjf7uD8t5YXK6Hw
         wjB0BZbLni4VqnzHarea5LWtMkB9EXMl0UrcKZvTB5ouNFO1/6KXkWjPK1UUxjVlQV02
         Fcqw==
X-Gm-Message-State: AOJu0YwJM5TqM03OfkBV3+8TVldl3ojjd3Cvnvy4juwGbKiKPza1/c/V
	vZ8Q3Aj4f814650QUeeENgUT2kN7s9gSHFKWAS+RWimR3UtGXXe2dQ6SXmOb4TRPhD6YtKnEDo0
	=
X-Google-Smtp-Source: AGHT+IFpk+JjB+WJhifnI6YhAG9tS1Qqmwl12LpjCzVm0DLTPYg/X31LGejpX1MN/St0Kud0rJfyyw==
X-Received: by 2002:a05:620a:124e:b0:789:c840:8295 with SMTP id a14-20020a05620a124e00b00789c8408295mr2958374qkl.18.1710448266675;
        Thu, 14 Mar 2024 13:31:06 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id u21-20020ae9c015000000b00788272dbcb3sm1228763qkk.33.2024.03.14.13.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 13:31:06 -0700 (PDT)
Date: Thu, 14 Mar 2024 16:31:05 -0400
Message-ID: <3f2a695a148db9e1daae8c07d9ce5c85@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] lsm/lsm-pr-20240314
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Hi Linus,

Two patches to address issues with the LSM syscalls that we shipped in
Linux v6.8.  The first patch might be a bit controversial, but the
second is a rather straightforward fix; more on both below.

The first fix from Casey addresses a problem that should have been
caught during the ~16 month (?) review cycle, but sadly was not.  The
good news is that Dmitry caught it very quickly once Linux v6.8 was
released.  The core issue is the use of size_t parameters to pass
buffer sizes back and forth in the syscall; while we could have solved
this with a compat syscall definition, given the newness of the syscalls
I wanted to attempt to just redefine the size_t parameters as u32 types
and avoid the work associated with a set of compat syscalls.  However,
this is technically a change in the syscall's signature/API so I can
understand if you're opposed to this, even if the syscalls are less
than a week old.

The second fix is a rather trivial fix to allow userspace to call into
the lsm_get_self_attr() syscall with a NULL buffer to quickly determine
a minimum required size for the buffer.  We do have kselftests for this
very case, I'm not sure why I didn't notice the failure; I'm going to
guess stupidity, tired eyes, I dunno.  My apologies we didn't catch
this earlier.

I would like if you could merge these patches, I believe fixing the
syscall signature problem now poses very little risk and will help us
avoid the management overhead of compat syscall variants in the future.
However, I'll understand if you're opposed, just let me know and I'll
get you a compat version of this pull request as soon as we can get
something written/tested/verfified.

Thanks,
-Paul

--
The following changes since commit b0546776ad3f332e215cebc0b063ba4351971cca:

  Merge tag 'printk-for-6.9' of
    git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux
    (2024-03-12 20:54:50 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
    tags/lsm-pr-20240314

for you to fetch changes up to eaf0e7a3d2711018789e9fdb89191d19aa139c47:

  lsm: handle the NULL buffer case in lsm_fill_user_ctx()
    (2024-03-14 11:31:26 -0400)

----------------------------------------------------------------
lsm/stable-6.9 PR 20240314

----------------------------------------------------------------
Casey Schaufler (1):
      lsm: use 32-bit compatible data types in LSM syscalls

Paul Moore (1):
      lsm: handle the NULL buffer case in lsm_fill_user_ctx()

 include/linux/lsm_hook_defs.h                        |  4 ++--
 include/linux/security.h                             |  8 ++++----
 include/linux/syscalls.h                             |  6 +++---
 security/apparmor/lsm.c                              |  4 ++--
 security/lsm_syscalls.c                              | 10 +++++-----
 security/security.c                                  | 20 +++++++++++-----
 security/selinux/hooks.c                             |  4 ++--
 security/smack/smack_lsm.c                           |  4 ++--
 tools/testing/selftests/lsm/common.h                 |  6 +++---
 tools/testing/selftests/lsm/lsm_get_self_attr_test.c | 10 +++++-----
 tools/testing/selftests/lsm/lsm_list_modules_test.c  |  8 ++++----
 tools/testing/selftests/lsm/lsm_set_self_attr_test.c |  6 +++---
 12 files changed, 48 insertions(+), 42 deletions(-)

--
paul-moore.com
