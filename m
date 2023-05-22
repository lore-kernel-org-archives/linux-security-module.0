Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6720C77B75
	for <linux-security-module@archiver.kernel.org>; Mon, 22 May 2023 17:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjEVRl7 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 22 May 2023 13:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjEVRl6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 May 2023 13:41:58 -0400
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4145FA
        for <linux-security-module@vger.kernel.org>; Mon, 22 May 2023 10:41:55 -0700 (PDT)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 29066629; Mon, 22 May 2023 12:41:54 -0500 (CDT)
Date:   Mon, 22 May 2023 12:41:54 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH -next] capability: fix kernel-doc warnings in capability.c
Message-ID: <20230522174154.GA336383@mail.hallyn.com>
References: <20230511012715.3692211-1-cuigaosheng1@huawei.com>
 <20230511052527.GA115075@mail.hallyn.com>
 <CAHC9VhT0mRM33JMe8qQ-cevDxfM8zb-FbA=27h07VqB6igAJ=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhT0mRM33JMe8qQ-cevDxfM8zb-FbA=27h07VqB6igAJ=A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, May 19, 2023 at 04:58:46PM -0400, Paul Moore wrote:
> On Thu, May 11, 2023 at 1:31 AM Serge E. Hallyn <serge@hallyn.com> wrote:
> >
> > On Thu, May 11, 2023 at 09:27:15AM +0800, Gaosheng Cui wrote:
> > > Fix all kernel-doc warnings in capability.c:
> > >
> > > kernel/capability.c:477: warning: Function parameter or member 'idmap'
> > > not described in 'privileged_wrt_inode_uidgid'
> > > kernel/capability.c:493: warning: Function parameter or member 'idmap'
> > > not described in 'capable_wrt_inode_uidgid'
> > >
> > > Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> >
> > Acked-by: Serge Hallyn <serge@hallyn.com>
> 
> I'm guessing you would prefer it if I took this via the LSM tree Serge?

That would be great, thank you.

> > >  kernel/capability.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/kernel/capability.c b/kernel/capability.c
> > > index 3e058f41df32..1a2795102ae4 100644
> > > --- a/kernel/capability.c
> > > +++ b/kernel/capability.c
> > > @@ -467,6 +467,7 @@ EXPORT_SYMBOL(file_ns_capable);
> > >  /**
> > >   * privileged_wrt_inode_uidgid - Do capabilities in the namespace work over the inode?
> > >   * @ns: The user namespace in question
> > > + * @idmap: idmap of the mount @inode was found from
> > >   * @inode: The inode in question
> > >   *
> > >   * Return true if the inode uid and gid are within the namespace.
> > > @@ -481,6 +482,7 @@ bool privileged_wrt_inode_uidgid(struct user_namespace *ns,
> > >
> > >  /**
> > >   * capable_wrt_inode_uidgid - Check nsown_capable and uid and gid mapped
> > > + * @idmap: idmap of the mount @inode was found from
> > >   * @inode: The inode in question
> > >   * @cap: The capability in question
> > >   *
> > > --
> > > 2.25.1
> 
> -- 
> paul-moore.com
