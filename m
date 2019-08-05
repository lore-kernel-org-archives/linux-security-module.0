Return-Path: <SRS0=x/8A=WB=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD32C0650F
	for <linux-security-module@archiver.kernel.org>; Mon,  5 Aug 2019 19:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D132B20B1F
	for <linux-security-module@archiver.kernel.org>; Mon,  5 Aug 2019 19:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565033251;
	bh=MQ8FR72Dyq5oOL55TMoiwVjBxDH1WhMvPfmVW1mvDIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sjFSfkjdHqhf0PyXOKogPhQKNIajJ7o1KSJf7Kiwpi63un6zTZ65YI7YQ2Kz/Tw/P
	 LodFDMWgDvoXovNORUuhHNTZsifyeDzyYztysttXeEmLcvza+TGpp1MVzjYhekZ/8h
	 FAvI0YiwWuQ6EzFSc4Pi3BUsGKsXGDp7a5LrSYcQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730036AbfHET1b (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 5 Aug 2019 15:27:31 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]:35126 "EHLO
        mail-qt1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbfHET1b (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 5 Aug 2019 15:27:31 -0400
Received: by mail-qt1-f182.google.com with SMTP id d23so82155161qto.2
        for <linux-security-module@vger.kernel.org>; Mon, 05 Aug 2019 12:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h1ewf34lHhC/ecib1hsGGIlixnNIzDn15kep7wiXFj4=;
        b=EverIdWBkbzrNKBtVjB/eEfEjEu95MHUnU5wBU8QlutwkoFjuV2QkwB4r0q4CLVmB/
         QQlU8b6AEABq1mqziHyeOka6DTzr7MkEtLGiIKQLVfWMHVHBC7fTL6QM3upaV7R2qXi8
         eV8XC4+v+h8mPIxGVQgYmEnGxAJ/12wtj0KV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h1ewf34lHhC/ecib1hsGGIlixnNIzDn15kep7wiXFj4=;
        b=FFflxWvLGFGGwVvyVPxeqiqBIStufSh/40jmUAPYmUDoHWttw+vyna+SodalyGYZlY
         jfXt26Atz8RL2upd6GkHy7U2e75Nzw5yt+I33Pw4hE9H6jhYJPaa5syNiBIQN4o7/WRf
         2NzeySaFO5oOHQrXiaK26rwgbhcQ1ZCALONbJUveVMzuVF6pb2BGQNVr1bBrstKkYwKS
         S80bnZ1NwThRsXT/STwdM8LGfbbFEgITNAndjltx9jkXGpVU6NqRk+QZYc99udWnbDqv
         zIJo4/z2jEaLTErsQ3A1pHkpqrbaEl2qb3omjNprA1OAR0z/4i7Y4PwGlTAXCyRiWqI8
         ciCw==
X-Gm-Message-State: APjAAAU4Rxx+5CJ88PeVNMgdIkAlRo4nRdBbinRif9z1VKWD+ZE0Zt0z
        tgDUEYO6RU/eOZ0+ZAAY7KpaCU4suWI=
X-Google-Smtp-Source: APXvYqzNnb5aK5bFMZDX/1DWfTBCo+Ag0Lvk6m3WaIGVkXDEPpTNVColK/U4FuU9sJuchpQcA5KhYg==
X-Received: by 2002:ac8:3f55:: with SMTP id w21mr108549934qtk.217.1565033249978;
        Mon, 05 Aug 2019 12:27:29 -0700 (PDT)
Received: from chatter.i7.local (192-0-228-88.cpe.teksavvy.com. [192.0.228.88])
        by smtp.gmail.com with ESMTPSA id j66sm35383650qkf.86.2019.08.05.12.27.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 12:27:29 -0700 (PDT)
Date:   Mon, 5 Aug 2019 15:27:27 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Micah Morton <mortonm@chromium.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] SafeSetID MAINTAINERS file update for v5.3
Message-ID: <20190805192727.GA15470@chatter.i7.local>
References: <CAJ-EccMXEVktpuPS5BwkGqTo++dGcpHAuSUZo7WgJhAzFByz0g@mail.gmail.com>
 <CAHk-=whZzJ8WxAeHcirUghcbeOYxmpCr+XxeS9ngH3df3+=p2Q@mail.gmail.com>
 <CAJ-EccOqmmrf2KPb7Z7NU6bF_4W1XUawLLy=pLekCyFKqusjKQ@mail.gmail.com>
 <CAHk-=wgT7Z3kCbKS9Q1rdA=OVxPL32CdBovX=eHvD2PppWCHpQ@mail.gmail.com>
 <20190805142756.GA4887@chatter.i7.local>
 <CAHk-=wgdiiBVprEVoi8+mpicGnOVNZ4Lb9YUJVskOXahO50sXw@mail.gmail.com>
 <20190805191136.GB4887@chatter.i7.local>
 <CAHk-=wg4xMXMM3EfW=NV6YuScA4zvcvaCAPou3bxegjGy6r-qA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <CAHk-=wg4xMXMM3EfW=NV6YuScA4zvcvaCAPou3bxegjGy6r-qA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Aug 05, 2019 at 12:17:49PM -0700, Linus Torvalds wrote:
>> However, I suspect that getting message-ids for all your pull 
>> requests
>> would significantly complicate your workflow.
>
>Yeah, that would be a noticeable annoyance. If I were to process pull
>requests the way I used to process emailed patches (ie "git am -s" on
>a mailbox) that would be a natural thing to perhaps do, but it's not
>at all how it ends up working. Having to save the pull request email
>to then process it with some script would turn it into a chore.
>
>I think the pr-tracker-bot clearly catches most cases as it is, and
>it's only the occasional "somebody did something odd" that then misses
>an automated response. Not a huge deal. For me it was actually more
>the "I didn't understand why the response didn't happen", not so much
>"I really want to always see responses".

Ok, let me add a fix for Re: at the start -- this won't make things
significantly more expensive, but will catch this particular corner 
case.

Best regards,
-K
