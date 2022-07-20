Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6247C433EF
	for <linux-security-module@archiver.kernel.org>; Wed, 20 Jul 2022 01:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241767AbiGTBlc (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 Jul 2022 21:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241774AbiGTBlF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Jul 2022 21:41:05 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139417AC3C
        for <linux-security-module@vger.kernel.org>; Tue, 19 Jul 2022 18:32:44 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id i132-20020a1c3b8a000000b003a2fa488efdso385211wma.4
        for <linux-security-module@vger.kernel.org>; Tue, 19 Jul 2022 18:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tQp/N6Uk+UKd7eDu5UmzGuGhmF0Y+ibaoFPpIegLF+Y=;
        b=by6T/E8VkX8oFtD8dnsR64IT7UFDcrTPCAIRCgOPa/LJUI8JOCFbfiz7J364/bCOeH
         rd2SkAx8XnmkmyymE0WIWkYVOzMHAWDtTOM7/pu4iS/Fe00JFXhg564o71FrfrqpBCLX
         kNQx4x/jPUrpwvMLbAB7FQyDSSJU5xbxfQ3JJ8oycJgKPUTeAw2TRAoGo85orXqi0A8u
         Xs58+Hntk7L9VAArrtF/7CD3yaGAuk+/qXl0aNv10D0zU/SEvOHRpjy0Q2PZ1bdEhEgl
         88w2QZanxV32ADu69Bwbh0ecfaxCfSbzFZyoWEIAXF445J3pol4ru5Qh5EMeLZvIwOIM
         TLcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tQp/N6Uk+UKd7eDu5UmzGuGhmF0Y+ibaoFPpIegLF+Y=;
        b=dvKs0/+8kdHeef3no+5PY9TpfUe6Fm1o51zoapFY5tUharPLjgmaJzprGG++JNNkvx
         vIF17OmiDmb++BPcygYLVvXs7fZsNmsWaXfwS2g/OO2AFJvNK1J0MpBw1eEKc6wuNGUP
         6KhQMbvETd/2Iq3mCeV4o0i0TnNqiOdsIijtd/ewtbMlI8zxbtjhKkYbefBD7qNA0pSI
         od6KEqkUk/ZYw4uWs4zpOh29aDuaKJh9I+bGhL2DKKKE3MQe+UZ6W4qNYHmBjcKCdnu6
         U7ubWeeW+EUAIkllSWmPv6mhc6aZE99T4FVHkN1U1fDa7gBB4kV8ZrZ2mOs70s+n4VR8
         zvug==
X-Gm-Message-State: AJIora8QqPxfxtJM9POJ6Xncrv1nax2SuGNZGOmR/afvM4SoGj/UVC/9
        DgmHL0aJMsVZ+BraOz+4vCaZYhGagVleoVwxGFku
X-Google-Smtp-Source: AGRyM1ubeyz5pphxIFoknkif5zSYvGormRenvsTvDWi7UK6OclfHHNS+LtozRpPhZOyHN270g6dMP5377DarcQ4fJ5w=
X-Received: by 2002:a7b:ce8f:0:b0:3a2:ff2d:915f with SMTP id
 q15-20020a7bce8f000000b003a2ff2d915fmr1512608wmj.165.1658280762556; Tue, 19
 Jul 2022 18:32:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220707223228.1940249-1-fred@cloudflare.com> <CAJ2a_DezgSpc28jvJuU_stT7V7et-gD7qjy409oy=ZFaUxJneg@mail.gmail.com>
 <3dbd5b30-f869-b284-1383-309ca6994557@cloudflare.com> <84fbd508-65da-1930-9ed3-f53f16679043@schaufler-ca.com>
In-Reply-To: <84fbd508-65da-1930-9ed3-f53f16679043@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 19 Jul 2022 21:32:31 -0400
Message-ID: <CAHC9VhQ-mBYH-GwSULDyyQ6mNC6K8GNB4fra0pJ+s0ZnEpCgcg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Introduce security_create_user_ns()
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Frederick Lawler <fred@cloudflare.com>,
        =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        KP Singh <kpsingh@kernel.org>, revest@chromium.org,
        jackmanb@chromium.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, shuah@kernel.org,
        Christian Brauner <brauner@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jul 8, 2022 at 12:11 PM Casey Schaufler <casey@schaufler-ca.com> wr=
ote:
> On 7/8/2022 7:01 AM, Frederick Lawler wrote:
> > On 7/8/22 7:10 AM, Christian G=C3=B6ttsche wrote:
> >> ,On Fri, 8 Jul 2022 at 00:32, Frederick Lawler <fred@cloudflare.com>
> >> wrote:

...

> >> Also I think the naming scheme is <object>_<verb>.
> >
> > That's a good call out. I was originally hoping to keep the
> > security_*() match with the hook name matched with the caller function
> > to keep things all aligned. If no one objects to renaming the hook, I
> > can rename the hook for v3.

No objection from me.

[Sorry for the delay, the last week or two has been pretty busy.]

> >> III.
> >>
> >> Maybe even attach a security context to namespaces so they can be
> >> further governed?
>
> That would likely add confusion to the existing security module namespace
> efforts. SELinux, Smack and AppArmor have all developed namespace models.

I'm not sure I fully understand what Casey is saying here as SELinux
does not yet have an established namespace model to the best of my
understanding, but perhaps we are talking about different concepts for
the word "namespace"?

From a SELinux perspective, if we are going to control access to a
namespace beyond simple creation, we would need to assign the
namespace a label (inherited from the creating process).  Although
that would need some discussion among the SELinux folks as this would
mean treating a userns as a proper system entity from a policy
perspective which is ... interesting.

> That, or it could replace the various independent efforts with a single,
> unified security module namespace effort.

We've talked about this before and I just don't see how that could
ever work, the LSM implementations are just too different to do
namespacing at the LSM layer.  If a LSM is going to namespace
themselves, they need the ability to define what that means without
having to worry about what other LSMs want to do.


--
paul-moore.com
