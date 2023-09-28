Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A018FCE7B1E
	for <linux-security-module@archiver.kernel.org>; Thu, 28 Sep 2023 19:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjI1TgA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 28 Sep 2023 15:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjI1Tf7 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 28 Sep 2023 15:35:59 -0400
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608F41A1;
        Thu, 28 Sep 2023 12:35:57 -0700 (PDT)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 9128C60B; Thu, 28 Sep 2023 14:35:55 -0500 (CDT)
Date:   Thu, 28 Sep 2023 14:35:55 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     John Johansen <john.johansen@canonical.com>
Cc:     Li kunyu <kunyu@nfschina.com>, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, apparmor@lists.ubuntu.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] apparmor/file: Removing unnecessary initial values
 for variable pointers
Message-ID: <20230928193555.GA1908893@mail.hallyn.com>
References: <20230919015608.8390-1-kunyu@nfschina.com>
 <056095ad-ecf4-b93e-252a-7e3c48e94f11@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <056095ad-ecf4-b93e-252a-7e3c48e94f11@canonical.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Sep 28, 2023 at 10:36:16AM -0700, John Johansen wrote:
> On 9/18/23 18:56, Li kunyu wrote:
> > These variable pointers are assigned during use and do not need to be
> > initialized for assignment.
> > 
> > Signed-off-by: Li kunyu <kunyu@nfschina.com>
> > ---
> >   v2: Fix timestamp issues
> > 
> >   security/apparmor/file.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/security/apparmor/file.c b/security/apparmor/file.c
> > index 698b124e649f..12eafdf18fc0 100644
> > --- a/security/apparmor/file.c
> > +++ b/security/apparmor/file.c
> > @@ -264,7 +264,7 @@ int aa_path_perm(const char *op, struct aa_label *label,
> >   {
> >   	struct aa_perms perms = {};
> >   	struct aa_profile *profile;
> > -	char *buffer = NULL;
> > +	char *buffer;
> 
> this is okay
> 
> >   	int error;
> >   	flags |= PATH_DELEGATE_DELETED | (S_ISDIR(cond->mode) ? PATH_IS_DIR :
> > @@ -412,7 +412,7 @@ int aa_path_link(struct aa_label *label, struct dentry *old_dentry,
> >   		d_backing_inode(old_dentry)->i_uid,
> >   		d_backing_inode(old_dentry)->i_mode
> >   	};
> > -	char *buffer = NULL, *buffer2 = NULL;
> > +	char *buffer, *buffer2;
> 
> this can cause an oops if buffer2 allocation fails. There are a couple of ways I can
> see to fix this, do you want to take a crack at it.
> 
> 
> >   	struct aa_profile *profile;
> >   	int error;

I don't whether this kind of thing has become in vogue, but while indeed
the first case is okay right now, it becomes more likely that a future patch
to this function will inadvertently goto aa_put_buffer(buffer) before the
aa_get_buffer call.  I would not have NACKed an original version of this fn
without the = NULL, but I'm not in favor of dropping it.

-serge
