Return-Path: <SRS0=jUwH=5J=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A6CC41621
	for <linux-security-module@archiver.kernel.org>; Tue, 24 Mar 2020 14:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3594520774
	for <linux-security-module@archiver.kernel.org>; Tue, 24 Mar 2020 14:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ACG7Xe7Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbgCXOwA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 24 Mar 2020 10:52:00 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50430 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728216AbgCXOwA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 24 Mar 2020 10:52:00 -0400
Received: by mail-wm1-f65.google.com with SMTP id d198so3521648wmd.0
        for <linux-security-module@vger.kernel.org>; Tue, 24 Mar 2020 07:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7e4KDLTmWgu/QQJEIVFCVN/w7UIWM4C7k1L+cgO3etw=;
        b=ACG7Xe7QJOeqLq9nxQgo/2Hmd7TANG6OyUfm9KlhXXEDFRJCJA5UGjhkxMgV5E3HlJ
         lcKpAHAeeWRt9+4yASeJo8ob176WIaXSIzV0Hv0Ni0SNxelTVnxKe57ObyCHBbqq5Pmr
         Kofe0bXI1xmqL8NJfeXLDIyJrJ40lD8Aicbd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7e4KDLTmWgu/QQJEIVFCVN/w7UIWM4C7k1L+cgO3etw=;
        b=YIFEMBSShsB926dRNsjZRiHXU9YfFX2FnsdIoYm+s0jiCwWfjdIkgToAbQeBxmFp+J
         TWZSmJq3ApmDQ7BHf0FtvHyX1XBAd2+Jry2sE//QOMOyK8QZaZMc3wkEZZhJQobz5iWw
         o/7lyL7k6DAh9gI6Iyq60remAnhauKrmFZUa22iJZ/OpxyPR8s5U0F/TGbdXRP4tDkS+
         4002+WvvrTtA2DYYL/OA3bhV7G+aOA0UbSJ470S5iBcayregYqww3Ne8Bq70ELYTROXx
         lo16S9gH9ZhqyNY5Lft/BO/vgfdO0HNfmkq0raEfxqpej8ZGkshryARL95/SYDEklfwJ
         VQNw==
X-Gm-Message-State: ANhLgQ0mhtuW4hvQTtBhiQWXPprva64q93PW+R8JPzLaitgD1Lgyf2Ct
        YAL80/5Bqtq+vLX9Abv9P1xtyg==
X-Google-Smtp-Source: ADFU+vum9D07o2DYTLiqEmlmU481OTm0K/ZD8B4oN/2zUqHNg6zKveeWlRzSLOOalwgn2Y/BsRssRA==
X-Received: by 2002:a1c:26c4:: with SMTP id m187mr5927248wmm.43.1585061518182;
        Tue, 24 Mar 2020 07:51:58 -0700 (PDT)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id t5sm22977367wrr.93.2020.03.24.07.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 07:51:57 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Tue, 24 Mar 2020 15:51:55 +0100
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH bpf-next v5 5/7] bpf: lsm: Initialize the BPF LSM hooks
Message-ID: <20200324145155.GB2685@chromium.org>
References: <20200323164415.12943-1-kpsingh@chromium.org>
 <20200323164415.12943-6-kpsingh@chromium.org>
 <6d45de0d-c59d-4ca7-fcc5-3965a48b5997@schaufler-ca.com>
 <20200324015217.GA28487@chromium.org>
 <CAEjxPJ7LCZYDXN1rYMBA2rko0zbTp0UU0THx0bhsAnv0Eg4Ptg@mail.gmail.com>
 <20200324144214.GA1040@chromium.org>
 <CAEjxPJ7GDA2PvYkoFhnE7gjr_n=ADCjy3XOwacfELY7evVJtJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEjxPJ7GDA2PvYkoFhnE7gjr_n=ADCjy3XOwacfELY7evVJtJw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 24-Mär 10:51, Stephen Smalley wrote:
> On Tue, Mar 24, 2020 at 10:42 AM KP Singh <kpsingh@chromium.org> wrote:
> >
> > On 24-Mär 10:37, Stephen Smalley wrote:
> > > On Mon, Mar 23, 2020 at 9:52 PM KP Singh <kpsingh@chromium.org> wrote:
> > > >
> > > > On 23-Mär 18:13, Casey Schaufler wrote:
> > > > > Have you given up on the "BPF must be last" requirement?
> > > >
> > > > Yes, we dropped it for as the BPF programs require CAP_SYS_ADMIN
> > > > anwyays so the position ~shouldn't~ matter. (based on some of the
> > > > discussions we had on the BPF_MODIFY_RETURN patches).
> > > >
> > > > However, This can be added later (in a separate patch) if really
> > > > deemed necessary.
> > >
> > > It matters for SELinux, as I previously explained.  A process that has
> > > CAP_SYS_ADMIN is not assumed to be able to circumvent MAC policy.
> > > And executing prior to SELinux allows the bpf program to access and
> > > potentially leak to userspace information that wouldn't be visible to
> > > the
> > > process itself. However, I thought you were handling the order issue
> > > by putting it last in the list of lsms?
> >
> > We can still do that if it does not work for SELinux.
> >
> > Would it be okay to add bpf as LSM_ORDER_LAST?
> >
> > LSMs like Landlock can then add LSM_ORDER_UNPRIVILEGED to even end up
> > after bpf?
> 
> I guess the question is whether we need an explicit LSM_ORDER_LAST or
> can just handle it via the default
> values for the lsm= parameter, where you are already placing bpf last
> IIUC?  If someone can mess with the kernel boot
> parameters, they already have options to mess with SELinux, so it is no worse...

Yeah, we do add BPF as the last LSM in the default list. So, I will
avoid adding LSM_ORDER_LAST for now.

- KP
