Return-Path: <SRS0=NXRd=6Z=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7875C54E8D
	for <linux-security-module@archiver.kernel.org>; Mon, 11 May 2020 13:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D6C42080C
	for <linux-security-module@archiver.kernel.org>; Mon, 11 May 2020 13:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AxEioQ6g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729724AbgEKNmg (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 11 May 2020 09:42:36 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32285 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726438AbgEKNmg (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 11 May 2020 09:42:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589204555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a+4ueUpxmGyJDhdbyflC74SPtwDyNM5MVN9jc/tyoSI=;
        b=AxEioQ6gtfDKApfSJ0M5QyFLyW5aMGaBQnZK+XgD6zRzuNiAr/9q1S9wlKN6GKg9scukNE
        mRBpTSasC+DBhOTbuICh/t+BK5uynAKBpsho8neKjDvQ48PQOWDBeBj2T7RvwU42NvJ86e
        zPljbWTNqVGUJhESS1vLlMxhi3T9PR0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-32cw__SJPtu_XXRNinLaqA-1; Mon, 11 May 2020 09:42:33 -0400
X-MC-Unique: 32cw__SJPtu_XXRNinLaqA-1
Received: by mail-qv1-f70.google.com with SMTP id bm3so9705711qvb.0
        for <linux-security-module@vger.kernel.org>; Mon, 11 May 2020 06:42:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a+4ueUpxmGyJDhdbyflC74SPtwDyNM5MVN9jc/tyoSI=;
        b=eGuPsDH/eXuAf7A1+gJKKi8S+StnGOlB7Ci5fXXL59R2b/imzYpN68ANtKczYZ3a1r
         7WDUkMs56W4QstGw8CVFUP0F6vgjfOp/uUBRXA0WEuOhSC3l4NN+xmSxHErYFA2P7AAF
         LyXrlhIpwhcJR6p2hIOZ3f3ceys1CUnwaHe+uAPohE6Adb9VVqRPO02LIRprl8jk7cmT
         0Hf556i1lXTTfdckEC0eAeWkZIyodo9rfpGLGOzchJzbzh6OPxcbeZv6qxgQ8Cq0d40r
         AgQKtlHOMFNWRg3L05XrbaNa2hI/mcM/Mb+VknKaCMsT3j7i4wPDcWb9FM4n14JBhyCd
         /mjA==
X-Gm-Message-State: AGi0PubwStTP1nb5UkHPt9RdG5o/4DKxvDFw2TAfZAcunnvHU0fcwHHi
        gVZ53zRkW5zGtZiFIaqgAw4jfsJExnpiJlMH2VoYB74k3RUf/rG7mJ/rKRZY4HLWA1Mnf7VHp4l
        xKA4wHnAnQ6qujJZYel40j2+FCfpCwnxU8G1C
X-Received: by 2002:ac8:73c1:: with SMTP id v1mr2550415qtp.320.1589204552988;
        Mon, 11 May 2020 06:42:32 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ4405i17T0JRi13ewE3f6GCn+QSzyzZe5yeFSXc+m6vqXV/0lUH1IRX3bFPNx4UEMXZUpqcQ==
X-Received: by 2002:ac8:73c1:: with SMTP id v1mr2550390qtp.320.1589204552670;
        Mon, 11 May 2020 06:42:32 -0700 (PDT)
Received: from dev.jcline.org ([136.56.87.133])
        by smtp.gmail.com with ESMTPSA id c63sm7973124qkf.131.2020.05.11.06.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 06:42:31 -0700 (PDT)
Date:   Mon, 11 May 2020 09:42:30 -0400
From:   Jeremy Cline <jcline@redhat.com>
To:     James Morris <jmorris@namei.org>
Cc:     "Serge E . Hallyn" <serge@hallyn.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        David Howells <dhowells@redhat.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Frank Ch . Eigler" <fche@redhat.com>
Subject: Re: [PATCH] lockdown: Allow unprivileged users to see lockdown status
Message-ID: <20200511134230.GA2311339@dev.jcline.org>
References: <20200220151738.1492852-1-jcline@redhat.com>
 <alpine.LRH.2.21.2002220351010.18183@namei.org>
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.2002220351010.18183@namei.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, Feb 22, 2020 at 03:51:24AM +1100, James Morris wrote:
> On Thu, 20 Feb 2020, Jeremy Cline wrote:
> 
> > A number of userspace tools, such as systemtap, need a way to see the
> > current lockdown state so they can gracefully deal with the kernel being
> > locked down. The state is already exposed in
> > /sys/kernel/security/lockdown, but is only readable by root. Adjust the
> > permissions so unprivileged users can read the state.
> > 
> > Fixes: 000d388ed3bb ("security: Add a static lockdown policy LSM")
> > Cc: Frank Ch. Eigler <fche@redhat.com>
> > Signed-off-by: Jeremy Cline <jcline@redhat.com>
> 
> Looks fine to me, any objection from Matthew or others?
> 

Can we take resounding silence as no objections?

- Jeremy

> > ---
> >  security/lockdown/lockdown.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> > index 5a952617a0eb..87cbdc64d272 100644
> > --- a/security/lockdown/lockdown.c
> > +++ b/security/lockdown/lockdown.c
> > @@ -150,7 +150,7 @@ static int __init lockdown_secfs_init(void)
> >  {
> >  	struct dentry *dentry;
> >  
> > -	dentry = securityfs_create_file("lockdown", 0600, NULL, NULL,
> > +	dentry = securityfs_create_file("lockdown", 0644, NULL, NULL,
> >  					&lockdown_ops);
> >  	return PTR_ERR_OR_ZERO(dentry);
> >  }
> > 
> 
> -- 
> James Morris
> <jmorris@namei.org>
> 

