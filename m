Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3868FC5519F
	for <linux-security-module@archiver.kernel.org>; Wed, 18 Nov 2020 21:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B893E246B8
	for <linux-security-module@archiver.kernel.org>; Wed, 18 Nov 2020 21:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="f/Fhd1G4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgKRVQS (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 18 Nov 2020 16:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbgKRVQS (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 18 Nov 2020 16:16:18 -0500
X-Greylist: delayed 1768 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 18 Nov 2020 13:16:17 PST
Received: from mx0b-00206401.pphosted.com (mx0b-00206401.pphosted.com [IPv6:2620:100:9005:15::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C518C0613D4
        for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2020 13:16:17 -0800 (PST)
Received: from pps.filterd (m0207805.ppops.net [127.0.0.1])
        by mx0b-00206401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0AIKftZN007030;
        Wed, 18 Nov 2020 12:46:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=default; bh=dSzpT62BI0ruz7pajvwyPXPz/bgceVVR7fecePnsO+E=;
 b=f/Fhd1G4E//5xR0i2q7nuqO64VzMmJ6MWZ6RJtWrJ9t4YZ34xPgqdy7cdtLVstCHL5BS
 c64npFtOo+g7CdL6hLyhTFVUjXJzaj+w/ykMT93GdQP3WdG1qZWbhFSp3DAnlp9MSZUg
 X1vTx3qR42ArebTP+WeMCoXx5InroTwarhl78qn5/HjIG2GgW4V/nZ4YPmpb5QN4vp1O
 RsyinibXyy4Cr9CuKOHtxVzcnxct1qz383yR/WQuHUN1XO3qfh+EeE9QjcVwjZmtotJ8
 tZMKkgGUvca6PU4E3WeeCoFsapRFYzpAjTIgNXWCDTE28T16c6djKayELlt23aqMT4lS ow== 
Received: from ee01.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60])
        by mx0b-00206401.pphosted.com with ESMTP id 34tea2wmda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 18 Nov 2020 12:46:43 -0800
From:   Martin Kelly <martin.kelly@crowdstrike.com>
To:     "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
CC:     Casey Schaufler <casey@schaufler-ca.com>
Subject: Question about security_file_open contract
Thread-Topic: Question about security_file_open contract
Thread-Index: Ada96ulpbZOS9v6rTAGoQ5nKsNhj6Q==
Date:   Wed, 18 Nov 2020 20:44:38 +0000
Deferred-Delivery: Wed, 18 Nov 2020 20:42:00 +0000
Message-ID: <2bf667b20edc407786778c00b0c375b5@casmbox08.crowdstrike.sys>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.100.11.84]
x-disclaimer: USA
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-18_08:2020-11-17,2020-11-18 signatures=0
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi,

I'm debugging a thorny problem and want to verify my understanding about th=
e
expected contract between LSM and kernel drivers. Specifically, I'm hitting
an issue in which the following occurs:

- A process exits, calling task_exit().
- exit_fs() is called, setting current->fs =3D NULL.
- Next, exit_task_work() is called, which calls fput().
- In response to the fput(), the filesystem opens a file to update some
metadata, calling dentry_open().
- dentry_open() calls security_file_open(), calling into the LSM. The LSM
crashes because it assumes it's called from process context and thus
current->fs is not NULL.

I'm trying to figure out exactly what the contract is here. Is it safe for
an LSM to assume current->fs should be non-NULL when security_file_open is
called?  More generally, is it safe for an LSM to assume that
security_file_open will always be called from process context? In other
words, is the LSM at fault here or the driver?

Thanks,
Martin
