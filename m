Return-Path: <SRS0=QDjJ=UU=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FA6C43613
	for <linux-security-module@archiver.kernel.org>; Fri, 21 Jun 2019 20:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73ED920673
	for <linux-security-module@archiver.kernel.org>; Fri, 21 Jun 2019 20:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tQXWoCT7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbfFUUPJ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 21 Jun 2019 16:15:09 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34928 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfFUUPJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 21 Jun 2019 16:15:09 -0400
Received: by mail-io1-f67.google.com with SMTP id m24so475041ioo.2
        for <linux-security-module@vger.kernel.org>; Fri, 21 Jun 2019 13:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AzDlMHYKYdPbav08td6cmrqKH87QGtCYlyXDXXOTgFk=;
        b=tQXWoCT7u5RD2XblRn/rEN/phOj7fWsEmz5uMzn5kiCQyibx9ujzvtEvgK6iZ8pwsm
         mf7OLToqshhDbzAdX8fnx8gG5wXPsbUk2uRMl5dBsMdWEHD5Z+LF4KSJeakOOmCxbyZP
         C6E9MxZMnuitfO1C+d0TwHhQljoRubGQLCDZYiIC3Ru4fpIkiiQkIkjVkjh6d65rgarv
         ZRAFTDUIefuKONBucRjVJjnw6fjoaa2gcyJQ0Coo8bG0g6t7lRYItK9Bw4q0CDU0gNf4
         Zsbfow4kziPBKI25UKNcswXRd9uGeYPOmcGp6uvJ5+a1qIP4KwCzcIEieVzY6BjgRFNo
         86nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AzDlMHYKYdPbav08td6cmrqKH87QGtCYlyXDXXOTgFk=;
        b=j+VB71uqGZr5jFDA9gmQAadU1KkCMSeE7fMlepSKQ4ViZKrxdVbvLTOC8LwZA0vLLw
         inCMRitpHx8u3xH18eNGJ1MWUyEv8t3OXRpp9zdwrbHlxJGk3R7g/Pq/v4ONzQwv0LHW
         OHzpdTUyo9jpV27FsV2UxfpUSwIvv7/G9geQzWS3NnonOm3EmCG33PLo9uYlPcJgdsBc
         /C1d13wqp1SqbevDHDejFoXE+UDpAod+EC4oyPeg4T4yGIgcNjY2Ht0cDPK5MziQ4QFG
         YLLBxLgbOtnJY1w9r9fcGkSxJzs5KwIWSnNuLJQ3x8PrN45UKatTjuaoLF2AROs0Zxgi
         RBbQ==
X-Gm-Message-State: APjAAAWkOHz9jNZVeOegcGP6uo3XFy2Hebw5Z0MJIdnL3E8pXZ25LKHb
        ZuROIfvdIarbUQFaBbpD0HK8twUoecFeA3wG2EkuDg==
X-Google-Smtp-Source: APXvYqzER/6ghfGh+cCnTzWqlcRB44urm1l0GO8Y6AzN702AqR5wrDwl3TwRIfhgqi7cB1Nz5b8PL34nNbf3GVcacss=
X-Received: by 2002:a05:6602:220d:: with SMTP id n13mr19253423ion.104.1561148108546;
 Fri, 21 Jun 2019 13:15:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190326182742.16950-1-matthewgarrett@google.com>
 <20190326182742.16950-7-matthewgarrett@google.com> <20190621063402.GA4528@localhost.localdomain>
 <CACdnJuvmU8PcRztTYRHes-O3QVwiXy_PQvP9AP=B=byX4Pu3uA@mail.gmail.com>
In-Reply-To: <CACdnJuvmU8PcRztTYRHes-O3QVwiXy_PQvP9AP=B=byX4Pu3uA@mail.gmail.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Fri, 21 Jun 2019 13:14:57 -0700
Message-ID: <CACdnJusyS=bHXTYMxQWObVL6rzGnh1g3KETayh0wyVEYdcjnpA@mail.gmail.com>
Subject: Re: [PATCH V31 06/25] kexec_file: split KEXEC_VERIFY_SIG into
 KEXEC_SIG and KEXEC_SIG_FORCE
To:     Dave Young <dyoung@redhat.com>
Cc:     James Morris <jmorris@namei.org>, Jiri Bohac <jbohac@suse.cz>,
        Linux API <linux-api@vger.kernel.org>,
        kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jun 21, 2019 at 1:13 PM Matthew Garrett <mjg59@google.com> wrote:
>
> On Thu, Jun 20, 2019 at 11:34 PM Dave Young <dyoung@redhat.com> wrote:
> > Force use -EKEYREJECTED is odd,  why not just use original "ret"?
>
> Fair question. Jiri, any feelings here?

Actually, looks like this change was made by Dave Howells.
