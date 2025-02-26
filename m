Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [45.157.188.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20455223329
	for <linux-security-module@vger.kernel.org>; Wed, 26 Feb 2025 16:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740587569; cv=none; b=nSLLwRJxfCyr4gYl/Ig/KZmvk77cFo5O5Z+JYBygHmN8QiNEa8otgkkCZCbOAyRkaldJdT8WhKc0L3dQ/J2DvCzq7S2TrvD3wok6RJx7i1rY6aq2WJfgtOf3970qiWt+VagNZOZcxt+I+rzyuzr7b/z6pcslzqBY99u7/e6uVsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740587569; c=relaxed/simple;
	bh=ftTCfTSEUWyG3MqWCjadumYHTH3fXvyAmNWMFNbVE8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T32InanSkcTqS5BRBglBWFXCWF69i3dFk9Zihsu0d8yXYtFfqJ9vB1oGjayWLI9LAtTusZz3FOCVUqiapg40AKhpeNEpI9voZYPEesyDElWOTS0w0MLy1o9s9Oaipe+0V9wrZvhAwOBUrWVwIwtz54CSmTmMuCAdK7klDnytP58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=MJJlcq0r; arc=none smtp.client-ip=45.157.188.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="MJJlcq0r"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Z30PZ5fYSzPcg;
	Wed, 26 Feb 2025 17:32:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1740587554;
	bh=v9sNy219I6ybcJlLUZTXEhfNT5QcZgghqKh9iitcV7Y=;
	h=From:To:Cc:Subject:Date:From;
	b=MJJlcq0rYB41m1+MVWtpUNKeTaU5rIcRj4YaOepZwzqttFTTfGkG0wvbYvmvX4nnK
	 YffNb9hahywU3XpEKnm+BdUwMxPpVbCbYG/15L/wDfaSZLHaoaTrHziMDxmYwymyA5
	 9Apwn9qp6jcKVXRHOHnfwNSry5siS5UkwSKkbMAc=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Z30PZ1yFHzqRP;
	Wed, 26 Feb 2025 17:32:34 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Bharadwaj Raju <bharadwaj.raju777@gmail.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Tanya Agarwal <tanyaagarwal25699@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [GIT PULL] Landlock fix for v6.14-rc5
Date: Wed, 26 Feb 2025 17:32:29 +0100
Message-ID: <20250226163229.2132331-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Hi Linus,

This PR fixes TCP socket identification, documentation, and tests.

Please pull these changes for v6.14-rc5 .  These commits merge cleanly with
your master branch.  The kernel code has been tested in the latest linux-next
releases for two weeks and rebased to update commit messages.

Test coverage for security/landlock is 92.8% of 1035 lines according to
gcc/gcov-14, and it was the same before this PR.

Regards,
 Mickaël

--
The following changes since commit a64dcfb451e254085a7daee5fe51bf22959d52d3:

  Linux 6.14-rc2 (2025-02-09 12:45:03 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.14-rc5

for you to fetch changes up to 78332fdb956f18accfbca5993b10c5ed69f00a2c:

  selftests/landlock: Add binaries to .gitignore (2025-02-14 09:23:11 +0100)

----------------------------------------------------------------
Landlock fix for v6.14-rc5

----------------------------------------------------------------
Bharadwaj Raju (1):
      selftests/landlock: Add binaries to .gitignore

Günther Noack (1):
      landlock: Minor typo and grammar fixes in IPC scoping documentation

Mickaël Salaün (1):
      selftests/landlock: Enable the new CONFIG_AF_UNIX_OOB

Mikhail Ivanov (3):
      landlock: Fix non-TCP sockets restriction
      selftests/landlock: Test TCP accesses with protocol=IPPROTO_TCP
      selftests/landlock: Test that MPTCP actions are not restricted

Tanya Agarwal (1):
      landlock: Fix grammar error

 Documentation/userspace-api/landlock.rst    |   6 +-
 include/uapi/linux/landlock.h               |   8 +-
 security/landlock/net.c                     |   3 +-
 security/landlock/ruleset.c                 |   2 +-
 tools/testing/selftests/landlock/.gitignore |   2 +
 tools/testing/selftests/landlock/common.h   |   1 +
 tools/testing/selftests/landlock/config     |   3 +
 tools/testing/selftests/landlock/net_test.c | 124 ++++++++++++++++++++++++----
 8 files changed, 127 insertions(+), 22 deletions(-)
