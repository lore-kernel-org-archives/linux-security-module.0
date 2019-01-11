Return-Path: <SRS0=b8Ih=PT=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542F9C43612
	for <linux-security-module@archiver.kernel.org>; Fri, 11 Jan 2019 01:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 273EC20872
	for <linux-security-module@archiver.kernel.org>; Fri, 11 Jan 2019 01:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="ClvvaPny"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbfAKB5a (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 10 Jan 2019 20:57:30 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40157 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728225AbfAKB5a (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 10 Jan 2019 20:57:30 -0500
Received: by mail-lj1-f194.google.com with SMTP id n18-v6so11532976lji.7
        for <linux-security-module@vger.kernel.org>; Thu, 10 Jan 2019 17:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hscE/JZej9f3YLwX0dLd86JZIHcT7l6BrwwT9w3M78o=;
        b=ClvvaPnyc4vI3padnYMXc8L0MXoIH/eAegyeZW/tE+BBqI9Ss90l0fOBgMlj1MAfja
         uIp55UQ5IAse/bbjr0pVjpEyMX9YwAq/6gJstP18onU4B/wArO39aK/5vZiTtpHGSyNd
         jrSTtf7UMrrMHXFIfhreI7kQDZnO4DqBuwKL6ZXbXOEZd82CtyCpN2Yh7jg1XAEqGTC4
         nk/HalHzvWrXgaFoMEVBnzop3iR4E6x0NTj2WmqnifZQeiiov2c1jK4L52gWJKY//Ud7
         6SXAKYToIxWAMwkuvoXY57ETsc4Ve9BalMHEVXiek7w6+zRYjI/i96zGUhSGOiM79++M
         rIxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hscE/JZej9f3YLwX0dLd86JZIHcT7l6BrwwT9w3M78o=;
        b=fgtTVCUnQ/q+ts/qcLUKfOZjMg7z7MrSYTHhGan/23M6vUyvC24IdyxJvSrQcmybo1
         m78/xJgmXOEma3XvEODXtcfdcB9yJv+N3bfmN/jCZIrnc+1CXchcayt3M06MWiJJY2x8
         518CfLIxWpInr+wK77aZQ2MnGzW88aPLDo13Jauu02qON5/16f5Xf/qX2tTyG5bQDcU5
         Xv3zhHW9WS9EMdOIeCPP9Qm/uwbtPDqo9CRTPayhYVIhvrjVikT3Y/cjg6RIVfZBvq7l
         3xTXml0yNAHPqSZtT8bDR/VYk3MkDndrkjq754iBYWOMCC2dQTvgOLP0+e0Hfw62ZsZ8
         WqCw==
X-Gm-Message-State: AJcUukdIlzLVdvn6e8a1cWKL9BrZv58Vjqrlig/F1SRJERQ/5LUFoAsC
        tS7FCfO3UJPoSlEEpxu+EU0VmGWEImaRBXL7E2Sc
X-Google-Smtp-Source: ALg8bN6SBM29paG7MbH7+0Ry1H4CevYRgdSzOtWLkGEt+UPEii0lfDLwp907WLzAyF2el6TAPFS2fIRjuY/GZ4v15uo=
X-Received: by 2002:a2e:834a:: with SMTP id l10-v6mr7047287ljh.42.1547171848068;
 Thu, 10 Jan 2019 17:57:28 -0800 (PST)
MIME-Version: 1.0
References: <20190109162830.8309-1-omosnace@redhat.com> <20190109162830.8309-2-omosnace@redhat.com>
 <cbe734fb-cd91-57a8-0de5-f4f0f8a1a2cd@schaufler-ca.com>
In-Reply-To: <cbe734fb-cd91-57a8-0de5-f4f0f8a1a2cd@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 10 Jan 2019 20:57:17 -0500
Message-ID: <CAHC9VhS6pGycbT1GET5CHjxgYCDu1KCrcPtcF0n==1oH15kAVA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] LSM: Add new hook for generic node initialization
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jan 9, 2019 at 12:08 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 1/9/2019 8:28 AM, Ondrej Mosnacek wrote:
> > This patch introduces a new security hook that is intended for
> > initializing the security data for newly created pseudo filesystem
> > objects (such as kernfs nodes) that provide a way of storing a
> > non-default security context, but need to operate independently from
> > mounts.
> >
> > The main motivation is to allow kernfs nodes to inherit the context of
> > the parent under SELinux, similar to the behavior of
> > security_inode_init_security(). Other LSMs may implement their own logic
> > for handling the creation of new nodes.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  include/linux/lsm_hooks.h | 30 ++++++++++++++++++++++++++++++
> >  include/linux/security.h  | 14 ++++++++++++++
> >  security/security.c       | 10 ++++++++++
> >  3 files changed, 54 insertions(+)
> >
> > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> > index aaeb7fa24dc4..3a2399d7721f 100644
> > --- a/include/linux/lsm_hooks.h
> > +++ b/include/linux/lsm_hooks.h
> > @@ -429,6 +429,31 @@
> >   *   to abort the copy up. Note that the caller is responsible for reading
> >   *   and writing the xattrs as this hook is merely a filter.
> >   *
> > + * Security hooks for special file-like objects
> > + *
> > + * @object_init_security:
>
> I don't like the name. There are too many things that are "objects"
> for this to be meaningful. I also dislike seeing names like
> security_object_init_security. How about init_from_parent? If there's
> never a chance that it will be used anywhere but with kernfs, it could
> be kernfs_node_init. The existing set of hook names are sufficiently
> confusing without adding to the mystery.

I like the naming similarity with inode_init_security(), that seems
helpful.  Although I somewhat understand you concern about the generic
"object".  Could you live with kernfs_init_security()?  If another fs
adopts it, we could always changing the name later if needed.

-- 
paul moore
www.paul-moore.com
