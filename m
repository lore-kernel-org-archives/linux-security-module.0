Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9430231ED68;
	Fri, 17 Apr 2026 07:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776411184; cv=none; b=JNo+d3WWVVA1QIHwpMTeVNIVHYzn5KtQ3awC0/ycr6/gkqPOs3/V5JeZv47YTg14cOA3eNTJsPhrqEWwg0vy88Lo810GqE5Wj79LwKgomyi4mLH9FkzOslvvK/zXhnFx4zEI+DY5oBct46gm1AJ2eOWpaN0InIZfV2g7zjNuwNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776411184; c=relaxed/simple;
	bh=slhT4iyxtRhdMnv0PzjaVTEaKAozy1qiIHZ5NKnGwtg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=amovWeKLewoqP7U8xMg4sZm7d7ZWsuURt4ABjsXqwajmis3dk48mgON3k1J/arH9v8wPjvUdgfFbDw9CUNRRfEGMSLTBn0A6DSlE1FbUgJR/8PxRq4AMJiYZLYLDhQ8nV1fJIcCJQxBmFqw+1AUoj6Vhq0x+v2sB9YcHy90ARLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.116])
	by APP-05 (Coremail) with SMTP id zQCowACXKQ0i4uFpvNXXDQ--.61497S2;
	Fri, 17 Apr 2026 15:32:50 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Kentaro Takeda <takedakn@nttdata.co.jp>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] tomoyo: reject short exec.envp[] names before suffix checks
Date: Fri, 17 Apr 2026 15:32:49 +0800
Message-ID: <20260417073249.93906-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACXKQ0i4uFpvNXXDQ--.61497S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr45Kr4DAF4rGrW8Zry7KFg_yoW8JFW8pr
	4akFy2grn5JFWSyw4xtw18CFyrCan5Cr43Ga9xAFySy3W3XF1Iq3WjgF4rur1rCr4xtrW2
	vw4jvry3KFWDJFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbzpBD
	UUUUU==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

tomoyo_parse_envp() assumes that the left-hand side still ends with the
closing '"' and ']' from an exec.envp["..."] condition and immediately
backs up from strlen(left) - 1 to verify that suffix.

If policy input leaves an empty or one-byte string here, the parser
reads before the start of the token while checking for the suffix.

Reject left-hand strings that are too short to contain the required '"]'
terminator before dereferencing the trailing characters.

Fixes: 5b636857fee6 ("TOMOYO: Allow using argv[]/envp[] of execve() as conditions.")
Cc: stable@vger.kernel.org

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 security/tomoyo/condition.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/security/tomoyo/condition.c b/security/tomoyo/condition.c
index f8bcc083bb0d..1fa8343df4b3 100644
--- a/security/tomoyo/condition.c
+++ b/security/tomoyo/condition.c
@@ -320,7 +320,13 @@ static bool tomoyo_parse_envp(char *left, char *right,
 {
 	const struct tomoyo_path_info *name;
 	const struct tomoyo_path_info *value;
-	char *cp = left + strlen(left) - 1;
+	size_t len = strlen(left);
+	char *cp;
+
+	if (len < 2)
+		goto out;
+
+	cp = left + len - 1;
 
 	if (*cp-- != ']' || *cp != '"')
 		goto out;
-- 
2.50.1 (Apple Git-155)

