Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB9C2AEEE;
	Sat, 19 Oct 2024 15:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.41.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729350834; cv=none; b=VbBwCDwUoA8dd3mSQOuQwtEyRJ5cagEsJglzhTLimvM8U3cWCHjyHRh1PWWOzq4E9FtzKeRQ0ebxyu4G7dr4inVB2+ifHUKxu1AnZetONwa1jqFEUylq3gbgVbvO8jNzS6wGLxvwzfz+zT5fg8bargkaBqCrZPxS8qicr1qE8MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729350834; c=relaxed/simple;
	bh=4g/l5/DUumFJXyC6AD/7bEovrNUuiBGb+XSeIo4/sZA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=oeArIBZpYSK+bRoWuTQFxpDWQ4Ge2pVhwXxZkS//hx97X6wdrgpE2Gi73kNjrhAK5EOSHS7IdI2nqtQi9pszH3aePKZ2CwQNpLmx2xxlAq7WQ94B3CVjeS2AYrqNJHLWrKwDxzwTZyH3FpT+Lr0GLGmtkKGudq6rRnGumq5EppA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=aKw1FRBw; arc=none smtp.client-ip=51.83.41.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buffet.re
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b="aKw1FRBw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1729350816; bh=4g/l5/DUumFJXyC6AD/7bEovrNUuiBGb+XSeIo4/sZA=;
	h=From:To:Cc:Subject:Date:From;
	b=aKw1FRBwNtlYznYwa40NOTpNdK5BzXomiuwZCK4cvCZvFyfndxDQa6d9X3PDsxjs6
	 efRR2YK0lwTjyJB2Z9A574cLg5YaFTTLvaYQI9ZcGFkT5XY3QDncbNYzetYfrfLQUe
	 Dpo7Uj9Sb3NaeR/poUXDgaVJ4KPyc4d59XSyFPL9apFZMqAX7/AvTXPLOuHnwJ8NKk
	 MMpq3EzuSC+H92L1m3EL0iZz9+/3nMhUBhoCCwrjBaK9pOfIycV4nhZ9AhKnj/3siL
	 h2g8Z7aTm9DLNV+NF4sU/wcwt5fJymFYj54LrwG+NVBeK6XSYMV0gkWEJZ5uQCO3tN
	 MSQ9+IUuJEUAQ==
Received: from localhost.localdomain (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPA id B5DA4123074;
	Sat, 19 Oct 2024 17:13:36 +0200 (CEST)
From: Matthieu Buffet <matthieu@buffet.re>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matthieu Buffet <matthieu@buffet.re>,
	Tahera Fahimi <fahimitahera@gmail.com>
Subject: [PATCH v3 0/3] samples/landlock: Fix port parsing in sandboxer
Date: Sat, 19 Oct 2024 17:15:31 +0200
Message-Id: <20241019151534.1400605-1-matthieu@buffet.re>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mickaël, Mikhail,

This v3 should have all your comments merged, thank your for your time
reviewing this.

Changes since v2:
- replaced help message with a static format string
- added possible LL_SCOPED values and their effect (also for easier
  understanding of expected environment variables, cc: Tahera)
- rebased on mic-linux/next

v2:
Link: https://lore.kernel.org/all/20241003005042.258991-1-matthieu@buffet.re/

Matthieu Buffet (3):
  samples/landlock: Fix port parsing in sandboxer
  samples/landlock: Refactor help message
  samples/landlock: Clarify option parsing behaviour

 samples/landlock/sandboxer.c | 112 +++++++++++++++++++++--------------
 1 file changed, 69 insertions(+), 43 deletions(-)


base-commit: fe76bd133024aaef12d12a7d58fa3e8d138d3bf3
-- 
2.39.5

