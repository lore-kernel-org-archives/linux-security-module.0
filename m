Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6108AC5519F
	for <linux-security-module@archiver.kernel.org>; Wed, 18 Nov 2020 22:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09CF2246E4
	for <linux-security-module@archiver.kernel.org>; Wed, 18 Nov 2020 22:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="ix2vDA8H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgKRWrt (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 18 Nov 2020 17:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgKRWrt (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 18 Nov 2020 17:47:49 -0500
Received: from mx0b-00206401.pphosted.com (mx0b-00206401.pphosted.com [IPv6:2620:100:9005:15::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3014AC0613D4
        for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2020 14:47:49 -0800 (PST)
Received: from pps.filterd (m0207805.ppops.net [127.0.0.1])
        by mx0b-00206401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0AIMh5sv017242;
        Wed, 18 Nov 2020 14:47:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com; h=from : to :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=default; bh=T+D13mPVy3gobpx/r8fnlDQkUZtlNkMJPqquLd8fO4A=;
 b=ix2vDA8HpMKtqSFEUaNqrVFWFZzleKCwMV/qW/yvheI4FX+oIwlRhZ8oKtVsCmVWoQRy
 2XoTyDJS6Q+7I03GirTt4cr1I67NxgI2WeFAn+o2HsyJ/vzx2nkKfyOh+2sRevGL/tKU
 JqyVIMJo1mUu3yG78X+wePWjVBQHrnjU9kSNsnEsLx08Rh5E4N0BjlcE0wkVtThdsMVS
 Iq3x7UW5Yfim7DXkKTIGofEfLbKn4WYrsNHKsHiHXjiSHWXRtEjTT6OiuXf9UJp+vjWq
 z4pRZgihA3AJECaAOjVLetns64dMfZ4A2eiVh3BcU07e3hOgd5AO+yd6lZqw6ROmliWV pA== 
Received: from ee01.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60])
        by mx0b-00206401.pphosted.com with ESMTP id 34tea2ws0d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 18 Nov 2020 14:47:46 -0800
From:   Martin Kelly <martin.kelly@crowdstrike.com>
To:     "casey@schaufler-ca.com" <casey@schaufler-ca.com>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: RE: Re: Question about security_file_open contract
Thread-Topic: Re: Question about security_file_open contract
Thread-Index: Ada9/FjTmJo8+HRgRqyXI0mSqEZ/Bg==
Date:   Wed, 18 Nov 2020 22:47:33 +0000
Deferred-Delivery: Wed, 18 Nov 2020 22:47:00 +0000
Message-ID: <03e42a055bf34e7b8669158b3d7b940c@casmbox08.crowdstrike.sys>
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
 definitions=2020-11-18_10:2020-11-17,2020-11-18 signatures=0
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

> -----Original Message-----
> From: Casey Schaufler <casey@schaufler-ca.com>
> Sent: Wednesday, November 18, 2020 1:26 PM
> To: Martin Kelly <martin.kelly@crowdstrike.com>; linux-security-
> module@vger.kernel.org
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> Subject: [External] Re: Question about security_file_open contract
>
> On 11/18/2020 12:44 PM, Martin Kelly wrote:
> > - A process exits, calling task_exit().
> > - exit_fs() is called, setting current->fs =3D NULL.
> > - Next, exit_task_work() is called, which calls fput().
> > - In response to the fput(), the filesystem opens a file to update
> > some metadata, calling dentry_open().
>
> Which process do you expect the file to be opened for? As you point out,
> current is being torn down. What is your kernel driver doing that led you=
 to
> think this was a good idea?
>
>

The driver is the OpenAFS filesystem. I'm not a developer for or expert in=
=20
OpenAFS, but from the stack, it appears to be updating a disk transaction=20
database to reflect a removed directory. It seems this happens to work most=
 of=20
the time but does not play nice with LSMs.

> > - dentry_open() calls security_file_open(), calling into the LSM. The
> > LSM crashes because it assumes it's called from process context and
> > thus
> > current->fs is not NULL.
>
> Right. Without a valid process context it's impossible to make access=20
> control
> decisions.
>
> >
> > I'm trying to figure out exactly what the contract is here. Is it safe
> > for an LSM to assume current->fs should be non-NULL when
> > security_file_open is called?  More generally, is it safe for an LSM
> > to assume that security_file_open will always be called from process
> > context? In other words, is the LSM at fault here or the driver?
>
> The driver. If you want to open files directly from the driver, as oppose=
d=20
> to
> from a process, you need a valid kernel context.
>

OK, this is what I figured; thanks for confirming. Sounds like OpenAFS shou=
ld=20
be patched to do this work in a kernel context.

> > Thanks,
> > Martin

