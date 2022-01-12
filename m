Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE9CC433EF
	for <linux-security-module@archiver.kernel.org>; Wed, 12 Jan 2022 17:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349943AbiALRXS (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 12 Jan 2022 12:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349903AbiALRXR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 12 Jan 2022 12:23:17 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460FAC061751
        for <linux-security-module@vger.kernel.org>; Wed, 12 Jan 2022 09:23:17 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id w16so12700549edc.11
        for <linux-security-module@vger.kernel.org>; Wed, 12 Jan 2022 09:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E+GKoVKVOccM1dkHK89h18D/i/ewkNsD1XD52+ih008=;
        b=YY7EmduOKEk8dWB6cII/ef1v9AxvCOr1SnL3fx6/ZNGGk67oKF+qRhYprPqE+3oFN/
         g+b5/83+y67yADjCpXPuZfvYhZzO5nqqhuQ2fbT5er9pPGlUNj+57ySElgYffNsP2GEZ
         /umsblvoP1yyVcVXtkDgnfyJPHwp0gJSSyU4JM+8Cao6+mFbXBVQxs3WpD7UQGYHWjN8
         IpEACg6dKFoEeuH0Xv/5297woB+oPpU/R+8PyR4ouKNfZM1hhgRjcepzNvRhCkShvH2d
         vwBaFoMikYcXnqYJpqr22e3sJwwV62Nx+0crvK2xH59oKw5Aaq3zZUaLDu/DY+4cT7+o
         ldlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E+GKoVKVOccM1dkHK89h18D/i/ewkNsD1XD52+ih008=;
        b=ekyUbAxLfca5Seh3DvBVS/qffCwVBuuDV/FNmnEYiHHoLEMty17PIMXPQliUnmgOva
         QVDkPaQ/SHdLy7fDvM9rdB5f404jKXc8ZPqBLDr0rJE+35UhqjHtqdDGmGJ1wAliLDuw
         SGEpRqMaUMguV22r0Ayaad8nLHfslIli+nY1HYk08KKl3hFXevg3JLkizsFzJ2LqL+4a
         b4eR8cntL7jZyKzQukb+jhA3l+iuIYl+IUD2/uBW3pqtwVG2/28fhf7RDHGPNtrbMTb/
         KEnqBUqq+noYleNxMegez0lmUFMRAVOIbOO6i54gZAU2FXub8oRKAdvwBCt2FGkTZLWp
         7kPA==
X-Gm-Message-State: AOAM533txZ6BTC1AnwUH4U+GhVdXYNWoBsu44BCVhqfBIY4KoF/T048H
        OZyVXvWWD7AyY7b+e2um34/a11eSYja3REkspsdj
X-Google-Smtp-Source: ABdhPJxv2JamqB8KhkNB2ZizekiRoIe5nQT6otoSikAytVEhtNxSH4AwmjXTFL7tWFAgtQSeUywiYRYw/dNvZlQVbRk=
X-Received: by 2002:a17:907:9687:: with SMTP id hd7mr600079ejc.12.1642008195767;
 Wed, 12 Jan 2022 09:23:15 -0800 (PST)
MIME-Version: 1.0
References: <tencent_425C87AB28D1FF53823C3047E48A71FC520A@qq.com>
In-Reply-To: <tencent_425C87AB28D1FF53823C3047E48A71FC520A@qq.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 12 Jan 2022 12:23:04 -0500
Message-ID: <CAHC9VhT018QQmjYdh1ftOYrMC9ZxMqKtkBU2dceF=PLg2j6rvQ@mail.gmail.com>
Subject: Re: [PATCH] integrity: check the return value of audit_log_start()
To:     xkernel.wang@foxmail.com
Cc:     jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Dec 14, 2021 at 12:39 AM <xkernel.wang@foxmail.com> wrote:
>
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
>
> audit_log_start() returns audit_buffer pointer on success or NULL on
> error, so it is better to check the return value of it to prevent
> potential memory access error.
>
> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
> ---
>  security/integrity/integrity_audit.c | 38 +++++++++++++++-------------
>  1 file changed, 20 insertions(+), 18 deletions(-)
>
> diff --git a/security/integrity/integrity_audit.c b/security/integrity/integrity_audit.c
> index 2922005..62785d5 100644
> --- a/security/integrity/integrity_audit.c
> +++ b/security/integrity/integrity_audit.c
> @@ -45,23 +45,25 @@ void integrity_audit_message(int audit_msgno, struct inode *inode,
>                 return;
>
>         ab = audit_log_start(audit_context(), GFP_KERNEL, audit_msgno);

As this is IMA code, it's largely up to Mimi about what she would
prefer, but I think a much simpler patch would be to just return early
if ab == NULL, for example:

  ab = audit_log_start( .... , audit_msgno);
  if (!ab)
    return;

> -       audit_log_format(ab, "pid=%d uid=%u auid=%u ses=%u",
> -                        task_pid_nr(current),
> -                        from_kuid(&init_user_ns, current_uid()),
> -                        from_kuid(&init_user_ns, audit_get_loginuid(current)),
> -                        audit_get_sessionid(current));
> -       audit_log_task_context(ab);
> -       audit_log_format(ab, " op=%s cause=%s comm=", op, cause);
> -       audit_log_untrustedstring(ab, get_task_comm(name, current));
> -       if (fname) {
> -               audit_log_format(ab, " name=");
> -               audit_log_untrustedstring(ab, fname);
> +       if (ab) {
> +               audit_log_format(ab, "pid=%d uid=%u auid=%u ses=%u",
> +                               task_pid_nr(current),
> +                               from_kuid(&init_user_ns, current_uid()),
> +                               from_kuid(&init_user_ns, audit_get_loginuid(current)),
> +                               audit_get_sessionid(current));
> +               audit_log_task_context(ab);
> +               audit_log_format(ab, " op=%s cause=%s comm=", op, cause);
> +               audit_log_untrustedstring(ab, get_task_comm(name, current));
> +               if (fname) {
> +                       audit_log_format(ab, " name=");
> +                       audit_log_untrustedstring(ab, fname);
> +               }
> +               if (inode) {
> +                       audit_log_format(ab, " dev=");
> +                       audit_log_untrustedstring(ab, inode->i_sb->s_id);
> +                       audit_log_format(ab, " ino=%lu", inode->i_ino);
> +               }
> +               audit_log_format(ab, " res=%d errno=%d", !result, errno);
> +               audit_log_end(ab);
>         }
> -       if (inode) {
> -               audit_log_format(ab, " dev=");
> -               audit_log_untrustedstring(ab, inode->i_sb->s_id);
> -               audit_log_format(ab, " ino=%lu", inode->i_ino);
> -       }
> -       audit_log_format(ab, " res=%d errno=%d", !result, errno);
> -       audit_log_end(ab);
>  }
> --



-- 
paul moore
www.paul-moore.com
