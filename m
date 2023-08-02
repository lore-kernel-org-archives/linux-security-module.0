Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04CAC41513
	for <linux-security-module@archiver.kernel.org>; Wed,  2 Aug 2023 08:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbjHBIEU (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 2 Aug 2023 04:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbjHBIER (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 2 Aug 2023 04:04:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D21E1A7
        for <linux-security-module@vger.kernel.org>; Wed,  2 Aug 2023 01:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690963401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Oo+8dg/DBj2V+G5oZvUMnojMP7aeWCXmA1VlhFSPE34=;
        b=SXn6W5xWy8NeVTte4GPeviFPpf2UqFaOMoJD58BA5unExfin1QiHN7Bx30n2mntnThe6pO
        HKLcdRogmd1E/GpxFp1HLd7N+E4h6iZ3ILh41epV4Gfcyftt4OfQQc73ja1yizO77Mor6r
        PMBYc6c3XwjGlMNrzxJg6jw+RLHAaf4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-83gG24fNOLqggQtK-SoNUg-1; Wed, 02 Aug 2023 04:03:20 -0400
X-MC-Unique: 83gG24fNOLqggQtK-SoNUg-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-76ca3baaec8so76571085a.1
        for <linux-security-module@vger.kernel.org>; Wed, 02 Aug 2023 01:03:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690963399; x=1691568199;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oo+8dg/DBj2V+G5oZvUMnojMP7aeWCXmA1VlhFSPE34=;
        b=DVEHHUM3H84DHTfpgYd9rf0RqBpbYQ9l64JFwwMxUMLNbnUmdAcUzWZXQmytmeJEC2
         XhIzQ3ez3GAO4nFqwqdX7WEx6rlSKp0y0ccBJGJSkv5STG5e/i9v45m5mEJMAV+6QhKb
         GBfB+hXGtkDb20sGpr2ZGrtil5PuFvNm5poYKMJp6eJnwln11MqtHRqMqRllgWy5QdoV
         GtaHkiAhfv4rEeVrRHXuu/F9T9pMZDQf6Ukiv0J3OQTn6bvNkHa4s0FzEkjNMhB/Xavb
         Fzy7oPpvn1X8rK5D+kGnCvSzc+h2IbyQrmJ1osPWeG/3KxriVQlRJbssZeBjY1jIHF+8
         a58w==
X-Gm-Message-State: ABy/qLZpmGaWcsXOfdBdxaO0a1Yq6mNMeipPZAYONdGepoJr117gwBLV
        c0l87ok5H5V6nxIEaQYUlZcpR9v9djAGac+MlfREe55kQ7ZDhssc09cmakVejKDJWYYJimrA1WM
        HcEQC5lJ1mTdgFs8RvCztASF2nLsX5pzkZ16c
X-Received: by 2002:a05:620a:31aa:b0:767:7a4c:1b9e with SMTP id bi42-20020a05620a31aa00b007677a4c1b9emr15272954qkb.7.1690963399767;
        Wed, 02 Aug 2023 01:03:19 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFnNAWWhSXb/HktBSfXGFmabV1fvsy307saOx2MgChsfs7xTXLkVxm9csctRpjZ4apFAXP/zg==
X-Received: by 2002:a05:620a:31aa:b0:767:7a4c:1b9e with SMTP id bi42-20020a05620a31aa00b007677a4c1b9emr15272941qkb.7.1690963399461;
        Wed, 02 Aug 2023 01:03:19 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-233-7.dyn.eolo.it. [146.241.233.7])
        by smtp.gmail.com with ESMTPSA id p12-20020a05620a132c00b0076c9cc1e107sm3299044qkj.54.2023.08.02.01.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 01:03:18 -0700 (PDT)
Message-ID: <1b51c79c59cb3ec4be95e993be9be2e5d9441670.camel@redhat.com>
Subject: Re: [RFC bpf-next v7 0/6] bpf: Force to MPTCP
From:   Paolo Abeni <pabeni@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Geliang Tang <geliang.tang@suse.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        bpf@vger.kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-kselftest@vger.kernel.org
Date:   Wed, 02 Aug 2023 10:03:12 +0200
In-Reply-To: <20230801004323.l2npfegkq3srzff3@MacBook-Pro-8.local>
References: <cover.1690624340.git.geliang.tang@suse.com>
         <20230801004323.l2npfegkq3srzff3@MacBook-Pro-8.local>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, 2023-07-31 at 17:43 -0700, Alexei Starovoitov wrote:

> I still think it's a hack, but its blast radius is nicely contained.
> And since I cannot propose any better I'm ok with it.
>=20
> Patches 1-2 can be squashed into one.
> Just like patches 3-6 as a single patch for selftests.
>=20
> But before proceeding I'd like an explicit ack from netdev maintainers.

Just to state the obvious, I carry my personal bias on this topic due
to my background ;)

My perspective is quite similar to Alexei's one: the solution is not
extremely elegant, but is very self-contained; it looks viable to me.

WRT the specific code, I think the additional checks on the 'protocol'
value after the 'update_socket_protocol()' call should be dropped: the
user space can already provide an arbitrary value there and the later
code deal with that.

Cheers,

Paolo

