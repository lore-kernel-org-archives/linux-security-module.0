Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch [83.166.143.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08A1145356
	for <linux-security-module@vger.kernel.org>; Fri, 19 Jul 2024 15:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721401615; cv=none; b=awzO72jiq0/x1uPjwf2ZniZmH9e/YZQ+LoXwLee3kGCMuJOI/JHRNpSYrVFO+1zZfagC/aZwZgIm8D9LLzWRdHPTMJgA6kvv5sEyhTsVE7/dsmJjrD3+ERk4qzyVeXZ23pvepTL1ZrS1BTsQOdjn8d874w8vOBXCmO/FEmGMnvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721401615; c=relaxed/simple;
	bh=R8UECAoOpn6Z9VyU8XWdVP4VJVlOGQ/d9Y7jGVbdA50=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p+M/EZRssVykXuX8/0aC/IK7d4xYU2buWAXLLEcJy/PXP+qftxkuR8pAsVJw19K+gpGJN7/kBUNhXX1AMs7RCSEXm6B+i+6Unyn5UcAQkKkj/dlC+AzRC3YwhUGK3+P34VPhNa9Bkky/o8GS/7pU8/l33VAw+zRw3MPR4pfx7Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=R1vGEDai; arc=none smtp.client-ip=83.166.143.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="R1vGEDai"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WQY102ql7zYG1;
	Fri, 19 Jul 2024 17:06:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1721401604;
	bh=MlvNcRdaWPCv4piayBnreztb2E0SfctcFZFdov4MJHM=;
	h=From:To:Cc:Subject:Date:From;
	b=R1vGEDaiOLE+63hKxA8+FlULKos0AYSaDhRQj6FydQIyKTFheCvHucyRs4jdV/EtN
	 c93xAKYjB8auzzIyfshrfNrsyktxu4QKufpY2Fd77crcH/PRFi/vFCB17VQesgJULV
	 qTvJNn4IHrP8P4kILn5By5R9HM8lyxgPpJwHFeAU=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4WQY0z2nrYzxKb;
	Fri, 19 Jul 2024 17:06:43 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Paul Moore <paul@paul-moore.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Jeff Xu <jeffxu@google.com>,
	Kees Cook <keescook@chromium.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Shervin Oloumi <enlightened@chromium.org>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [RFC PATCH v1 0/3] Use socket's Landlock domain
Date: Fri, 19 Jul 2024 17:06:15 +0200
Message-ID: <20240719150618.197991-1-mic@digikod.net>
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

While the current approach works, I think we should change the way
Landlock restricts network actions.  Because this feature is relatively
new, we can still fix this inconsistency.  In a nutshell, let's follow a
more capability-based model.  Please let me know what you think.

Regards,

Mickaël Salaün (3):
  landlock: Use socket's domain instead of current's domain
  selftests/landlock: Add test for socket's domain
  landlock: Document network restrictions tied to sockets

 Documentation/userspace-api/landlock.rst    |  4 ++-
 security/landlock/net.c                     | 22 ++++++++--------
 tools/testing/selftests/landlock/net_test.c | 29 +++++++++++++++++++++
 3 files changed, 43 insertions(+), 12 deletions(-)


base-commit: f4b89d8ce5a835afa51404977ee7e3889c2b9722
-- 
2.45.2

