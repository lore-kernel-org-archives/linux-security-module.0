Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D36C3F6B0
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Aug 2022 02:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbiHOCdH (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 14 Aug 2022 22:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbiHOCdG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 14 Aug 2022 22:33:06 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD3013D18
        for <linux-security-module@vger.kernel.org>; Sun, 14 Aug 2022 19:33:03 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-f2a4c51c45so6945377fac.9
        for <linux-security-module@vger.kernel.org>; Sun, 14 Aug 2022 19:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=rKW04FaMDWlNTKaTacFyl18vVqIzuIE+w07IJVIvyZM=;
        b=0jUHyBYurBxt6DRoAGI0tPLbdwq8QIJsKw7J6a4Op/+9xD+nIyf0dK0wJ7rPnfTq2i
         NSJvgBTl+8AkLsBjYlKlyuaxDMkNUlYhs/+z2HQnC5hHxmTcduBCI+AHAwPc+R7t9trj
         KXAijqp+0i9YdXfrzZqpprg6bYtuy30+eIQM05alUjdeky6TD3PDUne1lBj2I32oWOG6
         ez2BRA/6nu/5Q4AjgERGga2f76iujz1PeWL9w0Vbht1AOF6TtFmcWZT/4icZI3P+1tiZ
         12Rp1ZxPzP9Jqw/ddSAaGrl2xTsxCHQJjehriM7ybsI4vUgaqO/2H/uoGhsNDT3ppDQz
         4jcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=rKW04FaMDWlNTKaTacFyl18vVqIzuIE+w07IJVIvyZM=;
        b=qJTzX8nxngtOROxEa+7F7LsguhFYhB26N/1M4YVgGrK0hcM7gSLtfgHvTrewqgic8w
         OZFISwxOX94Sao3M0aL5+oflUNs6dWJAIBQTjYGkXtsH5xa8z/xjAYbwTAUcWFHhnP9M
         BDo5ugiCQqEdOTiSPi2oiU5p3ITcNoBLEC+CTXndIFm0FYup+Of2M2jwHzqrQSGScob5
         qkOwNmlYTHFIorXiS5ZEIiH0Mswrb9zHiTLlj383yT4Vabxzw1f+6LM9DkigXeCwfGpy
         ZXM4y32sVeh69oIw6iZjHEOSVYRjTMSxpq+3BXZiBcu4/fDzu9s15Zk8++gJGxf83uxt
         y66g==
X-Gm-Message-State: ACgBeo038v6xJ/tz7kRt0GkpSjlbta2ZC0XqhZyX9iKjm7n0gunCyq4Z
        iQxWavXfCpeSp6bE+C1tfF8yJnZtLS1Mg59M6AWy
X-Google-Smtp-Source: AA6agR7bLEQJ7JYxjJc7rtmw4f9ZOcgrB6hJHBerZqztI0P/WghbS9WDob88ogRFpEs/NuLS6Tn9yZ9JlaNb+LVvaqA=
X-Received: by 2002:a05:6870:b41e:b0:116:5dc7:192a with SMTP id
 x30-20020a056870b41e00b001165dc7192amr6039900oap.136.1660530782624; Sun, 14
 Aug 2022 19:33:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220801180146.1157914-1-fred@cloudflare.com> <87les7cq03.fsf@email.froward.int.ebiederm.org>
 <CAHC9VhRpUxyxkPaTz1scGeRm+i4KviQQA7WismOX2q5agzC+DQ@mail.gmail.com>
 <87wnbia7jh.fsf@email.froward.int.ebiederm.org> <CAHC9VhS3udhEecVYVvHm=tuqiPGh034-xPqXYtFjBk23+p-Szg@mail.gmail.com>
 <20220814155508.GA7991@mail.hallyn.com>
In-Reply-To: <20220814155508.GA7991@mail.hallyn.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 14 Aug 2022 22:32:51 -0400
Message-ID: <CAHC9VhRSCXCM51xpOT95G_WVi=UQ44gNV=uvvG23p8wn16uYSA@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Introduce security_create_user_ns()
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Frederick Lawler <fred@cloudflare.com>, kpsingh@kernel.org,
        revest@chromium.org, jackmanb@chromium.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        jmorris@namei.org, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, shuah@kernel.org, brauner@kernel.org,
        casey@schaufler-ca.com, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, kernel-team@cloudflare.com,
        cgzones@googlemail.com, karl@bigbadwolfsecurity.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sun, Aug 14, 2022 at 11:55 AM Serge E. Hallyn <serge@hallyn.com> wrote:
> On Mon, Aug 08, 2022 at 03:16:16PM -0400, Paul Moore wrote:
> > On Mon, Aug 8, 2022 at 2:56 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> > > Paul Moore <paul@paul-moore.com> writes:
> > > > On Mon, Aug 1, 2022 at 10:56 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> > > >> Frederick Lawler <fred@cloudflare.com> writes:
> > > >>
> > > >> > While creating a LSM BPF MAC policy to block user namespace creation, we
> > > >> > used the LSM cred_prepare hook because that is the closest hook to prevent
> > > >> > a call to create_user_ns().
> > > >>
> > > >> Re-nack for all of the same reasons.
> > > >> AKA This can only break the users of the user namespace.
> > > >>
> > > >> Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> > > >>
> > > >> You aren't fixing what your problem you are papering over it by denying
> > > >> access to the user namespace.
> > > >>
> > > >> Nack Nack Nack.
> > > >>
> > > >> Stop.
> > > >>
> > > >> Go back to the drawing board.
> > > >>
> > > >> Do not pass go.
> > > >>
> > > >> Do not collect $200.
> > > >
> > > > If you want us to take your comments seriously Eric, you need to
> > > > provide the list with some constructive feedback that would allow
> > > > Frederick to move forward with a solution to the use case that has
> > > > been proposed.  You response above may be many things, but it is
> > > > certainly not that.
> > >
> > > I did provide constructive feedback.  My feedback to his problem
> > > was to address the real problem of bugs in the kernel.
> >
> > We've heard from several people who have use cases which require
> > adding LSM-level access controls and observability to user namespace
> > creation.  This is the problem we are trying to solve here; if you do
> > not like the approach proposed in this patchset please suggest another
> > implementation that allows LSMs visibility into user namespace
> > creation.
>
> Regarding the observability - can someone concisely lay out why just
> auditing userns creation would not suffice?  Userspace could decide
> what to report based on whether the creating user_ns == /proc/1/ns/user...

One of the selling points of the BPF LSM is that it allows for various
different ways of reporting and logging beyond audit.  However, even
if it was limited to just audit I believe that provides some useful
justification as auditing fork()/clone() isn't quite the same and
could be difficult to do at scale in some configurations.  I haven't
personally added a BPF LSM program to the kernel so I can't speak to
the details on what is possible, but I'm sure others on the To/CC line
could help provide more information if that is important to you.

> Regarding limiting the tweaking of otherwise-privileged code by
> unprivileged users, i wonder whether we could instead add smarts to
> ns_capable().

The existing security_capable() hook is eventually called by ns_capable():

  ns_capable()
    ns_capable_common()
      security_capable(const struct cred *cred,
                       struct user_namespace *ns,
                       int cap,
                       unsigned int opts);

... I'm not sure what additional smarts would be useful here?

[side note: SELinux does actually distinguish between capability
checks in the initial user namespace vs child namespaces]

> Point being, uid mapping would still work, but we'd
> break the "privileged against resources you own" part of user
> namespaces.  I would want it to default to allow, but then when a
> 0-day is found which requires reaching ns_capable() code, admins
> could easily prevent exploitation until reboot from a fixed kernel.

That assumes that everything you care about is behind a capability
check, which is probably going to be correct in a lot of the cases,
but I think it would be a mistake to assume that is always going to be
true.

--
paul-moore.com
