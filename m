Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9E8C433F5
	for <linux-security-module@archiver.kernel.org>; Fri, 13 May 2022 16:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235602AbiEMQ3g (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 13 May 2022 12:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235531AbiEMQ3g (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 13 May 2022 12:29:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B379894198
        for <linux-security-module@vger.kernel.org>; Fri, 13 May 2022 09:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652459372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wPAv5hHS+2+NL1LWGdNroHEvnnxHLkPkD7FQQ5EMMCs=;
        b=RvrLSUnjStC/D1AEOU7ZJWeXCtXhexNsMj9W3T8uPsM/xeLBlo6WtLpPNLu4ieNbl+9/2D
        tYG+zIGn1KRq4CdojqPmS8kH3berCYM9YYRYAyG8/ef1rzRJKfYiIv3TilEnbDtUtT38QS
        dAoEz3M8C7w0PFHwBu/ASQS2xMYkw8I=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-173-ji5-LAcNORWsIyVJpMKoLw-1; Fri, 13 May 2022 12:29:31 -0400
X-MC-Unique: ji5-LAcNORWsIyVJpMKoLw-1
Received: by mail-qk1-f200.google.com with SMTP id bl27-20020a05620a1a9b00b0069994eeb30cso6701518qkb.11
        for <linux-security-module@vger.kernel.org>; Fri, 13 May 2022 09:29:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wPAv5hHS+2+NL1LWGdNroHEvnnxHLkPkD7FQQ5EMMCs=;
        b=Do8cORGPbC4qsHSPqxUtnT3Nq2VmaqOUs1JF85kC6SUCVHA1/S32JoONVGTyYWi4qq
         WRGGiKzlcjwMROzKum6eToC2lkz4Ocb+0UfvHKayNRBJxR8ntlLf0w2bBuYEAgI4r6wY
         Gdf+uhaOhc51irxkHWJt2DweBwu/xYiFr4+F0SWYwZZOM9ZVUbHdLfF0VPfAypQS+JeG
         g5tuXTeZ17JSqveGFD2Ox+06zNnF8L95gjjC+kMsVZoBctEIV1MhH4EqVpSZvi/X/3Je
         LNMPf9shKTiQlLbX4Uzq8FYl/vMnscLMyNhORXYq5TKYQHrenflXyxcia0e8jKJS7Bk8
         KT9A==
X-Gm-Message-State: AOAM5309TyN7ck+db1YGSaEozYz9uHcYTWu09VLgu9mZFgy4WZ/znKzj
        lqGK8KSRa2rCPSEBMMVqqXQxzu9ovRw0xo+tG9Ufw1UQKPgMJKQ8JqJu+HlWff9D9Dv4ABIwxxO
        bgMz/f4//qhFJUr7UJ75H/PJ5pZEsdeuhsUc=
X-Received: by 2002:a05:6214:2ae:b0:456:31d0:c934 with SMTP id m14-20020a05621402ae00b0045631d0c934mr5145345qvv.45.1652459371285;
        Fri, 13 May 2022 09:29:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz51XOenaZG7oKBy9PprOx68Yse9jbiQoQlGc2RkO/uD1HBYQRnWq6eYh+w1GgNkbSjWQk3Hw==
X-Received: by 2002:a05:6214:2ae:b0:456:31d0:c934 with SMTP id m14-20020a05621402ae00b0045631d0c934mr5145333qvv.45.1652459371092;
        Fri, 13 May 2022 09:29:31 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id z4-20020ac875c4000000b002f39b99f6adsm1676208qtq.71.2022.05.13.09.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 09:29:30 -0700 (PDT)
Date:   Fri, 13 May 2022 12:29:29 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dm: Add verity helpers for LoadPin
Message-ID: <Yn6HaVbfBxmmWkvI@redhat.com>
References: <20220504195419.1143099-1-mka@chromium.org>
 <20220504125404.v3.1.I3e928575a23481121e73286874c4c2bdb403355d@changeid>
 <YnwioaRiVmYevo8i@google.com>
 <Yn1BkO4t+CXR0nzk@redhat.com>
 <Yn1xyVmPJGQz31lN@google.com>
MIME-Version: 1.0
In-Reply-To: <Yn1xyVmPJGQz31lN@google.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=snitzer@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, May 12 2022 at  4:44P -0400,
Matthias Kaehlcke <mka@chromium.org> wrote:

> On Thu, May 12, 2022 at 01:19:12PM -0400, Mike Snitzer wrote:
> > On Wed, May 11 2022 at  4:54P -0400,
> > Matthias Kaehlcke <mka@chromium.org> wrote:
> > 
> > > Alasdar/Mike, I'd be interested in your take on adding these functions
> > > to verity/DM, to get an idea whether this series has a path forward to
> > > landing upstream.
> > 
> > I'll be reviewing your patchset now. Comments inlined below.
> > 
> > > On Wed, May 04, 2022 at 12:54:17PM -0700, Matthias Kaehlcke wrote:
> > > > LoadPin limits loading of kernel modules, firmware and certain
> > > > other files to a 'pinned' file system (typically a read-only
> > > > rootfs). To provide more flexibility LoadPin is being extended
> > > > to also allow loading these files from trusted dm-verity
> > > > devices. For that purpose LoadPin can be provided with a list
> > > > of verity root digests that it should consider as trusted.
> > > > 
> > > > Add a bunch of helpers to allow LoadPin to check whether a DM
> > > > device is a trusted verity device. The new functions broadly
> > > > fall in two categories: those that need access to verity
> > > > internals (like the root digest), and the 'glue' between
> > > > LoadPin and verity. The new file dm-verity-loadpin.c contains
> > > > the glue functions.
> > > > 
> > > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > > ---
> > > > 
> > > > Changes in v3:
> > > > - none
> > > > 
> > > > Changes in v2:
> > > > - none
> > > > 
> > > >  drivers/md/Makefile               |  6 +++
> > > >  drivers/md/dm-verity-loadpin.c    | 80 +++++++++++++++++++++++++++++++
> > > >  drivers/md/dm-verity-target.c     | 33 +++++++++++++
> > > >  drivers/md/dm-verity.h            |  4 ++
> > > >  include/linux/dm-verity-loadpin.h | 27 +++++++++++
> > > >  5 files changed, 150 insertions(+)
> > > >  create mode 100644 drivers/md/dm-verity-loadpin.c
> > > >  create mode 100644 include/linux/dm-verity-loadpin.h
> > > > 
> > > > diff --git a/drivers/md/Makefile b/drivers/md/Makefile
> > > > index 0454b0885b01..e12cd004d375 100644
> > > > --- a/drivers/md/Makefile
> > > > +++ b/drivers/md/Makefile
> > > > @@ -100,6 +100,12 @@ ifeq ($(CONFIG_IMA),y)
> > > >  dm-mod-objs			+= dm-ima.o
> > > >  endif
> > > >  
> > > > +ifeq ($(CONFIG_DM_VERITY),y)
> > > > +ifeq ($(CONFIG_SECURITY_LOADPIN),y)
> > > > +dm-mod-objs			+= dm-verity-loadpin.o
> > > > +endif
> > > > +endif
> > > > +
> > 
> > Why are you extending dm-mod-objs?  Why not dm-verity-objs?
> 
> Sorry, I missed to address this comment in my earlier reply.
> 
> I don't recall why I chose dm-mod-objs initially, agreed that
> dm-verity-objs seems a better fit.

Yes, should be fixed even though the 3rd patch removes this change.

BTW, looking at the 2nd patch's loadpin_is_fs_trusted().  Seems to me
you'd do well to pass a 'struct block_device *' to a DM helper rather
than force security/loadpin/loadpin.c to mess around with DM device
refcounting, etc.

