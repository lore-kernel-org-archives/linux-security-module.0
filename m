Return-Path: <SRS0=4asR=UN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1805C31E44
	for <linux-security-module@archiver.kernel.org>; Fri, 14 Jun 2019 05:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AFD621473
	for <linux-security-module@archiver.kernel.org>; Fri, 14 Jun 2019 05:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MXRx/8mR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725823AbfFNFNM (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 14 Jun 2019 01:13:12 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38895 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfFNFNM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 14 Jun 2019 01:13:12 -0400
Received: by mail-lj1-f196.google.com with SMTP id r9so1010168ljg.5
        for <linux-security-module@vger.kernel.org>; Thu, 13 Jun 2019 22:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aL7dOhWJv6Iy9PdIL/Yj/9BYl97GRWMi/xDEOn/xHjE=;
        b=MXRx/8mRNZMEm1bSJWyIQsqdjsBQQWYSqSNiLZbqiLy8NWqMXq9PwlieAW0h9A12ak
         /QfePvWZDuOYNpjekRDfBniymCHnr8jZ6wyvty7ZG7h+tkY4iUnvLjn4rf/3RpwKp4y7
         yENE6RqmnFanwpBzOT9bmTtrkiKD/rZKwo9AE5XqDN4hiTmgj6FpzDjKfz1dU/4bTGa/
         5hv6teKrtqHFtBVrtF7qGtc5jBuXkteMXOVAPJd7bKlJrHx6evSlDzru4Zugeyp3Kl1B
         fpiyzYSgJI1guXX+HAkkUTyRSKQmjmLyAQSCiVSywCIYV/d+sqdiFx2/yT92ARm6v5Se
         1KDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aL7dOhWJv6Iy9PdIL/Yj/9BYl97GRWMi/xDEOn/xHjE=;
        b=KZecVfcc967Xn0FUzgEn4qm/nc13gYm+VcdirsOoX1KEt1D7CeeyVGDwc/3jDSbPLR
         YtgE4l9/HIgHypAZhpH/6ut98PlVjkbZE+qJkAscVfYMT61wWI3CMEBxK9stHvzB1aVQ
         SJCZpBb+XWb5U51CpQLadhDyBUREfN/tdhQQ140+bi3TuPCHEh29XcQG26zEatphoL6k
         7ksZqJ7T8B5jNvmpCemfyGVTcCOqGONwoVcP48H3KTIWDfMu43BgJbvIW78vVv/hWqr4
         VmbcP5DelF3bdn5xBT+DH1spwa6/ynVTw7psmMt34xLMAwlwRKjHeZRDXWan3X/zem6r
         hLVA==
X-Gm-Message-State: APjAAAXCMJ+GiGg2l7jn2brnkfyxcyTAiHWam9GnVEipFisiKRMkcjgX
        /ujUbel/htdx58m2UYq2spAEHFXvOOptswR2YUWOPg==
X-Google-Smtp-Source: APXvYqwbhE6azwYa5Cp42iogGaz/sbbBnyxJMg/6/oQvYNIvy2CVlb+gsNyQN1WDW1av7RwJ5ccPczeFkpq9mcT7YzM=
X-Received: by 2002:a2e:4b12:: with SMTP id y18mr2691836lja.238.1560489190498;
 Thu, 13 Jun 2019 22:13:10 -0700 (PDT)
MIME-Version: 1.0
References: <1560421833-27414-1-git-send-email-sumit.garg@linaro.org>
 <1560421833-27414-2-git-send-email-sumit.garg@linaro.org> <20190613151257.GA18488@linux.intel.com>
 <20190613151714.GC18488@linux.intel.com> <20190613151746.GD18488@linux.intel.com>
In-Reply-To: <20190613151746.GD18488@linux.intel.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 14 Jun 2019 10:42:59 +0530
Message-ID: <CAFA6WYMjuEm8jwjteD1Wu2Uqs_O2jQuVyffqqpaNnSs0hksDMw@mail.gmail.com>
Subject: Re: [RFC 1/7] tee: optee: allow kernel pages to register as shm
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jens Wiklander <jens.wiklander@linaro.org>, corbet@lwn.net,
        dhowells@redhat.com, jejb@linux.ibm.com, zohar@linux.ibm.com,
        jmorris@namei.org, serge@hallyn.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tee-dev@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, 13 Jun 2019 at 20:47, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Thu, Jun 13, 2019 at 06:17:14PM +0300, Jarkko Sakkinen wrote:
> > On Thu, Jun 13, 2019 at 06:12:57PM +0300, Jarkko Sakkinen wrote:
> > > On Thu, Jun 13, 2019 at 04:00:27PM +0530, Sumit Garg wrote:
> > > > Kernel pages are marked as normal type memory only so allow kernel pages
> > > > to be registered as shared memory with OP-TEE.
> > > >
> > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > >
> > > Just out of pure interest why this was not allowed before?
> >
> > Please spare me and ignore that one :-) Obviouslly because it
> > was not used.
> >
> > Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>
> Actually,
>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>

Thanks.

-Sumit

> /Jarkko
