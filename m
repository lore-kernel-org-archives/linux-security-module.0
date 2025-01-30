Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22311AC884
	for <linux-security-module@vger.kernel.org>; Thu, 30 Jan 2025 21:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738271167; cv=none; b=cw6wLXc0TuPmv2vVO8zvE6ojfIsY/zYeRx4TE20c4pH71gE6g3YDJA+s2avNiL1vmMXv283ZQCKGlTWVP6UAmYAM7ad0kA/Vgl2proaFwoPJcdpi/FzZDrb4AbreC/Mj+Ym9eipuGYBCrff1icqUuEGv7cUAq3dPrxTgUhl+w7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738271167; c=relaxed/simple;
	bh=OL48AjWgPca1qpR+kW+bsAv3I245rdLzl9l0Juze94M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PNjR/jR7clv1B/+2vdL6+HyXyGfgZsog51oPaKhBSh9aAhVFI2VNQED1CYJ06OKsyi1vCKC3IXb4t7B0k8pAVAr1K5WhZfIYV6XsT3g796iPJhVlDSL/+usofZ0thErUfNd8exAWaUd1gKmuHDLdb7D1Q30cAm4O63UZ0hZ+u3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Xikvh0Ei; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Xikvh0Ei"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6f0054cb797so3071757b3.0
        for <linux-security-module@vger.kernel.org>; Thu, 30 Jan 2025 13:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1738271165; x=1738875965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0tKV1aO06e/O0OrbzjacFwylG9jIZZkGMi9QwaFoQw=;
        b=Xikvh0Ei9njvYQ/0F9rmMUYPL3PllVVKrPICj2L15ktjltew4nYmKHFn8u4chfxyee
         ntci+gmnBm+4DW69F02pnkll+QudoRQHgd4bJUWSl4MKDOiAMeohbJuMu9r8zjAoxmZX
         KrRPzu6bCpUZg7oUzJ9IW8dVKHYtWJ/sXhFbKMGozevBzUIs0BU3hsUz9pKWenbJBAAp
         WDRsVkIsABSE6qLp+/HalsgnyxzboYtKQgt/LD/qvIVBuwA0k3Z1LuINNbaoec0UskQk
         5POum7dIn6Yh1wdMl9LKgV1mgjNtZhNsWwr28oksM6Z/UX2zXXHjwLa30ehZIlQxIbtG
         lCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738271165; x=1738875965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J0tKV1aO06e/O0OrbzjacFwylG9jIZZkGMi9QwaFoQw=;
        b=hUfPyWm0mA68LdjI+T2A+otJJOBeSNQMXINV4Q/ytL9lsg6A2sywk/7cxiioypIdgI
         XMdxKDmcHm4KQQzRRh87frxeW+PmJfZnfS2NuSosffMJ9CIcVJpdVNtn2Zcv9GVIHVCz
         SpUzAkmweCLH59YDJzdPfByXajwFle4B4MLUTpDABOATBq1+Kd774mU05gdUi1E4kLBA
         NjyaYAfzMRS5hsJkXBcMxUGO1cBRBzzyZEBR15yAFCL6WHKoHiBM3BKwxhd0eNMfLBFx
         JEdl4po5aQjbN4OmoCOc8wTJ4SQ50trao0uZP3yj+QBBUz6Hw/4uVYOY6dAspEZxtMq4
         b8nw==
X-Forwarded-Encrypted: i=1; AJvYcCXBXINU9Kkm0oy6HjZlqBBuUC0VmzIXK3qvNCLa70pLh92PYoFiuL8kNI+z/AwC+bB11X1JSO1pIJ0Qion64i/J5iUgL/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw2k8mSA1joIb5ZE4ww4kZPl0zKC+GHTK/6+V5OINi5/O05Rid
	WGkoEWp4EZU9axKDeW2bEHm6bdSPuVuMQNVFOJxIsfZZ39WXLBbGtwRpYnJZrVqruXry4olZe67
	R2fWVLfoK84SHvOqyV/bzKEMMd3vAn4CuLPtL
X-Gm-Gg: ASbGnct0+tvb8mUBx2MieVgyuGco8P3UNZWxlu9hpVR+Mn5PAe9R2EWYRvZoCrtK3eA
	Se7B6jmKM60g0v+PLMB/3c5/N4sPnWA3jSRk9PcVWlOY6GvM/L9sEm0dHXGNzkutPNjLH22I=
X-Google-Smtp-Source: AGHT+IH+ckwfvZFjliyWvxAApv5Gvw35jbwVywAqbuEKp/REwr8ScUlmNPXqS/akwDlB60L/XLa+LIC+kidTyTg8nGE=
X-Received: by 2002:a05:690c:6602:b0:6ef:4a57:fc98 with SMTP id
 00721157ae682-6f7a8354df6mr74999037b3.16.1738271164623; Thu, 30 Jan 2025
 13:06:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250129165803.72138-1-mszeredi@redhat.com> <20250129165803.72138-3-mszeredi@redhat.com>
In-Reply-To: <20250129165803.72138-3-mszeredi@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 30 Jan 2025 16:05:53 -0500
X-Gm-Features: AWEUYZkqXlCOfnnMA-0yOjXYsL2G1YyD1829MDG4OZWumGa043Y7iRqeD-zMfbY
Message-ID: <CAHC9VhTOmCjCSE2H0zwPOmpFopheexVb6jyovz92ZtpKtoVv6A@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] fanotify: notify on mount attach and detach
To: Miklos Szeredi <mszeredi@redhat.com>, Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Amir Goldstein <amir73il@gmail.com>, Karel Zak <kzak@redhat.com>, 
	Lennart Poettering <lennart@poettering.net>, Ian Kent <raven@themaw.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2025 at 11:58=E2=80=AFAM Miklos Szeredi <mszeredi@redhat.co=
m> wrote:
>
> Add notifications for attaching and detaching mounts.  The following new
> event masks are added:
>
>   FAN_MNT_ATTACH  - Mount was attached
>   FAN_MNT_DETACH  - Mount was detached
>
> If a mount is moved, then the event is reported with (FAN_MNT_ATTACH |
> FAN_MNT_DETACH).
>
> These events add an info record of type FAN_EVENT_INFO_TYPE_MNT containin=
g
> these fields identifying the affected mounts:
>
>   __u64 mnt_id    - the ID of the mount (see statmount(2))
>
> FAN_REPORT_MNT must be supplied to fanotify_init() to receive these event=
s
> and no other type of event can be received with this report type.
>
> Marks are added with FAN_MARK_MNTNS, which records the mount namespace fr=
om
> an nsfs file (e.g. /proc/self/ns/mnt).
>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/mount.h                         |  2 +
>  fs/namespace.c                     | 14 +++--
>  fs/notify/fanotify/fanotify.c      | 38 +++++++++++--
>  fs/notify/fanotify/fanotify.h      | 18 +++++++
>  fs/notify/fanotify/fanotify_user.c | 87 +++++++++++++++++++++++++-----
>  fs/notify/fdinfo.c                 |  5 ++
>  include/linux/fanotify.h           | 12 +++--
>  include/uapi/linux/fanotify.h      | 10 ++++
>  security/selinux/hooks.c           |  4 ++
>  9 files changed, 167 insertions(+), 23 deletions(-)

...

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 7b867dfec88b..06d073eab53c 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3395,6 +3395,10 @@ static int selinux_path_notify(const struct path *=
path, u64 mask,
>         case FSNOTIFY_OBJ_TYPE_INODE:
>                 perm =3D FILE__WATCH;
>                 break;
> +       case FSNOTIFY_OBJ_TYPE_MNTNS:
> +               /* Maybe introduce FILE__WATCH_MOUNTNS? */
> +               perm =3D FILE__WATCH_MOUNT;
> +               break;
>         default:
>                 return -EINVAL;
>         }

Ignoring for a moment that this patch was merged without an explicit
ACK for the SELinux changes, let's talk about these SELinux changes
...

I understand that you went with the "simpler version" because you
didn't believe the discussion was converging, which is fair, however,
I believe Daniel's argument is convincing enough to warrant the new
permission.  Yes, it has taken me approximately two days to find the
time to revisit this topic and reply with some clarity, but personally
I feel like that is not an unreasonable period of time, especially for
a new feature discussion occurring during the merge window.

If you need an example on how to add a new SELinux permission, you can
look at commit ed5d44d42c95 ("selinux: Implement userns_create hook")
for a fairly simple example.  In the watch_mountns case things are
slightly different due to the existence of the COMMON_FILE_PERMS
macro, but you basically want to add "watch_mountns" to the end of the
COMMON_FILE_PERMS macro in security/selinux/include/classmap.h.  Of
course if you aren't sure about something, let me know.  As a FYI, my
network access will be spotty starting tonight and extending through
the weekend, but I will have network/mail access at least once a day.

Now back to the merge into the VFS tree ... I was very surprised to
open this patchset and see that Christian had merged v5 after less
than 24 hours (at least according to the email timestamps that I see)
and without an explicit ACK for the SELinux changes.  I've mentioned
this to you before Christian, please do not merge any SELinux, LSM
framework, or audit related patches without an explicit ACK.  I
recognize that sometimes there are highly critical security issues
that need immediate attention, but that is clearly not the case here,
and there are other procedures to help deal with those emergency
scenarios.

--=20
paul-moore.com
