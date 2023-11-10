Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE70C4332F
	for <linux-security-module@archiver.kernel.org>; Fri, 10 Nov 2023 22:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjKJWUN (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 10 Nov 2023 17:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjKJWUM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 10 Nov 2023 17:20:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E5844B6
        for <linux-security-module@vger.kernel.org>; Fri, 10 Nov 2023 14:20:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BFEDC433CB
        for <linux-security-module@vger.kernel.org>; Fri, 10 Nov 2023 22:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699654808;
        bh=NZpHuyACLpRCUBOlVTQueBO3ak832TS3DuZ+jUL9vsg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UMdOyKeIH7fz/uzH/ZqMUiB3JLxMFdQv4F7ZXcSPefPAnBZrmXoENytsZSyFk8syc
         zlkSTTXm4l9DZz02NgSHhbFxeW4vMGb/Sqr+8efjgFtERvO2N9NoP38cqk+5sWPi9M
         +Qijw0VPiwCvJaVQ1M//XWPLhDFepP/MoKBt3w4jiRMwt3BhSaYQ0BjF9Zu+lzU4zj
         UW+VLJrxIa160nFq5L7LyPsSuLyaHgtSV8dymLLabkUv32xKTXaSWeSZESaTSgsSXs
         hV4pqGNkVjqTJA2zq6SavFEAF9dEd+DGgnE20Ha9EzrdBmg+cQytSxGqQq94FgiaOG
         ksXuTLwNbNdrg==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-53df747cfe5so4188224a12.2
        for <linux-security-module@vger.kernel.org>; Fri, 10 Nov 2023 14:20:08 -0800 (PST)
X-Gm-Message-State: AOJu0Yx7ecI0Ckig8uNC1lJSVFLY8m3yiHOhsDcdrwbAVbL6w2Pj0HXn
        GCHG4cMkPqWD2rkxeNy0jIuqjFYSzb6NDG53BBSc5g==
X-Google-Smtp-Source: AGHT+IHmLk1Z/Sz01akvMr/FQh6as32bImEa+pudYGREu5eK4WEKhfIYILoFgQP0CspWs0pXV8plDiECpNfrxfFgNVY=
X-Received: by 2002:aa7:c993:0:b0:53d:fe98:fd48 with SMTP id
 c19-20020aa7c993000000b0053dfe98fd48mr462449edt.3.1699654806808; Fri, 10 Nov
 2023 14:20:06 -0800 (PST)
MIME-Version: 1.0
References: <20231102005521.346983-1-kpsingh@kernel.org> <20231102005521.346983-5-kpsingh@kernel.org>
 <CAEf4Bzakdg3pxQZtjYZGrvZPo-nmpsxB0=Ymp9q+KFYOPViu=Q@mail.gmail.com>
In-Reply-To: <CAEf4Bzakdg3pxQZtjYZGrvZPo-nmpsxB0=Ymp9q+KFYOPViu=Q@mail.gmail.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Fri, 10 Nov 2023 14:19:55 -0800
X-Gmail-Original-Message-ID: <CACYkzJ5u053pm1gD35xY2_Q8SscsEYKMJn2TRcak8nEucenvEg@mail.gmail.com>
Message-ID: <CACYkzJ5u053pm1gD35xY2_Q8SscsEYKMJn2TRcak8nEucenvEg@mail.gmail.com>
Subject: Re: [PATCH v7 4/5] bpf: Only enable BPF LSM hooks when an LSM program
 is attached
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        paul@paul-moore.com, keescook@chromium.org, casey@schaufler-ca.com,
        song@kernel.org, daniel@iogearbox.net, ast@kernel.org,
        renauld@google.com, pabeni@redhat.com, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

[...]

> > @@ -110,11 +110,14 @@ struct lsm_id {
> >   * @scalls: The beginning of the array of static calls assigned to this hook.
> >   * @hook: The callback for the hook.
> >   * @lsm: The name of the lsm that owns this hook.
> > + * @default_state: The state of the LSM hook when initialized. If set to false,
> > + * the static key guarding the hook will be set to disabled.
> >   */
> >  struct security_hook_list {
> >         struct lsm_static_call  *scalls;
> >         union security_list_options     hook;
> >         const struct lsm_id             *lsmid;
> > +       bool                            default_state;
>
> minor nit: "default_state" would make more sense if it would be some
> enum instead of bool. But given it's true/false, default_enabled makes
> more sense.

Agreed.

>
> >  } __randomize_layout;
> >
> >  /*
>

[...]

> > +
> > +void bpf_lsm_toggle_hook(void *addr, bool value)
>
> another minor nit: similar to above, s/value/enable/ reads nicer
>

Fixed.
