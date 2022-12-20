Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16566C3DA6E
	for <linux-security-module@archiver.kernel.org>; Tue, 20 Dec 2022 22:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiLTWHe (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 20 Dec 2022 17:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234134AbiLTWH0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 20 Dec 2022 17:07:26 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966A71DF07
        for <linux-security-module@vger.kernel.org>; Tue, 20 Dec 2022 14:07:25 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id z8-20020a17090abd8800b00219ed30ce47so167734pjr.3
        for <linux-security-module@vger.kernel.org>; Tue, 20 Dec 2022 14:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jFAFy2cX6p2TxsPpogzDjs9fiQ6UuglhalzGO4odrnI=;
        b=QDsdbXmsvZ+ZTvzBdxGLT8GWYu85ANRweHrwxsJMFBsiDhJRfQXp7fTKPF7hxLgZ+J
         AmUkpodyJAOcjj6LSJXtHEvp4VUUo5c4M6lnLbeul2NakFsw78nbz416BVzTjObpU/Og
         2+2xRaG6P0tWDL/GSVolA+WfbrFJB9t4gNwddm3qKPz2oEVr6HLhuSezPgPdZBfGERNb
         Hm0xida19crW/LZwfehkRKT/V/WK6UxMwpFWqnsQCV8pKzk0+rDWNvrdA7pRVqVBZh/g
         EUNn78E/O5i8T3oS0K7ORBPxMoLNh6uOc04eli9ywvwMLbxr5OtS59lvzmdlv5fCZRRk
         Dzdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jFAFy2cX6p2TxsPpogzDjs9fiQ6UuglhalzGO4odrnI=;
        b=bu32q/iHiqkD9tCCb0rycooRSEJqJPmxz0KLO1JfMwnF5Ju9mu8IAhiq75Lo97JjS5
         /RRwtaQbbqaV1sIj+Yo/UBAz1NRz6u2EDHDEqKSu7qPejWAXToM0dIv0rL93jzNVMHAw
         Bc0v6x965OkirjluFBKtJlkcM1wekxVN2k1sBr534beHEWJTy/UewrRX3ugB++GyJmCW
         aKWmXW7pEhfQs0nQC5TQ9FGEK0Zr612gPOQnTwLrxf6JE2mbE+KDCtO89H4YVSLjCCTz
         +++eHxwxCfr9gUD5xAOtPoeMrOPBszR0TMZ3lTX7TmRSEn1xm4Te39ntaLMX7qufRS0g
         JMNw==
X-Gm-Message-State: AFqh2krQXo+M8HzBDf5jq9FHYNqEii8/jXbaycQRXhiWcWevkjo6Qap9
        cllre7hGA1gv8aMfxr1WZZtSxt8t9J4uKvtHaOGk
X-Google-Smtp-Source: AMrXdXsHspUJoS7HSo5OLC8JbdXBJm3B8unlBAtSokp6tcirCSO9Ki89+7LVWXPWIsCTqcqYf1HoTKFzPM5W66dsCSQ=
X-Received: by 2002:a17:90a:6481:b0:221:5597:5de7 with SMTP id
 h1-20020a17090a648100b0022155975de7mr1983156pjj.147.1671574044825; Tue, 20
 Dec 2022 14:07:24 -0800 (PST)
MIME-Version: 1.0
References: <cover.1671469167.git.pabeni@redhat.com> <3074022fdca04676443a9c74f57328eb729f150e.1671469167.git.pabeni@redhat.com>
In-Reply-To: <3074022fdca04676443a9c74f57328eb729f150e.1671469167.git.pabeni@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 20 Dec 2022 17:07:13 -0500
Message-ID: <CAHC9VhRYr9=qKUeF0EuY46koCnkeZ5d-=umV5TxbiUZ7qNXJ6w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] selinux: Implement mptcp_add_subflow hook
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Dec 19, 2022 at 12:34 PM Paolo Abeni <pabeni@redhat.com> wrote:
>
> Newly added subflows should inherit the associated label
> from the current process context, regarless of the sk_kern_sock
> flag value.
>
> This patch implements the above resetting the subflow sid, deleting
> the existing subflow label, if any, and then re-creating a new one.
>
> The new helper reuses the selinux_netlbl_sk_security_free() function,
> and it can end-up being called multiple times with the same argument;
> we additionally need to make it idempotent.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v1 -> v2:
>  - fix build issue with !CONFIG_NETLABEL
> ---
>  security/selinux/hooks.c    | 27 +++++++++++++++++++++++++++
>  security/selinux/netlabel.c |  4 +++-
>  2 files changed, 30 insertions(+), 1 deletion(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 3c5be76a9199..f785600b666a 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -5476,6 +5476,32 @@ static void selinux_sctp_sk_clone(struct sctp_association *asoc, struct sock *sk
>         selinux_netlbl_sctp_sk_clone(sk, newsk);
>  }
>
> +static int selinux_mptcp_add_subflow(struct sock *sk, struct sock *ssk)
> +{
> +       const struct task_security_struct *tsec = selinux_cred(current_cred());
> +       struct sk_security_struct *ssksec = ssk->sk_security;
> +       u16 sclass;
> +       u32 sid;
> +       int err;
> +
> +       /* create the sid using the current cred, regardless of the ssk kern
> +        * flag
> +        */
> +       sclass = socket_type_to_security_class(ssk->sk_family, ssk->sk_type,
> +                                              ssk->sk_protocol);
> +       err = socket_sockcreate_sid(tsec, sclass, &sid);
> +       if (err)
> +               return err;
> +
> +       ssksec->sid = sid;
> +
> +       /* replace the existing subflow label deleting the existing one
> +        * and re-recrating a new label using the current context
> +        */
> +       selinux_netlbl_sk_security_free(ssksec);
> +       return selinux_netlbl_socket_post_create(ssk, ssk->sk_family);
> +}

I thought the idea was to ensure that new subflows of an existing
MPTCP connection would be created with the same label as the main
MPTCP connection socket?  The code above labels the new subflow based
on the current process, not the main MPTCP connection; it matches the
commit description, but not what we had previously discussed - or I am
horribly mis-remembering something? :)

I was expecting something more like the following:

static int selinux_mptcp_add_subflow(...)
{
  struct sk_security_struct *sksec = sk->sk_security;
  struct sk_security_struct *ssksec = ssk->sk_security;

  ssksec->sclass = sksec->sclass;
  ssksec->sid = sksec->sid;

  selinux_netlbl_sk_security_free(ssksec);
  selinux_netlbl_socket_post_create(ssk, ssk->sk_family);
}

> diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
> index 1321f15799e2..8e0080b8a8ef 100644
> --- a/security/selinux/netlabel.c
> +++ b/security/selinux/netlabel.c
> @@ -155,8 +155,10 @@ void selinux_netlbl_err(struct sk_buff *skb, u16 family, int error, int gateway)
>   */
>  void selinux_netlbl_sk_security_free(struct sk_security_struct *sksec)
>  {
> -       if (sksec->nlbl_secattr != NULL)
> +       if (sksec->nlbl_secattr != NULL) {
>                 netlbl_secattr_free(sksec->nlbl_secattr);
> +               sksec->nlbl_secattr = NULL;
> +       }
>  }

This is pretty nitpicky, but it might be a little cleaner to use the
pattern below.  At the very least I think it tends to better match a
lot of the various free helpers in the kernel.

void free_stuff(void *ptr)
{
  if (!ptr)
    return;
  free_properly(ptr);
}

I would probably also reset sk_security_struct::nlbl_state too, so
maybe something like the following:

void selinux_netlbl_sk_security_free(...)
{
  if (!sksec)
    return;
  netlbl_secattr_free(sksec->nlbl_secattr);
  sksec->nlbl_secattr = NULL;
  sksec->nlbl_state = NLBL_UNSET;
}

-- 
paul-moore.com
