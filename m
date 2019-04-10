Return-Path: <SRS0=my8L=SM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45997C10F11
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 19:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 143FD20820
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 19:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554925502;
	bh=0cLhpq+yQ10qB9ukleJOXpSFwirvMql+mTikt2IIvCM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wePWpdZ0xAfq/IHQ4Twi6K3p3IDjZGrKk4L91Tu6oQooTv2kb2Ic42E59eOoYYVOt
	 4+HhGKJFMHuhnPg/nPZVZpvk/c/EZT0/x6TC/MmarqiWMIjBhIBz9dzh6qhO0HViCw
	 Ov/YKp5E9t2g8QZk+TYoPUt2zw3DSA4aXNqPnifY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfDJTpB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 10 Apr 2019 15:45:01 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41506 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbfDJTpB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Apr 2019 15:45:01 -0400
Received: by mail-lf1-f65.google.com with SMTP id t30so2736177lfd.8
        for <linux-security-module@vger.kernel.org>; Wed, 10 Apr 2019 12:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rsBa5M7cr66bNr57pCqY9xnSx/YPJHTWLIyNqQt1HX0=;
        b=Obu0iH5zZYljx26kyd08C8+DLbYm44jLQE7W5yMnS8jj8F8d118hGNeonhA2WrNRyk
         6FYPs+HiiL2UnpuK6OuEY8sb7YHQn6hrzVOg/OinGsYpE9qBNhzVqAeFbZOEbGs45kec
         kR3KgV93LJvr94gdAxbsQcYz29BIGyUmb8Mdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rsBa5M7cr66bNr57pCqY9xnSx/YPJHTWLIyNqQt1HX0=;
        b=mDybS6G7FHbRQzV/KLRcMcnAdMoNBPec0jHC5EWb6K2vPmcCpCTybtGsdBbcEVr+cl
         F3zIiTa4FjOI4yrz6IQDCr/Wj+4Eh128s2bly0p+STEeBoNRh3XC7QVPn0+fuZRZuLyE
         LflNEaJX48JNj+jvMVcvugEWujSPWU1d/6d1xo95F4Pt5t4zYdK64f/k6NAF/07gmlk1
         NJxYpzvKt3/zDA+DoSTc0WAkYl9ngwVyKOyGJkn5NHbajCIbsmdE0mjywXBvgvl/Rsrg
         HEW0VV0ITqNDCZZvzotWafniikLWE9Ok6uVNqZdcvTHE9s89Pxhx65d6wXfvpmZo5lHJ
         n7Cg==
X-Gm-Message-State: APjAAAUh0S4+ujNNwtdLm3qkVne6BDoyA6pqyoYAb+lSmGPh7ebJYkc6
        LnFL91Gx9u2pYDPfcXIM3rEm8rI0lKU=
X-Google-Smtp-Source: APXvYqxqc5Y0+f1gwhzqHpbRFldwIrUmU31CvERzvxv9Df2+1sdjg4GjWKA8GQ+iF++jk2KTfSPRWA==
X-Received: by 2002:a19:5506:: with SMTP id n6mr23125319lfe.119.1554925498910;
        Wed, 10 Apr 2019 12:44:58 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id 77sm7425469ljc.69.2019.04.10.12.44.57
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 12:44:57 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id j89so3266711ljb.1
        for <linux-security-module@vger.kernel.org>; Wed, 10 Apr 2019 12:44:57 -0700 (PDT)
X-Received: by 2002:a2e:9597:: with SMTP id w23mr18295781ljh.111.1554925497426;
 Wed, 10 Apr 2019 12:44:57 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000006946d2057bbd0eef@google.com> <CAHk-=wiijJMTw=nTj_ED+YWMCrvHzh3ezfVYRxvzcW6+trgyPA@mail.gmail.com>
 <20190325045744.GK2217@ZenIV.linux.org.uk> <CAHk-=wg4iJsMHBzK52WzP+5_92HbwvX_vh_s4mMUuN0FJGdM5A@mail.gmail.com>
 <CAHk-=whJ4M5FegOLvnjUtJ0+pHv4L8UNFt+9jJDhox3Ada8kwA@mail.gmail.com>
 <20190325211405.GP2217@ZenIV.linux.org.uk> <CAHk-=wj+-e=X9cvvNwc5+QuvBOyYT7OtZTBzy-Wg8zGrUwxSbw@mail.gmail.com>
 <20190325233731.GS2217@ZenIV.linux.org.uk> <20190326014552.GY2217@ZenIV.linux.org.uk>
 <20190410181135.GA32071@ZenIV.linux.org.uk>
In-Reply-To: <20190410181135.GA32071@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 10 Apr 2019 09:44:41 -1000
X-Gmail-Original-Message-ID: <CAHk-=wg1hfdCE97hCCgRqW4=vbcAj8SaGhGffajg7B-aVenzNw@mail.gmail.com>
Message-ID: <CAHk-=wg1hfdCE97hCCgRqW4=vbcAj8SaGhGffajg7B-aVenzNw@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in path_lookupat
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     syzbot <syzbot+7a8ba368b47fdefca61e@syzkaller.appspotmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Apr 10, 2019 at 8:11 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Both are in vfs.git#fixes.  Which way should that go - directly or
> via linux-security.git?

Just do it directly. I doubt you can trigger them for securityfs and
apparmourfs, since normal users have no way to remove any files from
them, so the race with final unlink sounds fairly irrelevant in
practice, no?

               Linus
