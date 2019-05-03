Return-Path: <SRS0=MkZ/=TD=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C339BC43219
	for <linux-security-module@archiver.kernel.org>; Fri,  3 May 2019 06:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 931452081C
	for <linux-security-module@archiver.kernel.org>; Fri,  3 May 2019 06:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JtIcacL+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbfECGQ4 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 3 May 2019 02:16:56 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:56155 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbfECGQ4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 3 May 2019 02:16:56 -0400
Received: by mail-it1-f194.google.com with SMTP id i131so7417386itf.5
        for <linux-security-module@vger.kernel.org>; Thu, 02 May 2019 23:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tU8/Io3oX6XqbOYmWxy4FQgmgtv4NyekBb6U3mYiwfQ=;
        b=JtIcacL+I73Nx94kYCWmgKP2J0l8AhtJ3iS0o7c3lvb9McIzC96QatYwqmrdn/zMIq
         03str+eUlo3r/Nz3zQKqg8ebbMvKO3Bju5cAnTiH0ZtX3BTZC7kr/pOEcLGdoaiNLcyD
         SDf9wyx3vYjIVp5m6LoXVPO6fpE6OjC1nb1Zv2nBIrFfO75PYaqG9xn4N+sc8N0unPN5
         wCRBZokDhJPoUy3yNEvT8P6nGQv+KguGOmdNJAu6oWOcyynedKw8M46M2P/i9lMUtBZ5
         1jmltTiV8S8FRc//bnPGZL0GsUOoteiMZ+0N1IIohjQQPldrnahUomr17XJn16BspUe9
         e4vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tU8/Io3oX6XqbOYmWxy4FQgmgtv4NyekBb6U3mYiwfQ=;
        b=PeirORiJrvrqWmUKRzV2O28MmGy4jhcGYn9f6YbOD5UCmtb8Nke+/0YS7+clUxh39Q
         JrfH8f0SO1LYgGjavyPT0wiKDqAbDedX2CwoaIsv4jbp2LMY+bFGN8JzRukJFA6Nl/JI
         +ZCz8aaLRxUg6K2WLb+5Z1El/gsDC/ly91M3uoq6wm1bA9FIS9euHVuEGltjtP8Z0Ak9
         HB5Ll1jhfY7M+BFB/WBdXpT40CtAALsvKMRUgeGFnpY5cuOa7Fkao+40nKo8D/YRUZEL
         A11VgRPvzp3smHgQ9w/Zu/llXtcmw3o8k/+7bEHRi17e/lfWSMhQHOySA7e1/778H/Zn
         +xqA==
X-Gm-Message-State: APjAAAUZ/P7+brt81Y/IOIydton26EGXiPgt4sa6v7cSd3fPitMCoM3L
        /PCqYxrDc8+PlN49Yni9GycICe7Kh4L89NbHxBlLrQ==
X-Google-Smtp-Source: APXvYqyT3s+ROONjAR9Ys6zEgYHBBzcOpcN3vHAjUlBVOBVYDxcMy9fP2GOiJgeIQrZbYqx3G8cPtw+o4tgWe219nhg=
X-Received: by 2002:a24:59c1:: with SMTP id p184mr6060046itb.158.1556864214995;
 Thu, 02 May 2019 23:16:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190502040441.30372-1-jlee@suse.com> <CAKv+Gu9mjtNEWN-w4ix7VJMZ_kk-Qf6FfYFRu2mCosaAjMA4Vg@mail.gmail.com>
 <20190503061518.GM11486@linux-l9pv.suse>
In-Reply-To: <20190503061518.GM11486@linux-l9pv.suse>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 3 May 2019 08:16:42 +0200
Message-ID: <CAKv+Gu9KGE3dpkZ1J9B0_VX2AsiTnE3Zbs1kAcz-xeOcXfxYog@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] efi: add a function to convert the status value to string
To:     joeyli <jlee@suse.com>
Cc:     "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        David Howells <dhowells@redhat.com>,
        Josh Boyer <jwboyer@fedoraproject.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, 3 May 2019 at 08:15, joeyli <jlee@suse.com> wrote:
>
> On Thu, May 02, 2019 at 10:53:31AM +0200, Ard Biesheuvel wrote:
> > On Thu, 2 May 2019 at 06:04, Lee, Chun-Yi <joeyli.kernel@gmail.com> wrote:
> > >
> > > This function can be used to convert EFI status value to string
> > > for printing out debug message. Using this function can improve
> > > the readability of log.
> > >
> > > v2.
> >
> > Please move the changelog out of the commit log (move it below the ---
> > further down)
> >
>
> OK! I will moved the changelog out of the commit log.
>
> > > - Changed the wording in subject and description.
> > > - Moved the marco immediately after the status value definitions.
> > > - Turned into a proper function instead of inline.
> > >
> >
> > You missed my point here. A proper function means the function in a .c
> > file, and only the declaration in a .h file. This way, you are still
> > duplicating the literal strings into every object file that references
> > this function.
> >
>
> Sorry for I missunderstood. I will move the function to load_uefi.c.
>

No, please move it to a file that is shared between all EFI code.
