Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com [209.85.160.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129D13C4167
	for <linux-security-module@vger.kernel.org>; Tue, 16 Jun 2026 02:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781578546; cv=none; b=G/fC6nj16VyC+SPzy46SHhbldijU4T4OuEw0IMzxtBr7ckht57iB9x53YL+7kZF6DlcYwCnQNiu4sig+KxRJI8ZC84pwqIx203r19qbNxGBd4pAsOOMEeVmHOU6ltMhVjxCiqZVfpeOrYvW0ei4aeZj5im0JP90+Rsa6wzX35gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781578546; c=relaxed/simple;
	bh=UIJdGw5UtCnNa+ICdlphlCumkYyyM9SuVvKUcxoMaUw=;
	h=Date:Message-ID:From:To:Cc:Subject; b=Qz9EJ6Zy1nPqXw0DdkuVzY2Larwmuh4FoYUBe0oAjbrcLp7kQqRZthbpsVwAWuy2Po/0jZHEU+Tvj0/qR5cpNO8kYcRskDbge5Xnxo2q3a4iAe82iACcoWskY4iZpDMMg+OgAvZa3fUCqT4rJPjXKRR7Na4Sho1MzeQTvYwXP0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QYGswcfx; arc=none smtp.client-ip=209.85.160.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QYGswcfx"
Received: by mail-qt1-f194.google.com with SMTP id d75a77b69052e-51776b4de37so35693121cf.1
        for <linux-security-module@vger.kernel.org>; Mon, 15 Jun 2026 19:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1781578544; x=1782183344; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXwlGxhzf+32k+zkMy6zWi+hjqqLA4HJgxUXiPX+O54=;
        b=QYGswcfxbmNRHt2d6GM8F3hShQQPy1OnbQUBWWQZKSkbklp31K/5m6kw69UXvcmXDJ
         Gdt+kPKP+p1VGnqn9pZ+oekzkTjBEEeJR91M7fEZYESe9vMwJRQL6sLbAsxzJ8M9Vw6M
         XGe1I309eYQYAeRY/ljzg/958W/4/P6fuRvIzPUhEvTbOJS+vfsdEAPW7p4kHI/bZ6/m
         ad77KEHLyEVOo14ZJTW0jTYRAhBAqscUxq8XztsevQdyrpVqABfzCuYM4RbUzuH42jrD
         1gkVxM8jDW7lFwaclQqDV5k6OIeDWryJeV0ycCJrNKfAZHpO9YGbbmEZOo3EN71QZ4H7
         KvSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781578544; x=1782183344;
        h=subject:cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TXwlGxhzf+32k+zkMy6zWi+hjqqLA4HJgxUXiPX+O54=;
        b=jKtTfSnaXDtZP+PtuK7UIefYJdFNsvGuI7s/4ABmFizIfwAwPKbXSkLWlLbjdn9cqK
         +t+dPPNfujNV2MKk9ewkHI0nyfgzUm9edKZ5+633Fz1q31QHY1LQJxGp5RUTPuLqpIA2
         0vTVCrKWecDCRhaTIwfgMBFnw/6GXl2S1/MuJ2GIUUnN2lbG1L4m5qfwsYh4cUTBjbgH
         f/Uf3wjP1to4YHmcUqvr+jNBhQYr0saUHEaaHA10oHmen/MzCqNNQ7BQnZyK3qVgERQM
         e3UBaTxLL5KogXlVqVQQSwKsnipT0KJPnnwmXOgmo/WJuq6F50zgwFfTc6hgsAvb7iZl
         5EEw==
X-Forwarded-Encrypted: i=1; AFNElJ+gSFZP9EuAwADyLEf7CNx5odfzvkMMOXNKNXgDIf+ZL/e2S3GPgo0RZYCTIed/p07TXEOoqCTLksyV2Egle0bHD0Elh9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr0nHanLndpSPy0CmOtigva2yydqKOJSJYETiQ7Ik53cdTIGIy
	s/vBElbodaN4Zf08vyLGLIsRL0W+ZxP6oV9rYijf6znv+VanMm/Gbt0MX9lZPBp2MQ==
X-Gm-Gg: Acq92OGJau+S9cGXcZTjD/cyuRlfARTXiBXG6Tc+nggTAbqN37UFP6TAhcO0AxOx+sn
	c5SNxJ7HkJn+Zzt4Bqe75FSQrFcydeN5AaToevg06n6347kFE9L+Vok8nj1bTqD4xGhhrkgrgx6
	plTh91nyxytDZ6Ks4N2PW+SQ2enDjO+cDIVnb/WJFwUWslkoLTvJ4vMS3yANStysh+cADZqW/7t
	WRcyJyrh2FVd+2p6I45T+Rc4/dPgFfb/rPG4AH93xJJ8BhwsOVuCDJbQ1fKHQlI5t4rgIk+tlAf
	EjZ2KA0h/0O/GxkiUdvtOf95qSKEd52DtJgaZQG0eMS8Z/Dhp3GxNLM1sWnmqUEI+iRh16rDQ+p
	3zjCza7x05ygH4TTjxdWIsvwClzLvwigJgP55a7pYEZkH/JYcodKIwpTdIIMqHDsYtJ0943G3B3
	OhxUMoBuGho6BU74VFKJ2L6MQnIEB6I9ZdiKLGZlwa/lwbFrfXf2mawZWcLQDHEl0VadM9
X-Received: by 2002:a05:622a:5916:b0:517:760d:48ea with SMTP id d75a77b69052e-5195339bd2dmr218963441cf.18.1781578543930;
        Mon, 15 Jun 2026 19:55:43 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb7a00desm137115621cf.19.2026.06.15.19.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 19:55:43 -0700 (PDT)
Date: Mon, 15 Jun 2026 22:55:42 -0400
Message-ID: <577e6fb29cf0b9c335748aa5fa026275@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] selinux/selinux-pr-20260615
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Linus,

A number of SELinux patches for Linux v7.2, almost all of which are
either minor fixes or hardening patches.

- Additional verifications when loading new SELinux policy

Multiple patches by Christian Göttsche to add additional validations to
the code responsible for loading and parsing SELinux policy as it is
loaded into the kernel.

- Avoid nontransitive comparisons comparisons in our sorting code

Done to prevent unexpected sorting results due to overflow.  Qualys
documented a similar issue with glibc:
https://www.qualys.com/2024/01/30/qsort.txt

- Consistently use u16 for SELinux security classes

- Move from page allocations to kmalloc() based allocations

Unfortunately one of these patches had to be reverted, but you should
see a fixed version during the next merge window.

- Move from kmalloc_objs() to kzalloc_objs() in the policy load code

- Reorder sel_kill_sb() slightly to match other pseudo filesystems

- Simplify things with QSTR() instead of QSTR_INIT()

- Minor comment typo fixes

Paul

--
The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
    tags/selinux-pr-20260615

for you to fetch changes up to 033182baeab63ce96a6eb8aef1a6cd444fcf9519:

  selinux: revert use of __getname() in selinux_genfs_get_sid()
    (2026-05-29 11:24:37 -0400)

----------------------------------------------------------------
selinux/stable-7.2 PR 20260615
----------------------------------------------------------------

Christian Göttsche (9):
      selinux: avoid nontransitive comparison
      selinux: use u16 for security classes
      selinux: more strict policy parsing
      selinux: check length fields in policies
      selinux: check type attr map overflows
      selinux: reorder policydb_index()
      selinux: beef up isvalid checks
      selinux: more strict bounds check
      selinux: check for simple types

Kalevi Kolttonen (2):
      selinux: comment typo fix in selinuxfs.c
      selinux: comment spelling fix in ibpkey.c

Mike Rapoport (Microsoft) (2):
      selinux: use k[mz]alloc() to allocate temporary buffers
      selinux: hooks: use __getname() to allocate path buffer

Paul Moore (1):
      selinux: revert use of __getname() in selinux_genfs_get_sid()

Stephen Smalley (2):
      selinux: fix sel_kill_sb()
      selinux: switch two allocations to use kzalloc_objs()

Thorsten Blum (1):
      selinux: use QSTR() instead of QSTR_INIT() in init_sel_fs

 security/selinux/ibpkey.c           |    2 
 security/selinux/include/security.h |    1 
 security/selinux/selinuxfs.c        |   27 +-
 security/selinux/ss/avtab.c         |   49 +++
 security/selinux/ss/avtab.h         |   13 +
 security/selinux/ss/conditional.c   |   39 ++-
 security/selinux/ss/constraint.h    |    1 
 security/selinux/ss/ebitmap.c       |   27 ++
 security/selinux/ss/ebitmap.h       |    1 
 security/selinux/ss/hashtab.h       |    4 
 security/selinux/ss/mls.c           |   66 +++--
 security/selinux/ss/mls.h           |    6 
 security/selinux/ss/policydb.c      |  358 ++++++++++++++++++++++------
 security/selinux/ss/policydb.h      |   56 +++-
 security/selinux/ss/services.c      |   13 -
 security/selinux/ss/symtab.c        |    2 
 security/selinux/ss/symtab.h        |    2 
 17 files changed, 512 insertions(+), 155 deletions(-)

--
paul-moore.com
