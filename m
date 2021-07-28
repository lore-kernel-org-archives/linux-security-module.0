Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B1FC432BE
	for <linux-security-module@archiver.kernel.org>; Wed, 28 Jul 2021 16:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E88A660F23
	for <linux-security-module@archiver.kernel.org>; Wed, 28 Jul 2021 16:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhG1QVY (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 28 Jul 2021 12:21:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55699 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229542AbhG1QVY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 28 Jul 2021 12:21:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627489282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N2ROMHHpEqp2zK+5JNFUYl00yJlvuqdMk7fyTdniw0s=;
        b=DqoVeZSZSax+9ovLRlO+EoDZEjrk14F/zAoJLfUArJZeFgRZZVvFYJnGvdUSqg70N8yTz3
        EOg+AhvToZ3k+MFqKw4a7VjFDUC6nHBXHJLj/2FIGSdDLG3m68vpthaix2deVANKsfoQoP
        kBFgGWugYX/GO/9o0dNkZMS5UUtnexE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-va_dSvyZOya9q7XQNtBBxA-1; Wed, 28 Jul 2021 12:21:19 -0400
X-MC-Unique: va_dSvyZOya9q7XQNtBBxA-1
Received: by mail-wm1-f71.google.com with SMTP id 25-20020a05600c0219b029024ebb12928cso1114542wmi.3
        for <linux-security-module@vger.kernel.org>; Wed, 28 Jul 2021 09:21:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=N2ROMHHpEqp2zK+5JNFUYl00yJlvuqdMk7fyTdniw0s=;
        b=ujrdWMzTuky0hyArrIM8fc6+iUJ0gqOAkTnHboKd03kgnU6eSbXqZTUTjzMoaO6OXX
         EgAmJlwnBWbcz6zPuMhUclUFZeEMK77ynnEIg2ZmLPqPX+wrw7jlApPU30eH3pDMeB9c
         vHsUfQoiH+JPJ52MrOL490OyT+phRH9ZgdKzor7XWTO1mgDDlqLOTup/wpdTuD7jnXbC
         nxn3x+saGUZxUUogD3HViCFz3jE/wbwIJAlZQhQdt5R36Ed1nOR3p7UKke8o4Ifc0gmd
         HOYzZrrpVxStd36QGw5CEzyenE703fa5dy+1fFGbccB/zHckB9k/aYsp3qYAHKtOv+Wp
         OSNQ==
X-Gm-Message-State: AOAM531YAzbiqqFBbB8Nzjny2Sab0OkT5MwZGLikQTh6uaxzBP19KsKB
        ONJ3MkZCCvjivSfk5orFMUIyjz6TeeuV7WQG+dARH0tfYVj6XC5LrxxJql39vhT+YSOeLdiLcKW
        qeX2Km7kbZohvwe0hJLq1mpKEBfwZm0CkOpqz
X-Received: by 2002:a05:600c:3554:: with SMTP id i20mr546115wmq.68.1627489277962;
        Wed, 28 Jul 2021 09:21:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzNNG5Lq6mIIGQNCRPOWqDLevyCEmtGBKp0QMEeUSpawS0ZtIhPq1GkHZ2XXOgu0mF9uznUBA==
X-Received: by 2002:a05:600c:3554:: with SMTP id i20mr546099wmq.68.1627489277751;
        Wed, 28 Jul 2021 09:21:17 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-97-57.dyn.eolo.it. [146.241.97.57])
        by smtp.gmail.com with ESMTPSA id p3sm6765905wmp.25.2021.07.28.09.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 09:21:17 -0700 (PDT)
Message-ID: <8a07a88f56f25fbc542d7c07cd1a1c04ba7cf860.camel@redhat.com>
Subject: Re: [PATCH RFC 0/9] sk_buff: optimize layout for GRO
From:   Paolo Abeni <pabeni@redhat.com>
To:     Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc:     Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Date:   Wed, 28 Jul 2021 18:21:16 +0200
In-Reply-To: <CAHC9VhSTputyDZMrdU0SmO0gg=P3uskT6ejJkfOwn6bFgaFB3A@mail.gmail.com>
References: <cover.1626879395.git.pabeni@redhat.com>
         <1252ad17-3460-5e6a-8f0d-05d91a1a7b96@schaufler-ca.com>
         <e6200ddd38510216f9f32051ce1acff21fc9c6d0.camel@redhat.com>
         <2e9e57f0-98f9-b64d-fd82-aecef84835c5@schaufler-ca.com>
         <d3fe6ae85b8fad9090288c553f8d248603758506.camel@redhat.com>
         <CAHC9VhT0uuBdmmT1HhMjjQswiJxWuy3cZdRQZ4Zzf-H8n5arLQ@mail.gmail.com>
         <20210724185141.GJ9904@breakpoint.cc>
         <CAHC9VhSsNWSus4xr7erxQs_4GyfJYb7_6a8juisWue6Xc4fVkQ@mail.gmail.com>
         <20210725162528.GK9904@breakpoint.cc>
         <75982e4e-f6b1-ade2-311f-1532254e2764@schaufler-ca.com>
         <20210725225200.GL9904@breakpoint.cc>
         <d0186e8f-41f8-7d4d-5c2c-706bfe3c30cc@schaufler-ca.com>
         <CAHC9VhSTputyDZMrdU0SmO0gg=P3uskT6ejJkfOwn6bFgaFB3A@mail.gmail.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, 2021-07-26 at 22:51 -0400, Paul Moore wrote:
> On Mon, Jul 26, 2021 at 11:13 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > On 7/25/2021 3:52 PM, Florian Westphal wrote:
> > > Casey Schaufler <casey@schaufler-ca.com> wrote:
> > > > RedHat and android use SELinux and will want this. Ubuntu doesn't
> > > > yet, but netfilter in in the AppArmor task list. Tizen definitely
> > > > uses it with Smack. The notion that security modules are only used
> > > > in fringe cases is antiquated.
> > > I was not talking about LSM in general, I was referring to the
> > > extended info that Paul mentioned.
> > > 
> > > If thats indeed going to be used on every distro then skb extensions
> > > are not suitable for this, it would result in extr akmalloc for every
> > > skb.
> > 
> > I am explicitly talking about the use of secmarks. All my
> > references are uses of secmarks.
> 
> I'm talking about a void* which would contain LSM specific data; as I
> said earlier, think of inodes.  This LSM specific data would include
> the existing secmark data as well as network peer security information
> which would finally (!!!) allow us to handle forwarded traffic and
> enable a number of other fixes and performance improvements.
> 
> (The details are a bit beyond this discussion but it basically
> revolves around us not having to investigate the import the packet
> headers every time we want to determine the network peer security
> attributes, we could store the resolved LSM information in the
> sk_buff.security blob.)

I've investigated the feasibility of extending the secmark field to
long/void*. I think that performance wise it should be doable on top of
this series: the amount of allocated memory for sk_buff will not
change, nor the amount of memory memseted at skb initialization time.

I stumbled upon some uAPIs issues, as CT/nft expose a secmark related
field via uAPI, changing that size without breaking esisting user-space 
looks hard to me.

Additionally, even patch 7/9 is problematic, as there are some in
kernel users accessing and using the inner_ field regardless skb-
>encapsulation. That works while inner_* field are always
initializared/zeored, but will break with the mentioned patch. The fix
is doable, but large and complex. 

To keep the scope of this series sane, I'll drop in the next iteration
all the problematic patches - that is: no sk_buff layout change at all.

If there is interest for such thing, it could still be added
incrementally.

Cheers,

Paolo



