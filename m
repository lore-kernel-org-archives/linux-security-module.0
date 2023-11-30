Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="rNb/vexk"
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [IPv6:2001:1600:3:17::8fa9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC5F10CE
	for <linux-security-module@vger.kernel.org>; Thu, 30 Nov 2023 01:36:25 -0800 (PST)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
	by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Sgrfv6fSJzMqYbR;
	Thu, 30 Nov 2023 09:36:23 +0000 (UTC)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Sgrft6yFgzMppB4;
	Thu, 30 Nov 2023 10:36:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1701336983;
	bh=FNSiMlXD3wG3kFp+RuKTFCVYl/aDD6rN7s4DIUdQYkk=;
	h=From:To:Cc:Subject:Date:From;
	b=rNb/vexkhW0qtbfiv61vmos86MGas1MCYHrIxPgzYmHrTfVV/k3sXVEciA2Udh8PP
	 /kn/xeaIN4cw6t1C7YcwdZ9X9lMhTuDx//9uddMT0xxvctpj5F/5xkRJCKNCthF2Zz
	 Pudn3kEJS3G3nrU5Se9x4j9hNkXgtuNPrgZU6uhw=
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	James Morris <jmorris@namei.org>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v2 0/2] Extend Landlock test to improve rule's coverage
Date: Thu, 30 Nov 2023 10:36:14 +0100
Message-ID: <20231130093616.67340-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Hi,

These are new tests to give more backward compatibility guarantees about
rule's access rights. This might be useful for changes happening in the
access right handling, especially with synthetic access rights:
https://lore.kernel.org/r/20231117154920.1706371-3-gnoack@google.com

Previous version:
v1: https://lore.kernel.org/r/20231120193914.441117-1-mic@digikod.net

Regards,

Mickaël Salaün (2):
  selftests/landlock: Add tests to check unknown rule's access rights
  selftests/landlock: Add tests to check unhandled rule's access rights

 tools/testing/selftests/landlock/fs_test.c  | 63 ++++++++++++++++++++-
 tools/testing/selftests/landlock/net_test.c | 59 ++++++++++++++++++-
 2 files changed, 120 insertions(+), 2 deletions(-)


base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
-- 
2.42.1

