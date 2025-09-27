Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723842206B8
	for <linux-security-module@vger.kernel.org>; Sat, 27 Sep 2025 03:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758942464; cv=none; b=ESRcJp7oCpXJvKO/B6nScTI6TknrwRv7Fy8l54yVqTzdWUI0dYUyyGg7pU9BJtsjvvGDNlGS6FTkaWBcNkKIep5W9SH0unzjrITcnNc5BfwqqCcB0DJKu1jn+WbujzyZyoMBrvnelWiJcEn3u9krb4J6hfvhu3yNk4zHhOJUXN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758942464; c=relaxed/simple;
	bh=aPobOO7WnjJZOB+RNqo/7lhEQ6V6+hKlbl399mJh0Uw=;
	h=Date:Message-ID:From:To:Cc:Subject; b=ZG1wsr/wA/zut5fkMI+DiVkc/RYjsuWBfUswOV34SsHlBRhvLRVZ/qry6dDrFQYETMTbEeD4OpgTmKQlb2LpMGBLJ/ma+h3fSBTLKPABN1CXGXT9m+vNiF503+oIUdOaxOm6u50uA8ZcfyPM7nS0Mob6K2SspG02Q8wV8RcDTpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TxmI8HtB; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TxmI8HtB"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-78f30dac856so24570226d6.2
        for <linux-security-module@vger.kernel.org>; Fri, 26 Sep 2025 20:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758942461; x=1759547261; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yp3lKOizHfbYQMLxItAPWev9U/XlTvHIGNeFDnSx3GA=;
        b=TxmI8HtBtDPF8hAzAWq+wEly+fQNvwU+ipQnRhXpBNRJRvMkkoqhwhN5aqySBGhiM4
         P9cddEjxVAL5oSPD2bukxQdWzo3fTUVlyDTP8ZGNiLvYSAAtXMH+H+CxiMmTgmjaRyB+
         uHvdBrVKje31+cEK6Z+No8BrDYOXXRV6CvNfHdu5kcanghVWJLMAB9VN5XXbKLCzyNki
         zwnb7f0KCBsCXV9EeCqxuh61PWtpxUZj8AGEwWjMkOeoNkY1rd8OxUjwjd2USP5LAc6k
         w3MbXEaUqIUeA7idg8rPKfdwBdWYBxS0rGoGyaiwq3FCsId/o4LsqyFC9jX/hIPwPEuQ
         KEMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758942461; x=1759547261;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yp3lKOizHfbYQMLxItAPWev9U/XlTvHIGNeFDnSx3GA=;
        b=EuT9j4oM8K0Kv0MOv5FGsXeJp5c3NAFMscbqD3g3yaU8Avev60MMxYKlRDej2id9S8
         654AoMe593VPCGpL0wM16As75o7bX4bAl86RLlG9/T0mpL4KvBgKBl3XAJXLfZOC39H3
         h01DAnpEq+EeqVJYP6mzAmHPvaEcmTFdUGwquwo7FVEf4gA3fcnTds+uJ8H9jUP8cCtR
         Nk6Ez19lgI4kXS5adiLIJEa9cR27yJ7V/EcImZy+ioSIEcEWaK2VSWrnU+wmWIKK5wsf
         aUYwoA0U6XhxUVJCi6+hBu5qICCabNN+NFBIKDqOxCYxxbTyfd/NoXu9zxLxnMyjZzyT
         hOUA==
X-Gm-Message-State: AOJu0Yw9Zt//9rVSmYxZhVHw7NAIQFJJOMgaC2S9UI0EGvzQDoBtJiP+
	JaIBg38UMQ6pM8141P4LLPOsq6PN2DsSMi/9HKcO4upfWawM1pUfEkb31na40YXdU5PC5kdbNnk
	+y/8=
X-Gm-Gg: ASbGncs7gb9LgnhF65dzguUlYcSYXM2UMt/WD0nFcbw/FiCLwUKeBdVDaHlhHam/ugc
	KPPIY9kcbDtS4beZOzi2rqtnROqRVpTCp0rbickiHbIyCcrgOhRMRvwvV4Beek4eqzK6p22BhBS
	waDjnb5/X1Is9bNqMpdzvwVnchS8phFedP1EoX7b9AceLnv9dnd8BptJApvI7CVL3yYV+6snBen
	A2Kf39TdChAszQx5fB69Dlhd8exmAuAYLpNupdyishjBbdKcdMPGBEe36VuE6e4WmnKISidgtoi
	iI2LVn5JYo50cUXFhY8P5fHgyDpU4jcvLv4xs6xtJpeXrMuyjKXEce8OGXXHWvCKOm4uGIoZ+ss
	HvBhOwp/qKbapj411w0PKbtS5oELi20IUDmKFErGkHlp/zqnuUyCM2qUs7t6KBUrSyBUjQKzEfE
	BJLQM=
X-Google-Smtp-Source: AGHT+IHgpHHxgry3Lut9EVp65Mvkk+TNQ6IbpO4i4j4mh5u/pHY+SXg2VgTUPKyqxzQ+9Q5p8aATlg==
X-Received: by 2002:a05:6214:5294:b0:7cd:91ff:6214 with SMTP id 6a1803df08f44-7fc4ec01d2cmr132041536d6.62.1758942461293;
        Fri, 26 Sep 2025 20:07:41 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-80166e2f32bsm36429156d6.41.2025.09.26.20.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 20:07:40 -0700 (PDT)
Date: Fri, 26 Sep 2025 23:07:40 -0400
Message-ID: <1c4f33b7d1e986bb09ce18410200f91e@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] lsm/lsm-pr-20250926
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Linus,

Here are the LSM framework patches for the upcoming Linux v6.18 merge
window:

- Move the management of the LSM BPF security blobs into the framework

  In order to enable multiple LSMs we need to allocate and free the
  various security blobs in the LSM framework and not the individual
  LSMs as they would end up stepping all over each other.

- Leverage the lsm_bdev_alloc() helper in lsm_bdev_alloc()

  Make better use of our existing helper functions to reduce some code
  duplication.

- Update the Rust cred code to use 'sync::aref'

  Part of a larger effort to move the Rust code over to the 'sync'
  module.

- Make CONFIG_LSM dependent on CONFIG_SECURITY

  As the CONFIG_LSM Kconfig setting is an ordered list of the LSMs to
  enable a boot, it obviously doesn't make much sense to enable this
  when CONFIG_SECURITY is disabled.

- Update the LSM and CREDENTIALS sections in MAINTAINERS with Rusty bits

  Add the Rust helper files to the associated LSM and CREDENTIALS entries
  int the MAINTAINERS file.  We're trying to improve the communication
  between the two groups and making sure we're all aware of what is
  going on via cross-posting to the relevant lists is a good way to
  start.

Paul

--
The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
    tags/lsm-pr-20250926

for you to fetch changes up to 54d94c422fed9575b74167333c1757847a4e6899:

  lsm: CONFIG_LSM can depend on CONFIG_SECURITY
    (2025-09-11 16:32:04 -0400)

----------------------------------------------------------------
lsm/stable-6.18 PR 20250926
----------------------------------------------------------------

Blaise Boscaccy (1):
      lsm,selinux: Add LSM blob support for BPF objects

Paul Moore (3):
      lsm: use lsm_blob_alloc() in lsm_bdev_alloc()
      MAINTAINERS: add the associated Rust helper to the LSM section
      MAINTAINERS: add the associated Rust helper to the CREDENTIALS
         section

Qianfeng Rong (1):
      security: use umax() to improve code

Randy Dunlap (1):
      lsm: CONFIG_LSM can depend on CONFIG_SECURITY

Shankari Anand (1):
      rust,cred: update AlwaysRefCounted import to sync::aref

 MAINTAINERS                       |    2 
 include/linux/lsm_hooks.h         |    3 
 rust/kernel/cred.rs               |    6 -
 security/Kconfig                  |    1 
 security/min_addr.c               |    6 -
 security/security.c               |   98 ++++++++++++++++++++++++++----
 security/selinux/hooks.c          |   56 +++--------------
 security/selinux/include/objsec.h |   20 ++++++
 8 files changed, 124 insertions(+), 68 deletions(-)

--
paul-moore.com
