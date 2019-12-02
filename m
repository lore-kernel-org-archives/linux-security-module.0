Return-Path: <SRS0=f5xb=ZY=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E38BC43215
	for <linux-security-module@archiver.kernel.org>; Mon,  2 Dec 2019 20:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43428214AF
	for <linux-security-module@archiver.kernel.org>; Mon,  2 Dec 2019 20:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="HLMKnGEU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbfLBUEh (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 2 Dec 2019 15:04:37 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46805 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbfLBUEh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 2 Dec 2019 15:04:37 -0500
Received: by mail-lj1-f195.google.com with SMTP id z17so884758ljk.13
        for <linux-security-module@vger.kernel.org>; Mon, 02 Dec 2019 12:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4a9wd3LK/WMXQxJZI+b/CD+KV3p6tmfSnKjb/oWhht0=;
        b=HLMKnGEUW1I50CjZUFs++L/3XtSbERJUSs7q1SDbofRafls4/cGo40Tcg+rqmXb815
         YMnW0sbaC0GrD4fci5jcEykZTeybN9wN18htoKxwscueQrHffsfp0qytycXK04Lz/xOj
         NYOqXcoDqSI/7VsoMORawMJulxa67lt439mQ/O+iu/EAtKasnj37jc+1C9lUPjmBDHZs
         h6gO7dtaibtE7jX+EQdQpi+jFOvgGfbR9J57IJvbzrnSAYPwkhmjvB6Xtc+8r6dU1XhX
         9BxO0iiuZ9zf+fAKtDl3uKdZadS8rQ+5g6vwz6MB+MP363jVxCDA1r66AvBzdex/Sdcc
         QcBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4a9wd3LK/WMXQxJZI+b/CD+KV3p6tmfSnKjb/oWhht0=;
        b=Xgyk2S4fO9QBm0tSNnf9xv51Tq9aK5RWoW98dXnU3j0Z54uYAk0ogI6h/jDh5NFL/2
         pKUOdROlWIUMu0oYS4W5qCvnXsETR9qjTPbaTjpvaBm1s1GF084UfFRZ/ryNUg6lb9bW
         q2aW1b1qoEBixpDg5kETYuXSxiFL4FwYU3rdglLW481R9Xudyv3gWY11YsUFD4bY3bmQ
         GCV7JKrcUJxw6WJuOPCPGnMBdIg69P2avZLlMPMabb1McLz5sh2EqsyaJVdvYlNWhA1a
         qv+wqCE3ZLjVgNx2a2ZsmHcJJ2Am8ai/MFzm5Pv7zycXUXS8UWBhdUU0/IUgPxBDSTlJ
         VHUA==
X-Gm-Message-State: APjAAAWZ878+OIliLiNcWqlcHXHIfdGSUXWMqEYqQmPcadJ2wl4kUkDr
        QmJgGS+x1uUbwGRLae8n4Z+cYxSc+rRjF+bHNTOV
X-Google-Smtp-Source: APXvYqyDK/Pn/gNjm8YlA5sp2FKiD8lD+p3tLP4A6RnfpI01vux9roHpZ0OZtreCFn0pev+lOHmkJ563DiGQNxhvUm0=
X-Received: by 2002:a2e:85d5:: with SMTP id h21mr313937ljj.243.1575317074980;
 Mon, 02 Dec 2019 12:04:34 -0800 (PST)
MIME-Version: 1.0
References: <CAHC9VhRj-vx8AnP5tKcq9joNqWSHRv1bk+3e7DGU9mxjN+fVFg@mail.gmail.com>
 <1575302310.4793.379.camel@linux.ibm.com>
In-Reply-To: <1575302310.4793.379.camel@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 2 Dec 2019 15:04:24 -0500
Message-ID: <CAHC9VhRkosCVR+4qyf=GPKQuQoJzwjZZJ_z7rhE-qiL-TNbtPw@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux patches for v5.5
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        initramfs <initramfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Dec 2, 2019 at 10:58 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> [Truncated Cc list, adding Roberto and the initramfs mailing list]
>
> Hi Paul,
>
> On Tue, 2019-11-26 at 16:24 -0500, Paul Moore wrote:
>
> > - Allow file labeling before the policy is loaded.  This should ease
> > some of the burden when the policy is initially loaded (no need to
> > relabel files), but it should also help enable some new system
> > concepts which dynamically create the root filesystem in the initrd.
>
> Any chance you're planning on using Roberto's patches for including
> security xattrs in the initramfs?[1]
> [1] https://www.spinics.net/lists/linux-initramfs/msg04771.html

I'm assuming you're not asking about me personally? ;)

However, just in case, I'll probably wait until it is picked up by the
various distributions; somehow I haven't yet found the time to roll my
own distribution for personal use ;)

> Any help reviewing his patches
> would be much appreciated!

I would love to help, but given my current workload I'm not sure how
timely the review would be, I would suggest reaching out to the
distributions who maintain the userspace (and have asked for this
feature).

-- 
paul moore
www.paul-moore.com
