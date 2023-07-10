Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7375AEB64D9
	for <linux-security-module@archiver.kernel.org>; Mon, 10 Jul 2023 11:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjGJLCt (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 10 Jul 2023 07:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjGJLCs (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 10 Jul 2023 07:02:48 -0400
X-Greylist: delayed 1735 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 10 Jul 2023 04:02:47 PDT
Received: from blizzard.enjellic.com (wind.enjellic.com [76.10.64.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 53203CE;
        Mon, 10 Jul 2023 04:02:47 -0700 (PDT)
Received: from blizzard.enjellic.com (localhost [127.0.0.1])
        by blizzard.enjellic.com (8.15.2/8.15.2) with ESMTP id 36AANKcM019744;
        Mon, 10 Jul 2023 05:23:20 -0500
Received: (from greg@localhost)
        by blizzard.enjellic.com (8.15.2/8.15.2/Submit) id 36AANK2Q019742;
        Mon, 10 Jul 2023 05:23:20 -0500
X-Authentication-Warning: blizzard.enjellic.com: greg set sender to greg@enjellic.com using -f
From:   "Dr. Greg" <greg@enjellic.com>
To:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net
Subject: [PATCH 01/13] Update MAINTAINERS file.
Date:   Mon, 10 Jul 2023 05:23:07 -0500
Message-Id: <20230710102319.19716-2-greg@enjellic.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230710102319.19716-1-greg@enjellic.com>
References: <20230710102319.19716-1-greg@enjellic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Add an entry to the MAINTAINERS file to document the maintainer's
address and files relevant to the Trusted Security Event Modeling
system (TSEM).

Signed-off-by: Greg Wettstein <greg@enjellic.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 35e19594640d..4660c972d5e3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19026,6 +19026,14 @@ F:	include/uapi/linux/selinux_netlink.h
 F:	scripts/selinux/
 F:	security/selinux/
 
+TSEM SECURITY MODULE
+M:	Greg Wettstein <greg@enjellic.com>
+S:	Maintained
+L:	linux-security-module@vger.kernel.org
+F:	Documentation/admin-guide/LSM/tsem.rst
+F:	Documentation/ABI/testing/tsemfs
+F:	security/tsem/
+
 SENSABLE PHANTOM
 M:	Jiri Slaby <jirislaby@kernel.org>
 S:	Maintained
-- 
2.39.1

