Return-Path: <SRS0=iZqy=5M=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4C7C43331
	for <linux-security-module@archiver.kernel.org>; Fri, 27 Mar 2020 12:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 063A42083E
	for <linux-security-module@archiver.kernel.org>; Fri, 27 Mar 2020 12:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A8KkiHIx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbgC0MlV (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 27 Mar 2020 08:41:21 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36629 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbgC0MlV (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 27 Mar 2020 08:41:21 -0400
Received: by mail-wm1-f65.google.com with SMTP id g62so12188300wme.1
        for <linux-security-module@vger.kernel.org>; Fri, 27 Mar 2020 05:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=HnVDDDsqTX8MxfeqmFfp9Tn3o5KLZ/pppfNiIQGaWUU=;
        b=A8KkiHIxW5mfnjqo0cLZcZh8IfHn7HLznrdYV7aPqFFm15SFa0UTabygnJhHemRtBH
         s7dZz7uQCAPVqinpRuTEDU1qFyzXTRK/c9ia70ebmPLz2klt3qGR7SxPqroVkxADCJ4k
         VEnM1FoM+w6QnEqnBfT5qMalW89SrTK1R6AuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=HnVDDDsqTX8MxfeqmFfp9Tn3o5KLZ/pppfNiIQGaWUU=;
        b=BOHZJXsFgQKjl3Pwoxl3j5aTWPUxOT6XGxMmNyX121B9lym5uLGNxd3bxBHMi3CNPF
         BGPVDT9mRZ4KPmuVimixheO56UGm3fAkF3mOzLEj3iyMejVy3hRdxr17MW6LI1hUIC1C
         VShsWeAyTCQCZcvEJyWPltxONnJ3nApnIr5TlbnlYRAWAh+4SKD1BJvjFuIk7Cex4DM9
         vGbYQEcyd91Lcid1ABsf0C5yV4mAlh1s2c9wFGK+udO517cB3ocsezPfEULTNQBuSrqd
         Fnj0A24zm8Rbjgx1s3PIMyRpMPbF6lxoPBPnrKF5e2IcuJ0wUedVbe0XFXj9q3wuqH/B
         hYxA==
X-Gm-Message-State: ANhLgQ19uAfcLR/8qzyrvtcuEIoBToYaHhp3JRvDbXJxkmC3QqN7A5dG
        6fdIsRwraO+Ec9G9yv0dyomlh24J6YQ=
X-Google-Smtp-Source: ADFU+vvnFgmbe+QdpMxmXQZgR5mtej1ElSkahIq/1zjkyNYq4sg7qO361XxdE8+2Zp5RWVxPX5yKWQ==
X-Received: by 2002:a1c:9a8d:: with SMTP id c135mr5381550wme.183.1585312878062;
        Fri, 27 Mar 2020 05:41:18 -0700 (PDT)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id u11sm8075975wrt.29.2020.03.27.05.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 05:41:17 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Fri, 27 Mar 2020 13:41:15 +0100
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH bpf-next v7 4/8] bpf: lsm: Implement attach, detach and
 execution
Message-ID: <20200327124115.GA8318@chromium.org>
References: <20200326142823.26277-1-kpsingh@chromium.org>
 <20200326142823.26277-5-kpsingh@chromium.org>
 <alpine.LRH.2.21.2003271119420.17089@namei.org>
 <2241c806-65c9-68f5-f822-9a245ecf7ba0@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2241c806-65c9-68f5-f822-9a245ecf7ba0@tycho.nsa.gov>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 27-Mär 08:27, Stephen Smalley wrote:
> On 3/26/20 8:24 PM, James Morris wrote:
> > On Thu, 26 Mar 2020, KP Singh wrote:
> > 
> > > +int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
> > > +			const struct bpf_prog *prog)
> > > +{
> > > +	/* Only CAP_MAC_ADMIN users are allowed to make changes to LSM hooks
> > > +	 */
> > > +	if (!capable(CAP_MAC_ADMIN))
> > > +		return -EPERM;
> > > +
> > 
> > Stephen, can you confirm that your concerns around this are resolved
> > (IIRC, by SELinux implementing a bpf_prog callback) ?
> 
> I guess the only residual concern I have is that CAP_MAC_ADMIN means
> something different to SELinux (ability to get/set file security contexts
> unknown to the currently loaded policy), so leaving the CAP_MAC_ADMIN check
> here (versus calling a new security hook here and checking CAP_MAC_ADMIN in
> the implementation of that hook for the modules that want that) conflates
> two very different things.  Prior to this patch, there are no users of
> CAP_MAC_ADMIN outside of individual security modules; it is only checked in
> module-specific logic within apparmor, safesetid, selinux, and smack, so the
> meaning was module-specific.

As we had discussed, We do have a security hook as well:

https://lore.kernel.org/bpf/20200324180652.GA11855@chromium.org/

The bpf_prog hook which can check for BPF_PROG_TYPE_LSM and implement
module specific logic for LSM programs. I thougt that was okay?

Kees was in favor of keeping the CAP_MAC_ADMIN check here:

https://lore.kernel.org/bpf/202003241133.16C02BE5B@keescook

If you feel strongly and Kees agrees, we can remove the CAP_MAC_ADMIN
check here, but given that we already have a security hook that meets
the requirements, we probably don't need another one.

- KP


> 
> 
> 
> 
