Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [84.16.66.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD174145A1A
	for <linux-security-module@vger.kernel.org>; Fri, 19 Jul 2024 15:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721401618; cv=none; b=RM68FSz+FvS9TX2kh/vwZEnMUQpEUSmz3PvIgbdUykCubVUYxRWWBPP93D7frr7ZGNX6gWowjmxS2moF2ZHa/vsFVAmSNofPZbf/7nhWl35wTOnqPpg11Z9b8pPsl6uVQJxcl86wobFaDvwzG733kCziv1Hr2BupR9JKE7likc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721401618; c=relaxed/simple;
	bh=1VRgN9E20Mz0E1cuuygk/Vt16CkssBzZL4IMwdHn5A8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RJabUHUtA3xgWIYSYsMTeoQMwereyUsQNxaPU26DI1+7ilEvhuzXUveSgvJpVkPBON2J5Q310wXahaeg2nYMPJdx1XhDX9rJ1PupkuubOReXhofoWDThnWMwz5q6/yhfkkqSWBSiGCqD5gWaEvqylGZrHEuOoEZ7izQZYxGK9ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=zZl6K+7K; arc=none smtp.client-ip=84.16.66.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="zZl6K+7K"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WQY132qxMzcBS;
	Fri, 19 Jul 2024 17:06:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1721401607;
	bh=OBPsO/SKaEeE/YlM+it8OhWEccms0c50naVM5DXA5DM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zZl6K+7KhAbi7bYpDROj72Z4n5CgbrmipVkvzgc99i6WI8wepLoaj7q4hywJa494g
	 KAM8GT55IEH4ZTwDLJe1cqODQ0Nzt+HRzalIKzn1xbQhq2k0s2HoT6H6pWxSLVbV77
	 Z7E1pqLCdCPFCaZS+mUZ4S3Fs1D7cvlIKCJvo350=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4WQY126cp3ztZT;
	Fri, 19 Jul 2024 17:06:46 +0200 (CEST)
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
Subject: [RFC PATCH v1 3/3] landlock: Document network restrictions tied to sockets
Date: Fri, 19 Jul 2024 17:06:18 +0200
Message-ID: <20240719150618.197991-4-mic@digikod.net>
In-Reply-To: <20240719150618.197991-1-mic@digikod.net>
References: <20240719150618.197991-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

The Landlock domain used to restrict operations on a socket is the
domain from the thread that created this socket.

Cc: Günther Noack <gnoack@google.com>
Cc: Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>
Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Tahera Fahimi <fahimitahera@gmail.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20240719150618.197991-4-mic@digikod.net
---
 Documentation/userspace-api/landlock.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index 37dafce8038b..4a9bfff575d5 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -529,7 +529,9 @@ Network support (ABI < 4)
 Starting with the Landlock ABI version 4, it is now possible to restrict TCP
 bind and connect actions to only a set of allowed ports thanks to the new
 ``LANDLOCK_ACCESS_NET_BIND_TCP`` and ``LANDLOCK_ACCESS_NET_CONNECT_TCP``
-access rights.
+access rights.  These restrictions are tied to a socket and are inherited from
+the sandboxed thread that created this socket.  Hence, sockets created before
+sandboxing are not restricted.
 
 IOCTL (ABI < 5)
 ---------------
-- 
2.45.2

