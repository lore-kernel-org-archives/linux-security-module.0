Return-Path: <SRS0=/FKR=AT=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91621C433E0
	for <linux-security-module@archiver.kernel.org>; Wed,  8 Jul 2020 05:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EF0C20774
	for <linux-security-module@archiver.kernel.org>; Wed,  8 Jul 2020 05:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594185635;
	bh=1wVO9BE1cY6w1JAMPSgKs3c9xVqeEHUNeFiQCCL3mwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=h0/2GgN56fIfhC2T49RO/snEtw5p5yqBIH8KPb5TeEwOIr4KAAItbbZYVEAe3ZihY
	 bYEiEhlgN/0GZ6zIVLE0Egxg3EszMTb14vZCuayKML3/361KNESOgDsFbJUF3C5qwu
	 vATcjcd1RX5eb8uL0Y7tmq7xrRREVdxiX+YlUJzI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbgGHFUb (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 8 Jul 2020 01:20:31 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38870 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbgGHFUb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 8 Jul 2020 01:20:31 -0400
Received: by mail-pl1-f195.google.com with SMTP id d10so17692342pls.5;
        Tue, 07 Jul 2020 22:20:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mHvv1akSeMcW+d6BM9EuxicMsI99taf4NpplA/oKL1o=;
        b=KMFoKbnyoePxQFA3rnyFJ3zeD5rtutHt6+jC0y9bRWwTdN/ktAVFBUIec+0s5kU18J
         i5KpdCz27haaPe9myp+JXs7PbJxijKFzFhPtZkHLq7/9YWrsJxtxwMY27mr7vI9SKcHs
         /mwoN76UBRwwICd9e1MC39Hof8i19+Y/UZoCqXCr67N+u+rAtsvH34ZbCZPOpHcR0Bt8
         BuYnf2Cdr7TyTTeeIT6NH5VI4A62X1GRrzrx0MrHTTtc4ClTrgtoI6UV0wsPdUswS+zv
         eyV9KD0EsK2+eHPAleumCBO+jfCqFw7je/yf0Lt5Lp4inE3Phx+pqrOjdLROQuwOysKP
         r/rg==
X-Gm-Message-State: AOAM5338rSQ4MybTDF8XQEgzP//lCmtzDh2GLK20KIp4OXOHBrrrny9k
        a1eZVAWyZTdjhMeyHzq0RVw=
X-Google-Smtp-Source: ABdhPJyUtlGzmjKuYw2anwU6VZKAJzkXHMyJZbFUQtGLl++AohBG0jXwWNT+2io4N3hckgnkQtYmRA==
X-Received: by 2002:a17:902:bb93:: with SMTP id m19mr47969475pls.137.1594185630550;
        Tue, 07 Jul 2020 22:20:30 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id u26sm2607618pgo.71.2020.07.07.22.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 22:20:29 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id D0978400DB; Wed,  8 Jul 2020 05:20:28 +0000 (UTC)
Date:   Wed, 8 Jul 2020 05:20:28 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <greg@kroah.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 00/15] Make the user mode driver code a better citizen
Message-ID: <20200708052028.GB4332@42.do-not-panic.com>
References: <20200625095725.GA3303921@kroah.com>
 <778297d2-512a-8361-cf05-42d9379e6977@i-love.sakura.ne.jp>
 <20200625120725.GA3493334@kroah.com>
 <20200625.123437.2219826613137938086.davem@davemloft.net>
 <CAHk-=whuTwGHEPjvtbBvneHHXeqJC=q5S09mbPnqb=Q+MSPMag@mail.gmail.com>
 <87pn9mgfc2.fsf_-_@x220.int.ebiederm.org>
 <87y2oac50p.fsf@x220.int.ebiederm.org>
 <87bll17ili.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bll17ili.fsf_-_@x220.int.ebiederm.org>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jun 29, 2020 at 02:55:05PM -0500, Eric W. Biederman wrote:
> 
> I have tested thes changes by booting with the code compiled in and
> by killing "bpfilter_umh" and running iptables -vnL to restart
> the userspace driver.
> 
> I have compiled tested each change with and without CONFIG_BPFILTER
> enabled.

Sounds like grounds for a selftests driver and respective selftest?
And if so, has the other issues Tetsuo reported be hacked into one?

  Luis
