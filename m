Return-Path: <SRS0=4lEG=AM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE2BC433DF
	for <linux-security-module@archiver.kernel.org>; Wed,  1 Jul 2020 12:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8C5F206CB
	for <linux-security-module@archiver.kernel.org>; Wed,  1 Jul 2020 12:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593606034;
	bh=N13ZLGUJaht5n5gmpWlI3C9ZD1c4CH4SnSBG9Qt4LeU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=P3lNy4xc5hLRY0IPPbkVh8y81R1/ylPYhIEYetFTbmy5hWtrkM/cvYWFjkgIhAs0J
	 jiutpi3RPB4m5mUv5Whz6IaSI6S/6h2BWFG2S97/RylNTPPK3uMiobVpklrhYwaf47
	 yzPRjuy1RYWDYl5ssg3D5AqRiFAxpORgwHYQwdjg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730422AbgGAMUe (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 1 Jul 2020 08:20:34 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:55897 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730063AbgGAMUd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 1 Jul 2020 08:20:33 -0400
Received: by mail-pj1-f68.google.com with SMTP id a9so505734pjh.5;
        Wed, 01 Jul 2020 05:20:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VwgLhJhuD3bTOoPlbUjfhcLw7tSFjG6RAmBLl9KmyJc=;
        b=XAOkdakQTzKPF0XomcICYSxrxfxmxaKgxxzNv/eHrpQgEgMwY2BmhzSXI9yojvDZxP
         OwpRT7JEy22HqP6+VM20VJxLk40xi1QPjZJ4cBEvdaC2IcBA1W0M1cKT3vzD8+eUp5ge
         Ck2ts36Ba+4/qNNL3zn18f7DHoCJXra3VTBTvhU+Qrx7AKUy9I/KfygcP2ZPzu/n5lvB
         6Vu5a/79ZJNrcGWLjqvDAl6OJTVxI3wSLhzkKCVhhOhw5anXnRp5yOXwO/hzISjn53mV
         dlkjKe/4KP85vDsqsl5R55jEUzHXXUGNfCTes/BbwRqR5FPcosBk6O7cMHesbsYgAqWG
         zHOQ==
X-Gm-Message-State: AOAM5300Yocc8uPGsGgojFc5THp9vHeHd2rVCjdQPLlLZGXWSnkJR9iJ
        MswtqoLeIcH2AkKxEACKp8A=
X-Google-Smtp-Source: ABdhPJwXGS21Suclru/CJ+S2jfDOb1KyAhamV2KxRUxxFQw3Qxxld+hbL4v1CsqA3kNd47uNIvE0eA==
X-Received: by 2002:a17:90a:65c9:: with SMTP id i9mr28333485pjs.201.1593606032838;
        Wed, 01 Jul 2020 05:20:32 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id f132sm5724544pfa.122.2020.07.01.05.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 05:20:31 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 4A395403DC; Wed,  1 Jul 2020 12:20:30 +0000 (UTC)
Date:   Wed, 1 Jul 2020 12:20:30 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Christoph Hellwig <hch@infradead.org>, mcgrof@kernel.org
Cc:     syzbot <syzbot+46c77dc7e98c732de754@syzkaller.appspotmail.com>,
        dhowells@redhat.com, jarkko.sakkinen@linux.intel.com,
        jmorris@namei.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: INFO: task hung in request_key_tag
Message-ID: <20200701122030.GP4332@42.do-not-panic.com>
References: <000000000000961dea05a95c9558@google.com>
 <728915db-592b-997f-6970-464cc59441d7@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <728915db-592b-997f-6970-464cc59441d7@i-love.sakura.ne.jp>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jul 01, 2020 at 07:04:15PM +0900, Tetsuo Handa wrote:
> I suspect commit 9e9b47d6bbe9df65 ("umh: fix processed error when UMH_WAIT_PROC is used").
> Maybe the change in kernel/umh.c and/or security/keys/request_key.c made by that commit is
> affecting call_usermodehelper_keys() == 0 case when complete_request_key() is called.

That patch has been dropped for now due to another reported issue
bisected to it and even though we have not root caused that issue [0].

It would be good to have a reproducer for this reported issue as well,
but I should also point out a regression which Naresh reported is fixed
recently by a posted patch [1] by Herbert Xu. It would be good if you
can test with that patch posted by Herbert.

[0] https://lkml.kernel.org/r/20200623141157.5409-1-borntraeger@de.ibm.com          
[1] https://lkml.kernel.org/r/20200626062948.GA25285@gondor.apana.org.au

  Luis

> 
> On 2020/07/01 16:53, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following crash on:
> > 
> > HEAD commit:    c28e58ee Add linux-next specific files for 20200629
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=17925a9d100000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=dcd26bbca17dd1db
> > dashboard link: https://syzkaller.appspot.com/bug?extid=46c77dc7e98c732de754
> > compiler:       gcc (GCC) 10.1.0-syz 20200507
> > 
> > Unfortunately, I don't have any reproducer for this crash yet.
> > 
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+46c77dc7e98c732de754@syzkaller.appspotmail.com
