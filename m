Return-Path: <SRS0=/I77=BX=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3561EC433DF
	for <linux-security-module@archiver.kernel.org>; Thu, 13 Aug 2020 15:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBD032078D
	for <linux-security-module@archiver.kernel.org>; Thu, 13 Aug 2020 15:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bmw.de header.i=@bmw.de header.b="L8M84DUu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgHMPVP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 13 Aug 2020 11:21:15 -0400
Received: from esa1.hc324-48.eu.iphmx.com ([207.54.68.119]:32035 "EHLO
        esa1.hc324-48.eu.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726167AbgHMPVP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 13 Aug 2020 11:21:15 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Aug 2020 11:21:14 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1597332074; x=1628868074;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=m+kWdlHbxZ4OIsRYKBv9LGgoH+NPqdqAaHQgNUgUd+g=;
  b=L8M84DUuvPjZlG22INTUG0Ba0oKJ2YFf7o8nNTq19F/ZqZq5IongdtJ7
   sXtztYJQOx2CzgpZStpQpWd3qmdTwEZ7MBjzsWHjLOVBinBdlvJPhEG/Q
   Z36fBc6HumqhY1KC1w4LXh85HVZvhvELObU52qh3vAQNa+OlqYnikg7lC
   o=;
Received: from esagw6.bmwgroup.com (HELO esagw6.muc) ([160.46.252.49]) by
 esa1.hc324-48.eu.iphmx.com with ESMTP/TLS; 13 Aug 2020 17:14:05 +0200
Received: from esabb4.muc ([160.50.100.33])  by esagw6.muc with ESMTP/TLS;
 13 Aug 2020 17:14:05 +0200
Received: from smucm27m.bmwgroup.net (HELO smucm27m.europe.bmw.corp) ([160.46.167.34])
 by esabb4.muc with ESMTP/TLS; 13 Aug 2020 17:14:05 +0200
Received: from smucm27l.europe.bmw.corp (160.46.167.33) by smucm27m.europe.bmw.corp
 (160.46.167.34) with Microsoft SMTP Server (TLS;
 Thu, 13 Aug 2020 17:14:05 +0200
Received: from smucm27l.europe.bmw.corp ([160.46.167.33]) by
 smucm27l.europe.bmw.corp ([160.46.167.33]) with mapi id 15.00.1497.006; Thu,
 13 Aug 2020 17:14:05 +0200
From:   <Martin.U.Lang@bmw.de>
To:     <keescook@chromium.org>, <linux-security-module@vger.kernel.org>
Subject: Loadpin: Possibility of exceptions for certain firmwares?
Thread-Topic: Loadpin: Possibility of exceptions for certain firmwares?
Thread-Index: AdZxb4wfx4uDSW6hQrGa2itsKiChwA==
Date:   Thu, 13 Aug 2020 15:14:05 +0000
Message-ID: <6557a5ede7674fd69d6a610a2b39188d@smucm27l.europe.bmw.corp>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Kees, hi LSM community,

I'm currently struggling a bit with the bare simplicity of loadpin and tryi=
ng to understand which options exist for me.

We have the following situation:=20
Our root file system is integrity protected with dm-verity. During the deve=
lopment/validation stage, we create builds that use a test key for secure b=
oot.  For certain builds that successfully passed validation, we would like=
 to "promote" these builds to be a real release and sign them with the real=
 secure-boot/verified-boot release keys. This requires us to re-sign all se=
cure-boot signed artifacts (bootloaders, TEE, kernel, ...) including the dm=
-verity root hash(es) of the filesystem(s). During this re-signing process =
we do not want to touch the root file system (due to validation concerns) b=
ut only to provide new signatures for the dm-verity root hash.
As it turns out, some of the firmware blobs of our system are signed with t=
he secure boot keys of the system and this signature is validated somewhere=
 outside of the Linux kernel (by other firmware, by the TEE...). So, we wan=
ted to move those outside of the root filesystem in order to avoid changing=
 the file system as part of the release re-signing process. However, we the=
n noticed that the kernel driver seems to load these firmwares using the us=
ual firmware loader infrastructure of Linux. Consequently, loadpin kicks in=
, does its job and denies loading the firmware as it comes now from this ex=
tra partition.

So, I was wondering if adding an exception list to loadpin could be a reaso=
nable approach to this issue. If I understand the whole infrastructure corr=
ectly, the driver requests a firmware (file) by name. If I know on my syste=
m that the firmware with this name is self-contained secure-boot signed and=
 later-on validated independently anyways, there is no security benefit in =
letting loadpin enforce that it must come from my root fs. Consequently, I =
was thinking of adding a (configurable) exception list mechanism to loadpin=
 to accept certain firmwares (by name) even if they are not loaded from the=
 pinned fs.

Would you be open to such an extension of loadpin? If there are other sugge=
stions how this issue could be addressed, I'm also grateful for input. I wo=
uld like to see a solution that enables us to use loadpin as it saves quite=
 some effort on kernel module signing.

Best Regards,

Martin
