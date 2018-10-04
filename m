Return-Path: <SRS0=kUy5=MQ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB2AC64EBC
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Oct 2018 16:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87289206B2
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Oct 2018 16:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kG5QhKQi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87289206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbeJDXMn (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 4 Oct 2018 19:12:43 -0400
Received: from mail-yb1-f179.google.com ([209.85.219.179]:43061 "EHLO
        mail-yb1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbeJDXMn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 4 Oct 2018 19:12:43 -0400
Received: by mail-yb1-f179.google.com with SMTP id w80-v6so4132040ybe.10
        for <linux-security-module@vger.kernel.org>; Thu, 04 Oct 2018 09:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=klikc/ppoWhHWoTPwATe/d3YAeCUULUa19nJC8jVpk4=;
        b=kG5QhKQiXbODahJrteU88ImIM3Gdefjzn39Ql04hsa85oIqg7rheUSWXuwlMoldiMN
         FWm+elTP8aX3dgn08TLtTiswx17TJHuHOgpOiYn2P8fAVOOQdu47PFcD8PHZOXZjMZ5K
         qoNi7nkRrmowNiZmDx5tvSSQVnd2//ArTBVUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=klikc/ppoWhHWoTPwATe/d3YAeCUULUa19nJC8jVpk4=;
        b=Dc1tPlTABMQZjVoI0Y4YX3M7o6sG2dJMEvayx0HDm2AxnjQ4gVrGSjXZ/zVtCCk5wy
         HCKYtgkZQv5CNccMyaq/5MwKvPn/jwsUhZR5Yipz2B1iypJxH7jA29KK7rXfpyoVqAK6
         e2uszfkzPp+4kdqHxYVUH+bUAwzuWXoImfTXnRbbbVpaVJM9eO6AXBYUGktO/Z1rtX5w
         Vh4g72EIT5qlMTlvTT1D2WymTIosUhvPym+PlsndSZMacRcypTjQt6Np9EG33/uqmUA8
         D8SXKg7z9xh8MmFROt2coSJkis8fZGMa8vIsgjF50adeMgJ3anRdwn2sQCerY2ZhX3jK
         gyfQ==
X-Gm-Message-State: ABuFfoiaE3hqv9nf3SyIsAH6G6pVVl+rhhBuTbj6fOInik4Y6CUuacKu
        SFi4GGy+94FJOjw5vuzglgVLi1HjTxc=
X-Google-Smtp-Source: ACcGV63lT0ZQLynchmGoLa5sP3ZhlKkjZ0NhN6OHwC4Lw6uYpoXfe769FJdgyMnl/J+lOdwxsXm87A==
X-Received: by 2002:a5b:9d0:: with SMTP id y16-v6mr4194463ybq.69.1538669923504;
        Thu, 04 Oct 2018 09:18:43 -0700 (PDT)
Received: from mail-yw1-f48.google.com (mail-yw1-f48.google.com. [209.85.161.48])
        by smtp.gmail.com with ESMTPSA id k17-v6sm2195015ywk.47.2018.10.04.09.18.41
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 09:18:42 -0700 (PDT)
Received: by mail-yw1-f48.google.com with SMTP id s73-v6so3985664ywg.11
        for <linux-security-module@vger.kernel.org>; Thu, 04 Oct 2018 09:18:41 -0700 (PDT)
X-Received: by 2002:a0d:fec6:: with SMTP id o189-v6mr4141380ywf.237.1538669921384;
 Thu, 04 Oct 2018 09:18:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Thu, 4 Oct 2018 09:18:40 -0700 (PDT)
In-Reply-To: <f016c836-cc9d-0a2d-fb18-930b43898cdf@canonical.com>
References: <20181002005505.6112-1-keescook@chromium.org> <CAGXu5jKNzG3rGUAV39D0w4txHRG3H2qU1Z1e_b+03OgycTaWqA@mail.gmail.com>
 <809f1cfd-077b-ee58-51ba-b22daf46d12b@tycho.nsa.gov> <QpdcE4QSCQKJqDmB2QBEGBlnlioHuRHlM0g5HF8KbHjU1zIUAOjnQ2r9EIMu3m0S2OWNR3_M_TSp_M6CVDqkp6kKuFPUvegsyDPNw1AGju4=@protonmail.ch>
 <CAGXu5jKqXNbEvPr1axQtGCCnWsGhDgjynW5u326mcx4vZ1oH8g@mail.gmail.com>
 <abe03d09-4dcb-2b02-4102-5e108d617a42@canonical.com> <CAGXu5jJtC1gkJ0ZKDFroL8UzvjiPfmC+6EsrzyB0j0oETdSQQg@mail.gmail.com>
 <alpine.LRH.2.21.1810030758460.23596@namei.org> <CAGXu5jLKgrdhah-5TtAXDL-odbLGeyAUH2=PkAU769AkEnZFfQ@mail.gmail.com>
 <5955f5ce-b803-4f58-8b07-54c291e33da5@canonical.com> <alpine.LRH.2.21.1810040416500.13517@namei.org>
 <CAGXu5j+oPR58oJ06-n7e96-Rmu+ywTW0hud5LhOZ_3UXG5s12w@mail.gmail.com>
 <alpine.LRH.2.21.1810040427550.13517@namei.org> <CAGXu5jJmVR4Wsdti=aFaDhCBaxsVu1KTJOdsJOtFvZOV1ZhdvQ@mail.gmail.com>
 <CAGXu5jLBHN=YSs3Uh49bBJ1SRA1Km2UUD4j37GJJXiKhQq+KPA@mail.gmail.com> <f016c836-cc9d-0a2d-fb18-930b43898cdf@canonical.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 4 Oct 2018 09:18:40 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJJit8bDNvgXaFkuvFPy7NWtJW2oRWFbG-6iWk0+A1qng@mail.gmail.com>
Message-ID: <CAGXu5jJJit8bDNvgXaFkuvFPy7NWtJW2oRWFbG-6iWk0+A1qng@mail.gmail.com>
Subject: Re: [PATCH security-next v4 23/32] selinux: Remove boot parameter
To:     John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>
Cc:     Jordan Glover <Golden_Miller83@protonmail.ch>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Oct 3, 2018 at 10:56 PM, John Johansen
<john.johansen@canonical.com> wrote:
> On 10/03/2018 01:36 PM, Kees Cook wrote:
>> I still think we should have all built LSMs enabled by default, with
>> CONFIG_LSM_DISABLE available to turn stuff off. CONFIG_LSM_ORDER
>
> and this as a distro ubuntu does not want.
> Ubuntu wants to make yes available by building them in, but does NOT
> want all the LSM enabled by default, not even necessarily all minor LSMs.
>
> As a distro we want a supported set as default, and users can opt-in
> to new LSMs. If a new LSM comes along we don't want it enabled by
> default, which happens Using the lsm disable approach.

Okay, but order still matters. Where, in the order, should a disabled
LSM go? It seems like the friendliest approach for an end-user would
be to do something like

lsm=+landlock

and it all works correctly. That user doesn't need to know about
ordering or the distro default LSMs. They just want to _add_ landlock.
They want all the other LSMs to still be present, and they want the
distro to have chosen where landlock is in the ordering.

>> I should also note that I don't want to leave CONFIG_DEFAULT_SECURITY
>> in, since it's just a way to disable all the other majors. I don't
>> like this because it will force LSMs to be disabled that don't need to
>> be once blob-sharing lands. The whole point of this series is to get
>> us away from fixed ordering and thinking about "major" vs "minor" and
>> towards "exclusive" or not, where we can continue to slowly chip away
>> at exclusivity without breaking anything.
>>
> sure we definitely want to get away form "major" vs "minor" and in
> generally even exclusive, except where to LSMs just can't live
> with each other.
>
> But that doesn't mean dropping something like default security. The
> mistake with the current DEFAULT_SECURITY was that it only applied
> to major LSMs, not the minor ones.

Right, we need to expand it to include a full description of ordering
and enablement.

How about this:

CONFIG_LSM specifies order and enablement status. For example:

CONFIG_LSM=yama,loadpin,apparmor,!selinux

This means init order is yama, loadpin, apparmor, selinux, but selinux
is disabled. Anything not listed in CONFIG_LSM but built in will be
disabled and ordered in link-order. (i.e. an implicit trailing
"!smack,!tomoyo".)

Then we add "lsm=" which understands modifiers "-", and "+".
"lsm=-apparmor,+selinux" wouldn't change ordering, but would disable
apparmor and enable selinux. "lsm=smack,loadpin" would enable only
smack and loadpin, in that order and disable everything else.

I don't want to overload "security=", but we can if we want. It would
be as above, but a trailing comma would be needed to trigger the
"ordering" behavior. e.g. "security=selinux" would disable all other
majors (retaining the current behavior), but "security=selinux," would
disable all other LSMs.

-Kees

-- 
Kees Cook
Pixel Security
