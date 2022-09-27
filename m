Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C8FC6FA82
	for <linux-security-module@archiver.kernel.org>; Tue, 27 Sep 2022 22:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbiI0WhS (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 27 Sep 2022 18:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbiI0WhR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 27 Sep 2022 18:37:17 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB86C1114D9
        for <linux-security-module@vger.kernel.org>; Tue, 27 Sep 2022 15:37:16 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1280590722dso15197663fac.1
        for <linux-security-module@vger.kernel.org>; Tue, 27 Sep 2022 15:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=HuReV2OQBnHcceVx8SqAsjobLICjCWNggHjGYWWV+mw=;
        b=saFvd9BXXwBcFjl9sF5V8J2nH2s2H4XC6Yg5aZ8QVVHw0SGoWKMXSN14BL35Rp3sPZ
         UHivfuDNTEVKE90GsaOpAVX41rx+o0G0dn9CfajYRAR7ZJdI1g+jaDxIL1iGR8Z4Ei2o
         FXHpC6+pUJxJtlnDu8cYL1rw+MJan3xLP8P2ZiI+YtMyRLDfH3kzqgOY/g82al2dU8Ce
         3mJ2HdZUFIdozY9+xzyhagQROAFKuIbpiK+3uFVm1zFWINcqJbx1kfiaCJ8Pvs9dnU7q
         T/9GMB3/wCmI68gZFRgh5GUnPYLNAyht4j9wztnv9LNh2tu7WV5QtbJCbw/eoeRHzms8
         hmXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=HuReV2OQBnHcceVx8SqAsjobLICjCWNggHjGYWWV+mw=;
        b=NCM0/6AXELYRD7KasFdS35z6RKg25IcQ203efDDFOlhsHoF0TCcJu6Te8ZIpxTkRgB
         pyqrRlmhEJW5xBkS+e/JyuYTyKYT5FgAk20wwAV7ppkMcC9uOo1r203vswgh1sUM5hy0
         DZGrlkhIz7yqJtMLrL4TJPlpoId9wnC1DAT8J+c27mmskZZwwObUYaeFQDho2aOarqvh
         pVklSEbNj7idZVOIwdIZb09LiXUFbIytMfKrb/7RPEkyf6mJc+lGRv8flhlKD6Zt4UZS
         R3SieJjxRk+Ks9GLI8a3Bk+nTTrwedm3Gj8XhPrTVC2P6bEpSyV9cGmeQ6E0V6TAnQ7N
         dWXQ==
X-Gm-Message-State: ACrzQf0SGAYlRUtEitHeaRTkuIXdLXspuozqo8kv1YOd/wBV47Xm8GAO
        yVweEVaeuUVgO8hgROmkRKVuFQt5zDK7v2RcUsD5sJLXRw==
X-Google-Smtp-Source: AMsMyM4O2kGKvQzlomKIOb0sQmWIrDacYCBH/MJwdv3Scfmk2nloSnvq4/fo5b8iVk8ahjRk0FQGApbxKdoxXXfs7G0=
X-Received: by 2002:a05:6870:a916:b0:131:9361:116a with SMTP id
 eq22-20020a056870a91600b001319361116amr1904631oab.172.1664318236263; Tue, 27
 Sep 2022 15:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <791e13b5-bebd-12fc-53de-e9a86df23836.ref@schaufler-ca.com>
 <CAHC9VhSF8hWg=7tbFiCrizNF61vpwJcU3793LcStiu-anW4i1g@mail.gmail.com>
 <CAHC9VhTDGwO789t59EyOV0SwnwGrdyBhRiuJpoY7cB4MSe02BQ@mail.gmail.com>
 <e2b6ae44-1037-666f-5012-6abd4d46c0b7@schaufler-ca.com> <CAHC9VhQ+UcJw4G=VHNE8wMa+EBG-UcoZ7ox0vNqLHoSKAd9XZQ@mail.gmail.com>
 <269014c6-5ce6-3322-5208-004cb1b40792@canonical.com> <CAHC9VhRrOgDMO9fo632tSL7vCMAy1_x3smaAok-nWdMAUFB8xQ@mail.gmail.com>
 <1958a0d3-c4fb-0661-b516-93f8955cdb95@schaufler-ca.com> <CAHC9VhQPvcunvBDvSnrUChwmGLen0Rcy8KEk_uOjNF1kr4_m9w@mail.gmail.com>
 <6552af17-e511-a7d8-f462-cafcf41a33bb@schaufler-ca.com> <CAHC9VhQMeyxQJSAUuigu=CCr44WtpJg=LEh1xng_bPfCCjqq6Q@mail.gmail.com>
 <5ef4a1ae-e92c-ca77-7089-2efe1d4c4e6d@schaufler-ca.com> <CAHC9VhQRpeOMkeEfy=VRPnpuYMUDYgLp56OjQZPYwoXmfHYREQ@mail.gmail.com>
 <c679cea7-bb90-7a62-2e17-888826857d55@schaufler-ca.com> <CAHC9VhQ-FqURHeuq_3YNH8NixJiGZ9bEEdydu49kC5tLan+FoA@mail.gmail.com>
 <e53a88aa-8fe9-0e0f-ae41-0df17df86a77@schaufler-ca.com>
In-Reply-To: <e53a88aa-8fe9-0e0f-ae41-0df17df86a77@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 27 Sep 2022 18:37:04 -0400
Message-ID: <CAHC9VhR9MyQvuJtupq09Nc307oSRV4K=9iOU6is93yQ3HHmiHQ@mail.gmail.com>
Subject: Re: LSM stacking in next for 6.1?
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     John Johansen <john.johansen@canonical.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>, linux-audit@redhat.com,
        Mimi Zohar <zohar@linux.ibm.com>, keescook@chromium.org,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Sep 27, 2022 at 4:54 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 9/14/2022 6:42 AM, Paul Moore wrote:
> > On Thu, Sep 8, 2022 at 6:56 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> I am going to start playing with these syscalls. Please help me understand
> >> where I have suggested something stoopid.
> > Thanks for posting an initial patch that we can use for further
> > discussion.  Time is a bit tight this week due to LPC/LSS-EU so I'm
> > not sure I'll have the time to provide any meaningful comments, but if
> > nothing else it's on my todo list for next week.
>
> With a full understanding that the 6.1 boat has not only sailed but has
> subsequently been sunk by pirates I've posted my v38 stacking patches.
> I would have liked to wait for some amount of "discussion" on the proposed
> syscalls and prctl() options before posting, but it seems that isn't
> going to happen on its own ...

I was happy to see the patches posted, and they are in my queue, but
being away the week of LPC/LSS-EU as well as some other more near-term
patchsets that need review have delayed my ability to review your
syscall patches.

-- 
paul-moore.com
