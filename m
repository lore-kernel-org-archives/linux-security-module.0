Return-Path: <SRS0=wiIN=6U=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0170C47256
	for <linux-security-module@archiver.kernel.org>; Wed,  6 May 2020 15:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D13CF20A8B
	for <linux-security-module@archiver.kernel.org>; Wed,  6 May 2020 15:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oEhUT0Uf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729428AbgEFPec (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 6 May 2020 11:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729353AbgEFPec (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 6 May 2020 11:34:32 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108F6C061A10
        for <linux-security-module@vger.kernel.org>; Wed,  6 May 2020 08:34:32 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id fu13so1043340pjb.5
        for <linux-security-module@vger.kernel.org>; Wed, 06 May 2020 08:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Gb2TqqmmU2qOWGfoFSijSCwJM2igRhwccR0CWHmE4pM=;
        b=oEhUT0Ufn+nJY7KEy1YZKbHTppMxHGRjgiK0K6/qIDtvjoNBRFfPPmvqXs7xjKpt0s
         kypw0Y/2r1ktwvEChy0w9RutTZ4YC+netbwrszcqxir3JA/SZ0Cqn3v/vjD72T5EJ62W
         dBqHktrHl5BDGJiZXZtUanyNjMJMcyXtmsjP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gb2TqqmmU2qOWGfoFSijSCwJM2igRhwccR0CWHmE4pM=;
        b=NAnzsu2eJ2lL5IxY63w9suGJzzY8StA2f1CFXeM3MURwDoHID6rUYDPhV+Ux2s2Zfh
         x1ZhIe9Yjmfg8Iu04hoyYnwinyofC89C36bsQLk5CYAu8oDj5hk/KdZhaZ1XWh93AboQ
         VtG9sqeNKuN6D+qwszIbJSW2VoDOIBOryxxO7bZtrljqtXwERMzrrAO84aDZUcliOaQS
         rLSXmvVjIa302pT4Brif3DSFbM/G5Oku23JedTziVIhP0CEO+QaGm5yvmtjKB092CDMs
         beP1NBOw0Im+EJnbHLR0vqu0zOBcseKl+aiF+WW1uVvHgke4PPOCsU/jq6xmLFfTN9q8
         9uPA==
X-Gm-Message-State: AGi0PuZjIJsEg54YTRor/QIy4vmG2xxELwSQ/D/RWQ7XDon8rkn0Y1bG
        uXu5k5KTeOp0eip0poRSbN4YDUs14n4=
X-Google-Smtp-Source: APiQypKAC5fjwvNCBfn2l3Itu4c/lAUzq6/AohL7JUYZevpFrxGdy1xepw7tko5JMzww4m0sOoG8Ug==
X-Received: by 2002:a17:902:23:: with SMTP id 32mr8696193pla.40.1588779271527;
        Wed, 06 May 2020 08:34:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o1sm5230528pjs.39.2020.05.06.08.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 08:34:30 -0700 (PDT)
Date:   Wed, 6 May 2020 08:34:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] securityfs: Add missing d_delete() call on removal
Message-ID: <202005060831.C05759E@keescook>
References: <202005051626.7648DC65@keescook>
 <20200506011431.GB23230@ZenIV.linux.org.uk>
 <202005052024.2D7626C742@keescook>
 <20200506040252.GC23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506040252.GC23230@ZenIV.linux.org.uk>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, May 06, 2020 at 05:02:52AM +0100, Al Viro wrote:
> On Tue, May 05, 2020 at 08:28:33PM -0700, Kees Cook wrote:
> > On Wed, May 06, 2020 at 02:14:31AM +0100, Al Viro wrote:
> > > On Tue, May 05, 2020 at 04:40:35PM -0700, Kees Cook wrote:
> > > > After using simple_unlink(), a call to d_delete() is needed in addition
> > > > to dput().
> > > > 
> > > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > > ---
> > > > Is this correct? I went looking around and there are a lot of variations
> > > > on the simple_unlink() pattern...
> > > > 
> > > > Many using explicit locking and combinations of d_drop(), __d_drop(), etc.
> > > 
> > > Quite a few of those should switch to simple_recursive_removal().  As for
> > > securityfs...  d_drop() is _probably_ a saner variant, but looking at the
> > > callers of that thing... at least IMA ones seem to be garbage.
> > 
> > Hmm, I dunno. I hadn't looked at these yet. I'm not sure what's needed
> > for those cases.
> > 
> > Is my patch to add d_delete() correct, though? I'm trying to construct
> > the right set of calls for pstore's filesystem, and I noticed that most
> > will do simple_unlink(), d_delete(), dput(), but securityfs seemed to be
> > missing it.
> 
> d_drop().  d_delete() is for the situations when you want the sucker
> to become a hashed negative, if at all possible.

I'm not sure what that means. :) Should stuff like apparmorfs be changed
to d_drop()?

> Re pstore: context, please.

Just posted the whole series:
https://lore.kernel.org/lkml/20200506152114.50375-1-keescook@chromium.org/

But the specific question was driven by this patch:
https://lore.kernel.org/lkml/20200506152114.50375-11-keescook@chromium.org/

-- 
Kees Cook
