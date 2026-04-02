Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [185.125.25.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B0436E484
	for <linux-security-module@vger.kernel.org>; Thu,  2 Apr 2026 19:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775157989; cv=none; b=ozQhqbW6QKvkdkEwa+drOc60oX/GtggLjgXppfPLb+2UjW3qrYma7T80zYdTa9a+bIzT4jo2ehS5c5IJ0Copus8hiZgOClZI2rCt5W6FttJicclhQU0BWnqEreoanlzV+AxG/q+wE0qAtuY2qNiOK/efOl3WaCgrI9hRoDcoF+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775157989; c=relaxed/simple;
	bh=3H5idt766ekoHJ8G9GMtlVpHxURof1i84sYO2Mfh/t8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gOuzUlz9BPKbE2zIZ0LBxcQ0yDPCzsXhzu+Cs4KMX3CbAFGB+XPDwXou/MBvOhbQ/RQN75CRvb15AiA59EeRlrjg7gLJBvJQt+T8N+QnnJgtr3vpljq0HVCyfZFNrFRsrZbZu+txhA9OkAwZS9ju4vp3Y5frc8aGhiqh6FNv+GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=YSBzwII8; arc=none smtp.client-ip=185.125.25.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="YSBzwII8"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fmsKS0wrBzZTj;
	Thu,  2 Apr 2026 21:26:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1775157980;
	bh=vIjBHSV18eXsjXywBHUzW7ZrxARXMolFNDxm0CDg/Do=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YSBzwII8Oq+/qNaaUjmWqiXQhlGPXTUs/qoN+AiYbg+NK/zDKJSrhIjdOwsxpODTC
	 oP4riS8OD19s4ENxnNcp42wIUHsAwznzQyBso6QFJiJrI+ak//wAjnkH3EYbO8bkQR
	 6Jt9MKhBVmRWx5q9O8CHftlYkH9AKc+QcyfVUvTU=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fmsKR4WMKzkqd;
	Thu,  2 Apr 2026 21:26:19 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>,
	Tingmao Wang <m@maowtm.org>,
	stable@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v3 5/5] selftests/landlock: Fix format warning for __u64 in net_test
Date: Thu,  2 Apr 2026 21:26:06 +0200
Message-ID: <20260402192608.1458252-6-mic@digikod.net>
In-Reply-To: <20260402192608.1458252-1-mic@digikod.net>
References: <20260402192608.1458252-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

On architectures where __u64 is unsigned long (e.g. powerpc64), using
%llx to format a __u64 triggers a -Wformat warning because %llx expects
unsigned long long.  Cast the argument to unsigned long long.

Cc: Günther Noack <gnoack@google.com>
Cc: stable@vger.kernel.org
Fixes: a549d055a22e ("selftests/landlock: Add network tests")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202604020206.62zgOTeP-lkp@intel.com/
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v2:
- New patch.
---
 tools/testing/selftests/landlock/net_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
index b34b139b3f89..4c528154ea92 100644
--- a/tools/testing/selftests/landlock/net_test.c
+++ b/tools/testing/selftests/landlock/net_test.c
@@ -1356,7 +1356,7 @@ TEST_F(mini, network_access_rights)
 					    &net_port, 0))
 		{
 			TH_LOG("Failed to add rule with access 0x%llx: %s",
-			       access, strerror(errno));
+			       (unsigned long long)access, strerror(errno));
 		}
 	}
 	EXPECT_EQ(0, close(ruleset_fd));
-- 
2.53.0

