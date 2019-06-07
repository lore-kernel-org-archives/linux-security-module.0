Return-Path: <SRS0=9TCU=UG=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E75C2BCA1
	for <linux-security-module@archiver.kernel.org>; Fri,  7 Jun 2019 16:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 230392067C
	for <linux-security-module@archiver.kernel.org>; Fri,  7 Jun 2019 16:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559925668;
	bh=4qVWoZokjDgBZvYJ5lk1cJVg3BvI5JKoufcaQXGGA04=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=dx6466qlEmVjf7vmpejLZXdf81B7p7ZuTLVkaEyyIQWsbeASOhIFZNamNrbA6J1J7
	 +ZkrN33dPfoo/IFsqmYQHFQvbsZ1zuWBp/OL6835rKNqTC21oocCxAkx/44jPgKU7R
	 M3Gm+H816epGQaNJzRIBQt99y00LZjWrHSfPlsDk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730550AbfFGQlH (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 7 Jun 2019 12:41:07 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37905 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729953AbfFGQlH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 7 Jun 2019 12:41:07 -0400
Received: by mail-lf1-f68.google.com with SMTP id b11so2107838lfa.5
        for <linux-security-module@vger.kernel.org>; Fri, 07 Jun 2019 09:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/hjS06kksmvXKKACQCnPiaKbtP2R8cOVn1m0gpdsIsk=;
        b=OZMxqdUWGyNBlPYl3DcxShmsv9iCdGBuWVI8mpGyqO8IwRynjBT9fPkhnJaQggffy5
         rmXtERqcYDfoLeheyZW8mY4tYKc5XVa0lHT+e7AVmf5v4Zq68YwtRhbLe0i713O8d/rD
         Ko4pfrfcY7S8q1zPpMy8L6jrtTFnSd+HzC884=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/hjS06kksmvXKKACQCnPiaKbtP2R8cOVn1m0gpdsIsk=;
        b=lwiT47/pvJ0gZn1CyzQ8dIrze4HTB/Lg+pp/NyjcLcKlGsatwqFH/GVmnirchq7T+Z
         DJpvF5HFFYJsZKPUB2WnQEd9mbh/e76a77pvtjc4xtzmrL2dlDnSltZH3vF+YXUDmZXE
         fpQ5ZD4RwMyS8WBh65Ih+7fm7tTFrX04u5ZQsuwjDcMV5jbA6ei/qsb/iH8z1V0UKS3V
         QPUZayanpmrWRL1gR7DHclihrnIkKQf9bZS09GPquwXvVH3zmFZQLqqBrOgUHefFcw8g
         Icdxpk+ChzWXtyJOtp/SLPBu5Rvy5nyt21FDQEXSRGB/I2mALW4IQB+dWbSQWyC8t5pP
         vHvA==
X-Gm-Message-State: APjAAAVEuuv4RdKijS1pShmTiAP1euXLWvrDTsC96VAITRUITZ/w3aBn
        1vPeDW5wih4aARtDcJ8yc/GiFo3/bzg=
X-Google-Smtp-Source: APXvYqxCnYS5LgIDPv8ydv7bktgHTGAL52+4MjKTqCsUzsLKExixNb2LB1A+KZvHKTe1DSHdAKUZ2w==
X-Received: by 2002:a19:7110:: with SMTP id m16mr27403790lfc.4.1559925665042;
        Fri, 07 Jun 2019 09:41:05 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id o8sm467365ljh.42.2019.06.07.09.41.04
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 09:41:04 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id r15so2092504lfm.11
        for <linux-security-module@vger.kernel.org>; Fri, 07 Jun 2019 09:41:04 -0700 (PDT)
X-Received: by 2002:ac2:59c9:: with SMTP id x9mr27015971lfn.52.1559925663867;
 Fri, 07 Jun 2019 09:41:03 -0700 (PDT)
MIME-Version: 1.0
References: <de770db0-5451-c57f-df52-75114ad290e9@canonical.com>
In-Reply-To: <de770db0-5451-c57f-df52-75114ad290e9@canonical.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 7 Jun 2019 09:40:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg=io4rX2qzupdd4XdYy6okMx5jjzEwXe_UvLQgLsSUFA@mail.gmail.com>
Message-ID: <CAHk-=wg=io4rX2qzupdd4XdYy6okMx5jjzEwXe_UvLQgLsSUFA@mail.gmail.com>
Subject: Re: [GIT PULL] apparmor bug fixes for v5.3-rc4
To:     John Johansen <john.johansen@canonical.com>
Cc:     LKLM <linux-kernel@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Jun 6, 2019 at 5:39 PM John Johansen
<john.johansen@canonical.com> wrote:
>
> Can you please pull the following bug fixes for apparmor

No I can not.

You have for some completely unrecognizable reason rebased OTHER PEOPLES WORK.

There are two new apparmor commits in there, but there are also 89
random rebased patches from the networking tree.

What is going with all the security subsystem issues? Why does this
garbage keep on happening, and why are the security trees doing this
when everybody else has learnt.

DO NOT REBASE. NOT EVER. YOU CLEARLY DO NOT KNOW WHAT YOU ARE DOING.
"git rebase" and "git merge" are not commands you should ever EVER
EVER use, because you don't seem to understand what they do.

I'm seriously fed up with all the security subsystem by now. This is
not ok. It's not even one person, it seems to be a common issue where
people do completely odd things that make zero sense.

                   Linus
