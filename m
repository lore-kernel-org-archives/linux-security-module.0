Return-Path: <SRS0=XWg0=XT=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA87C432C1
	for <linux-security-module@archiver.kernel.org>; Tue, 24 Sep 2019 00:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B47FB20644
	for <linux-security-module@archiver.kernel.org>; Tue, 24 Sep 2019 00:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569285955;
	bh=G5+n0yTeI262hOAqLd2UKRmaptJSB1DKaIWuBFAS7GA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=VrMBwYQmNnKJ2VnO0xVqTPoVDTxsXCEH8tDHsfUKXPezeo9NVd+Lzh5A/y+vUmaLo
	 t8jdJ9qi5fnHUXudjMoFCefdE8Uicbra3BNS84ta+oYuswQSkRyalXmqw//qDOqYVW
	 ZvYrcUrl16H3HOF+hhGhJ36lIaZUvt1hRQMG4TcA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbfIXApy (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 23 Sep 2019 20:45:54 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:32822 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503682AbfIXApy (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 23 Sep 2019 20:45:54 -0400
Received: by mail-lf1-f66.google.com with SMTP id y127so16386lfc.0
        for <linux-security-module@vger.kernel.org>; Mon, 23 Sep 2019 17:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a6k/LKVxsjSrT2CO9Xt89a9E4se+ppAiNrE8ucF5Ejw=;
        b=L+OR0BsYjfCj/RTtWXae8fv9HttOeT/9/bi9Qlqfz3vbAuXLMeeyN2fkkbOU1woIpZ
         og+vDrY2YkQY9xXuyogHE8PzKTuoY7kEGyoTdzNoYLWsuWGfGVJw8tu2XtcH+Qprgx3/
         Ys5ep4nXuOY3NhTlQqyoJ8oFmqEv4HYcd+Yg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a6k/LKVxsjSrT2CO9Xt89a9E4se+ppAiNrE8ucF5Ejw=;
        b=DL7Su7zIwxY0Z/DD7A9Xtjl6nrwJ4+XXeammU+WNInSWipn+ckkKRP9WzeS+zw586F
         aGqgEahk28lYyOG0GdmgjglIK/sKh7z7kFrNU2UEu3nDlAF1JCYhORqf10rKQSZFVS0v
         9DP5BJa42k8Ylce1UgZAE1JJbc+MyPxKC50izMWmk+cAyaajUzv6uo1YYei56Befu3L4
         F9ovI+yJ2JDNaGDwjNay72QH5RD7r3ITUwDyw8k0FitXZ4tnnw4p93//ccSsMkE38IcS
         77F+kL7m1RoDW26iRiSASVQwHYwTSk0qkHZfUp7HIKlSIPP9mUV2muhoF0eDvc8ySPQW
         5+Vg==
X-Gm-Message-State: APjAAAX5DrN/m38wFazdAWgLY914CQa4k4XFCXm8EoSYZIBRpdWq7oQ8
        7x6oxLpaTtP3VRuaywcWYseaWmxE7G4=
X-Google-Smtp-Source: APXvYqwfk2j29dyoeP+lTZ5gTcNrEggRgyZWvf5DIt1TUJNJQa4VSrH5HFZVaaWtSxtbRZBrbT+3NQ==
X-Received: by 2002:ac2:4945:: with SMTP id o5mr15482lfi.70.1569285950363;
        Mon, 23 Sep 2019 17:45:50 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id t16sm52442lfp.38.2019.09.23.17.45.49
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 17:45:49 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id m13so40961ljj.11
        for <linux-security-module@vger.kernel.org>; Mon, 23 Sep 2019 17:45:49 -0700 (PDT)
X-Received: by 2002:a2e:5b9a:: with SMTP id m26mr37812lje.90.1569285948983;
 Mon, 23 Sep 2019 17:45:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ-EccM49yBA+xgkR+3m5pEAJqmH_+FxfuAjijrQxaxxMUAt3Q@mail.gmail.com>
 <CAHk-=wiAsJLw1egFEE=Z7-GGtM6wcvtyytXZA1+BHqta4gg6Hw@mail.gmail.com>
 <CAHk-=wh_CHD9fQOyF6D2q3hVdAhFOmR8vNzcq5ZPcxKW3Nc+2Q@mail.gmail.com> <alpine.LRH.2.21.1909231633400.54130@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.inter>
In-Reply-To: <alpine.LRH.2.21.1909231633400.54130@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.inter>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 23 Sep 2019 17:45:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh4cuHsE8jFHO7XVatdXa=M2f4RHL3VwnSkAf5UNHUJ-Q@mail.gmail.com>
Message-ID: <CAHk-=wh4cuHsE8jFHO7XVatdXa=M2f4RHL3VwnSkAf5UNHUJ-Q@mail.gmail.com>
Subject: Re: [GIT PULL] SafeSetID LSM changes for 5.4
To:     James Morris <jamorris@linuxonhyperv.com>
Cc:     Micah Morton <mortonm@chromium.org>, Jann Horn <jannh@google.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Sep 23, 2019 at 4:35 PM James Morris <jamorris@linuxonhyperv.com> wrote:
>
> My understanding is that SafeSetID is shipping in ChromeOS -- this was
> part of the rationale for merging it.

Well, if even the developer didn't test it for two months, I don't
think "it's in upstream" makes any sense or difference.

                     Linus
