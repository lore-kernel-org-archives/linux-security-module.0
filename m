Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493B210A1E;
	Thu,  3 Oct 2024 00:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.41.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727916595; cv=none; b=GS1XY+H5FpBWMOPRinAP5IfV/SDosDaV3T06WUGwfAO0huDBARC77zHlPcFdkKffik/KjhDQdH9vNsu2PgcvKPzCOlSWd8Ono5pz4p2sd3HXPAprZMDcqjjfINL7m2xSo6rnNtqzH3QOyEouHNnhfLy1iDVUJOYEPm6yyW7efxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727916595; c=relaxed/simple;
	bh=C5qXtRGtWzV670O3uJBwz7I/tQySbHayzPKy/MjpAAg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NtM5LmICANT13WwDcydWkj3fSyx5xQSG7Crktd6XsIyJShL/F2kggk41/mTkyTQCuQ4zBbznlyC9vHjOH/ALb8IUzlOINBGR6+q8/8lllhykxNpwak6T5FPJznhxEsPhL+r98I0QqXczHtUCZLSpr3DFR62OTFTRsUf3jMBn6Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=CvI8Ov9Q; arc=none smtp.client-ip=51.83.41.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buffet.re
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b="CvI8Ov9Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1727916581; bh=C5qXtRGtWzV670O3uJBwz7I/tQySbHayzPKy/MjpAAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CvI8Ov9QiOHnnNX1YY1hzMRtMOPzmUSPadwinnZuRWGTZy+Vujdcroty6/btx5+M6
	 e5dScVXqB5N5KUU7ns2HbimHl8qSIIaJ8C8mkUnSHiaRxql65ZEQvNv0GtwWoM1N/y
	 TuuuN7C30L+yRrI6kwA8+VbKlnN6YpdV1J9ir2QYILpSeTKeWhiMjF59XQ3hfDHJ9u
	 /iXmAV1a8Wx5mUjxEdMQa2XqR1nG7+qhfRUR21F9QTv7zuNUG9DOTGr+lVkeJBffW/
	 H4jsz1+wba+LGV0+YT9pHkC6Ixl+7Tj+zpuXD32w1SeTqGf7+XFGarwA0U43cGUMmw
	 QQk2gjXReCVSA==
Received: from localhost.localdomain (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPA id 65F641230C1;
	Thu,  3 Oct 2024 02:49:41 +0200 (CEST)
From: Matthieu Buffet <matthieu@buffet.re>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matthieu Buffet <matthieu@buffet.re>
Subject: [PATCH v2 2/3] samples/landlock: Refactor --help message in function
Date: Thu,  3 Oct 2024 02:50:41 +0200
Message-Id: <20241003005042.258991-2-matthieu@buffet.re>
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

Help message is getting larger with each new supported feature (scopes,
and soon UDP). Refactor it away into a separate helper function.

Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
---
 samples/landlock/sandboxer.c | 87 +++++++++++++++++++-----------------
 1 file changed, 46 insertions(+), 41 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index aff5ef808e22..f16994d35d9e 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -295,6 +295,51 @@ static bool check_ruleset_scope(const char *const env_var,
 
 #define LANDLOCK_ABI_LAST 6
 
+static void print_help(const char *argv0)
+{
+	fprintf(stderr,
+		"usage: %s=\"...\" %s=\"...\" %s=\"...\" %s=\"...\" %s=\"...\" %s "
+		"<cmd> [args]...\n\n",
+		ENV_FS_RO_NAME, ENV_FS_RW_NAME, ENV_TCP_BIND_NAME,
+		ENV_TCP_CONNECT_NAME, ENV_SCOPED_NAME, argv0);
+	fprintf(stderr,
+		"Execute a command in a restricted environment.\n\n");
+	fprintf(stderr,
+		"Environment variables containing paths and ports "
+		"each separated by a colon:\n");
+	fprintf(stderr,
+		"* %s: list of paths allowed to be used in a read-only way.\n",
+		ENV_FS_RO_NAME);
+	fprintf(stderr,
+		"* %s: list of paths allowed to be used in a read-write way.\n\n",
+		ENV_FS_RW_NAME);
+	fprintf(stderr,
+		"Environment variables containing ports are optional "
+		"and could be skipped.\n");
+	fprintf(stderr,
+		"* %s: list of ports allowed to bind (server).\n",
+		ENV_TCP_BIND_NAME);
+	fprintf(stderr,
+		"* %s: list of ports allowed to connect (client).\n",
+		ENV_TCP_CONNECT_NAME);
+	fprintf(stderr, "* %s: list of scoped IPCs.\n",
+		ENV_SCOPED_NAME);
+	fprintf(stderr,
+		"\nexample:\n"
+		"%s=\"${PATH}:/lib:/usr:/proc:/etc:/dev/urandom\" "
+		"%s=\"/dev/null:/dev/full:/dev/zero:/dev/pts:/tmp\" "
+		"%s=\"9418\" "
+		"%s=\"80:443\" "
+		"%s=\"a:s\" "
+		"%s bash -i\n\n",
+		ENV_FS_RO_NAME, ENV_FS_RW_NAME, ENV_TCP_BIND_NAME,
+		ENV_TCP_CONNECT_NAME, ENV_SCOPED_NAME, argv0);
+	fprintf(stderr,
+		"This sandboxer can use Landlock features "
+		"up to ABI version %d.\n",
+		LANDLOCK_ABI_LAST);
+}
+
 int main(const int argc, char *const argv[], char *const *const envp)
 {
 	const char *cmd_path;
@@ -313,47 +358,7 @@ int main(const int argc, char *const argv[], char *const *const envp)
 	};
 
 	if (argc < 2) {
-		fprintf(stderr,
-			"usage: %s=\"...\" %s=\"...\" %s=\"...\" %s=\"...\" %s=\"...\" %s "
-			"<cmd> [args]...\n\n",
-			ENV_FS_RO_NAME, ENV_FS_RW_NAME, ENV_TCP_BIND_NAME,
-			ENV_TCP_CONNECT_NAME, ENV_SCOPED_NAME, argv[0]);
-		fprintf(stderr,
-			"Execute a command in a restricted environment.\n\n");
-		fprintf(stderr,
-			"Environment variables containing paths and ports "
-			"each separated by a colon:\n");
-		fprintf(stderr,
-			"* %s: list of paths allowed to be used in a read-only way.\n",
-			ENV_FS_RO_NAME);
-		fprintf(stderr,
-			"* %s: list of paths allowed to be used in a read-write way.\n\n",
-			ENV_FS_RW_NAME);
-		fprintf(stderr,
-			"Environment variables containing ports are optional "
-			"and could be skipped.\n");
-		fprintf(stderr,
-			"* %s: list of ports allowed to bind (server).\n",
-			ENV_TCP_BIND_NAME);
-		fprintf(stderr,
-			"* %s: list of ports allowed to connect (client).\n",
-			ENV_TCP_CONNECT_NAME);
-		fprintf(stderr, "* %s: list of scoped IPCs.\n",
-			ENV_SCOPED_NAME);
-		fprintf(stderr,
-			"\nexample:\n"
-			"%s=\"${PATH}:/lib:/usr:/proc:/etc:/dev/urandom\" "
-			"%s=\"/dev/null:/dev/full:/dev/zero:/dev/pts:/tmp\" "
-			"%s=\"9418\" "
-			"%s=\"80:443\" "
-			"%s=\"a:s\" "
-			"%s bash -i\n\n",
-			ENV_FS_RO_NAME, ENV_FS_RW_NAME, ENV_TCP_BIND_NAME,
-			ENV_TCP_CONNECT_NAME, ENV_SCOPED_NAME, argv[0]);
-		fprintf(stderr,
-			"This sandboxer can use Landlock features "
-			"up to ABI version %d.\n",
-			LANDLOCK_ABI_LAST);
+		print_help(argv[0]);
 		return 1;
 	}
 
-- 
2.39.2

