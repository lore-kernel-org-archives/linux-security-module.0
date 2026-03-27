Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B96396B8D
	for <linux-security-module@vger.kernel.org>; Fri, 27 Mar 2026 22:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774649103; cv=none; b=RhpB7cxV9EUrUjTuCN+e8M3lULLlxWwbU2tGCqqPAeNTna3PmRvHq4Po25Pgo6lphYP+8/5DDEvaKsMfRzC2ATPi4XESCy5tT4UEPT5bQXqpd0GxP1dFu28JVEnKb0xoLBsvI8fOxlnJKWda/hSeFcjEbYZOl+og88RnYZlA2cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774649103; c=relaxed/simple;
	bh=Vzh/+jHRIGpmYHe5gU3rnLfig2+dnLv+37f6At4au3g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jZr+aTk13RNuRNMLD3UjdHWWRAZi9fTn/OlyZf7j/n0JttW5XUmcBE54vYcS0wAn6OawrpPkZYbPchd8q+Eb3dvJzkLnIYVRzy2hbn5rGVqu8AGQnLNzkSoLZaee02Ao8Ss67SsDXXTXv4gK29Gs6HW5peqt9TZl/aklZ5uHvT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=IgQPajF6; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="IgQPajF6"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8cd80f56b27so256979085a.1
        for <linux-security-module@vger.kernel.org>; Fri, 27 Mar 2026 15:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1774649101; x=1775253901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3S8EhNAp/M6HE2VsRMXkSr61L034glOOF85HPPP/Kto=;
        b=IgQPajF6Uy4Lc1BNZuXYBleA2pUwwbgrEuOvuCy/0CZabfdMsZ7+5d57l1S3FnwstA
         OTOatZXgxkh/zsiFRc04C8Z1jNXJYmNggXq5qSPGHV97szdfMiHy9H8XbwvhwaamMok0
         hl2q2i3dPAUM+MvhcX0ctzsa+FIQtCkYy2R8LzY/Ndjqt7Q7a9fL8tfYXdlDq8jPKnY1
         3biJwgyJsJEN66x5N3LeNtFT/TA5MhlHBAagM+swABLERuYdPGdO8YnDNkSt++CCbznR
         Nnqwxu+7tjSC2l5wU9Rzv/5RbRl8OnenoesZU+9FprjLc/O5y8tA265dCIfgaeAX0rVK
         xFhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774649101; x=1775253901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3S8EhNAp/M6HE2VsRMXkSr61L034glOOF85HPPP/Kto=;
        b=L0g0PoztUQgW7LhQqoLGg62CShjfviuwnGVK3Svv+hyAIokoeWEtVgJG7G3g12IPNq
         d/Wu3AUGImaTntLOGz1MPFlq9R9i9/pYBQOOqxHlCp1DhrzuhyiTbHSGoswD38D2+uSb
         zjcW5SzbUQwSvHyjAszzV5m7PihNDFkcv3QjdQdkX4061LYJYccIQb4BLlrb1a3SrUZZ
         4+XJ1lfkp71vtgUdZIhadIbYsTVOBoE92DY7nM8yeKKah8Uh9u9RpYxz0FAEktZwPXIP
         vH1YFEIPjjQVqq7BpVSciTFaznUa2QIsuQWHmEDttzc95c7Lq8zEVQPZJG3fc705C69e
         /uAw==
X-Gm-Message-State: AOJu0YyMyzjfdipp06sbeBQO2owiIQfwEhd89qZ8GqBLemTIc+KzdzRw
	+Q86icJbapQOvAxsWTyWDoJD6X3ROzfNz02VcPDutHI5SArCsG8kH/Hx7erRM/EfSp5xk3UUlhH
	9TkU=
X-Gm-Gg: ATEYQzyQ6J0sHCNVUEPtFmuvtO46F8kxg6xFn895kwXamuUGGXrDxtIo1yDwOohRljS
	/+ws5xLMMoMazstVEAr1MMoOgHltvlOsLW0oVPVQIdGzquMEV3VF8cRtf0BhW79El1c1bu3zEel
	7sWC7W7Dnkpirk62Vz9S+fVjI695uCcz8/NcFDXPt4yZV/wqQaTSWls0a+AjHsD8lwkgRh3IXCV
	kYcAYJ+Urvcmr/n8N8cu5BCPFLtG3d4HM+VI9+QUnz/UD+Yqj7JLRIy+Ifo5FTQHBCUGz51Ob4v
	izo6QN9CZz9J+viwrqDRfBDgf/WXP4kKQF+lQP6C7HKzJocNKH1DgLfVIIdQual+N8eR28lI9xA
	mm4HETCVlAcm0zz1Hjsw9PGN37XaYKpQny2Wpvwp7FgK+jfkxb3y30UviCCtzW1UL3mekbG2OZe
	lSTiOb8CmTxYWH4qBntqoIWVHeiMNRjXe2U/MnLUBRH0IGuJwVW3x/8bezf8koL3zvN9+ExLbgE
	d7xWRo=
X-Received: by 2002:a05:620a:2944:b0:8cb:52e0:15e7 with SMTP id af79cd13be357-8d01c621d51mr531573385a.33.1774649100763;
        Fri, 27 Mar 2026 15:05:00 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d027edb8ebsm31425685a.7.2026.03.27.15.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 15:05:00 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-erofs@lists.ozlabs.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Gao Xiang <xiang@kernel.org>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH v3 0/2] Fix incorrect overlayfs mmap() and mprotect() LSM access controls
Date: Fri, 27 Mar 2026 18:04:31 -0400
Message-ID: <20260327220446.353103-4-paul@paul-moore.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A very minor update to the v2 patchset[2] posted earlier this week.  The
changelog is below.  The primary reason for posting such a lightly revised
patchset is to drop the "RFC" qualifier as I've had the opportunity to do
additional testing and I'm reasonably happy with the results.  As always,
anyone reading this is welcome, and encouraged, to do any additional
testing they believe might be helpful.

I plan to merge this into lsm/stable-7.0 either later tonight, or sometime
over the weekend, so the patchset has some time in linux-next.  As we're
fairly close to the v7.1 merge window, I may decide to hold this for Linus
until then; let's see how things turn out with linux-next as well as any
additional review comments.

[2] https://lore.kernel.org/linux-security-module/20260323042510.3331778-4-paul@paul-moore.com/

--
CHANGELOG:
v3:
- fix the LSM hook stubs (kernel robot, Ryan Lee)
- fix the lsm_backing_file_cache allocation size (Ryan Lee)
- minor style, simplicity tweaks to the SELinux patch
v2:
- remove the user O_PATH file patch from Amir
- add the backing_file LSM blob and lifecycle hooks
- update the SELinux code to reflect the other changes
v1:
- initial version

--
Paul Moore (2):
      lsm: add backing_file LSM hooks
      selinux: fix overlayfs mmap() and mprotect() access checks

 fs/backing-file.c                 |   18 +-
 fs/erofs/ishare.c                 |   10 +
 fs/file_table.c                   |   21 ++
 fs/fuse/passthrough.c             |    2 
 fs/internal.h                     |    3 
 fs/overlayfs/dir.c                |    2 
 fs/overlayfs/file.c               |    2 
 include/linux/backing-file.h      |    4 
 include/linux/fs.h                |    1 
 include/linux/lsm_audit.h         |    2 
 include/linux/lsm_hook_defs.h     |    5 
 include/linux/lsm_hooks.h         |    1 
 include/linux/security.h          |   22 ++
 security/lsm.h                    |    1 
 security/lsm_init.c               |    9 +
 security/security.c               |  100 +++++++++++
 security/selinux/hooks.c          |  256 +++++++++++++++++++++---------
 security/selinux/include/objsec.h |   17 +
 18 files changed, 389 insertions(+), 87 deletions(-)

