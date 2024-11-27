Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1572B140E38;
	Wed, 27 Nov 2024 21:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732741507; cv=none; b=Nv6zs3sRv9qtqdj7o/MwMCNAgndySfM5SY9aPIX0setO/UjUxwDS7yPnA9fV8jKmzLWGWzzk76jyL4PXof2ZyGGmWeMmw7no+UPQvODUlZGa6pQw5PH/pVaiQQxeUdAgQP6BGsAOAZX2OzWh4JTKcbYJtMf99+IvmwbU2OYDstA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732741507; c=relaxed/simple;
	bh=1tQB4KkCRYLj9EIXaNnivm9OriRx0yD4O7OrpTTzag8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=UgJT/r9wRVw25aHM2mZ1orlytFEQuQkoRk0ltGqXeYJ6PxsHygkJ/+7jBoCN8ZyYY6bovhLhDhk+N/GJwAk1gWXOiL2R9e2HTazaovX59RrX0hKx7WGovEeILE3AoRz3jgTTig96QyKkfGIZJkESR2XYpAAAIcMKR4qVJlehRYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=oBWYO9qG; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="oBWYO9qG"
Received: from [192.168.192.84] (unknown [50.39.104.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 91DD140616;
	Wed, 27 Nov 2024 20:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1732741192;
	bh=lsiL23PSGeS7kRkaSO0TSWcYoeiimM07RgelnQ4NhV4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type;
	b=oBWYO9qGU5ng+HsrEoemmmgygH6oiyX19AYmiYRUKlMO4XIRXPVIHpUB//07oSeWn
	 CR1bzOeE4IIDsxpp+6FQMXWojdwiXag36Uo2jBPzPZ1GqUY4c+PixxZKMxmDvpbbbU
	 7bZyPpW8wJPkwzOXw/hJmAMXeMLEYDnpb0wlZoAlDN5e/pG8QO0U04hYvsiebY4+Bl
	 f+WFbNjCVVLAxgwnhzPibrpP2Iny28PcriHTN1sJRPe0/VT3Dh7XfDT+FaYLjudYPM
	 qUpMiAHXW0KduAr89KKUeh//EB8sPqzYJeHYoawruX+kdSO40q28twp8qHL7K/RbYm
	 vUROkB9Vppr1w==
Message-ID: <f8ecfc95-61d4-4637-b6ce-aa43b038ea37@canonical.com>
Date: Wed, 27 Nov 2024 12:59:49 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: John Johansen <john.johansen@canonical.com>
Subject: [GIT PULL] AppArmor updates for 6.13
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKLM <linux-kernel@vger.kernel.org>,
 "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Content-Language: en-US
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

This update is largely Bug fixes and cleanups. It has two small
developments, which I can drop and push to 6.14 if you would like. The
first increases the size of the policy state machine that can be
supported. At run time this is just swap out the next/check tables to
use u32, older policy is remains supported by mapping remapping the old
u16 to the u32 during policy load. The second is an improvement to age
the capability auditing cache.

These have all been in linux-next for more than two weeks, and I finally
managed to trace down and fix a bug in the regression tests that was causing
a failure, so these have been merge and regression tested against your tree
from this last weekend.

thanks
- john




The following changes since commit aaf20f870da056752f6386693cc0d8e25421ef35:

   Merge tag 'rpmsg-v6.13' of git://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux (2024-11-26 18:36:55 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/apparmor-pr-2024-11-27

for you to fetch changes up to 04b5f0a5bfee5a5886dc19296c90d9a6964275e4:

   apparmor: lift new_profile declaration to remove C23 extension warning (2024-11-26 19:21:06 -0800)

----------------------------------------------------------------
* Features
   - extend next/check table to add support for 2^24 states to the
     state machine.
   - rework capability audit cache to use broader cred information
     instead of just the profile. Also add a time stamp so old
     entries can be aged out of the cache.

* Bug Fixes
   - fix 'Do simple duplicate message elimination' to clear previous
     state when updating in capability audit cache
   - Fix memory leak for aa_unpack_strdup()
   - properly handle cx/px lookup failure when in complain mode
   - allocate xmatch for nullpdb inside aa_alloc_null fixing a
     NULL ptr deref of tracking profiles in when in complain mode

* Cleanups
   - Remove everything being reported as deadcode
   - replace misleading 'scrubbing environment' phrase in debug print
   - Remove unnecessary NULL check before kvfree()
   - clean up duplicated parts of handle_onexec()
   - Use IS_ERR_OR_NULL() helper function
   - move new_profile declaration to top of block instead immediately
     after label to remove C23 extension warning

* Documentation
   - add comment to document capability.c:profile_capable ad ptr
     parameter can not be NULL
   - add comment to document first entry is in packed perms struct is
     reserved for future planned expansion.
   - Update LSM/apparmor.rst add blurb for
     CONFIG_DEFAULT_SECURITY_APPARMOR

----------------------------------------------------------------
Dr. David Alan Gilbert (1):
       apparmor: Remove deadcode

Hongbo Li (1):
       apparmor: Use IS_ERR_OR_NULL() helper function

Jinjie Ruan (2):
       apparmor: test: Fix memory leak for aa_unpack_strdup()
       apparmor: Remove unused parameter L1 in macro next_comb

John Johansen (4):
       apparmor: add support for 2^24 states to the dfa state machine.
       apparmor: document first entry is in packed perms struct is reserved
       parser: drop dead code for XXX_comb macros
       apparmor: lift new_profile declaration to remove C23 extension warning

Leesoo Ahn (1):
       apparmor: domain: clean up duplicated parts of handle_onexec()

Ryan Lee (6):
       apparmor: allocate xmatch for nullpdb inside aa_alloc_null
       apparmor: properly handle cx/px lookup failure for complain
       apparmor: document capability.c:profile_capable ad ptr not being NULL
       apparmor: add a cache entry expiration time aging out capability audit cache
       apparmor: audit_cap dedup based on subj_cred instead of profile
       apparmor: replace misleading 'scrubbing environment' phrase in debug print

Siddharth Menon (1):
       Docs: Update LSM/apparmor.rst

Thorsten Blum (1):
       apparmor: Remove unnecessary NULL check before kvfree()

chao liu (1):
       apparmor: fix 'Do simple duplicate message elimination'

  Documentation/admin-guide/LSM/apparmor.rst |  7 ++-
  security/apparmor/apparmorfs.c             |  1 +
  security/apparmor/capability.c             | 19 +++---
  security/apparmor/domain.c                 | 66 +++++++++-----------
  security/apparmor/include/label.h          | 28 ---------
  security/apparmor/include/lib.h            |  1 -
  security/apparmor/include/match.h          |  8 ++-
  security/apparmor/include/perms.h          |  3 -
  security/apparmor/include/policy.h         |  1 -
  security/apparmor/include/secid.h          |  1 -
  security/apparmor/label.c                  | 33 ----------
  security/apparmor/lib.c                    | 84 -------------------------
  security/apparmor/match.c                  | 99 +++++++++++++++++++++++-------
  security/apparmor/path.c                   |  2 +-
  security/apparmor/policy.c                 |  9 +--
  security/apparmor/policy_unpack.c          |  5 +-
  security/apparmor/policy_unpack_test.c     |  6 ++
  security/apparmor/secid.c                  | 14 -----
  18 files changed, 141 insertions(+), 246 deletions(-)



