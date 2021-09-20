Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382F2C433EF
	for <linux-security-module@archiver.kernel.org>; Tue, 21 Sep 2021 02:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 279A961183
	for <linux-security-module@archiver.kernel.org>; Tue, 21 Sep 2021 02:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236815AbhIUCYH (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 20 Sep 2021 22:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236789AbhIUBv3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 20 Sep 2021 21:51:29 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A40DC0DBA95
        for <linux-security-module@vger.kernel.org>; Mon, 20 Sep 2021 15:35:14 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id b15so55397490lfe.7
        for <linux-security-module@vger.kernel.org>; Mon, 20 Sep 2021 15:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rWF92uKc1LzFq2JEnuimzPeetS03NUACyk3IwwBjnZM=;
        b=5qxzf1sqagKZS3VKwgdySBkF4aEAhj8QKzoZV+5Rq+RNEdV9/9gJUyWr02smDUNn8m
         RUWMPOowUB70Z1jM0dUYEyrKiMXrj4g/6TRkCHCefJ0xU55OMz7gaLFlvspy8WCD3/iv
         HlGCnWBkbJml/tRs4h2PVY5pqMaziV2hA5UeT7Ot/nR7Z7rhxPnRLJaSO3wEK0605xVN
         WTqlhP1YzOdcu3aUW/bmHmX6kkBry6eR++0F1/C1SM1rAAq/U5w25VqplMtzfAgottkX
         i49TsPnizAOm0Kt85VqiHnglZHwaVA9/i30OmTYSWS7NYRwayOLAJhJrclRYv0zDYgE8
         h7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rWF92uKc1LzFq2JEnuimzPeetS03NUACyk3IwwBjnZM=;
        b=x+4yIXbtZqpwM/8IhaF8Zno45jWPd26IqvnElmGiUlSISY++OyT1afogK/3+eIgg22
         +yQh/W2f9npHaPj/6GtqM0wSZIstS1qGdGao/PGCWWfWwdy1lPvbUR6AK2tdn6pJDLmp
         bIpxYwwuBVT3lc7NuzLtFddVtGYfkwcIzXlCY31GgpnpWU006WqDO5pJKDeTn3nszk9v
         kKtP7at8wUFCKthN8E3RbNAq+Q+lXKyBqEjQEpsGhag2vv1ABLT6LOJSXwhY+LstDBtw
         pZDRq6ODFQwomcOhEiPwyUrvxsvZTZLLemhf+wM+Zuwyk5gTX38xo+MT6iwcqy5oiChA
         TPnQ==
X-Gm-Message-State: AOAM530fxfX+4NRPuix6zY+pKeSmqoqFvnJE+3NKJvBXMT4okhpCbM0S
        VHyTs+aFfiQF86gS7gjY/DPXms8ChDn1/NasUl5IJQ==
X-Google-Smtp-Source: ABdhPJzf2RH/GjVb/y3cBDlOO0/0/OpDrFHmGrZ6KWoaiMVCXfKepuuVNbJSpqbcWaDy/nzjiYx38b6Yly50tTZ3djw=
X-Received: by 2002:a05:6512:a8d:: with SMTP id m13mr13408817lfu.427.1632177312251;
 Mon, 20 Sep 2021 15:35:12 -0700 (PDT)
MIME-Version: 1.0
References: <a507efa7-066b-decf-8605-89cdb0ac1951.ref@schaufler-ca.com>
 <a507efa7-066b-decf-8605-89cdb0ac1951@schaufler-ca.com> <CAHC9VhR9SKX_-SAmtcCj+vuUvcdq-SWzKs86BKMjBcC8GhJ1gg@mail.gmail.com>
 <dd58bbf5-7983-ca26-c335-6bf8e492fcaa@schaufler-ca.com>
In-Reply-To: <dd58bbf5-7983-ca26-c335-6bf8e492fcaa@schaufler-ca.com>
From:   "Jiang Wang ." <jiang.wang@bytedance.com>
Date:   Mon, 20 Sep 2021 15:35:01 -0700
Message-ID: <CAP_N_Z9iCP_xNNNSRVEzgGER7Zg+bb_nROzBUct=V6UyWn1P5A@mail.gmail.com>
Subject: Re: Re: Regression in unix stream sockets with the Smack LSM
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        John Fastabend <john.fastabend@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Sep 15, 2021 at 9:52 AM Casey Schaufler <casey@schaufler-ca.com> wr=
ote:
>
> On 9/13/2021 4:47 PM, Paul Moore wrote:
> > On Mon, Sep 13, 2021 at 6:53 PM Casey Schaufler <casey@schaufler-ca.com=
> wrote:
> >> Commit 77462de14a43f4d98dbd8de0f5743a4e02450b1d
> >>
> >>         af_unix: Add read_sock for stream socket types
> >>
> >> introduced a regression in UDS socket connections for the Smack LSM.
> >> I have not tracked done the details of why the change broke the code,
> >> but this is where bisecting the kernel indicates the problem lies, and
> >> I have verified that reverting this change repairs the problem.
> >>
> >> You can verify the problem with the Smack test suite:
> >>
> >>         https://github.com/smack-team/smack-testsuite.git
> >>
> >> The failing test is tests/uds-access.sh.
> >>
I tried to reproduce with tests/uds-access.sh, but the first two test
cases always failed. I tried different kernels with and without my
unix-stream sockmap patches. Also tried standard debian 4.19
kernel and they all have the same result.  What distro did you use? centos?
Fedora? Have you tested on debian based distros?
failing log:
root@gitlab-runner-stretch:~/smack-testsuite# tests/uds-access.sh -v
mkdir: cannot create directory =E2=80=98./targets/uds-notroot=E2=80=99: Fil=
e exists
tests/uds-access.sh:71 FAIL
tests/uds-access.sh:76 FAIL
tests/uds-access.sh:81 PASS
tests/uds-access.sh:86 PASS
tests/uds-access.sh:91 PASS
tests/uds-access.sh PASS=3D3 FAIL=3D2
root@gitlab-runner-stretch:~/smack-testsuite# uname -a
Linux gitlab-runner-stretch 5.14.0-rc5.bm.1-amd64+ #6 SMP Mon Sep 20
22:01:10 UTC 2021 x86_64 GNU/Linux
root@gitlab-runner-stretch:~/smack-testsuite#

> >> I have not looked to see if there's a similar problem with SELinux.
> >> There may be, but if there isn't it doesn't matter, there's still a
> >> bug.
> > FWIW, the selinux-testsuite tests ran clean today with v5.15-rc1 (it
> > looks like this code is only in v5.15) but as Casey said, a regression
> > is a regression.
> >
> > Casey, what actually fails on the Smack system with this commit?
>
> This problem occurs with security=3Dnone as well as with security=3Dsmack=
.
>
> There isn't a problem with connect, that always works correctly.
> The problem is an unexpected read() failure in the connecting process.
> This doesn't occur all the time, and sometimes happens in the first
> of my two tests, sometimes the second, sometimes neither and, you guessed
> it, sometimes both.
>
> Here's a sample socat log demonstrating the problem. The first run,
> ending at "uds-access RC=3D0" behaves as expected. The second, ending
> at "uds-access RC=3D1", demonstrates the read failure. This case was
I tried to compare logs between RC=3D0 and RC=3D1, but they look  to me
not apple to apple comparison? The read syscall have different parameters
and the syscall sequences are different. I am not sure which syscall
is the first failure.  See more comments below.

> run with Smack enabled, but I see the same problem with the same
> unpredictability on the same kernel with security=3Dnone.
>
> I've tried to convince myself that there's a flaw in the way I've
> set up the scripts. They've been pretty robust and I've never seen
> socat behaving erratically before. I've instrumented the kernel
> code and all the security checks are behaving as expected. Plus,
> as I mentioned above, the problem also occurs without an LSM.
>
> 2021/09/15 08:49:50 socat[2215] D getpid()
> 2021/09/15 08:49:50 socat[2215] D getpid() -> 2215
> 2021/09/15 08:49:50 socat[2215] D setenv("SOCAT_PID", "2215", 1)
> 2021/09/15 08:49:50 socat[2215] D setenv() -> 0
> 2021/09/15 08:49:50 socat[2215] D setenv("SOCAT_PPID", "2215", 1)
> 2021/09/15 08:49:50 socat[2215] D setenv() -> 0
> 2021/09/15 08:49:50 socat[2215] I socat by Gerhard Rieger and contributor=
s - see www.dest-unreach.org
> 2021/09/15 08:49:50 socat[2215] I This product includes software develope=
d by the OpenSSL Project for use in the OpenSSL Toolkit. (http://www.openss=
l.org/)
> 2021/09/15 08:49:50 socat[2215] I This product includes software written =
by Tim Hudson (tjh@cryptsoft.com)
> 2021/09/15 08:49:50 socat[2215] D socat version 1.7.4.1 on Jan 27 2021 00=
:00:00
> 2021/09/15 08:49:50 socat[2215] D setenv("SOCAT_VERSION", "1.7.4.1", 1)
> 2021/09/15 08:49:50 socat[2215] D setenv() -> 0
> 2021/09/15 08:49:50 socat[2215] D running on Linux version #58 SMP Wed Se=
p 15 08:40:38 PDT 2021, release 5.15.0-rc1bisect, machine x86_64
>
> 2021/09/15 08:49:50 socat[2215] D argv[0]: "socat"
> 2021/09/15 08:49:50 socat[2215] D argv[1]: "-d"
> 2021/09/15 08:49:50 socat[2215] D argv[2]: "-d"
> 2021/09/15 08:49:50 socat[2215] D argv[3]: "-d"
> 2021/09/15 08:49:50 socat[2215] D argv[4]: "-d"
> 2021/09/15 08:49:50 socat[2215] D argv[5]: "-"
> 2021/09/15 08:49:50 socat[2215] D argv[6]: "UNIX-CONNECT:./targets/uds-no=
troot/uds-access-socket"
> 2021/09/15 08:49:50 socat[2215] D sigaction(1, 0x7fffaec50b50, 0x0)
> 2021/09/15 08:49:50 socat[2215] D sigaction() -> 0
> 2021/09/15 08:49:50 socat[2215] D sigaction(2, 0x7fffaec50b50, 0x0)
> 2021/09/15 08:49:50 socat[2215] D sigaction() -> 0
> 2021/09/15 08:49:50 socat[2215] D sigaction(3, 0x7fffaec50b50, 0x0)
> 2021/09/15 08:49:50 socat[2215] D sigaction() -> 0
> 2021/09/15 08:49:50 socat[2215] D sigaction(4, 0x7fffaec50b50, 0x0)
> 2021/09/15 08:49:50 socat[2215] D sigaction() -> 0
> 2021/09/15 08:49:50 socat[2215] D sigaction(6, 0x7fffaec50b50, 0x0)
> 2021/09/15 08:49:50 socat[2215] D sigaction() -> 0
> 2021/09/15 08:49:50 socat[2215] D sigaction(7, 0x7fffaec50b50, 0x0)
> 2021/09/15 08:49:50 socat[2215] D sigaction() -> 0
> 2021/09/15 08:49:50 socat[2215] D sigaction(8, 0x7fffaec50b50, 0x0)
> 2021/09/15 08:49:50 socat[2215] D sigaction() -> 0
> 2021/09/15 08:49:50 socat[2215] D sigaction(11, 0x7fffaec50b50, 0x0)
> 2021/09/15 08:49:50 socat[2215] D sigaction() -> 0
> 2021/09/15 08:49:50 socat[2215] D sigaction(15, 0x7fffaec50b50, 0x0)
> 2021/09/15 08:49:50 socat[2215] D sigaction() -> 0
> 2021/09/15 08:49:50 socat[2215] D signal(13, 0x1)
> 2021/09/15 08:49:50 socat[2215] D signal() -> 0x0
> 2021/09/15 08:49:50 socat[2215] D atexit(0x55aa5d645110)
> 2021/09/15 08:49:50 socat[2215] D atexit() -> 0
> 2021/09/15 08:49:50 socat[2215] D xioopen("-")
> 2021/09/15 08:49:50 socat[2215] D calloc(1, 824)
> 2021/09/15 08:49:50 socat[2215] D calloc() -> 0x55aa5f0139d0
> 2021/09/15 08:49:50 socat[2215] D malloc(1024)
> 2021/09/15 08:49:50 socat[2215] D malloc() -> 0x55aa5f013d30
> 2021/09/15 08:49:50 socat[2215] D calloc(1, 824)
> 2021/09/15 08:49:50 socat[2215] D calloc() -> 0x55aa5f014140
> 2021/09/15 08:49:50 socat[2215] D calloc(1, 824)
> 2021/09/15 08:49:50 socat[2215] D calloc() -> 0x55aa5f014bc0
> 2021/09/15 08:49:50 socat[2215] D isatty(0)
> 2021/09/15 08:49:50 socat[2215] D isatty() -> 0
> 2021/09/15 08:49:50 socat[2215] D isatty(1)
> 2021/09/15 08:49:50 socat[2215] D isatty() -> 0
> 2021/09/15 08:49:50 socat[2215] D malloc(128)
> 2021/09/15 08:49:50 socat[2215] D malloc() -> 0x55aa5f014f00
> 2021/09/15 08:49:50 socat[2215] D malloc(128)
> 2021/09/15 08:49:50 socat[2215] D malloc() -> 0x55aa5f014f90
> 2021/09/15 08:49:50 socat[2215] N reading from and writing to stdio
> 2021/09/15 08:49:50 socat[2215] D xioopen("UNIX-CONNECT:./targets/uds-not=
root/uds-access-socket")
> 2021/09/15 08:49:50 socat[2215] D calloc(1, 824)
> 2021/09/15 08:49:50 socat[2215] D calloc() -> 0x55aa5f015020
> 2021/09/15 08:49:50 socat[2215] D malloc(1024)
> 2021/09/15 08:49:50 socat[2215] D malloc() -> 0x55aa5f015360
> 2021/09/15 08:49:50 socat[2215] D malloc(128)
> 2021/09/15 08:49:50 socat[2215] D malloc() -> 0x55aa5f015770
> 2021/09/15 08:49:50 socat[2215] N opening connection to AF=3D1 "./targets=
/uds-notroot/uds-access-socket"
> 2021/09/15 08:49:50 socat[2215] D socket(1, 1, 0)
> 2021/09/15 08:49:50 socat[2215] I socket(1, 1, 0) -> 5
> 2021/09/15 08:49:50 socat[2215] D fcntl(5, 2, 1)
> 2021/09/15 08:49:50 socat[2215] D fcntl() -> 0
> 2021/09/15 08:49:50 socat[2215] D connect(5, {1,AF=3D1 "./targets/uds-not=
root/uds-access-socket"}, 41)
> 2021/09/15 08:49:50 socat[2215] D connect() -> 0
> 2021/09/15 08:49:50 socat[2215] D getsockname(5, 0x7fffaec50580, 0x7fffae=
c50564{112})
> 2021/09/15 08:49:50 socat[2215] D getsockname(, {AF=3D1 "<anon>"}, {2}) -=
> 0
> 2021/09/15 08:49:50 socat[2215] N successfully connected from local addre=
ss AF=3D1 "uds-notroot/ud\xEE\xEE\xEE\xEEcess-socket")\n"
> 2021/09/15 08:49:50 socat[2215] I resolved and opened all sock addresses
> 2021/09/15 08:49:50 socat[2215] D posix_memalign(0x7fffaec50b28, 4096, 16=
385)
> 2021/09/15 08:49:50 socat[2215] D posix_memalign(...) -> 0
> 2021/09/15 08:49:50 socat[2215] N starting data transfer loop with FDs [0=
,1] and [5,5]
> 2021/09/15 08:49:50 socat[2215] D data loop: sock1->eof=3D0, sock2->eof=
=3D0, closing=3D0, wasaction=3D1, total_to=3D{0.000000}
> 2021/09/15 08:49:50 socat[2215] D select(6, &0x21, &0x22, &0x0, NULL/0.00=
0000)
> 2021/09/15 08:49:50 socat[2215] D select -> (, 0x21, 0x22, 0x0, NULL/0.00=
0000), 4
> 2021/09/15 08:49:50 socat[2215] D read(0, 0x55aa5f016000, 8192)
> 2021/09/15 08:49:50 socat[2215] D read -> 4
> 2021/09/15 08:49:50 socat[2215] D write(5, 0x55aa5f016000, 4)
> Pop
> 2021/09/15 08:49:50 socat[2215] D write -> 4
> 2021/09/15 08:49:50 socat[2215] I transferred 4 bytes from 0 to 5
> 2021/09/15 08:49:50 socat[2215] D read(5, 0x55aa5f016000, 8192)
> 2021/09/15 08:49:50 socat[2215] D read -> 4
> 2021/09/15 08:49:50 socat[2215] D write(1, 0x55aa5f016000, 4)
> Pop
> 2021/09/15 08:49:50 socat[2215] D write -> 4
> 2021/09/15 08:49:50 socat[2215] I transferred 4 bytes from 5 to 1
> 2021/09/15 08:49:50 socat[2215] D data loop: sock1->eof=3D0, sock2->eof=
=3D0, closing=3D0, wasaction=3D1, total_to=3D{0.000000}
> 2021/09/15 08:49:50 socat[2215] D select(6, &0x21, &0x22, &0x0, NULL/0.00=
0000)
> 2021/09/15 08:49:50 socat[2215] D select -> (, 0x21, 0x22, 0x0, NULL/0.00=
0000), 4
> 2021/09/15 08:49:50 socat[2215] D read(0, 0x55aa5f016000, 8192)
> 2021/09/15 08:49:50 socat[2215] D read -> 0
> 2021/09/15 08:49:50 socat[2215] D read(5, 0x55aa5f016000, 8192)
> 2021/09/15 08:49:50 socat[2215] D read -> 0
> 2021/09/15 08:49:50 socat[2215] N socket 1 (fd 0) is at EOF
> 2021/09/15 08:49:50 socat[2215] I shutdown(5, 1)
> 2021/09/15 08:49:50 socat[2215] D shutdown()  -> 0
> 2021/09/15 08:49:50 socat[2215] N socket 2 (fd 5) is at EOF
> 2021/09/15 08:49:50 socat[2215] I shutdown(5, 2)
> 2021/09/15 08:49:50 socat[2215] D shutdown()  -> 0
> 2021/09/15 08:49:50 socat[2215] N exiting with status 0
> 2021/09/15 08:49:50 socat[2215] D exit(0)
> 2021/09/15 08:49:50 socat[2215] D starting xioexit()
> 2021/09/15 08:49:50 socat[2215] D finished xioexit()
> uds-access RC=3D0
> 2021/09/15 08:49:52 socat[2240] D getpid()
> 2021/09/15 08:49:52 socat[2240] D getpid() -> 2240
> 2021/09/15 08:49:52 socat[2240] D setenv("SOCAT_PID", "2240", 1)
> 2021/09/15 08:49:52 socat[2240] D setenv() -> 0
> 2021/09/15 08:49:52 socat[2240] D setenv("SOCAT_PPID", "2240", 1)
> 2021/09/15 08:49:52 socat[2240] D setenv() -> 0
> 2021/09/15 08:49:52 socat[2240] I socat by Gerhard Rieger and contributor=
s - see www.dest-unreach.org
> 2021/09/15 08:49:52 socat[2240] I This product includes software develope=
d by the OpenSSL Project for use in the OpenSSL Toolkit. (http://www.openss=
l.org/)
> 2021/09/15 08:49:52 socat[2240] I This product includes software written =
by Tim Hudson (tjh@cryptsoft.com)
> 2021/09/15 08:49:52 socat[2240] D socat version 1.7.4.1 on Jan 27 2021 00=
:00:00
> 2021/09/15 08:49:52 socat[2240] D setenv("SOCAT_VERSION", "1.7.4.1", 1)
> 2021/09/15 08:49:52 socat[2240] D setenv() -> 0
> 2021/09/15 08:49:52 socat[2240] D running on Linux version #58 SMP Wed Se=
p 15 08:40:38 PDT 2021, release 5.15.0-rc1bisect, machine x86_64
>
> 2021/09/15 08:49:52 socat[2240] D argv[0]: "socat"
> 2021/09/15 08:49:52 socat[2240] D argv[1]: "-d"
> 2021/09/15 08:49:52 socat[2240] D argv[2]: "-d"
> 2021/09/15 08:49:52 socat[2240] D argv[3]: "-d"
> 2021/09/15 08:49:52 socat[2240] D argv[4]: "-d"
> 2021/09/15 08:49:52 socat[2240] D argv[5]: "-"
> 2021/09/15 08:49:52 socat[2240] D argv[6]: "UNIX-CONNECT:./targets/uds-no=
troot/uds-access-socket"
> 2021/09/15 08:49:52 socat[2240] D sigaction(1, 0x7ffcca7e26c0, 0x0)
> 2021/09/15 08:49:52 socat[2240] D sigaction() -> 0
> 2021/09/15 08:49:52 socat[2240] D sigaction(2, 0x7ffcca7e26c0, 0x0)
> 2021/09/15 08:49:52 socat[2240] D sigaction() -> 0
> 2021/09/15 08:49:52 socat[2240] D sigaction(3, 0x7ffcca7e26c0, 0x0)
> 2021/09/15 08:49:52 socat[2240] D sigaction() -> 0
> 2021/09/15 08:49:52 socat[2240] D sigaction(4, 0x7ffcca7e26c0, 0x0)
> 2021/09/15 08:49:52 socat[2240] D sigaction() -> 0
> 2021/09/15 08:49:52 socat[2240] D sigaction(6, 0x7ffcca7e26c0, 0x0)
> 2021/09/15 08:49:52 socat[2240] D sigaction() -> 0
> 2021/09/15 08:49:52 socat[2240] D sigaction(7, 0x7ffcca7e26c0, 0x0)
> 2021/09/15 08:49:52 socat[2240] D sigaction() -> 0
> 2021/09/15 08:49:52 socat[2240] D sigaction(8, 0x7ffcca7e26c0, 0x0)
> 2021/09/15 08:49:52 socat[2240] D sigaction() -> 0
> 2021/09/15 08:49:52 socat[2240] D sigaction(11, 0x7ffcca7e26c0, 0x0)
> 2021/09/15 08:49:52 socat[2240] D sigaction() -> 0
> 2021/09/15 08:49:52 socat[2240] D sigaction(15, 0x7ffcca7e26c0, 0x0)
> 2021/09/15 08:49:52 socat[2240] D sigaction() -> 0
> 2021/09/15 08:49:52 socat[2240] D signal(13, 0x1)
> 2021/09/15 08:49:52 socat[2240] D signal() -> 0x0
> 2021/09/15 08:49:52 socat[2240] D atexit(0x560590a15110)
> 2021/09/15 08:49:52 socat[2240] D atexit() -> 0
> 2021/09/15 08:49:52 socat[2240] D xioopen("-")
> 2021/09/15 08:49:52 socat[2240] D calloc(1, 824)
> 2021/09/15 08:49:52 socat[2240] D calloc() -> 0x560591e899d0
> 2021/09/15 08:49:52 socat[2240] D malloc(1024)
> 2021/09/15 08:49:52 socat[2240] D malloc() -> 0x560591e89d30
> 2021/09/15 08:49:52 socat[2240] D calloc(1, 824)
> 2021/09/15 08:49:52 socat[2240] D calloc() -> 0x560591e8a140
> 2021/09/15 08:49:52 socat[2240] D calloc(1, 824)
> 2021/09/15 08:49:52 socat[2240] D calloc() -> 0x560591e8abc0
> 2021/09/15 08:49:52 socat[2240] D isatty(0)
> 2021/09/15 08:49:52 socat[2240] D isatty() -> 0
> 2021/09/15 08:49:52 socat[2240] D isatty(1)
> 2021/09/15 08:49:52 socat[2240] D isatty() -> 0
> 2021/09/15 08:49:52 socat[2240] D malloc(128)
> 2021/09/15 08:49:52 socat[2240] D malloc() -> 0x560591e8af00
> 2021/09/15 08:49:52 socat[2240] D malloc(128)
> 2021/09/15 08:49:52 socat[2240] D malloc() -> 0x560591e8af90
> 2021/09/15 08:49:52 socat[2240] N reading from and writing to stdio
> 2021/09/15 08:49:52 socat[2240] D xioopen("UNIX-CONNECT:./targets/uds-not=
root/uds-access-socket")
> 2021/09/15 08:49:52 socat[2240] D calloc(1, 824)
> 2021/09/15 08:49:52 socat[2240] D calloc() -> 0x560591e8b020
> 2021/09/15 08:49:52 socat[2240] D malloc(1024)
> 2021/09/15 08:49:52 socat[2240] D malloc() -> 0x560591e8b360
> 2021/09/15 08:49:52 socat[2240] D malloc(128)
> 2021/09/15 08:49:52 socat[2240] D malloc() -> 0x560591e8b770
> 2021/09/15 08:49:52 socat[2240] N opening connection to AF=3D1 "./targets=
/uds-notroot/uds-access-socket"
> 2021/09/15 08:49:52 socat[2240] D socket(1, 1, 0)
> 2021/09/15 08:49:52 socat[2240] I socket(1, 1, 0) -> 5
> 2021/09/15 08:49:52 socat[2240] D fcntl(5, 2, 1)
> 2021/09/15 08:49:52 socat[2240] D fcntl() -> 0
> 2021/09/15 08:49:52 socat[2240] D connect(5, {1,AF=3D1 "./targets/uds-not=
root/uds-access-socket"}, 41)
> 2021/09/15 08:49:52 socat[2240] D connect() -> 0
> 2021/09/15 08:49:52 socat[2240] D getsockname(5, 0x7ffcca7e20f0, 0x7ffcca=
7e20d4{112})
> 2021/09/15 08:49:52 socat[2240] D getsockname(, {AF=3D1 "<anon>"}, {2}) -=
> 0
> 2021/09/15 08:49:52 socat[2240] N successfully connected from local addre=
ss AF=3D1 "uds-notroot/ud\xEE\xEE\xEE\xEEcess-socket")\n"
> 2021/09/15 08:49:52 socat[2240] I resolved and opened all sock addresses
> 2021/09/15 08:49:52 socat[2240] D posix_memalign(0x7ffcca7e2698, 4096, 16=
385)
> 2021/09/15 08:49:52 socat[2240] D posix_memalign(...) -> 0
> 2021/09/15 08:49:52 socat[2240] N starting data transfer loop with FDs [0=
,1] and [5,5]
> 2021/09/15 08:49:52 socat[2240] D data loop: sock1->eof=3D0, sock2->eof=
=3D0, closing=3D0, wasaction=3D1, total_to=3D{0.000000}
> 2021/09/15 08:49:52 socat[2240] D select(6, &0x21, &0x22, &0x0, NULL/0.00=
0000)
> 2021/09/15 08:49:52 socat[2240] D select -> (, 0x1, 0x22, 0x0, NULL/0.000=
000), 3
> 2021/09/15 08:49:52 socat[2240] D read(0, 0x560591e8c000, 8192)
> 2021/09/15 08:49:52 socat[2240] D read -> 5
> 2021/09/15 08:49:52 socat[2240] D write(5, 0x560591e8c000, 5)
> 2021/09/15 08:49:52 socat[2240] D write -> 5
> 2021/09/15 08:49:52 socat[2240] I transferred 5 bytes from 0 to 5
> 2021/09/15 08:49:52 socat[2240] D data loop: sock1->eof=3D0, sock2->eof=
=3D0, closing=3D0, wasaction=3D1, total_to=3D{0.000000}
> 2021/09/15 08:49:52 socat[2240] D select(6, &0x21, &0x20, &0x0, NULL/0.00=
0000)
> 2021/09/15 08:49:52 socat[2240] D select -> (, 0x1, 0x20, 0x0, NULL/0.000=
000), 2
> 2021/09/15 08:49:52 socat[2240] D read(0, 0x560591e8c000, 8192)
> 2021/09/15 08:49:52 socat[2240] D read -> 0
> 2021/09/15 08:49:52 socat[2240] N socket 1 (fd 0) is at EOF
> 2021/09/15 08:49:52 socat[2240] I shutdown(5, 1)
> 2021/09/15 08:49:52 socat[2240] D shutdown()  -> 0
Is this shutdown expected?

> 2021/09/15 08:49:52 socat[2240] D data loop: sock1->eof=3D3, sock2->eof=
=3D0, closing=3D1, wasaction=3D1, total_to=3D{0.000000}
> 2021/09/15 08:49:52 socat[2240] D select(6, &0x20, &0x0, &0x0, &0.500000)
> Snap
> 2021/09/15 08:49:52 socat[2240] D select -> (, 0x20, 0x0, 0x0, &0.500000)=
, 1
> 2021/09/15 08:49:52 socat[2240] D read(5, 0x560591e8c000, 8192)
> 2021/09/15 08:49:52 socat[2240] D read -> -1
This read failure seems due to the previous shutdown, right?

> 2021/09/15 08:49:52 socat[2240] E read(5, 0x560591e8c000, 8192): Invalid =
argument
> 2021/09/15 08:49:52 socat[2240] N exit(1)
> 2021/09/15 08:49:52 socat[2240] D starting xioexit()
> 2021/09/15 08:49:52 socat[2240] I shutdown(5, 2)
> 2021/09/15 08:49:52 socat[2240] D shutdown()  -> 0
> 2021/09/15 08:49:52 socat[2240] D finished xioexit()
> uds-access RC=3D1
>
>
>
>
