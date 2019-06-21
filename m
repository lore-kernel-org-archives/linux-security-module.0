Return-Path: <SRS0=QDjJ=UU=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01F7C43613
	for <linux-security-module@archiver.kernel.org>; Fri, 21 Jun 2019 20:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DF282084E
	for <linux-security-module@archiver.kernel.org>; Fri, 21 Jun 2019 20:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uSwOqok2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbfFUUNw (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 21 Jun 2019 16:13:52 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37809 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfFUUNv (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 21 Jun 2019 16:13:51 -0400
Received: by mail-io1-f66.google.com with SMTP id e5so1670030iok.4
        for <linux-security-module@vger.kernel.org>; Fri, 21 Jun 2019 13:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PZ3HSopZ8scQspbF1YU2hVMlcP6almQVuwJAX1EnWwE=;
        b=uSwOqok2TkKrZs6ef8LyutAmeIVAmrvTX+I0ogpzk10JIgISYRGYFwHbDr/jBjBhcQ
         NA0jqzdzcHT1pNOkAqCHa8QCl44F1pjbQDOu2/zfc8yi+p+kQLK+f7uR4VD/+0cI4wHv
         xyStzMvyDtyEBRWTLynVzKIoWNKAK9B/92biEVIcBuvl9q+1a7EvC4MuZxHvM0O4+pVw
         +fhrIa/DQRoh5GnPuLG3ExEMN3D+SSHaIdgG3OESJHZBWFv0hVuDE2ptMeSG+iW12k/F
         75OD3qMFXdinEJIj3XJYvi/Bjf/DTLErZwwDftSc7wyoG4HP9trMYVkX1zPAwD+mXBb4
         VHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PZ3HSopZ8scQspbF1YU2hVMlcP6almQVuwJAX1EnWwE=;
        b=aU3/aX3M5EfuO+tDE//WKYPyOkF+CvQivG7N3AnPTZuUh6r+OZ9kyAhjciwB3VLRQw
         eKk6yCSLNR8n7SX/dGf9oOB1tK4niiv8g5nZzn73WaiV272k9msytsG8KxYSQPXKo1Wq
         ffCY4QP0RVIk5evU8MQx15UYbayosPaGvKH69x22oLCeTbrgZIgUhhzQD1XVPndcwV1A
         e4+MrR5hky8la/qUAOmsobyJB1pX/IMt8Tb+UG3/KliWrNTGj55VCfnPxoijcv1Mx6JJ
         OHwiwcfABvNv4PDRFRmz3tF2d45CrDSf+Zxwwy453S9Lf7AC5jXe42Kc50EJISrsDlx5
         jcwQ==
X-Gm-Message-State: APjAAAWJpioELs801QdgzKyHLBjs/ASI0x4oUfMsfQWNaObAGuU8KjHF
        3YeOwzM8RbMTib6+JPLp56I5Z+bnCTC6qEPkq4e1zA==
X-Google-Smtp-Source: APXvYqyCItlv6yjcz3a4aTv8GzO1ooFirmCSp1fDi4OqQzk3T9nZxw8NBDxszz7jAyO4tbQoJtfUZh4Tl4uzOjWmdAA=
X-Received: by 2002:a02:ab99:: with SMTP id t25mr8431415jan.113.1561148030643;
 Fri, 21 Jun 2019 13:13:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190326182742.16950-1-matthewgarrett@google.com>
 <20190326182742.16950-7-matthewgarrett@google.com> <20190621063402.GA4528@localhost.localdomain>
In-Reply-To: <20190621063402.GA4528@localhost.localdomain>
From:   Matthew Garrett <mjg59@google.com>
Date:   Fri, 21 Jun 2019 13:13:39 -0700
Message-ID: <CACdnJuvmU8PcRztTYRHes-O3QVwiXy_PQvP9AP=B=byX4Pu3uA@mail.gmail.com>
Subject: Re: [PATCH V31 06/25] kexec_file: split KEXEC_VERIFY_SIG into
 KEXEC_SIG and KEXEC_SIG_FORCE
To:     Dave Young <dyoung@redhat.com>
Cc:     James Morris <jmorris@namei.org>, Jiri Bohac <jbohac@suse.cz>,
        Linux API <linux-api@vger.kernel.org>,
        kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Jun 20, 2019 at 11:34 PM Dave Young <dyoung@redhat.com> wrote:
> Force use -EKEYREJECTED is odd,  why not just use original "ret"?

Fair question. Jiri, any feelings here?
