Return-Path: <SRS0=NWfs=SE=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8AC3C4360F
	for <linux-security-module@archiver.kernel.org>; Tue,  2 Apr 2019 17:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A737C206DD
	for <linux-security-module@archiver.kernel.org>; Tue,  2 Apr 2019 17:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V2u3YRsk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbfDBRPw (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 2 Apr 2019 13:15:52 -0400
Received: from mail-it1-f171.google.com ([209.85.166.171]:40141 "EHLO
        mail-it1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbfDBRPv (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 2 Apr 2019 13:15:51 -0400
Received: by mail-it1-f171.google.com with SMTP id k64so6536596itb.5
        for <linux-security-module@vger.kernel.org>; Tue, 02 Apr 2019 10:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HFPmBx+B1WZ6nJT4RE69xmC8uy5jW1MyDXfthBDNL0c=;
        b=V2u3YRsk7JpNkAIHI+OTVMyfoxGzTDvHwkXjKBqKrgsepoCcnmuPQ4iYHy5esNj3ua
         D0XZjCjpY3DeDcVb9b14+PsHaVje90gM1LL/qBsyzEe4fCu09sC/zlvONsu7tpyk6N4h
         h4E39GMWAex7ESOdk0WFndjGYkB8q+kXqO/q9m16xviXj3zTYkP5Iunn6MYcsF3/6In6
         H9ehfOnxbMjw2hzUrELA+NoJHE7pbumjhoUmr/wwKLKJ3wcV6JWW2obBhgIegVSueF8Z
         4zfu4Zchr5Kxo2wq37b2zQSUpz5R0gvSwth+nojdJ8DBNsGsEP9sjM2jwn+1qveDB2KJ
         Ka1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HFPmBx+B1WZ6nJT4RE69xmC8uy5jW1MyDXfthBDNL0c=;
        b=lDgwY/a7EjXJcspAsEIMogQUA6BmMl+tvfZvcAErg53CjEGFWFnplkPtQ1XF8CPLE7
         5kj4tm7meues7AQoteuUabSD3t+CGiPesMTJ7eqQitrrEm4I+3xF5bDdNaXOqqt3ws16
         E9/hvvhYN6+Pkz5ZKDdzBtdJe+IzjXlYlXHuEOjruwplJjghjv/CsT4sY64rJZwy4B5Y
         dJQ2EctC3jOsF3vRjz122ibactQi2s0bcZ3s+2sV9QxShtxDjJcQqgAZTwXNaFZQLSaJ
         sFlYprUnQ/PEVER7FaZO6e5oD3lHNiXZGTJtLYuY1Y/xMHA/JZ1cuG2lwUVhbCQvP/CE
         /HKQ==
X-Gm-Message-State: APjAAAX7KTtMTb/sDudD5ElwRAmvJqtIUchsVEIb+vXKpa3hszvxz+Xy
        NQg75OCm9TQp4BiA+e/4hs+Hf3iow6ErnNX7gkpAkg==
X-Google-Smtp-Source: APXvYqxJjCW4h+i3d/gXbXt+9Vk9zPrvaLq8tThlHlRFPtr8bgRmEf41ON8OUqbZ67BMdd3UKwQCtNBY2GvZwlcWCOU=
X-Received: by 2002:a24:cf41:: with SMTP id y62mr4867233itf.106.1554225350512;
 Tue, 02 Apr 2019 10:15:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190227202658.197113-1-matthewgarrett@google.com>
 <20190401235245.GA29282@linux.intel.com> <CACdnJutCC7n++Nz5qy1YzmsSchEApDUvMH9-qpxYXckh-Dzf-Q@mail.gmail.com>
 <20190402130704.GA3916@linux.intel.com>
In-Reply-To: <20190402130704.GA3916@linux.intel.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Tue, 2 Apr 2019 10:15:39 -0700
Message-ID: <CACdnJuvFxKCwP3XftqacFiLTmTZzCGHkc9DzrJu2u6vwy5_o-w@mail.gmail.com>
Subject: Re: Add support for TCG2 log format on UEFI systems
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     tomas.winkler@intel.com,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
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

On Tue, Apr 2, 2019 at 6:07 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>
> I'll apply all patches soonish and include them to the next PR.

Thanks! Looks like I need some fixes to deal with non-x86
architectures, I'll get on that today.
