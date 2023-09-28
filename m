Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FBCE732E9
	for <linux-security-module@archiver.kernel.org>; Thu, 28 Sep 2023 20:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbjI1UEp (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 28 Sep 2023 16:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbjI1UEo (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 28 Sep 2023 16:04:44 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F393E19F
        for <linux-security-module@vger.kernel.org>; Thu, 28 Sep 2023 13:04:39 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-419768e69dfso102351cf.0
        for <linux-security-module@vger.kernel.org>; Thu, 28 Sep 2023 13:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695931479; x=1696536279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qgxxz+OnRyQe+q8AIYmhPzyJtLKQsIADrJmvXfny8jI=;
        b=CTMZIugSysh+zcD/kQzBaFNIAw0BhMC6pPQDcTMSb0BDvVcRRmNIHdxxq2/mp0UyX8
         PARB/ip+nHoLcK9ipM7/YENS8cx6ECSqUS4Y1Wj14Af2SIClCrmJ8H/GcGqak9PRuWCB
         xkSL0w4/ouz0FykYPdlgVBQ0eoKgambCZGgZ76MqK45mlvlc6HEbWiA4Cewn9xN0ppWn
         iDNhsjDOP85SyR8lE40RWmTMlv3hjWW24mc9ZgvsBdHUhQGqExxfw0Jnx2MBKtPo2mGy
         HLK667F6PM5y4YLq5VjXbP+/xOUBXYA7ct8BrzZwTEqwoOucqTtI+YjYERkWpgLJ5T8H
         uMDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695931479; x=1696536279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qgxxz+OnRyQe+q8AIYmhPzyJtLKQsIADrJmvXfny8jI=;
        b=buBU+b6F6g6kL45Mr77qJB+r23z3TarH0WNXFpkCA9yzYXvjgySfyfIPujPX7guObb
         Qx8n4nVGO2hkCU5tvi18s+1yAn7bq7EuWYmbRto3RXJ+p/3kTe7FkGfw1GEEXqWFwbZP
         t+OMpLAce+cbPq/SF2Nk0uirskMlpgKmLfOKn+ch3TXVGoU/1apgqIGWhYMr2zaVF0sW
         ucJhzenWn3dKfSYfPKigSw46Xc4BmZ3e+LDrLJ/o+laJfirHVo9PxTYamj9u3XjVtDYE
         6NXLEggdpN6a6a9dHgJDSJDnv0LZwM9FS93FgEiLe1zHmhSGAvz4XiImQDWi6m5jgne0
         6lIA==
X-Gm-Message-State: AOJu0YyqqM1OkqF+MSlFAlj1D9d4GTlrNYYO76zXukbPMeqcv3x9txfe
        7WpuA3ZPxEhvrtMbPd4tPNxnrFbSVFc/Br6fDk6odQ==
X-Google-Smtp-Source: AGHT+IHY0/xsbgBzjcjxPDujOv1W4T1wvJxHwc6FolCzVRnqKs0m4uNhTuDLK9CBll6SPINEsIU/dbPearENwJyyEeY=
X-Received: by 2002:a05:622a:1a12:b0:3f2:1441:3c11 with SMTP id
 f18-20020a05622a1a1200b003f214413c11mr983468qtb.2.1695931478697; Thu, 28 Sep
 2023 13:04:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230921061641.273654-1-mic@digikod.net> <20230921061641.273654-6-mic@digikod.net>
 <CALmYWFubLv+yd9NWMMwt4FUdYnbghMC=GHeZm4oaSOctqnwbVA@mail.gmail.com>
 <20230926.di9Esee2xahi@digikod.net> <CALmYWFuerqvZ3HoUnc9xXYhR8vBgg9qAyA-ncHai4ksN-c-gGQ@mail.gmail.com>
 <20230928.Haewoh8Aishe@digikod.net>
In-Reply-To: <20230928.Haewoh8Aishe@digikod.net>
From:   Jeff Xu <jeffxu@google.com>
Date:   Thu, 28 Sep 2023 13:04:01 -0700
Message-ID: <CALmYWFvT8EBh+DwW0gw8yU36FKQxtsmO2s5sU6DD8_pfA9yxYg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 5/7] landlock: Log file-related requests
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     Eric Paris <eparis@redhat.com>, James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Ben Scarlato <akhna@google.com>,
        =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
        Jorge Lucangeli Obes <jorgelo@google.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Shervin Oloumi <enlightened@google.com>, audit@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Sep 28, 2023 at 8:16=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> On Tue, Sep 26, 2023 at 02:19:51PM -0700, Jeff Xu wrote:
> > On Tue, Sep 26, 2023 at 6:35=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@d=
igikod.net> wrote:
> > >
> > > On Mon, Sep 25, 2023 at 06:26:28PM -0700, Jeff Xu wrote:
> > > > On Wed, Sep 20, 2023 at 11:17=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <=
mic@digikod.net> wrote:
> > > > >
> > > > > Add audit support for mkdir, mknod, symlink, unlink, rmdir, trunc=
ate,
> > > > > and open requests.
> > > > >
> > > > > Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> > > > > ---
> > > > >  security/landlock/audit.c | 114 ++++++++++++++++++++++++++++++++=
++++++
> > > > >  security/landlock/audit.h |  32 +++++++++++
> > > > >  security/landlock/fs.c    |  62 ++++++++++++++++++---
> > > > >  3 files changed, 199 insertions(+), 9 deletions(-)
> > > > >
> > >
> > > > > +static void
> > > > > +log_request(const int error, struct landlock_request *const requ=
est,
> > > > > +           const struct landlock_ruleset *const domain,
> > > > > +           const access_mask_t access_request,
> > > > > +           const layer_mask_t (*const layer_masks)[LANDLOCK_NUM_=
ACCESS_FS])
> > > > > +{
> > > > > +       struct audit_buffer *ab;
> > > > > +
> > > > > +       if (WARN_ON_ONCE(!error))
> > > > > +               return;
> > > > > +       if (WARN_ON_ONCE(!request))
> > > > > +               return;
> > > > > +       if (WARN_ON_ONCE(!domain || !domain->hierarchy))
> > > > > +               return;
> > > > > +
> > > > > +       /* Uses GFP_ATOMIC to not sleep. */
> > > > > +       ab =3D audit_log_start(audit_context(), GFP_ATOMIC | __GF=
P_NOWARN,
> > > > > +                            AUDIT_LANDLOCK);
> > > > > +       if (!ab)
> > > > > +               return;
> > > > > +
> > > > > +       update_request(request, domain, access_request, layer_mas=
ks);
> > > > > +
> > > > > +       log_task(ab);
> > > > > +       audit_log_format(ab, " domain=3D%llu op=3D%s errno=3D%d m=
issing-fs-accesses=3D",
> > > > > +                        request->youngest_domain,
> > > > > +                        op_to_string(request->operation), -error=
);
> > > > > +       log_accesses(ab, request->missing_access);
> > > > > +       audit_log_lsm_data(ab, &request->audit);
> > > > > +       audit_log_end(ab);
> > > > > +}
> > > > > +
> > > > > +// TODO: Make it generic, not FS-centric.
> > > > > +int landlock_log_request(
> > > > > +       const int error, struct landlock_request *const request,
> > > > > +       const struct landlock_ruleset *const domain,
> > > > > +       const access_mask_t access_request,
> > > > > +       const layer_mask_t (*const layer_masks)[LANDLOCK_NUM_ACCE=
SS_FS])
> > > > > +{
> > > > > +       /* No need to log the access request, only the missing ac=
cesses. */
> > > > > +       log_request(error, request, domain, access_request, layer=
_masks);
> > > > > +       return error;
> > > > > +}
> > >
> > > > > @@ -636,7 +638,8 @@ static bool is_access_to_paths_allowed(
> > > > >  }
> > > > >
> > > > >  static int current_check_access_path(const struct path *const pa=
th,
> > > > > -                                    access_mask_t access_request=
)
> > > > > +                                    access_mask_t access_request=
,
> > > > > +                                    struct landlock_request *con=
st request)
> > > > >  {
> > > > >         const struct landlock_ruleset *const dom =3D
> > > > >                 landlock_get_current_domain();
> > > > > @@ -650,7 +653,10 @@ static int current_check_access_path(const s=
truct path *const path,
> > > > >                                        NULL, 0, NULL, NULL))
> > > > >                 return 0;
> > > > >
> > > > > -       return -EACCES;
> > > > > +       request->audit.type =3D LSM_AUDIT_DATA_PATH;
> > > > > +       request->audit.u.path =3D *path;
> > > > > +       return landlock_log_request(-EACCES, request, dom, access=
_request,
> > > > > +                                   &layer_masks);
> > > >
> > > > It might be more readable to let landlock_log_request return void.
> > > > Then the code will look like below.
> > > >
> > > > landlock_log_request(-EACCES, request, dom, access_request,  &layer=
_masks);
> > > > return -EACCES;
> > > >
> > > > The allow/deny logic will be in this function, i.e. reader
> > > > doesn't need to check landlock_log_request's implementation to find
> > > > out it never returns 0.
> > >
> > > I did that in an early version of this patch, but I finally choose to=
 write
> > > 'return lanlock_log_request();` for mainly two reasons:
> > > * to help not forget to call this function at any non-zero return val=
ues
> > >   (which can easily be checked with grep),
> >
> > "grep -A 2 landlock_log_request" would serve the same purpose though.
>
> Yes, there is always a way to find a pattern, and the best tool might be
> Coccinelle, but I think it's harder to miss with such tail calls.
>
> >
> > > * to do tail calls.
> > >
> > > I guess compiler should be smart enough to do tail calls with a varia=
ble
> > > set indirection, but I'd like to check that.
> > >
> >
> > What are tail calls and what is the benefit of this code pattern ?
> > i.e. pass the return value into landlock_log_request() and make it a
> > single point of setting return value for all landlock hooks.
>
> landlock_log_request() should only be called at the end of LSM hooks.
> Tail calls is basically when you call a function at the end of the
> caller. This enables replacing "call" with "jmp" and save stack space.
> landlock_log_request() can fit with this pattern (if not using the
> caller's stack, which is not currently the case). See this tail call
> optimization example: https://godbolt.org/z/r88ofcW6x
>
Thanks for giving the context of the tail call.
Compile options are controlled by makefile, and can be customized. In
the past, I have had different projects setting different O levels for
various reasons, including disable optimization completely. Individual
Compiler implementation  also matters, gcc vs clang, etc. I think the
tail call is probably not essential to the discussion.

> I find it less error prone to not duplicate the error code (once for
> landlock_log_request and another for the caller's returned value). I
> also don't really see the pro of using a variable only to share this
> value. In ptrace.c, an "err" variable is used to check if the error is 0
> or not, but that is handled differently for most hooks.
>
> Makeing landlock_log_request() return a value also encourages us (thanks
> to compiler warnings) to use this value and keep the error handling
> consistent (especially for future code).
>
One general assumption about logging function is that it is not part
of the main business logic, i.e. if the logging statement is
removed/commented out, it doesn't have side effects to the main
business logic. This is probably why most log functions return void.

> Another feature that I'd like to add is to support a "permissive mode",
> that would enable to quickly see the impact of a sandbox without
> applying it for real. This might change some landlock_log_request()
> calls, so we'll see what fits best.
>
It is an excellent feature to have.
To implement that, I guess there will be a common function as a switch
to allow/deny, and logging the decision, depending on the permissive
setting.
From that point, preparing the code towards that goal makes sense.

> >
> > > To make it easier to read (and to not forget returning the error), th=
e
> > > landlock_log_request() calls a void log_request() helper, and returns
> > > the error itself. It is then easy to review and know what's happening
> > > without reading log_request().
> > >
> > > I'd like the compiler to check itself that every LSM hook returned
> > > values are either 0 or comming from landlock_log_request() but I thin=
k
> > > it's not possible right now. Coccinelle might help here though.
> > >
> > > BTW, in a next version, we might have landlock_log_request() called e=
ven
> > > for allowed requests (i.e. returned value of 0).
When there is more business logic to landlock_log_request, it is
probably better to rename the function. Most devs might assume the log
function does nothing but logging.  Having some meaningful name, e.g.
check_permissive_and_audit_log,  will help with readability.

Thanks!
-Jeff
