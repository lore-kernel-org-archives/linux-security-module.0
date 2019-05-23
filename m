Return-Path: <SRS0=z3Bq=TX=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134FEC282DD
	for <linux-security-module@archiver.kernel.org>; Thu, 23 May 2019 16:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9D3721773
	for <linux-security-module@archiver.kernel.org>; Thu, 23 May 2019 16:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="RBmoo21s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731073AbfEWQQB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 23 May 2019 12:16:01 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:44702 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731206AbfEWQQA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 23 May 2019 12:16:00 -0400
Received: by mail-ua1-f68.google.com with SMTP id i48so1709251uae.11
        for <linux-security-module@vger.kernel.org>; Thu, 23 May 2019 09:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nXMl9P+TGNueE5euLoOAhBRVyH0nXGkNGXAvhSh7+OU=;
        b=RBmoo21sPuzUV/EQovrxfLit8XjveVUpH/oRQNXVl7Q6wTjT2WhMeju7re3mqz8IBN
         fGdQdayykoLjbugpvir9+tXe/l0zWxJ6gCEaAte21ryH3NxdCpos865hXneKhcdNkwow
         I29SNtgGZwYGEa/J5emaZ+P8ZhtfSl4GL1UyTdj80GPWBCJWSenaQj7B4XRJ09R2a+fh
         +C9erGAG6rC9BLBZiGL+ifwexjPk5kRHwJE2C6SvKk2xFEY/klwYPfG+k1WD1LJ+XPWX
         Cv+wD6cHdbdKCDVNXBvakwQoxcPGeb0X7qvoKYFFJGNz7P6CWVRZGU47e9KNUyuqFZOj
         FT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nXMl9P+TGNueE5euLoOAhBRVyH0nXGkNGXAvhSh7+OU=;
        b=ui/TxSz4517gyZMJYe/Scs0Jt3aS6B6vzgamd36f15nSCUwSQverw6nvgtxq5SsgVx
         6X7n4cWRioMiaWZNqEiBrAqtBN2bJyvlaHe1miJ1ZNCFBIRjdVpnMhsJFiCceUO7BvP3
         pbinohSf9najrwRtntFnEMIfVCqLcRBYAvlF/MtP2PH9yGyvTCzwd3tfTwyBi2GBIVUb
         69m7gwLZyMjDp5FzG+1RQYWfgF4COkz/n2MLeRfqU1GQcPM3LhAR4vIQEL6Ljk9SK8na
         SzLT+Gn0zFRyG/0FKwSXnI4h9mRLHCJtwovOh8ZmVVY7qkCVYQnbaV8dKLXMiN4LwxYO
         HbtQ==
X-Gm-Message-State: APjAAAWOVTzK2Ze3zySVlMornnBIcrgrZxvm4EHEKftmqxzo8zOqevzZ
        oNfHG+CRUmz4I9vfiyW/mmDVvSGPbdVnFf17BQmOPg==
X-Google-Smtp-Source: APXvYqyKyrA3Zqk0VgrKQ9df6i2EvyciTk799ILFHCqR2AZ71fV4FIj6HG11qTQ2eMLBgGuo+Uu4fS1QUy9VmXaig2s=
X-Received: by 2002:ab0:670c:: with SMTP id q12mr24858805uam.106.1558628159122;
 Thu, 23 May 2019 09:15:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190520205501.177637-1-matthewgarrett@google.com>
In-Reply-To: <20190520205501.177637-1-matthewgarrett@google.com>
From:   Bartosz Szczepanek <bsz@semihalf.com>
Date:   Thu, 23 May 2019 18:15:48 +0200
Message-ID: <CABLO=+=5D2v2TQ6HWSByJjnb4pzXZxXAs1jJgcFtVNYk5PYrjw@mail.gmail.com>
Subject: Re: [PATCH V7 0/4] Add support for crypto agile logs
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, May 20, 2019 at 10:55 PM Matthew Garrett
<matthewgarrett@google.com> wrote:
>
> Identical to previous version except without the KSAN workaround - Ard
> has a better solution for that.

Just tested the patchset on aarch64, all works fine.

Reviewed-by: Bartosz Szczepanek <bsz@semihalf.com>
Tested-by: Bartosz Szczepanek <bsz@semihalf.com>
