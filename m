Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74685EB64DC
	for <linux-security-module@archiver.kernel.org>; Fri, 21 Jul 2023 15:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjGUPf7 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 21 Jul 2023 11:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbjGUPf4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 21 Jul 2023 11:35:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA23D30E3
        for <linux-security-module@vger.kernel.org>; Fri, 21 Jul 2023 08:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689953707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=juDB50ep5EziMZB0FQ61LdKKQ78ZVaC7nofAg3guVPo=;
        b=aH1hFLQV3yYUZF8rRKcBcbq6AJtsG+lwqKDuY8NvKElQBmiFRbN0+iS6IaUxLeR6ChUVcE
        x+76C8Fa6oMy4TvW/s4Uvs4dsEL4UOvESjtHXpDdGhEZQCCVcI9KP9GvO/EHx4sEd8+N8e
        pcYPfTpCt/UtX62uZiXMmnLmXNd/cbQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-1CUPjU1wMkeFUjssRPr3OQ-1; Fri, 21 Jul 2023 11:35:03 -0400
X-MC-Unique: 1CUPjU1wMkeFUjssRPr3OQ-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-402fa256023so5209861cf.0
        for <linux-security-module@vger.kernel.org>; Fri, 21 Jul 2023 08:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689953703; x=1690558503;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=juDB50ep5EziMZB0FQ61LdKKQ78ZVaC7nofAg3guVPo=;
        b=NmDNOkysnwrG/TYeypaxuWjyPKMs908oahKHVDFJRBmSZIV+5V7inhbay6uiZMzonf
         os1OJy7nyByvMVzRxr+si/ZZwKh03AItRfaoGdAZxRiVVD8Ts0mcs+Y7cwn6bdWINwzE
         1bsp4CR64LrTJEsGPFg/+MI1Y9a+VxM9/dcPPKB8QgO1MRbFbGgEbOZP+5pn2azKby/q
         IbJCrlWfb3+SrU4FpgN0/YOP4vGwNSMv5ctaBoLoGjQDkmLtscPnmb0JA6nxfO1P8lLg
         CYM5UAZ7f5YoiEb5ChCKPT1jZct1VrVfvDP0Ciq51jxXkTrpKCPNUJN4OQh6gcA967k/
         om3w==
X-Gm-Message-State: ABy/qLZULMzJ5s9sQc4csUMuO1MBtWMX56EP8coFjTFLRKWtWrnJzp9N
        wh9/DfmZEYOF8REGR3VhhUua69fny8X0VKmqxWH78efBVawpPEoV+Mh32CH1oMOi/S3RTXbPsGJ
        xDIA5YfmsQsi/hi/q/DGjIpzERBsmNEyo7HTDMU9cWpaX
X-Received: by 2002:a05:622a:16:b0:403:59f8:25d9 with SMTP id x22-20020a05622a001600b0040359f825d9mr2941251qtw.2.1689953702996;
        Fri, 21 Jul 2023 08:35:02 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFtmwbAmIm72vygzZW8jvNGyhiYlMdjFzJTDlqFurwIRYLcPtf6Ix91swrXK0VKRdFtao2bUg==
X-Received: by 2002:a05:622a:16:b0:403:59f8:25d9 with SMTP id x22-20020a05622a001600b0040359f825d9mr2941221qtw.2.1689953702672;
        Fri, 21 Jul 2023 08:35:02 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-170.dyn.eolo.it. [146.241.226.170])
        by smtp.gmail.com with ESMTPSA id r5-20020ac87945000000b003eabcc29132sm1295516qtt.29.2023.07.21.08.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 08:35:02 -0700 (PDT)
Message-ID: <679840421f2e7794bb69962b97e0cee1a4e0f0f6.camel@redhat.com>
Subject: Re: [RFC PATCH] selinux: introduce and use ad_init_net*() helpers
From:   Paolo Abeni <pabeni@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-security-module@vger.kernel.org
Date:   Fri, 21 Jul 2023 17:34:59 +0200
In-Reply-To: <73a810980a8452f0cb98d25698c4ae83285b7393.1689604030.git.pabeni@redhat.com>
References: <73a810980a8452f0cb98d25698c4ae83285b7393.1689604030.git.pabeni@redhat.com>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi all,

On Mon, 2023-07-17 at 16:27 +0200, Paolo Abeni wrote:
> The only
> remaining perf-related pain-point I see is the indirect call at the
> security_ level, and tackling it looks much more difficult... :(

I spent a little more time on this latest topic. AFAICS recently such
overhead has increased due to the bpf lsm introduction. My
understanding is that a major LSM and BPF LSM simultaneously enabled is
a common usage scenario. That means 2 indirect calls + 2 untrain trails
and 3 additional cache-lines used per hook.

Under the assumption than having multiple major lsms enabled
concurrently is less common, I hacked some (not exactly spectacularly
beautiful) code to avoid the above. Basically, after initialization,
for a limited number of hooks, it checks if only the default major lsm
and eventually the bpf lsm are registered and if so, converts such
hooks to static call[s], using static branches.

The idea would be to keep the above infra usage restricted to the most
performance-relevant hooks (e.g. one-off initialization or
configuration  are not relevant from that perspective). For obvious
reasons I started from a few of network related hooks ;)

As said the code could be more nice: there is some quite heavy macro
usage and some duplication I was not able to avoid). On the flip side
it shows quite measurable benefit when enabled, 0 impact when disabled,
and it's available to all major LSM, except tomoyo (but even the latter
could be accommodated with some effort).

If there is some shared interest for the above I can share the current
status and try to cleanup the code.

Any feedback more then appreciated!

Cheers,

Paolo

