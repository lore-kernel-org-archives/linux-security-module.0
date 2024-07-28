Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53136FD5;
	Sun, 28 Jul 2024 00:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722127913; cv=none; b=Q06/R9nqjviZDw815tIqC8wObMEekU6rEyXrkCULUuwGgn9DiAv1lKxyG8XrCdn5TTNKnrVsp6fuhKdytCelUbLH2dZZrP2S7+19K9DaFWUV13JYgquyPkQi1RQORt+dVEmhUF38bb/BDE8apAIl3b4MiE7xvkC2ElbKgOjyFI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722127913; c=relaxed/simple;
	bh=QuNYQ5Rxf4SFUDj6mc+dZjtjbj/x4rBn0uVU72yFcAA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pe2iYas2Gix8M+N/XnfDg6CHnkw8fkdgBCRaeWwYfgfkc25erhTANVJjITxX4XmjufmRzv31OXJsjAOHBp0M5nEayEFNtFzPEQZdcXXDDBXYyaZkayxNMUPD5r29a+x4H4qksnXwMwDdd8uwZuXmalgnLDQUWdlzLLf/HXUyv0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=C35G3yS2; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mtfbOC9C; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="C35G3yS2";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mtfbOC9C"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CC99B21C3B;
	Sun, 28 Jul 2024 00:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1722127909; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=K5ueq3FoJocMKyR/0Hi0c1XApOql0EEmP83iDFnPsUA=;
	b=C35G3yS2L48DItjt3laWRp9nY71pJ3iRfFfiDfzURFsgVqphD+lHbQrD5jO44U7zkr5YWP
	muH71nIPWkuPAL3zfQ3Qg0WCezySy1ePTTlv6QYOgwi5QomDSf3wf292lnSitrOg7vgvgF
	lX9GiPc6r7ZypEa6gvDSma4kFZnkY8s=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=mtfbOC9C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1722127908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=K5ueq3FoJocMKyR/0Hi0c1XApOql0EEmP83iDFnPsUA=;
	b=mtfbOC9CXdBCBTZc5C33RxZcISSsxRGaY33SuuMoFfwLAvEojDdXLmWCicEf27qxtj7v8C
	huy3oVSEGDj3o8NIlJkiCLqUnuX5GcfefMB/Lm/Nyj8klSIjychT92Dvk/3HibA09+msEf
	Nup97/6fb41NPE98asmdH6jmnj8HkVo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 58C801379A;
	Sun, 28 Jul 2024 00:51:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UZvZCSSWpWY5XAAAD6G6ig
	(envelope-from <mpdesouza@suse.com>); Sun, 28 Jul 2024 00:51:48 +0000
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Sat, 27 Jul 2024 21:51:40 -0300
Subject: [PATCH RFC] security: tomoyo: Add default builtin-policy.h for
 default policy
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240727-tomoyo-gen-file-v1-1-eb6439e837a1@suse.com>
X-B4-Tracking: v=1; b=H4sIABuWpWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDcyNz3ZL83PzKfN301DzdtMycVN205LRk40SDZIM0EzMloK6CotS0zAq
 widFKQW7OSrG1tQCJ50m4ZgAAAA==
To: Kentaro Takeda <takedakn@nttdata.co.jp>, 
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, 
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
 llvm@lists.linux.dev, Marcos Paulo de Souza <mpdesouza@suse.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722127906; l=2533;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=QuNYQ5Rxf4SFUDj6mc+dZjtjbj/x4rBn0uVU72yFcAA=;
 b=GqCX4MdOTflpcoUQsgYUwn6pHWOeVY8vo5195KVBI2khlZAZtj9jNhJC4TbbyLRX//AQc1bIR
 QY2CfDoNmoTDsfvcLsNag6+mzLtzL7Xizp3FQvplE9nQnmmBVfdNOVw
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: CC99B21C3B
X-Spam-Score: -6.31
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-6.31 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim]

When checking tomoyo code there is an include for a file that is not
included on kernel-source since it's generated at build time, and the
kernel-source uses git archive to create the tarball.

Having the source code referencing a file that is not included in the
tarball can confuse tools that inspect/parse code, since the file is not
there.

The builtin-policy.h added is generated from the same default policy
that already exists on policy/ directory, so it doesn't break the
current usage of that file.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
Hello, I sent this patch because we saw some issues while running
clang-extract[1] on tomoyo given CVE 2024-26622. Since clang-extract
parses the C files it failed to find builtin-policy.h. As a bandaid, I
had to add
	-DCONFIG_SECURITY_TOMOYO_INSECURE_BUILTIN_SETTING

to clang-extract (we feed the gcc arguments used to compile common.c got
from compile_commands.json on kernel-source).

Per my tests it works with my patch, and I don't see why this would hurt
to have builtin-policy.h on git, since it would regenerate the file if
the policy scripts are changed.

Please let me know if I'm missing something here.

Thanks!

[1]: https://github.com/SUSE/clang-extract
---
 security/tomoyo/.gitignore       |  1 -
 security/tomoyo/builtin-policy.h | 13 +++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/security/tomoyo/.gitignore b/security/tomoyo/.gitignore
index 9f300cdce362..85d086c6502d 100644
--- a/security/tomoyo/.gitignore
+++ b/security/tomoyo/.gitignore
@@ -1,3 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
-builtin-policy.h
 policy/*.conf
diff --git a/security/tomoyo/builtin-policy.h b/security/tomoyo/builtin-policy.h
new file mode 100644
index 000000000000..781d35b3ccb3
--- /dev/null
+++ b/security/tomoyo/builtin-policy.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+static char tomoyo_builtin_profile[] __initdata =
+	"";
+static char tomoyo_builtin_exception_policy[] __initdata =
+	"initialize_domain /sbin/modprobe from any\n"
+	"initialize_domain /sbin/hotplug from any\n"
+	"";
+static char tomoyo_builtin_domain_policy[] __initdata =
+	"";
+static char tomoyo_builtin_manager[] __initdata =
+	"";
+static char tomoyo_builtin_stat[] __initdata =
+	"";

---
base-commit: 910bfc26d16d07df5a2bfcbc63f0aa9d1397e2ef
change-id: 20240727-tomoyo-gen-file-fcfc3a0c0f46

Best regards,
-- 
Marcos Paulo de Souza <mpdesouza@suse.com>

