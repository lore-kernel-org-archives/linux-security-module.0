Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A27E359A7C
	for <linux-security-module@vger.kernel.org>; Thu,  2 Apr 2026 18:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775153391; cv=pass; b=gj9KPLPM1iVxKXRf7Q682MgWOJ2uG0K4x6kzVbmVAUfEeUABVxujciCWrpzb5Ju9y1uAZpeF68mKc0bnnqL7l94gRLJap8xFhxpq8DxLOmZrHR+HGgtu3SVqCGjwI93zDuQY6VhUg8Jjf9mhXRY8FI3SEYCN7KEiutfC9z3gO2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775153391; c=relaxed/simple;
	bh=FPjsEBP7zOb+NT0AE7tDynBCsL9yv9/o3ffwitYV+84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qvmfix619nk/Q8id6Kqm4ADP/Uo1udPxeMKz5N3j0rHFzA3NbduFKzrryXG17+dkGWDWi7PFCP5mCgQFGejFEoJTWyU/BCUtU5IhTWxy+7nAA5Ny0vkaSFNVxFkn1jOXynjW80HBGd+yBqjY9XHvsbqwT0VzM0oZabyKz4HqBhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MYxPHar/; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MYxPHar/"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1279eced0b9so1445837c88.0
        for <linux-security-module@vger.kernel.org>; Thu, 02 Apr 2026 11:09:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775153388; cv=none;
        d=google.com; s=arc-20240605;
        b=CqNh7Z4Hl8q9obExUWv79h4ip/0HKYvbmoxfChmmNS1Q7XnGkPaDFqrksd5QIJzgkU
         Dhp1NhyffDsLA8a2PMGVKf9rcD9b8MPrJWYOAiV3LXC/aw7kdAGYheG1qiRtURkMIY1C
         Ul8f07pUz8T8n2824h+0eqPUFAhnazMgu3/d15uI2krAx5TATxLVq/FUNphieNYOTeRX
         WH8HQhB0Z7cFalTa0i1ayNlG/zCCtGcS4jeagGs0PGnRXaN5fmDXtQi63Ot7SeM7ixVg
         Aa8RS7zXQhmqI2nyf2mObLq/b/kDlnNC81ockTNhvKvFsJFPQeBrT7XUG17mdw4m+H0d
         aEmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z5cXzZjBQKXDf7F9j6DnhoA3FYnFE8rhFJRkotYJtw4=;
        fh=4Xijx9WVAvhlgbyV072N1MnO0xN4v0TeY1PzFfTE+po=;
        b=X0LRPy8CBlNO6lxv8jSP6yu4PhLSXpTs49xqbh2RnAlfR+ziY80hfQE7svlNGDH7nC
         zdmPOmq3IgI7onhVujeka1z+FZKNFaXxu8nQs0kSTs8WegAmkcfGwbsntcfrGn7eXfLg
         x3iPx+WoiBVRwdd5x+pzQkzl1ExQxq9SsVR+4/ydMC+l6gq7D6yo/rMj+3tvebMS4QUG
         Pk7MnlvyUhBNEE1kpo2EoK6yY8rXnpn/5flq3zObCcwyGfeqPY3JLNFWB2agRNHFGfKU
         qiQFnz3hZVSNWHBzsI42hpsXZajeZBmBVaWNudeI+s32flme9kVb2dSa3w+zsRM2p+Rx
         I0Dw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775153388; x=1775758188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5cXzZjBQKXDf7F9j6DnhoA3FYnFE8rhFJRkotYJtw4=;
        b=MYxPHar/vq97AW9kJUBcGm+tUorK53sJYsFammxZCjl+HeyrEkJkDUc/1VU5V/0RBK
         h1KigUjYuUNnTNubER/pYaANXxjy2DgmesGZAnEsWGgQjiNypAmWN3ut8nCpoIC06/i3
         GxjJY6IrfmE0HHDN2vs4tud8gFMhjh1CUaR78Ddhf14u253s+B04H8tZ57Wfii/Yrae+
         ldbw2hQs98N2efwiegj1n0qOmlOqpP89+OUZF5r4IBc+0ehI2GFev0JTmQ9/0nKZHMzm
         AvYXdgrzwB0hgc74xccljUoTuSj2KF1du9w6o7q/xs9C/mAi1MwUsX2c3D+VrbjHz9FP
         sYCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775153388; x=1775758188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z5cXzZjBQKXDf7F9j6DnhoA3FYnFE8rhFJRkotYJtw4=;
        b=YmhkLYCYijjTS6uNMQ9ZYR99j/Jvc7//n1mj5Fa9Lp2UZmPcXDertPK8rUqpHTw3TN
         iqBKw7AtEadFPvxOFUT8X85p2Vz2GYRVevT95C0f6zgUoE9EN098N9knxVkfFjyK/cB0
         nhcxOlptPwCKQrl3utyYlS01WMUtCJXBgarFclAjhp5MH3MJpOjhjixVJRapWkix9XUt
         057erhMVoNb87ZnM5pfZsmr9Y5tEOMtYCCerYa+S6ODVOnE2W/HGd6Hr3Y5NxzmF+diJ
         TlvkufpYlxX4zoSVFXP2Z7xApeTmGLDQpXXadENrRNPb/3VaegtAc8Tm2FcnS+DwM4U0
         Z9mQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhzyb3qSifVAqUBGds6l3o+g7KJXFR3PvhRQgYguXLnkMI18ZvcowEG40Oo2z6nCTmVERSfdrfKErI7FelYqhRKkKMJxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL1FtcsqVyPvuDgofxE48+Bno7DWzxrRrENyYyOthE8GDj7Z3A
	2fTbg43TF/XuozbE2zmOa52SDgjnYjo6+VFfp5yxNEURy8ryc7Yy5gG48gRQzOQl1gi3aCb9uM7
	w4rtGgAi6cJT5xKWqjc24nyrsLb/+p3zrmhm3Lul/53SfiSDY/YCDdu/h7cc=
X-Gm-Gg: ATEYQzxWF3BmeAVRDAzkJ5uOHQkHV1lcw8tklXwy4uD36UiKfs4swF1Mt1Nu/Q+Yn6r
	gXTu3y1WeLel8aTJMHEPOf7NQsP2gEPxIdjC8/GdftLybCBcGxQBxdt5QgvuoXwuVoPOz4z0qt8
	4xZM3b9Vc65+ayOAvHrYfyLT+SmuOrkc2VdHl3wJ4hOH46VB84eVJMABfs+siJHb72ef2c+/b9F
	9AbZQUvrz/Wv+l2viVVde2C5dPtJEYzyXwbNRzQbPQj0QUeRVA3j9Ysab4CdSs1VZMJwUVFXxiN
	UR3RjNQgKey3TnwZYYZWQ/n7DO5turoJeM/POZIqqMuTJ1Ms9ucoQUJnf+jBjU6KsYtXCg==
X-Received: by 2002:a05:7022:6b8a:b0:128:d23d:81aa with SMTP id
 a92af1059eb24-12bfb75edefmr8787c88.27.1775153387691; Thu, 02 Apr 2026
 11:09:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327164838.38231-1-gnoack3000@gmail.com> <20260327164838.38231-5-gnoack3000@gmail.com>
In-Reply-To: <20260327164838.38231-5-gnoack3000@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 2 Apr 2026 11:09:36 -0700
X-Gm-Features: AQROBzA7J2pamjlyq32G1g5d12smI2dX2ywL_3tRYssLlsLayOZOaATPISdfOZ8
Message-ID: <CAAVpQUBm9_y=ai6TYTPgKEDxJ2ZReN00gL7=HkjJSLAi_JtYJg@mail.gmail.com>
Subject: Re: [PATCH v8 04/12] landlock: Control pathname UNIX domain socket
 resolution by path
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	John Johansen <john.johansen@canonical.com>, Tingmao Wang <m@maowtm.org>, 
	Justin Suess <utilityemal77@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Jann Horn <jannh@google.com>, linux-security-module@vger.kernel.org, 
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, Matthieu Buffet <matthieu@buffet.re>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, konstantin.meskhidze@huawei.com, 
	Demi Marie Obenour <demiobenour@gmail.com>, Alyssa Ross <hi@alyssa.is>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Georgia Garcia <georgia.garcia@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 9:49=E2=80=AFAM G=C3=BCnther Noack <gnoack3000@gmai=
l.com> wrote:
>
> * Add a new access right LANDLOCK_ACCESS_FS_RESOLVE_UNIX, which
>   controls the lookup operations for named UNIX domain sockets.  The
>   resolution happens during connect() and sendmsg() (depending on
>   socket type).
> * Change access_mask_t from u16 to u32 (see below)
> * Hook into the path lookup in unix_find_bsd() in af_unix.c, using a
>   LSM hook.  Make policy decisions based on the new access rights
> * Increment the Landlock ABI version.
> * Minor test adaptations to keep the tests working.
> * Document the design rationale for scoped access rights,
>   and cross-reference it from the header documentation.
>
> With this access right, access is granted if either of the following
> conditions is met:
>
> * The target socket's filesystem path was allow-listed using a
>   LANDLOCK_RULE_PATH_BENEATH rule, *or*:
> * The target socket was created in the same Landlock domain in which
>   LANDLOCK_ACCESS_FS_RESOLVE_UNIX was restricted.
>
> In case of a denial, connect() and sendmsg() return EACCES, which is
> the same error as it is returned if the user does not have the write
> bit in the traditional UNIX file system permissions of that file.
>
> The access_mask_t type grows from u16 to u32 to make space for the new
> access right.  This also doubles the size of struct layer_access_masks
> from 32 byte to 64 byte.
>
> Document the (possible future) interaction between scoped flags and
> other access rights in struct landlock_ruleset_attr, and summarize the
> rationale, as discussed in code review leading up to [2].
>
> This feature was created with substantial discussion and input from
> Justin Suess, Tingmao Wang and Micka=C3=ABl Sala=C3=BCn.
>
> Cc: Tingmao Wang <m@maowtm.org>
> Cc: Justin Suess <utilityemal77@gmail.com>
> Cc: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Kuniyuki Iwashima <kuniyu@google.com>
> Suggested-by: Jann Horn <jannh@google.com>
> Link[1]: https://github.com/landlock-lsm/linux/issues/36
> Link[2]: https://lore.kernel.org/all/20260205.8531e4005118@gnoack.org/
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>
> ---
>  Documentation/security/landlock.rst          |  42 +++++-
>  Documentation/userspace-api/landlock.rst     |   2 +-
>  include/uapi/linux/landlock.h                |  21 +++
>  security/landlock/access.h                   |   2 +-
>  security/landlock/audit.c                    |   1 +
>  security/landlock/fs.c                       | 130 ++++++++++++++++++-
>  security/landlock/limits.h                   |   2 +-
>  security/landlock/syscalls.c                 |   2 +-
>  tools/testing/selftests/landlock/base_test.c |   2 +-
>  tools/testing/selftests/landlock/fs_test.c   |   5 +-
>  10 files changed, 200 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/security/landlock.rst b/Documentation/security=
/landlock.rst
> index 3e4d4d04cfae..c3f8f43073a7 100644
> --- a/Documentation/security/landlock.rst
> +++ b/Documentation/security/landlock.rst
> @@ -7,7 +7,7 @@ Landlock LSM: kernel documentation
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  :Author: Micka=C3=ABl Sala=C3=BCn
> -:Date: September 2025
> +:Date: March 2026
>
>  Landlock's goal is to create scoped access-control (i.e. sandboxing).  T=
o
>  harden a whole system, this feature should be available to any process,
> @@ -89,6 +89,46 @@ this is required to keep access controls consistent ov=
er the whole system, and
>  this avoids unattended bypasses through file descriptor passing (i.e. co=
nfused
>  deputy attack).
>
> +.. _scoped-flags-interaction:
> +
> +Interaction between scoped flags and other access rights
> +--------------------------------------------------------
> +
> +The ``scoped`` flags in ``struct landlock_ruleset_attr`` restrict the
> +use of *outgoing* IPC from the created Landlock domain, while they
> +permit reaching out to IPC endpoints *within* the created Landlock
> +domain.
> +
> +In the future, scoped flags *may* interact with other access rights,
> +e.g. so that abstract UNIX sockets can be allow-listed by name, or so
> +that signals can be allow-listed by signal number or target process.
> +
> +When introducing ``LANDLOCK_ACCESS_FS_RESOLVE_UNIX``, we defined it to
> +implicitly have the same scoping semantics as a
> +``LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET`` flag would have: connecting to
> +UNIX sockets within the same domain (where
> +``LANDLOCK_ACCESS_FS_RESOLVE_UNIX`` is used) is unconditionally
> +allowed.
> +
> +The reasoning is:
> +
> +* Like other IPC mechanisms, connecting to named UNIX sockets in the
> +  same domain should be expected and harmless.  (If needed, users can
> +  further refine their Landlock policies with nested domains or by
> +  restricting ``LANDLOCK_ACCESS_FS_MAKE_SOCK``.)
> +* We reserve the option to still introduce
> +  ``LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET`` in the future.  (This would
> +  be useful if we wanted to have a Landlock rule to permit IPC access
> +  to other Landlock domains.)
> +* But we can postpone the point in time when users have to deal with
> +  two interacting flags visible in the userspace API.  (In particular,
> +  it is possible that it won't be needed in practice, in which case we
> +  can avoid the second flag altogether.)
> +* If we *do* introduce ``LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET`` in the
> +  future, setting this scoped flag in a ruleset does *not reduce* the
> +  restrictions, because access within the same scope is already
> +  allowed based on ``LANDLOCK_ACCESS_FS_RESOLVE_UNIX``.
> +
>  Tests
>  =3D=3D=3D=3D=3D
>
> diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/use=
rspace-api/landlock.rst
> index 13134bccdd39..1490f879f621 100644
> --- a/Documentation/userspace-api/landlock.rst
> +++ b/Documentation/userspace-api/landlock.rst
> @@ -8,7 +8,7 @@ Landlock: unprivileged access control
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  :Author: Micka=C3=ABl Sala=C3=BCn
> -:Date: January 2026
> +:Date: March 2026
>
>  The goal of Landlock is to enable restriction of ambient rights (e.g. gl=
obal
>  filesystem or network access) for a set of processes.  Because Landlock
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.=
h
> index f88fa1f68b77..3157d257555b 100644
> --- a/include/uapi/linux/landlock.h
> +++ b/include/uapi/linux/landlock.h
> @@ -248,6 +248,26 @@ struct landlock_net_port_attr {
>   *
>   *   This access right is available since the fifth version of the Landl=
ock
>   *   ABI.
> + * - %LANDLOCK_ACCESS_FS_RESOLVE_UNIX: Look up pathname UNIX domain sock=
ets
> + *   (:manpage:`unix(7)`).  On UNIX domain sockets, this restricts both =
calls to
> + *   :manpage:`connect(2)` as well as calls to :manpage:`sendmsg(2)` wit=
h an
> + *   explicit recipient address.
> + *
> + *   This access right only applies to connections to UNIX server socket=
s which
> + *   were created outside of the newly created Landlock domain (e.g. fro=
m within
> + *   a parent domain or from an unrestricted process).  Newly created UN=
IX
> + *   servers within the same Landlock domain continue to be accessible. =
 In this
> + *   regard, %LANDLOCK_ACCESS_FS_RESOLVE_UNIX has the same semantics as =
the
> + *   ``LANDLOCK_SCOPE_*`` flags.
> + *
> + *   If a resolve attempt is denied, the operation returns an ``EACCES``=
 error,
> + *   in line with other filesystem access rights (but different to denia=
ls for
> + *   abstract UNIX domain sockets).
> + *
> + *   This access right is available since the ninth version of the Landl=
ock ABI.
> + *
> + *   The rationale for this design is described in
> + *   :ref:`Documentation/security/landlock.rst <scoped-flags-interaction=
>`.
>   *
>   * Whether an opened file can be truncated with :manpage:`ftruncate(2)` =
or used
>   * with `ioctl(2)` is determined during :manpage:`open(2)`, in the same =
way as
> @@ -333,6 +353,7 @@ struct landlock_net_port_attr {
>  #define LANDLOCK_ACCESS_FS_REFER                       (1ULL << 13)
>  #define LANDLOCK_ACCESS_FS_TRUNCATE                    (1ULL << 14)
>  #define LANDLOCK_ACCESS_FS_IOCTL_DEV                   (1ULL << 15)
> +#define LANDLOCK_ACCESS_FS_RESOLVE_UNIX                        (1ULL << =
16)
>  /* clang-format on */
>
>  /**
> diff --git a/security/landlock/access.h b/security/landlock/access.h
> index 277b6ed7f7bb..99c709f7979e 100644
> --- a/security/landlock/access.h
> +++ b/security/landlock/access.h
> @@ -34,7 +34,7 @@
>         LANDLOCK_ACCESS_FS_IOCTL_DEV)
>  /* clang-format on */
>
> -typedef u16 access_mask_t;
> +typedef u32 access_mask_t;
>
>  /* Makes sure all filesystem access rights can be stored. */
>  static_assert(BITS_PER_TYPE(access_mask_t) >=3D LANDLOCK_NUM_ACCESS_FS);
> diff --git a/security/landlock/audit.c b/security/landlock/audit.c
> index 60ff217ab95b..8d0edf94037d 100644
> --- a/security/landlock/audit.c
> +++ b/security/landlock/audit.c
> @@ -37,6 +37,7 @@ static const char *const fs_access_strings[] =3D {
>         [BIT_INDEX(LANDLOCK_ACCESS_FS_REFER)] =3D "fs.refer",
>         [BIT_INDEX(LANDLOCK_ACCESS_FS_TRUNCATE)] =3D "fs.truncate",
>         [BIT_INDEX(LANDLOCK_ACCESS_FS_IOCTL_DEV)] =3D "fs.ioctl_dev",
> +       [BIT_INDEX(LANDLOCK_ACCESS_FS_RESOLVE_UNIX)] =3D "fs.resolve_unix=
",
>  };
>
>  static_assert(ARRAY_SIZE(fs_access_strings) =3D=3D LANDLOCK_NUM_ACCESS_F=
S);
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index 97065d51685a..fcf69b3d734d 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -27,6 +27,7 @@
>  #include <linux/lsm_hooks.h>
>  #include <linux/mount.h>
>  #include <linux/namei.h>
> +#include <linux/net.h>
>  #include <linux/path.h>
>  #include <linux/pid.h>
>  #include <linux/rcupdate.h>
> @@ -36,6 +37,7 @@
>  #include <linux/types.h>
>  #include <linux/wait_bit.h>
>  #include <linux/workqueue.h>
> +#include <net/af_unix.h>
>  #include <uapi/linux/fiemap.h>
>  #include <uapi/linux/landlock.h>
>
> @@ -314,7 +316,8 @@ static struct landlock_object *get_inode_object(struc=
t inode *const inode)
>         LANDLOCK_ACCESS_FS_WRITE_FILE | \
>         LANDLOCK_ACCESS_FS_READ_FILE | \
>         LANDLOCK_ACCESS_FS_TRUNCATE | \
> -       LANDLOCK_ACCESS_FS_IOCTL_DEV)
> +       LANDLOCK_ACCESS_FS_IOCTL_DEV | \
> +       LANDLOCK_ACCESS_FS_RESOLVE_UNIX)
>  /* clang-format on */
>
>  /*
> @@ -1557,6 +1560,130 @@ static int hook_path_truncate(const struct path *=
const path)
>         return current_check_access_path(path, LANDLOCK_ACCESS_FS_TRUNCAT=
E);
>  }
>
> +/**
> + * unmask_scoped_access - Remove access right bits in @masks in all laye=
rs
> + *                        where @client and @server have the same domain
> + *
> + * This does the same as domain_is_scoped(), but unmasks bits in @masks.
> + * It can not return early as domain_is_scoped() does.
> + *
> + * A scoped access for a given access right bit is allowed iff, for all =
layer
> + * depths where the access bit is set, the client and server domain are =
the
> + * same.  This function clears the access rights @access in @masks at al=
l layer
> + * depths where the client and server domain are the same, so that, when=
 they
> + * are all cleared, the access is allowed.
> + *
> + * @client: Client domain
> + * @server: Server domain
> + * @masks: Layer access masks to unmask
> + * @access: Access bits that control scoping
> + */
> +static void unmask_scoped_access(const struct landlock_ruleset *const cl=
ient,
> +                                const struct landlock_ruleset *const ser=
ver,
> +                                struct layer_access_masks *const masks,
> +                                const access_mask_t access)
> +{
> +       int client_layer, server_layer;
> +       const struct landlock_hierarchy *client_walker, *server_walker;
> +
> +       /* This should not happen. */
> +       if (WARN_ON_ONCE(!client))
> +               return;
> +
> +       /* Server has no Landlock domain; nothing to clear. */
> +       if (!server)
> +               return;
> +
> +       /*
> +        * client_layer must be a signed integer with greater capacity
> +        * than client->num_layers to ensure the following loop stops.
> +        */
> +       BUILD_BUG_ON(sizeof(client_layer) > sizeof(client->num_layers));
> +
> +       client_layer =3D client->num_layers - 1;
> +       client_walker =3D client->hierarchy;
> +       server_layer =3D server->num_layers - 1;
> +       server_walker =3D server->hierarchy;
> +
> +       /*
> +        * Clears the access bits at all layers where the client domain i=
s the
> +        * same as the server domain.  We start the walk at min(client_la=
yer,
> +        * server_layer).  The layer bits until there can not be cleared =
because
> +        * either the client or the server domain is missing.
> +        */
> +       for (; client_layer > server_layer; client_layer--)
> +               client_walker =3D client_walker->parent;
> +
> +       for (; server_layer > client_layer; server_layer--)
> +               server_walker =3D server_walker->parent;
> +
> +       for (; client_layer >=3D 0; client_layer--) {
> +               if (masks->access[client_layer] & access &&
> +                   client_walker =3D=3D server_walker)
> +                       masks->access[client_layer] &=3D ~access;
> +
> +               client_walker =3D client_walker->parent;
> +               server_walker =3D server_walker->parent;
> +       }
> +}
> +
> +static int hook_unix_find(const struct path *const path, struct sock *ot=
her,
> +                         int flags)
> +{
> +       const struct landlock_ruleset *dom_other;
> +       const struct landlock_cred_security *subject;
> +       struct layer_access_masks layer_masks;
> +       struct landlock_request request =3D {};
> +       static const struct access_masks fs_resolve_unix =3D {
> +               .fs =3D LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
> +       };
> +
> +       /* Lookup for the purpose of saving coredumps is OK. */
> +       if (unlikely(flags & SOCK_COREDUMP))
> +               return 0;
> +
> +       subject =3D landlock_get_applicable_subject(current_cred(),
> +                                                 fs_resolve_unix, NULL);
> +
> +       if (!subject)
> +               return 0;
> +
> +       /*
> +        * Ignoring return value: that the domains apply was already chec=
ked in
> +        * landlock_get_applicable_subject() above.
> +        */
> +       landlock_init_layer_masks(subject->domain, fs_resolve_unix.fs,
> +                                 &layer_masks, LANDLOCK_KEY_INODE);
> +
> +       /* Checks the layers in which we are connecting within the same d=
omain. */
> +       unix_state_lock(other);
> +       if (unlikely(sock_flag(other, SOCK_DEAD) || !other->sk_socket ||
> +                    !other->sk_socket->file)) {

When will the latter two condition be true when !SOCK_DEAD ?

unix_find_bsd() should not find embryo sockets.


> +               unix_state_unlock(other);
> +               /*
> +                * We rely on the caller to catch the (non-reversible) SO=
CK_DEAD
> +                * condition and retry the lookup.  If we returned an err=
or
> +                * here, the lookup would not get retried.
> +                */
> +               return 0;
> +       }
> +       dom_other =3D landlock_cred(other->sk_socket->file->f_cred)->doma=
in;
> +
> +       /* Access to the same (or a lower) domain is always allowed. */
> +       unmask_scoped_access(subject->domain, dom_other, &layer_masks,
> +                            fs_resolve_unix.fs);
> +       unix_state_unlock(other);
> +
> +       /* Checks the connections to allow-listed paths. */
> +       if (is_access_to_paths_allowed(subject->domain, path,
> +                                      fs_resolve_unix.fs, &layer_masks,
> +                                      &request, NULL, 0, NULL, NULL, NUL=
L))
> +               return 0;
> +
> +       landlock_log_denial(subject, &request);
> +       return -EACCES;
> +}
> +
>  /* File hooks */
>
>  /**
> @@ -1834,6 +1961,7 @@ static struct security_hook_list landlock_hooks[] _=
_ro_after_init =3D {
>         LSM_HOOK_INIT(path_unlink, hook_path_unlink),
>         LSM_HOOK_INIT(path_rmdir, hook_path_rmdir),
>         LSM_HOOK_INIT(path_truncate, hook_path_truncate),
> +       LSM_HOOK_INIT(unix_find, hook_unix_find),
>
>         LSM_HOOK_INIT(file_alloc_security, hook_file_alloc_security),
>         LSM_HOOK_INIT(file_open, hook_file_open),
> diff --git a/security/landlock/limits.h b/security/landlock/limits.h
> index eb584f47288d..b454ad73b15e 100644
> --- a/security/landlock/limits.h
> +++ b/security/landlock/limits.h
> @@ -19,7 +19,7 @@
>  #define LANDLOCK_MAX_NUM_LAYERS                16
>  #define LANDLOCK_MAX_NUM_RULES         U32_MAX
>
> -#define LANDLOCK_LAST_ACCESS_FS                LANDLOCK_ACCESS_FS_IOCTL_=
DEV
> +#define LANDLOCK_LAST_ACCESS_FS                LANDLOCK_ACCESS_FS_RESOLV=
E_UNIX
>  #define LANDLOCK_MASK_ACCESS_FS                ((LANDLOCK_LAST_ACCESS_FS=
 << 1) - 1)
>  #define LANDLOCK_NUM_ACCESS_FS         __const_hweight64(LANDLOCK_MASK_A=
CCESS_FS)
>
> diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> index 3b33839b80c7..a6e23657f3ce 100644
> --- a/security/landlock/syscalls.c
> +++ b/security/landlock/syscalls.c
> @@ -166,7 +166,7 @@ static const struct file_operations ruleset_fops =3D =
{
>   * If the change involves a fix that requires userspace awareness, also =
update
>   * the errata documentation in Documentation/userspace-api/landlock.rst =
.
>   */
> -const int landlock_abi_version =3D 8;
> +const int landlock_abi_version =3D 9;
>
>  /**
>   * sys_landlock_create_ruleset - Create a new ruleset
> diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing=
/selftests/landlock/base_test.c
> index 0fea236ef4bd..30d37234086c 100644
> --- a/tools/testing/selftests/landlock/base_test.c
> +++ b/tools/testing/selftests/landlock/base_test.c
> @@ -76,7 +76,7 @@ TEST(abi_version)
>         const struct landlock_ruleset_attr ruleset_attr =3D {
>                 .handled_access_fs =3D LANDLOCK_ACCESS_FS_READ_FILE,
>         };
> -       ASSERT_EQ(8, landlock_create_ruleset(NULL, 0,
> +       ASSERT_EQ(9, landlock_create_ruleset(NULL, 0,
>                                              LANDLOCK_CREATE_RULESET_VERS=
ION));
>
>         ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/s=
elftests/landlock/fs_test.c
> index 968a91c927a4..b318627e7561 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -575,9 +575,10 @@ TEST_F_FORK(layout1, inval)
>         LANDLOCK_ACCESS_FS_WRITE_FILE | \
>         LANDLOCK_ACCESS_FS_READ_FILE | \
>         LANDLOCK_ACCESS_FS_TRUNCATE | \
> -       LANDLOCK_ACCESS_FS_IOCTL_DEV)
> +       LANDLOCK_ACCESS_FS_IOCTL_DEV | \
> +       LANDLOCK_ACCESS_FS_RESOLVE_UNIX)
>
> -#define ACCESS_LAST LANDLOCK_ACCESS_FS_IOCTL_DEV
> +#define ACCESS_LAST LANDLOCK_ACCESS_FS_RESOLVE_UNIX
>
>  #define ACCESS_ALL ( \
>         ACCESS_FILE | \
> --
> 2.53.0
>
