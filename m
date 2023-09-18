Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0B9CD37B0
	for <linux-security-module@archiver.kernel.org>; Mon, 18 Sep 2023 16:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjIRQSq (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 18 Sep 2023 12:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjIRQSc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 18 Sep 2023 12:18:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0133B25444
        for <linux-security-module@vger.kernel.org>; Mon, 18 Sep 2023 09:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695053724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n7LnswCOaGW4WDijQcX3CV0DLHpeotxjqcHToesSIKc=;
        b=Y0H6hFsX7aCf/ywi175CwSmcUekn9+M0B57vfd18spx2zLcAAqvDaxGRUWMpGNhYh7G6Rm
        Si0H/dE791PaIFZx5laVSV+br2lIJSHvKq5enfham2wLIZDbez1diIbdlelkvzHOdYBU2n
        7Agop8iGVGW2LEypRIuJSx7J/GhN6cY=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-33za7ZhyO3qT45uZsLvVrA-1; Mon, 18 Sep 2023 10:14:14 -0400
X-MC-Unique: 33za7ZhyO3qT45uZsLvVrA-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-274abe07e94so1732057a91.1
        for <linux-security-module@vger.kernel.org>; Mon, 18 Sep 2023 07:14:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695046453; x=1695651253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n7LnswCOaGW4WDijQcX3CV0DLHpeotxjqcHToesSIKc=;
        b=qeXKvDHBoAVuOJ9WbssOrjIKTj166jWe0jsb9UrJqlkXdKbH9ZW73KbpCFuCrFEWjk
         3kckLeo+74B4nVzjgOkjFCjjCkzVtpx7NF3MZWaFhLihLt7kEaqgAR0eiNVLiM2kS7PE
         5e+zWa0LkwQ2ZhHSleT4lTUiE2vuRWe3uKQapJgeQmEK8b/fIy9xqA1EcmAbSDKx3XLJ
         pMZdgy1J8ShpIZwMeqXgPy4o290qmbA2raOJPQJXvKMVQq7ckdgpRUZsoPhYLpepYord
         wrFZO7IGAwEeKxSDkFZYZA05sqYmPpwtHQwT1fQlnnMOInQtOdgq0+KPgV5EgwAWdvUP
         Ns5g==
X-Gm-Message-State: AOJu0YyZiN23tg0mNtmfxorYuzbubmMVy++whQASFWLaOhLVuYZfwjJ5
        zAff5HFdcI0xVJSXUcv4UjY87/0KMz174Z2JnWZks1/j/sDfcA5OWFj7pZ29hY7D1xv/B9yCqaw
        Nm6w8bYumKVNfXgBL90ST/dXqOlfuOAprqYCkMiQE5ZlBf/ahK66h
X-Received: by 2002:a17:90a:5d92:b0:26b:374f:97c2 with SMTP id t18-20020a17090a5d9200b0026b374f97c2mr12211748pji.6.1695046453473;
        Mon, 18 Sep 2023 07:14:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7+neZJHpQgC1WYfw1UrSUZAhW6hjsbs2O6fe1ylMjIdtirlIwv14K9Cp0eRu/9VmEWd+vz5/135X2Ocy1Brk=
X-Received: by 2002:a17:90a:5d92:b0:26b:374f:97c2 with SMTP id
 t18-20020a17090a5d9200b0026b374f97c2mr12211725pji.6.1695046453181; Mon, 18
 Sep 2023 07:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230913152238.905247-1-mszeredi@redhat.com> <20230913152238.905247-3-mszeredi@redhat.com>
 <20230914-salzig-manifest-f6c3adb1b7b4@brauner> <CAJfpegs-sDk0++FjSZ_RuW5m-z3BTBQdu4T9QPtWwmSZ1_4Yvw@mail.gmail.com>
 <20230914-lockmittel-verknallen-d1a18d76ba44@brauner> <CAJfpegt-VPZP3ou-TMQFs1Xupj_iWA5ttC2UUFKh3E43EyCOQQ@mail.gmail.com>
 <20230918-grafik-zutreffen-995b321017ae@brauner>
In-Reply-To: <20230918-grafik-zutreffen-995b321017ae@brauner>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Mon, 18 Sep 2023 16:14:02 +0200
Message-ID: <CAOssrKfS79=+F0h=XPzJX2E6taxAPmEJEYPi4VBNQjgRR5ujqw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] add statmnt(2) syscall
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Sep 18, 2023 at 3:51=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:

> I really would prefer a properly typed struct and that's what everyone
> was happy with in the session as well. So I would not like to change the
> main parameters.

I completely  agree.  Just would like to understand this point:

  struct statmnt *statmnt(u64 mntid, u64 mask, unsigned int flags);

What's not properly typed about this interface?

I guess the answer is that it's not a syscall interface, which will
have an added [void *buf, size_t bufsize], while the buffer sizing is
done by a simple libc wrapper.

Do you think that's a problem?  If so, why?

Thanks,
Miklos

