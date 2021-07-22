Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203C5C63793
	for <linux-security-module@archiver.kernel.org>; Thu, 22 Jul 2021 16:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC4146052B
	for <linux-security-module@archiver.kernel.org>; Thu, 22 Jul 2021 16:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234630AbhGVQSb (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 22 Jul 2021 12:18:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58415 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234969AbhGVQRH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 22 Jul 2021 12:17:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626973056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6OaaFBDYasoiIPsVBT+KwuldBimPeSqiViQl4LNJysI=;
        b=M3FbyFoIWe3r5fecjdURBhoiZQyICgZ4BzZb39fY30ozyVDz4aFKBIUq9NWOlSlEWVlW4A
        FG6LnYK6HWQey4ID7nNZmoKCNMXUn3qRLrrT4A8Su1M7uWs5ctvdTmLOnZxBtyN6KDcvek
        OJaTZgv2KTsdn+5F1MRVWft4LvImaqg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-550-Io1pqGLDPyK1E0-YubTUAA-1; Thu, 22 Jul 2021 12:57:35 -0400
X-MC-Unique: Io1pqGLDPyK1E0-YubTUAA-1
Received: by mail-wm1-f69.google.com with SMTP id 145-20020a1c04970000b0290242a8f4cf9cso835wme.5
        for <linux-security-module@vger.kernel.org>; Thu, 22 Jul 2021 09:57:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=6OaaFBDYasoiIPsVBT+KwuldBimPeSqiViQl4LNJysI=;
        b=feZ83jEUwNl6tlSJ5DqAfvYrHiAzDaudid8kkraw0+AoWKgA2f7CgWpLDCfwh93RMF
         JNLZZuwCDBqixngSbWSGVeteglGWjW5bEi51xK7A0KTdMX0cKHozIqqu2l+ZillVBTh/
         +3zpnnNLPJoP7ysyQs0cEGoFTOQqPt9ff4XmI/KeKziBfU47y65Vf5SssoN3Kv2mmQxz
         AR0umiXtPgxjRFNh0JLJfUtLa+Taq/uAj0oyubeNqNUkjCw7Ch+Db/vRZivfSzGDqKp7
         o3R55/oCjpNZpJQ8+zvEDrenOHHTgb5bgQTh/ggf5u3ZYbSeu1eXcR4nkBqgU10Dad2S
         ATDQ==
X-Gm-Message-State: AOAM530J74lZh/kq8C98lyHWrcvVgnDi4CD1LzeQN8GK3dPQ6hoYeI/C
        Yjtjhc414ai6KdY5sq/w1D2zAyBXdsX3mnRPklaye8Jq2ZovdXOi2aLatMNyVUsNFZSs3Nzgx/z
        mlfPQIzvnUoiqdl5y4YOC5wuTeOF1HckU6Zbq
X-Received: by 2002:a05:600c:5127:: with SMTP id o39mr531901wms.124.1626973053900;
        Thu, 22 Jul 2021 09:57:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwybnGn59m8JlANQT/urK3RIFampLl/89DIBgFCvmmTFjroSiIfifkkhXt74zF++i13ezOKOw==
X-Received: by 2002:a05:600c:5127:: with SMTP id o39mr531880wms.124.1626973053608;
        Thu, 22 Jul 2021 09:57:33 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-97-57.dyn.eolo.it. [146.241.97.57])
        by smtp.gmail.com with ESMTPSA id e8sm9178264wrc.6.2021.07.22.09.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 09:57:33 -0700 (PDT)
Message-ID: <d3fe6ae85b8fad9090288c553f8d248603758506.camel@redhat.com>
Subject: Re: [PATCH RFC 0/9] sk_buff: optimize layout for GRO
From:   Paolo Abeni <pabeni@redhat.com>
To:     Casey Schaufler <casey@schaufler-ca.com>, netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Florian Westphal <fw@strlen.de>,
        Eric Dumazet <edumazet@google.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Date:   Thu, 22 Jul 2021 18:57:31 +0200
In-Reply-To: <2e9e57f0-98f9-b64d-fd82-aecef84835c5@schaufler-ca.com>
References: <cover.1626879395.git.pabeni@redhat.com>
         <1252ad17-3460-5e6a-8f0d-05d91a1a7b96@schaufler-ca.com>
         <e6200ddd38510216f9f32051ce1acff21fc9c6d0.camel@redhat.com>
         <2e9e57f0-98f9-b64d-fd82-aecef84835c5@schaufler-ca.com>
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

On Thu, 2021-07-22 at 09:04 -0700, Casey Schaufler wrote:
> On 7/22/2021 12:10 AM, Paolo Abeni wrote:
> > On Wed, 2021-07-21 at 11:15 -0700, Casey Schaufler wrote:
> > > On 7/21/2021 9:44 AM, Paolo Abeni wrote:
> > > > This is a very early draft - in a different world would be
> > > > replaced by hallway discussion at in-person conference - aimed at
> > > > outlining some ideas and collect feedback on the overall outlook.
> > > > There are still bugs to be fixed, more test and benchmark need, etc.
> > > > 
> > > > There are 3 main goals:
> > > > - [try to] avoid the overhead for uncommon conditions at GRO time
> > > >   (patches 1-4)
> > > > - enable backpressure for the veth GRO path (patches 5-6)
> > > > - reduce the number of cacheline used by the sk_buff lifecycle
> > > >   from 4 to 3, at least in some common scenarios (patches 1,7-9).
> > > >   The idea here is avoid the initialization of some fields and
> > > >   control their validity with a bitmask, as presented by at least
> > > >   Florian and Jesper in the past.
> > > If I understand correctly, you're creating an optimized case
> > > which excludes ct, secmark, vlan and UDP tunnel. Is this correct,
> > > and if so, why those particular fields? What impact will this have
> > > in the non-optimal (with any of the excluded fields) case?
> > Thank you for the feedback.
> 
> You're most welcome. You did request comments.
> 
> > There are 2 different relevant points:
> > 
> > - the GRO stage.
> >   packets carring any of CT, dst, sk or skb_ext will do 2 additional
> > conditionals per gro_receive WRT the current code. My understanding is
> > that having any of such field set at GRO receive time is quite
> > exceptional for real nic. All others packet will do 4 or 5 less
> > conditionals, and will traverse a little less code.
> > 
> > - sk_buff lifecycle
> >   * packets carrying vlan and UDP will not see any differences: sk_buff
> > lifecycle will stil use 4 cachelines, as currently does, and no
> > additional conditional is introduced.
> >   * packets carring nfct or secmark will see an additional conditional
> > every time such field is accessed. The number of cacheline used will
> > still be 4, as in the current code. My understanding is that when such
> > access happens, there is already a relevant amount of "additional" code
> > to be executed, the conditional overhead should not be measurable.
> 
> I'm responsible for some of that "additonal" code. If the secmark
> is considered to be outside the performance critical data there are
> changes I would like to make that will substantially improve the
> performance of that "additional" code that would include a u64
> secmark. If use of a secmark is considered indicative of a "slow"
> path, the rationale for restricting it to u32, that it might impact
> the "usual" case performance, seems specious. I can't say that I
> understand all the nuances and implications involved. It does
> appear that the changes you've suggested could negate the classic
> argument that requires the u32 secmark.

I see now I did not reply to one of you questions - why I picked-up
 vlan, tunnel secmark fields to move them at sk_buff tail. 

Tow main drivers on my side:
- there are use cases/deployments that do not use them.
- moving them around was doable in term of required changes.

There are no "slow-path" implications on my side. For example, vlan_*
fields are very critical performance wise, if the traffic is tagged.
But surely there are busy servers not using tagget traffic which will
enjoy the reduced cachelines footprint, and this changeset will not
impact negatively the first case.

WRT to the vlan example, secmark and nfct require an extra conditional
to fetch the data. My understanding is that such additional conditional
is not measurable performance-wise when benchmarking the security
modules (or conntrack) because they have to do much more intersting
things after fetching a few bytes from an already hot cacheline.

Not sure if the above somehow clarify my statements.

As for expanding secmark to 64 bits, I guess that could be an
interesting follow-up discussion :)

Cheers,

Paolo

