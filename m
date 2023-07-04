Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE046EB64D9
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Jul 2023 23:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjGDX3h (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 4 Jul 2023 19:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjGDX3h (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 4 Jul 2023 19:29:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A686A10E0
        for <linux-security-module@vger.kernel.org>; Tue,  4 Jul 2023 16:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688513329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zxr5qDhLUP1R94cKfvkuJwjykxCSB++k75bbVZUeq/M=;
        b=SLzNur6spbLIjlHw+/0m9E+OY8TVikilAnhrjIYVE5Y4NSvSjb/37/8WFMZqJpq/JN/VKX
        1rNvdjMZyTEhk8QWftsvDWaTjgynR4FjYnU2XX2rH9bJoryke7sCLOgBW2YewF1X0e/rSq
        7ahfSDqM+0WPc+OBBn7kr2k8ke3RYzU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-eufykLbNMgGPS8LC4kOwnA-1; Tue, 04 Jul 2023 19:28:48 -0400
X-MC-Unique: eufykLbNMgGPS8LC4kOwnA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9932bf9a1e8so234876166b.0
        for <linux-security-module@vger.kernel.org>; Tue, 04 Jul 2023 16:28:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688513327; x=1691105327;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zxr5qDhLUP1R94cKfvkuJwjykxCSB++k75bbVZUeq/M=;
        b=TTlNS+RpsagiVFGcuFWTX/Bw9I5IZjuiWjTxIYEwy/YH1g/DkWDZPoEPgoM07/RvjN
         bqP/d8csblE4hqY/ZoUnGnCLTMuVJxCyjhVYsVeL28hL1xiNJ5Xj27RL+ThZyOZB3cv6
         M3x3fK5vK+BXDyWjOj6GjHzlk75zirB+tTE3xAeWXRntLRQezxIE41iIRggKMdTSBec2
         FYzsP06oHZHSQXRQDdzKPVpvEfr8V6HPcSUk+z0YlzAkPhnQOSLVHLpA4WEuP5skyUzn
         h21ewY5oBNsn28l+BhEdgIe3bAQNLf9NaWAoNZr7nwqZ8VQARfpiLL6RfiBdg2N2xT//
         IkIw==
X-Gm-Message-State: ABy/qLa7fjXs60CFD3sa9hk3XngtOPLZ7ZtprosJAoQ9SWHiqIR9ipoP
        HRO0722B3C3vkO8cimdTC4NrmAJWr/LzZz5v/gBo+5m7QboPgtP03oJGgpwQSib+AauM/TVNTv6
        qt1JiuXR1tTmoEd1O7lt+oFi+fGQEpHNce+IO
X-Received: by 2002:a17:906:e94:b0:96a:30b5:cfb0 with SMTP id p20-20020a1709060e9400b0096a30b5cfb0mr10566092ejf.22.1688513327457;
        Tue, 04 Jul 2023 16:28:47 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFuT5Cw7eJvulDmFtlZ+cxEOXMoAhOur4BWAz8dQeBJFF/QKG4IKBkNPZT81R3Z2tSgFV60Mg==
X-Received: by 2002:a17:906:e94:b0:96a:30b5:cfb0 with SMTP id p20-20020a1709060e9400b0096a30b5cfb0mr10566080ejf.22.1688513327027;
        Tue, 04 Jul 2023 16:28:47 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id kg13-20020a17090776ed00b009932528281bsm5167763ejc.121.2023.07.04.16.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 16:28:46 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 1EE49BC1180; Wed,  5 Jul 2023 01:28:46 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Christian Brauner <brauner@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        keescook@chromium.org, lennart@poettering.net, cyphar@cyphar.com,
        luto@kernel.org, kernel-team@meta.com, sargun@sargun.me
Subject: Re: [PATCH RESEND v3 bpf-next 01/14] bpf: introduce BPF token object
In-Reply-To: <20230704-hochverdient-lehne-eeb9eeef785e@brauner>
References: <20230629051832.897119-1-andrii@kernel.org>
 <20230629051832.897119-2-andrii@kernel.org>
 <20230704-hochverdient-lehne-eeb9eeef785e@brauner>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 05 Jul 2023 01:28:46 +0200
Message-ID: <87sfa3b6j5.fsf@toke.dk>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Christian Brauner <brauner@kernel.org> writes:

> On Wed, Jun 28, 2023 at 10:18:19PM -0700, Andrii Nakryiko wrote:
>> Add new kind of BPF kernel object, BPF token. BPF token is meant to to
>> allow delegating privileged BPF functionality, like loading a BPF
>> program or creating a BPF map, from privileged process to a *trusted*
>> unprivileged process, all while have a good amount of control over which
>> privileged operations could be performed using provided BPF token.
>> 
>> This patch adds new BPF_TOKEN_CREATE command to bpf() syscall, which
>> allows to create a new BPF token object along with a set of allowed
>> commands that such BPF token allows to unprivileged applications.
>> Currently only BPF_TOKEN_CREATE command itself can be
>> delegated, but other patches gradually add ability to delegate
>> BPF_MAP_CREATE, BPF_BTF_LOAD, and BPF_PROG_LOAD commands.
>> 
>> The above means that new BPF tokens can be created using existing BPF
>> token, if original privileged creator allowed BPF_TOKEN_CREATE command.
>> New derived BPF token cannot be more powerful than the original BPF
>> token.
>> 
>> Importantly, BPF token is automatically pinned at the specified location
>> inside an instance of BPF FS and cannot be repinned using BPF_OBJ_PIN
>> command, unlike BPF prog/map/btf/link. This provides more control over
>> unintended sharing of BPF tokens through pinning it in another BPF FS
>> instances.
>> 
>> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>> ---
>
> The main issue I have with the token approach is that it is a completely
> separate delegation vector on top of user namespaces. We mentioned this
> duringthe conf and this was brought up on the thread here again as well.
> Imho, that's a problem both security-wise and complexity-wise.
>
> It's not great if each subsystem gets its own custom delegation
> mechanism. This imposes such a taxing complexity on both kernel- and
> userspace that it will quickly become a huge liability. So I would
> really strongly encourage you to explore another direction.

I share this concern as well, but I'm not quite sure I follow your
proposal here. IIUC, you're saying that instead of creating the token
using a BPF_TOKEN_CREATE command, the policy daemon should create a
bpffs instance and attach the token value directly to that, right? But
then what? Are you proposing that the calling process inside the
container open a filesystem reference (how? using fspick()?) and pass
that to the bpf syscall? Or is there some way to find the right
filesystem instance to extract this from at the time that the bpf()
syscall is issued inside the container?

-Toke

