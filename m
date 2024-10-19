Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CA08472;
	Sat, 19 Oct 2024 15:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.41.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729350894; cv=none; b=f4AMn4WNKX5tHqkMjv8jz6w0n3VvTB7MSh3OoGtxF5dUlz7sglGl5WcTE4AmD4+x++m4acDTCjpcUwYZfRf5HIHmjxK009dBB90JZWCbcOe7I0HriUv7BJ1yS9C37VWGxGDJvOHMqIJAjB9uuXvlkO16UvgxIbbVP8J34aoTwB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729350894; c=relaxed/simple;
	bh=EbOaNfV96LGnKaVuzgC8ZReAzEf1xeV3TJnMvRw0RKw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=op7zY/+kCBi6n8l1WlHOUn/pzQL7BwiOzJ2mkmsCvN8594sQTh13TN0svfwC8KLJHUBYrsSSkM3RQl0sMKNuLGURWHuw7un+a/cJvMr0I9bz3ee4jb5pali6DLqjTwPQPgBmgSlzHGqbUo9XmZD4aB2vrRh/nTaEZjLT4h5U4fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=D22pavtT; arc=none smtp.client-ip=51.83.41.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buffet.re
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b="D22pavtT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1729350882; bh=EbOaNfV96LGnKaVuzgC8ZReAzEf1xeV3TJnMvRw0RKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D22pavtT67F9YQpapMTd18eKhpaRqHIF1ckPStjcxsB2cti+274q8bY7CMmMjnUhE
	 Gufm3NbEkZ6R4T7aYiHx/wrDGgPn4ZsZdlIexXRzijSXvS9iu/daOHOw1zMVLb/6Im
	 SYBCHOOh+3T7rPlZcekOEmuzkYlv5Kuz5Q3twHF0EmR5t003GD2sdOrjrv8LL2j5Xb
	 6aa60tCMk91S02I7xEVCfU/uVsdE4Q7GdGWbYiv5aPjOsb026OQt0yPbCYF/Qhn/UV
	 0OARaJHRn6J0cF26gaOa2magAgZTbcWxQyKZfMXDzrWEI+rTqeG2lPLMIeJSge6XPY
	 NG6dEn3IL0Icg==
Received: from localhost.localdomain (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPA id 1F21E123074;
	Sat, 19 Oct 2024 17:14:42 +0200 (CEST)
From: Matthieu Buffet <matthieu@buffet.re>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matthieu Buffet <matthieu@buffet.re>,
	Tahera Fahimi <fahimitahera@gmail.com>
Subject: [PATCH v3 1/3] samples/landlock: Fix port parsing in sandboxer
Date: Sat, 19 Oct 2024 17:15:32 +0200
Message-Id: <20241019151534.1400605-2-matthieu@buffet.re>
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

Use strtoull(3) instead, which allows error checking. Check that the entire
string has been parsed correctly without overflows/underflows, but not
that the __u64 (the type of struct landlock_net_port_attr.port)
is a valid __u16 port: that is already done by the kernel.

Fixes: 5e990dcef12e ("samples/landlock: Support TCP restrictions")
Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
---
 samples/landlock/sandboxer.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index f847e832ba14..4cbef9d2f15b 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -60,6 +60,25 @@ static inline int landlock_restrict_self(const int ruleset_fd,
 #define ENV_SCOPED_NAME "LL_SCOPED"
 #define ENV_DELIMITER ":"
 
+static int str2num(const char *numstr, __u64 *num_dst)
+{
+	char *endptr = NULL;
+	int err = 0;
+	__u64 num;
+
+	errno = 0;
+	num = strtoull(numstr, &endptr, 10);
+	if (errno != 0)
+		err = errno;
+	/* Was the string empty, or not entirely parsed successfully? */
+	else if ((*numstr == '\0') || (*endptr != '\0'))
+		err = EINVAL;
+	else
+		*num_dst = num;
+
+	return err;
+}
+
 static int parse_path(char *env_path, const char ***const path_list)
 {
 	int i, num_paths = 0;
@@ -160,7 +179,6 @@ static int populate_ruleset_net(const char *const env_var, const int ruleset_fd,
 	char *env_port_name, *env_port_name_next, *strport;
 	struct landlock_net_port_attr net_port = {
 		.allowed_access = allowed_access,
-		.port = 0,
 	};
 
 	env_port_name = getenv(env_var);
@@ -171,7 +189,17 @@ static int populate_ruleset_net(const char *const env_var, const int ruleset_fd,
 
 	env_port_name_next = env_port_name;
 	while ((strport = strsep(&env_port_name_next, ENV_DELIMITER))) {
-		net_port.port = atoi(strport);
+		__u64 port;
+
+		if (strcmp(strport, "") == 0)
+			continue;
+
+		if (str2num(strport, &port)) {
+			fprintf(stderr, "Failed to parse port at \"%s\"\n",
+				strport);
+			goto out_free_name;
+		}
+		net_port.port = port;
 		if (landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
 				      &net_port, 0)) {
 			fprintf(stderr,
-- 
2.39.5

