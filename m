Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF48C3AFB1B
	for <linux-security-module@vger.kernel.org>; Sat, 17 Oct 2026 03:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792206014; cv=none; b=maJywgXPHHsqRF2C0WuSzqsRVKnPdpzOMmJUnxuQb70xwTShzOnawu8l1utqDKD5gJhx5yFn86I+UMyJrcJldZwphYR+6phUDJMwEKnVIjxPUd03tsqDBeRgeaoRpSrXnHfEGe/L7/W4LJDD7eN1uZtbOAHmmZnh5MpUEcztzC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792206014; c=relaxed/simple;
	bh=RnyUtaj56FacvXKJT/5BOE5uL4aLHIIMeKqQgZyyy3w=;
	h=Date:Message-ID:From:To:Cc:Subject; b=lnWccWJnPNyun88RNZpqj3mJrPFi9dWoz/emDKvPUZU23Ytx1c5aigSSPmQFkdH2PpeyO1YcIQ6ZyX6LxUIpkP+eydv8Bu1O6afS4UY6WyLy2MO/0dqu5nEW7JJJ+k4C5BOFHlG8QMCcIsA6GSSnuNKvpvbwpuW3xB3O/KkTmgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=SkyKkWWj; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SkyKkWWj"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-93ece7a73b9so64973985a.3
        for <linux-security-module@vger.kernel.org>; Fri, 16 Oct 2026 20:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1792206006; x=1792810806; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H7TFgfiFf6FEXV3J7Inq1lkdC8JNBzhySk1rzqW+t48=;
        b=SkyKkWWj35bDcts8jT/Vm8ebaAmtwQIQ2aldBjUveWiFsnhPtE2VD0UHBM2h+63BMI
         wHOSrBjN5DZr4EyOYc8VMQCHCVh6mueA0IX4/i0giSK7bBzkRGGMQautk4BBAOOt21Ig
         vLVnT5fVS/TGo9mBBCDKKU1YvI+9gtXlIu6P0/e9MklAsUxTO2VxMtF9f9hV73u9pKwy
         GQaIZa7rkJRP6gHb7/nORUOF/hLYirjJcN81gf/LRtgiCva7zkj8K4RYXuSCv/EinZsi
         kS9sy+YCmmbIM68+/qDwnjh4g8AFfUwZnkv0fujgMWfSt856edmHxDNlOiGuDoWOoNjy
         +LuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792206006; x=1792810806;
        h=subject:cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=H7TFgfiFf6FEXV3J7Inq1lkdC8JNBzhySk1rzqW+t48=;
        b=YCpcS73MXoJE8PC56wE9GJ/fGbf11cwuNGkvfknBIxWv1+42pMEGvwtSvUzUvqu+rl
         URyzwIjMkV56ITE/uq5slshJqBRiof4Haw15rvBK262/nxfP3ojCYn2pdd/4S5zNswHg
         cjgnmcSM4xvVXl14IfaqVpovDTUrA5OYjrmesneXZAz9Oy6RRWluWiwo0SDaw5pviAj5
         mUhN6/XPYee7EwAWljnuopUkS2lsRZgSDilCqHcrdB+FHQWR5TdKpGkDaTGjYi5UnRq8
         ETPRwnWMTZ0Lude1gKRAUhTGeQnWX2fhy+0xZ/sgalZsEaIf78QfBPP+De2zOIK1BZ4X
         72og==
X-Forwarded-Encrypted: i=1; AKwUvBxTFhp4BqmA9hecmul4OrtgXqlhtpFx4M67JzAxFlAzJq0yiNWTq0BkLg7to49QJFvsn0cJqNtPbwgpH7IkWDWKDTj1/Hg=@vger.kernel.org
X-Gm-Message-State: AFq9FYL1TU/ugF5lHdfbZGdbdFgUB/PHnMxgErDWqMzaq0J0w370ihUC
	WCA33moy56rEjEx9fE1+Qibtbgr01hzqyLLeF2Us75NVQpoZMBviDiy/EnCeWczL7A==
X-Gm-Gg: AYBFou2KgzM8gR70ruJAlKR+l8IChWXVotgdb9cjuwzYFDQfzUf9LAECrjZy/7h7Zb5
	HPvDh/jZ+DkLV7FqmwBBLQNuT7rhp3lGhvaHHtpm0Gp/15IQEwbgLn74J+rG5F+hYFeUQb1ipPf
	8iFjCSI9PUgkPNdtoJstN/F98Z2hw6hWb2/+Ib6ALNSsAUVuTVKKTxhRtqDHcJVAnuixcQmRdvR
	Xhj91Nb537uqf2Po3kgL3ueNz/4TxprzXd/oH0pAglosz8UiwRArzNtWWrxKJ6Lx4ARK+SIX8nM
	uHray5Vu3u0MAGBTcNgmpqoiBCRZXuImjTDIj1Kb/TaF8O4QGSoOwhC8bi8KiQIWBMKOMQ+rwta
	XxClDTs9KV8ZLH349fgyC+mYuvtCVFjd5FHxL+mAt1TOPJy0h7bl/fm8oHeJV+2A6wHLAP4J9gg
	987FiUQ3sAh+4wK9IR3bNb6zv25J0PKX41Wb5zDAhq2h2IXdiYjEm8x96LLOFdSDLcl7l6FHPyn
	xBBZHgy5QYsVi3l6x+rGlP0NVLYZOIX62DO3cG4fTAUu6Jfk0VrSbe0JQyoYE0hfAwTwqT4tQ0=
X-Received: by 2002:a05:620a:439b:b0:939:9edf:edb7 with SMTP id af79cd13be357-93f29b73708mr304873385a.6.1792206006258;
        Fri, 16 Oct 2026 20:00:06 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f1a1850cbsm361980985a.24.2026.10.16.20.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 20:00:05 -0700 (PDT)
Date: Fri, 16 Oct 2026 23:00:05 -0400
Message-ID: <e30c2a29706391f16d9ac9446907193c@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] selinux/selinux-pr-20261015
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Linus,

Thirteen SELinux patches for the Linux v7.4 merge window:

- Continue to improve the load time validation of SELinux policies

While SELinux policy loading remains a privileged operation, we continue
the recent trend of hardening the policy parsing and validation code in
the kernel to ensure that invalid, or poorly formatted policies are
rejected at load time.

- Correctly incorporate "neveraudit" into the xperms code

This change aligns the xperms neveraudit handling with the conventional
permission handling code, exiting early from the SELinux auditing
code when neveraudit is enabled for the domain.

- Mark the selinuxfs "status" and "policy" files immutable

These are read-only kernel/userspace interfaces that could successfully
be opened at the VFS layer through the use of CAP_DAC_OVERRIDE.  With
this pull request we are marking these two files as immutable so that
the requests to open these file with write permissions now fail at the
VFS layer.  This also allows us to drop some of our mmap() checks around
write permissions as the VFS will now also handle this for us.

The existing SELinux permissions checks remain untouched.

- Convert the selinuxfs inode numbers to u64

Bring selinuxfs current with other filesystems in using u64 for inode
numbering as opposed to the architecture dependent unsigned long.

- Constify a number of the SELinux AVC function parameters

- Remove a SELinux MLS function that was no longer used

Paul

--
The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
    tags/selinux-pr-20261015

for you to fetch changes up to b73b967b0fc44707f39faa4f298f1f9d9b7bfac5:

  selinux: validate permissive and neveraudit map types at load
    (2026-09-30 16:59:44 -0400)

----------------------------------------------------------------
selinux/stable-7.4 PR 20261015
----------------------------------------------------------------

Christian Göttsche (8):
      selinux: constify avc function parameters
      selinux: reject a policy that both rejects and allows unknown
         classes
      selinux: reject duplicate symbol values during policy load
      selinux: bounds-check filename transition source types at load
      selinux: check neveraudit in avc_xperms_audit_required()
      selinux: bounds-check role and user membership bitmaps at load
      selinux: validate user MLS range and default level at load
      selinux: validate permissive and neveraudit map types at load

Paul Moore (2):
      selinux: convert selinuxfs inode numbers from unsigned long to u64
      selinux: avoid 64-bit division of inode numbers

Stephen Smalley (3):
      selinux: tighten policydb_context_isvalid() checks
      selinux: remove unused mls_setup_user_range()
      selinux: mark status and policy inodes as immutable, drop status
         mmap write checks

 security/selinux/avc.c          |   37 ++++----
 security/selinux/include/avc.h  |    7 -
 security/selinux/selinuxfs.c    |   59 +++++++------
 security/selinux/ss/mls.c       |   38 --------
 security/selinux/ss/mls.h       |    3 
 security/selinux/ss/mls_types.h |    3 
 security/selinux/ss/policydb.c  |  137 ++++++++++++++++++++++++++++----
 7 files changed, 183 insertions(+), 101 deletions(-)

--
paul-moore.com
