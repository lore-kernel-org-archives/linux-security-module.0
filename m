Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C674D8D83
	for <linux-security-module@vger.kernel.org>; Mon, 11 May 2026 21:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778536195; cv=pass; b=uHx3OTTkt9BjG0vbRGr2cr7/s9iHn05PCa4yrIELevhUXJ3CsyVZ+0aAr+7+pQSV1Rns4fqfQQwJbg3SoSDD9oioT6qlhkensY1hA+6APB3l2Xh1njXk/vkBlgAzYRhJ9EvfDYQJtNiFabZqtSCT5s0dq29nJzINJhCyYIk/di4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778536195; c=relaxed/simple;
	bh=XdHPTUaon4qMKhfV+GkVLIq6iUv15qkFI3hbCXwnh+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R02GVAsFGcEzWTiYzPphx8eRbL0u/c6vJpXy4+IGqDlVYk70yN21hIZKBKK+b5Qb6lkX6lcklvc4ruKE3hwxw5ZFFy4bltLH6e13ptkBpOcdOYpb0T24+o8MfOCrESdDJUhwC0X9Lj7KDPa9yP5YGLYOSHIWgzULIYnQy8eAo5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=d+piT+16; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="d+piT+16"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ba928852a5so31829205ad.1
        for <linux-security-module@vger.kernel.org>; Mon, 11 May 2026 14:49:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778536193; cv=none;
        d=google.com; s=arc-20240605;
        b=LrmdWd/Ybfd9o5ja5li3NojCf14PftnxYtNO2RbfXebA9/EgwVwLVHd6J1WqcTRlEo
         ZziiwaJIJ9A8oxzg0aDCzoSoGjQk3sWV6m5H86o6wLBkMGLzaxUijCYGDu+xXFL8Gl/Z
         H/kAugyD2HtW2divEU6QVCRixB64TCezk960/pLLadtOPP1t27lbSqJmbonOHfL58DU3
         7npEXgFQyLuoslBuAdDqhYr0uMLduetA3xb6N/Oy9QlzFeblq24DZtuX75n8+7hhzhvm
         Nta7X+g19vv7JNNwp1aJXM6ckkfLpGutiiBwz1UYslkciuzvh2UQ2Q9ikb7ANuO8SrWR
         aA3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OUo4L4WIPQHPOig8wBsHK8psuw6OsB6Z+20wUPEg6uQ=;
        fh=PjYz1zP15p3gecshlIro6ts6WCNzcjo7DF0D5JS6pPo=;
        b=bkZ/aew756Bq5oog99kNo5YkrJ4srAKL3ZPUa4jJwaN183cg4D4d3LtpaZ6QLOLah0
         2XKwZlfKZaN3tsyPHEymafYt3l/9l47JwM78rp6TYolENqHO6VF/QhbLqqTkgoEzrPcw
         8rdIV29tqF1jLTH0pzmcHQ4AmI1ub4DhNAjKvdUpocBeebzby+4wHeYmZGdlkxwVUhFc
         YfjPKahM+G8HguzEbFCZzlgJt83MhcwMbx0JkuUP+ZEErTea7o3TRelv0T3OI+uBlqVD
         dyCChJZRccgO0eHgDlB7zQ9vS5k38KhijKMj9kP0507SSWdrYipTErz+KKQww2l3PPuu
         JyCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778536193; x=1779140993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUo4L4WIPQHPOig8wBsHK8psuw6OsB6Z+20wUPEg6uQ=;
        b=d+piT+166KTh11CzzCnG4+5N0K1/YavckPMcdG0/S8KtpHSbON7V6L4eoGSh4qD+PX
         YoNUUB9z2E0pGUkerB28PTeKlQ6meewUicg/zD3ki9YbReVMhqvVOCFhnFy+8xx7wSMI
         sLDJ62VH9XJe1d+X77hq8gWJdzKxgGA9rImJekiRzc7PanVPEYRJ3nLjEqcMlLnr8w/8
         My9JxF/5OWQIhxXO12yXmeEq780AL7wts3SezHWhuY1IkuWJ+QtqgpbYw2Txlip+5z6x
         dws6Hoiql7JeYTmtAX50YOD43V/ZjanRCH3lozV4HfDk+bEi+tFJrcd/xbaGxq3IVJT+
         uYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778536193; x=1779140993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OUo4L4WIPQHPOig8wBsHK8psuw6OsB6Z+20wUPEg6uQ=;
        b=dl+1PWP6XJwwuC6NM8wgENBvNA6M1EFvPr/CSldBJqNt9fOEU/XF0hav4dg6fYBiqK
         5i3tT+OCO9zwGSTbMHTaarTrHILOvjdmN/fkS9BDH3E+cdW4ElT6+jULp8Q08UL330fy
         fDjjKf1o9JYTKBPH47WZZF0lZQJn9LIetK8lpfc3hB7IYHG3ai2FIr975eve/GzgzOs8
         glqu3jtx1x2P7tqU4PMbjNWZtKe0nF0/qT4MfcnT8irD8krpT1jIGxUpIqb6rRHIvguc
         TCEWfdwdSFfVwGgQnxyxMFf7CHHlz6owe2o7QvEYRXjAHs4SZtVRAbKbKyex0dsFJ/hR
         uHkg==
X-Gm-Message-State: AOJu0YwKCZIf6R6uprXN2xA/oZCP6mAKQESLkgXKVuBwTJvCMtPyX2Zu
	rpEJ/9clEM9fbme+aBhGmUbdBene8Gi9O07O1RqPdxlqoY9Dse/21RmT8co/zgbmniBiSm01suE
	RMFC2nhrvzC4cUZzStlORFytCzu+alipPohrTFZmDglpqrXV4kutQMQ==
X-Gm-Gg: Acq92OF3xzuh+XWgkNVgXaoMzwNw+estUZeRDdMTZrA7xU+0fCE5DtfUCsatBq0Dzth
	s16Yv41Ys4PF3toebE7wVpENhchnpG2fgrFwZJ+U9YQNQPm6XftpEeQUv6w7AKCy4fksZzEgxA1
	cKcBN295yQVWdrFF6GosM45QwfgJ56EozlYQETMrooUpvpAbQn8KEK/DGPJTp/E2G4a9S4jt08H
	2AJBytupbCXEZv9hhucX5W90kwn9az8dfa/RHapIm09tax17hhnSKvEeAES2LILs2zdKqNjC4qk
	JzUhjQIB5ZEhxUMHfw==
X-Received: by 2002:a17:902:7c82:b0:2b9:fb9a:1103 with SMTP id
 d9443c01a7336-2bc7ac8b06amr80747045ad.38.1778536193220; Mon, 11 May 2026
 14:49:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <agDuCdGIeM-6z-j-@altlinux.org> <CAHC9VhQ4VyAvG-z2h2NFpPx9PcJP4Ot2Ap=MPbCRk2TosJWOTA@mail.gmail.com>
 <agI9Rdi-72f8dNbB@altlinux.org>
In-Reply-To: <agI9Rdi-72f8dNbB@altlinux.org>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 11 May 2026 17:49:39 -0400
X-Gm-Features: AVHnY4Ja7h2T0iiBovZjmBZ_dd3oYXhTgK2-VnHqO-CqDAWECmhpgQlAIJ5QMl0
Message-ID: <CAHC9VhRWNEzYx3Xxtxv_0BBkM7skisVdnKXx3CGn3S=aoBCiyQ@mail.gmail.com>
Subject: Re: [BUG] lsm= with bpf before selinux breaks fscreate with EINVAL
To: Vitaly Chikunov <vt@altlinux.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	selinux@vger.kernel.org, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 5:03=E2=80=AFPM Vitaly Chikunov <vt@altlinux.org> w=
rote:
> On Mon, May 11, 2026 at 04:19:34PM -0400, Paul Moore wrote:
> > On Sun, May 10, 2026 at 5:17=E2=80=AFPM Vitaly Chikunov <vt@altlinux.or=
g> wrote:
> > >
> > > Hi,
> > >
> > > We have boot failure when CONFIG_LSM has "bpf" listed before "selinux=
"
> > > (without bpf lsm scripts loaded). (This also happens with a boot with
> > > "security=3Dselinux" if selinux was not in LSM=3D list but bpf is.)
> > >
> > > systemd reports on the failing boot attempt:
> > >
> > >   Failed to set SELinux security context generic_u:object_r:device:s0=
 for /dev/shm: Invalid argument
> > >   Mounting tmpfs to /dev/shm of type tmpfs with options mode=3D01777.
> > >   Mounting tmpfs (tmpfs) on /dev/shm (MS_NOSUID|MS_NODEV|MS_STRICTATI=
ME "mode=3D01777")...
> > >   Failed to mount tmpfs (type tmpfs) on /dev/shm (MS_NOSUID|MS_NODEV|=
MS_STRICTATIME "mode=3D01777"): No such file or directory
> > >   Failed to set SELinux security context generic_u:object_r:device:s0=
 for /dev/pts: Invalid argument
> > >   Mounting devpts to /dev/pts of type devpts with options mode=3D0620=
,gid=3D5.
> > >   Mounting devpts (devpts) on /dev/pts (MS_NOSUID|MS_NOEXEC "mode=3D0=
620,gid=3D5")...
> > >   Failed to mount devpts (type devpts) on /dev/pts (MS_NOSUID|MS_NOEX=
EC "mode=3D0620,gid=3D5"): No such file or directory
> > >   No filesystem is currently mounted on /sys/fs/cgroup.
> > >   Failed to set SELinux security context generic_u:object_r:def_t:s0 =
for /sys/fs/cgroup: Invalid argument
> > >   Mounting cgroup2 to /sys/fs/cgroup of type cgroup2 with options nsd=
elegate,memory_recursiveprot.
> > >   Mounting cgroup2 (cgroup2) on /sys/fs/cgroup (MS_NOSUID|MS_NODEV|MS=
_NOEXEC "nsdelegate,memory_recursiveprot")...
> > >   Failed to set SELinux security context generic_u:object_r:def_t:s0 =
for /sys/fs/pstore: Invalid argument
> > >   Mounting pstore to /sys/fs/pstore of type pstore with options n/a.
> > >   Mounting pstore (pstore) on /sys/fs/pstore (MS_NOSUID|MS_NODEV|MS_N=
OEXEC "")...
> > >   Failed to set SELinux security context generic_u:object_r:def_t:s0 =
for /sys/fs/bpf: Invalid argument
> > >   Mounting bpf to /sys/fs/bpf of type bpf with options mode=3D0700.
> > >   Mounting bpf (bpf) on /sys/fs/bpf (MS_NOSUID|MS_NODEV|MS_NOEXEC "mo=
de=3D0700")...
> > >   [!!!!!!] Failed to mount API filesystems.
> > >   Freezing execution
> > >
> > > 'Invalid arguments' seems from setfscreatecon_raw.
> > >
> > > Reproducer:
> > >
> > >   Boot with lsm=3Dlockdown,capability,landlock,yama,safesetid,bpf,sel=
inux,ima,evm
> > >
> > >   (none):~# cat /proc/thread-self/attr/current
> > >   cat: /proc/thread-self/attr/current: Invalid argument
> > >   (none):~# echo > /proc/thread-self/attr/fscreate
> > >   bash: echo: write error: Invalid argument
> > >
> > > This appears to be caused by security_getprocattr / security_setproca=
ttr
> > > iterating until the first hook defined (which is bpf) and returning w=
ith
> > > default value -EINVAL before selinux even sees them.
> >
> > Thanks for the problem report, the general recommendation is to place
> > the BPF LSM towards the end of the list (see the CONFIG_LSM Kconfig
> > help text), but we're trying to ensure that the BPF LSM works properly
> > when placed anywhere in that list.
>
> I think if the order is important it should be handled in the code like
> for capabilities and ima/evm LSMs, not by forcing the user to discover
> the correct order with trial and error.

Patches are always welcome, although as I mentioned to you previously
we are working towards supporting arbitrary ordering for BPF LSMs.

> > My apologies if you're abilities are well beyond this, but if you are
> > familiar with patching and building your own kernel, have you tried
> > changing the LSM_RET_DEFAULT value for those functions to zero/0?
> > Assuming userspace is happy with that, I believe it may solve this
> > problem.
>
> I can patch and test if this is useful to find the correct solution, but
> the description is a bit vague. Did you mean
>
>   include/linux/lsm_hook_defs.h:301:LSM_HOOK(int, -EINVAL, getprocattr, s=
truct task_struct *p, const char *name,
>   include/linux/lsm_hook_defs.h:303:LSM_HOOK(int, -EINVAL, setprocattr, c=
onst char *name, void *value, size_t size)
>
> In these lines to replace -EINVAL with 0?

The patch below is what I had in mind (although be warned that was
just a cut-n-paste into this email so it is likely whitespace
damaged).  If you are able to give that a test it would be great, if
not, I can throw it on the todo pile.

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 2b8dfb35caed..12724e259900 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -298,9 +298,9 @@ LSM_HOOK(int, -EOPNOTSUPP, getselfattr, unsigned int at=
tr,
        struct lsm_ctx __user *ctx, u32 *size, u32 flags)
LSM_HOOK(int, -EOPNOTSUPP, setselfattr, unsigned int attr,
        struct lsm_ctx *ctx, u32 size, u32 flags)
-LSM_HOOK(int, -EINVAL, getprocattr, struct task_struct *p, const char *nam=
e,
+LSM_HOOK(int, 0, getprocattr, struct task_struct *p, const char *name,
        char **value)
-LSM_HOOK(int, -EINVAL, setprocattr, const char *name, void *value, size_t =
size)
+LSM_HOOK(int, 0, setprocattr, const char *name, void *value, size_t size)
LSM_HOOK(int, 0, ismaclabel, const char *name)
LSM_HOOK(int, -EOPNOTSUPP, secid_to_secctx, u32 secid, struct lsm_context *=
cp)
LSM_HOOK(int, -EOPNOTSUPP, lsmprop_to_secctx, struct lsm_prop *prop,

--=20
paul-moore.com
