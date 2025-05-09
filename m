Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA95123A993
	for <linux-security-module@vger.kernel.org>; Fri,  9 May 2025 16:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746808268; cv=none; b=hMHUFkmoAxbJW1SHlaYI5/HaOTHU6xZxLgAww17jLHZv6xyCal1pkjdB9UOMxIo4FriRhwbgXVXMGnKpwCpzNLH5u1PUgpTfpoLpNJB/OD0GxiBsntm9Tkuxr5RKecYJkdnjTSFcAUe9RZXMJJcNXN5H1jJnnDIskkbDiSmZhio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746808268; c=relaxed/simple;
	bh=3F3cDCq8FuqEGRjFqwlZc4GvvKGUzJBMJDglBCvafpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rSbI9YY3bSx9bzX2uvHrg359/Jfz1ODc2cfqtwiucBHrjVradMngGp+bH7anfcHfPuiARKrfYG3l3j894ZUJnzvYsEB48MzpTVYEYMsebE15b72V4pPYF53dXfHJfFDoCBb15GlnBJD0CJpkKO4TPUjYFVUozgXbonqPi6cJ0zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=bcKgA4hm; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="bcKgA4hm"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-326cf24aa35so3072541fa.2
        for <linux-security-module@vger.kernel.org>; Fri, 09 May 2025 09:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1746808263; x=1747413063; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Dczfm41jf/+ot0pq62ZLpRDZZlZmNUxw7VlnOz5PeIg=;
        b=bcKgA4hm3ZZk1/EMhUj9SJIEokxBhQTjq6FFbpy4XtpNnAPWMQTVrlUI7j1tqhEwud
         35Yi+NfdhYzJSKQzuP0iWeYF+LjB1snPteoO5j5VbHNJAqTtbA4uXncbS9lHKXr0J82+
         QYFkUIbVhn2rU+2i5vVBOkQatyC+PZefwanLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746808263; x=1747413063;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dczfm41jf/+ot0pq62ZLpRDZZlZmNUxw7VlnOz5PeIg=;
        b=Xw6CitxnhRMoH7SnouTnLSOBjfamFzg4AdwNIw9/01yEiyNuI0s2JHwtrj02Q9pZMp
         zAFtoQAEtJdszO4psupP9BG3t2fkn5dFAongxrd8dh8El8lhQNDJy2DDpA/xc8cORvLJ
         2hTRA19VUpxiyEqwDvwkc7wF1LUjZpVN2AKCipVxFNgMCaaThmS7IPyl8gvNAfqyIO8u
         T7EsFthcuLZSy5UXjIzo+EGtt2ZkEgUwq/ZfziTf05UPFZtqk3L21suwLUdnfnysIff/
         pxA2RbqqfBW7YxmMNzByfKlPX42nVEljZfetLlGtSymYnrisOEyjwoD6g9Wh4etNmYTt
         ZTdw==
X-Forwarded-Encrypted: i=1; AJvYcCUL9RlYzXMWyS8GzVsTJwGINDdZkkpxHQgdRKjNylKl3GuTu0g3LrUJ157T6zBUf4xEljirajbUuTqBGZwAXuMTcBQDnwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyesFPyP8pbw50p+PS4fX00rtJcQ83Q+/U8ueQ9BiEF53dkuhnV
	M3mPr/XwSE8yPjypzz3B6fyaq4YJrFyDstIgUX3LofepAtu6LKB6/3mt/ISPwxMoE6KuyD4AvQ7
	qbOE/89AoXvsdh1UJXHRgtwbVQarJYyGhv61IIA==
X-Gm-Gg: ASbGncvJibP59uXTv0Mz2pUd4y8g+gxSMa1r2dnjqf/erk9aVJ6YZqbQw0Os/HL+s8N
	2zfqZQlChLPdjGyJyyjk789W03CnafsQTMzjjbSi5oXQfr7lACxnxeaANY0KN6sADEvHtk0mJgK
	uTsLfWcM3H8gLt70AL0cp2jNhg/uRttd3kOQ==
X-Google-Smtp-Source: AGHT+IHGg7ev8Us7cUxKeueai1BHjAHTYxTZouDrum8k4bUq3CW+5ojYIautOJhDd40fC5MrdLRm1S6TK6IgZ8w6Od8=
X-Received: by 2002:a05:651c:547:b0:30d:dad4:e074 with SMTP id
 38308e7fff4ca-326c459a4e1mr17086891fa.6.1746808262468; Fri, 09 May 2025
 09:31:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509-work-coredump-socket-v5-0-23c5b14df1bc@kernel.org> <20250509-work-coredump-socket-v5-2-23c5b14df1bc@kernel.org>
In-Reply-To: <20250509-work-coredump-socket-v5-2-23c5b14df1bc@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Fri, 9 May 2025 18:30:51 +0200
X-Gm-Features: AX0GCFui91OodDSa1dR8yv60GLGFoEtNuUM3aekOlc8fePpHrMC4CU4IloaWT7c
Message-ID: <CAJqdLrrcEwF1s0uLm-z=2DhkmtYLjqwttNujuQ3vT83m-PYLoQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/9] coredump: massage do_coredump()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Eric Dumazet <edumazet@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, David Rheinsberg <david@readahead.eu>, 
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Am Fr., 9. Mai 2025 um 12:26 Uhr schrieb Christian Brauner <brauner@kernel.org>:
>
> We're going to extend the coredump code in follow-up patches.
> Clean it up so we can do this more easily.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  fs/coredump.c | 122 +++++++++++++++++++++++++++++++---------------------------
>  1 file changed, 65 insertions(+), 57 deletions(-)
>
> diff --git a/fs/coredump.c b/fs/coredump.c
> index 281320ea351f..41491dbfafdf 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -646,63 +646,8 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>                 goto fail_unlock;
>         }
>
> -       if (cn.core_type == COREDUMP_PIPE) {
> -               int argi;
> -               int dump_count;
> -               char **helper_argv;
> -               struct subprocess_info *sub_info;
> -
> -               if (cprm.limit == 1) {
> -                       /* See umh_coredump_setup() which sets RLIMIT_CORE = 1.
> -                        *
> -                        * Normally core limits are irrelevant to pipes, since
> -                        * we're not writing to the file system, but we use
> -                        * cprm.limit of 1 here as a special value, this is a
> -                        * consistent way to catch recursive crashes.
> -                        * We can still crash if the core_pattern binary sets
> -                        * RLIM_CORE = !1, but it runs as root, and can do
> -                        * lots of stupid things.
> -                        *
> -                        * Note that we use task_tgid_vnr here to grab the pid
> -                        * of the process group leader.  That way we get the
> -                        * right pid if a thread in a multi-threaded
> -                        * core_pattern process dies.
> -                        */
> -                       coredump_report_failure("RLIMIT_CORE is set to 1, aborting core");
> -                       goto fail_unlock;
> -               }
> -               cprm.limit = RLIM_INFINITY;
> -
> -               dump_count = atomic_inc_return(&core_dump_count);
> -               if (core_pipe_limit && (core_pipe_limit < dump_count)) {
> -                       coredump_report_failure("over core_pipe_limit, skipping core dump");
> -                       goto fail_dropcount;
> -               }
> -
> -               helper_argv = kmalloc_array(argc + 1, sizeof(*helper_argv),
> -                                           GFP_KERNEL);
> -               if (!helper_argv) {
> -                       coredump_report_failure("%s failed to allocate memory", __func__);
> -                       goto fail_dropcount;
> -               }
> -               for (argi = 0; argi < argc; argi++)
> -                       helper_argv[argi] = cn.corename + argv[argi];
> -               helper_argv[argi] = NULL;
> -
> -               retval = -ENOMEM;
> -               sub_info = call_usermodehelper_setup(helper_argv[0],
> -                                               helper_argv, NULL, GFP_KERNEL,
> -                                               umh_coredump_setup, NULL, &cprm);
> -               if (sub_info)
> -                       retval = call_usermodehelper_exec(sub_info,
> -                                                         UMH_WAIT_EXEC);
> -
> -               kfree(helper_argv);
> -               if (retval) {
> -                       coredump_report_failure("|%s pipe failed", cn.corename);
> -                       goto close_fail;
> -               }
> -       } else if (cn.core_type == COREDUMP_FILE) {
> +       switch (cn.core_type) {
> +       case COREDUMP_FILE: {
>                 struct mnt_idmap *idmap;
>                 struct inode *inode;
>                 int open_flags = O_CREAT | O_WRONLY | O_NOFOLLOW |
> @@ -796,6 +741,69 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>                 if (do_truncate(idmap, cprm.file->f_path.dentry,
>                                 0, 0, cprm.file))
>                         goto close_fail;
> +               break;
> +       }
> +       case COREDUMP_PIPE: {
> +               int argi;
> +               int dump_count;
> +               char **helper_argv;
> +               struct subprocess_info *sub_info;
> +
> +               if (cprm.limit == 1) {
> +                       /* See umh_coredump_setup() which sets RLIMIT_CORE = 1.
> +                        *
> +                        * Normally core limits are irrelevant to pipes, since
> +                        * we're not writing to the file system, but we use
> +                        * cprm.limit of 1 here as a special value, this is a
> +                        * consistent way to catch recursive crashes.
> +                        * We can still crash if the core_pattern binary sets
> +                        * RLIM_CORE = !1, but it runs as root, and can do
> +                        * lots of stupid things.
> +                        *
> +                        * Note that we use task_tgid_vnr here to grab the pid
> +                        * of the process group leader.  That way we get the
> +                        * right pid if a thread in a multi-threaded
> +                        * core_pattern process dies.
> +                        */
> +                       coredump_report_failure("RLIMIT_CORE is set to 1, aborting core");
> +                       goto fail_unlock;
> +               }
> +               cprm.limit = RLIM_INFINITY;
> +
> +               dump_count = atomic_inc_return(&core_dump_count);
> +               if (core_pipe_limit && (core_pipe_limit < dump_count)) {
> +                       coredump_report_failure("over core_pipe_limit, skipping core dump");
> +                       goto fail_dropcount;
> +               }
> +
> +               helper_argv = kmalloc_array(argc + 1, sizeof(*helper_argv),
> +                                           GFP_KERNEL);
> +               if (!helper_argv) {
> +                       coredump_report_failure("%s failed to allocate memory", __func__);
> +                       goto fail_dropcount;
> +               }
> +               for (argi = 0; argi < argc; argi++)
> +                       helper_argv[argi] = cn.corename + argv[argi];
> +               helper_argv[argi] = NULL;
> +
> +               retval = -ENOMEM;
> +               sub_info = call_usermodehelper_setup(helper_argv[0],
> +                                               helper_argv, NULL, GFP_KERNEL,
> +                                               umh_coredump_setup, NULL, &cprm);
> +               if (sub_info)
> +                       retval = call_usermodehelper_exec(sub_info,
> +                                                         UMH_WAIT_EXEC);
> +
> +               kfree(helper_argv);
> +               if (retval) {
> +                       coredump_report_failure("|%s pipe failed", cn.corename);
> +                       goto close_fail;
> +               }
> +               break;
> +       }
> +       default:
> +               WARN_ON_ONCE(true);
> +               goto close_fail;
>         }
>
>         /* get us an unshared descriptor table; almost always a no-op */
>
> --
> 2.47.2
>
