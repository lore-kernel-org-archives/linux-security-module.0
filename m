Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B78F2571B3;
	Mon,  4 Aug 2025 12:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754310006; cv=none; b=GLDfDpwl4jchjYXrcfiViqp8sZ7lG2cwhgBNa324MzOF/uNOMw6mLww44NWPLob8wq+qX2cD9/ZQu5Q/cwcsrfxJIWTO7BviCA5KGVaIgQqvoYA3Nj15o50zy5lXIttpdUHE5JFD5DDneBeHAMkHUY/pYoAPPz+AwMRM/tlLHu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754310006; c=relaxed/simple;
	bh=Z2XOxsGec20JEHEZdicJHs5kqrzUgeoPMl2F6iueaU4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=TvMMPePzxCNfXGW91jI7zbhat5VzONsls917BTMdS0zlrOKbknmZCbVmfc3kIjQfH8LMw09IgghA/eY03fcb86xUN1hOY70JQSebTD10b2fze4WRUey5yg9qUWsesXdfd5F99oqxnDx29e9YX5k6xUckSnNZQ2dlABoOGRNHiS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=VO3pk8Hl; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="VO3pk8Hl"
Received: from [192.168.192.85] (unknown [50.47.147.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id A0D933F138;
	Mon,  4 Aug 2025 12:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1754309513;
	bh=n1PbwwU/H+BIVo5ReubkDTXD/mRW/H5M/0cObPfOgNE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type;
	b=VO3pk8HlA9JQ1oFacb/vqhodBO4SyI4/JsMog1fpN6nXE7jn53kY6VDz7KLjErMVd
	 Cltvs3tGu057OuCVSZZjSANpBAqQWVCdVqIg60a5L0ZysCFiKydqqrKDXr3P/DtZVH
	 fAEG5oVUxE1zIoGRbCXrxZKviZ2zmzMK7yIefuA8dI+W0gWXzZxsX+0wWkE+OaZqdP
	 1KRbn5sKhi99OMby3R0Aior8KcgGvISDCzPfyOdeYgTQe0+2KFlCsXaZAWrLDYZasK
	 gKQ6BK3Sfp54DhXlc9H9xeJt1eBM4xcBI32k0p4PWV3OYyqYHQQhagWewhXVzvrA6O
	 jmn1i6vV0TULg==
Message-ID: <8d0c22fd-330e-4c13-b9e3-32a927697667@canonical.com>
Date: Mon, 4 Aug 2025 05:11:50 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: John Johansen <john.johansen@canonical.com>
Subject: [GIT PULL] AppArmor updates for 6.17-rc1
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

There are a few patches at the top of this PR for issues fixes that
came in while I was out (I know poor timing) that I pulled in last
week after I returned. I have waited a few days for feedback and
verification on those patches beyond my own testing.

These patches have all been merge, build, and regression tested
against your tree as of yesterday. The majority of the code has had
months of testing, both in linux-next and the Ubuntu kernels, and
everything else, except the fixes I pulled in last week, has had weeks
of testing.

This PR has one major feature, it pulls in a cleaned up version of
af_unix mediation that Ubuntu has been carrying for years. It is
placed behind a new abi to ensure that it does cause policy
regressions. With pulling in the af_unix mediation there have been
cleanups and some refactoring of network socket mediation. This
accounts for the majority of the changes in the diff.

In addition there are a few improvements providing minor code
optimizations. several code cleanups, and bug fixes.

There is one Revert in the patchset for code that Eric decided he
would rather take through the crypto tree.


thanks
- john



The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

   Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/apparmor-pr-2025-08-04

for you to fetch changes up to 5f49c2d1f422c660c726ac5e0499c66c901633c2:

   apparmor: fix: oops when trying to free null ruleset (2025-08-04 01:14:56 -0700)

----------------------------------------------------------------
+ Features
   - improve debug printing
   - carry mediation check on label (optimization)
   - improve ability for compiler to optimize __begin_current_label_crit_section
   - transition for a linked list of rulesets to a vector of rulesets
   - don't hardcode profile signal, allow it to be set by policy
   - ability to mediate caps via the state machine instead of lut
   - Add Ubuntu af_unix mediation, put it behind new v9 abi

+ Cleanups
   - fix typos and spelling errors
   - cleanup kernel doc and code inconsistencies
   - remove redundant checks/code
   - remove unused variables
   - Use str_yes_no() helper function
   - mark tables static where appropriate
   - make all generated string array headers const char *const
   - refactor to doc semantics of file_perm checks
   - replace macro calls to network/socket fns with explicit calls
   - refactor/cleanup socket mediation code preparing for finer grained
     mediation of different network families
   - several updates to kernel doc comments

+ Bug fixes
   - apparmor: Fix incorrect profile->signal range check
   - idmap mount fixes
   - policy unpack unaligned access fixes
   - kfree_sensitive() where appropriate
   - fix oops when freeing policy
   - fix conflicting attachment resolution
   - fix exec table look-ups when stacking isn't first
   - fix exec auditing
   - mitigate userspace generating overly large xtables

----------------------------------------------------------------
Colin Ian King (1):
       apparmor: Fix incorrect profile->signal range check

Eric Biggers (1):
       apparmor: use SHA-256 library API instead of crypto_shash API

Gabriel Totev (2):
       apparmor: shift ouid when mediating hard links in userns
       apparmor: shift uid when mediating af_unix in userns

Helge Deller (2):
       apparmor: Fix 8-byte alignment for initial dfa blob streams
       apparmor: Fix unaligned memory accesses in KUnit test

Jiapeng Chong (3):
       apparmor: Modify mismatched function name
       apparmor: Modify mismatched function name
       apparmor: Remove the unused variable rules

John Johansen (34):
       apparmor: Improve debug print infrastructure
       apparmor: cleanup: attachment perm lookup to use lookup_perms()
       apparmor: remove redundant unconfined check.
       apparmor: switch signal mediation to use RULE_MEDIATES
       apparmor: ensure labels with more than one entry have correct flags
       apparmor: remove explicit restriction that unconfined cannot use change_hat
       apparmor: cleanup: refactor file_perm() to doc semantics of some checks
       apparmor: carry mediation check on label
       apparmor: add additional flags to extended permission.
       apparmor: add support for profiles to define the kill signal
       apparmor: fix x_table_lookup when stacking is not the first entry
       apparmor: add ability to mediate caps with policy state machine
       apparmor: remove af_select macro
       apparmor: lift kernel socket check out of critical section
       apparmor: in preparation for finer networking rules rework match_prot
       apparmor: add fine grained af_unix mediation
       apparmor: gate make fine grained unix mediation behind v9 abi
       apparmor: fix dbus permission queries to v9 ABI
       apparmor: make debug_values_table static
       apparmor: Document that label must be last member in struct aa_profile
       apparmor: mitigate parser generating large xtables
       Revert "apparmor: use SHA-256 library API instead of crypto_shash API"
       apparmor: update kernel doc comments for xxx_label_crit_section
       apparmor: Remove use of the double lock
       apparmor: fix af_unix auditing to include all address information
       apparmor: fix AA_DEBUG_LABEL()
       apparmor: fix regression in fs based unix sockets when using old abi
       apparmor: make sure unix socket labeling is correctly updated.
       apparmor: fix kernel doc warnings for kernel test robot
       apparmor: transition from a list of rules to a vector of rules
       apparmor: fix: accept2 being specifie even when permission table is presnt
       apparmor: fix test error: WARNING in apparmor_unix_stream_connect
       apparmor: fix Regression on linux-next (next-20250721)
       apparmor: fix: oops when trying to free null ruleset

Mateusz Guzik (2):
       apparmor: use the condition in AA_BUG_FMT even with debug disabled
       apparmor: make __begin_current_label_crit_section() indicate whether put is needed

Nathan Chancellor (2):
       apparmor: Fix checking address of an array in accum_label_info()
       apparmor: Remove unused variable 'sock' in __file_sock_perm()

Peng Jiang (1):
       apparmor: fix documentation mismatches in val_mask_to_str and socket functions

Randy Dunlap (1):
       apparmor: fix some kernel-doc issues in header files

Ryan Lee (8):
       apparmor: ensure WB_HISTORY_SIZE value is a power of 2
       apparmor: fix loop detection used in conflicting attachment resolution
       apparmor: make all generated string array headers const char *const
       apparmor: force audit on unconfined exec if info is set by find_attach
       apparmor: move the "conflicting profile attachments" infostr to a const declaration
       apparmor: include conflicting attachment info for confined ix/ux fallback
       apparmor: force auditing of conflicting attachment execs from confined
       apparmor: remove redundant perms.allow MAY_EXEC bitflag set

Tanya Agarwal (1):
       apparmor: fix typos and spelling errors

Thorsten Blum (1):
       apparmor: Use str_yes_no() helper function

Zilin Guan (1):
       security/apparmor: use kfree_sensitive() in unpack_secmark()

  security/apparmor/Makefile             |   6 +-
  security/apparmor/af_unix.c            | 799 +++++++++++++++++++++++++++++++++
  security/apparmor/apparmorfs.c         |  39 +-
  security/apparmor/audit.c              |   2 +-
  security/apparmor/capability.c         |  61 ++-
  security/apparmor/domain.c             | 203 ++++++---
  security/apparmor/file.c               |  92 ++--
  security/apparmor/include/af_unix.h    |  55 +++
  security/apparmor/include/apparmor.h   |   4 +-
  security/apparmor/include/audit.h      |   5 +-
  security/apparmor/include/capability.h |   1 +
  security/apparmor/include/cred.h       |  31 +-
  security/apparmor/include/file.h       |  11 +-
  security/apparmor/include/ipc.h        |   3 +
  security/apparmor/include/label.h      |  51 ++-
  security/apparmor/include/lib.h        |  46 +-
  security/apparmor/include/match.h      |  10 +-
  security/apparmor/include/net.h        |  38 +-
  security/apparmor/include/path.h       |   1 +
  security/apparmor/include/perms.h      |   8 +-
  security/apparmor/include/policy.h     |  59 ++-
  security/apparmor/include/sig_names.h  |   6 +-
  security/apparmor/include/signal.h     |  19 +
  security/apparmor/ipc.c                |  13 +-
  security/apparmor/label.c              |  37 +-
  security/apparmor/lib.c                | 114 +++++
  security/apparmor/lsm.c                | 468 +++++++++++++++----
  security/apparmor/match.c              |  23 +-
  security/apparmor/mount.c              |  12 +-
  security/apparmor/net.c                | 189 ++++++--
  security/apparmor/policy.c             |  93 ++--
  security/apparmor/policy_compat.c      |   6 +-
  security/apparmor/policy_ns.c          |   2 +-
  security/apparmor/policy_unpack.c      |  67 ++-
  security/apparmor/policy_unpack_test.c |   6 +-
  security/apparmor/procattr.c           |   6 +-
  security/apparmor/resource.c           |  11 +-
  security/apparmor/task.c               |  11 +-
  38 files changed, 2178 insertions(+), 430 deletions(-)
  create mode 100644 security/apparmor/af_unix.c
  create mode 100644 security/apparmor/include/af_unix.h
  create mode 100644 security/apparmor/include/signal.h

