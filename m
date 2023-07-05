Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD8DEB64DA
	for <linux-security-module@archiver.kernel.org>; Wed,  5 Jul 2023 12:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjGEMgN (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 5 Jul 2023 08:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjGEMgL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 5 Jul 2023 08:36:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6727F1727
        for <linux-security-module@vger.kernel.org>; Wed,  5 Jul 2023 05:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688560472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A+Cmt8pCXt5KWisoV9VDhh/EzbRZ0a2/We4bLtWGgTM=;
        b=DKQAQummNDRU1Bw0Zk1h6gp0Y4a8nTZTjENPkEwA2A8tYNwGkVhzfheH3/etzSRLpOPVyN
        qq1obnfh5oT/j4/1EtDjvrvngCG2HSaQly4zAhAudOTCEg+G4+oKDWQ3uHD6slPoI0N9p7
        AdNyRyxySRdEk88/ZLDyBXj4lPptWds=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-VOqGFk0GOFmlFTvLMHVUEA-1; Wed, 05 Jul 2023 08:34:31 -0400
X-MC-Unique: VOqGFk0GOFmlFTvLMHVUEA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-313e65772d8so6730309f8f.0
        for <linux-security-module@vger.kernel.org>; Wed, 05 Jul 2023 05:34:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688560471; x=1691152471;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9n2Chuvyr5F1WS1DcynjB5EgkPOLdfP7pefN+jTsGUk=;
        b=BqZSx/MHbl8TG59fxaK4XP6FKzLt4De6FbxA4Dt2wANO0OQ+I3fnURzsGlDCVx/Ce1
         FPV2Gb52ei83sCFCIvMFOBL6h3mmlXfRVHWvEKT6ViAgwuTBQxCPg5T6KIo4QuhCyY3H
         tH1ru1IkeftUkZI+s32YkUR55koMLTE6h+UBgfQ3m6MFQylI3caNT6hKsAF18R09gMly
         Rdx95EWJ+EOwkPrAZ6HfZv/6s5C2hjcubb577i81EbG9Y5hS4uExh6IyF1+Ahi/S9cPj
         S3N1qeD65d03+RoQKdtDMetNGUrxB+V89xtNPxDZUV46ni2A7AQInsAUEHIIbxsYCGH1
         /nuQ==
X-Gm-Message-State: ABy/qLaXPA+8Z3qsCoD75YN+pj+LWTde9GCXTWxu0Id5NTmQCp2YeJNo
        8qAnwcHGpo/+whxvBVyU1H+D9+EehWAOKQ8pbf0BxhAJeEU9SFIVxczb8ajy4szXrUjRIRvNBZ1
        JXhxheyAR37EbfwIZ01te1oEQJVUVmXkL62yN
X-Received: by 2002:adf:e4c1:0:b0:314:37ac:c896 with SMTP id v1-20020adfe4c1000000b0031437acc896mr11965183wrm.44.1688560470639;
        Wed, 05 Jul 2023 05:34:30 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHVDjX0j2vlDhMrqZgyZuPY4mV1tg2k5iuAkbToYRMjihI+/Ew0efXto7iasHFqX3KI860e1Q==
X-Received: by 2002:adf:e4c1:0:b0:314:37ac:c896 with SMTP id v1-20020adfe4c1000000b0031437acc896mr11965158wrm.44.1688560470123;
        Wed, 05 Jul 2023 05:34:30 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id u4-20020a5d5144000000b0031444673643sm2704145wrt.57.2023.07.05.05.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 05:34:29 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id EA5FEBC12F0; Wed,  5 Jul 2023 14:34:28 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Christian Brauner <brauner@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org, keescook@chromium.org,
        lennart@poettering.net, cyphar@cyphar.com, luto@kernel.org,
        kernel-team@meta.com, sargun@sargun.me
Subject: Re: [PATCH RESEND v3 bpf-next 01/14] bpf: introduce BPF token object
In-Reply-To: <20230705-praxen-nahmen-644ea9e5c35c@brauner>
References: <20230629051832.897119-1-andrii@kernel.org>
 <20230629051832.897119-2-andrii@kernel.org>
 <20230704-hochverdient-lehne-eeb9eeef785e@brauner>
 <87sfa3b6j5.fsf@toke.dk>
 <3555c0bd-7aee-35b0-655d-710437b4876c@iogearbox.net>
 <20230705-praxen-nahmen-644ea9e5c35c@brauner>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 05 Jul 2023 14:34:28 +0200
Message-ID: <87h6qibkq3.fsf@toke.dk>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Christian Brauner <brauner@kernel.org> writes:

> On Wed, Jul 05, 2023 at 09:20:28AM +0200, Daniel Borkmann wrote:
>> On 7/5/23 1:28 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> > Christian Brauner <brauner@kernel.org> writes:
>> > > On Wed, Jun 28, 2023 at 10:18:19PM -0700, Andrii Nakryiko wrote:
>> > > > Add new kind of BPF kernel object, BPF token. BPF token is meant t=
o to
>> > > > allow delegating privileged BPF functionality, like loading a BPF
>> > > > program or creating a BPF map, from privileged process to a *trust=
ed*
>> > > > unprivileged process, all while have a good amount of control over=
 which
>> > > > privileged operations could be performed using provided BPF token.
>> > > >=20
>> > > > This patch adds new BPF_TOKEN_CREATE command to bpf() syscall, whi=
ch
>> > > > allows to create a new BPF token object along with a set of allowe=
d
>> > > > commands that such BPF token allows to unprivileged applications.
>> > > > Currently only BPF_TOKEN_CREATE command itself can be
>> > > > delegated, but other patches gradually add ability to delegate
>> > > > BPF_MAP_CREATE, BPF_BTF_LOAD, and BPF_PROG_LOAD commands.
>> > > >=20
>> > > > The above means that new BPF tokens can be created using existing =
BPF
>> > > > token, if original privileged creator allowed BPF_TOKEN_CREATE com=
mand.
>> > > > New derived BPF token cannot be more powerful than the original BP=
F
>> > > > token.
>> > > >=20
>> > > > Importantly, BPF token is automatically pinned at the specified lo=
cation
>> > > > inside an instance of BPF FS and cannot be repinned using BPF_OBJ_=
PIN
>> > > > command, unlike BPF prog/map/btf/link. This provides more control =
over
>> > > > unintended sharing of BPF tokens through pinning it in another BPF=
 FS
>> > > > instances.
>> > > >=20
>> > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>> > > > ---
>> > >=20
>> > > The main issue I have with the token approach is that it is a comple=
tely
>> > > separate delegation vector on top of user namespaces. We mentioned t=
his
>> > > duringthe conf and this was brought up on the thread here again as w=
ell.
>> > > Imho, that's a problem both security-wise and complexity-wise.
>> > >=20
>> > > It's not great if each subsystem gets its own custom delegation
>> > > mechanism. This imposes such a taxing complexity on both kernel- and
>> > > userspace that it will quickly become a huge liability. So I would
>> > > really strongly encourage you to explore another direction.
>> >=20
>> > I share this concern as well, but I'm not quite sure I follow your
>> > proposal here. IIUC, you're saying that instead of creating the token
>> > using a BPF_TOKEN_CREATE command, the policy daemon should create a
>> > bpffs instance and attach the token value directly to that, right? But
>> > then what? Are you proposing that the calling process inside the
>> > container open a filesystem reference (how? using fspick()?) and pass
>> > that to the bpf syscall? Or is there some way to find the right
>> > filesystem instance to extract this from at the time that the bpf()
>> > syscall is issued inside the container?
>>=20
>> Given there can be multiple bpffs instances, it would have to be similar
>> as to what Andrii did in that you need to pass the fd to the bpf(2) for
>> prog/map creation in order to retrieve the opts->abilities from the supe=
r
>> block.
>
> I think it's pretty flexible what one can do here. Off the top of my
> head there could be a dedicated file like /sys/fs/bpf/delegate which
> only exists if delegation has been enabled. Thought that might be just a
> wasted inode. There could be a new ioctl() on bpffsd which has the same
> effect.
>
> Probably an ioctl() on the bpffs instance is easier to grok. You could
> even take away rights granted by a bpffs instance from such an fd via
> additional ioctl() on it.

Right, gotcha; I was missing whether there was an existing mechanism to
obtain this; an ioctl makes sense. I can see the utility in attaching
this to the file system instance instead of as a separate object that's
pinned (but see my post in the other subthread about using the "ask
userspace model instead").

-Toke

