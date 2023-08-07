Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F95C001DE
	for <linux-security-module@archiver.kernel.org>; Mon,  7 Aug 2023 23:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjHGXPM (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 7 Aug 2023 19:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjHGXPK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 7 Aug 2023 19:15:10 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB9411A
        for <linux-security-module@vger.kernel.org>; Mon,  7 Aug 2023 16:14:56 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-58451ecf223so54782537b3.1
        for <linux-security-module@vger.kernel.org>; Mon, 07 Aug 2023 16:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1691450096; x=1692054896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gC650LVe61HwPim1FSUuzXp4C/B2DwrSSnI6+3CNzQ8=;
        b=ct+ge2PGifRP3AlMIL/2uh0Qxnp5/FFhMPFh1pADmZFwbBUUztR9EjiH+7kkziM74s
         qZAjmrkpD1CdVps/VpDrKBYmtg03d/GoP3/+FfqBBBzrSn30IWE0+ixoqmDOrAH+O2qx
         ZK8X6B1b0Yy/2dyuIRVptN2hY9zk0fC2xMCvLJg0HIlu3iG5ejaOh48zKA9JDbI0t6QD
         rpxIeR/fckdT+rJDS3i78lzOjpgMigIQPcLmeo18ttjBsgQLeSzWhLJ1ZxGhfMnHptbj
         4O0xCy8K4HT5PqD1tsQ+/WUR0cRwPsdhCIiCp/x0sf3IcIR6lFhOzr5cfWtSNH10j0NE
         s9sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691450096; x=1692054896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gC650LVe61HwPim1FSUuzXp4C/B2DwrSSnI6+3CNzQ8=;
        b=CyrzeyMbau2Ol2IxajEU7pnxxizj4MW4jmo6yufsGlBynK9QkQJz0KltRK+syMQzh/
         yfbwZ02EMY59J5jxpoa8rWcI0snjtlFnOvlz90qAGYtnLw643G8wzhGa7l98nkfQoQLh
         pa4z9jI+HDkQythjHCfH+BPqvLJmu9Qst3bkAwJvQg/k1BLKPkZ5z3eyWlYWYdGjlvXU
         frEUubp6n2IXUeW4+1OAuGsJtGcu+YGPDMVfASQRePYvEuK/qvTrcjKwmDdCMsgQ8NJW
         WyX+gaeXscnfj4WbhVe37pGyBxQFqoAZ1vo1/A3uztyGj3VyQ0xBtd+QHE/kffpWQjcm
         /BIQ==
X-Gm-Message-State: AOJu0YzI2PAhP0TsFbxkY5doId/u5bC2eVEXo16Qi7v1ZL9YlYeBslLl
        nGgxIvvlHLmho2z/SJUwThKXAwkIzZHXb8S031jPw8Q5iJosykqjLE+C
X-Google-Smtp-Source: AGHT+IG+zDyHe2W8hJPVzd30Y0QsMafbml2uX7nh9Nm5i+kMzX1fDTv2ox8qZUEuhWfN8JG6FwS88UOzudjmO8t4qPQ=
X-Received: by 2002:a81:6e86:0:b0:584:5e7e:40c1 with SMTP id
 j128-20020a816e86000000b005845e7e40c1mr10333423ywc.28.1691450095895; Mon, 07
 Aug 2023 16:14:55 -0700 (PDT)
MIME-Version: 1.0
References: <ZNCZ4KL7TRDE9vIC@gmail.com>
In-Reply-To: <ZNCZ4KL7TRDE9vIC@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 7 Aug 2023 19:14:45 -0400
Message-ID: <CAHC9VhSULN1B_EjVPA5st+NhDjiUbymOwt81C4gZ9Tn4_wWpuw@mail.gmail.com>
Subject: Re: [PATCH v2] lsm: add comment block for security_sk_classify_flow()
 LSM hook
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        ztarkhani@microsoft.com, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Aug 7, 2023 at 3:14=E2=80=AFAM Khadija Kamran <kamrankhadijadj@gmai=
l.com> wrote:
>
> security_sk_classify_flow() LSM hook has no comment block. Add a comment
> block with a brief description of LSM hook and its function parameters.
>
> Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> ---
> Changed in v2:
>  - Add parenthesis with security_sk_calssify_flow to refer to it as a
>    function in commit message and commit log.
>  - Remove an extra space in the comment block.
>
> security/security.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Hi Khadija,

Thanks, but I already merged your original patch :)

https://lore.kernel.org/linux-security-module/abe91475c7f9e3483405c6096006b=
2a9.paul@paul-moore.com/

> diff --git a/security/security.c b/security/security.c
> index d5ff7ff45b77..b76fb27a1dc6 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -4396,6 +4396,13 @@ void security_sk_clone(const struct sock *sk, stru=
ct sock *newsk)
>  }
>  EXPORT_SYMBOL(security_sk_clone);
>
> +/**
> + * security_sk_classify_flow() - Set a flow's secid based on socket
> + * @sk: original socket
> + * @flic: target flow
> + *
> + * Set the target flow's secid to socket's secid.
> + */
>  void security_sk_classify_flow(struct sock *sk, struct flowi_common *fli=
c)
>  {
>         call_void_hook(sk_getsecid, sk, &flic->flowic_secid);
> --
> 2.34.1

--=20
paul-moore.com
