Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B18C8CE;
	Thu,  3 Oct 2024 00:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.41.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727916545; cv=none; b=CNLjAfNvdjSNc99tN6aDA0mHqKlbB7E+xj34R72BH4LDyiI5qS1vcgww9BXZl0UBfbYESJXYqZcMWN8B5XOAJ2uRtf2ynYrhrFLazlMLQUSP9Mh93rFUHhH5myzB98lqfAigQXaP2kpXZdGOSmkUAo/UkSuyXJYO3+d1akBECxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727916545; c=relaxed/simple;
	bh=Q1ce3jn9XQL6ANvPMCddF9t/Fksz4njwik0p/EWHY0I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rIEWK6BBb6IiNE6+9Z9v1L74cE1eu+kVFU3oziO43Zbl2KTnWVI9ZRCXR2boDbcfYYT7rS9UOcuE4RkyNk/zPkpn+sZNNJaJ5JHy9MQrgup7kIwmxDlhpakuLy/YdNvfMOefXel2qFB1czoOVV3nfOS4OCd/9ZQtQ5VzHViBpFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=Uv0Y+37u; arc=none smtp.client-ip=51.83.41.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buffet.re
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b="Uv0Y+37u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1727916534; bh=Q1ce3jn9XQL6ANvPMCddF9t/Fksz4njwik0p/EWHY0I=;
	h=From:To:Cc:Subject:Date:From;
	b=Uv0Y+37u3klwaP+PUx1ESXBB68fehYPQkIt0vCc3srTPzu9KZsLoAPyBEhSq6PN+p
	 If8etRln5s83I2m9LbrqPbGBJj/QjTEelo26JS0ukFJsIi5X7og8ak/busBE1JTVar
	 Xrxaod1vQPYQZhEaIG/j3B5tnEl3WbDWMeLvjRreZSuvTN9D4YGrzdO7vWB/X1lTT1
	 CinYtxUn25yQXTSGCi26dhwE/xBQnMUxz3yvbW4Wxeuci+G0Umxb9tTHNdaG4XC7sn
	 sLeBGbS4j0xpHh9s6U4tRNt7NgBCfy1dTJ4YohtW59Cu/aJezd+uDnxvZv2iyCnVMN
	 /7yknT4CprncQ==
Received: from localhost.localdomain (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPA id BDAF41230C1;
	Thu,  3 Oct 2024 02:48:54 +0200 (CEST)
From: Matthieu Buffet <matthieu@buffet.re>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matthieu Buffet <matthieu@buffet.re>
Subject: [PATCH v2 1/3] samples/landlock: Fix port parsing in sandboxer
Date: Thu,  3 Oct 2024 02:50:40 +0200
Message-Id: <20241003005042.258991-1-matthieu@buffet.re>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If you want to specify that no port can be bind()ed, you would think
(looking quickly at both help message and code) that setting LL_TCP_BIND=""
would do it.

However the code splits on ":" then applies atoi(), which does not allow
checking for errors. Passing an empty string returns 0, which is
interpreted as "allow bind(0)", which means bind to any ephemeral port.
This bug occurs whenever passing an empty string or when leaving a
trailing/leading colon, making it impossible to completely deny bind().

To reproduce:
export LL_FS_RO="/" LL_FS_RW="" LL_TCP_BIND=""
./sandboxer strace -e bind nc -n -vvv -l -p 0
Executing the sandboxed command...
bind(3, {sa_family=AF_INET, sin_port=htons(0),
     sin_addr=inet_addr("0.0.0.0")}, 16) = 0
Listening on 0.0.0.0 37629

Use strtoul() instead, which allows error checking. Check that the entire
string has been parsed correctly without overflows/underflows.
Don't check that the __u64 (the type of struct landlock_net_port_attr.port)
is a valid __u16 port: that is already done by the kernel.
Two places check for an empty string, that is just to make the helper
function safer to use in the future.

Fixes: 5e990dcef12e ("samples/landlock: Support TCP restrictions")
Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
---
 samples/landlock/sandboxer.c | 37 ++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index f847e832ba14..aff5ef808e22 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -16,6 +16,7 @@
 #include <linux/prctl.h>
 #include <linux/socket.h>
 #include <stddef.h>
+#include <stdint.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -60,6 +61,29 @@ static inline int landlock_restrict_self(const int ruleset_fd,
 #define ENV_SCOPED_NAME "LL_SCOPED"
 #define ENV_DELIMITER ":"
 
+static int str2num(const char *numstr, __u64 *num_dst)
+{
+	char *endptr = NULL;
+	int err = 1;
+	__u64 num;
+
+	if (*numstr == '\0')
+		goto out;
+
+	errno = 0;
+	num = strtoull(numstr, &endptr, 10);
+	if (errno != 0)
+		goto out;
+
+	if (*endptr != '\0')
+		goto out;
+
+	*num_dst = num;
+	err = 0;
+out:
+	return err;
+}
+
 static int parse_path(char *env_path, const char ***const path_list)
 {
 	int i, num_paths = 0;
@@ -160,7 +184,6 @@ static int populate_ruleset_net(const char *const env_var, const int ruleset_fd,
 	char *env_port_name, *env_port_name_next, *strport;
 	struct landlock_net_port_attr net_port = {
 		.allowed_access = allowed_access,
-		.port = 0,
 	};
 
 	env_port_name = getenv(env_var);
@@ -171,7 +194,17 @@ static int populate_ruleset_net(const char *const env_var, const int ruleset_fd,
 
 	env_port_name_next = env_port_name;
 	while ((strport = strsep(&env_port_name_next, ENV_DELIMITER))) {
-		net_port.port = atoi(strport);
+		__u64 port;
+
+		if (strcmp(strport, "") == 0)
+			continue;
+
+		if (str2num(strport, &port)) {
+			fprintf(stderr,
+				"Failed to parse port at \"%s\"\n", strport);
+			goto out_free_name;
+		}
+		net_port.port = port;
 		if (landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
 				      &net_port, 0)) {
 			fprintf(stderr,
-- 
2.39.2

