Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161FB40E8E1
	for <linux-security-module@vger.kernel.org>; Fri, 14 Aug 2026 08:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786697706; cv=none; b=PwomL++mxM9//GMhBBT6gfJhCzAMXGMl/VGIIx6wvlataV7m0AWpMFrU9iAByGl7Zc9gY4lLMIwOgKA4FWZUxwmxKJIjKnrpc3BIT0q2taBwdq1mG3jNeILryzbcXMb+ZHZkM7wC3qg+pKWIudcQFlUv++a1ypjQOfCLYsIgR88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786697706; c=relaxed/simple;
	bh=NO2JvQNsMMZgyLKm83dJeGXuQXstUbL8uutqQJAqezY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rxVAP9mi4XM08oZ0QqtlAKpyueMa3rd++HTUDtv1ALaYTryu9l0esjlSYBOsSCq3kKzLMwKQK7IGjDPNaTElvkcWYUgD8ijs+OCbxNggpORSXsLo1OPQMdGGTizZVyCx1YZD8Sn6NAuz3LUfRP6G+Jyz1+TcMnR/2klMWQmBb2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=WstEj6x1; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="WstEj6x1"
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 238823FBDC
	for <linux-security-module@vger.kernel.org>; Fri, 14 Aug 2026 08:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1786697700;
	bh=54b2DVF1kWnIz6lUGKM9/C1BP6a80iMzZ+lel8TT4+E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=WstEj6x1h+roZXd/1Q41z6WxPLRIR9jdrWI5KnAAaZIPeAb8p/3Ca2MlZKP3FoLIr
	 JEGTxdynZ43W7fYBMiLHV3dMH4XP5xGpmOr27HQvEBsi2DDVfpHsXcHV6DFdMEsUgJ
	 tnH+1vkM4t41b7AvQeJ/+zWecriruCa5kTEcovgjnBhu6oU7NUogupZ7s539Olcjey
	 CelLtMqN2+T50G6Mvumhp8n0C+qaUB6n7FoTRs6xF2FCHjJAB1/glPB7qyRZZyu2Wv
	 Q61/xKaUCN0NBlNb6eLBoMW+wl3H78S21DTS8sVyrg2VRuu8bi4YFznvX9uqmO8gnG
	 Qq57kgPlLIffvlQz+Gv1Z1UTBfPj8+jlHglfSUsd7knqUiUAyRgoUXzO9DJ8kBLHNg
	 9NSXWHr8Gx3EHp6ziFZ98iWZgEK1T+JCBOPSWKKwO5tfml8YTt1loesaUlrGSKXhx8
	 /EJf3HCOEotkUUueB0n539JqlxyYFSekU2RLX4hcbp12Kwvh1boA3G9NSuZ7JptUuT
	 ceowaWasO9d9+RQUJjfAUnJ7PlL6KahDy3tZV9uU7TrJh1cwUiMGjlIDDtWOX4y3np
	 khfJBhWCw+4Ugr5Y8NLf61ERImCm5QfnCtgTPzCiml9glJBSYzQ0S4NT0H5RovEpSs
	 aE7oHIzmGZvD2IAKOyRnkqyM=
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48000d75326so472439f8f.2
        for <linux-security-module@vger.kernel.org>; Fri, 14 Aug 2026 01:55:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786697700; x=1787302500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=54b2DVF1kWnIz6lUGKM9/C1BP6a80iMzZ+lel8TT4+E=;
        b=jAy/3ZTSSXa04V6bcTQSC2M+t5IhTpBwqFKEHyn75qYxpGsdU8IgY0LQ4l2Ud5t/25
         NNY4Sht+lmAvwWnVfsnD2EJTUIJvv57CGQRtNt54Bp2vvBlT5n0ail0ThyOjGkWi4k+F
         YktTrKq6OveFmxDyOeZ2ECdvBmwbOataCAMtIeJLYL4KYOcEu/L01C1MwuCjrJveTGYA
         /2/pV/bp5AHiBochzhjlJjLkr5VCHy1/nJ7Vy1c1jhFpLuaYSAQbg25oN0Nb4f5fdj6E
         Isp+k3zOe/wfSagnW2+mgwozjpTGjaHth1DqGfdum/IA17zow4x0wAwO51ZMihryI9FS
         MKqg==
X-Forwarded-Encrypted: i=1; AHgh+RqYw/nI0j4DehufYtrAHrlbqZ/ylEmd4ek5e1sf3YKbAXSi1LV0WCKUD0Lx/G7ghkDpf+RBGs4hf0osLN5uinqEch/RLo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfNpvRcC2xlJoT+LQs6GORO5jAauI7qBSdMX5ju1iTnzd1ISsw
	w83Hcl2oUY1khkK00ie7NyQZeDJlnLqDJgspth8iDXXUEcBP4kmywJpsgjuBXwvsKqnwgNTZKje
	0BnjxfFbnYHzmhfhc56zrXq9gmDhC/CDw+zDsDXXk5nl/RpbJehnai06IMmka2ctIXaYdD0X4uE
	4fsuTJKNLtP4xEMMp08Q==
X-Gm-Gg: AR+sD125bpuOW1EmTBbp499mEZ/w4aISu8nfhYNSSJkww5aNWSdOvZYrUhqleo9tpj6
	GW3f9mb+h+3a98Que/5E8TtKxJ/BFp0TQ77OStxsb2nn8wCUNNQHZt6AMO7wEKhfEeGMHPOmIcI
	b3stRudir5C/7A6JVf1e8SLh1m5qkCa+H+F7hJSy4zihOxjXJ34TU/xYGwVJN7tzF1+zow2HqBf
	cTseRcRvQbdJLLVTZkrHolpWNUhS6yXaqqMWoKXL6rBIkviDSsESVoxsPGqfzHrKTt5ryTfdtW0
	7vSaEKSDOLJmccq8QIVE0PSNVQMs9TsefMwdbZJvln/yFReWG9n9/6eyx3TrD5mY3MNK+M0Kjo1
	LJr1A+H6ryO0PZlu/HIerQL10vFR0KED1b12QSr4KI8jMtNxizsbzyIgvaR7PK2z79HR2muYjvq
	QKe/EuNurruCozcClQ4ahVwMic
X-Received: by 2002:a05:6000:290e:b0:47f:776f:3838 with SMTP id ffacd0b85a97d-481606f682dmr6094933f8f.6.1786697699672;
        Fri, 14 Aug 2026 01:54:59 -0700 (PDT)
X-Received: by 2002:a05:6000:290e:b0:47f:776f:3838 with SMTP id ffacd0b85a97d-481606f682dmr6094849f8f.6.1786697699032;
        Fri, 14 Aug 2026 01:54:59 -0700 (PDT)
Received: from t-14 (2a01cb00088323008940b17acf2a49f2.ipv6.abo.wanadoo.fr. [2a01:cb00:883:2300:8940:b17a:cf2a:49f2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2c1307sm6625307f8f.27.2026.08.14.01.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 01:54:58 -0700 (PDT)
From: Fabrice Derepas <fabrice.derepas@canonical.com>
To: Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Fabrice Derepas <fabrice.derepas@canonical.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ima: bound line scan in ima_read_policy() to fix OOB read
Date: Fri, 14 Aug 2026 10:54:33 +0200
Message-ID: <20260814085443.1211989-1-fabrice.derepas@canonical.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ima_read_policy() loads a policy file with kernel_read_file_from_path()
and splits it into lines with

	while (size > 0 && (p = strsep(&datap, "\n")))

kernel_read_file() allocates the destination with vmalloc(i_size) --
exactly i_size bytes, and writes no NUL terminator. strsep()'s scan for
the next '\n' is not bounded by @size, so when the last line has no
trailing newline the scan runs off the end of the buffer (CWE-125). When
i_size is a multiple of PAGE_SIZE the allocation has no slack and the
read walks into the vmalloc guard page and faults.

Reproduced under KASAN in a VM: writing the path of a page-aligned
policy file with no trailing newline to <securityfs>/ima/policy oopses:

  BUG: unable to handle page fault for address: ffffc90000032000
  #PF: supervisor read access in kernel mode
  RIP: 0010:strsep+0x7a/0xd0
  Call Trace:
   ima_write_policy+0x1f4/0x260
   vfs_write+0x16a/0x6f0
   ksys_write+0xcb/0x160
   do_syscall_64+0xe0/0x5a0

This requires CAP_MAC_ADMIN (the policy file is mode 0200), but a policy
file that does not end in a newline is an ordinary, non-malicious
condition, so a legitimate policy load can crash the kernel.

Walk the buffer with memchr() bounded by the remaining size instead of
strsep(): terminate each line in place at its newline, and parse a
NUL-terminated copy of a final line that has none. The explicit per-line
accounting replaces the old "size -= rc" step, whose off-by-one
(ima_parse_add_rule() returns strlen() + 1) made a trailing line without a
newline fail with -EINVAL; such a policy now loads. The loop now consumes
the buffer exactly, so the trailing "if (size) return -EINVAL" is dropped.

Fixes: 7429b092811f ("ima: load policy using path")
Assisted-by: copilot-cli:claude-opus-4-6 frama-c
Signed-off-by: Fabrice Derepas <fabrice.derepas@canonical.com>
---
Tested under KASAN (CONFIG_KASAN_GENERIC + CONFIG_KASAN_VMALLOC) in QEMU,
loading a policy via "echo /path > <securityfs>/ima/policy":

  - page-aligned file, no trailing newline: unpatched -> guard-page oops
    in strsep()/ima_read_policy() (trace above); patched -> no fault, the
    load fails cleanly with -EINVAL on the (garbage) content.
  - valid policy with a trailing newline: loads before and after.
  - valid rule with no trailing newline: unpatched -> -EINVAL (the size
    underflow); patched -> loads.

lib/string.o is not KASAN-instrumented, so the over-read is caught by the
vmalloc guard page rather than a shadow report; the confirmation is the
page-fault oops with strsep()/ima_write_policy() in the trace.

 security/integrity/ima/ima_fs.c | 46 ++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 10 deletions(-)

diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 174a94740..7b530b130 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -526,12 +526,10 @@ static const struct file_operations ima_ascii_measurements_staged_ops = {
 static ssize_t ima_read_policy(char *path)
 {
 	void *data = NULL;
-	char *datap;
-	size_t size;
+	char *datap, *eol, *p;
+	size_t size, linelen;
 	int rc, pathlen = strlen(path);
 
-	char *p;
-
 	/* remove \n */
 	datap = path;
 	strsep(&datap, "\n");
@@ -546,21 +544,49 @@ static ssize_t ima_read_policy(char *path)
 	rc = 0;
 
 	datap = data;
-	while (size > 0 && (p = strsep(&datap, "\n"))) {
+	while (size > 0) {
+		eol = memchr(datap, '\n', size);
+		linelen = eol ? (size_t)(eol - datap) : size;
+
+		if (eol) {
+			/* NUL-terminate the line in place, within bounds. */
+			*eol = '\0';
+			p = datap;
+		} else {
+			/*
+			 * kernel_read_file_from_path() does not NUL-terminate
+			 * the buffer, and it may be exactly i_size bytes long,
+			 * so a string walk off the end is possible.  The final
+			 * line without a trailing newline has no room for a
+			 * terminator; parse a terminated copy instead.
+			 */
+			p = kmemdup_nul(datap, linelen, GFP_KERNEL);
+			if (!p) {
+				rc = -ENOMEM;
+				break;
+			}
+		}
+
 		pr_debug("rule: %s\n", p);
 		rc = ima_parse_add_rule(p);
+		if (!eol)
+			kfree(p);
 		if (rc < 0)
 			break;
-		size -= rc;
+		rc = 0;
+
+		datap += linelen;
+		size -= linelen;
+		if (eol) {
+			datap++;	/* skip the newline */
+			size--;
+		}
 	}
 
 	vfree(data);
 	if (rc < 0)
 		return rc;
-	else if (size)
-		return -EINVAL;
-	else
-		return pathlen;
+	return pathlen;
 }
 
 static ssize_t ima_write_policy(struct file *file, const char __user *buf,

base-commit: d58772d8520c7ef247c4b95c9bd76d3a25da9ff5
-- 
2.53.0

