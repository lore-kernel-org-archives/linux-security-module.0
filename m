Received: from blizzard.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5539A39ACC;
	Mon, 26 Aug 2024 10:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724669398; cv=none; b=IAoa/yaupTOAX8ONdfCq9aa4R41hhwybx0KEmb1Rne4xZYXX/cphof+cv09uVx+UhWo08eTDpflHLfTRL6KeU2AquXDDQD846EDidvsXGZ4k805YdfPtYFbHeePUGZBTvPVRZvH83wWUTniHGFZrZYz+NJEh552BK6JWh07tNq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724669398; c=relaxed/simple;
	bh=rbU4Y17++Pv9h75lBxpFvTz5+XkNgT7DcwoBJKeq984=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iIYf0OhMIcB5Ud78DMjVdhvkCrAmoQceKdzUakvvECQ7FPRBo7BIWr+HVhy9vFaNeUcubAPORpshNeX9WAGuKS2xq6iXI3q/N6MD7MIjSVFPq5RZv0oh1zRPwieptaZRPxhrTl87E6X+48uHSeOXID9zlIR+G3t32vK7J4WCyTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjellic.com
Received: from blizzard.enjellic.com (localhost [127.0.0.1])
	by blizzard.enjellic.com (8.15.2/8.15.2) with ESMTP id 47QAbU7q003405;
	Mon, 26 Aug 2024 05:37:30 -0500
Received: (from greg@localhost)
	by blizzard.enjellic.com (8.15.2/8.15.2/Submit) id 47QAbUsB003404;
	Mon, 26 Aug 2024 05:37:30 -0500
X-Authentication-Warning: blizzard.enjellic.com: greg set sender to greg@enjellic.com using -f
From: Greg Wettstein <greg@enjellic.com>
To: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jmorris@namei.org
Subject: [PATCH v4 01/14] Update MAINTAINERS file.
Date: Mon, 26 Aug 2024 05:37:15 -0500
Message-Id: <20240826103728.3378-2-greg@enjellic.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240826103728.3378-1-greg@enjellic.com>
References: <20240826103728.3378-1-greg@enjellic.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 958e935449e5..f4a5772ea255 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22824,6 +22824,14 @@ S:	Maintained
 F:	Documentation/tee/ts-tee.rst
 F:	drivers/tee/tstee/
 
+TSEM SECURITY MODULE
+M:	Greg Wettstein <greg@enjellic.com>
+S:	Maintained
+L:	linux-security-module@vger.kernel.org
+F:	Documentation/admin-guide/LSM/tsem.rst
+F:	Documentation/ABI/testing/tsem
+F:	security/tsem/
+
 TTY LAYER AND SERIAL DRIVERS
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 M:	Jiri Slaby <jirislaby@kernel.org>
-- 
2.39.1

