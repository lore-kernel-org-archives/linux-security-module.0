Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDCF4A99E
	for <linux-security-module@vger.kernel.org>; Wed, 20 Dec 2023 21:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dJTu2Vvx"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5df49931b4eso1961407b3.0
        for <linux-security-module@vger.kernel.org>; Wed, 20 Dec 2023 13:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1703107364; x=1703712164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hjk2wbnJnfETqR90Vlt520Brmk0gs134nu2Nw80lVgc=;
        b=dJTu2VvxIAAtEoB0WMiRhItDX0KfTIDTXsO7z82dTGwnmDQO7m8zUuW9BIM1tgo/V2
         Mv2VkdUMN+Jpy9wuiofbjtvlzZ+IjhkcZTA5RioJkjPpP6RyFxlzTKs6gIuEIzWHpLvA
         DQLvSAIDnwQWQWnKvIs6ARDQ4dQ0iHDySbBuFM8jycfMRMNUM5xHrLQCHwpi7NGXSVi5
         FvecaPs8bwdwOHV6J16MAawKgD8VC/W+fC3HAa/A82iMyxg27nXpfgTev62iDdUd0+oh
         hd7YvtgJRDTo1xyxJUN6gB4xx3Z5kOxI40UyIs6fUTVX9zlv9xUN+If89ZoZZfXwYyec
         ZkGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703107364; x=1703712164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hjk2wbnJnfETqR90Vlt520Brmk0gs134nu2Nw80lVgc=;
        b=ZarpMeKgbfVclQqy8wFhEGzKUsHBVMcEkRbomVJr9SjafBR4W7sEViTR/G8LCFgtzX
         7AOLoRrLCJBX6KXdzZO/Dg80SgezTMOjgZi+Zh2HxWzEQkwExo4dT6HNurmxhcFNnm5J
         TZ1m01hMdsAbKesJN4WzgIifL+KkBkIZsjtiM7LVo659xOzaDJ/niO+xLXLnJnDihfMa
         EpTNIVC7J7zRh7SJpk9UT23R84z+LalJSPQEcGalXWooCizNUnC+pOqAgDyl18kBNP8K
         hyHSs8bPSXAWbtq7WOUoXwuXq2cNr7exYyaadr+mFCbtR6cAW3UE4bdJapAG+qL7e0hv
         r9FA==
X-Gm-Message-State: AOJu0YxS3EBHxAXmDC8ZKFLI3OkP++PbdpKLnAGH09mp0o1yWIKF2Wuj
	fYBF1mXIclxF1YY0/okP0dlay0NjC/wan02Fvsqh
X-Google-Smtp-Source: AGHT+IFZ9InTQzUBBwu5o1SBQXowBQpw6AtehdzOg9gSUJe+Rxl+DZX6TjAm8AB3o4VcGlsI76noEFF57OP42lWa6MA=
X-Received: by 2002:a25:1054:0:b0:dbc:bd3f:9fa1 with SMTP id
 81-20020a251054000000b00dbcbd3f9fa1mr341878ybq.44.1703107363914; Wed, 20 Dec
 2023 13:22:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230921061641.273654-1-mic@digikod.net> <20230921061641.273654-6-mic@digikod.net>
In-Reply-To: <20230921061641.273654-6-mic@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 20 Dec 2023 16:22:33 -0500
Message-ID: <CAHC9VhQJPXJQCmXPUxOE3wXArUcgfDi98FO=VhRBgBgdueyAOQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 5/7] landlock: Log file-related requests
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Eric Paris <eparis@redhat.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Ben Scarlato <akhna@google.com>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@google.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Shervin Oloumi <enlightened@google.com>, 
	audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 21, 2023 at 2:17=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> Add audit support for mkdir, mknod, symlink, unlink, rmdir, truncate,
> and open requests.
>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> ---
>  security/landlock/audit.c | 114 ++++++++++++++++++++++++++++++++++++++
>  security/landlock/audit.h |  32 +++++++++++
>  security/landlock/fs.c    |  62 ++++++++++++++++++---
>  3 files changed, 199 insertions(+), 9 deletions(-)
>
> diff --git a/security/landlock/audit.c b/security/landlock/audit.c
> index d9589d07e126..148fc0fafef4 100644
> --- a/security/landlock/audit.c
> +++ b/security/landlock/audit.c
> @@ -14,6 +14,25 @@
>
>  atomic64_t ruleset_and_domain_counter =3D ATOMIC64_INIT(0);
>
> +static const char *op_to_string(enum landlock_operation operation)
> +{
> +       const char *const desc[] =3D {
> +               [0] =3D "",
> +               [LANDLOCK_OP_MKDIR] =3D "mkdir",
> +               [LANDLOCK_OP_MKNOD] =3D "mknod",
> +               [LANDLOCK_OP_SYMLINK] =3D "symlink",
> +               [LANDLOCK_OP_UNLINK] =3D "unlink",
> +               [LANDLOCK_OP_RMDIR] =3D "rmdir",
> +               [LANDLOCK_OP_TRUNCATE] =3D "truncate",
> +               [LANDLOCK_OP_OPEN] =3D "open",
> +       };

If you're going to be using a single AUDIT_LANDLOCK record type, do
you want to somehow encode that the above are access/permission
requests in the "op=3D" field name?

> +static void
> +log_request(const int error, struct landlock_request *const request,
> +           const struct landlock_ruleset *const domain,
> +           const access_mask_t access_request,
> +           const layer_mask_t (*const layer_masks)[LANDLOCK_NUM_ACCESS_F=
S])
> +{
> +       struct audit_buffer *ab;
> +
> +       if (WARN_ON_ONCE(!error))
> +               return;
> +       if (WARN_ON_ONCE(!request))
> +               return;
> +       if (WARN_ON_ONCE(!domain || !domain->hierarchy))
> +               return;
> +
> +       /* Uses GFP_ATOMIC to not sleep. */
> +       ab =3D audit_log_start(audit_context(), GFP_ATOMIC | __GFP_NOWARN=
,
> +                            AUDIT_LANDLOCK);
> +       if (!ab)
> +               return;
> +
> +       update_request(request, domain, access_request, layer_masks);
> +
> +       log_task(ab);
> +       audit_log_format(ab, " domain=3D%llu op=3D%s errno=3D%d missing-f=
s-accesses=3D",
> +                        request->youngest_domain,
> +                        op_to_string(request->operation), -error);
> +       log_accesses(ab, request->missing_access);
> +       audit_log_lsm_data(ab, &request->audit);
> +       audit_log_end(ab);
> +}

See my previous comments about record format consistency.

--
paul-moore.com
