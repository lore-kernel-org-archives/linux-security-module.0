Return-Path: <SRS0=Rr8+=WM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64537C3A59C
	for <linux-security-module@archiver.kernel.org>; Fri, 16 Aug 2019 00:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 324BA2089E
	for <linux-security-module@archiver.kernel.org>; Fri, 16 Aug 2019 00:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="aacTW4DY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbfHPAzD (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 15 Aug 2019 20:55:03 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37403 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfHPAzD (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 15 Aug 2019 20:55:03 -0400
Received: by mail-pg1-f194.google.com with SMTP id d1so1479262pgp.4
        for <linux-security-module@vger.kernel.org>; Thu, 15 Aug 2019 17:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=IF0jyuisXYKPSxXocSmf9hJgGkzQWtijePSZe+9Ib1E=;
        b=aacTW4DY/xF/TLNPmr3l/xdylKWJ+mwD/wwKjI0I+zMseIi8TR2/skd2hbKGCp15OU
         9498d/M7A4eW1ON7xbYdR1zwWqg4ezmxYDd5NsKFfxlA5gjQUvEOhwz+gHNB45bW0hVR
         /60gYHkY9mgdDKxFuWb4IClJ8Ca+Et+HaA5DHC+kbcj79Tyb0zI7MzWeKMOmHC/Q9vf9
         yzy2zQTmfTDgYaOeh4qJq6/cM805T8F8Tl+yxEfhlUvh/Cjih6jZya/3oAzmvLn5zQHg
         svAyJ9wvAwYavsMfk4d1gslJjf9vBICM44T0vCo1nSDrGj5EtL8fT9nhX5p87kNSgll5
         TuYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=IF0jyuisXYKPSxXocSmf9hJgGkzQWtijePSZe+9Ib1E=;
        b=XLf3o7R4xO41Jn43SQrO0IIKZhytYu1InjHUvfpzDm2OHkIyxPJoRyeO8Wzg4Z8DXM
         MMApum4nkqVvrVBgcafmVWbW/nwn/fuiJLgK9ApkmUTW5dC8IScPeuL0GPDmn+zdRaIx
         WdtI2H9P4WXK8UkgyY5I91uDOczdfpcLtJ7anrMzXWdFZuN56agjBGuewhQm9UIZjIVW
         7s5X0EW0xE2BqqGkTHCC1f1QHPGAKukQSGoYtJPko2mGfpkFpiBRxDG1i7uDQAt6/dKB
         ZfN7tBiHA7kPTPRSyED1ne4iQuI+BtMGZgO5fE/HBeDPQGwLi9fbE7GaeX3RmY5w7tWe
         ph2Q==
X-Gm-Message-State: APjAAAVPkoytG8TTi1TkW1kzbEZAN/VUwjv53nl8nD2PYO2ocopAcaWK
        fpkmLhb16MPZgOAk3JZBmU+0Qw==
X-Google-Smtp-Source: APXvYqwdU5aqqyiGUpyQI8Y3c3tMMMEnapfMFu9fyEsNFjhIsmoAc6ujEVdkwHSQMyIecx/UIjK64g==
X-Received: by 2002:a63:b20f:: with SMTP id x15mr5726067pge.453.1565916902350;
        Thu, 15 Aug 2019 17:55:02 -0700 (PDT)
Received: from ?IPv6:2600:1010:b04e:b450:9121:34aa:70f4:e97c? ([2600:1010:b04e:b450:9121:34aa:70f4:e97c])
        by smtp.gmail.com with ESMTPSA id e188sm3994528pfa.76.2019.08.15.17.55.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Aug 2019 17:55:01 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 bpf-next 1/4] bpf: unprivileged BPF access via /dev/bpf
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16G77)
In-Reply-To: <20190815234622.t65oxm5mtfzy6fhg@ast-mbp.dhcp.thefacebook.com>
Date:   Thu, 15 Aug 2019 17:54:59 -0700
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Jann Horn <jannh@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B0364660-AD6A-4E5C-B04F-3B6DA78B4BBE@amacapital.net>
References: <CALCETrUjh6DdgW1qSuSRd1_=0F9CqB8+sNj__e_6AHEvh_BaxQ@mail.gmail.com> <CALCETrWtE2U4EvZVYeq8pSmQjBzF2PHH+KxYW8FSeF+W=1FYjw@mail.gmail.com> <EE7B7AE1-3D44-4561-94B9-E97A626A251D@fb.com> <CALCETrXX-Jeb4wiQuL6FUai4wNMmMiUxuLLh_Lb9mT7h=0GgAw@mail.gmail.com> <20190805192122.laxcaz75k4vxdspn@ast-mbp> <CALCETrVtPs8gY-H4gmzSqPboid3CB++n50SvYd6RU9YVde_-Ow@mail.gmail.com> <20190806011134.p5baub5l3t5fkmou@ast-mbp> <CALCETrXEHL3+NAY6P6vUj7Pvd9ZpZsYC6VCLXOaNxb90a_POGw@mail.gmail.com> <20190813215823.3sfbakzzjjykyng2@ast-mbp> <201908151203.FE87970@keescook> <20190815234622.t65oxm5mtfzy6fhg@ast-mbp.dhcp.thefacebook.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>



> On Aug 15, 2019, at 4:46 PM, Alexei Starovoitov <alexei.starovoitov@gmail.=
com> wrote:


>>=20
>> I'm not sure why you draw the line for VMs -- they're just as buggy
>> as anything else. Regardless, I reject this line of thinking: yes,
>> all software is buggy, but that isn't a reason to give up.
>=20
> hmm. are you saying you want kernel community to work towards
> making containers (namespaces) being able to run arbitrary code
> downloaded from the internet?

Yes.

As an example, Sandstorm uses a combination of namespaces (user, network, mo=
unt, ipc) and a moderately permissive seccomp policy to run arbitrary code. N=
ot just little snippets, either =E2=80=94 node.js, Mongo, MySQL, Meteor, and=
 other fairly heavyweight stacks can all run under Sandstorm, with the whole=
 stack (database engine binaries, etc) supplied by entirely untrusted custom=
ers.  During the time Sandstorm was under active development, I can recall *=
one* bug that would have allowed a sandbox escape. That=E2=80=99s a pretty g=
ood track record.  (Also, Meltdown and Spectre, sigh.)

To be clear, Sandstorm did not allow creation of a userns by the untrusted c=
ode, and Sandstorm would have heavily restricted bpf(), but that should only=
 be necessary because of the possibility of kernel bugs, not because of the o=
verall design.

Alexei, I=E2=80=99m trying to encourage you to aim for something even better=
 than you have now. Right now, if you grant a user various very strong capab=
ilities, that user=E2=80=99s systemd can use bpf network filters.  Your prop=
osal would allow this with a different, but still very strong, set of capabi=
lities. There=E2=80=99s nothing wrong with this per se, but I think you can a=
im much higher:

CAP_NET_ADMIN and your CAP_BPF both effectively allow the holder to take ove=
r the system, *by design*.  I=E2=80=99m suggesting that you engage the secur=
ity community (Kees, myself, Aleksa, Jann, Serge, Christian, etc) to aim for=
 something better: make it so that a normal Linux distro would be willing to=
 relax its settings enough so that normal users can use bpf filtering in the=
 systemd units and maybe eventually use even more bpf() capabilities. And le=
t=E2=80=99s make is to that mainstream container managers (that use userns!)=
 will be willing (as an option) to delegate bpf() to their containers. We=E2=
=80=99re happy to help design, review, and even write code, but we need you t=
o be willing to work with us to make a design that seems like it will work a=
nd then to wait long enough to merge it for us to think about it, try to pok=
e holes in it, and convince ourselves and each other that it has a good chan=
ce of being sound.

Obviously there will be many cases where an unprivileged program should *not=
* be able to use bpf() IP filtering, but let=E2=80=99s make it so that enabl=
ing these advanced features does not automatically give away the keys to the=
 kingdom.

(Sandstorm still exists but is no longer as actively developed, sadly.)=
