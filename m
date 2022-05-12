Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6794CC433F5
	for <linux-security-module@archiver.kernel.org>; Thu, 12 May 2022 20:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358412AbiELUpC (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 12 May 2022 16:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352626AbiELUpC (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 12 May 2022 16:45:02 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B3222DA36
        for <linux-security-module@vger.kernel.org>; Thu, 12 May 2022 13:45:00 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id c1-20020a17090a558100b001dca2694f23so5926248pji.3
        for <linux-security-module@vger.kernel.org>; Thu, 12 May 2022 13:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mfDd2mUqrFJnPjYIAGb7iTHqp7/V/kqIzmO4Ik5ICtE=;
        b=VSL2P1g6oKCepZ9gpAuZb3IJYGYlROev7evIcpI2bAO4ymJpGTpTPWg28w7aZ74nqu
         +4hkrxBXxozmtUkznxUeB16mVvTNuWjlKl3GvgorQtDgqz1Nl+vcsah0mU6P4adNEl8I
         hzSvp6YfypuLT0514UmzVGtZJ2H2UTxby3128=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mfDd2mUqrFJnPjYIAGb7iTHqp7/V/kqIzmO4Ik5ICtE=;
        b=QyBJ8pVEU+UhRKIgzwqn8CFYqrBpYB/QvFcRPtyh7Q24U0epocRYq/2hesbQaeSBqJ
         A/vOIEvAFUfyMvgxgZfCjDYe4rq21RqqV/UQyenpigtB3jAOC2OsbBHc0dW+Zbrx/C7z
         tB2vkV78nL2zMu+DTm089phq/J0fKO6Nyz2HnRE26Aop1lVt057I63KD8rLZYVzF5YFN
         JPlRoMhOBPsEKEG9f/AioluofqY3qfx9LodG2sa+JLWqPloJ+KKOCoZbM4nbey7NYZxP
         3imYDYXLgg2dcHi/rXP6algb97dTNE98g9DSUETx/pcpjTbWKK9PyjagzyKz5eY2J6w4
         KHfg==
X-Gm-Message-State: AOAM5304lkRw7Um+MI2TpJQK62aBP3i0rBRDmKe059Vd8oyRwv6uHRTm
        oDGsqo5IeanHWxl8iugfkk1nUg==
X-Google-Smtp-Source: ABdhPJweC1XGidiP3A3Cg1L4P+c7vLixuIQHOEhEEVMPX3OSorgSxCxtYRx8oqG/gfH5ctvhV02/CQ==
X-Received: by 2002:a17:902:ed52:b0:15e:c71f:72c8 with SMTP id y18-20020a170902ed5200b0015ec71f72c8mr1599550plb.38.1652388299601;
        Thu, 12 May 2022 13:44:59 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:4060:29b:ac8a:c726])
        by smtp.gmail.com with UTF8SMTPSA id i9-20020aa79089000000b0050dc76281e4sm223297pfa.190.2022.05.12.13.44.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 13:44:59 -0700 (PDT)
Date:   Thu, 12 May 2022 13:44:57 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Mike Snitzer <snitzer@redhat.com>
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
Message-ID: <Yn1xyVmPJGQz31lN@google.com>
References: <20220504195419.1143099-1-mka@chromium.org>
 <20220504125404.v3.1.I3e928575a23481121e73286874c4c2bdb403355d@changeid>
 <YnwioaRiVmYevo8i@google.com>
 <Yn1BkO4t+CXR0nzk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yn1BkO4t+CXR0nzk@redhat.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, May 12, 2022 at 01:19:12PM -0400, Mike Snitzer wrote:
> On Wed, May 11 2022 at  4:54P -0400,
> Matthias Kaehlcke <mka@chromium.org> wrote:
> 
> > Alasdar/Mike, I'd be interested in your take on adding these functions
> > to verity/DM, to get an idea whether this series has a path forward to
> > landing upstream.
> 
> I'll be reviewing your patchset now. Comments inlined below.
> 
> > On Wed, May 04, 2022 at 12:54:17PM -0700, Matthias Kaehlcke wrote:
> > > LoadPin limits loading of kernel modules, firmware and certain
> > > other files to a 'pinned' file system (typically a read-only
> > > rootfs). To provide more flexibility LoadPin is being extended
> > > to also allow loading these files from trusted dm-verity
> > > devices. For that purpose LoadPin can be provided with a list
> > > of verity root digests that it should consider as trusted.
> > > 
> > > Add a bunch of helpers to allow LoadPin to check whether a DM
> > > device is a trusted verity device. The new functions broadly
> > > fall in two categories: those that need access to verity
> > > internals (like the root digest), and the 'glue' between
> > > LoadPin and verity. The new file dm-verity-loadpin.c contains
> > > the glue functions.
> > > 
> > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > ---
> > > 
> > > Changes in v3:
> > > - none
> > > 
> > > Changes in v2:
> > > - none
> > > 
> > >  drivers/md/Makefile               |  6 +++
> > >  drivers/md/dm-verity-loadpin.c    | 80 +++++++++++++++++++++++++++++++
> > >  drivers/md/dm-verity-target.c     | 33 +++++++++++++
> > >  drivers/md/dm-verity.h            |  4 ++
> > >  include/linux/dm-verity-loadpin.h | 27 +++++++++++
> > >  5 files changed, 150 insertions(+)
> > >  create mode 100644 drivers/md/dm-verity-loadpin.c
> > >  create mode 100644 include/linux/dm-verity-loadpin.h
> > > 
> > > diff --git a/drivers/md/Makefile b/drivers/md/Makefile
> > > index 0454b0885b01..e12cd004d375 100644
> > > --- a/drivers/md/Makefile
> > > +++ b/drivers/md/Makefile
> > > @@ -100,6 +100,12 @@ ifeq ($(CONFIG_IMA),y)
> > >  dm-mod-objs			+= dm-ima.o
> > >  endif
> > >  
> > > +ifeq ($(CONFIG_DM_VERITY),y)
> > > +ifeq ($(CONFIG_SECURITY_LOADPIN),y)
> > > +dm-mod-objs			+= dm-verity-loadpin.o
> > > +endif
> > > +endif
> > > +
> 
> Why are you extending dm-mod-objs?  Why not dm-verity-objs?

Sorry, I missed to address this comment in my earlier reply.

I don't recall why I chose dm-mod-objs initially, agreed that
dm-verity-objs seems a better fit.
