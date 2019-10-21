Return-Path: <SRS0=Btf7=YO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C419C47E49
	for <linux-security-module@archiver.kernel.org>; Mon, 21 Oct 2019 16:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE2D62166E
	for <linux-security-module@archiver.kernel.org>; Mon, 21 Oct 2019 16:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J7m8XyLb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbfJUQF4 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 21 Oct 2019 12:05:56 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35910 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfJUQF4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 21 Oct 2019 12:05:56 -0400
Received: by mail-qt1-f194.google.com with SMTP id d17so7196518qto.3
        for <linux-security-module@vger.kernel.org>; Mon, 21 Oct 2019 09:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=531cCBl4i9yQxVHY6Fc4jmInfUcTFsMFBRwLLqkbbsA=;
        b=J7m8XyLbnCcCFa+RkEUdG5aQ77qhKM2xKK6QuM8oOcwpzcbiNdS/9JQ7KHm5eohZ+g
         0KPgSRseqMPuYQ07ppyBTTjVZ+dlpfWvPN5i8MFVoOVMdK6LVvzEBtlJxbZBiE3ShkEi
         I0stg3FSjNkckzSGuEwjilGaEm1Uv+080YwkGYmY2q9688JWtfo6YO6wTTOyKRGLoHCA
         4wF0ppmavgG3PZYTMg3dNwAqDzBzpBoLpEXUkC/8VdD+K0KvVqulh4h/2Oi6M6hpiTQ5
         UPzd7k0Iy84JOsG/yGm8aHLFC4AS/owz2/KzFs2D6M7pSTnx7w988q0bGHsDrpv/M7pu
         ViTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=531cCBl4i9yQxVHY6Fc4jmInfUcTFsMFBRwLLqkbbsA=;
        b=DyVirZEP1aFgaXdXb+Rw5OwIU30jJttGJbMlzh7DefOw8UACT3ZYL2vqPFAeMuPTP6
         1Zk7/qwvLqtE67kW4nNNtgpXsd8TI23DJ9mbSFxrldux2MUHj1NAxJlUmOy6/gJy+t6l
         X1kkR3YvVpg8c3wilf0/YHq4QMDFS+XTiPDAc7SEyvrjbJRt+orJYIibjMYXQPVRToc2
         jR96uCzaLv67tdBgZ/iTl7mLthwVS57XtqBRs0l086HelVNi6cxUPgukTvxGZg14Jm21
         ZEeejFszxMJ5iVTWrHidC448NyR2nTJO/0BTYCrmMT6oLNt2YBxP7SM4ohccXlDDU3qC
         3NwQ==
X-Gm-Message-State: APjAAAWNluBL7kqy+b162LK17G5oisrfdWd5y49VLRWLFPASGhLJjLmH
        6Htl/N8BsoemPGD6Jok043OhjSWo87tYnkkVvU3BJw==
X-Google-Smtp-Source: APXvYqx+V80R0g8ka4mvuphFpmFxHIfFs0r+6m1My9wPI75glpXldHuxqSk3nZBPJ2DOnrYuuGI+ifd5vi7AHNKn2uE=
X-Received: by 2002:ac8:3408:: with SMTP id u8mr25315451qtb.380.1571673953322;
 Mon, 21 Oct 2019 09:05:53 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000830fe50595115344@google.com> <8509.1571673553@warthog.procyon.org.uk>
In-Reply-To: <8509.1571673553@warthog.procyon.org.uk>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 21 Oct 2019 18:05:41 +0200
Message-ID: <CACT4Y+ZZ2tmUg9PAKouK5zhNw=BDWD7+jfo_JjB92Eb+g_gAQQ@mail.gmail.com>
Subject: Re: WARNING: refcount bug in find_key_to_update
To:     David Howells <dhowells@redhat.com>
Cc:     syzbot <syzbot+6455648abc28dbdd1e7f@syzkaller.appspotmail.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <jmorris@namei.org>, keyrings@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Oct 21, 2019 at 5:59 PM David Howells <dhowells@redhat.com> wrote:
>
> syzbot <syzbot+6455648abc28dbdd1e7f@syzkaller.appspotmail.com> wrote:
>
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11c8adab600000
>
> How do I tell what's been passed into the add_key for the encrypted key?

Hi David,

The easiest and most reliable would be to run it and dump the data in
the kernel function.
