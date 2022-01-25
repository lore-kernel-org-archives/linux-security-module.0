Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A41C433EF
	for <linux-security-module@archiver.kernel.org>; Tue, 25 Jan 2022 14:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578865AbiAYOV1 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 25 Jan 2022 09:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1578287AbiAYORt (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 25 Jan 2022 09:17:49 -0500
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A71C061753
        for <linux-security-module@vger.kernel.org>; Tue, 25 Jan 2022 06:17:49 -0800 (PST)
Received: by mail-vk1-xa2a.google.com with SMTP id m131so12442472vkm.7
        for <linux-security-module@vger.kernel.org>; Tue, 25 Jan 2022 06:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K9qNYEguOKx8AbCzHGgE3pgKrH/csc5za8weZ+n8ZZg=;
        b=LS7D4KNsPJm+YayCIFnCNcWjxylNoNw76n+xa/aqD7ItWtHSu1WRHB9yIn8y3TUNPA
         dEYVHfrxQ7mzWI0eYoamdm7KWjxJQS2JrVak6Mwqcel5fZ3CS4x2AAXnjjZsRrP212CQ
         WApKf2bqXjzUdlba0CtSBhB0NgDGnChhkJMIwEif33CGe3FYZX2uK+2loylJPwHFCAfI
         +cFAVegIQ6WWXh9I5v2nwTzMdOv2f+9BrYEqmF8QMi3MFBFrYE6+TgzYs+dzxVVllnab
         /owNzn5URyT6TyiaPMPf64C6dLSPcz5PHCZlTKW9NjL/eIF5QYSfDCOyD1nY0nthq9eR
         kx5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K9qNYEguOKx8AbCzHGgE3pgKrH/csc5za8weZ+n8ZZg=;
        b=aX11piz4WM2YE+Vfu71Y4wi+zL2zpiJO4s8OwIcOK+bJV5EQrTxa9PAo+1l5J6EDJ7
         g3KFx9N2KYINA8a5rXdu1bUABPZ3xdj3mCztJtlxfjWs4PmtGJ7C4hW/NI607M8Bp3MZ
         4OPdIW2DJjOmtOWAOGxnBX7ZX0jivm/D/Z4+DFL0bMFMeAUFzeTNYkp4yT+UoS7cbagN
         YKijTmAOqQcou3Xt+MbzCyXG0KwqMUJFw7tghy3j3WO4hhptXMHAEfnQE7E8JuMBUaiE
         hGQXHcA5UfATA/NPT74El03lj+MdwfKVch2goRYVibajuL/voVbGlhOcmpmDve0YJTAY
         Eufg==
X-Gm-Message-State: AOAM531TtVl4dXNHWOIWQFEciLXfHN7zaswOa5F1k9HcIti1O3lDZPu5
        X47ww0tHFWdL/T1LQ0cqdfArlUiSFRk=
X-Google-Smtp-Source: ABdhPJwd4vQzRiZPlfRcB9F6nSjkjR2Urw6y4gJVWLlaTtUREoNLBxPVu46HBxY57Qm4APYd6PdXeA==
X-Received: by 2002:a1f:784d:: with SMTP id t74mr4666699vkc.22.1643120268355;
        Tue, 25 Jan 2022 06:17:48 -0800 (PST)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id 187sm1902599vsi.12.2022.01.25.06.17.46
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 06:17:47 -0800 (PST)
Received: by mail-ua1-f50.google.com with SMTP id l1so35758198uap.8
        for <linux-security-module@vger.kernel.org>; Tue, 25 Jan 2022 06:17:46 -0800 (PST)
X-Received: by 2002:a67:d389:: with SMTP id b9mr4563384vsj.79.1643120266518;
 Tue, 25 Jan 2022 06:17:46 -0800 (PST)
MIME-Version: 1.0
References: <20220124080215.265538-1-konstantin.meskhidze@huawei.com> <20220124080215.265538-2-konstantin.meskhidze@huawei.com>
In-Reply-To: <20220124080215.265538-2-konstantin.meskhidze@huawei.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Tue, 25 Jan 2022 09:17:10 -0500
X-Gmail-Original-Message-ID: <CA+FuTSf4EjgjBCCOiu-PHJcTMia41UkTh8QJ0+qdxL_J8445EA@mail.gmail.com>
Message-ID: <CA+FuTSf4EjgjBCCOiu-PHJcTMia41UkTh8QJ0+qdxL_J8445EA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] landlock: TCP network hooks implementation
To:     Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc:     mic@digikod.net, linux-security-module@vger.kernel.org,
        netdev@vger.kernel.org, netfilter@vger.kernel.org,
        yusongping@huawei.com, artem.kuzin@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jan 24, 2022 at 3:02 AM Konstantin Meskhidze
<konstantin.meskhidze@huawei.com> wrote:
>
> Support of socket_bind() and socket_connect() hooks.
> Current prototype can restrict binding and connecting of TCP
> types of sockets. Its just basic idea how Landlock could support
> network confinement.
>
> Changes:
> 1. Access masks array refactored into 1D one and changed
> to 32 bits. Filesystem masks occupy 16 lower bits and network
> masks reside in 16 upper bits.
> 2. Refactor API functions in ruleset.c:
>     1. Add void *object argument.
>     2. Add u16 rule_type argument.
> 3. Use two rb_trees in ruleset structure:
>     1. root_inode - for filesystem objects
>     2. root_net_port - for network port objects
>
> Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>

> +static int hook_socket_connect(struct socket *sock, struct sockaddr *address, int addrlen)
> +{
> +       short socket_type;
> +       struct sockaddr_in *sockaddr;
> +       u16 port;
> +       const struct landlock_ruleset *const dom = landlock_get_current_domain();
> +
> +       /* Check if the hook is AF_INET* socket's action */
> +       if ((address->sa_family != AF_INET) && (address->sa_family != AF_INET6))
> +               return 0;

Should this be a check on the socket family (sock->ops->family)
instead of the address family?

It is valid to pass an address with AF_UNSPEC to a PF_INET(6) socket.
And there are legitimate reasons to want to deny this. Such as passing
a connection to a unprivileged process and disallow it from disconnect
and opening a different new connection.

> +
> +       socket_type = sock->type;
> +       /* Check if it's a TCP socket */
> +       if (socket_type != SOCK_STREAM)
> +               return 0;
> +
> +       if (!dom)
> +               return 0;
> +
> +       /* Get port value in host byte order */
> +       sockaddr = (struct sockaddr_in *)address;
> +       port = ntohs(sockaddr->sin_port);
> +
> +       return check_socket_access(dom, port, LANDLOCK_ACCESS_NET_CONNECT_TCP);
> +}
