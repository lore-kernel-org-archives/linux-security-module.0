Return-Path: <SRS0=9TCU=UG=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDDBC46470
	for <linux-security-module@archiver.kernel.org>; Fri,  7 Jun 2019 05:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAE1D20825
	for <linux-security-module@archiver.kernel.org>; Fri,  7 Jun 2019 05:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="SP39a6dK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfFGFTS (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 7 Jun 2019 01:19:18 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42413 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfFGFTS (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 7 Jun 2019 01:19:18 -0400
Received: by mail-lf1-f67.google.com with SMTP id y13so596481lfh.9
        for <linux-security-module@vger.kernel.org>; Thu, 06 Jun 2019 22:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gcgoiMaasR9GYRsYKIbgillYLme+avvxyb1D2UipF2A=;
        b=SP39a6dKhm2JhOqt3S0Fm0qRBQu9iyXJKug3k/afiQrepK7Q2eS1h0zRSVggRpCuuR
         g9Waph99295vdX3PMAjEGsSeAs1TBn/4CX99WfxKIuzqjFADrB9+b6f8DcX/DP+HcPFt
         kILQsby0yTn/aQE3U0yncwScOJUmJKIBNnUBDm3GO+rAjm2bKQcCCz86gS1h+9zE7Jy5
         Kqt8eQ21CZWLEDCqZKd8vdPHSNJ++duTcJr+GNaDNvj339S7HBzy6A2s3IiFd2ozg6nI
         4kYz/ztUrgXhV7m5UnC5fsEVRsDs0j6wS5CG5WeT6dwdNNevjmQo1do8nK1KjAXT4hs3
         qzjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gcgoiMaasR9GYRsYKIbgillYLme+avvxyb1D2UipF2A=;
        b=hZ4aO3pPDIiiq5B3xRcPq4J4H4ZNk97X7rhgUDb5s6i1c+InK0Ti6nsNCFIW6OrQoN
         iUZKzicShjMxzCrF6Y3WgkDQ5gC1BzHkfX7i7ch4h+eSWeB+de5MQzoskhI8Ppv0f10Y
         9lnerhAbgQPNxSEM7DdgLbWd71ec4EK6PzrBwZfTx2y9T8fKJFh/pgHqvaxkHVAKjeIe
         CZEXa6EYk3zRpURKZ35i1cjMCzOSSUdkqTWE3RDKnXHsva3nzEf9b1GTC6DJgUAzUG6V
         0B2TOJLJpEtoPk7LBPp58r0cV9/dqnBZ99Ix7Z9ET8bKdzaImRhJPlBbY/L6PlmiqwID
         i3yg==
X-Gm-Message-State: APjAAAWj1fm4zQ+tXdAHwOjS2WJTJGBVVYZuxi+6lV0jHV5BJAvh87oT
        p/yUuvsKy+J543O2ZxAfY50Y5wL9Ewb4cNRu1w3d
X-Google-Smtp-Source: APXvYqzsTuviT5aNkwwxpngJQ/DjOkvU8YIIHHF9yGzi6lk6g5L9aG5wM1AhEEb5I6PbUv2+dma9rY8UVj6QAQGcTGU=
X-Received: by 2002:a19:7716:: with SMTP id s22mr8063496lfc.64.1559884755951;
 Thu, 06 Jun 2019 22:19:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190605083606.4209-1-janne.karhunen@gmail.com>
 <9121835b-d6ac-c9d5-349a-1ef7024c6192@schaufler-ca.com> <CAE=NcrahPmzmB-xJwxzXqaPGtJY+ijbxV4wXz7K=y-ocw4Cmwg@mail.gmail.com>
 <1edfbd72-f492-db17-8717-a8cfe30d9654@schaufler-ca.com> <CAHC9VhTzwPoxYPxYWn15ZQQwM6Q3wGJSRybb-zu_ZDA1xU6ziQ@mail.gmail.com>
 <alpine.LRH.2.21.1906071043160.21512@namei.org>
In-Reply-To: <alpine.LRH.2.21.1906071043160.21512@namei.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 7 Jun 2019 01:19:04 -0400
Message-ID: <CAHC9VhSrjVmnsAuXDmHVmsyDaEF10nsvdxq7VsfCsh=NfaOMQg@mail.gmail.com>
Subject: Re: [PATCH 1/2] LSM: switch to blocking policy update notifiers
To:     James Morris <jmorris@namei.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Janne Karhunen <janne.karhunen@gmail.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Jun 6, 2019 at 8:45 PM James Morris <jmorris@namei.org> wrote:
> On Wed, 5 Jun 2019, Paul Moore wrote:
> > On Wed, Jun 5, 2019 at 1:05 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > > On 6/5/2019 9:51 AM, Janne Karhunen wrote:
> > >
> > > One hook with an added "bool blocking" argument, if
> > > that's the only difference?
> >
> > I think there is value in keeping a similar convention to the notifier
> > code on which this is based, see include/linux/notifier.h.
>
> Although this doesn't seem to be what other users in the kernel are doing.

How many of them potentially have the need for both blocking and
non-blocking notifiers?  I didn't go through the entire list of
callers, but it seems all that I looked at used only one type.  The
simple fact that we started with one type of notifier for the LSM, and
we are now switching to the other (and getting lucky that it is safe
to do so for the existing callers) seems to lend some weight to the
argument we may need both and adding "block"/"blocking"/etc. to the
name has value.

-- 
paul moore
www.paul-moore.com
