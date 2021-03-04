Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35026C433E6
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Mar 2021 00:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0197D64F0D
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Mar 2021 00:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbhCDA7p (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:59:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1453128AbhCDArs (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 3 Mar 2021 19:47:48 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4DCC06175F
        for <linux-security-module@vger.kernel.org>; Wed,  3 Mar 2021 16:47:07 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id mj10so25905320ejb.5
        for <linux-security-module@vger.kernel.org>; Wed, 03 Mar 2021 16:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mq1f8KTtZiYItxqJI2LgJatX0epQhRAFbaIZi+expz0=;
        b=Oc+SWz8n0ufa9QRdQhnxQIklG0y9oh4rsTE9dlLij8ea41tPx5uxpQJaw88Sfq8u+l
         OvxCF5/vojxFgl9UzAyv+YY7eOT3ys9T+CDt0ZnW7n0xjDCmukQgzrsCSca5JuuPnOBB
         DHgTIHYpsmpCDvb5x0uVoI191R/WOFrBBwFNFe4Y/oZX/liilPeDD5ZWZ9BD9tTk7DT2
         vopxtWv9nCoCnKLpTkaTYy9Wk7LJ6jWx/zpgvW3gAU8NxnTrNVRTl1/pbSmzhfDYaFq9
         HBYCPSbLi6gBizNJ86dVk/WaoxjL6P5H0LTQziJSRqLu/dOue8cTTDiqFrAkNSl2DYiw
         rKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mq1f8KTtZiYItxqJI2LgJatX0epQhRAFbaIZi+expz0=;
        b=D1TW8XN7KyWdustQMgOBJGv/G6da19QBvZKhcgHmcMSx6AS+xT5THu4ntcpjwRlYLF
         gTibIXso56QQtjhYk094dTb/DPWUsRYmfvz8/qOnJ9jKDlS32s6l4Fr+2amgaXHVEzME
         TsKw6P4SCPBBiMVQF/J9Ag5dJJwpURN74VySvKM5NXNzCZuoMFz6GFJzSOL95DU8jRez
         Jr9RYyL/jfT1WgAWpq1AyyDYNOfHIgaCDDCzuS6uf6Re8G3NRaGfNuUiihp0PyQGKb7R
         v2YHzHR1ysiAYDn4e5TSOsVk9ycw9ouykwYruPrdPQV75paCptA8tQafJ5fEl19hzdGX
         IKHg==
X-Gm-Message-State: AOAM531uqZzNBqnuJH/5vxpQ0aWwDQJ97rdfgdqN1qlGWB+gytqtqOFt
        2Ma2C/+8IPplKFGyTylv+vtE2q9/5MmHRuDDxX9q
X-Google-Smtp-Source: ABdhPJzFReVQqWcB51YCLgOXcJ77lmnHR8e1TAPj9TL5+P31gZuqxQKpNr0xnGinbrwwT44eCfFHsDbq+b0OdR4h3Fw=
X-Received: by 2002:a17:906:e116:: with SMTP id gj22mr1386315ejb.398.1614818826560;
 Wed, 03 Mar 2021 16:47:06 -0800 (PST)
MIME-Version: 1.0
References: <161377712068.87807.12246856567527156637.stgit@sifl>
 <9ea5259b-fd84-e176-c042-c52a1c4fcc27@schaufler-ca.com> <CAHC9VhQBbep2WkD6JkCemtcXFLq7j5=AQeM9vVJ4_gmvi7hPQA@mail.gmail.com>
 <1ab6d635-53af-6dd9-fc29-482723c80c6a@schaufler-ca.com>
In-Reply-To: <1ab6d635-53af-6dd9-fc29-482723c80c6a@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 3 Mar 2021 19:46:55 -0500
Message-ID: <CAHC9VhR3=dNpxHXSo7TgJD6bCezgzfS-iT32f-jAZJgzCsNA3w@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] Split security_task_getsecid() into subj and obj variants
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     John Johansen <john.johansen@canonical.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, Mimi Zohar <zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Feb 22, 2021 at 6:59 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 2/20/2021 6:41 AM, Paul Moore wrote:
> > On Fri, Feb 19, 2021 at 8:49 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> On 2/19/2021 3:28 PM, Paul Moore wrote:
> >>> As discussed briefly on the list (lore link below), we are a little
> >>> sloppy when it comes to using task credentials, mixing both the
> >>> subjective and object credentials.  This patch set attempts to fix
> >>> this by replacing security_task_getsecid() with two new hooks that
> >>> return either the subjective (_subj) or objective (_obj) credentials.
> >>>
> >>> https://lore.kernel.org/linux-security-module/806848326.0ifERbkFSE@x2/T/
> >>>
> >>> Casey and John, I made a quick pass through the Smack and AppArmor
> >>> code in an effort to try and do the right thing, but I will admit
> >>> that I haven't tested those changes, just the SELinux code.  I
> >>> would really appreciate your help in reviewing those changes.  If
> >>> you find it easier, feel free to wholesale replace my Smack/AppArmor
> >>> patch with one of your own.
> >> A quick test pass didn't show up anything obviously
> >> amiss with the Smack changes. I have will do some more
> >> through inspection, but they look fine so far.
> > Thanks for testing it out and giving it a look.  Beyond the Smack
> > specific changes, I'm also interested in making sure all the hook
> > callers are correct; I believe I made the correct substitutions, but a
> > second (or third (or fourth ...)) set of eyes is never a bad idea.
>
> I'm still not seeing anything that looks wrong. I'd suggest that Mimi
> have a look at the IMA bits.

Assuming you are still good with these changes Casey, any chance I can
get an ACK on the LSM and Smack patches?

-- 
paul moore
www.paul-moore.com
