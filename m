Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch [84.16.66.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A852116FC
	for <linux-security-module@vger.kernel.org>; Fri, 10 Jan 2025 15:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736523572; cv=none; b=YyP71zAfGTiQBv5g/bOflftablePskzxLr0HGD+EDz0LCR/1eSUrTtJgYCqc2XbfuAz4RQshOw4gy3IgPdTQnVD2ZxJCYcYG6v8m4JkfUcm/f56TgeT1SpwoOHJWJ0Fpln7OKDVXTekttcrFKaQ/XWslAhkuGhPlzZeO+ihQpsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736523572; c=relaxed/simple;
	bh=/PlasUUg+tCGz3EHMvkEX/mc5natk/yUYrZEcdMowco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dVoDrYJHT3eOZ1M6htOWFOBKFZaF4MApVsjcHKU2OT5ONEN0CIC4CePdQADYFP0zHLkWhmqjmeF+fbpm/OarZ8VO21mMS5DbR8lQmMeRt1h5m9k//g5adVdk7F/s/icgS2kTlKQ87FH40WEKME3J+CmMfby5PwtixyPXY/I1jrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=P2meaDr+; arc=none smtp.client-ip=84.16.66.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="P2meaDr+"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YV5S00bF7z48X;
	Fri, 10 Jan 2025 16:39:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1736523567;
	bh=AsHxtaI/j0xAJpUvjMF5GGxk6M6C8AwNGet+DOF16/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P2meaDr+yvTyyWxF4mFKaRzgKZwGy+K3iASGZUsDnRCyTmnC7qiUh70RhIoeS6r8e
	 7u9+vjel70PKagbJGyaR929v7mZtAJbcsdpgpOF+OTxMWQ6NQ2kUOu+IZeQc/CnKFW
	 BjJDgD6nBK2cfkesZHTXwWkRVTGu1zysxHyV1V4Y=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4YV5Rz3J9ZzKnD;
	Fri, 10 Jan 2025 16:39:27 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>
Subject: [PATCH v1 2/2] landlock: Constify get_mode_access()
Date: Fri, 10 Jan 2025 16:39:14 +0100
Message-ID: <20250110153918.241810-2-mic@digikod.net>
In-Reply-To: <20250110153918.241810-1-mic@digikod.net>
References: <20250110153918.241810-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Use __attribute_const__ for get_mode_access().

Cc: Günther Noack <gnoack@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/landlock/fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 7adb25150488..f81d0335b825 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -932,7 +932,7 @@ static int current_check_access_path(const struct path *const path,
 	return check_access_path(dom, path, access_request);
 }
 
-static access_mask_t get_mode_access(const umode_t mode)
+static __attribute_const__ access_mask_t get_mode_access(const umode_t mode)
 {
 	switch (mode & S_IFMT) {
 	case S_IFLNK:
-- 
2.47.1

