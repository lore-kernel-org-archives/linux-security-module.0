Return-Path: <SRS0=LaDg=AG=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E410C433E2
	for <linux-security-module@archiver.kernel.org>; Thu, 25 Jun 2020 14:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E40420702
	for <linux-security-module@archiver.kernel.org>; Thu, 25 Jun 2020 14:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9LygiLf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405385AbgFYO1F (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 25 Jun 2020 10:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405189AbgFYO1E (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 25 Jun 2020 10:27:04 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E589C08C5C1;
        Thu, 25 Jun 2020 07:27:04 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id r8so5116603oij.5;
        Thu, 25 Jun 2020 07:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dC6tzsYILRcNlhPsnZrmlaBj5Ye3SKdAeItsQWIKi+U=;
        b=M9LygiLfmAIu+6g8BP4Bu2tbYOsK3jVQtZOrRqfNcuTBuKzBGFW7+LfZrTf0jchCsN
         s3HMj3Z2gv5rVJUA6D9gfFprtaaMCy3p7G6sNmxarvTNNoaGLLWdyQ+hW5WAssToNGwC
         hT1MBUi9ZCBs5hiQQfmjeVHcfMqhOALMmwTJov1aU4RG1a5ZPPlEPwKKLv7A8qTUCRNa
         DfKZ9mUZkQkiczhlsrOgg6PrgKHCAeDSc4JI+x4pVHOyT9b2hzRgGCNqrry2NsyQjaBh
         9mZUDMp32SXHohfxgJkzddiZfAU1yU7icmtV5CjG4CK1z6IlvbJEnYC4lF0AT7BJ0E5m
         E2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dC6tzsYILRcNlhPsnZrmlaBj5Ye3SKdAeItsQWIKi+U=;
        b=rK0hDx0+S6pZMy1ES8jbnv90r0I/Vko+KjiQYOphWxLQecC7hyNISG0UdpCfAa+XR1
         M/cEH/5xpAZn9nhaCp7fl5eso3TKquQW/nbXh7bRMJbPda8AD6adct+S/hHIAxrLaE9m
         lQ1lZa35s7uBIQcmUMJc3RwZnwfDgaDwO/4FS8N/YJmPfY9x4UbgI+E+8FIM1QUxyXQF
         LyU/Irt1sA0O0sNbMTsCsklpP/HVH0goYp4EfYXOoJ9OJRcNkVsmdZdVSeITohgUEZtZ
         t6klbpMz1cu9YmM+HQq/T4RxaC13rwYPIUaIBOs9g0KDfNkP2Olk1CMegP9MUwjO3bsO
         j07g==
X-Gm-Message-State: AOAM533ABa0LvAB8ITpeSbQANFaO9WCUZ+MmSCR31AH0DuvoELDJXbAe
        lymvVfYv9TwaRW84JP0DGZ+C/7Oe4AlxVZ7anyE=
X-Google-Smtp-Source: ABdhPJzGMW1G46L2SJvq0qCi+cGzWPcwMkGo0yId5qaC1b07LSRyGeSOP2vSiAZLCUb92wYp6Kox6oQBE3XUXZcyeQ8=
X-Received: by 2002:aca:55c1:: with SMTP id j184mr2251086oib.160.1593095223763;
 Thu, 25 Jun 2020 07:27:03 -0700 (PDT)
MIME-Version: 1.0
References: <87ftaxd7ky.fsf@x220.int.ebiederm.org> <20200616015552.isi6j5x732okiky4@ast-mbp.dhcp.thefacebook.com>
 <87h7v1pskt.fsf@x220.int.ebiederm.org> <20200623183520.5e7fmlt3omwa2lof@ast-mbp.dhcp.thefacebook.com>
 <87h7v1mx4z.fsf@x220.int.ebiederm.org> <20200623194023.lzl34qt2wndhcehk@ast-mbp.dhcp.thefacebook.com>
 <878sgck6g0.fsf@x220.int.ebiederm.org> <CAADnVQL8WrfV74v1ChvCKE=pQ_zo+A5EtEBB3CbD=P5ote8_MA@mail.gmail.com>
 <2f55102e-5d11-5569-8248-13618d517e93@i-love.sakura.ne.jp>
 <CAEjxPJ4e9rWWssp0CyM7GM7NP_QKkswHK7URwLZFqo5+wGecQw@mail.gmail.com> <20200625132551.GB3526980@kroah.com>
In-Reply-To: <20200625132551.GB3526980@kroah.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 25 Jun 2020 10:26:52 -0400
Message-ID: <CAEjxPJ6MEb--R=zP_wCh-zgCochgcPhy7Fp7ENTYKB2NH9c6PA@mail.gmail.com>
Subject: Re: [RFC][PATCH] net/bpfilter: Remove this broken and apparently unmantained
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        David Miller <davem@davemloft.net>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Jun 25, 2020 at 9:25 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jun 25, 2020 at 08:56:10AM -0400, Stephen Smalley wrote:
> > No, because we cannot label the inode based on the program's purpose
> > and therefore cannot configure an automatic transition to a suitable
> > security context for the process, unlike call_usermodehelper().
>
> Why, what prevents this?  Can you not just do that based on the "blob
> address" or signature of it or something like that?  Right now you all
> do this based on inode of a random file on a disk, what's the difference
> between a random blob in memory?

Given some kind of key to identify the blob and look up a suitable
context in policy, I think it would work.  We just don't have that
with the current interface.  With /bin/kmod and the like, we have a
security xattr assigned to the file when it was created that we can
use as the basis for determining the process security context.

> > On a different note, will the usermode blob be measured by IMA prior
> > to execution?  What ensures that the blob was actually embedded in the
> > kernel image and wasn't just supplied as data through exploitation of
> > a kernel vulnerability or malicious kernel module?
>
> No reason it couldn't be passed to IMA for measuring, if people want to
> do that.

Actually, I think it probably happens already via IMA's existing hooks
but just wanted to confirm that IMA doesn't ignore S_PRIVATE inodes.
