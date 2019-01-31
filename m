Return-Path: <SRS0=hRTQ=QH=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C686FC169C4
	for <linux-security-module@archiver.kernel.org>; Thu, 31 Jan 2019 18:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A948218AF
	for <linux-security-module@archiver.kernel.org>; Thu, 31 Jan 2019 18:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Y5fzDDzX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbfAaSwo (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 31 Jan 2019 13:52:44 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34647 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbfAaSwo (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 31 Jan 2019 13:52:44 -0500
Received: by mail-lj1-f194.google.com with SMTP id u89-v6so3650816lje.1
        for <linux-security-module@vger.kernel.org>; Thu, 31 Jan 2019 10:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EoPq2Gpjoh5/AheroPKAuShVwRAXgiAMRb9VhOJl20s=;
        b=Y5fzDDzXBklrXEuCnqUbsCilsPuxjCIUVOAtKnUNWmbDkhaL3DibOJ0aP2qWpLw4yR
         5YcIFLfYmBeuEAeuCFCzpa0J3WGL4f6HQ82Z79/KW7n7yk4dtHw0v2i6fuZesG2ElVFi
         BCYoPrG6IPhCKs+00BwRvePwc1x9Uel7ZdGHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EoPq2Gpjoh5/AheroPKAuShVwRAXgiAMRb9VhOJl20s=;
        b=aflnbOF/mjq7MU9ihXhC9+U5HwV1IoJYKsgZkUYVtuqzi9GKYMR6AxnnqCWTsKkQuz
         Bwxs67do7g0/3fmcE3FH2DUxSvrH4E0AzM5vMoiLihkERqRNTvnDsZ1pTPyqCO8vEPMk
         snCC+oVQpbI2ssr0GfPk6ugvf3nsRhDY4Sy6VDV3E0mboZtjvM15ueto6BWruJZZrUy1
         EWVuiiPRrTCz/pCa4KA1k1r5lvMZ5vbPpa/7nQMNt3pvaZVvSd4ioLVXQbVny/GgusPQ
         lXsrQllWdBNOc7O+hEFYvb9gq8XX6T05tP5vCpIjKHVndyAr6fAeTdRF9gk+r2nvPk3P
         CmUg==
X-Gm-Message-State: AJcUukfOMBFvAlVY8qpaNM3bM5ulGykwXjsmMvL3RerVhrVbg2qMiJRJ
        nGxjTYOpxvsFCkxWVSvlupiRmpJav2g=
X-Google-Smtp-Source: ALg8bN4x6CX/SH63tCKPTzFn+qx5Qe7ELCQZQYQDsHEgX6psZKfHKCv9qYiQ0KXetgTH21s82V+f+A==
X-Received: by 2002:a2e:568d:: with SMTP id k13-v6mr30829171lje.105.1548960761400;
        Thu, 31 Jan 2019 10:52:41 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id d2sm978732lfg.16.2019.01.31.10.52.40
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 10:52:40 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id u188so1186345lff.4
        for <linux-security-module@vger.kernel.org>; Thu, 31 Jan 2019 10:52:40 -0800 (PST)
X-Received: by 2002:a19:980f:: with SMTP id a15mr27881838lfe.103.1548960759863;
 Thu, 31 Jan 2019 10:52:39 -0800 (PST)
MIME-Version: 1.0
References: <20190122010218.GA26713@linux.intel.com> <20190122025836.GH25163@ziepe.ca>
 <20190122132910.GA2720@linux.intel.com> <CAHk-=wgdOfi+zVVfKDDqJMs2Y7Lq0uufmP8Hx8JzQFA9UzNrBw@mail.gmail.com>
 <20190123153638.GA8727@linux.intel.com> <CAHk-=whgoJ8aAYH37hnyFjZ8jbYyswyf9wZZ82tTFL5f2he+6g@mail.gmail.com>
 <20190129132016.GA1602@linux.intel.com> <20190131122606.GA12470@linux.intel.com>
 <20190131160437.GA5629@linux.intel.com> <20190131170603.GA18349@linux.intel.com>
 <20190131183530.GA27112@linux.intel.com> <CAHk-=wj0pRLS9Z+_LKfiTvnnquGQjOySVuqiObC9sDXp8SCP0A@mail.gmail.com>
In-Reply-To: <CAHk-=wj0pRLS9Z+_LKfiTvnnquGQjOySVuqiObC9sDXp8SCP0A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 31 Jan 2019 10:52:23 -0800
X-Gmail-Original-Message-ID: <CAHk-=whEb14V981ziWmMdcqR40x5xfhhDCaB2JYcOBQHnHmsgw@mail.gmail.com>
Message-ID: <CAHk-=whEb14V981ziWmMdcqR40x5xfhhDCaB2JYcOBQHnHmsgw@mail.gmail.com>
Subject: Re: Getting weird TPM error after rebasing my tree to security/next-general
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     tomas.winkler@intel.com, Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Jan 31, 2019 at 10:51 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> In fact, we have another patch (that isn't applied) that makes even
> the memcpy_erms() just call the sw version of memcpy() for short
> copies (because "rep movsb" is slow for those cases). That would also
> have broken your driver.

I think what I should do is to just make "memcpy_*io()" do the "align
naturally" thing.

Let me cook up a patch for you to test.

              Linus
