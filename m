Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82CCC4321A
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Mar 2021 00:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C3A364F10
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Mar 2021 00:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbhCCX7q (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 3 Mar 2021 18:59:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41529 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1359033AbhCCN0R (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 3 Mar 2021 08:26:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614777850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vk447qmcUk9k9oiYBDQSU0MXpWTCWyE8diWCiLIMsCQ=;
        b=VsAu2uYPScKRXhYt4/3BbxR486eITEomDYd/GiG5diJxFo6LwvNohuYA0DIiTfVo4N4q1Z
        ozqTSbadjPuBuf7aKsqN517mVZg/qnxcOYc2fDyWuLl01nHtn+BfVpipShyOdDHtFEgW9n
        N8ymIFNlf5XYkKwyqbJ3fvc92rDLhsw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-SfutzYt4PO6iqn8pozASaw-1; Wed, 03 Mar 2021 08:24:06 -0500
X-MC-Unique: SfutzYt4PO6iqn8pozASaw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6A9D804023;
        Wed,  3 Mar 2021 13:24:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-119-68.rdu2.redhat.com [10.10.119.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 205305D9E2;
        Wed,  3 Mar 2021 13:24:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
In-Reply-To: <20210121131959.646623-10-christian.brauner@ubuntu.com>
References: <20210121131959.646623-10-christian.brauner@ubuntu.com> <20210121131959.646623-1-christian.brauner@ubuntu.com>
To:     Tycho Andersen <tycho@tycho.pizza>,
        Christian Brauner <christian.brauner@ubuntu.com>
Cc:     dhowells@redhat.com, Tycho Andersen <tycho@tycho.ws>,
        James Morris <jmorris@namei.org>,
        linux-fsdevel@vger.kernel.org,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 09/40] xattr: handle idmapped mounts
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2123327.1614777789.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
From:   David Howells <dhowells@redhat.com>
Date:   Wed, 03 Mar 2021 13:24:02 +0000
Message-ID: <2129497.1614777842@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Christian Brauner <christian.brauner@ubuntu.com> wrote:

> diff --git a/fs/cachefiles/xattr.c b/fs/cachefiles/xattr.c
> index 72e42438f3d7..a591b5e09637 100644
> --- a/fs/cachefiles/xattr.c
> +++ b/fs/cachefiles/xattr.c
> @@ -39,8 +39,8 @@ int cachefiles_check_object_type(struct cachefiles_obj=
ect *object)
>  	_enter("%p{%s}", object, type);
>  =

>  	/* attempt to install a type label directly */
> -	ret =3D vfs_setxattr(dentry, cachefiles_xattr_cache, type, 2,
> -			   XATTR_CREATE);
> +	ret =3D vfs_setxattr(&init_user_ns, dentry, cachefiles_xattr_cache, ty=
pe,
> +			   2, XATTR_CREATE);

Actually, on further consideration, this might be the wrong thing to do in
cachefiles.  The creds are (or should be) overridden when accesses to the
underlying filesystem are being made.

I wonder if this should be using current_cred()->user_ns or
cache->cache_cred->user_ns instead.

David

