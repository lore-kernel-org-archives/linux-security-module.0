Return-Path: <SRS0=iWO7=Y2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB9BCA9EC7
	for <linux-security-module@archiver.kernel.org>; Sat,  2 Nov 2019 22:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1D942084D
	for <linux-security-module@archiver.kernel.org>; Sat,  2 Nov 2019 22:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572732671;
	bh=uWJi/MwEfcXtvMshsyfTyXUwqGP5JBPovIygjDprHms=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Mu8TtJSAiH1TP31mNDiuf1CmwD3GUt1JYac9acFuu3bnF5JgSwujkHSNr3P5POF5r
	 VPrHy3+t6N2GVGkGyyMbJYQvp9hwxLWGiZ+t95x8GAEHHo9wgnAm0b0t+9+BO1s3bk
	 g7TLylaoOuneYvhziriGpPy6R7qKDlwywVsa1ks8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfKBWLL (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 2 Nov 2019 18:11:11 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33395 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfKBWLL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 2 Nov 2019 18:11:11 -0400
Received: by mail-lf1-f65.google.com with SMTP id y127so9601119lfc.0
        for <linux-security-module@vger.kernel.org>; Sat, 02 Nov 2019 15:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vTCI0qHuBsBb0Kz5RbeswHqlSoPusOsIRcj6s1CCCCU=;
        b=XRll/5vMVkjx89KHnpq6WWB0oHHUpEHdiN6O6XIbNfDvJpLq9nAHdnvBRo0qcYtdlV
         dDebt2KT4z/UoQ3oT2Pk6vWaFBXKSztN5uuRAQNTvGwr3g3jPPeee0pGSv+auGk2TkT9
         /FiIqnPnAFsk6ubf5wFePKPpQhSpZfg8GPgik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vTCI0qHuBsBb0Kz5RbeswHqlSoPusOsIRcj6s1CCCCU=;
        b=hvxzft630frdlDWQ5KX0ZfYWt8kA1WzSJjCmXcTOY2K1rhnEkERtmgvVVDwdAq8PKL
         ToKAbOTncX4ObrWRzlviUXoQlJUiHusqfo62R0UVVP3LUtXuxkln5RwlDxnrIkkF4bGj
         lZogEun/3DJC74olfIUBc54i6Ao4tmkdHX+nN3hYhlfsdgPqpd+lTKXZadFzaDE6KCGA
         AyJ8kvEEUayBrVKMZpIksMbPUIWGW4Wf4K4hHsoXy1xpIw/7w0u0XQUSOg+7baqJGpAE
         YMdwX02TEPZMWB6cngQEQyf1mrmIzbUgxOfxTTTVcxaH3Ar3uFIToyUZKmNoDYFojV/Y
         kp/w==
X-Gm-Message-State: APjAAAXI0vb+KWlG4GofbPgGoZ90VUeCNSG5QpBtVEnMQkSJ4+eKamaP
        54/NiELnBqX4AKRXfZa9tgKPhfzjhrY=
X-Google-Smtp-Source: APXvYqyoVWTfhrMxGhzjAFy8ia94lzY/IiBr/JJ4QnEzC8jzyoj5Bz9oXlxcVm+tityj2SwyXa3dbQ==
X-Received: by 2002:a19:4c02:: with SMTP id z2mr11209696lfa.45.1572732668830;
        Sat, 02 Nov 2019 15:11:08 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id m8sm1370318ljj.80.2019.11.02.15.11.08
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Nov 2019 15:11:08 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id v2so13716586lji.4
        for <linux-security-module@vger.kernel.org>; Sat, 02 Nov 2019 15:11:08 -0700 (PDT)
X-Received: by 2002:a2e:3e18:: with SMTP id l24mr13611187lja.48.1572732239632;
 Sat, 02 Nov 2019 15:03:59 -0700 (PDT)
MIME-Version: 1.0
References: <25886.1572723272@warthog.procyon.org.uk> <CC3328CC-2F05-461E-AAC3-8DEBAB1BA162@amacapital.net>
In-Reply-To: <CC3328CC-2F05-461E-AAC3-8DEBAB1BA162@amacapital.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 2 Nov 2019 15:03:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj1BLz6s9cG9Ptk4ULxrTy=MkF7ZH=HF67d7M5HL1fd_A@mail.gmail.com>
Message-ID: <CAHk-=wj1BLz6s9cG9Ptk4ULxrTy=MkF7ZH=HF67d7M5HL1fd_A@mail.gmail.com>
Subject: Re: [RFC PATCH 11/10] pipe: Add fsync() support [ver #2]
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     David Howells <dhowells@redhat.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, Nov 2, 2019 at 1:31 PM Andy Lutomirski <luto@amacapital.net> wrote:
>
> Add in the fact that it=E2=80=99s not obvious that vmsplice *can* be used=
 correctly, and I=E2=80=99m wondering if we should just remove it or make i=
t just do write() under the hood.

Sure it can. Just don't modify the data you vmsplice. It's really that simp=
le.

That said, if we don't have any actual users, then we should look at
removing it (maybe turning it into "write()" as you say). Not because
it's hard to use, but simply because it probably doesn't have that
many uses.

               Linus
