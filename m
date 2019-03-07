Return-Path: <SRS0=bVIv=RK=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8C0C10F03
	for <linux-security-module@archiver.kernel.org>; Thu,  7 Mar 2019 09:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2901C20851
	for <linux-security-module@archiver.kernel.org>; Thu,  7 Mar 2019 09:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725747AbfCGJBH (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 7 Mar 2019 04:01:07 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41043 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfCGJBH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 7 Mar 2019 04:01:07 -0500
Received: by mail-oi1-f194.google.com with SMTP id e7so12289564oia.8
        for <linux-security-module@vger.kernel.org>; Thu, 07 Mar 2019 01:01:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ElYvV2fvCkLBraBf/ssGt1m5M7ChBwo7N0gPQyqJnBo=;
        b=o32lsf4UMZq2BHsqZDl6qFUF7O7XEy/raUBGl4hIV+ZP6E+PQAxnE6ntmH5H0m0RIO
         RSqs+m3f+IdgHQmkVfU6uYabg/2tMWHhd1Xa57ny52k/2FgjgyfZJ1bJTn8UseFCS7CQ
         uazJ644Xz4v/tgcDnIjIu6rHUadiTyS35I3tx31TQY87W+FP8hg2+p2/MO1YbgSSo973
         DfNdsYSwbWuTlsf1Ug92c1Flk8lhTba+9RcJfWeTg2Z7s6BqI9Xyd9J8ICmWuesl23lN
         Nj38WeGQ+M/Og/+jS+7aQMfzkVHMKNzJg5e4CRjPkWvZsVmZof+n70vS6GEACFBoU069
         PZ/w==
X-Gm-Message-State: APjAAAW48AQLLnKpORsKmQc3Fg8Rft5tpMZlUjLhf+/Slkg5Xlgmj2uG
        1+x46wM7XnWEWgwTkj+ryfGKwLjAU50YlQb4AP0Uxg==
X-Google-Smtp-Source: APXvYqw3uOHyjzfvwCSHqr+uoJAyjHPkJ7W2ZevYHUvRTAm6uUKO4wRRnTOXVnyvO3tpQqOhTdQXpBba9CpvZnmr174=
X-Received: by 2002:aca:3746:: with SMTP id e67mr4471451oia.103.1551949266422;
 Thu, 07 Mar 2019 01:01:06 -0800 (PST)
MIME-Version: 1.0
References: <20190222145718.5740-1-omosnace@redhat.com> <CAFqZXNs28QAxHA3=vECuG17TQ-be0ywS=r9S48q_KNBYpzgJLg@mail.gmail.com>
 <CAHC9VhShXZasD8d3nF4PwaL38gkq3hKDbvRivHX5_oHeBROFKQ@mail.gmail.com>
In-Reply-To: <CAHC9VhShXZasD8d3nF4PwaL38gkq3hKDbvRivHX5_oHeBROFKQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 7 Mar 2019 10:00:55 +0100
Message-ID: <CAFqZXNs8s6K9nK80+6FE9UOktWLy5PdbJ864zZ3rCXE9K71LuQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] Allow initializing the kernfs node's secctx based
 on its parent
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morris <jmorris@namei.org>,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Mar 6, 2019 at 5:20 PM Paul Moore <paul@paul-moore.com> wrote:
> On Wed, Mar 6, 2019 at 10:54 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > On Fri, Feb 22, 2019 at 3:57 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > [...]
> >
> > Ping about this series... Casey, are you OK with this new version?
>
> We've got two weeks, well one and a half weeks, to decide as the
> earliest I would merge this would be after the merge window closes :)

Sure, I just wanted to know early if there would be any more changes needed.

--
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
