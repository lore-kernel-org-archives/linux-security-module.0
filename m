Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1A027D784
	for <linux-security-module@vger.kernel.org>; Thu, 14 Aug 2025 22:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212044; cv=none; b=F822XId+RmnX60bgSGqBDj0Pn8dOqCrWwmL+2xDF6QZ8qw52tFBeQZgCJipZIt5G5ny249b+Nac9u5A7JSpEveQb5rMVQerH/B2KmqT5as2SVfc7GA+SIlr9n3t+yGXW20VO3e6wMnDkP4AZ9Kp+6RrzGzHAHR5m++PBhDP2Njc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212044; c=relaxed/simple;
	bh=lPdhiCA/2A43VbIVwb+6dc6qvHinv/k9x8LvcHDmb0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U7J3NJ0k3pL8jP24hiFHASOOgM9UdLNnWVIx7A3s9VRQRtf/aAGRAQ0JStMVx4W4+n9B0hRa/UNSuh42PAAw0T/FfiGH6dJrWP3cSMYO9ugiEEkQBGWLVjt/KnBDTUIFMDZXHwfag/GJlhtCGalzZkzQfIcKeIrAnXGm1t79BEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=AogRvOMz; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="AogRvOMz"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-70a928cca6aso8611986d6.2
        for <linux-security-module@vger.kernel.org>; Thu, 14 Aug 2025 15:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755212041; x=1755816841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rU+UOhNaqwsjYUe9zCIc66XJqDaw1SHKCGrAl1D5PcE=;
        b=AogRvOMzaFUZ51nWudmhtAvLKQCPMxqJUq+rBRtFaD2riJZxFdRHldR2u/TgsOUSf/
         Kx7zSQQ4429F+1g88MMVWsnzgE5aEjKFmLiVOiARaJmci/9GfiUKf7nize1TPAZSs90h
         KD3To7XCDJSUGXCsSjGyjrJh55+6ZbJVj6AmDY3MVqjWGolPJ/3aEckmxKv+++Pr7RyJ
         rsG7WdOXGb8P2Di//vFkJP3oDMugQ8Tfu1VKnnDqQLpbsFGAR0pO/Sv7n0nTdsVa+BFj
         FNChCiWMkjapDGL2clII37p0oM+d6Qb1nJVJPdcPPBXwAsYuFzH0qEmBOmBeIcZDPXw8
         bYdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755212041; x=1755816841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rU+UOhNaqwsjYUe9zCIc66XJqDaw1SHKCGrAl1D5PcE=;
        b=c9zqTbzicpkPLf8wsLwzduwO6tXvL30x5+BgewBtupQDShPLg85vIEUL5TZtEpbdjX
         EJUXdH/iCmpEBdOo+cju1QbADn+CFukUTlnJVe0AV9+wLHXKFi9EjS2BQowP4RTR9OPE
         8v5dpn0yzCBQUVYtDgMQPREUaO9bG2+W+Ztx7Bj8yvcnHgUKj791WKT7oZz/bQl9fMwl
         CdLWB8QcJHIjBCrPdAYGuPlE/aNGzFN47ajplckNgksvqs5pfgRvje4PUPt+hU2ZVxsr
         BJU+/c0YIsqPRwvQUwIYAODQZB6HQrdNNGGr89eZmShTc/ZOq7uspZDqSbozLWCXIQII
         K4Tg==
X-Gm-Message-State: AOJu0Yz8ZG6tIaFY96MA+luNUC0Bb8ACHlRMzkrkFd2JVoruiVgbQpAb
	K0jp0uwji/1YgWnk2WGoWU99/9cD/Nz66k4Ljrkxlh9qgioOo7bpy6UTjaKS4asgzuYyWLDqcQg
	CoX0=
X-Gm-Gg: ASbGncvw8uVeIkDp1swTvJA0XOUmqiLhqUVzSDRaHL5bbNUhSaiFBc7QTVXw6DcpvoJ
	4dwW1veaHMI3BfiAVhT9veuOxNEgSV7unVmHo/yrVgC+YZakfTYZYu/dSD3DkC2MoKL3DweYX0L
	iIcIFVxVemgkcFcZwTzpTgiXau6TXpzx8OBlfrNTz0O/KOqr2BSHOCLa11Vf0RKkySTAVynL0/T
	OF7y5rspXYEIkkQ+S8yeX5RzUlIf/RjzLNSjv3Tv3+j5STE3cfI353wZY5pKUFJhV9jNFtxJLhB
	vpKrrLxVTmAYSt/uYRrN8aAQlxGkP4OPsCagrcfFPnUqpYhLo+nAJ/rgXZxD4gYivx8s1Yktaa8
	fbvLtCX/xlDwDNagGp+LbuF/9dXn555EP9+RKlvWmHTxZaeg6L5Dh6xXY/+eaTAQWByY=
X-Google-Smtp-Source: AGHT+IEjObLWGd1F0gHvu1/FHumZZNzME/HV+XYLewREMJxt9Y3k5V3pQZrwrK7pJHvmnr4LC13rqQ==
X-Received: by 2002:a05:6214:5013:b0:709:dff6:9b8e with SMTP id 6a1803df08f44-70af5ccd897mr83782626d6.36.1755212041097;
        Thu, 14 Aug 2025 15:54:01 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-70adc1cd165sm19419346d6.8.2025.08.14.15.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 15:54:00 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Fan Wu <wufan@kernel.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Kees Cook <kees@kernel.org>,
	Micah Morton <mortonm@chromium.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: [RFC PATCH v3 0/34] Rework the LSM initialization
Date: Thu, 14 Aug 2025 18:50:09 -0400
Message-ID: <20250814225159.275901-36-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The third revision of the LSM initialization rework patchset.  While
there was a good deal of change between RFC/v1 and RFC/v2, the number
of changes in the v3 revision are relatively minor; I think the biggest
change is simply bringing it up to date with the current lsm/dev branch.

Please take a look if you haven't already, and to my fellow LSM
maintainers, please focus on the patch associated with your LSM and
either send me an ACK or reply back with the changes you would like to
see before this is merged.  I think we're in a good place with this
patchset, and I'd like to get this merged during this dev cycle if
possible.

The RFC/v2 patchset:
https://lore.kernel.org/linux-security-module/20250721232142.77224-36-paul@paul-moore.com/

The RFC/v1 patchset is below, the cover letter provides some background
and motivation for this series which still applies:
https://lore.kernel.org/linux-security-module/20250409185019.238841-31-paul@paul-moore.com/

CHANGELOG
v3:
- rebased to lsm/dev branch
- fixed IMA/EVM initcall comment (Roberto)
- fixed CONFIG_IMA and CONFIG_EVM problems (Nicolas, Roberto)
- fixed CONFIG_SECURITY_SMACK_NETFILTER problems (Roberto)
- fixed the IMA/EVM header file include macro protections
- fixed an off-by-one string length issue in lsm_read() (Casey)
RFC/v2:
- rename lsm_prep_single() to lsm_prepare()
- drop the lsm_prop counting patch
- drop the platform_certs changes from the IMA/EVM patch (Mimi)
- split/reorder anough patches in the patchset that I lost track
- added missing function comment blocks in the SELinux patches
- split patch 04/29 into smaller patches (Kees)
- fix an LSM list output problem in an intermediate patch (Kees)
- preserve the "lsm_active_cnt" variable name (Casey)
- cache the lsm_read() string (Kees)
- squashed, split, and reordered the enabled/ordering patches
- reworked the Smack patch (Casey)
- conditionalized the SELinux IB init code (Stephen)
- fixed missing Smack "__init" annotation (Fan)
- fixed a potential unused variable warning in IMA/EVM (John)
- fixed the placeholder commit descriptions (various)
RFC/v1:
- initial version

--
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
      ima,evm: move initcalls to the LSM framework
      selinux: move initcalls to the LSM framework
      lsm: consolidate all of the LSM framework initcalls
      lsm: add a LSM_STARTED_ALL notification event

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
 security/inode.c                       |   62 ++
 security/integrity/Makefile            |    2 
 security/integrity/evm/evm_main.c      |    8 
 security/integrity/iint.c              |    4 
 security/integrity/ima/ima_main.c      |    8 
 security/integrity/initcalls.c         |   41 +
 security/integrity/initcalls.h         |   28 +
 security/ipe/fs.c                      |    4 
 security/ipe/ipe.c                     |    3 
 security/ipe/ipe.h                     |    2 
 security/landlock/setup.c              |    2 
 security/loadpin/loadpin.c             |   15 
 security/lockdown/lockdown.c           |    5 
 security/lsm.h                         |   42 +
 security/lsm_init.c                    |  563 ++++++++++++++++++++++
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
 52 files changed, 1043 insertions(+), 711 deletions(-)

