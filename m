Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5681EB4B1;
	Thu,  1 Aug 2024 17:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722532676; cv=none; b=p1AUYP8Z5WsKhyFCBtLoHH+o+9AtN6QaUjn7ZC45+ZqX+US5tt3VRb0VxJSo9GaXpxocayibfiQpGB98TL1VRp0TWyD+t19itN+Np5HZ1uXZG4aDv1crnM7EolmuAXHraf65MTOy5EznPVt9g39pLG/oIFNGaoA6M+4zouCTDIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722532676; c=relaxed/simple;
	bh=odKPgBOSNRs0Y2jlCbXWxM4uE1V80TnGSEwMr5VIZP0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IOKexTtu/p4wXYEyt0cywPPDmR0Y4eyz7D7YEYgR3Vt3xMxr4WUxuRiDSCRlyG0qiDRhCp6Iw8DrI4Qf3TB97j363ENWzke8Ne8hwy/3Xgoyyn20lDoQNc8x8VuQKzuH25HQxXUemKVS8+xvm+CoTUkdBmjhPofpq8R9jYuwJu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVI73tov; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVI73tov"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE297C32786;
	Thu,  1 Aug 2024 17:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722532675;
	bh=odKPgBOSNRs0Y2jlCbXWxM4uE1V80TnGSEwMr5VIZP0=;
	h=From:To:Cc:Subject:Date:From;
	b=DVI73tovSQPGzrRnpCa3pVuK5LO74ZjbwAMzzu/LLic3WtRd/EQerHvdfW71kr6OJ
	 ZZ2XDurkqpVGBmmKziRA0zC2E46QsL1GPoND9piDR7pQcINf5Wa5ij5Y2W+Kqt9LyK
	 q1IHoPp2NwZc1GbvMiYGWeMJlN22ofzqeFoCAdFfCsW9NrEa13IWVxOcpCEI89PgWl
	 FLFP5PZL6+n6Xfziwo47yotA3UdHRjBCyXd62f3APTwNeIyoT/2RkeePLQKE+3Rb4F
	 2V+A2qaX37SJYhz1E4muChcencdjCVESosSucbUc992BNt18efbgWKdbNTO5MoZhxI
	 WWL/YtDHN09Aw==
From: KP Singh <kpsingh@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: paul@paul-moore.com,
	kpsingh@kernel.org,
	bp@alien8.de,
	sfr@canb.auug.org.au,
	peterz@infradead.org,
	nathan@kernel.org
Subject: [PATCH] init/main.c: Initialize early LSMs after arch code
Date: Thu,  1 Aug 2024 19:17:47 +0200
Message-ID: <20240801171747.3155893-1-kpsingh@kernel.org>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With LSMs using static calls, early_lsm_init needs to wait for setup_arch
for architecture specific functionality which includes jump tables and
static calls to be initialized.

This only affects "early LSMs" i.e. only lockdown when
CONFIG_SECURITY_LOCKDOWN_LSM_EARLY is set.

Fixes: 2732ad5ecd5b ("lsm: replace indirect LSM hook calls with static calls")
Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 init/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/main.c b/init/main.c
index 206acdde51f5..a0e3f3c720e6 100644
--- a/init/main.c
+++ b/init/main.c
@@ -922,8 +922,8 @@ void start_kernel(void)
 	boot_cpu_init();
 	page_address_init();
 	pr_notice("%s", linux_banner);
-	early_security_init();
 	setup_arch(&command_line);
+	early_security_init();
 	setup_boot_config();
 	setup_command_line(command_line);
 	setup_nr_cpu_ids();
-- 
2.46.0.rc2.264.g509ed76dc8-goog

