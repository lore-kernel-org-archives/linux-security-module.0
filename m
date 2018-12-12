Return-Path: <SRS0=0itc=OV=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F12FC65BAF
	for <linux-security-module@archiver.kernel.org>; Wed, 12 Dec 2018 17:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AB9720839
	for <linux-security-module@archiver.kernel.org>; Wed, 12 Dec 2018 17:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nonadev.net header.i=@nonadev.net header.b="lIBUp8BT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AB9720839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nonadev.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbeLLRcl (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 12 Dec 2018 12:32:41 -0500
Received: from erza.lautre.net ([80.67.160.89]:60177 "EHLO erza.lautre.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727691AbeLLRck (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 12 Dec 2018 12:32:40 -0500
X-Greylist: delayed 341 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Dec 2018 12:32:40 EST
Received: from d-jobol.iot.bzh (por56-1-78-229-206-229.fbx.proxad.net [78.229.206.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by erza.lautre.net (Postfix) with ESMTPSA id 4D0E74594F;
        Wed, 12 Dec 2018 18:26:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=nonadev.net;
        s=alternc; t=1544635618;
        bh=L/hxp+9KBG+e5/FuLIGwge7Tm5hTdlWignq8gOJYxf4=;
        h=Date:From:To:Subject;
        b=lIBUp8BT1zjQxsb7Y+xRYa6SzbyrZnk+CERfaerHBIZaa5l4ta4pU6STJuLN5qLEc
         XhVVVkpKmjd3GM0VJE6fGnc0Pr4aVCmCSuRlguzBhsuREaXi46P9q8yXDUk8MBPaEj
         iPWb7VC/izr34ccbCJii5RiFRaw3TLSeeTyH/mtQ=
Date:   Wed, 12 Dec 2018 18:26:57 +0100
From:   =?UTF-8?B?Sm9zw6k=?= Bollo <jobol@nonadev.net>
To:     casey@schaufler-ca.com, linux-security-module@vger.kernel.org
Subject: [PATCH] Smack: Improve documentation
Message-ID: <20181212182657.45205ad1@d-jobol.iot.bzh>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Add some words about the mount option "smackfstransmute=3Dlabel".

Signed-off-by: Jos=C3=A9 Bollo <jobol@nonadev.net>
---
 Documentation/admin-guide/LSM/Smack.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/admin-guide/LSM/Smack.rst
b/Documentation/admin-guide/LSM/Smack.rst index
6a5826a13aea..2d5e3e79d190 100644 ---
a/Documentation/admin-guide/LSM/Smack.rst +++
b/Documentation/admin-guide/LSM/Smack.rst @@ -818,6 +818,10 @@ Smack
supports some mount options: specifies a label to which all labels set
on the filesystem must have read access. Not yet enforced.
=20
+  smackfstransmute=3Dlabel:
+        behaves exactly like smackfsroot except that it also
+        set the transmuting flag on the root of the mount
+
 These mount options apply to all file system types.
=20
 Smack auditing
--=20
2.17.2
