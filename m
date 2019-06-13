Return-Path: <SRS0=ug0r=UM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB044C31E49
	for <linux-security-module@archiver.kernel.org>; Thu, 13 Jun 2019 16:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90710215EA
	for <linux-security-module@archiver.kernel.org>; Thu, 13 Jun 2019 16:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRV4gxKf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392722AbfFMQpM (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:45:12 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36109 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730371AbfFMGCJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 13 Jun 2019 02:02:09 -0400
Received: by mail-lf1-f67.google.com with SMTP id q26so14082701lfc.3;
        Wed, 12 Jun 2019 23:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E9vz0in6RS8016Qk80W2zWm5aSJZ0kwQGVww14npFtk=;
        b=CRV4gxKfPLzeYScqoU0Ca+ajA0dg0SDlrpr6b1YHmlNfBA94oYtvM4y2moLJrM97EZ
         tzk1NbZAKxfjYp1mdPh5z5cDM6U/3SKPRLoj2IpKEOK9LUbj2VP8dpLuD2G6Ao357mmy
         Bb6f/NTRdMHvhLxWDe7lTdoShBKC88eWXSun1vcGUc8ZHzqeSLym3cJbOKkpqj63Mznx
         lBB0FVFwMBdoobmzW67x8MGrj996MBo/a+xHpsTpWk8+ocWe7gx9G/JEGmNOBCAd6x3s
         /yCsT77iw2Go4upeX35AhpEFv5hAAg91+Zbdzcl9f4SP9ofCHkURljd+CWfWuj8GrP6D
         J1lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E9vz0in6RS8016Qk80W2zWm5aSJZ0kwQGVww14npFtk=;
        b=qaY7j6Llyv2F1rQ1yndztwEodOu0p6EZqHFc8W0rsOysy/8bRRSV/Q/1RZwOHj/iNe
         tdVZpIDtBHqg023UC/jkUcNYh2QmZtUF+zs5HTPNZZy0k7zY2om9UZ2Qu3SrJ/SFhyeB
         PGOpTyFpKDueV1MQgHdrz/do9ZkPNLZFZLlFwfAJQW2iUtMpc4KicOtMNFRU7gausXbv
         2MqKrds5MyhIdrq3JywNktmXXMFCpl+1WoKpzzi2YRxZS2RyjY2rkH4wNGJpjGNC7UGR
         umi+JrN8ZImA4STNy9iwoWoIVQaDSUQenj1z1pNm9QoA8vyA7VNvSioAnIgL0HjJug4x
         V3CQ==
X-Gm-Message-State: APjAAAVed/xDj+ptUk29bKzg1JrZciGQKw39HzVRBt7WWy89yW5xmcaz
        3tfasq4T6F4TExGEa6+nrHVWDK70OKtzpTDC91c=
X-Google-Smtp-Source: APXvYqxjxDnpuGrKLNG+sde6iNS+MpLYpd3Fy4JHmv9BwhTqFLoORkVgVyyxHUWe1BcnS70oSUkyh/8kwIT5f02FEuQ=
X-Received: by 2002:a19:8cc:: with SMTP id 195mr8530538lfi.150.1560405727256;
 Wed, 12 Jun 2019 23:02:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190606112620.26488-1-roberto.sassu@huawei.com>
 <CAE=NcraYOw9B3RFu3_DbJs9nPT87AtQEptC7zF4kAu4FP8YhxA@mail.gmail.com>
 <d9efe3c7-20dd-bbb0-40d8-40f69cba5b88@huawei.com> <CAE=NcraHqzST=SZNcrSgpv5EqfyUfpCCb7iQ0Oh6uohL3yiCdw@mail.gmail.com>
 <c13c6b4f-1302-35fb-f077-00b7f84fea08@huawei.com>
In-Reply-To: <c13c6b4f-1302-35fb-f077-00b7f84fea08@huawei.com>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Thu, 13 Jun 2019 09:01:55 +0300
Message-ID: <CAE=NcrZiyWjZUuxdLgA9Bq89Cpt1W6MLAzPkLHVgfOqSo2i1hQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] ima/evm fixes for v5.2
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, dmitry.kasatkin@huawei.com,
        mjg59@google.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, silviu.vlasceanu@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jun 12, 2019 at 7:33 PM Roberto Sassu <roberto.sassu@huawei.com> wrote:

> > That's a pretty big change for the userland IMHO. Quite a few
> > configurations out there will break, including mine I believe, so I
> > hope there is a solid reason asking people to change their stuff. I'm
> > fine holding off all writing until it is safe to do so for now..
>
> The goal of appraisal is to allow access only to files with a valid
> signature or HMAC. With the current behavior, that cannot be guaranteed.
>
> Unfortunately, dracut-state.sh is created very early. It could be
> possible to unseal the key before, but this probably means modifying
> systemd.

Ok, I see the use case. Now, if you pull a urandom key that early on
during the boot, the state of the system entropy is at all time low,
and you are not really protecting against any sort of offline attack
since the file is created during that boot cycle. Is there really use
for using such key? Wouldn't it be possible to create a new config
option, say IMA_ALLOW_EARLY_WRITERS, that would hold the NEW_FILE flag
until the persistent key becomes available? In other words, it would
start the measuring at the point when the key becomes online?


--
Janne
