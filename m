Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFD018FC80
	for <linux-security-module@vger.kernel.org>; Tue,  2 Dec 2025 02:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764640839; cv=none; b=STA9xOMHlS+f7jDSmqrsIPkSv9OfCUHFz+EcY/hQpdSUrpBkTkIP5fsS3HYXE94JP20t/x1Sl1d2qBN+PgZNP6MAyU9XTzO8vI1R+DJUioUA1qGM/gUONmYVJsAue5LDw9Ch7FoIyyxzyiAyW+ri+zGjjJmge8YkCyDE6OFxx1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764640839; c=relaxed/simple;
	bh=z/2hAvYVxV8Lmc5YIg6fUPKBQU7ZGIaOXgJ5nZsk0TU=;
	h=Date:Message-ID:From:To:Cc:Subject; b=PsFE/TIi4xAMeqv5PIp0/gRj/AQDdu+4/BzGLaGsf98fyFbJMcgCzHQxz8FE8jyBNDe3tSxb4rmIeH9HVeNQ7m01kFd6lQzeb/oIMQGJz/Gb0cye3R5ajaYW2CfxGSLtzZYGXx/LAXgvY176WRLOgvLvI+GCZyMDNxfEtQG7fko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NA1+mxCH; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NA1+mxCH"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-88054872394so65149856d6.1
        for <linux-security-module@vger.kernel.org>; Mon, 01 Dec 2025 18:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1764640836; x=1765245636; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGss0LZUPEHUx/FnKLRHgHJPUXCJCdwTCbaOcsxbeS0=;
        b=NA1+mxCH11c4kSMKa+bb1QQnN+KUiRBTSS7sD6Ao4T33LPZxnkZkPY83/iwmqVYtGi
         dd5SNW+3vDK9D8x/RtPfAnM2LPemGikBd4LwYPVct8IE4qPhH68LZbtJcoBbEO6j9WQD
         TYyOjIoeczr4GyA1+8218Ixs86r6NyUosOxlFulegi2ONUJ/N5bF+N5rD3acPfX2GidR
         y7BJsIKarnzRAdhQmoDk3iBsSBwm0EDxmu4ksOtTLND72pRbmI3iGRunxdDGwYck8q8m
         H+hZRrOunYRBTUGzN7YLiXGS/jueudd5oaOdlaPWSkbtq+cNua1yd4n227O7V8BFA9ur
         lusA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764640836; x=1765245636;
        h=subject:cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DGss0LZUPEHUx/FnKLRHgHJPUXCJCdwTCbaOcsxbeS0=;
        b=f6RTfVoZFeijvoC3caM4XnNi+jAGX1tdUc3Zin2BpJ0I0MFhGwsfptSp5rsiuRCsXr
         5pLYc6ppuCd1/XEv0tKee/IAliFTJG7Z2Wh3h8cMT8trjDAFD1JxwgoQW7e7B210WTCK
         jxjsszVsdmUTDPtux68GTV88fJXDP9lzsObOKsgJzcx/IKDgkK5JVD80cvuC6FTFLFcV
         d7ZQvMnuFbtDjtbxMT4uevG6KohElrGuDaWHfsxZKaOGKbzV/513ZlihVzRE4RrNUYfL
         jHt2YrQk2lKwPXM3LT0aAtbIqHvyHUUkg8451moV7rXgXfHqKANZ8JnplAA0D2I4VceD
         af7g==
X-Gm-Message-State: AOJu0YxtCovBJrLT7FKWAPk53GEAPSjyfhCXXc5Q0yC9Qfy3zJ/aGbYD
	Bvr5LUmYVSzXFG/yF30mTR8QZ2W4G/kllN09oM/XbmZoxtin4nQpBKfhwZaqV7Znl07LUW/ADT8
	SL5Y=
X-Gm-Gg: ASbGnctjRsgPCerNgTwDx3oN/er16TbFCXlYLhmwIhOC7jI8eaoBzDRGz+xL5wQNbly
	B4EPe1+PwLz/MTyFzDFQuxEQ9pIz5Ql0BhayylHQGSGG1pqkozb6rJFCVdPLsr3X7M6Qk+mVUPM
	hr4Wh0miNz0JUVBKiyq3tQxocNcc3EbAp65L6ZYOdFHFuWuATeu3b6DpWkiLVnODGCKMd7oVyXM
	b1oqpGlKyOhVo/3U2EhmifiMV5I54X7YAKZME/JaIM9dfDGs+h+dhcrHGY4lDjbbuC4WIgBWV+w
	lfOjdyIgWJy1GRLYGpYedJYSJMikz/rYGOSYfdWv0Z5Jw8/+iGbTr2rUiv3rJ0E4ARTpzjcyodH
	ob6gf5b3x6wudwF/2MQr6ID+P7zYCHn3m6g42rY2M1zHRPm/4dycyQK04PoXNd/cA3fNv3KJTGo
	YAQ2EmQi76lMZk2bzt0flU4swVN2zwYQZ0sjmvCMaBiGwHrgAJ+Mx+n9Lp
X-Google-Smtp-Source: AGHT+IGSISf8N0K0YT3d4Y8TFuxSVd/6hEqyjKtDflQ2Joj57f6953OB5zDCnym3oanO9TXKdiDdIA==
X-Received: by 2002:a05:6214:5542:b0:880:55e4:dde with SMTP id 6a1803df08f44-8847c545e37mr611979546d6.63.1764640835991;
        Mon, 01 Dec 2025 18:00:35 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88652b8efa9sm94178606d6.50.2025.12.01.18.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 18:00:34 -0800 (PST)
Date: Mon, 01 Dec 2025 21:00:34 -0500
Message-ID: <b60d63f8bd01d8432b9986d8a4797f4b@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] lsm/lsm-pr-20251201
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Linus,

A larger pull request than usual for the LSM framework, however, all but
one of the commits are tied to one effort:

- Rework the LSM initialization code

  What started as a "quick" patch to enable a notification event once
  all of the individual LSMs were initialized, snowballed a bit into a
  30+ patch patchset when everything was done.  Most of the patches,
  and diffstat, is due to splitting out the initialization code into
  security/lsm_init.c and cleaning up some of the mess that was there.
  While  not strictly necessary, it does cleanup the code signficantly,
  and hopefully makes the upkeep a bit easier in the future.

  Aside from the new LSM_STARTED_ALL notification, these changes also
  ensure that individual LSM initcalls are only called when the LSM is
  enabled at boot time.  There should be a minor reduction in boot times
  for those who build multiple LSMs into their kernels, but only enable
  a subset at boot.

  It is worth mentioning that nothing at present makes use of the
  LSM_STARTED_ALL notification, but there is work in progress which is
  dependent upon LSM_STARTED_ALL.

- Make better use of the seq_put*() helpers in device_cgroup

Paul

--
The following changes since commit 211ddde0823f1442e4ad052a2f30f050145ccada:

  Linux 6.18-rc2 (2025-10-19 15:19:16 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
    tags/lsm-pr-20251201

for you to fetch changes up to 9a948eefad594c42717f29824dd40d6dc0b7aa13:

  lsm: use unrcu_pointer() for current->cred in security_init()
    (2025-11-19 10:32:06 -0500)

----------------------------------------------------------------
lsm/stable-6.19 PR 20251201
----------------------------------------------------------------

Paul Moore (34):
      lsm: split the notifier code out into lsm_notifier.c
      lsm: split the init code out into lsm_init.c
      lsm: consolidate lsm_allowed() and prepare_lsm() into
         lsm_prepare()
      lsm: introduce looping macros for the initialization code
      lsm: integrate report_lsm_order() code into caller
      lsm: integrate lsm_early_cred() and lsm_early_task() into caller
      lsm: rename ordered_lsm_init() to lsm_init_ordered()
      lsm: replace the name field with a pointer to the lsm_id struct
      lsm: rename the lsm order variables for consistency
      lsm: rework lsm_active_cnt and lsm_idlist[]
      lsm: get rid of the lsm_names list and do some cleanup
      lsm: rework the LSM enable/disable setter/getter functions
      lsm: rename exists_ordered_lsm() to lsm_order_exists()
      lsm: rename/rework append_ordered_lsm() into lsm_order_append()
      lsm: rename/rework ordered_lsm_parse() to lsm_order_parse()
      lsm: cleanup the LSM blob size code
      lsm: cleanup initialize_lsm() and rename to lsm_init_single()
      lsm: fold lsm_init_ordered() into security_init()
      lsm: add/tweak function header comment blocks in lsm_init.c
      lsm: cleanup the debug and console output in lsm_init.c
      lsm: output available LSMs when debugging
      lsm: group lsm_order_parse() with the other lsm_order_*()
         functions
      lsm: introduce an initcall mechanism into the LSM framework
      loadpin: move initcalls to the LSM framework
      ipe: move initcalls to the LSM framework
      smack: move initcalls to the LSM framework
      tomoyo: move initcalls to the LSM framework
      safesetid: move initcalls to the LSM framework
      apparmor: move initcalls to the LSM framework
      lockdown: move initcalls to the LSM framework
      selinux: move initcalls to the LSM framework
      lsm: consolidate all of the LSM framework initcalls
      lsm: add a LSM_STARTED_ALL notification event
      lsm: use unrcu_pointer() for current->cred in security_init()

Roberto Sassu (1):
      ima,evm: move initcalls to the LSM framework

Thorsten Blum (1):
      device_cgroup: Refactor devcgroup_seq_show to use seq_put* helpers

 include/linux/lsm_hooks.h              |   73 +-
 include/linux/security.h               |    3 
 security/Makefile                      |    2 
 security/apparmor/apparmorfs.c         |    4 
 security/apparmor/crypto.c             |    3 
 security/apparmor/include/apparmorfs.h |    2 
 security/apparmor/include/crypto.h     |    1 
 security/apparmor/lsm.c                |   11 
 security/bpf/hooks.c                   |    2 
 security/commoncap.c                   |    2 
 security/device_cgroup.c               |   56 +-
 security/inode.c                       |   46 +
 security/integrity/evm/evm_main.c      |    5 
 security/integrity/evm/evm_secfs.c     |   11 
 security/integrity/iint.c              |   14 
 security/integrity/ima/ima_fs.c        |   11 
 security/integrity/ima/ima_main.c      |    6 
 security/integrity/integrity.h         |    2 
 security/ipe/fs.c                      |    4 
 security/ipe/ipe.c                     |    3 
 security/ipe/ipe.h                     |    2 
 security/landlock/setup.c              |    2 
 security/loadpin/loadpin.c             |   15 
 security/lockdown/lockdown.c           |    5 
 security/lsm.h                         |   58 ++
 security/lsm_init.c                    |  564 ++++++++++++++++++++++
 security/lsm_notifier.c                |   31 +
 security/lsm_syscalls.c                |    2 
 security/min_addr.c                    |    5 
 security/safesetid/lsm.c               |    3 
 security/safesetid/lsm.h               |    2 
 security/safesetid/securityfs.c        |    3 
 security/security.c                    |  623 +------------------------
 security/selinux/Makefile              |    2 
 security/selinux/hooks.c               |   11 
 security/selinux/ibpkey.c              |    5 
 security/selinux/include/audit.h       |    9 
 security/selinux/include/initcalls.h   |   19 
 security/selinux/initcalls.c           |   52 ++
 security/selinux/netif.c               |    5 
 security/selinux/netlink.c             |    5 
 security/selinux/netnode.c             |    5 
 security/selinux/netport.c             |    5 
 security/selinux/selinuxfs.c           |    5 
 security/selinux/ss/services.c         |   26 -
 security/smack/smack.h                 |   14 
 security/smack/smack_lsm.c             |   11 
 security/smack/smack_netfilter.c       |    4 
 security/smack/smackfs.c               |    4 
 security/tomoyo/common.h               |    2 
 security/tomoyo/securityfs_if.c        |    4 
 security/tomoyo/tomoyo.c               |    3 
 security/yama/yama_lsm.c               |    2 
 53 files changed, 1026 insertions(+), 743 deletions(-)

--
paul-moore.com
