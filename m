Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D05F1DDC37
	for <linux-security-module@vger.kernel.org>; Fri, 31 Oct 2025 21:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761946879; cv=none; b=k+9fYwHztYRgL0VJJnJGUPS5mC2wh+XmiYk8Zv+LO5NrRRkSwSV9+e7dIMTFqON8v3RCOP7/WLjasNAsUBMr3PuylkZGQ1M77TtMP/gYq5a7qOeeCnh3pKzK+sRUumQhtxh4g2bV3m38F3O59AtCMiXzrfOJSHpXaLyAM7iBZCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761946879; c=relaxed/simple;
	bh=FQtGKj1C1W4YeqLWF0p+M1O+rfPZB3/GavtPlTk/VrE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DUuZs6Z2onuecPZkvQpxl0NMsJqpFZVdAZtAvMR90Il4TLh8EFh7nhlSokDEW/lF1q3i69/8k9icZslgrgm/Wcnpofi4qnuYXjsWAgmm2gxRm+xVQqWoppxGaJ74ZDAY25+Gpn9b7sK245YkdSw7TcF+C9ilO8DlFkEg8S6HPAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HJ2/Cugc; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HJ2/Cugc"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761946864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Rum7pY6JLVc1QrY6RaGpCIzKK5H6n6X8wHW4Xv/T4Zo=;
	b=HJ2/CugcONe4SzdA38bQqib2/LfwmE4yqV3pTyQOF8TFLILwGTqA7UJL5jCywXxFT960oU
	RgipaOzuRimaX9T5S74yNsSZTe4VAVZJdVCuweyjYnFLQTuGqEstXoYSes2p1aX34WOFI0
	b+wlu32ful0kCHlns7QXSzG9LEnlypo=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: David Laight <david.laight.linux@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] device_cgroup: Refactor devcgroup_seq_show to use seq_put* helpers
Date: Fri, 31 Oct 2025 22:39:14 +0100
Message-ID: <20251031213915.211046-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace set_access(), set_majmin(), and type_to_char() with new helpers
seq_putaccess(), seq_puttype(), and seq_putversion() that write directly
to 'seq_file'.

Simplify devcgroup_seq_show() by hard-coding "a *:* rwm", and use the
new seq_put* helper functions to list the exceptions otherwise.

This allows us to remove the intermediate string buffers while
maintaining the same functionality, including wildcard handling.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v2:
- Add setq_put* helpers to modify seq_file directly (David)
- Update patch subject and description
- Link to v1: https://lore.kernel.org/lkml/20251031110647.102728-2-thorsten.blum@linux.dev/
---
 security/device_cgroup.c | 56 ++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 31 deletions(-)

diff --git a/security/device_cgroup.c b/security/device_cgroup.c
index dc4df7475081..7fec575d32d6 100644
--- a/security/device_cgroup.c
+++ b/security/device_cgroup.c
@@ -244,45 +244,40 @@ static void devcgroup_css_free(struct cgroup_subsys_state *css)
 #define DEVCG_DENY 2
 #define DEVCG_LIST 3
 
-#define MAJMINLEN 13
-#define ACCLEN 4
-
-static void set_access(char *acc, short access)
+static void seq_putaccess(struct seq_file *m, short access)
 {
-	int idx = 0;
-	memset(acc, 0, ACCLEN);
 	if (access & DEVCG_ACC_READ)
-		acc[idx++] = 'r';
+		seq_putc(m, 'r');
 	if (access & DEVCG_ACC_WRITE)
-		acc[idx++] = 'w';
+		seq_putc(m, 'w');
 	if (access & DEVCG_ACC_MKNOD)
-		acc[idx++] = 'm';
+		seq_putc(m, 'm');
 }
 
-static char type_to_char(short type)
+static void seq_puttype(struct seq_file *m, short type)
 {
 	if (type == DEVCG_DEV_ALL)
-		return 'a';
-	if (type == DEVCG_DEV_CHAR)
-		return 'c';
-	if (type == DEVCG_DEV_BLOCK)
-		return 'b';
-	return 'X';
+		seq_putc(m, 'a');
+	else if (type == DEVCG_DEV_CHAR)
+		seq_putc(m, 'c');
+	else if (type == DEVCG_DEV_BLOCK)
+		seq_putc(m, 'b');
+	else
+		seq_putc(m, 'X');
 }
 
-static void set_majmin(char *str, unsigned m)
+static void seq_putversion(struct seq_file *m, unsigned int version)
 {
-	if (m == ~0)
-		strcpy(str, "*");
+	if (version == ~0)
+		seq_putc(m, '*');
 	else
-		sprintf(str, "%u", m);
+		seq_printf(m, "%u", version);
 }
 
 static int devcgroup_seq_show(struct seq_file *m, void *v)
 {
 	struct dev_cgroup *devcgroup = css_to_devcgroup(seq_css(m));
 	struct dev_exception_item *ex;
-	char maj[MAJMINLEN], min[MAJMINLEN], acc[ACCLEN];
 
 	rcu_read_lock();
 	/*
@@ -292,18 +287,17 @@ static int devcgroup_seq_show(struct seq_file *m, void *v)
 	 * This way, the file remains as a "whitelist of devices"
 	 */
 	if (devcgroup->behavior == DEVCG_DEFAULT_ALLOW) {
-		set_access(acc, DEVCG_ACC_MASK);
-		set_majmin(maj, ~0);
-		set_majmin(min, ~0);
-		seq_printf(m, "%c %s:%s %s\n", type_to_char(DEVCG_DEV_ALL),
-			   maj, min, acc);
+		seq_puts(m, "a *:* rwm\n");
 	} else {
 		list_for_each_entry_rcu(ex, &devcgroup->exceptions, list) {
-			set_access(acc, ex->access);
-			set_majmin(maj, ex->major);
-			set_majmin(min, ex->minor);
-			seq_printf(m, "%c %s:%s %s\n", type_to_char(ex->type),
-				   maj, min, acc);
+			seq_puttype(m, ex->type);
+			seq_putc(m, ' ');
+			seq_putversion(m, ex->major);
+			seq_putc(m, ':');
+			seq_putversion(m, ex->minor);
+			seq_putc(m, ' ');
+			seq_putaccess(m, ex->access);
+			seq_putc(m, '\n');
 		}
 	}
 	rcu_read_unlock();
-- 
2.51.1

