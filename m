Return-Path: <SRS0=jUwH=5J=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE96C54EEB
	for <linux-security-module@archiver.kernel.org>; Tue, 24 Mar 2020 16:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9409B20789
	for <linux-security-module@archiver.kernel.org>; Tue, 24 Mar 2020 16:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KYQKDx8D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbgCXQGY (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:06:24 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51440 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727730AbgCXQGY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 24 Mar 2020 12:06:24 -0400
Received: by mail-wm1-f68.google.com with SMTP id c187so3826406wme.1
        for <linux-security-module@vger.kernel.org>; Tue, 24 Mar 2020 09:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=1N/kkCsXiaUZJR6Cb6g+LjBhvjr5lmjI4mokCR0tVqI=;
        b=KYQKDx8DyzUAnuq2yoc8TeWYg6u2d9G1EnJpysHS23i/nJtDUTJ1EGMDA+yLtc+3Ne
         ttb5axfZ4dXbmiVTOnc+IEEDAk9zxj2cXn99YKJpGZc93ZuBmxvzsUq8qH6oTtP5O3Yq
         fGk1pmxtTvy5X+ioEB3lY2DmwDertoipWkA38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1N/kkCsXiaUZJR6Cb6g+LjBhvjr5lmjI4mokCR0tVqI=;
        b=JQ/+2HoOLzTRYgZS6OOFlfphcqvIdScGcUYbn5MhzLFC6jBgE2CM9p+L+4Oz1PJwEN
         SaXzRM/CMaHBdrHSfyYVMdnw9S9pmQpStVpzAH5RVzPlVoAisaeRJKZ3xLdhIy2qWCzx
         9CcxLjxlntm6LSdVc15M2q53/wuSeM7/LOSqrazGF+szCR/49ZpUNwyHJ9LtMtqXlAAa
         Y+NcdXEqaMAGixKp5E1yeqesNgE5XHimYsRXI01uTeCpAmU5jbEmeImwZ0zdfeaQnnU9
         yKRpVjvMfKe+nuf0rB00FkHk00F4r6FwmSb4lD1QehAb7YbfLTwvGWZRvPUmGDLlbZXQ
         dzxw==
X-Gm-Message-State: ANhLgQ3wFliq6TATtnZhUhe4KS6rUwCpLV+IfKCT3Vcu7Ce2RKKGf2D5
        1OkfzccJp9pTCJKi7obHZZA4pQ==
X-Google-Smtp-Source: ADFU+vuG4lJMdGuOPi6DXgu5JzM407RSy855bnUG1UuTb5xJvxQ+7aP+XEs6ZftW2sAQYdGUDfywtg==
X-Received: by 2002:a7b:cf19:: with SMTP id l25mr6240257wmg.131.1585065980936;
        Tue, 24 Mar 2020 09:06:20 -0700 (PDT)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id u204sm4887603wmg.40.2020.03.24.09.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 09:06:18 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Tue, 24 Mar 2020 17:06:16 +0100
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
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
Subject: Re: [PATCH bpf-next v5 2/7] security: Refactor declaration of LSM
 hooks
Message-ID: <20200324160616.GA9173@chromium.org>
References: <20200323164415.12943-1-kpsingh@chromium.org>
 <20200323164415.12943-3-kpsingh@chromium.org>
 <CAEf4Bza67kM0KiX464yB+iV83aV96TyD7iLEZJccXyH-Od0QTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bza67kM0KiX464yB+iV83aV96TyD7iLEZJccXyH-Od0QTQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 23-Mär 12:56, Andrii Nakryiko wrote:
> On Mon, Mar 23, 2020 at 9:45 AM KP Singh <kpsingh@chromium.org> wrote:
> >
> > From: KP Singh <kpsingh@google.com>
> >
> > The information about the different types of LSM hooks is scattered
> > in two locations i.e. union security_list_options and
> > struct security_hook_heads. Rather than duplicating this information
> > even further for BPF_PROG_TYPE_LSM, define all the hooks with the
> > LSM_HOOK macro in lsm_hook_names.h which is then used to generate all
> > the data structures required by the LSM framework.
> >
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > Reviewed-by: Brendan Jackman <jackmanb@google.com>
> > Reviewed-by: Florent Revest <revest@google.com>
> > ---
> >  include/linux/lsm_hook_names.h | 354 +++++++++++++++++++
> >  include/linux/lsm_hooks.h      | 622 +--------------------------------
> >  2 files changed, 360 insertions(+), 616 deletions(-)
> >  create mode 100644 include/linux/lsm_hook_names.h
> >
> > diff --git a/include/linux/lsm_hook_names.h b/include/linux/lsm_hook_names.h
> > new file mode 100644
> > index 000000000000..412e4ca24c9b
> > --- /dev/null
> > +++ b/include/linux/lsm_hook_names.h
> 
> It's not really just hook names, it's full hook definitions, no? So
> lsm_hook_defs.h seems a bit more appropriate. Just for consideration,
> not that I care that strongly :)

I like lsm_hook_defs.h better too :) Updated.

- KP

> 
> 
> [...]
