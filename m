Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8777A45957;
	Wed, 31 Jul 2024 21:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722461675; cv=none; b=fAXI2d1l7WZAGo4VRMXJYOz/S05iPIPZ1X3uVdeV84qqNkFS6t/FGIHpVjwQevRFubyV8dP3TGEu13H+DOsvZ04r7JolTP0+yc22JPCvZcecAONTqgm/cpdIPseMJT0gsP6iji95XV5MkQfRk0mZIDL1iA1/Ssgb5cyo0vd1UWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722461675; c=relaxed/simple;
	bh=lr6RndWb/v97/nsxy7O9GZ+yCqur6+qPiC4EmRPnwws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EhLk/zA768cCpk4SUGzUAlO71cVYQJH4DKh2yKVXj419wiWPM9TdGICBaC+iWJC59HHKHK14q1tYiHkzTJloklRBdJQuhosNiStZDwXpe8qvIhhdsgVI7rcMhA4ZzSQCxu+2FBy+40D9L/854olYoHKtD9qXmjuK74gT8N7hgzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MS0qMhVL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MS0qMhVL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEECAC116B1;
	Wed, 31 Jul 2024 21:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722461675;
	bh=lr6RndWb/v97/nsxy7O9GZ+yCqur6+qPiC4EmRPnwws=;
	h=From:To:Cc:Subject:Date:From;
	b=MS0qMhVL5wCt5bFwEaXjK01fwm/rMkFRUFRqDy2k4EU9M2XvEnFQj3yCgcRFf7qhC
	 kRkiW262Lwi9ChozOSiKW564hZXoupHLo/xbjgkMgB31TnCr8SM85KgeOb9jJvoNp6
	 TJqzFQTla+cWTa3tqIiNrrW7i7VIiT683g1yTiODcMrLzK2xXEhbnRAtbAACvt0hRq
	 vyoPPBrblaKSvhVkmcaDSFpeUaMxxf/U7CD7tCXAhjC/OagdXEoqlLpCmAoILgKwHi
	 aSLysAYeStf8BbSKH8bkWxr4yRDccTrE3MDj+f2sqy+F28mjjwd79UgQz8x9GKyrCt
	 rgN6NvOOZF01w==
From: KP Singh <kpsingh@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: paul@paul-moore.com,
	kpsingh@kernel.org,
	bp@alien8.de,
	sfr@canb.auug.org.au
Subject: [PATCH] init/main.c: Do jump_label_init before early_security_init
Date: Wed, 31 Jul 2024 23:34:29 +0200
Message-ID: <20240731213429.2244234-1-kpsingh@kernel.org>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LSM indirect calls being are now replaced by static calls, this requires
a jumpt_table_init before early_security_init where LSM hooks and their
static calls and keys are initialized.

Fixes: 2732ad5ecd5b ("lsm: replace indirect LSM hook calls with static calls")
Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 init/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/init/main.c b/init/main.c
index 206acdde51f5..5bd45af7a49e 100644
--- a/init/main.c
+++ b/init/main.c
@@ -922,6 +922,8 @@ void start_kernel(void)
 	boot_cpu_init();
 	page_address_init();
 	pr_notice("%s", linux_banner);
+	/* LSM and command line parameters use static keys */
+	jump_label_init();
 	early_security_init();
 	setup_arch(&command_line);
 	setup_boot_config();
@@ -933,8 +935,6 @@ void start_kernel(void)
 	boot_cpu_hotplug_init();
 
 	pr_notice("Kernel command line: %s\n", saved_command_line);
-	/* parameters may set static keys */
-	jump_label_init();
 	parse_early_param();
 	after_dashes = parse_args("Booting kernel",
 				  static_command_line, __start___param,
-- 
2.46.0.rc2.264.g509ed76dc8-goog

