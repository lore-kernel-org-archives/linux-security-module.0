Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB635C4332F
	for <linux-security-module@archiver.kernel.org>; Mon, 13 Nov 2023 04:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjKMELJ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 12 Nov 2023 23:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjKMELI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 12 Nov 2023 23:11:08 -0500
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A698109
        for <linux-security-module@vger.kernel.org>; Sun, 12 Nov 2023 20:11:05 -0800 (PST)
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-4acb1260852so1614027e0c.2
        for <linux-security-module@vger.kernel.org>; Sun, 12 Nov 2023 20:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1699848664; x=1700453464; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9WbW09RQCwQYYA0oy71bWYwQQSt2x1fbL3QKzF3AG4o=;
        b=H+U4PlLTZ1GqE/KBVMAWV3jD75OCNe7hUfF9VmbBGyYUrCuEDEdudohgaSTWqIvhZ4
         kfvv9XygMTJWcaPUhVq1e8ujykKqgGSzUe1hwSxLYuxPX82RowGSYvyDMmmX7kkR9xKK
         SgkNjDveVzyaNCl7PK3VeVQvhd8SeSh9rvoWogedpnEpaeNzjcAC51q4JTaFEvIoPp8E
         f+dFkkxvxocOteF5cn0fMQTtOp8z2k63tn4eqPaIuJHOFEKXiH1xPnusEKXSC6BMl23D
         fDI7un8BOiqkvjty08TMxhGepRj04Y2Q2sTrmEb2sWV+SSOLOTeoAZLUBv0hLVTLSw3I
         z9nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699848664; x=1700453464;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9WbW09RQCwQYYA0oy71bWYwQQSt2x1fbL3QKzF3AG4o=;
        b=i9P2Jnfzd7nv71QmOo8swU26tPWPMuveV8QD6xcEGOeS8ykizH+fvFtgUZvS0bYpV7
         16VpIlkPe/1fN/tOhnHrb3AYRn/XvULAS0AUyU9oWM70L+yWsTl3zClHRvoVrv7jvC8+
         M41Y2LeuzKceofxYhCZkQqw9xUf6tsgjU+wnPzgJBnEJp6wys8wQihIh4Xzhmuna0gxK
         5V3gm/XtajxyEGZ/FVw7yugEwrBTOkI6bVRdGnPseUU0xf3SPi5KTLVduoi2j9jcQGXG
         xIcajwp/EZK0TkCNYjKIxf+RgMVuj7tHPIHHCENCpo3EUnbtnSR47jFrIQcP+lbHlQYN
         S9Bw==
X-Gm-Message-State: AOJu0YweUs/aGV9K9ICp5pJbRzg3xfwq8L/Dcv0jcalWgJB4SH0jsq3h
        +TIpn9a8YIpNuNE4cvVN0ifwVmBRNxYvRbSLCKSeMzCyBLBfwZM=
X-Google-Smtp-Source: AGHT+IEPY6Hauw3tdXUGMOV4VGIIf8fzv0X+9BzpAnPToQ5m2dhriD7MGKuNw6Pd4DDIKrGFgBIgWiW4rqzLEqpbXoc=
X-Received: by 2002:ac5:cadb:0:b0:4ac:174d:4d3d with SMTP id
 m27-20020ac5cadb000000b004ac174d4d3dmr4675668vkl.2.1699848663894; Sun, 12 Nov
 2023 20:11:03 -0800 (PST)
MIME-Version: 1.0
References: <20231110173442.79462-2-paul@paul-moore.com> <CAHC9VhSYO637Q+VE3ypBgvZcUa1X8_FvWmkiC-BGx5deDi_=Cw@mail.gmail.com>
In-Reply-To: <CAHC9VhSYO637Q+VE3ypBgvZcUa1X8_FvWmkiC-BGx5deDi_=Cw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 12 Nov 2023 23:10:29 -0500
Message-ID: <CAHC9VhTeE_vxVvtGN8S8r4tJSiUaoDRJV9Ryw_a3Qwx1mdr1Xw@mail.gmail.com>
Subject: Re: [PATCH] mailmap: update/replace my old email addresses
To:     linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Nov 10, 2023 at 4:37=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Fri, Nov 10, 2023 at 12:34=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> >
> > I was recently reminded by someone who was unable to reach my old
> > email address that I really should update the kernel's .mailmap
> > so that people looking for me in old commits can reach my current
> > email.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  .mailmap | 2 ++
> >  1 file changed, 2 insertions(+)
>
> Merged into lsm/dev-staging.

Merged into lsm/dev.

--=20
paul-moore.com
