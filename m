Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063E910E4;
	Sat, 19 Oct 2024 15:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.41.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729350943; cv=none; b=YokBiSPjBe8MZtAKFOWJTm/UhPcm12VzHo+vKg8ssRw31U0WaH9PUhj3zlEkpWmTH86qzw/Rp4pCw9Zwaub45AsVR3YvhQe6MvSMbHslcFn4Pv1abKFmAs3YLc+WzNyIr8gCD2AgnrUjzgpr2o5DAqYtPCDSL+dKRoagtBiA76U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729350943; c=relaxed/simple;
	bh=4p0yi6hQrklynyNTJu66D+95UFCO+N8SlLzW+Fppcg0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R0r/tIunFHTTkB9OAmiCTqOYuB61MnIoYj0IW9BIdXcBsASURiUzOvXXEy5XzVRUOGY2w3CAj5UCCiCAJpgnb5RnuMWhJIQlHNYWrTjshch+tbvnyvfqatPF+eorT0eqG1lK9BQ8r3Cy4Z27z95tVr7qJgtim7qf/cNMA8EXGsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=VTuhLc0F; arc=none smtp.client-ip=51.83.41.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buffet.re
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b="VTuhLc0F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1729350934; bh=4p0yi6hQrklynyNTJu66D+95UFCO+N8SlLzW+Fppcg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VTuhLc0FF8VlhjZuG18YyRl70fRf2BMM6YPMrAUp4BKJ7VSk1CTIrwRlbpf3BQC48
	 vfMo6ed5US/+E2yTO7fR+WmYbglISNyfZYLF53Wz/pz0wtRZcv09shuqE02PQesQ9x
	 C+jfBw/NWMPTi+Sj1rq6svlShQSgv7ZERcU3B3H8537Hl3V//WlJAN9cyIxjpORMaA
	 nX1czajwNx9bkvYeaFtKDHQuoSFf1GpXVS1PTCOp744Ra8OU0Qdw5U94IQjCtK2YLV
	 ekIb2uu+wud4mB/7wb6QhJ3FQJ+G0iF+P+3c7INGKEIemVuXZv5aFrfhBaD4DEL22S
	 7u3hSMYkah8EA==
Received: from localhost.localdomain (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPA id 08279123074;
	Sat, 19 Oct 2024 17:15:34 +0200 (CEST)
From: Matthieu Buffet <matthieu@buffet.re>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matthieu Buffet <matthieu@buffet.re>,
	Tahera Fahimi <fahimitahera@gmail.com>
Subject: [PATCH v3 2/3] samples/landlock: Refactor help message
Date: Sat, 19 Oct 2024 17:15:33 +0200
Message-Id: <20241019151534.1400605-3-matthieu@buffet.re>
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

Help message is getting larger with each new supported feature (scopes,
and soon UDP). Also the large number of calls to fprintf with environment
variables make it hard to read. Refactor it away into a single simpler
constant format string.

Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
---
 samples/landlock/sandboxer.c | 79 +++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 41 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index 4cbef9d2f15b..38fc6ebd7222 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -290,6 +290,43 @@ static bool check_ruleset_scope(const char *const env_var,
 
 #define LANDLOCK_ABI_LAST 6
 
+#define XSTR(s) #s
+#define STR(s) XSTR(s)
+
+/* clang-format off */
+
+static const char help[] =
+	"usage: "
+	ENV_FS_RO_NAME "=\"...\" "
+	ENV_FS_RW_NAME "=\"...\" "
+	ENV_TCP_BIND_NAME "=\"...\" "
+	ENV_TCP_CONNECT_NAME "=\"...\" "
+	ENV_SCOPED_NAME "=\"...\" %1$s <cmd> [args]...\n"
+	"\n"
+	"Execute a command in a restricted environment.\n"
+	"\n"
+	"Environment variables containing paths and ports each separated by a colon:\n"
+	"* " ENV_FS_RO_NAME ": list of paths allowed to be used in a read-only way\n"
+	"* " ENV_FS_RW_NAME ": list of paths allowed to be used in a read-write way\n"
+	"\n"
+	"Environment variables containing ports are optional and could be skipped.\n"
+	"* " ENV_TCP_BIND_NAME ": list of ports allowed to bind (server)\n"
+	"* " ENV_TCP_CONNECT_NAME ": list of ports allowed to connect (client)\n"
+	"* " ENV_SCOPED_NAME ": list of scoped IPCs\n"
+	"\n"
+	"Example:\n"
+	ENV_FS_RO_NAME "=\"${PATH}:/lib:/usr:/proc:/etc:/dev/urandom\" "
+	ENV_FS_RW_NAME "=\"/dev/null:/dev/full:/dev/zero:/dev/pts:/tmp\" "
+	ENV_TCP_BIND_NAME "=\"9418\" "
+	ENV_TCP_CONNECT_NAME "=\"80:443\" "
+	ENV_SCOPED_NAME "=\"a:s\" "
+	"%1$s bash -i\n"
+	"\n"
+	"This sandboxer can use Landlock features up to ABI version "
+	STR(LANDLOCK_ABI_LAST) ".\n";
+
+/* clang-format on */
+
 int main(const int argc, char *const argv[], char *const *const envp)
 {
 	const char *cmd_path;
@@ -308,47 +345,7 @@ int main(const int argc, char *const argv[], char *const *const envp)
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
+		fprintf(stderr, help, argv[0]);
 		return 1;
 	}
 
-- 
2.39.5

