Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB45723A9AE;
	Sat, 31 May 2025 15:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748704106; cv=none; b=c2LRj2Lssd2kRExSlPUR1Ke7/HHOSKrOVFq5JFI5CceYe4RusRGT4iy8CmjEaDdbQQR1hmQwLc3fEMmcaF3Ves3JodRiDb74Ljct8ino2fx5tRQi5ZSBQhR4Di7xhH8OCuVgmYI4oLvUw2lNDPBQXfmF20bCslAejdaD+vrrtsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748704106; c=relaxed/simple;
	bh=8dEJQ3ur5tpd16Psc/n5nL0w2GV8FT1cgYwb/BiBv8I=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XMw0/+Pg7Uib/krLMvXlZburLLaeyqhR/JI9LjoK/H7qC0AInj7tAiv08QPSZKHMrTJ3eFvWyvWmAu7COeTMNAe5vm/85oJMAonQ/kKxXFQGHnrjQUxm1hE2DLCVhK8QIdCik0olQU5Emj3F01FJtspWf0L1VpKBMW5Tt1OftmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9CCeHPv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9CCeHPv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C2FC4CEEE;
	Sat, 31 May 2025 15:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748704106;
	bh=8dEJQ3ur5tpd16Psc/n5nL0w2GV8FT1cgYwb/BiBv8I=;
	h=From:To:Cc:Subject:Date:From;
	b=G9CCeHPvgf6PD9x4QasuV24wtiyzQ4Ql8VMFuKVh1mXGyiDUHZomUA7+QTPTkY671
	 O0TknkaYQ5DOWtU33uR4UiYxvkFfjeEFr0HCJl0ykAHAK473ObcdQHSSjtO0MRQucQ
	 J//dzXJpfET99MRXqsqljJPyVWMqO92U0ExFelOR9wAmXAaHWb8qVaXQneGxzTl/Zh
	 0meuz95VxGwmbZAW46qv1n7iBC/EpULkMjl91/b01cCj1a8EwuT0U4PwCow6w4dHyo
	 KpuCdnBi34aWYkUWvyxR9UR9y9V2HWlygLeQlCeMVPbVNvJGqPG0EV64iSi9OgTi9G
	 ZkV30zagOqHFg==
From: deller@kernel.org
To: linux-kernel@vger.kernel.org,
	apparmor@lists.ubuntu.com,
	John Johansen <john.johansen@canonical.com>,
	linux-security-module@vger.kernel.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PATCH 0/2] apparmor unaligned memory fixes
Date: Sat, 31 May 2025 17:08:20 +0200
Message-ID: <20250531150822.135803-1-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Helge Deller <deller@gmx.de>

Two patches which fix unaligned memory accesses in apparmor.
Both triggered on the parisc platform, which is much more
memory alignment sensitive and will report violations.
Please check and apply.

Helge

Helge Deller (2):
  apparmor: Fix 8-byte alignment for initial dfa blob streams
  apparmor: Fix unaligned memory accesses in KUnit test

 security/apparmor/lsm.c                | 4 ++--
 security/apparmor/policy_unpack_test.c | 6 ++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

-- 
2.47.0

