Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4281B5808
	for <linux-security-module@vger.kernel.org>; Wed, 14 Aug 2024 15:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723649531; cv=none; b=ts21RjZ+6d7ynegv/Zge1gr2UyFkki+9IbXGw16Nh5IQ207jiDsSajpA5lhd1+6/Jv8o/NnndfzRPPBEn1FlYcTsva9fmA1McuSOFuD0Cla5XNSl2qjYa1/y/uQa4KynnVwd1iB3Yd0dgx3AfKOMvjMQKuA4RieyNqt+/6t6fqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723649531; c=relaxed/simple;
	bh=7OooO9TplT+lvfE2JkQoIj1MaDEShOjip54yS30SXQE=;
	h=Date:Message-ID:From:To:Cc:Subject; b=FCNAoEdzmvGbQT5zh2OiRrgH6OUJsShQ4FqF38JmeYxHCFLZFE4s9U3GfgQrS/BUwQjNeA97YIAcgasAhC2EJYbB3YzyqZcb/vXK71q49jS3RuWU3a1QZTn5i9Qkzpvf3qiXxjnpzPFkV3QMwepm6bAKd4ccBqHIjdcsPuEkCe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YMqb83Mn; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YMqb83Mn"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6b795574f9dso37399046d6.0
        for <linux-security-module@vger.kernel.org>; Wed, 14 Aug 2024 08:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1723649529; x=1724254329; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJ9fvRwo+hi0Q64GB7HfIEW9tbB2awWX2voQOxbEeD4=;
        b=YMqb83MnEOE5jmcQHWVB8wgsxz0EYlz+299wNwPPcDct65oB/k5W08vuUQ7HICfnkm
         cSu9UkzXVAIPrIYc0AH8Q+HkoHhec1eihEJz7B3GvVL4EUw+J+I4SywcM7JWnG/xvSaj
         uSlX4Hs24Hi2Ii4/F75+LO+ilMPcCTpzoYghb9c8GeFsBd3z1NhZ5VmVSj2SKj9Gtpsr
         loqCe8DcOE79bAUcHExrZK0VrClZyvmBs+xX4S9n1bk0yWcXX076lAp2eFJ5ppqLCf6b
         2sq4bbhQcg+Qd2WvNjbDiyQ4GmZknGWPxGsHnQFKYe4DIrVuFfMw5dbJs+4BhPqhl0+w
         tchg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723649529; x=1724254329;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LJ9fvRwo+hi0Q64GB7HfIEW9tbB2awWX2voQOxbEeD4=;
        b=bB8DrYYmTnq8lxubPn4S5rH5y3Z4TIvRao56NmCmkaM7IEXdPLPIRcZUy3ef1jUXP7
         6CImOjBMUhuJWqomjMUlh2DxHwu8TWizOmdbEjhihxWi80hucPMh/kmNrL7ytairV99K
         M5l5yRwkrcQOrrCqUSfcYCF4SbcuZ5QI7TEIdqMzllJ/cKgV/yNngSHqeaDOvzlCglCN
         NNbMnZBvVo4ury+VOiWTewYtDG6jZg9CndRcLcPgmf+c4BOQL1c3aRpGZnZWvwS8Dujx
         3ub1hBFDN98hamH4UdQydAajat4fSCjofRwqmrddCD/1LUJ5qZb6rCc/SOEG70HqGhx6
         eItg==
X-Forwarded-Encrypted: i=1; AJvYcCV3LMt+UceE3mm3xe/Jx5ghkPppEelqOjUy8i8+58Pmv4AqRHeXNgNes0iXyr8D7WzdQrDv+G7ob5Kg1GyylnCW6kXSYQUKy0XXW4qZ9ZH2bipAoLbg
X-Gm-Message-State: AOJu0YzWTIxWWhifDVuAsC4JYuB0U5YdDsQNrHoct64zNpR+ZJ6ojxJ8
	1nCkTjKkJzFpikipaH2cbye8X6s8E/PwQ2oTShlwwlDUaxdmQQgTWxvOoqyhTA==
X-Google-Smtp-Source: AGHT+IEr3vsF6kVgdcrOqiLxJ8Htl5sV9F9/r74PtqYHFUz+Cxr42fM4Gg7zoS2U9E9KIDVqOo9kow==
X-Received: by 2002:a05:6214:2b99:b0:6bf:5587:f6cd with SMTP id 6a1803df08f44-6bf5d25999dmr26638996d6.42.1723649528855;
        Wed, 14 Aug 2024 08:32:08 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bd82c5ef2esm44967696d6.8.2024.08.14.08.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 08:32:08 -0700 (PDT)
Date: Wed, 14 Aug 2024 11:32:08 -0400
Message-ID: <30fc5b38165e4eda57d640eca76b7df1@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] selinux/selinux-pr-20240814
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Linus,

Three SELinux fixes for v6.11-rcX:

- Fix a xperms counting problem where we adding to the xperms count
  even if we failed to add the xperm.

- Propogate errors from avc_add_xperms_decision() back to the caller
  so that we can trigger the proper cleanup and error handling.

- Revert our use of vma_is_initial_heap() in favor of our older logic
  as vma_is_initial_heap() doesn't correctly handle the no-heap case
  and it is causing issues with the SELinux process/execheap access
  control.  While the older SELinux logic may not be perfect, it
  restores the expected user visible behavior.  Hopefully we will be
  able to resolve the problem with the vma_is_initial_heap() macro
  with the mm folks, but we need to fix this in the meantime.

-Paul

--
The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
    tags/selinux-pr-20240814

for you to fetch changes up to 05a3d6e9307250a5911d75308e4363466794ab21:

  selinux: revert our use of vma_is_initial_heap()
    (2024-08-08 16:22:47 -0400)

----------------------------------------------------------------
selinux/stable-6.11 PR 20240814

----------------------------------------------------------------
Paul Moore (1):
      selinux: revert our use of vma_is_initial_heap()

Zhen Lei (2):
      selinux: fix potential counting error in
               avc_add_xperms_decision()
      selinux: add the processing of the failure of
               avc_add_xperms_decision()

 security/selinux/avc.c   |  8 ++++++--
 security/selinux/hooks.c | 12 +++++++++++-
 2 files changed, 17 insertions(+), 3 deletions(-)

--
paul-moore.com
