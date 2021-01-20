Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA79C43381
	for <linux-security-module@archiver.kernel.org>; Wed, 20 Jan 2021 07:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C733F23142
	for <linux-security-module@archiver.kernel.org>; Wed, 20 Jan 2021 07:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729853AbhATHzX (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 20 Jan 2021 02:55:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729577AbhATHyR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 20 Jan 2021 02:54:17 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5138EC0613ED
        for <linux-security-module@vger.kernel.org>; Tue, 19 Jan 2021 23:52:39 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id k22so3956984ual.0
        for <linux-security-module@vger.kernel.org>; Tue, 19 Jan 2021 23:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uNdd7I2hNKAtcfKQGi3GUg+MhbxssvCuRmdUQZa83G4=;
        b=Ylwu8MaIfcMtXeRHHcdwBLnRoutC82UYXqkJIBtOivUEMmhWi5MIahULll+FlWnkT7
         JmPX49Txh2CBicmCu1r/uHDoOgGt43Pt6egifpvlG0N9WkQ4sd9dWwhT2XqzPCrYxuFJ
         lvaRyu3cL5u3PMTRSekUykObI3rpbo85ziBNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uNdd7I2hNKAtcfKQGi3GUg+MhbxssvCuRmdUQZa83G4=;
        b=QPKe5vR49UgxiVYAzWq86VCoBZrtUPraOUHgF6f30k33RRsz4Sc1PjhUf73yqQ/mp+
         1/66Wq+4ER7qdDQAtijRyJ5vGgWRjagYvtPa+HC0nKDqPY2E45UBY9N3O+/fngjcn23S
         BazHGPwTnzV6Plnp+m7svhrcS9uqgNHWUHEDEjbq0YEiV9ZIynR0rVMdACk6OoBecZTV
         TGm844uAWCYtC8Vg4qg9VhkDVg2Xf5vAEMeoaRQi3asBNlJ0pyEJFkWZSuFhvJvurpvL
         FW2tJLCEYyj53Q8nSgKKkPuZ3ze80PeuhPj0iqdKQvzfpPlZNGekqAQH2FscwMToIMoq
         XhwA==
X-Gm-Message-State: AOAM532ptOmeT/S9n3DhOnhLXZCarmH++rjJOYx646vlkiVWSaxNjyt1
        +aeYqyjYo8YoleN/D8P2P1qVPMsJ/nQJz4cyUdC15Q==
X-Google-Smtp-Source: ABdhPJwRciGoD7gQP+crKeuujj3hoGxybSoXTk18gDmGI7WKaAUZHP/lExz5OVrqMvYJynhTLUACKyEZrrtu5fA93GI=
X-Received: by 2002:ab0:7296:: with SMTP id w22mr5234322uao.13.1611129158535;
 Tue, 19 Jan 2021 23:52:38 -0800 (PST)
MIME-Version: 1.0
References: <20210119162204.2081137-1-mszeredi@redhat.com> <20210119162204.2081137-2-mszeredi@redhat.com>
 <87a6t4ab7h.fsf@x220.int.ebiederm.org>
In-Reply-To: <87a6t4ab7h.fsf@x220.int.ebiederm.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 20 Jan 2021 08:52:27 +0100
Message-ID: <CAJfpegvy4u9cC7SXWqteg54q-96fH3SqqfEybcQtAMxsewAGYg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ecryptfs: fix uid translation for setxattr on security.capability
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Tyler Hicks <code@tyhicks.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jan 19, 2021 at 10:11 PM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> Miklos Szeredi <mszeredi@redhat.com> writes:
>
> > Prior to commit 7c03e2cda4a5 ("vfs: move cap_convert_nscap() call into
> > vfs_setxattr()") the translation of nscap->rootid did not take stacked
> > filesystems (overlayfs and ecryptfs) into account.
> >
> > That patch fixed the overlay case, but made the ecryptfs case worse.
> >
> > Restore old the behavior for ecryptfs that existed before the overlayfs
> > fix.  This does not fix ecryptfs's handling of complex user namespace
> > setups, but it does make sure existing setups don't regress.
>
> Today vfs_setxattr handles handles a delegated_inode and breaking
> leases.  Code that is enabled with CONFIG_FILE_LOCKING.  So unless
> I am missing something this introduces a different regression into
> ecryptfs.

This is in line with all the other cases of ecryptfs passing NULL as
delegated inode.

I'll defer this to the maintainer of ecryptfs.

Thanks,
Miklos
