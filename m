Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B60C433EF
	for <linux-security-module@archiver.kernel.org>; Tue,  3 May 2022 15:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237770AbiECPHy (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 3 May 2022 11:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237764AbiECPHx (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 3 May 2022 11:07:53 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFDC3A1BC
        for <linux-security-module@vger.kernel.org>; Tue,  3 May 2022 08:04:20 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id g6so34048651ejw.1
        for <linux-security-module@vger.kernel.org>; Tue, 03 May 2022 08:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bmC7DRu7flM3aFzKHb+bDUK/tB+P+W9KDDy98mVSVQ0=;
        b=oyxVT1gpTaomCxljv6pbFCCpbu4ZgTR/80bvs4ClyThEQsIq3L3UeHcgt4WI2j+7Uf
         lpG1gBMr5yuIBdD0NvK/i6vwQSr7AUsssXoNfkNqCXxTbcaNwVQ2GkR267bP6zLn5QM0
         XxEgxNI7Vkbu6Crh8QfSUAvz9q57mPWXd1UGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bmC7DRu7flM3aFzKHb+bDUK/tB+P+W9KDDy98mVSVQ0=;
        b=3LYib0dIjSaMUFKm5MvLB4dIXUNlbbVnZTdrrxL9bGp3ErXMwznzjiT6sqvj0/UhR0
         dA867TW/9ufxrPwEVIlM1KRNcSl9Y9FihouIEqT/3khPTZdEHywZLzaizbjHnwa8SdiT
         EUdOKS4DHWeWZa/U17x+/jWapVlxO9gD2Uzn+keYb9Y6JoMrZKtCVwxsk2Uh2Ehc3O8w
         ATfKfAvENssIJ157TK0sV33/nwkDgt10MW9jtr6X0brJtrM6A1PJigZBDWmLAVvhufdv
         MfmgDbiouOYpifYhshBFW9Q9NL5g4ECBcIkemkGFiJ38smR/4JF5smyJbW8SOazlTI3D
         rVpg==
X-Gm-Message-State: AOAM530vtSIm/AkdUkgtNWTPMvqM8omxsNWA0AAzT7HFYxnuHX90AsmW
        vbPgGo48G3hWoPNNebmd6q7+FyOP9NPMBMVLJIwNzw==
X-Google-Smtp-Source: ABdhPJxhO8bLjM6wdea3bRux6bogjYO+c6+DWAw0ArELIY5Ox+tfOrkFBk71CkkeK4W0MVxxYnnxxKbq8koDg++bpqU=
X-Received: by 2002:a17:907:62aa:b0:6e0:f208:b869 with SMTP id
 nd42-20020a17090762aa00b006e0f208b869mr16047649ejc.270.1651590258996; Tue, 03
 May 2022 08:04:18 -0700 (PDT)
MIME-Version: 1.0
References: <YnEeuw6fd1A8usjj@miu.piliscsaba.redhat.com> <CAOQ4uxim+JmFbXPQcasELDEgRDP-spdPtJrLuhvSiyxErSUkvw@mail.gmail.com>
 <YnFB/ct2Q/yYBnm8@kroah.com>
In-Reply-To: <YnFB/ct2Q/yYBnm8@kroah.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 3 May 2022 17:04:06 +0200
Message-ID: <CAJfpegtZjRca5QPm2QgPtPG0-BJ=15Vtd48OTnRnr5G7ggAtmA@mail.gmail.com>
Subject: Re: [RFC PATCH] getting misc stats/attributes via xattr API
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Karel Zak <kzak@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, 3 May 2022 at 16:53, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, May 03, 2022 at 05:39:46PM +0300, Amir Goldstein wrote:

> > It should be noted that while this API mandates text keys,
> > it does not mandate text values, so for example, sb iostats could be
> > exported as text or as binary struct, or as individual text/binary records or
> > all of the above.
>
> Ugh, no, that would be a total mess.  Don't go exporting random binary
> structs depending on the file, that's going to be completely
> unmaintainable.  As it is, this is going to be hard enough with random
> text fields.
>
> As for this format, it needs to be required to be documented in
> Documentation/ABI/ for each entry and key type so that we have a chance
> of knowing what is going on and tracking how things are working and
> validating stuff.

My preference would be a single text value for each key.

Contents of ":mnt:info" contradicts that, but mountinfo has a long
established, well documented format, and nothing prevents exporting
individual attributes with separate names as well (the getvalues(2)
patch did exactly that).

Thanks,
Miklos
