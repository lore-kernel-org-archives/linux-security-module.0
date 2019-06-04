Return-Path: <SRS0=5Pje=UD=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCC4C282CE
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Jun 2019 20:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59BAF2075B
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Jun 2019 20:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559681866;
	bh=ihQrR3672ZM/DzWjZDVj/EkCVxnHXupxxQEbDR/4vAg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=VWckEUSu0MAlvNIFCW3lgAX0CCEJLj485lOdNc60k+6pbx1ExN5AwAAAaOpgc16aQ
	 wcBipp5k6JL1uGG88/8+zK52hPLs2bnhcXOXi6iAIiUSN8gljPWI3acDgXD0DgyYD9
	 80n5U49/I63YtQafxsE2U3t2JzYKfj6W+pjT0kw8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfFDU5p (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 4 Jun 2019 16:57:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:44192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726464AbfFDU5n (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 4 Jun 2019 16:57:43 -0400
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9727620862
        for <linux-security-module@vger.kernel.org>; Tue,  4 Jun 2019 20:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559681862;
        bh=ihQrR3672ZM/DzWjZDVj/EkCVxnHXupxxQEbDR/4vAg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=I4PRguwk4bMuMypdm5AOXXn53k/m+L5N9pyKwSfTNHLewnh8M65uGMG7NNR3Ebc8l
         rsRnH3DUUzV1SO4+TidtsVDH9S4H4Orx7UfDX0ta38L+l5LFNUqPzgkVOGyqiElmZe
         nHeIlBvnyw6Sot3eJ4IIqxcrsiVBsK6rjKdIv0AM=
Received: by mail-wm1-f54.google.com with SMTP id z23so134110wma.4
        for <linux-security-module@vger.kernel.org>; Tue, 04 Jun 2019 13:57:42 -0700 (PDT)
X-Gm-Message-State: APjAAAVLVvq8unirKUsQYixtn96gpocs8L59+/jL+UOTsnnrp2HjF0MU
        zpDYvGYxAMauwLhWwdj2bthV3aZM8pjc5LdLMELKjw==
X-Google-Smtp-Source: APXvYqzjigMmzQseLoEe4mdRuIyW/gpGOaqBUS3DaksOo5KC4LVSwBy+ViDmwuhEPpoWAnb6UhQhHp6vTImgw+QurWo=
X-Received: by 2002:a7b:c450:: with SMTP id l16mr19833827wmi.0.1559681861171;
 Tue, 04 Jun 2019 13:57:41 -0700 (PDT)
MIME-Version: 1.0
References: <155966609977.17449.5624614375035334363.stgit@warthog.procyon.org.uk>
 <CALCETrWzDR=Ap8NQ5-YrVhXCEBgr+hwpjw9fBn0m2NkZzZ7XLQ@mail.gmail.com> <1207.1559680778@warthog.procyon.org.uk>
In-Reply-To: <1207.1559680778@warthog.procyon.org.uk>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 4 Jun 2019 13:57:30 -0700
X-Gmail-Original-Message-ID: <CALCETrXmjpSvVj_GROhgouNtbzLm5U9B4b364wycMaqApqDVNA@mail.gmail.com>
Message-ID: <CALCETrXmjpSvVj_GROhgouNtbzLm5U9B4b364wycMaqApqDVNA@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/8] Mount, FS, Block and Keyrings notifications [ver #2]
To:     David Howells <dhowells@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Casey Schaufler <casey@schaufler-ca.com>, raven@themaw.net,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jun 4, 2019 at 1:39 PM David Howells <dhowells@redhat.com> wrote:
>
> Andy Lutomirski <luto@kernel.org> wrote:
>
> > > Here's a set of patches to add a general variable-length notification queue
> > > concept and to add sources of events for:
> >
> > I asked before and didn't see a response, so I'll ask again.  Why are you
> > paying any attention at all to the creds that generate an event?
>
> Casey responded to you.  It's one of his requirements.
>

It being a "requirement" doesn't make it okay.

> However, the LSMs (or at least SELinux) ignore f_cred and use current_cred()
> when checking permissions.  See selinux_revalidate_file_permission() for
> example - it uses current_cred() not file->f_cred to re-evaluate the perms,
> and the fd might be shared between a number of processes with different creds.

That's a bug.  It's arguably a rather severe bug.  If I ever get
around to writing the patch I keep thinking of that will warn if we
use creds from invalid contexts, it will warn.

Let's please not repeat this.
