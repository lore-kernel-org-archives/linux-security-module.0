Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8AFCC433F5
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Oct 2021 20:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA6A261050
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Oct 2021 20:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234687AbhJLUk1 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 12 Oct 2021 16:40:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23963 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234460AbhJLUkZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 12 Oct 2021 16:40:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634071102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S5Pmm7g3Bz2KQhtrNfKpNDBMQE3LgrNn+xIsRNrSIe8=;
        b=cPdY7PvkpBtL2HmAUKPCD6q2MFwLIT0jjz4WFJAYs43Exle3t1GJi+ZjUAUniRSzDOQMAv
        /Y1Wm7X5Wq0EWF9PxkPXVArxSQ8OKZ+WKmDZ/MpmU0suMBnzcd3k2HMZg0BoizmiUMr4yd
        mz4BTa3pnPnr5KaRAt6y/I6fK1ytXvA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-kXnmsHdNPUKMdkMXbmxdIw-1; Tue, 12 Oct 2021 16:38:21 -0400
X-MC-Unique: kXnmsHdNPUKMdkMXbmxdIw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5AFA5074E;
        Tue, 12 Oct 2021 20:38:19 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.9.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 40BFD1037F36;
        Tue, 12 Oct 2021 20:38:17 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id C431422023A; Tue, 12 Oct 2021 16:38:16 -0400 (EDT)
Date:   Tue, 12 Oct 2021 16:38:16 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, miklos@szeredi.hu,
        virtio-fs@redhat.com, chirantan@chromium.org,
        stephen.smalley.work@gmail.com, dwalsh@redhat.com,
        omosnace@redhat.com
Subject: Re: [PATCH v2 1/2] fuse: Add a flag FUSE_SECURITY_CTX
Message-ID: <YWXyOH0oA2C5TOSF@redhat.com>
References: <20211012180624.447474-1-vgoyal@redhat.com>
 <20211012180624.447474-2-vgoyal@redhat.com>
 <2a7afeee-1f34-fb1c-13b1-0af1dcd95b68@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a7afeee-1f34-fb1c-13b1-0af1dcd95b68@schaufler-ca.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Oct 12, 2021 at 12:09:35PM -0700, Casey Schaufler wrote:
> On 10/12/2021 11:06 AM, Vivek Goyal wrote:
> > Add the FUSE_SECURITY_CTX flag for the `flags` field of the
> > fuse_init_out struct.  When this flag is set the kernel will append the
> > security context for a newly created inode to the request (create,
> > mkdir, mknod, and symlink).  The server is responsible for ensuring that
> > the inode appears atomically (preferrably) with the requested security context.
> >
> > For example, if the server is backed by a "real" linux file system then
> > it can write the security context value to
> > /proc/thread-self/attr/fscreate before making the syscall to create the
> > inode.
> 
> his only works for SELinux, as I've mentioned before. Perhaps:
> 
> If the server is using SELinux and backed by a "real" linux file system
> that supports extended attributes it can write the security context value
> to /proc/thread-self/attr/fscreate before making the syscall to create
> the inode.

Agreed, this comment is more accurate. Server needs to be using SELinux.

Vivek

> 
> >
> > Vivek:
> > This patch is slightly modified version of patch from
> > Chirantan Ekbote <chirantan@chromium.org>. I made changes so that this
> > patch applies to latest kernel.
> >
> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > ---
> >  include/uapi/linux/fuse.h | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > index 36ed092227fa..2fe54c80051a 100644
> > --- a/include/uapi/linux/fuse.h
> > +++ b/include/uapi/linux/fuse.h
> > @@ -184,6 +184,10 @@
> >   *
> >   *  7.34
> >   *  - add FUSE_SYNCFS
> > + *
> > + *  7.35
> > + *  - add FUSE_SECURITY_CTX flag for fuse_init_out
> > + *  - add security context to create, mkdir, symlink, and mknod requests
> >   */
> >  
> >  #ifndef _LINUX_FUSE_H
> > @@ -219,7 +223,7 @@
> >  #define FUSE_KERNEL_VERSION 7
> >  
> >  /** Minor version number of this interface */
> > -#define FUSE_KERNEL_MINOR_VERSION 34
> > +#define FUSE_KERNEL_MINOR_VERSION 35
> >  
> >  /** The node ID of the root inode */
> >  #define FUSE_ROOT_ID 1
> > @@ -336,6 +340,8 @@ struct fuse_file_lock {
> >   *			write/truncate sgid is killed only if file has group
> >   *			execute permission. (Same as Linux VFS behavior).
> >   * FUSE_SETXATTR_EXT:	Server supports extended struct fuse_setxattr_in
> > + * FUSE_SECURITY_CTX:	add security context to create, mkdir, symlink, and
> > + * 			mknod
> >   */
> >  #define FUSE_ASYNC_READ		(1 << 0)
> >  #define FUSE_POSIX_LOCKS	(1 << 1)
> > @@ -367,6 +373,7 @@ struct fuse_file_lock {
> >  #define FUSE_SUBMOUNTS		(1 << 27)
> >  #define FUSE_HANDLE_KILLPRIV_V2	(1 << 28)
> >  #define FUSE_SETXATTR_EXT	(1 << 29)
> > +#define FUSE_SECURITY_CTX	(1 << 30)
> >  
> >  /**
> >   * CUSE INIT request/reply flags
> 

