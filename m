Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B831C433EF
	for <linux-security-module@archiver.kernel.org>; Fri, 24 Sep 2021 21:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03AFB61242
	for <linux-security-module@archiver.kernel.org>; Fri, 24 Sep 2021 21:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244920AbhIXVSj (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 24 Sep 2021 17:18:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33408 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233640AbhIXVSj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 24 Sep 2021 17:18:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632518225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GZioS7vFZMqkXfHoKg2yJtw7jJ3DNNnz8RiO+XBslD0=;
        b=RCL4XR0pLbJ84xmeejdX/NMXbqvpbcjkraDgzy9LNgDRbF6xnLFawS8TYbPpdpDIiXyAb6
        yQCXoUVoLt/D1CgJYHXyL2pEGAgE0F2N0zfFgmqpw/gusxuyEA00og9/JoplfnLsZoYOuI
        THA1wz6BqMvA8YDl1ZliPRE7/LglFus=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-KlLlKBMLMa65iAP28HnKfQ-1; Fri, 24 Sep 2021 17:17:04 -0400
X-MC-Unique: KlLlKBMLMa65iAP28HnKfQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C422F835DE1;
        Fri, 24 Sep 2021 21:17:02 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.32.185])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B08125FC13;
        Fri, 24 Sep 2021 21:16:48 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 2B572222E4F; Fri, 24 Sep 2021 17:16:48 -0400 (EDT)
Date:   Fri, 24 Sep 2021 17:16:48 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        chirantan@chromium.org, miklos@szeredi.hu,
        stephen.smalley.work@gmail.com, dwalsh@redhat.com
Subject: Re: [PATCH 2/2] fuse: Send security context of inode on file creation
Message-ID: <YU5AQB/owpnC/yeZ@redhat.com>
References: <20210924192442.916927-1-vgoyal@redhat.com>
 <20210924192442.916927-3-vgoyal@redhat.com>
 <a843a6d9-2e7a-768c-b742-fc190880b439@schaufler-ca.com>
 <YU4ypwtADWRn/A0p@redhat.com>
 <f92a082e-c329-f079-6765-ac8b44e45ee4@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f92a082e-c329-f079-6765-ac8b44e45ee4@schaufler-ca.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Sep 24, 2021 at 01:54:20PM -0700, Casey Schaufler wrote:
> On 9/24/2021 1:18 PM, Vivek Goyal wrote:
> > On Fri, Sep 24, 2021 at 12:58:28PM -0700, Casey Schaufler wrote:
> >> On 9/24/2021 12:24 PM, Vivek Goyal wrote:
> >>> When a new inode is created, send its security context to server along
> >>> with creation request (FUSE_CREAT, FUSE_MKNOD, FUSE_MKDIR and FUSE_SYMLINK).
> >>> This gives server an opportunity to create new file and set security
> >>> context (possibly atomically). In all the configurations it might not
> >>> be possible to set context atomically.
> >>>
> >>> Like nfs and ceph, use security_dentry_init_security() to dermine security
> >>> context of inode and send it with create, mkdir, mknod, and symlink requests.
> >>>
> >>> Following is the information sent to server.
> >>>
> >>> - struct fuse_secctx.
> >>>   This contains total size of security context which follows this structure.
> >>>
> >>> - xattr name string.
> >>>   This string represents name of xattr which should be used while setting
> >>>   security context. As of now it is hardcoded to "security.selinux".
> >> Why? It's not like "security.SMACK64' is a secret.
> > Sorry, I don't understand what's the concern. Can you elaborate a bit
> > more.
> 
> Sure. Interfaces that are designed as special case solutions for
> SELinux tend to make my life miserable as the Smack maintainer and
> for the efforts to complete LSM stacking. You make the change for
> SELinux and leave the generalization as an exercise for some poor
> sod like me to deal with later.

I am not expecting you do to fuse work. Once you add the new security
hook which can return multiple labels, I will gladly do fuse work
to send multiple labels.

> 
> > I am hardcoding name to "security.selinux" because as of now only
> > SELinux implements this hook.
> 
> Yes. A Smack hook implementation is on the todo list. If you hard code
> this in fuse you're adding another thing that has to be done for
> Smack support.
> 
> >  And there is no way to know the name
> > of xattr, so I have had to hardcode it. But tomorrow if interface
> > changes so that name of xattr is also returned, we can easily get
> > rid of hardcoding.
> 
> So why not make the interface do that now?

Because its unnecessary complexity for me. When multiple label support
is not even there, I need to write and test code to support multiple
labels when support is not even there.

> 
> > If another LSM decides to implement this hook, then we can send
> > that name as well. Say "security.SMACK64".
> 
> Again, why not make it work that way now, and avoid having
> to change the protocol later? Changing protocols and interfaces
> is much harder than doing them generally in the first place.

In case of fuse, it is not that complicated to change protocol and
add new options. Once you add support for smack and multiple labels,
I will gladly change fuse to be able to accomodate that.

> 
> >>> - security context.
> >>>   This is the actual security context whose size is specified in fuse_secctx
> >>>   struct.
> >> The possibility of multiple security contexts on a file is real
> >> in the not too distant future. Also, a file can have multiple relevant
> >> security attributes at creation. Smack, for example, may assign a
> >> security.SMACK64 and a security.SMACK64TRANSMUTE attribute. Your
> >> interface cannot support either of these cases.
> > Right. As of now it does not support capability to support multiple
> > security context. But we should be easily able to extend the protocol
> > whenever that supports lands in kernel.
> 
> No. Extending single data item protocols to support multiple
> data items *hurts* most of the time. If it wasn't so much more
> complicated you'd be doing it up front without fussing about it.

Its unnecessary work at this point of time. Once multiple labels
are supported, I can do this work.

I think we will need to send extra structure which tells how many
labels are going to follow. And then all the labels will follow
with same format I am using for single label.

struct fuse_secctx; xattr name string; actual label

> 
> >  Say a new option
> > FUSE_SECURITY_CTX_EXT which will allow sending multiple security
> > context labels (along with associated xattr names).
> >
> > As of now there is no need to increase the complexity of current
> > implementation both in fuse as well as virtiofsd when kernel
> > does not even support multiple lables using security_dentry_init_security()
> > hook.
> 
> You're 100% correct. For your purpose today there's no reason to
> do anything else. It would be really handy if I didn't have yet
> another thing that I don't have the time to rewrite.

I can help with adding fuse support once smack supports it. Right now
I can't even test it even if I sign up for extra complexity.

Vivek

