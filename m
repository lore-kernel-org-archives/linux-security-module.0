Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B38FC001DB
	for <linux-security-module@archiver.kernel.org>; Mon,  7 Aug 2023 13:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbjHGNV6 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 7 Aug 2023 09:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjHGNV5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 7 Aug 2023 09:21:57 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3643BCF
        for <linux-security-module@vger.kernel.org>; Mon,  7 Aug 2023 06:21:53 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id a640c23a62f3a-99cc32f2ec5so123624366b.1
        for <linux-security-module@vger.kernel.org>; Mon, 07 Aug 2023 06:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691414511; x=1692019311;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gplJKtygBIgaBwPd+b3DwTDPYxE0PSYEpeEbA63W7To=;
        b=7glyMk/acrv1/zb2RjMSIEF5h72/4v4+5OBowbDYZa3chdOp/fbfx7/oRZ9QSHIq//
         6JmABXBjGJ0gWjpSHkGmjPJatsi72xdBCRmg6j/ofT/VyRWLHlHYJHAYHJj9INat8PQg
         /DSZZ39uOqZQicSj0t7yDYJ267qzJUnOArCv5DXkJQDSc9o98bFDfTPTPrdtPFx3ENzN
         44admkH2xSBGEhoc6px0QIv2SiooHLa7uLnXVBibOrn+VroNo58h7F5Oa3P0VTNA4FgM
         V2v0n4Sph65ZXFozZNngEN8F4lNejsLHSGMMfCEKKK2+KZPhK9NDy60h+I+N6HKpGAj8
         nBGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691414511; x=1692019311;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gplJKtygBIgaBwPd+b3DwTDPYxE0PSYEpeEbA63W7To=;
        b=WtpzVuc1e/VVWbF5xSNN9PZleuo0oYzleLDLhpzqzEHX+43Y5ZGLS8WXgEE4/7lssF
         WwDyqvVvDpc9uJbeGxJA1ERL6MW/CG28DhLh+T/LWcN8rFExL/cVDo3xjIpf/c5gTAjp
         mjO1O/naJLDWBSD5gwdRZA6HOQmUpo8RHE2Oa9H+QNwrQVacRKbSi/YFX1rT6W1q6Fcw
         F9Kd0Fifk8+AtFDSXG1i8Budxzn5lnxIstuqm89wpFNbBekv8IjN5qn+7K9o4iiowwEY
         PORnjCk4FJvVXv1vNXr7mF4mNyAMTqzUxE+hUpKGQVI1PQjjGyI9bO/tMQ0fF9R9GqvS
         of/w==
X-Gm-Message-State: AOJu0Yxwc9DVSMwxYfwyQSVvEQr7wORyKGcxVXBB0+aD/HKCWMqXarzR
        /iY1o5f0kqvIzdELOWeVIKaklyi4Hpk=
X-Google-Smtp-Source: AGHT+IFHr0m00tKNGZK1g9/QbElQy5LSWHIwPDQG/eolA7daa8ve8/ig71weB/wOcU3xFqerCvQux+OeuLc=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:5a00:cb76:4f2a:6df])
 (user=gnoack job=sendgmr) by 2002:a17:906:d506:b0:992:4713:ec8d with SMTP id
 cq6-20020a170906d50600b009924713ec8dmr23580ejc.9.1691414511486; Mon, 07 Aug
 2023 06:21:51 -0700 (PDT)
Date:   Mon, 7 Aug 2023 15:21:49 +0200
In-Reply-To: <20230807.thiepaW9ooWu@digikod.net>
Message-Id: <ZNDv7Q5ugRMd4YAg@google.com>
Mime-Version: 1.0
References: <20230502171755.9788-1-gnoack3000@gmail.com> <20230502171755.9788-4-gnoack3000@gmail.com>
 <be5ac5ab-2b00-b896-27fc-14c30f938622@digikod.net> <ZNCfxozBIkDIj9R3@google.com>
 <20230807.thiepaW9ooWu@digikod.net>
Subject: Re: [RFC 3/4] selftests/landlock: Test ioctl support
From:   "=?iso-8859-1?Q?G=FCnther?= Noack" <gnoack@google.com>
To:     "=?iso-8859-1?Q?Micka=EBl_Sala=FCn?=" <mic@digikod.net>
Cc:     "=?iso-8859-1?Q?G=FCnther?= Noack" <gnoack3000@gmail.com>,
        linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi!

On Mon, Aug 07, 2023 at 11:41:48AM +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> On Mon, Aug 07, 2023 at 09:39:50AM +0200, G=C3=BCnther Noack wrote:
> > We've already tested the inheritance of access rights across different
> > directories and mount points in other tests.  I feel that exercising it=
 in all
> > combinations of access rights and inheritance mechanisms makes the test=
s harder
> > to understand and maintain, and does not give us much additional confid=
ence on
> > top of what we already have.  What balance do you want to find there?
>=20
> Indeed. It should be notted that this new IOCTL access right will be the
> first one to directly apply to both files and directories.  It should
> then have the same scope as LANDLOCK_ACCESS_FS_READ i.e., apply to the
> target directory itself and files/directories beneath it.
>=20
> We then need to test a directory's IOCTL, for instance using FIOQSIZE.
>=20
> What about this two rules and related access checks, combined with
> already-opened FD?
> - dir_s1d1: always denied (negative test)
> - file1_s1d1: allowed with a rule (checks ACCESS_FILE)
> - dir_s2d1: allowed with a rule (checks directory right)

Ah, that's an excellent point - I had not realized yet that it is different=
 to
the other access rights in that way, and it makes a lot of sense to test th=
at. =F0=9F=91=8D

I'll dig up one IOCTL command for regular files and one IOCTL command for
directories like FIOQSIZE, which are both not blanket-permitted, and I'll t=
est
it with that, and will make sure to cover the combinations you listed above=
.

Thanks!
=E2=80=94G=C3=BCnther

--=20
Sent using Mutt =F0=9F=90=95 Woof Woof
