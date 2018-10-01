Return-Path: <SRS0=sHE6=MN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364BBC43143
	for <linux-security-module@archiver.kernel.org>; Mon,  1 Oct 2018 23:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0E8B213A2
	for <linux-security-module@archiver.kernel.org>; Mon,  1 Oct 2018 23:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b5pSpTqR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0E8B213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbeJBGaT (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 2 Oct 2018 02:30:19 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:33582 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbeJBGaS (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 2 Oct 2018 02:30:18 -0400
Received: by mail-yw1-f68.google.com with SMTP id m127-v6so67415ywb.0
        for <linux-security-module@vger.kernel.org>; Mon, 01 Oct 2018 16:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2ohEmpld1IFXjpF8PrBFP4qTkcM2P6AcoHxxKbyBNVM=;
        b=b5pSpTqR8TmSGggikp7xyF+snqMrJPH1p7e2lE+1eU7X9y0Z6OFHDpZcPaucVlYuNP
         nRK3vFBfzv60PdkYhhoUyz8uzMQt5WyH7tj/80NkYdGBqXOXpC8u5OPbEtnG1N2ct9is
         OkDfeKDCsH4kAPyJHnMm/NGh3kiYzLLRdQN9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2ohEmpld1IFXjpF8PrBFP4qTkcM2P6AcoHxxKbyBNVM=;
        b=jd6esAmIJOyH3zEXOefMUjuREpAb1/2o9Ecauwhj4pjYDOD+kcrk8QA4BGJUauMfp9
         2CnN3vSCmPNFLU8Li1/dQDukc12u/9oNQeO0in2Nw5gx2sHUJLima9K5xtWjwV5LB4iL
         qtvOgS/wnBFMIV0olmBnVBS0LbbnASLYbIyB0IQezKtk8NesOlqJool6/bwSwIfqFDxy
         TQx9zjYFwjmdYp7OM1kfxxp8OSxXriuv+6yQlDJpw23d/qk+V1uBVbnpE7d9/rB2BAZ4
         /SZlfNj2OM1ux1XXEH5ybSH0YZ5xhMpOSqazmuNjm43RiVLzqFoyUPHNpZ2zTK4/b5sM
         dJ9g==
X-Gm-Message-State: ABuFfohUVcw+oaMbCu8xaWJCnxogW2GcAFNX/vmdohseZ+779RoZnk3Q
        XOgmDVdJEPY/IC3qMo/uMGum7/T7H6Q=
X-Google-Smtp-Source: ACcGV62cdj180OuHOytWUx9y7XASoN/aO1RWILa76Soi7tomCD82G+mjwH5SBTXsVtBesMUkcl1OMg==
X-Received: by 2002:a81:5596:: with SMTP id j144-v6mr7082148ywb.116.1538437801963;
        Mon, 01 Oct 2018 16:50:01 -0700 (PDT)
Received: from mail-yw1-f41.google.com (mail-yw1-f41.google.com. [209.85.161.41])
        by smtp.gmail.com with ESMTPSA id b71-v6sm21423637ywa.48.2018.10.01.16.49.59
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 16:49:59 -0700 (PDT)
Received: by mail-yw1-f41.google.com with SMTP id j75-v6so48114ywj.10
        for <linux-security-module@vger.kernel.org>; Mon, 01 Oct 2018 16:49:59 -0700 (PDT)
X-Received: by 2002:a81:1194:: with SMTP id 142-v6mr7356787ywr.168.1538437798500;
 Mon, 01 Oct 2018 16:49:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Mon, 1 Oct 2018 16:49:57 -0700 (PDT)
In-Reply-To: <b2952ffe-545f-931f-e6a2-589be5ac8ac0@canonical.com>
References: <20180925001832.18322-1-keescook@chromium.org> <20180925001832.18322-19-keescook@chromium.org>
 <68e4e323-3216-7e77-2807-c3207126ae68@canonical.com> <CAGXu5j+jzmFh-iuXDVHQTq7e=mftpfaqS-45TP_UR3B+qtGcLQ@mail.gmail.com>
 <9b3e1733-7cfa-5047-1422-0f9d92d88d39@canonical.com> <CAGXu5jJheexJgnJ+OWaDoRFraqm9yxj1Vr290tfZ7kELBPUpAw@mail.gmail.com>
 <b2952ffe-545f-931f-e6a2-589be5ac8ac0@canonical.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 1 Oct 2018 16:49:57 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJr8P_rS+DcQJxMM9xnB0vFFc75Xrk7Qv9yx8_DLB1Vjg@mail.gmail.com>
Message-ID: <CAGXu5jJr8P_rS+DcQJxMM9xnB0vFFc75Xrk7Qv9yx8_DLB1Vjg@mail.gmail.com>
Subject: Re: [PATCH security-next v3 18/29] LSM: Introduce lsm.enable= and lsm.disable=
To:     John Johansen <john.johansen@canonical.com>
Cc:     Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Oct 1, 2018 at 4:44 PM, John Johansen
<john.johansen@canonical.com> wrote:
> On 10/01/2018 04:30 PM, Kees Cook wrote:
>> If we keep it, "apparmor=0 lsm_enable=apparmor" would mean it's
>> enabled. Is that okay?
>>
> ugh I would rather get rid of apparmor=0 or to emit a warning with apparmor
> disabled, but if we have to live with it then yes I can live with last
> option wins

Removing it would be much preferred! :)

Assuming Paul is okay with the same results in SELinux, I'll prepare patches...

-Kees

-- 
Kees Cook
Pixel Security
