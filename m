Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832B7382F08
	for <linux-security-module@vger.kernel.org>; Tue, 22 Sep 2026 06:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790057121; cv=none; b=vFcUNW63rV2g5hm/CnnJ8ORgbUL/lC3WEMKIF06KncSYoIfKbIKyS2nbouED3QOKvrJ1/urrV7230YZeB7s+bsFcMRwwS32+DhRMDdafR3SAUB8yLQ3AxfuFdQp1GfU92vcqQaiyW+1Dh81CIlS5RpU5ujOoWPHMscXCdLgmSJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790057121; c=relaxed/simple;
	bh=Q/oDrKjoLV0PJ7re9Qc+KtJR5UkROXgTJNC/Syw4ETE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iq6yXGNG4ti3+25UNsDqWMVErpYlGnV9ujyK67x0qUavlA5hgKX4CIWvbaxVLVaCtGo/+R1Ofoj18BApaRGlcfylyFxmYa2S3bnOErEpGtG8EPjDsuVmWxofdlvCZowZhi9T+d40l7W7x4lKoNhONCxSMkJ4sIvd79hzf/GBEIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=black-desk.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=black-desk.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2a7d46c5bbso98355166b.0
        for <linux-security-module@vger.kernel.org>; Mon, 21 Sep 2026 23:05:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790057119; x=1790661919;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zxmsk/EJ4w4QHvprrsLgwa7ofL6yH0BsSIWlOL221Nk=;
        b=1CKh+oNMRf8SO105LTbgBlD35N5B991VWQy0lCiqyfibxPBf6nvsDGDCia8MCX+UIy
         oCvgeCEafH61Ke5QmNIHPYHBvgpnzuxOZJNRc1N7X+bRkSrF+vJq+xvaHfLFksBfVQNA
         zN7OyfDNlTucF4O0jCJabu4E1ekd9D3isAFWf/kZFj4SzsrhW/pRrr0d++3Ayodi+1jW
         pTzUWGh5zDQQqZXD5380Kp+C0klDM6G4nwj6E/eyhhDBVixsTCSw8pN/la91teRnsX8l
         LVxHemhmR4Rw9Au/n9h6q50r6+nNQIravJP9GXVmiwRSdbNfj3Zo8heQtlC6CDOLjQc/
         DYTg==
X-Forwarded-Encrypted: i=1; AKwUvBwPbUveW3u06gU3gxezyPQkg47YEvu3JABdWmhXRMnGAoqw2r3EYLTvvUgxbaVivzlsbLMWbdYNS0ykrBnFqjUSyj9SngE=@vger.kernel.org
X-Gm-Message-State: AFuF++lC+TY4iElQ191m0TTzTfXO9ZyOgEmrNJ0WTc0+KQz0H8RBaRo2
	lRY9VpGB3prbyDvAaolXet36FyziEuFcMMGtNbYfYWKCylSIbLa/gz7GG8VbH7sJmEfe/A==
X-Gm-Gg: AYBFou19vdHQWmh4oYCIGDUPAoY/ZlqKNdp4SIILnfrWihZ9gfJbQzRfGj3N2hoTULy
	cs30uN/YmfdEhPIwNrqCs4LWiatTTGfeFfO/Y6VV+hTk6H+DjwbAZETjSabiokrax3FEiUi0HzK
	0+XzrspSKn2Cu3hZFtnz360z0TgRX0G57VVaNBJXCPgUPVtv3CaO7CHXAg7AjG3J+dnO/deHY/5
	YI9nZNmC5c85WADdC9kn9lRK+C8EyqKKWlv3mcrOmCPyVtoX4GiJy5dl0VgdE0V5WlZgGYn7PLt
	msrGPaeg/NoACjc4lv1rxyQoGfNq9vLCwRZk/fVFzVJ/ZQ3mj/6nVxjEVlI+P7zkat5FfET9GVk
	ayjx8KbHHXPsWbK5hnKvjqXQSs7ecsbVHprTEeKSSUSrfKB5PFi+H2w3bI29RPWxfOadzSLHIjA
	HtQgwDClVE8ij0EI339o624pfdCF0HSRdgkyCaEmxsQWkuFC9jJu0UY9O0h91VzB21PK8ms7xs0
	1wVEJBSarF3Tdx/VS4buYBA1vD5JQ0SHxebsofiUV61uaoASdKZgHwChThqibE=
X-Received: by 2002:a17:907:8692:b0:c25:4ba1:594f with SMTP id a640c23a62f3a-c2a8cffeff4mr160427866b.0.1790057118548;
        Mon, 21 Sep 2026 23:05:18 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a9c580d2fsm33430366b.26.2026.09.21.23.05.18
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 23:05:18 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6aa13a28848so911691a12.1
        for <linux-security-module@vger.kernel.org>; Mon, 21 Sep 2026 23:05:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBytswdJM14IdAI0Iz8l5KvZYEPf0roFa94yjb9FNCHDgOYAndMRa6QA37qzWx3TrnzQRQsgFjyGfR/iDwX172IXGfKIAuU=@vger.kernel.org
X-Received: by 2002:a05:6512:220f:b0:5aa:62df:cd0f with SMTP id
 2adb3069b0e04-5b8d28f3a47mr500408e87.2.1790056745194; Mon, 21 Sep 2026
 22:59:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831-pidfd-get-paths-v2-0-c59ea6a21b72@black-desk.cn>
 <20260831-pidfd-get-paths-v2-1-c59ea6a21b72@black-desk.cn> <CAG48ez3vJrbt+qYh5b-PYxmr2txcg3DAKDRwmBwVzNhRB+8Ueg@mail.gmail.com>
In-Reply-To: <CAG48ez3vJrbt+qYh5b-PYxmr2txcg3DAKDRwmBwVzNhRB+8Ueg@mail.gmail.com>
From: Chen Linxuan <me@black-desk.cn>
Date: Tue, 22 Sep 2026 13:58:53 +0800
X-Gmail-Original-Message-ID: <CAC1kPDMUT6pUarj-ohTGB9=5u=7osk+8bvyyAAjStsJN6Z3sEw@mail.gmail.com>
X-Gm-Features: AclHuK-ZUoiNUpNllD9s0TdWDgkEMFXuDsvm8kdoP44o6gMCMaHAEIjZzTqw_NM
Message-ID: <CAC1kPDMUT6pUarj-ohTGB9=5u=7osk+8bvyyAAjStsJN6Z3sEw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] fs: Introduce task path helpers
To: Jann Horn <jannh@google.com>
Cc: me@black-desk.cn, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Kees Cook <kees@kernel.org>, John Johansen <john.johansen@canonical.com>, 
	Georgia Garcia <georgia.garcia@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 3:21=E2=80=AFAM Jann Horn <jannh@google.com> wrote:
>
> On Mon, Aug 31, 2026 at 4:59=E2=80=AFAM Chen Linxuan via B4 Relay
> <devnull+me.black-desk.cn@kernel.org> wrote:
> > Introduce helpers that acquire a referenced struct path for a task's
> > executable, root, and working directory. Reuse them for procfs task
> > links and AppArmor executable-path handling instead of duplicating file
> > and path reference handling at each call site.
> [...]
> > +/**
> > + * get_task_exe_path - acquire a reference to the task's executable pa=
th
> > + * @task: The task.
> > + * @exe_path: The task's executable path.
> > + *
> > + * Returns 0 if the task has an executable path, or -ENOENT if it does=
 not.
> > + * The caller must release the path through path_put() on success.
> > + */
> > +int get_task_exe_path(struct task_struct *task, struct path *exe_path)
> > +{
> > +       struct file *exe_file =3D get_task_exe_file(task);
> > +
> > +       if (!exe_file)
> > +               return -ENOENT;
> > +
> > +       *exe_path =3D exe_file->f_path;
> > +       path_get(exe_path);
> > +       fput(exe_file);
> > +       return 0;
> > +}
> [...]
> >  static const char *get_current_exe_path(char *buffer, int buffer_size)
> >  {
> > -       struct file *exe_file;
> > -       struct path p;
> > +       struct path p __free(path_put) =3D {};
> >         const char *path_str;
> >
> > -       exe_file =3D get_task_exe_file(current);
> > -       if (!exe_file)
> > +       if (get_task_exe_path(current, &p))
> >                 return ERR_PTR(-ENOENT);
>
> This assumes that when get_task_exe_path() fails, it doesn't set
> members of the path argument to non-NULL values. That should be noted
> in a comment above get_task_exe_path().

Will be updated in V3.

>
