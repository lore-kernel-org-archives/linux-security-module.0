Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBF5EB64DA
	for <linux-security-module@archiver.kernel.org>; Sat, 24 Jun 2023 15:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjFXP2a (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 24 Jun 2023 11:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjFXP23 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 24 Jun 2023 11:28:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FB61715
        for <linux-security-module@vger.kernel.org>; Sat, 24 Jun 2023 08:28:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55D366097A
        for <linux-security-module@vger.kernel.org>; Sat, 24 Jun 2023 15:28:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 717BEC433C0;
        Sat, 24 Jun 2023 15:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687620506;
        bh=ky4bwl+Jvhzuw604b2TcsXkBxuI4T4UZ0oC38KWIYNw=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=NWtT+22xu74D8CHktttctBao6ukEuNlh92yeAFupS4NPX1CQGhJOthGfKJdHiIwhA
         QFXJs3SwXd2llmVu9oI5UhiecTWhYFZPjRi6P6yhRIx4a2kOv8szcJm4aD63eNdJRR
         OyLlEx+b85wfbp/nw3KAfn/Dha5p2diyKDQQ5mSYiP2FPNFuVy79OTey9IYNbkeeTu
         iZuujR5wvUyeN4eJnzrRV3hjLvECtJoO5aXt+B26xVW7SWHvlz6PGX+5lxmxjPHkDE
         sxGqW4riPXb8CXXCRHvZZ6FeV01xpsLJwe4v0TVETLp3SKlaT+jXMQQzssFRm5412r
         AU2TANcCpR3uQ==
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 580C627C0054;
        Sat, 24 Jun 2023 11:28:25 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute3.internal (MEProxy); Sat, 24 Jun 2023 11:28:25 -0400
X-ME-Sender: <xms:mAuXZMSQ44gUknqi7yPhZymNBRJ6NOPgOtvxLCzBireM0uu6fV7vOA>
    <xme:mAuXZJzXmnHUftm-EzkA2Rx780XdkY4W3meGOpv9WxwUMeFT9ilqEv3l7S2I_WVNb
    kRJnVOpIrKUCr7eAXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeegjedgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeduveffvdegvdefhfegjeejlefgtdffueekudfgkeduvdetvddu
    ieeluefgjeeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedu
    keehieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinh
    hugidrlhhuthhordhush
X-ME-Proxy: <xmx:mAuXZJ1N1H-icH1Hfv0nWxqsk70PhdQmAgF91u9juQ4wzR05wx3QWA>
    <xmx:mAuXZACGvyKn21kNAf7watbksqrdmwCHXRTt6j7izJ6XvutVshZK5w>
    <xmx:mAuXZFjSM6L63lZTvdeAM7KrCpC0V7MvctICtiKWcsZYryiCfX0T0g>
    <xmx:mQuXZGXXVWBZqOlPKq8w-0aEmnaNQlsfen5HvF2Ljs27qg2zR28SAw>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id DBBC531A0063; Sat, 24 Jun 2023 11:28:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Mime-Version: 1.0
Message-Id: <8340aaf2-8b4c-4f7d-8eed-f72f615f6fd0@app.fastmail.com>
In-Reply-To: <fe47aeb6-dae8-43a6-bcb0-ada2ebf62e08@app.fastmail.com>
References: <20230607235352.1723243-1-andrii@kernel.org>
 <c1a8d5e8-023b-4ef9-86b3-bdd70efe1340@app.fastmail.com>
 <CAEf4BzazbMqAh_Nj_geKNLshxT+4NXOCd-LkZ+sRKsbZAJ1tUw@mail.gmail.com>
 <a73da819-b334-448c-8e5c-50d9f7c28b8f@app.fastmail.com>
 <CAEf4Bzb__Cmf5us1Dy6zTkbn2O+3GdJQ=khOZ0Ui41tkoE7S0Q@mail.gmail.com>
 <5eb4264e-d491-a7a2-93c7-928b06ce264d@redhat.com>
 <bc4f99af-0c46-49b2-9f2d-9a01e6a03af3@app.fastmail.com>
 <5a75d1f0-4ed9-399c-4851-2df0755de9b5@redhat.com>
 <CAEf4Bza9GvJ0vw2-0M8GKSXmOQ8VQCmeqEiQpMuZBjwqpA03vw@mail.gmail.com>
 <82b79e57-a0ad-4559-abc9-858e0f51fbba@app.fastmail.com>
 <9b0e9227-4cf4-4acb-ba88-52f65b099709@app.fastmail.com>
 <173f0af7-e6e1-f4b7-e0a6-a91b7a4da5d7@iogearbox.net>
 <fe47aeb6-dae8-43a6-bcb0-ada2ebf62e08@app.fastmail.com>
Date:   Sat, 24 Jun 2023 08:28:04 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Daniel Borkmann" <daniel@iogearbox.net>,
        "Andrii Nakryiko" <andrii.nakryiko@gmail.com>,
        "Maryam Tahhan" <mtahhan@redhat.com>
Cc:     "Andrii Nakryiko" <andrii@kernel.org>, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        "Kees Cook" <keescook@chromium.org>,
        "Christian Brauner" <brauner@kernel.org>, lennart@poettering.net,
        cyphar@cyphar.com, kernel-team@meta.com
Subject: Re: [PATCH v2 bpf-next 00/18] BPF token
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>



On Sat, Jun 24, 2023, at 6:59 AM, Andy Lutomirski wrote:
> On Fri, Jun 23, 2023, at 4:23 PM, Daniel Borkmann wrote:

>
> If this series was about passing a =E2=80=9Cmay load kernel modules=E2=
=80=9D token=20
> around, I think it would get an extremely chilly reception, even thoug=
h=20
> we have module signatures.  I don=E2=80=99t see anything about BPF tha=
t makes=20
> BPF tokens more reasonable unless a real security model is developed=20
> first.
>

To be clear, I'm not saying that there should not be a mechanism to use =
BPF from a user namespace.  I'm saying the mechanism should have explici=
t access control.  It wouldn't need to solve all problems right away, bu=
t it should allow incrementally more features to be enabled as the acces=
s control solution gets more powerful over time.

BPF, unlike kernel modules, has a verifier.  While it would be a departu=
re from current practice, permission to use BPF could come with an expli=
cit list of allowed functions and allowed hooks.

(The hooks wouldn't just be a list, presumably -- premission to install =
an XDP program would be scoped to networks over which one has CAP_NET_AD=
MIN, presumably.  Other hooks would have their own scoping.  Attaching t=
o a cgroup should (and maybe already does?) require some kind of permiss=
ion on the cgroup.  Etc.)

If new, more restrictive functions are needed, they could be added.


Alternatively, people could try a limited form of BPF proxying.  It woul=
dn't need to be a full proxy -- an outside daemon really could approve t=
he attachment of a BPF program, and it could parse the program, examine =
the list of function it uses and what the proposed attachment is to, and=
 make an educated decision.  This would need some API changes (maybe), b=
ut it seems eminently doable.
