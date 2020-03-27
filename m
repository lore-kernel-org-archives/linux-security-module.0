Return-Path: <SRS0=iZqy=5M=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5706FC2D0ED
	for <linux-security-module@archiver.kernel.org>; Fri, 27 Mar 2020 15:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D2CA2074F
	for <linux-security-module@archiver.kernel.org>; Fri, 27 Mar 2020 15:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hO4sdxNx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbgC0PGn (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 27 Mar 2020 11:06:43 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38454 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727549AbgC0PGm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 27 Mar 2020 11:06:42 -0400
Received: by mail-wm1-f68.google.com with SMTP id f6so6108851wmj.3
        for <linux-security-module@vger.kernel.org>; Fri, 27 Mar 2020 08:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=pr0qD0iPXCEmGNYn73fmX69Dspd/3/go52tlDvpiG+I=;
        b=hO4sdxNxvULwr69BbYBiyiZhy52w5Rt88jCkrSsCrpHZlgE+artcZrY4Hh2ptIs6D3
         DzJNdRCbZuPdmL/2YArjpOMh6REjq0xJK0LdLZk9+aTlSheU3verxJCPPZvs7uBSn3+Q
         JIGInARCeIT1eNOGQmVGWgunmy6cxgGwcDp+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=pr0qD0iPXCEmGNYn73fmX69Dspd/3/go52tlDvpiG+I=;
        b=Wwgy6RKDDfMMScpjj2MUj3JZTz3NYlg8Wt8SX48ZuH8nDo32JwI3GUp2Fe00PH39Yw
         pPSHFAuN4DyKISoHSJrBm8lxhV9ctw4eTpXQXybAKEWBDZ40YrulYVxoyiwCn3CSBA6P
         Tr0B9B0CeD0NYkcYXRALlAjaU/jzVq9cIGVnRLbtBzzTjhIJJ0vVF6pzZA1dyqGG3EAy
         wMEKqlmeenvPOV7VXAUCDo3orFCrjwloJc5cq2NtvHclbBr+pTmrgfQO/VuUwtGgX66K
         ByCEkoi8q2udg8/Zt8P4spq9sU/uPKdHLjLvAMVzjqtY97Db4S6NHn381oVA4tGjnPYq
         CrvA==
X-Gm-Message-State: ANhLgQ3Hejfq5Pgn7c5M5CafNok7mvael1bTrPE7YtFeMw1cI8+7mvzM
        s3MWETMo7asQ0cN/n0ypQfp5Bw==
X-Google-Smtp-Source: ADFU+vttbTEMoPK04x5Y+InaWRPyOJAislXquQ5dm7z8g2RLd7ecoYpHxc6ZBWjAUh9hORUzjzQMJw==
X-Received: by 2002:a1c:8108:: with SMTP id c8mr5764675wmd.50.1585321600541;
        Fri, 27 Mar 2020 08:06:40 -0700 (PDT)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id m5sm8001072wmg.13.2020.03.27.08.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 08:06:39 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Fri, 27 Mar 2020 16:06:37 +0100
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
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
Subject: Re: [PATCH bpf-next v7 4/8] bpf: lsm: Implement attach, detach and
 execution
Message-ID: <20200327150637.GA23032@chromium.org>
References: <20200326142823.26277-1-kpsingh@chromium.org>
 <20200326142823.26277-5-kpsingh@chromium.org>
 <20200327031256.vhk2luomxgex3ui4@ast-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200327031256.vhk2luomxgex3ui4@ast-mbp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 26-Mär 20:12, Alexei Starovoitov wrote:
> On Thu, Mar 26, 2020 at 03:28:19PM +0100, KP Singh wrote:
> >  
> >  	if (arg == nr_args) {
> > -		if (prog->expected_attach_type == BPF_TRACE_FEXIT) {
> > +		/* BPF_LSM_MAC programs only have int and void functions they
> > +		 * can be attached to. When they are attached to a void function
> > +		 * they result in the creation of an FEXIT trampoline and when
> > +		 * to a function that returns an int, a MODIFY_RETURN
> > +		 * trampoline.
> > +		 */
> > +		if (prog->expected_attach_type == BPF_TRACE_FEXIT ||
> > +		    prog->expected_attach_type == BPF_LSM_MAC) {
> >  			if (!t)
> >  				return true;
> >  			t = btf_type_by_id(btf, t->type);
> 
> Could you add a comment here that though BPF_MODIFY_RETURN-like check
> if (ret_type != 'int') return -EINVAL;
> is _not_ done here. It is still safe, since LSM hooks have only
> void and int return types.

Good idea, I reworded the comment to make this explicit and moved
the comment to inside the if condition.

> 
> > +	case BPF_LSM_MAC:
> > +		if (!prog->aux->attach_func_proto->type)
> > +			/* The function returns void, we cannot modify its
> > +			 * return value.
> > +			 */
> > +			return BPF_TRAMP_FEXIT;
> > +		else
> > +			return BPF_TRAMP_MODIFY_RETURN;
> 
> I was thinking whether it would help performance significantly enough
> if we add a flavor of BPF_TRAMP_FEXIT that doesn't have
> BPF_TRAMP_F_CALL_ORIG.

Agreed.

> That will save the cost of nop call, but I guess indirect call due
> to lsm infra is slow enough, so this extra few cycles won't be noticeable.
> So I'm fine with it as-is. When lsm hooks will get rid of indirect call
> we can optimize it further.

Also agreed, that's the next step. :)

- KP
