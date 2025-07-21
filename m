Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D20E18B0F
	for <linux-security-module@vger.kernel.org>; Mon, 21 Jul 2025 23:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140241; cv=none; b=kxx1PFcRUQ+N3FzeJNCO/37Bei8SNpCOdO/GaUw6yvrTkKeH1UKYPghbhn3bOESmZ/1ByCpC2u8F8pxSxn60FrLb3YisyIyj3as6isfifZSC+K4W8hiZONrtaU+BKSs5mbAiv83/Q9wOQZXbWv1A/H4lNaJm9co2Pg6Ho9YUuDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140241; c=relaxed/simple;
	bh=9CsL4mPV2dsaGysCfwx3REgaptFlqd7wF9HSrpxwGTo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QgCVjuGH1hLvpAziTfa3mCPrnAbFCmfJjAeaNm2fwPJz1VZCNLAZGMlR2KX7/8oMvZ0ankfQrV4UV1D7VMSjefsaz0Av6ctLGVPmaGxrxoFPUhLNw2DXqT534orbR4uFTg1Y24mUNtcF0wCvU6CgZx2mvAN27hOr3q+0JI+KACw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=UO9OVW7Z; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UO9OVW7Z"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4aba19f4398so64378341cf.1
        for <linux-security-module@vger.kernel.org>; Mon, 21 Jul 2025 16:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753140239; x=1753745039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PinUcNST4KlnEqJlCVOm71QRYIVb44YBVpGpWsCOdq4=;
        b=UO9OVW7Zpi03lqqlsMv0+RCYyqkFwOCBpBQNBZuo4w1PPhrZMUDnLJ60VCEwXEWGn4
         yJtUdgl0xQxDFPbbotnIsZ3H3FdclZxewXSSqcWZ4Cc7NqGMvh8J8MC76KNXNlslWSjk
         312D2PJF9WW7UmsLJMRSlmS9+t8YLya376W6goZy1UhGBfEAuXsFBqIBn8bp1hd0fVyX
         O1kv/PBabeFdeqRjFR+MGnWy2B7BEKQYEx90U7ERhvLU84rW4hNtTghbGOjoRzorDZjD
         aNUwOS5PSZnEkElxftoCQ6HR9emf1TjLl8CgVQMrGWlW9jCoYIhmkTOmsD0OVua3anKT
         hbXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753140239; x=1753745039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PinUcNST4KlnEqJlCVOm71QRYIVb44YBVpGpWsCOdq4=;
        b=fOqS7VUwY/tdHL6V0lgu4vHs+B3xWfLvuzvKw68PFZaTth9nexQey2mIanhp0hJzx1
         9h3HoBN75BsiL8vu5PdrwgwlvxB4Yv4llC3vBEH97Jlzpa260uZMYOeVMOTcE99Qabik
         shUc5Zvexylc/BMJUnPwYEn/+lSPZbKo08Lj/8UelFBBLMUGooea1U1DxhPf5ad0iATz
         waR2j0Njy4apXeC/AOUDgw3vx2ZC+QKPS5ry7nPmw5DkX/5DP9rcJ0ncVBqiC3BxFJR0
         QsQ4R5k3QzjtLcYc4hbJalLzPzaeBNEPTI5spLDWGFu7OiSqOg0L9XwGRaQzVrjGDnrw
         PjUw==
X-Gm-Message-State: AOJu0YwemnSO8dQwp/88icj+fhvyFe1ibfRXF3ecdkdqaBSszHx2TQZ9
	rhMdPwSlk6zzwd6aQMix4l1ee5kLI5asRTm92lWyDjgHoukAowMd7J+yrdzzsY3FRGiMCASXzYW
	+3uw=
X-Gm-Gg: ASbGnctsvDkBhH89gbCIxoQZNQSBFqibLsnWo4Sue4aQb8FCRJMLqfdoq8WcTLrjE8s
	Lt+RYNsBqLQZreO44gcYN7w3X6G+SnGrYnlWR+FAendc48ObsuTgSOJuKvM+KeMEKQm2IeaZ3uA
	XkZAb8d5fTz4QDLK6diIOE6r29/H2FoCXp3pLD/acmXT2nyqhOEWDq+OWudLTwoFbvIWhRF457B
	L0gPDCMATcmPz1TSg1Bbb6cxQMPxntfCQoRJTPzc2BnYqoSvA0HR2FK6cMxvuyJ04dchBFDcFTE
	j5ucnzg6rRh1ch1RQEhqBVtqQUid3DWr8YEW1WJcJAfW7tawb1ZBSTdUfNAl+1iB8eoGxRsSzmD
	Rgrlw/83M6iMc/oYdKANx5wRkDB9P0tdBG/ZkR7Xe5OB0mvWXzqM7jLSPECjXTsbJmlA/zvT9TH
	vDEg==
X-Google-Smtp-Source: AGHT+IHhL7W7Ne/UrCbwfq2tmToqJK+MeGR34jdUxqqdzAQ6wsDDhovNS1Ak/vsPos7zAwiL0yYpTg==
X-Received: by 2002:ac8:5e06:0:b0:4a9:8685:1e92 with SMTP id d75a77b69052e-4ab90b1b83bmr311439841cf.34.1753140238908;
        Mon, 21 Jul 2025 16:23:58 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4abb49802efsm46996491cf.7.2025.07.21.16.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 16:23:58 -0700 (PDT)
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
Subject: [RFC PATCH v2 0/34] Rework the LSM initialization
Date: Mon, 21 Jul 2025 19:21:03 -0400
Message-ID: <20250721232142.77224-36-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

It's taken a few months to prepare the second RFC for posting, mostly
because of the sorry state of the first RFC, although as discussed
earlier, there was a reason for that.  There is a CHANGELOG below with
an itemized list of the changes between RFC/v1 and this posting, but
you can summarize it into three basic things: adding proper commit
descriptions, decomposing some of the uglier patches into smaller
coherent patches that make more sense, and dropping the subject/object
counting code as Casey found a different approach that fits his needs.
I've added the ACKs/Reviewed-by/etc. tags from the first posting, but
left some off as the associated patches changed enough that I felt it
was no longer responsible to include them.  Additional review is always
welcome and encouraged.

The RFC/v1 patchset is linked below, the cover letter provides some
background and motivation for this series which still applies.

https://lore.kernel.org/linux-security-module/20250409185019.238841-31-paul@paul-moore.com/

CHANGELOG
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

 include/linux/lsm_hooks.h              |   67 +-
 include/linux/security.h               |    3 
 security/Makefile                      |    2 
 security/apparmor/apparmorfs.c         |    4 
 security/apparmor/crypto.c             |    4 
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
 security/integrity/initcalls.h         |   13 
 security/ipe/fs.c                      |    4 
 security/ipe/ipe.c                     |    3 
 security/ipe/ipe.h                     |    2 
 security/landlock/setup.c              |    2 
 security/loadpin/loadpin.c             |   15 
 security/lockdown/lockdown.c           |    5 
 security/lsm.h                         |   42 +
 security/lsm_init.c                    |  557 ++++++++++++++++++++++
 security/lsm_notifier.c                |   31 +
 security/lsm_syscalls.c                |    2 
 security/min_addr.c                    |    5 
 security/safesetid/lsm.c               |    3 
 security/safesetid/lsm.h               |    2 
 security/safesetid/securityfs.c        |    3 
 security/security.c                    |  617 +------------------------
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
 security/smack/smack.h                 |    7 
 security/smack/smack_lsm.c             |   11 
 security/smack/smack_netfilter.c       |    4 
 security/smack/smackfs.c               |    4 
 security/tomoyo/common.h               |    2 
 security/tomoyo/securityfs_if.c        |    4 
 security/tomoyo/tomoyo.c               |    3 
 security/yama/yama_lsm.c               |    2 
 52 files changed, 1012 insertions(+), 703 deletions(-)

