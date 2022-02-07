Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D978C433F5
	for <linux-security-module@archiver.kernel.org>; Mon,  7 Feb 2022 16:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241373AbiBGQaE (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 7 Feb 2022 11:30:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388545AbiBGQRw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 7 Feb 2022 11:17:52 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19DDC0401CF
        for <linux-security-module@vger.kernel.org>; Mon,  7 Feb 2022 08:17:51 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id a19so176401vsi.2
        for <linux-security-module@vger.kernel.org>; Mon, 07 Feb 2022 08:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Gw/4UW15eYzSdi+TxSzYDRCdQSLS3TL9tdscCSdyYxg=;
        b=InXVv1jEZyzsy5z7eBG0uEfkymyD+xApXVpYh2qTWDc4lE+xqmJZ9QWZ4+UoK7Ii1s
         uoNEovvqySCIDsLm+OG4eWryIzbsCGkRVNqhr0/4iIstT4vsLOFtHFLYukv+kK3eVBs7
         chVNMKIbOiU9O57WWrbsitI4a7ccgHFvPrhPulfHmDSyVZzmZM8yYeMuRMYMPYRXUwQB
         egv/iqGX8AhyWnq+x5SPFiW7E8gT29om3mtDOrWofXM0Iwuds2J5FcaEhjvmLe+ZUaLR
         cshrxapm87uGiOSw34GBJN26WykSBTlGfw+Sf17dTTRRpGvXN5kCtlyYDGSGQRtM+FTI
         2Ziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Gw/4UW15eYzSdi+TxSzYDRCdQSLS3TL9tdscCSdyYxg=;
        b=E4MbhlWjvbSlG4h00nX54ftTMwB9/K+Mlw15SOClejVMGUut3HICgd5K8RmE2s8rh5
         MEttiP8QgV9E7znLA1wh0cvQCnSG6u3DZBvjfrIpJ5K9fmP2dwlYCQkvWlsihjQjrpvt
         8Fr6yYTjmvIjKsF7EE8rYbIYM6xkxi1AkNOS8UDKnTvX20d8nNbCYhXhTmA2Yab7btE3
         wUBZbRxdhxw2FsrzcZKkxojDaB16NNN2Bar96Z+Hp5aBBLDUV4YyOsKeWBwxPKUtN2Zm
         pDcEga1kJ+nGnxGlxR0ju5fUpVUWwNOeEchMDV+4faKvswl2DnL688Kh8yT32THEEMpH
         tTRg==
X-Gm-Message-State: AOAM5315TLdNDOKJ6Vvm8Hb8jVux7iWJ0MMKjDB3vL9k/YlXaT/qo7If
        D2DQcytRUZSNS2Jq4sysWRInNFQULns=
X-Google-Smtp-Source: ABdhPJyV7fU3HOz12OQ5hhVRGQg49qreBoUwPyRFFtNsnrlErL86X5baSqMZkIxRhGXLOgh15dNyCA==
X-Received: by 2002:a05:6102:a4c:: with SMTP id i12mr128567vss.11.1644250670934;
        Mon, 07 Feb 2022 08:17:50 -0800 (PST)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id j63sm267913vkj.24.2022.02.07.08.17.50
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 08:17:50 -0800 (PST)
Received: by mail-vs1-f53.google.com with SMTP id f6so177606vsa.5
        for <linux-security-module@vger.kernel.org>; Mon, 07 Feb 2022 08:17:50 -0800 (PST)
X-Received: by 2002:a05:6102:354f:: with SMTP id e15mr69589vss.74.1644250670162;
 Mon, 07 Feb 2022 08:17:50 -0800 (PST)
MIME-Version: 1.0
References: <20220124080215.265538-1-konstantin.meskhidze@huawei.com>
 <20220124080215.265538-2-konstantin.meskhidze@huawei.com> <CA+FuTSf4EjgjBCCOiu-PHJcTMia41UkTh8QJ0+qdxL_J8445EA@mail.gmail.com>
 <0934a27a-d167-87ea-97d2-b3ac952832ff@huawei.com> <CA+FuTSc8ZAeaHWVYf-zmn6i5QLJysYGJppAEfb7tRbtho7_DKA@mail.gmail.com>
 <d84ed5b3-837a-811a-6947-e857ceba3f83@huawei.com> <CA+FuTSeVhLdeXokyG4x__HGJyNOwsSicLOb4NKJA-gNp59S5uA@mail.gmail.com>
 <0d33f7cd-6846-5e7e-62b9-fbd0b28ecea9@digikod.net> <91885a8f-b787-62ff-1abb-700641f7c2cb@huawei.com>
 <CA+FuTScaoby-=xRKf_Dz3koSYHqrMN0cauCg4jMmy_nDxwPADA@mail.gmail.com>
In-Reply-To: <CA+FuTScaoby-=xRKf_Dz3koSYHqrMN0cauCg4jMmy_nDxwPADA@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 7 Feb 2022 11:17:13 -0500
X-Gmail-Original-Message-ID: <CA+FuTSc6BfWKu1taQr7wPoQ4VJg3Au1PH-rbTa71-srLzARL-A@mail.gmail.com>
Message-ID: <CA+FuTSc6BfWKu1taQr7wPoQ4VJg3Au1PH-rbTa71-srLzARL-A@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] landlock: TCP network hooks implementation
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        netfilter@vger.kernel.org, yusongping@huawei.com,
        artem.kuzin@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

> >   If bind() function has already been restricted so the following
> > listen() function is automatically banned. I agree with Micka=D1=91l ab=
out
> > the usecase here. Why do we need new-bound socket with restricted liste=
ning?
>
> The intended use-case is for a privileged process to open a connection
> (i.e., bound and connected socket) and pass that to a restricted
> process. The intent is for that process to only be allowed to
> communicate over this pre-established channel.
>
> In practice, it is able to disconnect (while staying bound) and
> elevate its privileges to that of a listening server:
>
> static void child_process(int fd)
> {
>         struct sockaddr addr =3D { .sa_family =3D AF_UNSPEC };
>         int client_fd;
>
>         if (listen(fd, 1) =3D=3D 0)
>                 error(1, 0, "listen succeeded while connected");
>
>         if (connect(fd, &addr, sizeof(addr)))
>                 error(1, errno, "disconnect");
>
>         if (listen(fd, 1))
>                 error(1, errno, "listen");
>
>         client_fd =3D accept(fd, NULL, NULL);
>         if (client_fd =3D=3D -1)
>                 error(1, errno, "accept");
>
>         if (close(client_fd))
>                 error(1, errno, "close client");
> }
>
> int main(int argc, char **argv)
> {
>         struct sockaddr_in6 addr =3D { 0 };
>         pid_t pid;
>         int fd;
>
>         fd =3D socket(PF_INET6, SOCK_STREAM, 0);
>         if (fd =3D=3D -1)
>                 error(1, errno, "socket");
>
>         addr.sin6_family =3D AF_INET6;
>         addr.sin6_addr =3D in6addr_loopback;
>
>         addr.sin6_port =3D htons(8001);
>         if (bind(fd, (void *)&addr, sizeof(addr)))
>                 error(1, errno, "bind");
>
>         addr.sin6_port =3D htons(8000);
>         if (connect(fd, (void *)&addr, sizeof(addr)))
>                 error(1, errno, "connect");
>
>         pid =3D fork();
>         if (pid =3D=3D -1)
>                 error(1, errno, "fork");
>
>         if (pid)
>                 wait(NULL);
>         else
>                 child_process(fd);
>
>         if (close(fd))
>                 error(1, errno, "close");
>
>         return 0;
> }
>
> It's fine to not address this case in this patch series directly, of
> course. But we should be aware of the AF_UNSPEC loophole.

I did just notice that with autobind (i.e., without the explicit call
to bind), the socket gets a different local port after listen. So
internally a bind call may be made, which may or may not be correctly
handled by the current landlock implementation already:

+static void show_local_port(int fd)
+{
+       char addr_str[INET6_ADDRSTRLEN];
+       struct sockaddr_in6 addr =3D { 0 };
+       socklen_t alen;
+
+       alen =3D sizeof(addr);
+       if (getsockname(fd, (void *)&addr, &alen))
+               error(1, errno, "getsockname");
+
+       if (addr.sin6_family !=3D AF_INET6)
+               error(1, 0, "getsockname: family");
+
+       if (!inet_ntop(AF_INET6, &addr.sin6_addr, addr_str, sizeof(addr_str=
)))
+               error(1, errno, "inet_ntop");
+       fprintf(stderr, "server: %s:%hu\n", addr_str, ntohs(addr.sin6_port)=
);
+
+}
+
@@ -23,6 +42,8 @@ static void child_process(int fd)
        if (connect(fd, &addr, sizeof(addr)))
                error(1, errno, "disconnect");

+       show_local_port(fd);
+
        if (listen(fd, 1))
                error(1, errno, "listen");

+       show_local_port(fd);
+

@@ -47,10 +68,6 @@ int main(int argc, char **argv)
        addr.sin6_family =3D AF_INET6;
        addr.sin6_addr =3D in6addr_loopback;

-       addr.sin6_port =3D htons(8001);
-       if (bind(fd, (void *)&addr, sizeof(addr)))
-               error(1, errno, "bind");
-
        addr.sin6_port =3D htons(8000);
        if (connect(fd, (void *)&addr, sizeof(addr)))
                error(1, errno, "connect");
