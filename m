Return-Path: <SRS0=hRTQ=QH=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76040C282D7
	for <linux-security-module@archiver.kernel.org>; Thu, 31 Jan 2019 01:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33BCF20989
	for <linux-security-module@archiver.kernel.org>; Thu, 31 Jan 2019 01:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="SvCycs7X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbfAaB57 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 30 Jan 2019 20:57:59 -0500
Received: from mail-lf1-f41.google.com ([209.85.167.41]:43730 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbfAaB57 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 30 Jan 2019 20:57:59 -0500
Received: by mail-lf1-f41.google.com with SMTP id u18so1073066lff.10
        for <linux-security-module@vger.kernel.org>; Wed, 30 Jan 2019 17:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7MOTlFqa8tspIU8wQZEWBbKciBxgK54tlwHUX/VaswA=;
        b=SvCycs7XJz0xg/M22qgTuplMQmzNGSa6DuVWpRzoh8gWZDo0lX1BmO6yZMqOTM8+N0
         wsnmzoT1JoMUgBPvzA9bHM2JiRYhCHvYwgP9KElUlPetImnpkARIQQ8pEjdZsh9BI9Oe
         VHx34JSgEwmHzZNnvm+mage/fjo93kQ4F+k/VVkf7P46S5QX+h7CIjJIK1HrIjDIyCRP
         fPSqwUYMDTAEdHsAT4v4oP6DGvhmLhX+7zOFewPNv3g1F5cJOw48ealaQOkaacYs1aRj
         VYvELvIKu3PAIZvEfcLOzRf3eSan2ZdX+rEW/x42Hmc405cH0+ENruLM01JGzPTmE9w0
         nI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7MOTlFqa8tspIU8wQZEWBbKciBxgK54tlwHUX/VaswA=;
        b=O6XMfu2yIThCwoydqkQRk3wlgrAvpAls9ugOhQ3ZGkuGmuvkGBzcYCvOAUtpR086iS
         mHFLPC1OzTGEe3DI0DfQu4ylfpEjHOkMbcaTxc1PngZgmaeGMTKdah/uLviPNoY1GMUM
         Q1Sfwne79lxhCMECsuPxEddbO7wptFROLYc/idyB0nET9aHgvu0VbWjc5mZONR/HGM2C
         u4tugZMF5EgusXmjBimQH1PdzsudIjcUB4KE2DTWNblXCPhX3G+GGhWbdY4QJEvYUiUZ
         jt7a1JKXwnvr6FuTtWpfNJ+iG5bTKh5L9cCk0i1ToDOMT0jvMjCfIHd34OAvrpEk66qx
         hmqA==
X-Gm-Message-State: AJcUukfd2PypGNyoOauJxzrhKr5R/Nqvq3nTqBUEeo7JT2YQ9h6pcW7M
        o6DvkVQ0rlCYQq7AIZhlQXEH2Rvo6jnrscV9oP74
X-Google-Smtp-Source: ALg8bN6jSoGg9DwfXGd/J4FZp3uSOuZObVVG6HMoqnIAze6lCVFbey+Y2adhHFDlWT+u5OF/x3uIQcPFq6+NEXvwKkU=
X-Received: by 2002:a19:cbcc:: with SMTP id b195mr25381666lfg.117.1548899876544;
 Wed, 30 Jan 2019 17:57:56 -0800 (PST)
MIME-Version: 1.0
References: <20190131005849.fmwpsg2dvwwwmali@madcap2.tricolour.ca>
In-Reply-To: <20190131005849.fmwpsg2dvwwwmali@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 30 Jan 2019 20:57:45 -0500
Message-ID: <CAHC9VhQY40KZX6A+X13G8O-Hn-_N92196t-BpJj=3oMySJdx5Q@mail.gmail.com>
Subject: Re: actx not used?
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jan 30, 2019 at 7:59 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> Hello users of *audit_rule_match(),
>
> As far as I can tell, it appears that the audit_context *actx parameter
> to *audit_rule_match() is not used by any consumers in-tree upstream.
> This includes selinux, apparmour, integrity and smack.
> Might there be others out of tree that do use it (or did request it)?

I'm not aware of any work-in-progress that would make use of it, so if
it isn't used by anything in-tree, go ahead and get rid of it.  If we
need it again in the future for some reason we can always add it back.

-- 
paul moore
www.paul-moore.com
