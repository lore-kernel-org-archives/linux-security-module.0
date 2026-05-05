Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A453B38BA;
	Tue,  5 May 2026 09:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777971931; cv=none; b=SjClSJqaW0UCw5xUr4/wy8mkAgO5r9EhSDCoXQy/CbG6Aqv00BKNmyZUUpNafIOgmwj5HN+yP+tNxX84bW07BY8Q4NJ3Z/dL5XJRfEjDx/ys9RQE/JZ47LVSOqgSLKkjVdGC1t3Q5Qlr9m+D9aAV7yD2SCTClAKmn66Msr5GTOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777971931; c=relaxed/simple;
	bh=XIA5YFBwc6Ej9VZmFF9JGp6ZBIHakQDs8PjcS5hpne4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sZXHjfHhEk9dUT0J4o6N6z90m+oE+IDSj1BZn1E06ynYzzX+zvwJ5xxonwKvZ/cNGUBB6quVtaPSwQJFkYAoHc4BZZ2VJAd/ssrXqweS1tR/2X0h8pabPDF0EDzANcQyBIp12VRdrrY9/9GKwpIW3hxqlcF1v/rV7ZrBNL8etnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=PYVOCmjq; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="PYVOCmjq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1777971923;
	bh=XIA5YFBwc6Ej9VZmFF9JGp6ZBIHakQDs8PjcS5hpne4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PYVOCmjq815JBlphGcbWGjosj5154jDxWGNn8ySDnDRZCagPbXH9bmGuDkWLdstc5
	 grpEv/Yl2QEHm9XpoxDF+rxCVkiggxlJsqZd9mPp3D9zvHgh8AHdI19vL1MIJlb8ak
	 bm5DkY3Tc6TmLgjyO/DFdc2VD/nWslfWIYCOq/mw=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 05 May 2026 11:05:08 +0200
Subject: [PATCH v5 04/14] module: Drop pointless debugging message
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260505-module-hashes-v5-4-e174a5a49fce@weissschuh.net>
References: <20260505-module-hashes-v5-0-e174a5a49fce@weissschuh.net>
In-Reply-To: <20260505-module-hashes-v5-0-e174a5a49fce@weissschuh.net>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
 Daniel Gomez <da.gomez@samsung.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Naveen N Rao <naveen@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, 
 Nicolas Schier <nicolas.schier@linux.dev>, 
 Daniel Gomez <da.gomez@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, 
 Xiu Jianfeng <xiujianfeng@huawei.com>, 
 Christophe Leroy <chleroy@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 bpf@vger.kernel.org, 
 =?utf-8?q?Fabian_Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>, 
 Arnout Engelen <arnout@bzzt.net>, Mattia Rizzolo <mattia@mapreri.org>, 
 kpcyrd <kpcyrd@archlinux.org>, Christian Heusel <christian@heusel.eu>, 
 =?utf-8?q?C=C3=A2ju_Mihai-Drosi?= <mcaju95@gmail.com>, 
 Eric Biggers <ebiggers@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org, 
 debian-kernel@lists.debian.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777971921; l=660;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=XIA5YFBwc6Ej9VZmFF9JGp6ZBIHakQDs8PjcS5hpne4=;
 b=Ee+VM+f9ivEIue9ulRLTnR7A7RxGy6esDrOUiYWXgYjcohrPW0vgCLL+otaNguQ4yU33rNoC0
 E/xUSCAFfC8Dq68rIFE+RjjVdNuj1MSQsJK7czkKKBhaEAT8wIUs2W8
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

This is the only instance of pr_devel() in the whole module subsystem
and essentially useless.

Drop it.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 kernel/module/signing.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/module/signing.c b/kernel/module/signing.c
index 590ba29c85ab..4a5e4eef250d 100644
--- a/kernel/module/signing.c
+++ b/kernel/module/signing.c
@@ -46,8 +46,6 @@ int mod_verify_sig(const void *mod, struct load_info *info)
 	size_t sig_len, modlen = info->len;
 	int ret;
 
-	pr_devel("==>%s(,%zu)\n", __func__, modlen);
-
 	if (modlen <= sizeof(ms))
 		return -EBADMSG;
 

-- 
2.54.0

