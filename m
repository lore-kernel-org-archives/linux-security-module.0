Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5203E28B4FD
	for <linux-security-module@vger.kernel.org>; Tue, 17 Mar 2026 02:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773713130; cv=pass; b=MsVd0AJVbP6rNxa8aI/3RB7UdgVSPKWJjHefcdWjMDWUL08PYUUjXSCG9lptm5auB5mwE+aPTbG0OX/lsRvFKGrpq9kSOI3y+2bprI2HjVZuw3g18r3CU/RDVGt0cgOH4qKlPOU8iyV2xEMcq/H3P6YdIDHoB18Oa+sG85UU2Jw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773713130; c=relaxed/simple;
	bh=Pa15k/f7JCsKm8Ta1ZcAIc8csfcefiqxdQimuxdBxkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Frj6bN8I/qEox3O9nl0R+jsUq31dO6tWTpvf889Hx8Z+z3no5XOlrQlR1F1zufES8iK/0Ar/K1u3lbdDM3Fsy9WS13HsZOcELRuTYtFShUoDzLiIEpQpcS307DnMS/c4C6QcgTbO0BEDvAVi8CjHMQ9a8H2nqbbWmH9qp5xXezY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jaf/7i6A; arc=pass smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jaf/7i6A"
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-4327790c4e9so3757556f8f.2
        for <linux-security-module@vger.kernel.org>; Mon, 16 Mar 2026 19:05:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773713128; cv=none;
        d=google.com; s=arc-20240605;
        b=js13+sEHCpvto1NxRZwfwvdbRkZGF6WSHUvudC+lbnkNBgO8lxrNsmNR8eAdqn6XQG
         LC6LIkxwowgavTjwFPg+yOx9hC4Jxt+FhWrK1eepap3dYfGL7nWk+lVGbbS2qAWkZaSz
         w3UhS2gwx6o3zRivTARHgLIqUZh7cr5wYOl6EAmLuzPTPMidcBCWsK8ggNUU0Esv6u79
         TISQQZhbmJ2cis+Cp6V4XTFHcZlar3MFHb///QTWB+pWxO86drhl9PBbT19yueVsTk+D
         yhu+NrrdJ6Cm+hJ8pYMSLMs/kc7NpaDBFQXvMBqVZNaSdkkJG7QOXiBXIhcbn6eU/+zS
         Emdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qM8PvAQjaxTMcJaMWaL4GPi/Stw1aNsHY3fxQVFtBvE=;
        fh=xd5EEVBolfvoT1jj7KC5JEtc+BTnhQ24Pwf68/+qmu8=;
        b=Z+Q3xriublpPbMRU/SGoGXSDd1dixiIDzulLUY/8C6W7nGApfmBL+ZnMNc0mYLhaqg
         a0RDwvv13w2VExT0Dyal25i4z+/Kxu8tRt8mBkxqyw2csiG+ZIEokVCHy1o5LtaiYpyJ
         gXMMk0dIW57h8RY1MUWtZJ42R+fNeF/XOBWzEX/5YtRAbBkuk2kk5AyDlKz5589MELbN
         LPgz3FcmA8/gKoGTqsuGIYWCaJMwjSCcXQ8LoEdhBJeTaCZBaN6E16EZ4mmhzi6PzUAO
         0bH0t3DniF7gKMEZT8Un+17xJgb/3XYOU+o3HpkadS9u/QNd6zLvaiUwppiDyCh3iKm2
         5WVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773713128; x=1774317928; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qM8PvAQjaxTMcJaMWaL4GPi/Stw1aNsHY3fxQVFtBvE=;
        b=Jaf/7i6A4woP96PzeMnz+dwaCpSREdvPU7fIFv7Xs1A/+luFd6vbHeg9uXUt5h3298
         8voONoliKchubNnp6nBPDxwoOQk5Hgm42KmOYX6ndHVs2E78ysCtmBPnm9VAGfbYiozG
         NLYYUkspUIoReuRJASEJwGZCfcXxk3xDSqpSnXoxRWck9u5dMjmlK3k7DFmiS72a9jaZ
         xFkna4lMTeWOeu2AShluhp0HXYW/0msQfN+CWvQSPqZcZaUqcRXuF/SAWPzaxAHceWNO
         HUCurkWyT9M4DOW4W9XAGsho7qW4ZF5TLX6Xhxiz7wFVn5THDBHrPHXWlX0I4hjD46kc
         zEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773713128; x=1774317928;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qM8PvAQjaxTMcJaMWaL4GPi/Stw1aNsHY3fxQVFtBvE=;
        b=qrKe6CnlOo4bsnpDssLFy8Vm7LrZShuWo1osBuFVcmJJD2uYvbusctmrxggyTyBsy8
         G0Pky1j9vk8QyrAzzXPnCNbS1PaLd4xHFFuFXk5ll2nZun8Gw/+GVHnizpY7NihC2Oho
         n8MWiveBoBUK7FeD/m8RJeszYO4X+w/szEeuE3Xiify079p6nvkSS7OBi4jVKV9+NEPj
         FXv5Sb04HVFxQ0/mHYv+YhpyYeK45UrZitj7Xru+oo/LbqPzTARSo7P1/hwLGNK61WrE
         U5awD7S7PU+UYXUrAE6fIeD4TjXhB5Yvnx/MJxqivUGn7DEyUzI6m+/Zlo1+I5ZRETun
         vcbA==
X-Forwarded-Encrypted: i=1; AJvYcCWdT9+8EPfEQRFJ5uTMcZPPTn2gIy323zSeeoakurfjlyIfx168xyIpkmlZ0hqe42b29pjA4qX2P3ku9T6o0vwWBL5IhPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJIe3eSaK9X7yf6ObV/z2qDIqGdg5LNIBjfs1BVWJdL/Th/60L
	Rg2yGcs16//WpiC67g/QEjdTvJIHGR+LBqH74WwlWsvsbcCzdEpJDGAL0KNFFCX13O3Bm12pyN+
	Pd8mCj6om9pFFhLk6Nd4qlc8pBMC4Ic4=
X-Gm-Gg: ATEYQzyVaOuwDqdze7nGKa0rIAxhJJ5VoAZDK7rtKLOqBwvvDZFxqKMXnB4Pvc/KenJ
	cy8UyIr7/BUTwxBDCcWjIqy8OhUg5nnKiDlW4d4CSCNJ0OFBerH8G18OCeR5iRvIAksGSji30LY
	hV4WNibSO2EsRlBtiIV1fXC3J9rGwWLjgsm2H9EXqho2viJLD1OgbUJFyBRsOfRvEtBuJG9uPjY
	6ZDcKo/kK0bWhL3H8jGA1ho1at/kQ/ivTKDrA7hMrUDhQ2REo/hHY1RROOXSEASZ2a1ko12jr2B
	E1Bs3GGIN+/DM+c5PeqaF9wT14mgN9Ts87OOUbZWJ3zt4z7j9L0C6eXB3Rk=
X-Received: by 2002:a05:6000:4011:b0:43b:4720:1102 with SMTP id
 ffacd0b85a97d-43b472013fcmr6516708f8f.32.1773713127331; Mon, 16 Mar 2026
 19:05:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311-bpf-auditd-send-message-v1-0-10a62db5c92f@cloudflare.com>
 <20260311-bpf-auditd-send-message-v1-1-10a62db5c92f@cloudflare.com>
In-Reply-To: <20260311-bpf-auditd-send-message-v1-1-10a62db5c92f@cloudflare.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 17 Mar 2026 03:04:51 +0100
X-Gm-Features: AaiRm526aBgdvFmf4JzfVkPGCIcd_fq8FocVpkKM-YUNW1KDtzdIsycxc9Aw8gE
Message-ID: <CAP01T77mRSxLN_nZdgd-qv-u7i5SEiSU5azohVcc_NZdqHnqOw@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 1/4] audit: Implement bpf_audit_log_*() wrappers
To: Frederick Lawler <fred@cloudflare.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Eric Paris <eparis@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	audit@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Mar 2026 at 22:31, Frederick Lawler <fred@cloudflare.com> wrote:
>
> The primary use case is to provide LSM designers a direct API to report
> access allow/denies through the audit subsystem similar to how LSM's
> traditionally log their accesses.
>
> Left out from this API are functions that are potentially abuseable such as
> audit_log_format() where users may fill any field=value pair. Instead, the
> API mostly follows what is exposed through security/lsm_audit.c for
> consistency with user space audit expectations. Further calls to functions
> report once to avoid repeated-call abuse.
>
> Lastly, each audit record corresponds to the loaded BPF program's ID to
> track which program reported the log entry. This helps remove
> ambiguity in the event multiple programs are registered to the same
> security hook.
>
> Exposed functions:
>
>         bpf_audit_log_start()
>         bpf_audit_log_end()
>         bpf_audit_log_cause()
>         bpf_audit_log_cap()
>         bpf_audit_log_path()
>         bpf_audit_log_file()
>         bpf_audit_log_ioctl_op()
>         bpf_audit_log_dentry()
>         bpf_audit_log_inode()
>         bpf_audit_log_task()
>         bpf_audit_log_net_sock()
>         bpf_audit_log_net_sockaddr()
>
> Signed-off-by: Frederick Lawler <fred@cloudflare.com>
> ---
>  include/linux/lsm_audit.h   |   1 +
>  include/uapi/linux/audit.h  |   1 +
>  security/lsm_audit_kfuncs.c | 306 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 308 insertions(+)
>
> diff --git a/include/linux/lsm_audit.h b/include/linux/lsm_audit.h
> index 382c56a97bba1d0e5efe082553338229d541e267..859f51590de417ac246309eb75a760b8632224be 100644
> --- a/include/linux/lsm_audit.h
> +++ b/include/linux/lsm_audit.h
> @@ -78,6 +78,7 @@ struct common_audit_data {
>  #define LSM_AUDIT_DATA_NOTIFICATION 16
>  #define LSM_AUDIT_DATA_ANONINODE       17
>  #define LSM_AUDIT_DATA_NLMSGTYPE       18
> +#define LSM_AUDIT_DATA_CAUSE 19 /* unused */
>         union   {
>                 struct path path;
>                 struct dentry *dentry;
> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> index 14a1c1fe013acecb12ea6bf81690965421baa7ff..7a22e214fe3e421decfc4109d2e6a3cee996fe51 100644
> --- a/include/uapi/linux/audit.h
> +++ b/include/uapi/linux/audit.h
> @@ -150,6 +150,7 @@
>  #define AUDIT_LANDLOCK_DOMAIN  1424    /* Landlock domain status */
>  #define AUDIT_MAC_TASK_CONTEXTS        1425    /* Multiple LSM task contexts */
>  #define AUDIT_MAC_OBJ_CONTEXTS 1426    /* Multiple LSM objext contexts */
> +#define AUDIT_BPF_LSM_ACCESS           1427    /* LSM BPF MAC events */
>
>  #define AUDIT_FIRST_KERN_ANOM_MSG   1700
>  #define AUDIT_LAST_KERN_ANOM_MSG    1799
> diff --git a/security/lsm_audit_kfuncs.c b/security/lsm_audit_kfuncs.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..0d4fb20be34a61db29aa2c48d2aefc39131e73bf
> --- /dev/null
> +++ b/security/lsm_audit_kfuncs.c
> @@ -0,0 +1,306 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2026 Cloudflare */
> +
> +#include <linux/audit.h>
> +#include <linux/bpf_mem_alloc.h>
> +#include <linux/gfp_types.h>
> +#include <linux/in6.h>
> +#include <linux/lsm_audit.h>
> +#include <linux/socket.h>
> +#include <linux/types.h>
> +
> +struct bpf_audit_context {
> +       struct audit_buffer *ab;
> +       u64 log_once_mask;
> +};
> +
> +static struct bpf_mem_alloc bpf_audit_context_ma;

bpf_mem_alloc will be deprecated, please use kmalloc_nolock().

> +
> +static inline u64 log_once(struct bpf_audit_context *ac, u64 mask)
> +{
> +       u64 set = (ac->log_once_mask & mask);
> +
> +       ac->log_once_mask |= mask;
> +       return set;
> +}
> +
> + [...]
> +
> +__bpf_kfunc int
> +bpf_audit_log_net_sockaddr(struct bpf_audit_context *ac, int netif,
> +                          const struct sockaddr *saddr__nullable,
> +                          const struct sockaddr *daddr__nullable, int addrlen)
> +{
> +       struct lsm_network_audit net;
> +       struct common_audit_data ad;
> +
> +       net.netif = netif;
> +
> +       if (!saddr__nullable && !daddr__nullable)
> +               return -EINVAL;

Code look a lot cleaner if you just stashed these locally in a better
named variable.

> +
> +       if (saddr__nullable && daddr__nullable &&
> +           saddr__nullable->sa_family != daddr__nullable->sa_family)
> +               return -EINVAL;
> +
> [...]
> +
> +/* The following have a recursion opportunity if a LSM is attached to any of
> + * the following functions, and a bpf_audit_log_*() is called.
> + *  security_current_getlsmprop_subj,
> + *  security_lsmprop_to_secctx, or
> + *  security_release_secctx
> + */
> +BTF_ID_FLAGS(func, bpf_audit_log_cause, KF_DESTRUCTIVE);
> +BTF_ID_FLAGS(func, bpf_audit_log_cap, KF_DESTRUCTIVE);
> +BTF_ID_FLAGS(func, bpf_audit_log_path, KF_DESTRUCTIVE);
> +BTF_ID_FLAGS(func, bpf_audit_log_file, KF_DESTRUCTIVE);
> +BTF_ID_FLAGS(func, bpf_audit_log_ioctl_op, KF_DESTRUCTIVE);
> +BTF_ID_FLAGS(func, bpf_audit_log_dentry, KF_DESTRUCTIVE);
> +BTF_ID_FLAGS(func, bpf_audit_log_inode, KF_DESTRUCTIVE);
> +BTF_ID_FLAGS(func, bpf_audit_log_task, KF_DESTRUCTIVE);
> +BTF_ID_FLAGS(func, bpf_audit_log_net_sock, KF_DESTRUCTIVE);
> +BTF_ID_FLAGS(func, bpf_audit_log_net_sockaddr, KF_DESTRUCTIVE);
> +
> +BTF_KFUNCS_END(lsm_audit_set_ids)
> +
> +static int bpf_lsm_audit_kfuncs_filter(const struct bpf_prog *prog,
> +                                      u32 kfunc_id)
> +{
> +       if (!btf_id_set8_contains(&lsm_audit_set_ids, kfunc_id))
> +               return 0;
> +
> +       return prog->type != BPF_PROG_TYPE_LSM ? -EACCES : 0;
> +}
> +
> +static const struct btf_kfunc_id_set bpf_lsm_audit_set = {
> +       .owner = THIS_MODULE,
> +       .set = &lsm_audit_set_ids,
> +       .filter = bpf_lsm_audit_kfuncs_filter,
> +};
> +
> +static int lsm_audit_init_bpf(void)
> +{
> +       int ret;
> +
> +       ret = bpf_mem_alloc_init(&bpf_audit_context_ma,
> +                                sizeof(struct bpf_audit_context), false);

One you switch to kmalloc_nolock you can drop this too.

> +       return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM,
> +                                                &bpf_lsm_audit_set);
> +}
> +
> +late_initcall(lsm_audit_init_bpf)
>
> --
> 2.43.0
>
>
