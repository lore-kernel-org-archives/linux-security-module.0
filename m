Return-Path: <SRS0=szIC=CC=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590A2C433DF
	for <linux-security-module@archiver.kernel.org>; Mon, 24 Aug 2020 13:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3685A2074D
	for <linux-security-module@archiver.kernel.org>; Mon, 24 Aug 2020 13:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="PuPOlDaS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgHXNHu (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 24 Aug 2020 09:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbgHXNHt (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 24 Aug 2020 09:07:49 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6E0C061574
        for <linux-security-module@vger.kernel.org>; Mon, 24 Aug 2020 06:07:48 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id ba10so7969123edb.3
        for <linux-security-module@vger.kernel.org>; Mon, 24 Aug 2020 06:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=++wVUAAL3FCIdU3Q7RBNPjfei0JC7QKDqs3d4gqLkD8=;
        b=PuPOlDaS3kto3atocjIDkePSCIXXIRpoKpPyuqY5As+lkPNxkYEIQAP9a/Nn2cf/ec
         zaFf5NNaSgVhzUZzGa4jT0EjXhrn3xTBWwhYneS2DFlEwstp+iof/WuOGObTgk2w8lW+
         cljb0Y9Qi3MmisyXxw2zwe8hcu0J00jevDGQsZ5Vec6b3SmGNOhiu0mujwKUpkoDGR87
         Sl5LHDc7XtsFWO/JUWqiA0gGgJ3A7tljnA1y0ltBpKiAg22PHAD56l8cejbAXvw9RAOK
         dwRkIuhsCAcYD0Rjth+QWS9fNGlDwFJlPb3RtgULuRw46wLEZ5oJELovinbtoaNvIcT4
         xZ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=++wVUAAL3FCIdU3Q7RBNPjfei0JC7QKDqs3d4gqLkD8=;
        b=SOjDxsv+LR/Tylgj1SBGKCycW6owWoYB7bh5Djj3lNt7GtaTV5QJN//uISM/s+UYAm
         xq8lTRl2M1XJWMF2MJ7bN8pebdCZS9MWLz685IQbnPPpWQ4NwDYHVLOQBf59Qjkaw7i2
         Ubc1Xbj3HZcs9UOzxBptWzJT7x6v5zjZF4pC5e8XnPSAeZrw1aRHebUYouk3e8SaB5ql
         Jrgb3bSAhi2kMs1lWwHSUy8OA1jDe7yS9ve9P9CGDj7klhA5AiN63HJy8RLMHs8zyeUp
         XRb9ZG2S53VE1CjH9s7JnJM3YDy9LlY7ej3ez1vJ8Mm8pgBmMpABpVM4aaRXDzApENVO
         MAuQ==
X-Gm-Message-State: AOAM530Jm0EIAK1iC1KHfwOEqipWEJYomvsJ+NRQuChzXopKyxt1SDtZ
        nnEXZ2h7+hPcdxGWq0Cty8KdYfVQy99yvmwAbi7e
X-Google-Smtp-Source: ABdhPJwvkn1F/xNYp0KGduUPe7dAvQCo8OrTtHv27xZTH9XHSiNh4240+VtyTkIu/D5pi9/aoxporbUNR2gCrGL2wZ4=
X-Received: by 2002:aa7:ca46:: with SMTP id j6mr2684340edt.128.1598274467311;
 Mon, 24 Aug 2020 06:07:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200807165134.3913-1-rdunlap@infradead.org> <CAHC9VhQW-8pem59QHQctx9UNhMNLEAjNwDiOU1ODz9wX5B_tdQ@mail.gmail.com>
In-Reply-To: <CAHC9VhQW-8pem59QHQctx9UNhMNLEAjNwDiOU1ODz9wX5B_tdQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 24 Aug 2020 09:07:36 -0400
Message-ID: <CAHC9VhT4EG3qs76=nfQ7sLW9t9V-jXymmczV9Ygq+9T+Qz4Pfg@mail.gmail.com>
Subject: Re: [PATCH] security: selinux: delete repeated words in comments
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Aug 7, 2020 at 2:09 PM Paul Moore <paul@paul-moore.com> wrote:
> On Fri, Aug 7, 2020 at 12:51 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> >
> > Drop a repeated word in comments.
> > {open, is, then}
> >
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Paul Moore <paul@paul-moore.com>
> > Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
> > Cc: Eric Paris <eparis@parisplace.org>
> > Cc: selinux@vger.kernel.org
> > Cc: James Morris <jmorris@namei.org>
> > Cc: "Serge E. Hallyn" <serge@hallyn.com>
> > Cc: linux-security-module@vger.kernel.org
> > ---
> >  security/selinux/hooks.c |    6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
>
> This obviously looks fine, but it will need to wait until after the
> merge window closes.  I'll send another reply once it is merged.

Hi Randy, this got buried a bit due to vacations and other patches but
I just merged it into selinux/next.  Thanks for your patience.

-- 
paul moore
www.paul-moore.com
