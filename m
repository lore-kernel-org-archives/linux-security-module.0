Return-Path: <SRS0=lnE7=U2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 131CBC48BD6
	for <linux-security-module@archiver.kernel.org>; Thu, 27 Jun 2019 15:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB06C2064A
	for <linux-security-module@archiver.kernel.org>; Thu, 27 Jun 2019 15:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nnW95Nc4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfF0PbG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 27 Jun 2019 11:31:06 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:42326 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbfF0PbG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 27 Jun 2019 11:31:06 -0400
Received: by mail-io1-f68.google.com with SMTP id u19so5615184ior.9
        for <linux-security-module@vger.kernel.org>; Thu, 27 Jun 2019 08:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TuO/waTdEbRopCnF+YINnarVye+qG1Wu8zI6yO1vq2Q=;
        b=nnW95Nc4Sck+SCyLDWb6ekZqtVJR9gFDsyfjGL4qdTmxCKqSDzLNB+q6JY04BCTCox
         rNzxKwwVKDRt6j/nSCWITR4woKO3Bg6Pi4yh4DIx201Y7mmDE2vv9BJlTOgg0nWuLodi
         hRrheHz1Qb7gI7AH1/e+uD16A64/DMlbPbvG0GMFSoHN4QgrKWYC61U11c2JmgwNL4fd
         57IHFuNC5SRqpkx1wImVnhsWW7VQAb4Gj74fRFKt/WKH/hZHSXsN2VBtrqFRwm0yMHvP
         qISmxHrhDrDGrXqYK7CvD9tSjcj8q5EF7ls1Z6zh/pEeXldbhUMy3yPshERw4SLH5ZjI
         zL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TuO/waTdEbRopCnF+YINnarVye+qG1Wu8zI6yO1vq2Q=;
        b=Dep7NCzmnmSIQQl5DZ/d/vS5TCbuM+Xf0jnaKIr6S6zp/xDrYnhw0DSzFUmfQomP6u
         /sdKsqCAume2yrozuINRmugQ2UEiIj65j2IXCiWdseUGBCnsMdcVRpoPqgVeFHI5gecl
         MRvJPZcvxQsU1eAk+Pwh81GVChejyv/IXo4Fi9DcsTEQNC+MlClBeUF5rVRzT+IsOOAT
         30Va8t7pxivvk05M4lgr9DISk64golyOvu+Gxv50jO7D5wEHL0AeIdvTjQChqsp5eTcY
         xGiyESfxxdZyLVXw8gPFCGXuDWcBfNOe3b/AsYJjBBYTtD6ca25rzOV1HaFgEL1rViD6
         Yp4w==
X-Gm-Message-State: APjAAAVUL5l6E3ihjzcIPHenbiVz3UhBQxZ3U7BCiGswO7UPYLNAJdLU
        do7Dl0a9swP8614HdnUMjLk8WrL0YLNPNf9IAuQjYZopcQQ=
X-Google-Smtp-Source: APXvYqyWPoDVGM4Ciu+xqxjJUuhEI0J//jkhx4KineosYbAyIwLnim/WCO6ZIrIBAhMlWt7aE44OwKUSv/DF3heQ9b4=
X-Received: by 2002:a6b:b790:: with SMTP id h138mr5109103iof.64.1561649464641;
 Thu, 27 Jun 2019 08:31:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190622000358.19895-1-matthewgarrett@google.com>
 <20190622000358.19895-20-matthewgarrett@google.com> <87ef3f3ihh.fsf@dja-thinkpad.axtens.net>
In-Reply-To: <87ef3f3ihh.fsf@dja-thinkpad.axtens.net>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 27 Jun 2019 08:30:52 -0700
Message-ID: <CACdnJuuUJShbsDt+oV+2nPOX_pQikOPumtMaB-mas6FLVeZ87A@mail.gmail.com>
Subject: Re: [PATCH V34 19/29] Lock down module params that specify hardware
 parameters (eg. ioport)
To:     Daniel Axtens <dja@axtens.net>
Cc:     James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jun 26, 2019 at 6:49 PM Daniel Axtens <dja@axtens.net> wrote:
>
> Matthew Garrett <matthewgarrett@google.com> writes:
> > +     if (kp->flags & KERNEL_PARAM_FL_HWPARAM &&
> > +         security_locked_down(LOCKDOWN_MODULE_PARAMETERS))
> > +             return false;
> > +     return true;
> >  }
>
> Should this test occur before tainting the kernel?

Seems reasonable.
