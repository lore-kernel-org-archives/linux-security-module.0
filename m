Return-Path: <SRS0=MM4E=37=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8ADDC3B188
	for <linux-security-module@archiver.kernel.org>; Tue, 11 Feb 2020 12:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2147206DB
	for <linux-security-module@archiver.kernel.org>; Tue, 11 Feb 2020 12:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kze4zHOP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgBKMox (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 11 Feb 2020 07:44:53 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33180 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbgBKMow (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 11 Feb 2020 07:44:52 -0500
Received: by mail-wm1-f68.google.com with SMTP id m10so2197080wmc.0
        for <linux-security-module@vger.kernel.org>; Tue, 11 Feb 2020 04:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iMv6R54aFlLhM7hktRN4UrtHbbiQS0KKmyFbwzLRwQE=;
        b=kze4zHOP05trixg7lfqDQ0EfT802h2tJrCV1oUaIaKhzSF/a33//7hXB84H2cQAfUB
         k4YAmYXqB4gAUf1sVlb/QngOGTY7gru46hU4WLj7OOA4AymxgwwLspbboQy325BKDIfH
         0SQzwVtL6cDddo/cEiOwJDrk8iqBZKyNTh/X4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iMv6R54aFlLhM7hktRN4UrtHbbiQS0KKmyFbwzLRwQE=;
        b=Wq2WGccBjYdwOpGGn0lr8Odgu7Kg5N/XvNJ8kgZp+OHJKGbggBnjrMHxm3rgwbMnyp
         MKd4jThOHz+7n+2cXuUenSbhjN/CjvwJ7+qGJ2MYf4hxqvM9P/hKAueOnc/5wZnOePvJ
         SblLP+Y0cOK20RZXDtsfshC5KEZIXi6pWWzG11Ob1jnjOwwTmSVsICZzt5ypMCEquSfo
         cCa2QyFlrmUxIHpSCUiMenJDhPO4nsQurkRfE3jouwbKIZYrlK3XA9EA32zg+9jA/7zL
         uZZMUga5S5oiUiUXfxqyZxK58g1ekNhv4yXTJ2SiuQKiKhWKCFF2ZNXa1kVub7vzvTS2
         dr5A==
X-Gm-Message-State: APjAAAUhsxBVlzZxqdNUmVpyO4EuHjrbwEsCN9xZNy/KZ+cuBRai9vOu
        5O7Mx3yjzJZ0dqZXCOUaYRQEOQ==
X-Google-Smtp-Source: APXvYqwU63IGIZUgRdotZLcl4cgyRkgh3ytCON4EAV4iW5e6Kkfs5FxGUFw9Rr6Yqz9lcKK3SiSx2w==
X-Received: by 2002:a05:600c:d6:: with SMTP id u22mr5530222wmm.77.1581425090945;
        Tue, 11 Feb 2020 04:44:50 -0800 (PST)
Received: from google.com ([2a00:79e0:42:204:8a21:ba0c:bb42:75ec])
        by smtp.gmail.com with ESMTPSA id i204sm3780608wma.44.2020.02.11.04.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 04:44:50 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Tue, 11 Feb 2020 13:44:48 +0100
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     KP Singh <kpsingh@chromium.org>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Thomas Garnier <thgarnie@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: Re: [PATCH bpf-next v3 03/10] bpf: lsm: Introduce types for eBPF
 based LSM
Message-ID: <20200211124448.GB96694@google.com>
References: <20200123152440.28956-1-kpsingh@chromium.org>
 <20200123152440.28956-4-kpsingh@chromium.org>
 <20200210235811.pbzvlok6rin7lctd@ast-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210235811.pbzvlok6rin7lctd@ast-mbp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 10-Feb 15:58, Alexei Starovoitov wrote:
> On Thu, Jan 23, 2020 at 07:24:33AM -0800, KP Singh wrote:
> > +
> > +static const struct bpf_func_proto *get_bpf_func_proto(
> > +	enum bpf_func_id func_id, const struct bpf_prog *prog)
> > +{
> > +	switch (func_id) {
> > +	case BPF_FUNC_map_lookup_elem:
> > +		return &bpf_map_lookup_elem_proto;
> > +	case BPF_FUNC_get_current_pid_tgid:
> > +		return &bpf_get_current_pid_tgid_proto;
> > +	default:
> > +		return NULL;
> > +	}
> > +}
> > +
> > +const struct bpf_verifier_ops lsm_verifier_ops = {
> > +	.get_func_proto = get_bpf_func_proto,
> > +};
> 
> Why artificially limit it like this?
> It will cause a lot of churn in the future. Like allowing map update and
> delete, in addition to lookup, will be an obvious next step.
> I think allowing tracing_func_proto() from the start is cleaner.

Sure, I will replace it to use tracing_func_proto in the next
revision.

- KP

