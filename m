Return-Path: <SRS0=sk88=TY=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CD0C072B5
	for <linux-security-module@archiver.kernel.org>; Fri, 24 May 2019 19:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E49C720863
	for <linux-security-module@archiver.kernel.org>; Fri, 24 May 2019 19:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="ULdMaSWb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731979AbfEXTh0 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 24 May 2019 15:37:26 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:45051 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729597AbfEXTh0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 24 May 2019 15:37:26 -0400
Received: by mail-lj1-f182.google.com with SMTP id e13so9619926ljl.11
        for <linux-security-module@vger.kernel.org>; Fri, 24 May 2019 12:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kVk+QgoPFapzgPKidQ2Ex+ZNQpBdgX+8bAqGLKPLCI0=;
        b=ULdMaSWbQZzi20lXO0vOVwhvcen1RL31LlQ15vZblK2tTgstJZwsLnZ+g29A6yExXh
         qbuuNQ7pHieW0CJBMZGGCpRb96ZETfCMZLl9onk2JGc1+ivP2Iq5oUAGBg5b1WD1kJT7
         SrF/JT0dhKxQwTBJhSFHcjhX1fWWk5HcLeNZSa3ns7h1QMsSCU3PmUYRO/m096wWSwMm
         gx6MDOhAt0cmOPLgTn6gD3r6ISUvMPTsdeTTGXO9NXyawhhHrM/jHi7f3kaKl4tivvxe
         3OrulggCTeEfvCq/tZ1QGJeE0F7YZJow/9XTjlSKCfHqeVTI4QiuR5KX+bPz2hq7EqQr
         G/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kVk+QgoPFapzgPKidQ2Ex+ZNQpBdgX+8bAqGLKPLCI0=;
        b=ObsYe2637hiSk2p3LKcLtZZZPJvUBGgf+HVXdpgpeVTKMJCNtRlxssbJrZY240QgDJ
         RS8rDKphDaMxgmchtuDBUYphG3TMEukH+p4Jch6q44UV5yhWDPcf9RqDdQBKqGmDBqD4
         7EZcnhAyRqh3PQd0YAd3lfgy7fTKWjF/8aZ/LvjMpBNj08HWrPudAlBnzEPDxji0b+9m
         Miwn0pzlcMRkPyQFpgb34ku61yWaHQOxfQlbUy9roeKDlrO91+Tnlg+FPGZRQ+NzjecB
         NSRXBogpbF3mVfDN/gIHaHBrY9oQSNZ320app3sb9As1obEKzqhxkfM1dL1w6+V64fnp
         jOyw==
X-Gm-Message-State: APjAAAUQVHU0wH8xYADxhTCm41soRoT4vk0glHIrknEF9g8/sgW+Mj87
        cRy1gsk9rsPbZpMZjrcU4RrR5yd7nsdnnNfA55rh
X-Google-Smtp-Source: APXvYqzx9iYiPzb/49lLkhXhCM1JJXCCJamB68x8jn6crqFMRwY0JCbl3BkrkvrgwU2xAqNRHQULROFr0KVObRaVOBE=
X-Received: by 2002:a2e:3e14:: with SMTP id l20mr37815015lja.40.1558726643706;
 Fri, 24 May 2019 12:37:23 -0700 (PDT)
MIME-Version: 1.0
References: <1106985e-1620-75b2-d6bf-c2c95d9a0fbb@schaufler-ca.com>
In-Reply-To: <1106985e-1620-75b2-d6bf-c2c95d9a0fbb@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 24 May 2019 15:37:12 -0400
Message-ID: <CAHC9VhRY8UOS9G_CgBPe=tVYgLmL7KHC_=RRtHyemHrx0_RqjA@mail.gmail.com>
Subject: Re: Stacking patches for 5.3
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        John Johansen <john.johansen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, May 24, 2019 at 3:26 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> I have a set of 59 patches for the nest round of LSM stacking.
> They are all really small. Kees has expressed a preference for
> small patches. I think that the collapsed set of about 10 would
> make more sense. Which would the community as a whole prefer?
> The patches are not much different from what has been presented
> already.

Is there an option for "not posted on the Friday before a holiday weekend"? ;)

I honestly don't care too much about patch size, regardless of how it
is packaged it's a lot of pretty critical stuff to review.

-- 
paul moore
www.paul-moore.com
