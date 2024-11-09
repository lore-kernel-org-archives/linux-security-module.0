Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch [84.16.66.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B2B19D08A
	for <linux-security-module@vger.kernel.org>; Sat,  9 Nov 2024 19:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731181336; cv=none; b=MLXigePDvu33HkLRpHvKLCTqOH+D+gyfjAsry4V3/doCLZvVVuXYeeYeZeA8OzMcrf0FuKJhhENRsvCbwgXolhJR5RciCTY3G1VpfnN5kRLrZ4r5m3wQVv3fC54wW5fX/V/rEqt963e0Tj1kSE5LrFGgfvGooKsEy9OUzl/RYuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731181336; c=relaxed/simple;
	bh=fLOhlaTrXG4EMH1PGvriK2F2h3RRWAAOp3UXm8RUdao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TuuhUJSgMhp9zv8hL3k4I0JmwZObfd6L6kfUHv2HfN/DW4GlJy21E8GHYOwwoyo7CLYXMF+/tarn2xD75E6bT5gvdnHhPG3mKzsftJyBKNfo0R1MDbsb4nPDYD2ZaSqSZ8PXSpe7bfVI8ASIpZOubjv5ikqxXKbl58hTkq2q8GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=0slas6hB; arc=none smtp.client-ip=84.16.66.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="0slas6hB"
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:0])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Xm5md0LbPzmsS;
	Sat,  9 Nov 2024 20:42:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1731181328;
	bh=7pfdGTRS9sfvT/2G9zRAJXChDRiw3/bm3WH+RwaBZ2Q=;
	h=From:To:Cc:Subject:Date:From;
	b=0slas6hBmFO5Q8RZPJDXVCuQfDJsJn/GLL3RAUo9vmC5dWt5Z27+FVew1THmAH31e
	 jvCpYZr2rwVwqR1fQUz62BrErDY7sLsbKMT3N+QL5d2MrimR0ThFRSZyhzqjZufShn
	 tYig+cOt/fKBI1ogJSUhKF3huJ2L2vDpMgJX5gSc=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Xm5mc0kq9zDXh;
	Sat,  9 Nov 2024 20:42:07 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Daniel Burgener <dburgener@linux.microsoft.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [GIT PULL] Landlock fix for v6.12-rc7
Date: Sat,  9 Nov 2024 20:41:58 +0100
Message-ID: <20241109194158.422529-1-mic@digikod.net>
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

This PR fixes issues in the Landlock's sandboxer sample and documentation,
slightly refactors helpers (required for ongoing patch series), and improve/fix
a feature merged in v6.12 (signal and abstract UNIX socket scoping).

Please pull these changes for v6.12-rc7 (or rc8, if any).  These commits merge
cleanly with your master branch.  The kernel code has been tested in the latest
linux-next releases for a few weeks, but I updated the last three patches with
cosmetic changes according to reviews.

Test coverage for security/landlock is 92.5% of 1129 lines according to
gcc/gcov-14, and it was 92.8% of 1134 lines before this PR.

Regards,
 Mickaël

--
The following changes since commit 03197e40a22c2641a1f9d1744418cd29f4954b83:

  landlock: Optimize scope enforcement (2024-11-09 19:52:13 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.12-rc7

for you to fetch changes up to 03197e40a22c2641a1f9d1744418cd29f4954b83:

  landlock: Optimize scope enforcement (2024-11-09 19:52:13 +0100)

----------------------------------------------------------------
Landlock fix for v6.12-rc7

----------------------------------------------------------------
