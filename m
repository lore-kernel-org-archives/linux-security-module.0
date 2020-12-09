Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7736C19425
	for <linux-security-module@archiver.kernel.org>; Wed,  9 Dec 2020 16:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8992423C17
	for <linux-security-module@archiver.kernel.org>; Wed,  9 Dec 2020 16:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731338AbgLIQVi (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 9 Dec 2020 11:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgLIQVf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 9 Dec 2020 11:21:35 -0500
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2773C0613D6
        for <linux-security-module@vger.kernel.org>; Wed,  9 Dec 2020 08:20:54 -0800 (PST)
Received: by mail-vs1-xe43.google.com with SMTP id u7so1173366vsg.11
        for <linux-security-module@vger.kernel.org>; Wed, 09 Dec 2020 08:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ftrjIMacRnCDUW60B5wDdWIgLtC6j6ITMAxZ0z4dcsk=;
        b=HgrvSW72NUDBACx2rcJOdsk9j2ywqmTiRhxzfml2ObmeS9/p68ApjmmEUiVuFFixel
         U8V/3sWV/jT/RnYtuN76/jqqa0beH35lqx0GkOdrSQB8kmGRwv6xH/mpxgBW9stqYh98
         TB1KeZ8zKUBTeHyC8I0eCxJ7EFkcfOUQYVVWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ftrjIMacRnCDUW60B5wDdWIgLtC6j6ITMAxZ0z4dcsk=;
        b=hOTEgdi1w7shkhU+g1K9DxRPNdT2hvWd2mm9WQd3OmCF1KvpZ9CvPcKqBqCOb9sNnB
         mzmQ4fBNTh60t5oQKZGIXr3Cuz9UrrCHk/Pomsl5XcNs3aJN73zfB9fMZMo9GQpP/wgp
         G+43Y6G3cq+m0253vE2LCvYe+Hr7kSlygQrUl5+ZVnjh+q6CYnJkWyHfNV7ZK2Bsk6SP
         MuFvAheMXbPeIRp+SY5YWFpqTv1B/Or0YUnqVFSz6Wr1li1a0xcJa8sebwDyPmVxC6JP
         nHRHMxnQ033IYs6F700TXPoIBjCpVbVTn9sYtY4peeJGZRNiShIv2DiMQBB3qlDK3i6z
         XhbQ==
X-Gm-Message-State: AOAM530qp4ZTxaVL5dqXywDqOsWvPaKu+KOqBbAMGLmrFgAWqtLXnMSE
        6c5JfxZMmypyCxSMPeyO1eFRYwlNM1Cb9Qj5Bvim/w==
X-Google-Smtp-Source: ABdhPJzZZ3IkQz7rOL8NyykGCELcBs/amTcJ+Xv2OgUQT+RVIeDoKVuHGvs38tWdvxSIhPXmjhSG0BuRFZBayhnap/U=
X-Received: by 2002:a67:ed57:: with SMTP id m23mr2755029vsp.7.1607530854236;
 Wed, 09 Dec 2020 08:20:54 -0800 (PST)
MIME-Version: 1.0
References: <20201207163255.564116-1-mszeredi@redhat.com> <20201207163255.564116-4-mszeredi@redhat.com>
 <CAOQ4uxhti+COYB3GhfMcPFwpfBRYQvr98oCO9wwS029W5e0A5g@mail.gmail.com> <CAJfpegsGpS=cym2NpnS6H-uMyLMKdbLpE1QxiDz4GQU1s-dYfg@mail.gmail.com>
In-Reply-To: <CAJfpegsGpS=cym2NpnS6H-uMyLMKdbLpE1QxiDz4GQU1s-dYfg@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 9 Dec 2020 17:20:43 +0100
Message-ID: <CAJfpeguvt-Mia9YmT55q3R9tSFocpgq7FzjDKJgnaOEQsaBNVA@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] ovl: check privs before decoding file handle
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Dec 9, 2020 at 11:13 AM Miklos Szeredi <miklos@szeredi.hu> wrote:

> Hard link indexing should work without fh decoding, since it is only
> encoding the file handle to search for the index entry, and encoding
> is not privileged.

Tested this a bit and while hard link indexing does work,  inode
lookup is broken since it uses the origin inode as a key (which is not
available) instead of using the origin value directly.  This is
fixable, but needs a fair amount of restructuring, so let's just
postpone this and disable index for now, as you suggested.

Thanks,
Miklos
