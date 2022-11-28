Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6900EC433FE
	for <linux-security-module@archiver.kernel.org>; Mon, 28 Nov 2022 03:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiK1DtG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 27 Nov 2022 22:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiK1DtF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 27 Nov 2022 22:49:05 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E548211159
        for <linux-security-module@vger.kernel.org>; Sun, 27 Nov 2022 19:49:04 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id ns17so1472508pjb.1
        for <linux-security-module@vger.kernel.org>; Sun, 27 Nov 2022 19:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=89aaUv3n0AzXwCZrz3sUfTfmKWe0V9mGkRuHoglXv5U=;
        b=F4SbjpZUWp5gVN2m89hgsNNyAotwuAWKvbMF3CWNy7iGl9uEI1AXaxPYf0sFw8YtWK
         jOTLBbDCkwZK3iq7jd54vj0s47FJtl0zvGOhc40z82vKTv7zZkIo0JUYG8W5Jgg3YQ37
         XARGusor5xfZTrrh93vLVQcjXvb94idgLbZBcQS68wZcJc64e7gO3BWaKBKsgmm+XyZZ
         lW3gncOyuzJhWFXl/VZxDjYb50nr6c/frBa5EePd1NmQcLgMOurF4VylhhI0jk/PkK+0
         oj2W63ZPAySakpz3JDXI1jx0SdrNzQvCU7Bg/CE+pm/PWD3UkqPjqAj4zPMBr9asVq//
         hmtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=89aaUv3n0AzXwCZrz3sUfTfmKWe0V9mGkRuHoglXv5U=;
        b=tFGNNk3vtamuSfZNG919lDLAqSeRAGFaLTjhee7FiNN/xxPs7nsYA8wng5lrSkH1ck
         2Ky0CPxfzO11OitGqnI4CwpYqZTGwCKBasTPv1pR4cEjixH8ctvyqpnoq75DMeeh7dUs
         yF7ATJ5rXxRGlb74theVL/Aef6FDNaAwZ4CjgfBhdFXLbpSK2G6jFLipmPF2AwPGS2sI
         v8nUDASM/LVBNn0gOnnzmyVF6vNC0NWPGjtqgEzIlmHyIeVAHvcTjm8MOMZd2rhrEqhm
         fLALpDIeNxDPFQfTBZ/Je7dmK4ANb+VHOC9lAwsDO4DOF4jFYlcMwM+SIlpLZrswVUPh
         9MjA==
X-Gm-Message-State: ANoB5plm6eGGFL4KXl7bdd6t4owSJFwqCWQAGQcxigwu5ClzIZKFPF01
        YJI28m3wGruu+gK5QSJyDgJJ84pWs8V3gIYl7j34rS5N2A==
X-Google-Smtp-Source: AA0mqf7RcLza/dRh0bacWs41PaOCR12ezszXApLSabQCoutYEWVUrDQ3Eh+QAcHd/5M8NFC4FiWv4UYCakNPPwooinE=
X-Received: by 2002:a17:903:28f:b0:189:8a36:1b70 with SMTP id
 j15-20020a170903028f00b001898a361b70mr3286900plr.12.1669607344298; Sun, 27
 Nov 2022 19:49:04 -0800 (PST)
MIME-Version: 1.0
References: <20221123201552.7865-1-casey@schaufler-ca.com> <20221123201552.7865-2-casey@schaufler-ca.com>
 <Y38D1s3uQ6zNORei@kroah.com> <463cb747-5bac-9e8e-b78e-1ff6a1b29142@digikod.net>
In-Reply-To: <463cb747-5bac-9e8e-b78e-1ff6a1b29142@digikod.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 27 Nov 2022 22:48:53 -0500
Message-ID: <CAHC9VhR9h1GF6VGovp1+UB-vt+QNofjmecPwLqE3OviKQHRMcg@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] LSM: Identify modules by more than name
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, casey.schaufler@intel.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Nov 25, 2022 at 11:19 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>=
 wrote:
> On 24/11/2022 06:40, Greg KH wrote:
> > On Wed, Nov 23, 2022 at 12:15:44PM -0800, Casey Schaufler wrote:
> >> Create a struct lsm_id to contain identifying information
> >> about Linux Security Modules (LSMs). At inception this contains
> >> the name of the module and an identifier associated with the
> >> security module. Change the security_add_hooks() interface to
> >> use this structure. Change the individual modules to maintain
> >> their own struct lsm_id and pass it to security_add_hooks().
> >>
> >> The values are for LSM identifiers are defined in a new UAPI
> >> header file linux/lsm.h. Each existing LSM has been updated to
> >> include it's LSMID in the lsm_id.
> >>
> >> The LSM ID values are sequential, with the oldest module
> >> LSM_ID_CAPABILITY being the lowest value and the existing modules
> >> numbered in the order they were included in the main line kernel.
> >> This is an arbitrary convention for assigning the values, but
> >> none better presents itself. The value 0 is defined as being invalid.
> >> The values 1-99 are reserved for any special case uses which may
> >> arise in the future.
> >
> > What would be a "special case" that deserves a lower number?
>
> I don't see any meaningful use case for these reserved numbers either.
> If there are some, let's put them now, otherwise we should start with 1.
> Is it inspired by an existing UAPI?
> Reserving 0 as invalid is good though.

I haven't finished reviewing this latest patchset, but I wanted to
comment on this quickly while I had a moment in front of a keyboard
... I did explain my desire and reasoning for this in a previous
revision of this patchset and I still believe the
reserved-for-potential-future-use to be a valid reason so I'm going to
ask for this to remain.  Several of you may disagree, but unless you
can provide a reason why these reserved values would *seriously* break
these, or potential future syscalls, I'm going to be stubborn and
insist we retain a set of low-numbered reserved values.

--=20
paul-moore.com
