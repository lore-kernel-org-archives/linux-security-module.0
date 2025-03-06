Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373A825D52E
	for <linux-security-module@vger.kernel.org>; Thu,  6 Mar 2025 18:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741284381; cv=none; b=b2StB0No4MdenVwJZ2+QtN0BVqRyWFJO/dib8/TTBHb0AsdhlC6AQki/6hJWdN0oK1whqGRmMiFORuzWmjcQJ7omRwPiCJy4riFUvhG9KfKLTMTWRwr8h70m+uJqTNhfeQ7pVEEs9RV5HqIZpj1HOG8hGpTkBqfYSG3mb4tj48w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741284381; c=relaxed/simple;
	bh=rN+WqF4ILqJj0LqnvdMi65ZXBQQSJKmc3PIJcPSLZ8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F5OQycn2QvS5osPrEITBHTTOJS2iFkC8ZspDge0s2RaChQB+E2Ux0eCY/O/wPf74lG1NP9nRrTzdtchVd7ufZKyr3g56THFIS6lYImRpWdD6lzrx8jI+oQH362JBnJWEt3S/ZnWBBts6W66oOIL20YmWrud6oY8No7dHt66TpBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=K1FqGkKD; arc=none smtp.client-ip=185.125.25.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="K1FqGkKD"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Z7y5q488LzQ9K;
	Thu,  6 Mar 2025 19:06:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1741284367;
	bh=3JI5Rcw04EKLLqRlbpDufnmcpPAmiwm0as3R8IpscuE=;
	h=From:To:Cc:Subject:Date:From;
	b=K1FqGkKDoe08mla0xewYU4bwIYrb2ndBOmxVoSE0BOIpdxSsFBx2KyuMMv7zO4v9J
	 vd86adf8Nz8h3uF6Vck3qJ9eo3MVfarHYmB9hpMxLb4R8dmAEGYMu2grJFVjLibJ9S
	 o+5SnZhetXSHF9ifJAzLbGSHkeBUriCqOZZY18/k=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Z7y5q1MpRzH5Q;
	Thu,  6 Mar 2025 19:06:07 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Kees Cook <kees@kernel.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] samples/check-exec: Fix script name
Date: Thu,  6 Mar 2025 19:05:58 +0100
Message-ID: <20250306180559.1289243-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

run-script-ask.sh had an incorrect file extension.  This helper script
is not used by kselftests.

Cc: Kees Cook <kees@kernel.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 samples/check-exec/{run-script-ask.inc => run-script-ask.sh} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename samples/check-exec/{run-script-ask.inc => run-script-ask.sh} (100%)

diff --git a/samples/check-exec/run-script-ask.inc b/samples/check-exec/run-script-ask.sh
similarity index 100%
rename from samples/check-exec/run-script-ask.inc
rename to samples/check-exec/run-script-ask.sh
-- 
2.48.1

