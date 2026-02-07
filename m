Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352021A239A
	for <linux-security-module@vger.kernel.org>; Sat,  7 Feb 2026 11:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770463682; cv=none; b=sxVIt5Uig7y7Z+3+BaH0s1e7/dybD+B+r1GU/RKMMgwVnz1N3QlPKB9sg0uEkb5NiG3XvozVOa5VfXB8fXyle7Cvtj0dbJ6WApK93MvhvIP7/Gltr2i173xl02s2dEfjECTLo2IPXmenIEYp58KyuimwR8lM1MXBkk6XbQ+9FLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770463682; c=relaxed/simple;
	bh=HEzcP5cl/jKaJ71NDTHevYxVQGvgs1Qvb+5UCWLQ8AA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RA4tu0EQKk6J71sg0Xo/zYAwBm7zuuMU7vzNnJHlqDjYz+jZIm9YaRSwJzu1W26SYyW59Od+Cgu0I96YQ5GiHAhrTw/bIsyq3i6B5X24qJ0Rjsk9ac/mV5P9BPySSFCfNrJrwCp1xpbwil4tlMuyzzk/AYvvk21cEdP6lig0Pag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Q3b73wVC; arc=none smtp.client-ip=83.166.143.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Q3b73wVC"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4f7Svl5mN5zY0H;
	Sat,  7 Feb 2026 12:11:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1770462707;
	bh=UoVtAS2Jof8vX5026Z9cSNgwqZLbIT760bNdfLH7Jbc=;
	h=From:To:Cc:Subject:Date:From;
	b=Q3b73wVCJa7RzhEJtS88FNhw0R4h1SoGSH/2nUPKKSI0pSInNSpIWjD39llsnPSCZ
	 lAQ+SSjWBEdloPX0Qy5tUK/ngJq7oX3tv5CIqV+aQjtlsoboS5l3pZRP8+dbOolVAN
	 E8+qKdMUhLX/BkUajF+mNexmpmG4LJm3j2bjKHy8=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4f7Svl2BBmzCNX;
	Sat,  7 Feb 2026 12:11:47 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	James Morris <jamorris@linux.microsoft.com>
Subject: [PATCH v1] =?UTF-8?q?mailmap:=20Add=20entry=20for=20Micka=C3=ABl?= =?UTF-8?q?=20Sala=C3=BCn?=
Date: Sat,  7 Feb 2026 12:11:35 +0100
Message-ID: <20260207111136.577249-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

My Microsoft address is no longer used.  Add a mailmap entry to reflect
that.

Cc: Günther Noack <gnoack@google.com>
Cc: James Morris <jamorris@linux.microsoft.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 22db8cfc18fc..2f2a06e8d3f9 100644
--- a/.mailmap
+++ b/.mailmap
@@ -558,6 +558,7 @@ Michel Dänzer <michel@tungstengraphics.com>
 Michel Lespinasse <michel@lespinasse.org>
 Michel Lespinasse <michel@lespinasse.org> <walken@google.com>
 Michel Lespinasse <michel@lespinasse.org> <walken@zoy.org>
+Mickaël Salaün <mic@digikod.net> <mic@linux.microsoft.com>
 Miguel Ojeda <ojeda@kernel.org> <miguel.ojeda.sandonis@gmail.com>
 Mike Rapoport <rppt@kernel.org> <mike@compulab.co.il>
 Mike Rapoport <rppt@kernel.org> <mike.rapoport@gmail.com>
-- 
2.53.0

