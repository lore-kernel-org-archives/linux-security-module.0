Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D525E21D3E4
	for <linux-security-module@vger.kernel.org>; Tue, 30 Sep 2025 12:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759235550; cv=none; b=cVZ1VSDoNNkibgPJmwcXxcDSSHzV1jiIbnAreleYSX09ekM4hwxUQNQpyLXzI4UqX6gaVsgp5ukyFjZpe0uC7gutkZsX7pT8XIHOZEwl4GY7Gi8anRWhp5G5aLFETd/7QWPrSvj5MIP34ocexzBzgSh92xW4e8kd6owGm4KaVVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759235550; c=relaxed/simple;
	bh=fqp7acpuolAbT+AqZsCyM9aF2dPGekT7fdiy/ZKIgbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M12I/xEwmT75DXP8QZSPQ85bvFyuvwwWGa/pBdRymaZ4PZInyvZLhC2ergMbboWYse1kmYpcnH/LQfy9ORQdymJ6SEZmqEaj1HnL+4BzjDsSlsnYBJFfu4x85gMzyqrPAJdtg3HZCgUJYWtdmXWpl0Kr6xjj+rjkTavtHqgouME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ie7ioacx; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ie7ioacx"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-329a41dc2ebso4911357a91.3
        for <linux-security-module@vger.kernel.org>; Tue, 30 Sep 2025 05:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759235548; x=1759840348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qOxJ/9lGpCQc8m0mg4MKRaSN/2MpGzGVeZfxYipVdUk=;
        b=Ie7ioacxtx3vfzNwlpfTzKYxxZwi1DKq6nb+z24gx/ZcS8EXasQy+cmk1AWz4epB1/
         gHPZeGAAzalbp2MGiJqHhP91Ugv0mgfMl2sBg4e/GQv/h82060FPqJ9zLGk0OiH1RAEh
         zA3UT38rR0lnVZTiTK0aOSmYB/pgpmJ3gmI6jrx+7ZXIkZWGdcrP/j+fGn7EdYHg89MY
         9nPmXXnGNFZJKAbeG/qQ/ziweFykfu7En9o8k2zOYpFov8S5l5B1zHAGONOc98ks4Cp9
         V2i4/mKarzb15bqI2cV5ZtFRAeQZnVA7TlGV/2iHgMsoHmmLi9BQ79j8pQizPXpOjzv8
         wLMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759235548; x=1759840348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qOxJ/9lGpCQc8m0mg4MKRaSN/2MpGzGVeZfxYipVdUk=;
        b=Qx5sgGNEKTY3KCjTj+ia6Mvk4muSNTvkFSIlqJ7Bq25ssCe3DxmOK4q51MWmxzKIhM
         G4SVNJUoY6GJSBtPfptsb6vvHmGEFB6AMwNGIgga3yiGny12Uo9RWJ6g2JDN8/uNGGLw
         3OAZfcevuwhH33ZtOXkbpfUK2xCeGQ29NBfj3fAVzwY4Fabp7zNQxWXxKY+PwdlJ58fE
         DrIyZ1U9qK33z88WCz+daAPGceu2tShklov3zbhRa+E9CtEOE025XTzbBaoRNtf7CRYl
         irwcbrB7uwfVu0F6psjJNHC5AZzq7sekYRTqNOs4PMLxDwmlvFsyddffNi9WSuCkChvf
         gddQ==
X-Gm-Message-State: AOJu0YxXdA98j0B5Zor6OnNCHf6VwAUJ6a1K4iRZ9+k616qBy0ygjtxQ
	dVmiPKzRauVBcVyMUlIbMzsqMAyctppp0fx/0FRMAlkMn9aRVe3G5SAGAfc3ox0q+2KY9r44KmL
	RmY680GofoJWNnYuFqHHVMjDpywg1VJxZuA==
X-Gm-Gg: ASbGncvLfA4en4eG3VYiEC61FVz1mahPLfGeJ5HSOVDqT4GavzA73T94/bJWZguKXje
	XHFvNnmK2F6oE8GL2gXgOSsSeF4CEWuoXn4HUx5WWYUuLseoUhuzW/iao1R4CCutn1kNdhV2/nb
	SOaRMJpoZCJhsyXkp+xTI05jkvlb3zQqt6aiJpFhoaYOOxPh4FOLYhAq3BKOv0vHPFQM6Kv2mrZ
	jneL3ClTgPPhkDc4u9yJchqOBX83Yo=
X-Google-Smtp-Source: AGHT+IFplJlaTt+I8crzbv+2pr99EXB8kLNQeMnUmk07dqlDuJMgVWZw4bFNOx9SbY0ZC37nK92J//6698z+x2yk9kE=
X-Received: by 2002:a17:90b:4a03:b0:327:9e88:7714 with SMTP id
 98e67ed59e1d1-3342a2dce52mr21882854a91.37.1759235545656; Tue, 30 Sep 2025
 05:32:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918135904.9997-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20250918135904.9997-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 30 Sep 2025 08:32:14 -0400
X-Gm-Features: AS18NWCu90dopyu4ionTWRMmWXqDYurNX6BIW0jP_K3xZ6Ef0jQUJSAOXjKjgSc
Message-ID: <CAEjxPJ4owvoGxP74KDQqtzHx-o2XtwNvcE-HLEWH31dh77BGNw@mail.gmail.com>
Subject: Re: [RFC PATCH v2] lsm,selinux: introduce LSM_ATTR_UNSHARE and wire
 it up for SELinux
To: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc: paul@paul-moore.com, omosnace@redhat.com, john.johansen@canonical.com, 
	serge@hallyn.com, casey@schaufler-ca.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 10:07=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> RFC-only, will ultimately split the LSM-only changes to their own
> patch for submission. I have now tested this with the corresponding
> selinux userspace change that you can find at
> https://lore.kernel.org/selinux/20250918135118.9896-2-stephen.smalley.wor=
k@gmail.com/
> and also verified that my modified systemd-nspawn still works when
> starting containers with their own SELinux namespace.

As it turns out, I had NOT tested this with my modified systemd-nspawn
- it was picking up the wrong libselinux and fails if I used the one
updated to call the lsm_set_self_attr() system call instead of the
/sys/fs/selinux/unshare interface. This was due to systemd-nspawn
setting seccomp filters prior to the point at which it was doing the
unshare and lsm_set_self_attr() not being included in the allowlist. I
fixed this by moving the selinux_unshare() call before setting the
seccomp filters and that solved the problem. Updated systemd patches
pushed to my systemd fork for anyone trying this themselves.


>
> This defines a new LSM_ATTR_UNSHARE attribute for the
> lsm_set_self_attr(2) system call and wires it up for SELinux to invoke
> the underlying function for unsharing the SELinux namespace. As with
> the selinuxfs interface, this immediately unshares the SELinux
> namespace of the current process just like an unshare(2) system call
> would do for other namespaces. I have not yet explored the
> alternatives of deferring the unshare to the next unshare(2),
> clone(2), or execve(2) call and would want to first confirm that doing
> so does not introduce any issues in the kernel or make it harder to
> integrate with existing container runtimes.
>
> Differences between this syscall interface and the selinuxfs interface
> that need discussion before moving forward:
>
> 1. The syscall interface does not currently check any Linux capability
> or DAC permissions, whereas the selinuxfs interface can only be set by
> uid-0 or CAP_DAC_OVERRIDE processes. We need to decide what if any
> capability or DAC check should apply to this syscall interface and if
> any, add the checks to either the LSM framework code or to the SELinux
> hook function.
>
> Pros: Checking a capability or DAC permissions prevents misuse of this
> interface by unprivileged processes, particularly on systems with
> policies that do not yet define any of the new SELinux permissions
> introduced for controlling this operation. This is a potential concern
> on Linux distributions that do not tightly coordinate kernel updates
> with policy updates (or where users may choose to deploy upstream
> kernels on their own), but not on Android.
>
> Cons: Checking a capability or DAC permissions requires any process
> that uses this facility to have the corresponding capability or
> permissions, which might otherwise be unnecessary and create
> additional risks. This is less likely if we use a capability already
> required by container runtimes and similar components that might
> leverage this facility for unsharing SELinux namespaces.
>
> 2. The syscall interface checks a new SELinux unshare_selinuxns
> permission in the process2 class between the task SID and itself,
> similar to other checks for setting process attributes. This means
> that:
>     allow domain self:process2 *; -or-
>     allow domain self:process2 ~anything-other-than-unshare_selinuxns; -o=
r-
>     allow domain self:process2 unshare_selinuxns;
> would allow a process to unshare its SELinux namespace.
>
> The selinuxfs interface checks a new unshare permission in the
> security class between the task SID and the security initial SID,
> likewise similar to other checks for setting selinuxfs attributes.
> This means that:
>     allow domain security_t:security *; -or-
>     allow domain security_t:security ~anything-other-than-unshare; -or-
>     allow domain security_t:security unshare;
> would allow a process to unshare its SELinux namespace.
>
> Technically, the selinuxfs interface also currently requires open and
> write access to the selinuxfs node; hence:
>     allow domain security_t:file { open write };
> is also required for the selinuxfs interface.
>
> We need to decide what we want the SELinux check(s) to be for the
> syscall and whether it should be more like the former (process
> attributes) or more like the latter (security policy settings). Note
> that the permission name itself is unimportant here and only differs
> because it seemed less evident in the process2 class that we are
> talking about a SELinux namespace otherwise.
>
> Regardless, either form of allow rule can be prohibited in policies
> via neverallow rules on systems that enforce their usage
> (e.g. Android, not necessarily on Linux distributions).
>
> 3. The selinuxfs interface currently offers more functionality than I
> have implemented here for the sycall interface, including:
>
> a) the ability to read the selinuxfs node to see if your namespace has
> been unshared, which should be easily implementable via
> lsm_get_self_attr(2).  However, questions remain as to when that
> should return 1 versus 0 (currently returns 1 whenever your namespace
> is NOT the initial SELinux namespace, useful for the testsuite to
> detect it is in a child, but could instead be reset to 0 by a
> subsequent policy load to indicate completion of the setup of the
> namespace, thus hiding from child processes that they are in a child
> namespace once its policy has been loaded).
>
> b) the abilities to get and set the maximum number of SELinux
> namespaces (via a /sys/fs/selinux/maxns node) and to get and set the
> maximum depth for SELinux namespaces (via a /sys/fs/selinux/maxnsdepth
> node). These could be left in selinuxfs or migrated to some other LSM
> management APIs since they are global in scope, not per-process
> attributes.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v2 fixes a typo (PROCESS->PROCESS2) and is now tested.
>
>  include/uapi/linux/lsm.h            | 1 +
>  security/selinux/hooks.c            | 8 ++++++++
>  security/selinux/include/classmap.h | 4 +++-
>  3 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
> index 938593dfd5da..fb1b4a8aa639 100644
> --- a/include/uapi/linux/lsm.h
> +++ b/include/uapi/linux/lsm.h
> @@ -83,6 +83,7 @@ struct lsm_ctx {
>  #define LSM_ATTR_KEYCREATE     103
>  #define LSM_ATTR_PREV          104
>  #define LSM_ATTR_SOCKCREATE    105
> +#define LSM_ATTR_UNSHARE       106
>
>  /*
>   * LSM_FLAG_XXX definitions identify special handling instructions
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index f48483383d6e..1e34a16b7954 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6816,6 +6816,10 @@ static int selinux_lsm_setattr(u64 attr, void *val=
ue, size_t size)
>                 error =3D avc_has_perm(state, mysid, mysid, SECCLASS_PROC=
ESS,
>                                      PROCESS__SETCURRENT, NULL);
>                 break;
> +       case LSM_ATTR_UNSHARE:
> +               error =3D avc_has_perm(state, mysid, mysid, SECCLASS_PROC=
ESS2,
> +                                    PROCESS2__UNSHARE_SELINUXNS, NULL);
> +               break;
>         default:
>                 error =3D -EOPNOTSUPP;
>                 break;
> @@ -6927,6 +6931,10 @@ static int selinux_lsm_setattr(u64 attr, void *val=
ue, size_t size)
>                 }
>
>                 tsec->sid =3D sid;
> +       } else if (attr =3D=3D LSM_ATTR_UNSHARE) {
> +               error =3D selinux_state_create(new);
> +               if (error)
> +                       goto abort_change;
>         } else {
>                 error =3D -EINVAL;
>                 goto abort_change;
> diff --git a/security/selinux/include/classmap.h b/security/selinux/inclu=
de/classmap.h
> index be52ebb6b94a..07fe316308cd 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -60,7 +60,9 @@ const struct security_class_mapping secclass_map[] =3D =
{
>             "siginh",       "setrlimit",     "rlimitinh",   "dyntransitio=
n",
>             "setcurrent",   "execmem",       "execstack",   "execheap",
>             "setkeycreate", "setsockcreate", "getrlimit",   NULL } },
> -       { "process2", { "nnp_transition", "nosuid_transition", NULL } },
> +       { "process2",
> +         { "nnp_transition", "nosuid_transition", "unshare_selinuxns",
> +           NULL } },
>         { "system",
>           { "ipc_info", "syslog_read", "syslog_mod", "syslog_console",
>             "module_request", "module_load", "firmware_load",
> --
> 2.50.1
>
