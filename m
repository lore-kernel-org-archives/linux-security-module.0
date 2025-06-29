Received: from smtp.eurecom.fr (smtp.eurecom.fr [193.55.113.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD35978F2E
	for <linux-security-module@vger.kernel.org>; Sun, 29 Jun 2025 12:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.55.113.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751198616; cv=none; b=XEy8H1iusa0Y/czCiVontbZwiOqYCC6UbZ0bq+iD+nNpkynCFiKUsgMlogaRkBygsZt3z8UnpiIpoM+JImFc2JGTCpF2QyYcBMCrfuoUsnwY7eiy02adlS3o7TOBuhrrZ2A08vNMTnBVW1uvTHq2KR/N6/fqW9HZ4z2tScVs/UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751198616; c=relaxed/simple;
	bh=Wf77jwR5XI8CpZdD00ogisakj6eAB3rzeNATzIWMHDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UQNG0hq4IAzZY95eYwYEDADuDiprKS6ZQbOBr80AVevSR4m2q7/xZHuXKZ/Fmcrxhbw1AZsIKgDKt4oYo24HUJNqG6J8LFh1uRVKQ3r8gmEkDrQDdyJhqRDAX0hWWMgf54o7dHfuMsvMyNX+/mjxFBWxppvdoJYWVE+KpT7id0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr; spf=pass smtp.mailfrom=eurecom.fr; dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b=peKCN4lG; arc=none smtp.client-ip=193.55.113.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eurecom.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b="peKCN4lG"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=eurecom.fr; i=@eurecom.fr; q=dns/txt; s=default;
  t=1751198614; x=1782734614;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wf77jwR5XI8CpZdD00ogisakj6eAB3rzeNATzIWMHDQ=;
  b=peKCN4lGtkD+o9DeOirOSg0L6dEr9sJYlrxtRR35TvnFqmPUGIhXKRzY
   9CYjYWAKe5/mwN2yMzxcs3sNMc7F5iysZc4gzb2K6OX37+QihH5zqseck
   hbQJ3S1wMdWMgCkTs6Mi6GRk/epS1IL2cGR7Q54OpcAwgdcF/+UqwUaqx
   U=;
X-CSE-ConnectionGUID: q2whxXu+QkOKGis2j3daHw==
X-CSE-MsgGUID: f+dl+bwTT/GFEafKDwuPww==
X-IronPort-AV: E=Sophos;i="6.16,275,1744063200"; 
   d="scan'208,217";a="1972335"
Received: from waha.eurecom.fr (HELO smtps.eurecom.fr) ([10.3.2.236])
  by drago1i.eurecom.fr with ESMTP; 29 Jun 2025 14:03:32 +0200
Received: from s76.. (88-183-119-157.subs.proxad.net [88.183.119.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtps.eurecom.fr (Postfix) with ESMTPSA id E9F8C2B53;
	Sun, 29 Jun 2025 14:03:30 +0200 (CEST)
From: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>
To: linux-security-module@vger.kernel.org
Cc: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>,
	Serge Hallyn <serge@hallyn.com>,
	"Andrew G . Morgan" <morgan@kernel.org>
Subject: [PATCH 1/1] uapi: fix broken link in linux/capability.h
Date: Sun, 29 Jun 2025 14:03:01 +0200
Message-Id: <20250629120301.1702897-2-ariel.otilibili-anieli@eurecom.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250629120301.1702897-1-ariel.otilibili-anieli@eurecom.fr>
References: <20250629120301.1702897-1-ariel.otilibili-anieli@eurecom.fr>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The link to the libcap library is outdated:

> $ curl "https://www.kernel.org/pub/linux/libs/security/linux-privs/kernel-2.6/"
>
> <html>
> <head><title>Index of /pub/linux/libs/security/linux-privs/kernel-2.6/</title></head>
> <body>
> <h1>Index of /pub/linux/libs/security/linux-privs/kernel-2.6/</h1><hr><pre><a href="../">../</a>
> </pre><hr></body>
> </html>

Instead, use a link to the libcap2 library:

> $ curl "https://www.kernel.org/pub/linux/libs/security/linux-privs/libcap2/"
>
> <html>
> <head><title>Index of /pub/linux/libs/security/linux-privs/libcap2/</title></head>
> <body>
> <h1>Index of /pub/linux/libs/security/linux-privs/libcap2/</h1><hr><pre><a href="../">../</a>
> <a href="old/">old/</a>                                               08-Nov-2007 06:34       -
> <a href="libcap-2.00.tar.gz">libcap-2.00.tar.gz</a>                                 11-Jan-2014 16:49     37K
> <a href="libcap-2.00.tar.sign">libcap-2.00.tar.sign</a>                               11-Jan-2014 16:49     819
> [...]
> <a href="libcap-2.76.tar.sign">libcap-2.76.tar.sign</a>                               13-Apr-2025 18:20     833
> <a href="libcap-2.76.tar.xz">libcap-2.76.tar.xz</a>                                 13-Apr-2025 18:20    195K
> <a href="sha256sums.asc">sha256sums.asc</a>                                     13-Apr-2025 18:25     14K
> </pre><hr></body>
> </html>

As well, give the complete reference of the POSIX compliance.

Signed-off-by: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>
---
Cc: Serge Hallyn <serge@hallyn.com>
Cc: Andrew G. Morgan <morgan@kernel.org>
---
 include/uapi/linux/capability.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/capability.h b/include/uapi/linux/capability.h
index 2e21b5594f81..ea5a0899ecf0 100644
--- a/include/uapi/linux/capability.h
+++ b/include/uapi/linux/capability.h
@@ -6,9 +6,10 @@
  * Alexander Kjeldaas <astor@guardian.no>
  * with help from Aleph1, Roland Buresund and Andrew Main.
  *
- * See here for the libcap library ("POSIX draft" compliance):
+ * See here for the libcap2 library (compliant with Section 25 of
+ * the withdrawn POSIX 1003.1e Draft 17):
  *
- * ftp://www.kernel.org/pub/linux/libs/security/linux-privs/kernel-2.6/
+ * https://www.kernel.org/pub/linux/libs/security/linux-privs/libcap2/
  */
 
 #ifndef _UAPI_LINUX_CAPABILITY_H
-- 
2.34.1

