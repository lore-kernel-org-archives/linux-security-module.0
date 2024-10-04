Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E721E3DCB
	for <linux-security-module@vger.kernel.org>; Fri,  4 Oct 2024 15:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728055905; cv=none; b=RzsJ0NlFPPx0j8DH5yzZdZHr2nkhL9AshO/7cZ3XDSgYunsNwYQW3MtDXAtxnFvebtV8BqQptkfVHSgZGlPSCcKNHpjj2zp4y7Mln0By1IPLifrZ5iQZy3S4Ch4dh+MuoC++omXbxU5L1MIn79cw1GEOtmv0qSssncI+Eom71Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728055905; c=relaxed/simple;
	bh=8vhNjG+/Qsat3GXCJeL6Mr/pUIKF5EDv8fG1E+sUygA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KHYMA1anNu+0kJYtPWSTmutnePlsueLNuBREty2Kh/M5PldvTOf2Gz4KEhT/VGHqxUEQ4Kea0undf8hcL6EjlrKNbKdSpNw7D4V5RxF+24hAOPdeyJNFkeRlzmzSoalN2KoZpX/MB48jQ8eAEdPpHClHTLpggJbo7rTZCb1PBxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=h5uESnQr; arc=none smtp.client-ip=84.16.66.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="h5uESnQr"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XKsw45m6JzTSv;
	Fri,  4 Oct 2024 17:31:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1728055892;
	bh=aqmuRMCU2iXnlf0025PN3bV3idGRHZy9Z2s4dXUSFBE=;
	h=From:To:Cc:Subject:Date:From;
	b=h5uESnQrMmKxDqVqPCYTKolga3L9/wejht7KoDnNhd3UETuNUoYSj3DAchStr5vHg
	 Bg7giHvOp1E09JSVlGuzvmfYPVccCl6tvh2bjmR5yj//Gpx5PHslSY3yqhQbUaZwSa
	 Gj9Bbqs/FL1tKxV59Z91Qy5F3H7LPhMxuMCM2eJI=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4XKsw34rF1zrfB;
	Fri,  4 Oct 2024 17:31:31 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Tahera Fahimi <fahimitahera@gmail.com>
Subject: [PATCH v1] landlock: Improve documentation of previous limitations
Date: Fri,  4 Oct 2024 17:31:20 +0200
Message-ID: <20241004153122.501775-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Improve consistency of previous limitations' subsection titles, and
expand a bit the IOCTL section.

This changes some HTML anchors and may break some external links though.

Cc: Günther Noack <gnoack@google.com>
Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc: Tahera Fahimi <fahimitahera@gmail.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 Documentation/userspace-api/landlock.rst | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index c8d3e46badc5..1febc71e2366 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -563,33 +563,34 @@ always allowed when using a kernel that only supports the first or second ABI.
 Starting with the Landlock ABI version 3, it is now possible to securely control
 truncation thanks to the new ``LANDLOCK_ACCESS_FS_TRUNCATE`` access right.
 
-Network support (ABI < 4)
--------------------------
+TCP bind and connect (ABI < 4)
+------------------------------
 
 Starting with the Landlock ABI version 4, it is now possible to restrict TCP
 bind and connect actions to only a set of allowed ports thanks to the new
 ``LANDLOCK_ACCESS_NET_BIND_TCP`` and ``LANDLOCK_ACCESS_NET_CONNECT_TCP``
 access rights.
 
-IOCTL (ABI < 5)
----------------
+Device IOCTL (ABI < 5)
+----------------------
 
 IOCTL operations could not be denied before the fifth Landlock ABI, so
 :manpage:`ioctl(2)` is always allowed when using a kernel that only supports an
 earlier ABI.
 
 Starting with the Landlock ABI version 5, it is possible to restrict the use of
-:manpage:`ioctl(2)` using the new ``LANDLOCK_ACCESS_FS_IOCTL_DEV`` right.
+:manpage:`ioctl(2)` on character and block devices using the new
+``LANDLOCK_ACCESS_FS_IOCTL_DEV`` right.
 
-Abstract UNIX socket scoping (ABI < 6)
---------------------------------------
+Abstract UNIX socket (ABI < 6)
+------------------------------
 
 Starting with the Landlock ABI version 6, it is possible to restrict
 connections to an abstract :manpage:`unix(7)` socket by setting
 ``LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET`` to the ``scoped`` ruleset attribute.
 
-Signal scoping (ABI < 6)
-------------------------
+Signal (ABI < 6)
+----------------
 
 Starting with the Landlock ABI version 6, it is possible to restrict
 :manpage:`signal(7)` sending by setting ``LANDLOCK_SCOPE_SIGNAL`` to the
-- 
2.46.1

