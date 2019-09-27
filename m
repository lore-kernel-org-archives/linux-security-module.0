Return-Path: <SRS0=6wZ9=XW=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7031C4360C
	for <linux-security-module@archiver.kernel.org>; Fri, 27 Sep 2019 14:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B57E217D7
	for <linux-security-module@archiver.kernel.org>; Fri, 27 Sep 2019 14:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="UL3FcFE2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfI0OtI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 27 Sep 2019 10:49:08 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:32818 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727668AbfI0OtH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 27 Sep 2019 10:49:07 -0400
Received: by mail-lj1-f194.google.com with SMTP id a22so2814031ljd.0
        for <linux-security-module@vger.kernel.org>; Fri, 27 Sep 2019 07:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KY62cZcmvsX3xM03mBE6HBbDYvpNvwvQeq59nLOyZl0=;
        b=UL3FcFE2NfXwtjvIvldZ2MUHIneNoq+mJEDmSgWEOp1dFr4eIlKaEqUNo+C3YqExFG
         mV39oyx+CARY2Od6aZhcw0xcNCszg5/Q3S+h7ceTavOyGJif5F+TDzGJfY15EoWKVtvv
         +eNRqBqk5d655UGD36nFXLsuwmoMmc/PkD048FcYSe0eksgJAssGG0k1HQP8uA1DKysm
         NepqPDU7b4JBqK8O0OnE56UKcCbC0y2Hbh8R9CU+73UeGD7CFQvTn7K9wRy5N3iE431p
         9Z6fexvTVsiZbqocbA0BOPVkySpbQ1yku2nvPHOXnsgPFJ5P7Uva3wrozBj2yu1Ci55H
         DC4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KY62cZcmvsX3xM03mBE6HBbDYvpNvwvQeq59nLOyZl0=;
        b=bHhbWVdHQm8rfzoCEZtIMoqk5UeudAGCIX+USivTfJZWsEXAUgf/mXqESZu8yiQxLx
         5z7SF16dPTIShnxLCFPuMWUmKx7B67WmOLjdKl8gkcSmxg5LHt8OCgr9vAL1GxjUKnjt
         DKQqDcNuPgZkksw1YaO+ATdoq7PZuqyWfESSuX1Ztump+OqhhRzaE8KlLf9iPcIUruE2
         C1DostchftBwTt5rdMKmxCxMJD/iV0JYlXQak7FJbh/+9GEX1a1yK7+tE7eJE8bO98D/
         mIjkFCDxYJE5fMRdaBftTOAnZhQYv/Ddd3FBuBUV78JdEpmk3m+YTcCOu5su9+Pyb2Eg
         CtCA==
X-Gm-Message-State: APjAAAVLr6eVTJGSjFsw/Zkf2dwwZt6DXWOHT79zKVCNG40ne8e7ZCMI
        ep8KtiioLtPT8UmLsjqQuOIZNR9SHt89aijk/zZ9
X-Google-Smtp-Source: APXvYqwkLzs8wOmvCMGAVfW9UfG3yFSgEhQJ4PJF36b0OQ8ayRelEpR7nbkBPFNaMcT8MMXULnm3ONsYWWGQxckK3Pg=
X-Received: by 2002:a2e:890c:: with SMTP id d12mr3273555lji.85.1569595745451;
 Fri, 27 Sep 2019 07:49:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhR+4pZObDz7kG+rxnox2ph4z_wpZdyOL=WmdnRvdQNH9A@mail.gmail.com>
 <c490685a-c7d6-5c95-5bf4-ed71f3c60cb6@web.de>
In-Reply-To: <c490685a-c7d6-5c95-5bf4-ed71f3c60cb6@web.de>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 27 Sep 2019 10:48:54 -0400
Message-ID: <CAHC9VhRk8Gc_Yexrjz5uif+Vj7d+b=uMUytbrmbm2Yv+zoM05w@mail.gmail.com>
Subject: Re: genetlink: prevent memory leak in netlbl_unlabel_defconf
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Stephen A McCamant <smccaman@umn.edu>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Sep 27, 2019 at 9:15 AM Markus Elfring <Markus.Elfring@web.de> wrot=
e:
>
> > > In netlbl_unlabel_defconf if netlbl_domhsh_add_default fails the
> > > allocated entry should be released.
> =E2=80=A6
> > That said, netlbl_unlabel_defconf() *should* clean up here just on
> > principal if nothing else.
>
> How do you think about to add the tag =E2=80=9CFixes=E2=80=9D then?

From what I've seen the "Fixes" tag is typically used by people who
are backporting patches, e.g. the -stable folks, to help decide what
they need to backport.  As I mentioned in my previous email this
missing free doesn't actually manifest itself as a practical leak on
any of the existing kernels so there isn't a need to backport this
patch.  For that reason I would probably skip the "Fixes" metadata
here, but I don't feel strongly enough about it to object if others
want it.  FWIW, I play things very conservatively when talking about
backporting patches to stable kernels; if it doesn't fix a serious
user-visible bug it shouldn't be backported IMHO.

This patch is more of a conceptual fix than a practical fix.  Not that
there is anything wrong with this patch, I just think it isn't as
critical as most people would think from reading "memory leak" in the
subject line.  Yes, there is a memory leak, but the kernel panics soon
after so it's a bit moot.  Further, even if the panic was somehow
skipped (?) the memory leak only happens once during boot; the failed
initialization is undoubtedly going to be far more damaging to the
system than a few lost bytes of memory.

--=20
paul moore
www.paul-moore.com
