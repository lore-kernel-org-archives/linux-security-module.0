Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BFADDAB;
	Thu,  3 Oct 2024 00:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.41.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727916630; cv=none; b=mcIt4QY6MumQtbr/GevXHhyEiTmzKKTEKLWGkkxcyIKH8q+JrIeC31iuQDbCbFSvUspe205fEWy80Hs7GVG555PbQePMHYYRdNEw1Ro9oIIAmuStFiJZ52gIV+ysL8IRhagDn5KulberSaIMZVILfZ9tAeSERs7NrppYeL6uj2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727916630; c=relaxed/simple;
	bh=SFt8Izw3k9oW8PRPnRr3j1kF25WKNW3bL1ymvtdIDvw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ai8d+AJ1zn3b60qpzo+yTAUkbW/Hf2HfagMpIk7belGk4I0M/SSbFs+FUtY8i9P3AC5CO1a5WsdxGqh0w+vZ19zNMVcW47vyNG5VsOxT0vnRmESUEqUKvsLg4vfRO0K8TXGXK5xEE/SRzeI9KR7SU5h38yWG01HZbyPF4bBbXrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=haQ4uImw; arc=none smtp.client-ip=51.83.41.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buffet.re
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b="haQ4uImw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1727916620; bh=SFt8Izw3k9oW8PRPnRr3j1kF25WKNW3bL1ymvtdIDvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=haQ4uImwh1ZMug4jCAxX2a/Kjn/JJ/a4K6uNldjeF3wkgO7OBFvtcQN76BlTZQa2L
	 4vNbGt8CNdeCoXC4RQ0Uri9dT3BxxhMuzE2fCTwmfluD0y+yALCC+bKzT02RWumCyq
	 xUlOdGfsvzjeU3HZ5C4lKdKjjYyJGtWHtE6ZKvnctFMKNCZs07GNGpou/RPtYtYXol
	 4JmX6v3rVh70RcJieBEFz+FL77M61/y8m9s+pOjl7hXt+8yDx6dOEYNlb6K9J0VPN8
	 sZsKZTZmHVwqrobwTCK8goUY5kiaBfFsrU1mF7W5Pheg5bhPiCAKSGYFlC6S+0un5C
	 YzfQlsvCgtetA==
Received: from localhost.localdomain (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPA id 9525D1230C1;
	Thu,  3 Oct 2024 02:50:20 +0200 (CEST)
From: Matthieu Buffet <matthieu@buffet.re>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matthieu Buffet <matthieu@buffet.re>
Subject: [PATCH v2 3/3] samples/landlock: Clarify option parsing behaviour
Date: Thu,  3 Oct 2024 02:50:42 +0200
Message-Id: <20241003005042.258991-3-matthieu@buffet.re>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241003005042.258991-1-matthieu@buffet.re>
References: <20241003005042.258991-1-matthieu@buffet.re>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Clarify which environment variables are optional, which ones are
  mandatory
- Clarify the difference between unset variables and empty ones

Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
---
 samples/landlock/sandboxer.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index f16994d35d9e..a28e4a9c5f87 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -298,24 +298,27 @@ static bool check_ruleset_scope(const char *const env_var,
 static void print_help(const char *argv0)
 {
 	fprintf(stderr,
-		"usage: %s=\"...\" %s=\"...\" %s=\"...\" %s=\"...\" %s=\"...\" %s "
+		"usage: %s=\"...\" %s=\"...\" [other environment variables] %s "
 		"<cmd> [args]...\n\n",
-		ENV_FS_RO_NAME, ENV_FS_RW_NAME, ENV_TCP_BIND_NAME,
-		ENV_TCP_CONNECT_NAME, ENV_SCOPED_NAME, argv0);
+		ENV_FS_RO_NAME, ENV_FS_RW_NAME, argv0);
 	fprintf(stderr,
 		"Execute a command in a restricted environment.\n\n");
 	fprintf(stderr,
-		"Environment variables containing paths and ports "
-		"each separated by a colon:\n");
+		"All environment variables can be multi-valued, with a "
+		"colon delimiter.\n"
+		"\n"
+		"Mandatory settings:\n");
 	fprintf(stderr,
 		"* %s: list of paths allowed to be used in a read-only way.\n",
 		ENV_FS_RO_NAME);
 	fprintf(stderr,
-		"* %s: list of paths allowed to be used in a read-write way.\n\n",
+		"* %s: list of paths allowed to be used in a read-write way.\n",
 		ENV_FS_RW_NAME);
 	fprintf(stderr,
-		"Environment variables containing ports are optional "
-		"and could be skipped.\n");
+		"\n"
+		"Optional settings (when not set, their associated access "
+		"check is always allowed, which is different from an empty "
+		"string which means an empty list)\n");
 	fprintf(stderr,
 		"* %s: list of ports allowed to bind (server).\n",
 		ENV_TCP_BIND_NAME);
@@ -325,7 +328,8 @@ static void print_help(const char *argv0)
 	fprintf(stderr, "* %s: list of scoped IPCs.\n",
 		ENV_SCOPED_NAME);
 	fprintf(stderr,
-		"\nexample:\n"
+		"\n"
+		"Example:\n"
 		"%s=\"${PATH}:/lib:/usr:/proc:/etc:/dev/urandom\" "
 		"%s=\"/dev/null:/dev/full:/dev/zero:/dev/pts:/tmp\" "
 		"%s=\"9418\" "
-- 
2.39.2

