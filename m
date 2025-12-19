Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84592DC764
	for <linux-security-module@vger.kernel.org>; Fri, 19 Dec 2025 19:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766173171; cv=none; b=GcBLFv2BLpBAjB9AW5I9/eMMkCKHWGeghjJQXqADyelSzw+glHAExTwoqUxQI+m+uQBEDebAGRbK5dc24DHYkziH+FUUFfNHKGQ9eu1NpTeelgdCyAjPAw54cttTo7I9HLG1/yYzdI5R5LCtgko57b7BopK/v+WBW4MYUPI54UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766173171; c=relaxed/simple;
	bh=Skc8KfwLgWxzrtl13areLxAWNYwXiSMA5cxB3YJmSMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T+RADpaz220hPpdunzFuuTa5Bzy1pnMF4Ena3IjheJ0xN3pT4AoqS+SAhtt6WiRL40f99NLGn6RtvBPizukV6l9JBuF0BPgSEobwjAahLMQev3zKK8SO4XByjUXGsmmDokW9KenpVSGL8idyD0/xutTUo8Ccf3es5w1fKClvOB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=iPVb1qeA; arc=none smtp.client-ip=84.16.66.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="iPVb1qeA"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dXyXS2cc3zkkd;
	Fri, 19 Dec 2025 20:39:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1766173160;
	bh=4S3kUm+6krvC4IFRLqI11ZYj2NPP3g1KDCSzAm8pUbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iPVb1qeAQ/sF0O9e6rDrLndLrp+8Pbufqs96C0DYxRDH9XO1fuOHxbez31k90Wj58
	 WFboDWNmDZQgsEGDY461HmT0I+ovYjuZryEL3ntlhd+bvkdK5R1XehuGr+VWRmmSXX
	 4Vj/LI52RZSoMH48VQ8K/HNr5Ybg/CbGFbkzL2t4=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4dXyXR6PYhzSQ0;
	Fri, 19 Dec 2025 20:39:19 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: 
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH v1 4/5] landlock: Fix spelling
Date: Fri, 19 Dec 2025 20:38:50 +0100
Message-ID: <20251219193855.825889-4-mic@digikod.net>
In-Reply-To: <20251219193855.825889-1-mic@digikod.net>
References: <20251219193855.825889-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Cc: Günther Noack <gnoack3000@gmail.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/landlock/domain.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index 7fb70b25f85a..621f054c9a2b 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -97,7 +97,7 @@ struct landlock_hierarchy {
 	 */
 	atomic64_t num_denials;
 	/**
-	 * @id: Landlock domain ID, sets once at domain creation time.
+	 * @id: Landlock domain ID, set once at domain creation time.
 	 */
 	u64 id;
 	/**
-- 
2.52.0

