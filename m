Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB85E7F143
	for <linux-security-module@archiver.kernel.org>; Tue, 26 Sep 2023 23:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjIZXB5 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 26 Sep 2023 19:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjIZW75 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 26 Sep 2023 18:59:57 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5837DB4
        for <linux-security-module@vger.kernel.org>; Tue, 26 Sep 2023 14:20:28 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-414ba610766so127101cf.0
        for <linux-security-module@vger.kernel.org>; Tue, 26 Sep 2023 14:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695763228; x=1696368028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+yfCPJ+h1vKT/btr1jZvB3H+pqknpmQhzFvkl0ehzB0=;
        b=porLy9Nf/CvM4T5KPhRvXoRRB8oCDEt/RP7LAuYpmLeTLjehCEwKDDwpvuL+CYIYsh
         bIJLw+ulc4DB+fpnh7x+0PwZu2QIUoihAD8jokNQtg/Jkl5kuAyt6p8skqeTA8J8aP67
         w92qhkFzRDnol7/aT5B4YKrjy6oNBzyUqDdz3YixUHC9ifD/oPCDgXdxHI7cbzwe4xmt
         Rsp4E13BuVMFJpzyWpnId0t1Qed4PrM70tx8KFMIeD6QuhVvmK1oSirshXsfpWM/wpLi
         NUiV2rpmUHOmLzQLA1p65+Y59qNPSe9SSVlGnwfao28MnO480AtAqE0h4H1e//Lv4VTu
         reuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695763228; x=1696368028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+yfCPJ+h1vKT/btr1jZvB3H+pqknpmQhzFvkl0ehzB0=;
        b=jA2P/50bA86j0vgbLMCDT8hIofqmivE6OIHhJDvOANNWCN36vsZtaoer1Yg45FHNzL
         ol+2A5b8QAgWJFzfp5ivLt5ohkf4GHlqgSfGBt24Rj5w4KH/mViW6mZvGbNE+vUsD3Je
         END3z1+qur4J8JdGh3uq7TIGn7kcsI/v+OGuKmYAChbe+ku13lr2wBQ/JZ8mlPxmycI+
         61Jg8vkO4xSX3RC904Fwq0DU/ZjSWWRHG1uxIe/DvOB50YtpAapvFpkQoO7XLQs+N0mV
         hUNEanacA1c/e9uE5SkLxMQHhprzsEiMKVVUw/rYise8omJFNc2rcq3f6up6rLC0+zjH
         Uv7w==
X-Gm-Message-State: AOJu0Yw/btJngNkvtBo1Ad1k9kO4bIhfoJczfrjG9QaybC7MQGsM04PA
        a2pYdjD0TlmOHIu+FLPFGoqXBR+E9/7WXVVINk9Z7f4Zbh5PW6SnKKJBJs+6
X-Google-Smtp-Source: AGHT+IGlC2Cfe5ksujev4GRMEvbJr3s/cuOJfP0+eExFS0lmCzk+qbaTOLoUEVFab0BBpr3Ih/5JbGIbUb328dtOH0c=
X-Received: by 2002:a05:622a:5cf:b0:403:e1d1:8b63 with SMTP id
 d15-20020a05622a05cf00b00403e1d18b63mr447837qtb.24.1695763227794; Tue, 26 Sep
 2023 14:20:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230921061641.273654-1-mic@digikod.net> <20230921061641.273654-6-mic@digikod.net>
 <CALmYWFubLv+yd9NWMMwt4FUdYnbghMC=GHeZm4oaSOctqnwbVA@mail.gmail.com> <20230926.di9Esee2xahi@digikod.net>
In-Reply-To: <20230926.di9Esee2xahi@digikod.net>
From:   Jeff Xu <jeffxu@google.com>
Date:   Tue, 26 Sep 2023 14:19:51 -0700
Message-ID: <CALmYWFuerqvZ3HoUnc9xXYhR8vBgg9qAyA-ncHai4ksN-c-gGQ@mail.gmail.com>
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

On Tue, Sep 26, 2023 at 6:35=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> On Mon, Sep 25, 2023 at 06:26:28PM -0700, Jeff Xu wrote:
> > On Wed, Sep 20, 2023 at 11:17=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@=
digikod.net> wrote:
> > >
> > > Add audit support for mkdir, mknod, symlink, unlink, rmdir, truncate,
> > > and open requests.
> > >
> > > Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> > > ---
> > >  security/landlock/audit.c | 114 ++++++++++++++++++++++++++++++++++++=
++
> > >  security/landlock/audit.h |  32 +++++++++++
> > >  security/landlock/fs.c    |  62 ++++++++++++++++++---
> > >  3 files changed, 199 insertions(+), 9 deletions(-)
> > >
>
> > > +static void
> > > +log_request(const int error, struct landlock_request *const request,
> > > +           const struct landlock_ruleset *const domain,
> > > +           const access_mask_t access_request,
> > > +           const layer_mask_t (*const layer_masks)[LANDLOCK_NUM_ACCE=
SS_FS])
> > > +{
> > > +       struct audit_buffer *ab;
> > > +
> > > +       if (WARN_ON_ONCE(!error))
> > > +               return;
> > > +       if (WARN_ON_ONCE(!request))
> > > +               return;
> > > +       if (WARN_ON_ONCE(!domain || !domain->hierarchy))
> > > +               return;
> > > +
> > > +       /* Uses GFP_ATOMIC to not sleep. */
> > > +       ab =3D audit_log_start(audit_context(), GFP_ATOMIC | __GFP_NO=
WARN,
> > > +                            AUDIT_LANDLOCK);
> > > +       if (!ab)
> > > +               return;
> > > +
> > > +       update_request(request, domain, access_request, layer_masks);
> > > +
> > > +       log_task(ab);
> > > +       audit_log_format(ab, " domain=3D%llu op=3D%s errno=3D%d missi=
ng-fs-accesses=3D",
> > > +                        request->youngest_domain,
> > > +                        op_to_string(request->operation), -error);
> > > +       log_accesses(ab, request->missing_access);
> > > +       audit_log_lsm_data(ab, &request->audit);
> > > +       audit_log_end(ab);
> > > +}
> > > +
> > > +// TODO: Make it generic, not FS-centric.
> > > +int landlock_log_request(
> > > +       const int error, struct landlock_request *const request,
> > > +       const struct landlock_ruleset *const domain,
> > > +       const access_mask_t access_request,
> > > +       const layer_mask_t (*const layer_masks)[LANDLOCK_NUM_ACCESS_F=
S])
> > > +{
> > > +       /* No need to log the access request, only the missing access=
es. */
> > > +       log_request(error, request, domain, access_request, layer_mas=
ks);
> > > +       return error;
> > > +}
>
> > > @@ -636,7 +638,8 @@ static bool is_access_to_paths_allowed(
> > >  }
> > >
> > >  static int current_check_access_path(const struct path *const path,
> > > -                                    access_mask_t access_request)
> > > +                                    access_mask_t access_request,
> > > +                                    struct landlock_request *const r=
equest)
> > >  {
> > >         const struct landlock_ruleset *const dom =3D
> > >                 landlock_get_current_domain();
> > > @@ -650,7 +653,10 @@ static int current_check_access_path(const struc=
t path *const path,
> > >                                        NULL, 0, NULL, NULL))
> > >                 return 0;
> > >
> > > -       return -EACCES;
> > > +       request->audit.type =3D LSM_AUDIT_DATA_PATH;
> > > +       request->audit.u.path =3D *path;
> > > +       return landlock_log_request(-EACCES, request, dom, access_req=
uest,
> > > +                                   &layer_masks);
> >
> > It might be more readable to let landlock_log_request return void.
> > Then the code will look like below.
> >
> > landlock_log_request(-EACCES, request, dom, access_request,  &layer_mas=
ks);
> > return -EACCES;
> >
> > The allow/deny logic will be in this function, i.e. reader
> > doesn't need to check landlock_log_request's implementation to find
> > out it never returns 0.
>
> I did that in an early version of this patch, but I finally choose to wri=
te
> 'return lanlock_log_request();` for mainly two reasons:
> * to help not forget to call this function at any non-zero return values
>   (which can easily be checked with grep),

"grep -A 2 landlock_log_request" would serve the same purpose though.

> * to do tail calls.
>
> I guess compiler should be smart enough to do tail calls with a variable
> set indirection, but I'd like to check that.
>

What are tail calls and what is the benefit of this code pattern ?
i.e. pass the return value into landlock_log_request() and make it a
single point of setting return value for all landlock hooks.

> To make it easier to read (and to not forget returning the error), the
> landlock_log_request() calls a void log_request() helper, and returns
> the error itself. It is then easy to review and know what's happening
> without reading log_request().
>
> I'd like the compiler to check itself that every LSM hook returned
> values are either 0 or comming from landlock_log_request() but I think
> it's not possible right now. Coccinelle might help here though.
>
> BTW, in a next version, we might have landlock_log_request() called even
> for allowed requests (i.e. returned value of 0).
