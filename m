Received: from smtp.eurecom.fr (smtp.eurecom.fr [193.55.113.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C829478F2E
	for <linux-security-module@vger.kernel.org>; Sun, 29 Jun 2025 12:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.55.113.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751198672; cv=none; b=jAA04Jl4kkrsMu1uIvxfkmRReOk2S2tDahPiYT0+w8i1mSK0+vdscNrHm0c8fl/NS86z6LS6vslSTUWaXRMLP1EHZMNsoI/1cAPXbxs3Jx7GJHyGZUS2SwvS2JKpvVBrkEaxfgH8HovpSywTagkQ4LChXrWwiOybuwqbo7aLXGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751198672; c=relaxed/simple;
	bh=dwZHe49PCtDMVmCsKzYlISJ8cwHJTQvM1YYb6a3TYRg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tDzSaT+h+w0rYdVdtHXJaNoAa667tIjyuybVnmIIdchtPitv9YzjJi18KgeiEe0qvQXnIPEOOdb1TLk6aAK8VuMW8U0N5/2RcNND/Tk3bCQKQZYdE6AW4lGYDPwN2Z93u37GXrWABlBK3c04o+h0nFfhGxoy4Md8Yl7NucrNC4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr; spf=pass smtp.mailfrom=eurecom.fr; dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b=N5qBEX1g; arc=none smtp.client-ip=193.55.113.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eurecom.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b="N5qBEX1g"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=eurecom.fr; i=@eurecom.fr; q=dns/txt; s=default;
  t=1751198670; x=1782734670;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dwZHe49PCtDMVmCsKzYlISJ8cwHJTQvM1YYb6a3TYRg=;
  b=N5qBEX1gR+YmaVs5MELgWGcbGQB1yfNkxPwlZ9esyIpSoW7BIyL0DhJU
   9TCa2QC5XbkjnkWqhRu7qZibvMM7v+m7VMjIrLxlT/QoB34Exe6pDZhDF
   wxvAuryqrOg18Bb3hvOo9LO2KASekGShoGKy3ATEmC9SgkEWQAyFaNyS0
   w=;
X-CSE-ConnectionGUID: q2KKUFEATcuh8YjpOsSlaQ==
X-CSE-MsgGUID: 2GS2CilSRTmfiwIyhJulFg==
X-IronPort-AV: E=Sophos;i="6.16,275,1744063200"; 
   d="scan'208";a="1972332"
Received: from waha.eurecom.fr (HELO smtps.eurecom.fr) ([10.3.2.236])
  by drago1i.eurecom.fr with ESMTP; 29 Jun 2025 14:03:18 +0200
Received: from s76.. (88-183-119-157.subs.proxad.net [88.183.119.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtps.eurecom.fr (Postfix) with ESMTPSA id 345D42B52;
	Sun, 29 Jun 2025 14:03:17 +0200 (CEST)
From: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>
To: linux-security-module@vger.kernel.org
Cc: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>,
	Serge Hallyn <serge@hallyn.com>,
	"Andrew G . Morgan" <morgan@kernel.org>
Subject: [PATCH 0/1] uapi: fix broken link in linux/capability.h
Date: Sun, 29 Jun 2025 14:03:00 +0200
Message-Id: <20250629120301.1702897-1-ariel.otilibili-anieli@eurecom.fr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This patch fixes a broken link to the libcap library. Moreover it gives the full reference of its compliance with POSIX.

The README of libcap2 says it is based on Draft 15 [1]; but, as far as I could see, only copies of Draft 17 exist online [2, 3].

Your feedback is much appreciated,
Ariel

[1] https://git.kernel.org/pub/scm/libs/libcap/libcap.git/tree/README
[2] https://drive.google.com/file/d/16yTUA10JLyi6zKky9_KBu7P8FpZrprl3/view?usp=sharing
[3] https://simson.net/ref/1997/posix_1003.1e-990310.pdf

Ariel Otilibili (1):
  uapi: fix broken link in linux/capability.h

 include/uapi/linux/capability.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.34.1

