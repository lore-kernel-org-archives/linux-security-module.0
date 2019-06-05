Return-Path: <SRS0=3lle=UE=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00664C28CC5
	for <linux-security-module@archiver.kernel.org>; Wed,  5 Jun 2019 19:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C87FD2075C
	for <linux-security-module@archiver.kernel.org>; Wed,  5 Jun 2019 19:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="lKLkULry"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfFETOn (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 5 Jun 2019 15:14:43 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39732 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbfFETOn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 5 Jun 2019 15:14:43 -0400
Received: by mail-lj1-f195.google.com with SMTP id v18so3056889ljh.6
        for <linux-security-module@vger.kernel.org>; Wed, 05 Jun 2019 12:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5YdHvRbtZkoE1mfXKC6vKs/nctU9UV+n3UMFdB8rp/0=;
        b=lKLkULryb6Sq2vFOw0+lQBDe0gS7QININkc/K8BNQ6vkjRUgxkRAr+ZCtnxTH8NeaT
         Ip1ZHBiunLcgX8U6ly75UHRNDMUgu2vnwjBdtke2tJbJrXRZwHBfSnsrToUxEs/IvgQu
         rXwnIgnxYIF5e0cZijkqw0iC6q4Ylb9Wl4cWMzaMU0tbNXXHtq1bGXwh5pE+XmLkUUCh
         8Cd0zdFzVXVc9nJfv22I8ySXkCmcCMoom0R4MowTjVbt6n1gF1ExTTrksvj1A1ejmOdZ
         nd9N60Xr5QmidjkJ4nIOb1XqIZFt4P1p9f6Qsqfkz0BTZoKBpXbo4m0oDRRCfRFQ+LNL
         Bh1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5YdHvRbtZkoE1mfXKC6vKs/nctU9UV+n3UMFdB8rp/0=;
        b=T6+d6Zz/ar97rPYysFsC8Mtt/KxDrCmGNCqMBhNeZhKHvFgjqnetCmWPmzrJUELkYN
         vWA2kN7Ogm1GgmEJLwd/dMXEhTZF0zK6xP+hVtPc+y/SRFxp6ZFzKL02vc5h04Q50EX8
         wI+cnIOwrGBMK0baNiX0jdTNfnwHIuoEHktS58KHsMS0K8xlBWGHz6eXWCrAFtRBDip+
         exY7hOXtzAVELlrSavel5tYNW/8ffmzRdwljPQndrOiOtevQVdcCcLQql7bVOLPm2v+R
         tcSHBLgUP27m+N8GUbGNlar9/KKAPNb1i1+JVrgSgEOvJxvm0kkO0PwynldINmJA+ww/
         PdyQ==
X-Gm-Message-State: APjAAAWJy/2rjmFWObHAQyTEdMdvKV2Y/tFeNmsyuNqo0EE87FpeNq0O
        HHBx3xEvXmqd2lwkdmKmp9oBtbRA4TcVrAyo5u0uJq86uA==
X-Google-Smtp-Source: APXvYqyrZ5kZlXvA/atqDgMrNWTJzdEaKKrAJ7Zz+ROHwpaD1NkfP1SiPCBf/KOZ0qhXqv0OTCPN92hG7X49hgGoQGg=
X-Received: by 2002:a2e:9bc5:: with SMTP id w5mr22603075ljj.87.1559762081075;
 Wed, 05 Jun 2019 12:14:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190605083606.4209-1-janne.karhunen@gmail.com>
 <9121835b-d6ac-c9d5-349a-1ef7024c6192@schaufler-ca.com> <CAE=NcrahPmzmB-xJwxzXqaPGtJY+ijbxV4wXz7K=y-ocw4Cmwg@mail.gmail.com>
 <1edfbd72-f492-db17-8717-a8cfe30d9654@schaufler-ca.com>
In-Reply-To: <1edfbd72-f492-db17-8717-a8cfe30d9654@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 5 Jun 2019 15:14:29 -0400
Message-ID: <CAHC9VhTzwPoxYPxYWn15ZQQwM6Q3wGJSRybb-zu_ZDA1xU6ziQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] LSM: switch to blocking policy update notifiers
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Janne Karhunen <janne.karhunen@gmail.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jun 5, 2019 at 1:05 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 6/5/2019 9:51 AM, Janne Karhunen wrote:
> > On Wed, Jun 5, 2019 at 6:23 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >
> >>> -int call_lsm_notifier(enum lsm_event event, void *data);
> >>> -int register_lsm_notifier(struct notifier_block *nb);
> >>> -int unregister_lsm_notifier(struct notifier_block *nb);
> >>> +int call_blocking_lsm_notifier(enum lsm_event event, void *data);
> >>> +int register_blocking_lsm_notifier(struct notifier_block *nb);
> >>> +int unregister_blocking_lsm_notifier(struct notifier_block *nb);
> >> Why is it important to change the names of these hooks?
> >> It's not like you had call_atomic_lsm_notifier() before.
> >> It seems like a lot of unnecessary code churn.
> > Paul was thinking there will eventually be two sets of notifiers
> > (atomic and blocking) and this creates the clear separation.
>
> One hook with an added "bool blocking" argument, if
> that's the only difference?

I think there is value in keeping a similar convention to the notifier
code on which this is based, see include/linux/notifier.h.

-- 
paul moore
www.paul-moore.com
