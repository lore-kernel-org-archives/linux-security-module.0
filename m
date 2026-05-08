Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790E9352921
	for <linux-security-module@vger.kernel.org>; Fri,  8 May 2026 20:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778271048; cv=pass; b=g1hvALswwfvngMDRgUVpup+qgTx41e62qw3FUMt6xflV+fQlAF9ZJY1yuLAEENIkIBe8tUc6tCIohI6DP0B+fZavwj79heF4uZDXqZV+X/LqxO9LHByzkH6mMK+XkXmDQBaeQi1qBM2KmnJsg9+7KKA2K2B2oln4DPp5/zqjF6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778271048; c=relaxed/simple;
	bh=TFrVhtXRzGaWgGBXsdmPjdMWa4luc0ZPlbhrFgpSi0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EQqH+RqO+aLipMzzjiPJWvHL7J98XNvdElT82ptk20z+3WPmUYfbp4wQcouFdfj8VgAEsRJFHTJ2VMcm3DZ423vJLdUiCwfgmbe1+xLJw+XDx8J7BQwuPMxbh5F26OMZmSU8zOrl5ElJmOWrCm4b84b+0SEXZ9QQGSytRO3kN20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Dilxkrhk; arc=pass smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Dilxkrhk"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-367c26471f5so261369a91.1
        for <linux-security-module@vger.kernel.org>; Fri, 08 May 2026 13:10:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778271047; cv=none;
        d=google.com; s=arc-20240605;
        b=UVJzkiMSzt8kM2lnHG4g/+8vhC/Stk/1THiLnk6MELFxf+T/FBsWjzTiVJXj20ctc/
         xGK4wU6PTawKqI9nejcfpVnwsKxS5KWxC2+m0Z/BY1jsJ/T0rcVHNVpOhncJlzAVNpda
         wyGdBd9pFWfCQKIunEqjHELkrxXD6Qtgb0NFYCqEt14AWG3gZt0/pj3gwQDM+Xpq/V9u
         Fvcj3tHI/6F38yr712TzJMhn/MikwvLuD3XdJARgwCufwmU7W27TkDJfvGUgi5FgXpAJ
         l6fT2xeoTTM1fwVaIFRBAU6mjltl2tsseqDSoyMZn8Bf+e4kbgkOEBHpanLqoOB8KzpW
         6lsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RHUkpCYBtC8f1kSrbyE8l06+fmWuae05jJfS+5AeM9M=;
        fh=97bavFZaQtKuelV2NmX4bNKgv1zqm1NxDd44Jjr83HE=;
        b=i/5IXKRLdZ6OSMFFY8mg7pQ/2T/hB1YKkG0OPRnZbXgWSz23PbkFlEnLSCMTP4MiOU
         1KufRMUNXRHclu7HIyO9uzrYUDqewyZ8XR1CJpv7Gf5Eph4gBXw1xarHNVQW5DRabUHs
         mHm3ejAo2E80KdLMsPaRZUCyWijFCyux9il5VV//6ksdEAWeBpQeby9aTzCz1gTY4J4p
         ETO8bIoa159eAXJ2mW8Aozq8TQzTnO+iSXgkw7kSNYE0fMQee7s4tLu1SVeQq88bvh8M
         mq8+2f75ctA6tEq6LD1bO3Blf9fQ1x84iizEIAq8u35ABBPk8LVem0NUDPDDr6T3NaLk
         L3jg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778271047; x=1778875847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RHUkpCYBtC8f1kSrbyE8l06+fmWuae05jJfS+5AeM9M=;
        b=DilxkrhkAC0uzjjPyGt0+4VO4px4J2U/CkzkF2kqx27AeLOR08LHs5M3UWt2Kvvquo
         fMVYkhrJSw4aaKmdrPFCDeBTD2AHlTFEgj3YRXdyMqmCrQQfG7VgO/izsfsJ0ZymU7bb
         zJz4aDeqeyFHYcqlJDbqh9mdzu1gX/Ig/C6s3Ag51ph3iAEo07QUkIjSPcO0MZ/jL118
         wDyKByZuiGPjFI7X47aK5YlQUBYb1AbSNy0h/1vexTm3tXxZVG9nzk7sCCnrw3Bif39+
         pjedrbaWmIYZ/9st1s2dXfCj+9M+6KQ6eoxgjWIIJq0UHQo8gABcnLG241siBBnikFbe
         Asug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778271047; x=1778875847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RHUkpCYBtC8f1kSrbyE8l06+fmWuae05jJfS+5AeM9M=;
        b=sER5SoD3bqHWfzYVDTs8Mv83AChowFZMGOFosDxfMpXkjPJGQJfc0fSL0n35haSfgT
         lX1i5LDbelpWoBZshI6b0zbErAPEoclUUp+RnssmEjwBjZsENpV7VhxnqhvZZ/zkNVR4
         VAzRyRHb6pwT5st4fzqCdtxU1Cv4l+FuP/hvo5TUZ1/B0F9lAU6sc5yQqzL7sEO1ID+C
         EpSWjmSj6XdmsyT3RYnbacsjq6Pi6GzUu6vgrBivZOLN1zJsPXLoog5cgjkPVPR8DxJ7
         BbFnpxsHoJibe0zruBfo3d3UFiTcgSr6OKvDC/isUS0Tz5cMSlaQABGEPUoRH4+pT1To
         95RQ==
X-Gm-Message-State: AOJu0Yza+Jc1Z8GOc/b+ltG00DrLANzOKc0xUfnnG5gwBSNryp2orWQ0
	Q6jeb2cy0nd9G9UWo9cl0oQWaYTR7lOOkzJtoJZOL5Wd7Df+fc1JospTUhZTnhQZjA1saQOsMBY
	S/Lrj/eTVN/JBkJvCH3+SH1scgDy6xA9L7pQQAneP
X-Gm-Gg: Acq92OH4kUm5Lja6ULU+S/hv6Pl7QDIswvI179WpJA0UIERdrHcVl/WWqJYE7SdKGN3
	jUPAEqZwgtIXUGYvc2kZ4cAapjiF7OYbTxEf820q3kq9HUCGGnTU+tNhvDkxyqGr36sMPIAi2CP
	jBIzD7nnZver+wmmrOGEihtK10DLg5Wz0hNMlEjxUS5NdSnZQ+L2SJPjQIiRLm4+ODAyWAnlpD8
	LC3ngOPuzmNamQt/FBbdbA8kklC/WLrj2PbCM7EQHMIFt/qwH3MdOqZQGxD0Eejpy4jjwTsSBDd
	U67VflFZOSmezloeWg==
X-Received: by 2002:a17:90a:509:b0:366:3ac:f730 with SMTP id
 98e67ed59e1d1-36603ad3f55mr6058264a91.25.1778271046680; Fri, 08 May 2026
 13:10:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430000315.918964-1-song@kernel.org> <20260430000315.918964-2-song@kernel.org>
In-Reply-To: <20260430000315.918964-2-song@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 8 May 2026 16:10:34 -0400
X-Gm-Features: AVHnY4JzYJuAYc9q9BmVnJzCXV6FuyRu5-uJafEtOUSW60YQOAJP4PpQpgO2G2Y
Message-ID: <CAHC9VhT6YxJQqSkBbSeACFL6+AoL0031u2VT4fuRqPxDkGzSfw@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] lsm: Add granular mount hooks to replace security_sb_mount
To: Song Liu <song@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	selinux@vger.kernel.org, apparmor@lists.ubuntu.com, jmorris@namei.org, 
	serge@hallyn.com, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	john.johansen@canonical.com, stephen.smalley.work@gmail.com, 
	omosnace@redhat.com, mic@digikod.net, gnoack@google.com, 
	takedakn@nttdata.co.jp, penguin-kernel@i-love.sakura.ne.jp, 
	herton@canonical.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 8:03=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> Add six new LSM hooks for mount operations:
>
> - mount_bind(from, to, recurse): bind mount with pre-resolved
>   struct path for source and destination.
> - mount_new(fc, mp, mnt_flags, flags, data): new mount, called after
>   mount options are parsed. The flags and data parameters carry the
>   original mount(2) flags and data for LSMs that need them (AppArmor,
>   Tomoyo).
> - mount_remount(fc, mp, mnt_flags, flags, data): filesystem remount,
>   called after mount options are parsed into the fs_context.
> - mount_reconfigure(mp, mnt_flags, flags): mount flag reconfiguration
>   (MS_REMOUNT|MS_BIND path).
> - mount_move(from, to): move mount with pre-resolved paths.
> - mount_change_type(mp, ms_flags): propagation type changes.
>
> These replace the monolithic security_sb_mount() which conflates
> multiple distinct operations into a single hook, and suffers from
> TOCTOU issues where LSMs re-resolve string-based dev_name via
> kern_path().
>
> The mount_move hook is added alongside the existing move_mount hook.
> During the transition, LSMs register for both hooks. The move_mount
> hook will be removed once all LSMs have been converted.
>
> Some LSMs, such as apparmor and tomoyo, audit the original input passed
> in the mount syscall. To keep the same behavior, argument data and flags
> are passed in do_* functions. These can be removed if these LSMs no
> longer need these information.
>
> All new hooks are registered as sleepable BPF LSM hooks.
>
> Code generated with the assistance of Claude, reviewed by human.
>
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com> # for selinux=
 only
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  fs/namespace.c                |  35 ++++++++++--
>  include/linux/lsm_hook_defs.h |  12 ++++
>  include/linux/security.h      |  50 +++++++++++++++++
>  kernel/bpf/bpf_lsm.c          |   7 +++
>  security/security.c           | 101 ++++++++++++++++++++++++++++++++++
>  5 files changed, 199 insertions(+), 6 deletions(-)

...

> @@ -3708,6 +3724,10 @@ static int do_move_mount_old(const struct path *pa=
th, const char *old_name)
>         if (err)
>                 return err;
>
> +       err =3D security_mount_move(&old_path, path);
> +       if (err)
> +               return err;
> +
>         return do_move_mount(&old_path, path, 0);
>  }

While the security_sb_mount() hook calls into do_move_mount_old(), the
security_move_mount() hook calls into do_mount_mount().  As you remove
both of these LSM hooks in patch 7/7, should we consider moving the
new security_mount_move() into do_move_mount()?  If not, how do we
ensure that we don't lose coverage when removing the
security_move_mount() hook, or can you explain why it is not needed?

--=20
paul-moore.com
