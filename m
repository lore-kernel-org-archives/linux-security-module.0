Return-Path: <SRS0=478F=TU=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F215DC04E87
	for <linux-security-module@archiver.kernel.org>; Mon, 20 May 2019 17:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C315A206B6
	for <linux-security-module@archiver.kernel.org>; Mon, 20 May 2019 17:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="CwchGZjI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390594AbfETRhb (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 20 May 2019 13:37:31 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:34645 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389161AbfETRhb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 20 May 2019 13:37:31 -0400
Received: by mail-ua1-f66.google.com with SMTP id 7so181552uah.1
        for <linux-security-module@vger.kernel.org>; Mon, 20 May 2019 10:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vDBzgk3+2zzaDlSxwytUrA3Kc0EghhVaruTPNWK1ttg=;
        b=CwchGZjIFzmqStPHXdkdMvjtXevOL6aMDz0RbbxhvTvOywv3R7HbSxVIiPR86vVgVJ
         28yp6/OUTu6GifEPNjnYBzsfPg5Y7BbwwV5Ty4ILdR7ZbBYLoKzOGlZ1hMwqgeyZohQS
         a9Xty3qBzDrM1VhvrAeqYsd8bm4McRK6eMvwStNI7jp8RC5DjasBTN49ChbDaScmiIHc
         LTl2jGq3y/n5qeMsGBeWktpO3+3aP8DzWvndvfXt1nfhBIsEP6nW4S6oWCWrYYgtNWmE
         SMz99yiCt+Utdgd/gzX6yrRr7ihWyoWsQAjda+WeCB98a3ybcjj/r3oR4U9vY176w7BS
         0c3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vDBzgk3+2zzaDlSxwytUrA3Kc0EghhVaruTPNWK1ttg=;
        b=jCpS4J7RtRslRI1xSknK9LTjEb5pCooEv3eskTgsYpHeEl5EAKv9nYVr3O0NZXAndf
         rvqqIm3eNx2ISUw9BNer5FR/Ql1c3NdcaQto3TZVSGMmpOcB7SZ4/D2+wAG9k3sVhAf7
         1wav51KX87esLOhyg52HAAPunZOm/ivKnCP/B9DNPDEC0mw2WxmRE1yHj3Jj5ziJhIz0
         Km8S5+IwHBKi2n8HEGmcGEs6kB34Nuj4/PXC7CnB+pOPvdDtW/sxT7xvCV9AFs1AWfCa
         Q3tgzhEiAxj5MxI87sLbQ4gV4y7C/ErTeKXXcn7tfBYXnxdSf4KhOfKdO4kOvCdYQVu6
         6+tA==
X-Gm-Message-State: APjAAAUL3DlXsaRqBcVsqyVjeU+cZiLGO8vkKNE9szl/mzIpJXHnk1av
        jLegszKLaLKi1Wzez5eAj1cjBJi8EuUq8+R04DtNgw==
X-Google-Smtp-Source: APXvYqxP8zxzm4jZKGosdcwN4a0RkbFAaC28vOtz1R97u76s4VbaoqHPsL53swQmuIAJyZjvBa85qqDRttnmEtWmwhM=
X-Received: by 2002:ab0:670c:: with SMTP id q12mr13594032uam.106.1558373850690;
 Mon, 20 May 2019 10:37:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190517213918.26045-1-matthewgarrett@google.com>
In-Reply-To: <20190517213918.26045-1-matthewgarrett@google.com>
From:   Bartosz Szczepanek <bsz@semihalf.com>
Date:   Mon, 20 May 2019 19:37:19 +0200
Message-ID: <CABLO=+mSkR8fwm5dDB2757OK=BKZGM9jHR6OuCkzazgFcVy=dg@mail.gmail.com>
Subject: Re: [PATCH V6 0/4] Add support for crypto agile TPM event logs
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Matthew,

On Fri, May 17, 2019 at 11:39 PM Matthew Garrett
<matthewgarrett@google.com> wrote:
>
> Updated with the fixes from Bartosz and the header fixes folded in.
> Bartosz, my machine still doesn't generate any final event log entries -
> are you able to give this a test and make sure it's good?

Yes, I'll check that and let you know. May be later this week.

Best regards,
Bartosz
