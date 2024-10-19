Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19212A1DC;
	Sat, 19 Oct 2024 15:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.41.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729350981; cv=none; b=Y0mHdqEBleqkbcsvWQAGKQpopN09DVEbrS0I28dFfO66u7cfwhk9dFfecm5RArBTuOvj7k3YzEwwxtj0jH0BN2OsAcc+b1vyzMeTaKOuPBFW5PDDX6bn4mXF+SYWvl2KCBqfS6pEGt+vR1cJmWQb0Xx2AUBgdSGJioCJTf9jVa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729350981; c=relaxed/simple;
	bh=pb5BOcbIw+1C1GTdxWqkBm/vZQtpW4RtR+DB6pQVSpw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oI4TB5Dm96g0pffWqf9PI0gWkka6LnHFKfcB9iQIvIqGkjsTvnnIZKqAneIrD0GWZJMTcMPb5vNB/CqYG07WC7yqNnHgP+g44HR8GmF73VBdoDVBYTHwheEBCXbJL8OWSUKA3pUBiPxWn/xkPVl4MTLRwpWrIvA26o7iEcBIh6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=CP/nvToJ; arc=none smtp.client-ip=51.83.41.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buffet.re
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b="CP/nvToJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1729350972; bh=pb5BOcbIw+1C1GTdxWqkBm/vZQtpW4RtR+DB6pQVSpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CP/nvToJ/wCqnnvAbjydjgKVpPMeYVBCPXYbygwdPLKD5KX/l+b8fH3lBhdVBs1TR
	 rX3yGOeiRLsxzJJywoB/+lKaskYmLogL1eNxlahoL5GDasUzTGqqj8pvUSmh5ZjRm4
	 QGuXN5wW8O8M5JA1RCD3JvVrsNsFj11CNpFkIEhWdNllDNJt5at5H6NmSOuNC4FnSU
	 SESVj4VyVqcRkGWBxV+8CHB2NsVYbx9FuSmc5WY/JXi8R5fqrEnEzjTmhef9Y8pZZ4
	 UYbR5E4/yvRm6nEGCIFfrpjBRfOUkr8wIzx/xt2rm5OlRZFx9dPLBN0nmWUnPotL8U
	 jqe0EFze04GqQ==
Received: from localhost.localdomain (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPA id B7112123074;
	Sat, 19 Oct 2024 17:16:12 +0200 (CEST)
From: Matthieu Buffet <matthieu@buffet.re>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matthieu Buffet <matthieu@buffet.re>,
	Tahera Fahimi <fahimitahera@gmail.com>
Subject: [PATCH v3 3/3] samples/landlock: Clarify option parsing behaviour
Date: Sat, 19 Oct 2024 17:15:34 +0200
Message-Id: <20241019151534.1400605-4-matthieu@buffet.re>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241019151534.1400605-1-matthieu@buffet.re>
References: <20241019151534.1400605-1-matthieu@buffet.re>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clarify the distinction between filesystem variables (mandatory)
and all others (optional).
For optional variables, explain the difference between unset variables
(no access check performed) and empty variables (nothing allowed for
lists of allowed paths/ports, or no effect for lists of scopes).
List LL_SCOPED values understood and their effect.

Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
---
 samples/landlock/sandboxer.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index 38fc6ebd7222..96b451cf0531 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -296,23 +296,24 @@ static bool check_ruleset_scope(const char *const env_var,
 /* clang-format off */
 
 static const char help[] =
-	"usage: "
-	ENV_FS_RO_NAME "=\"...\" "
-	ENV_FS_RW_NAME "=\"...\" "
-	ENV_TCP_BIND_NAME "=\"...\" "
-	ENV_TCP_CONNECT_NAME "=\"...\" "
-	ENV_SCOPED_NAME "=\"...\" %1$s <cmd> [args]...\n"
+	"usage: " ENV_FS_RO_NAME "=\"...\" " ENV_FS_RW_NAME "=\"...\" "
+	"[other environment variables] %1$s <cmd> [args]...\n"
 	"\n"
-	"Execute a command in a restricted environment.\n"
+	"Execute the given command in a restricted environment.\n"
+	"Multi-valued settings (lists of ports, paths, scopes) are colon-delimited.\n"
 	"\n"
-	"Environment variables containing paths and ports each separated by a colon:\n"
-	"* " ENV_FS_RO_NAME ": list of paths allowed to be used in a read-only way\n"
-	"* " ENV_FS_RW_NAME ": list of paths allowed to be used in a read-write way\n"
+	"Mandatory settings:\n"
+	"* " ENV_FS_RO_NAME ": paths allowed to be used in a read-only way\n"
+	"* " ENV_FS_RW_NAME ": paths allowed to be used in a read-write way\n"
 	"\n"
-	"Environment variables containing ports are optional and could be skipped.\n"
-	"* " ENV_TCP_BIND_NAME ": list of ports allowed to bind (server)\n"
-	"* " ENV_TCP_CONNECT_NAME ": list of ports allowed to connect (client)\n"
-	"* " ENV_SCOPED_NAME ": list of scoped IPCs\n"
+	"Optional settings (when not set, their associated access check "
+	"is always allowed, which is different from an empty string which "
+	"means an empty list)\n"
+	"* " ENV_TCP_BIND_NAME ": ports allowed to bind (server)\n"
+	"* " ENV_TCP_CONNECT_NAME ": ports allowed to connect (client)\n"
+	"* " ENV_SCOPED_NAME ": actions denied on the outside of the landlock domain\n"
+	"  - \"a\" to restrict opening abstract unix sockets\n"
+	"  - \"s\" to restrict sending signals\n"
 	"\n"
 	"Example:\n"
 	ENV_FS_RO_NAME "=\"${PATH}:/lib:/usr:/proc:/etc:/dev/urandom\" "
-- 
2.39.5

