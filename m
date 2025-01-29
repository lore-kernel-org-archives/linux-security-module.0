Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AF21E2847;
	Wed, 29 Jan 2025 20:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738183242; cv=none; b=ek2cRwJKJ65qMeTWShn4SPa23qIihKCn5gWepwV++3vtNbbtdaDnbmZ1SFcNE6uQwfaGUInGQMqk35IMn24fwNdl2wN1uzGW85zTmnHJEG02UEt8v1ihaBI4ovR6kZ0PjqrkvOSL3vJ+i4uiVfK1SABu8dmpfKVxP5pM4n1cxIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738183242; c=relaxed/simple;
	bh=TvUphb/vlGuqwwWD+ZxDY8HH0Mf2NGUG6U/J+wtc9zA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RMcCzcPpCO8FC4roTYxIThTyf1N+vECCxfHVijN53342qmH1Rk/87qddX7W/OjiU+Bwk0ZuEveOaMBYKd0Mtbeuj48Xl8G/rmkuLm0MhyDxLneRkLV4LB0EZGRIgDNTTDkaBpJAhujR3oAfVm4LnI8fSaNajSEo2F3MxyM4nFEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xd41c4UU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xd41c4UU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED86C4CEED;
	Wed, 29 Jan 2025 20:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738183239;
	bh=TvUphb/vlGuqwwWD+ZxDY8HH0Mf2NGUG6U/J+wtc9zA=;
	h=From:To:Cc:Subject:Date:From;
	b=Xd41c4UU4fyEfrNAqf6xoW7OKWID7moCyhMfXJfDPcaESFSvKp+E9+0KkfY7Eo3lc
	 ffz3Umx7wqSHwOzwftAS8vBX+xj8D7LUlJBTb2Hf1gQSUNYpE9PlAFXIzhRHN/4A0F
	 okVjeWVu6UdwrkqWwTZ21wRxZgn9u5mNAskzF6prH8HNTwUGK00cPE0hTH3RQDZcF/
	 6L7hMPSI65PyxHiq93BHe33XjP2ANtvtn6z0FQuXiyjlOqO16ST/I/cxRQwYyuWMso
	 jWftYOlkUfnWdfA3dgwvrbv5I3/uzSzIsAyVPI9Wtba6uj9TliyiyNr5SSsq0aLnIU
	 kTPFgH7LyEeDA==
From: wufan@kernel.org
To: corbet@lwn.net,
	jmorris@namei.org,
	paul@paul-moore.com,
	serge@hallyn.com,
	akpm@linux-foundation.org
Cc: linux-doc@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Fan Wu <wufan@kernel.org>
Subject: [RFC PATCH v2 0/2] ipe support for anonymous memory and memfd
Date: Wed, 29 Jan 2025 20:39:30 +0000
Message-Id: <20250129203932.22165-1-wufan@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Wu <wufan@kernel.org>

This patchset adds support for anonymous memory and memfd to the IPE LSM.
Currently, the IPE policy language can only allow or deny a physical file
from an integrity-verified source. However, for events triggered by
anonymous memory, either created via mmap() with MAP_ANONYMOUS or via
memfd_create(), IPE provides no mechanism to explicitly allow or deny
these events.

Execution from anonymous memory is a common use case in modern
applications. For example, JIT compilers store generated code in such
regions. This patchset introduces a new IPE property, anonymous_memory,
to let administrators explicitly allow or deny events triggered by
anonymous memory.

For example, the following policy:

  policy_name=example_policy policy_version=0.0.0
  DEFAULT action=DENY

  op=EXECUTE dmverity_signature=TRUE action=ALLOW
  op=EXECUTE anonymous_memory=TRUE action=ALLOW

will allow execution of files from a signed dm-verity volume and also
execution from anonymous memory.

In the current design, the anonymous_memory property covers both
memory regions created by mmap() with MAP_ANONYMOUS and those
allocated by memfd_create(), as both share the same semantics [1].
However, because regular files on tmpfs, shmemfs, or hugetlbfs are
also backed by anonymous memory, the policy language might not be
entirely clear to users. An alternative approach would be to define
two separate properties, one covering MAP_ANONYMOUS and another
covering memfd_create().

Nonetheless, allowing execution from anonymous memory does increase
the attack surface. Future work will add additional properties to
the IPE policy language to provide more fine-grained control.
For instance, one possibility is to permit only processes with certain
security attributes, such as specific SELinux labels, to execute code
from anonymous memory.

The ipe test suite has been updated to include anonymous memory tests:
https://github.com/microsoft/ipe/tree/test-suite

[1] https://man7.org/linux/man-pages/man2/memfd_create.2.html

Previous Postings
-----------------
v1: https://lore.kernel.org/all/66922c42-c3a2-4634-a8f0-4c8c2b4c051a@kernel.org/T/

Changelog
---------

V2:
  * Update test suite to include anonymous memory tests
  * Fix property implementation and add memfd support

Fan Wu (2):
  memfd,lsm: add a security hook to memfd_create()
  ipe: add 'anonymous_memory' property for policy decisions

 Documentation/admin-guide/LSM/ipe.rst | 12 ++++++++++
 Documentation/security/ipe.rst        |  9 +++----
 include/linux/lsm_hook_defs.h         |  3 +++
 include/linux/security.h              |  8 +++++++
 mm/memfd.c                            |  2 ++
 security/ipe/Kconfig                  | 10 ++++++++
 security/ipe/audit.c                  |  2 ++
 security/ipe/eval.c                   | 34 +++++++++++++++++++++++----
 security/ipe/eval.h                   | 13 ++++++----
 security/ipe/hooks.c                  | 12 ++++++++++
 security/ipe/hooks.h                  |  4 ++++
 security/ipe/ipe.c                    |  7 ++++--
 security/ipe/policy.h                 |  2 ++
 security/ipe/policy_parser.c          |  4 ++++
 security/security.c                   | 11 +++++++++
 15 files changed, 119 insertions(+), 14 deletions(-)

-- 
2.47.1

