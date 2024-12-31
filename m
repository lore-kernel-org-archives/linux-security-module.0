Received: from sonic315-26.consmr.mail.ne1.yahoo.com (sonic315-26.consmr.mail.ne1.yahoo.com [66.163.190.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B118C1AAE0D
	for <linux-security-module@vger.kernel.org>; Tue, 31 Dec 2024 17:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735665825; cv=none; b=b+8DTmn/8EiGPoBUT3M+RxmAguutL6xuDolaOpUuT8180BVPDnP39AvPQ/W6LBDhmIfS2ty612G/eNx7RZJ+9BheX5VZk8DcMcd9WsXv8QsY9Mm3E4xYMlVU+RRUZaZ46aLonePMf5T47u0TrxVmsGZQIJ9XwzZbMqKZn46QJcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735665825; c=relaxed/simple;
	bh=Pugcqp5K5OArUrlpoMeQcrZUwKSYDkMqRXJ10uUfwJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cROWuAkIEZSNRpft8a6RNE3YVNgI4ecnlfbnvZQzvRpd3oz0nQntkSdGP5t9soQgZI+repY3ablRamNscBF6OGX2YsLq+VNb4a1SsuZnkeQmE3Nb87u+bGSejI7Br1pX7rApxlsiIwP+9BlpfFtPRtmdZhooZzWyn4YHerF1CGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=ZMJSXUSU; arc=none smtp.client-ip=66.163.190.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ZMJSXUSU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1735665822; bh=TkpSdyKsGexIiV51RXZS9TY5keUBaNd0m9AcvfOr4wU=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=ZMJSXUSUnjjgjzU/AalwiBwpJLlJl9DxgqtsV6FPpD733C5/cZNJf9X3VaxfkSTfoy7IMnzGSDFjGup7HhFjn90n+1Aa1U1Fhorb8+TOikIwUzdG/IiPuyQYdNl7A5yoQquWi4XgCB9VNyJvSkfbHlqkIM7Qewq1WA++c1ZwQOxKn6/gdfVgMOYkyNPIGUU0l2356n87WdRqAzYge4/RFmGXIKncoU6L8CnZWK+DRUuj51GE3Afj2/h9LnXcDmKdgCrbOAHwJDFWG3FskViGpG6h5c25qVJxiVMOxL33TZRozgWxuqkNyE43F5UT+Xray+uqDvCQ/hzZwTbq8EPFYw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1735665822; bh=RMAJEvDgNWS7xZuj+AADAurInEBUGj/bzzDJIutJP9Z=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=LpJO2Oh85q4KyKBTGCgRJ/YlOn5zrALHMr/owLrzgXVRQfxCkpl7PjyJBaEXAm7jnkLkqsu2PrrE7rbm/WrjkI0e/ZWJaLKzv9tpG5GfSPSP512h0XJvhCGL/1+tBDFFq1hfPSENlLAVKNqdtAIue6n2csuZFjdcfWqPDUmY2o1TerszcApqfOX+E2+bRxXDBG7/1DuhZTnVRycA5gfWKHTC9eOS641ZWCm6CFAbcbJ8h8qYViJpH2TPtozOxNWU8Rb+VypOCYX8lDvm5WtpHylFd2kzDZq0XIxynZLZlIrv5h+MvPlgf84cYhCot/Gm2s6FoL6EVxNOIpmrKUz0xA==
X-YMail-OSG: z7d_ne4VM1lVfCMMSRdxNXzJG_o4dcVkBYWSG7ZzywNN8hWsoaR6sPOM2L1JHvK
 FJANTebigdAX1v5edK52MAzHSd1ugIlcxxDpYA_ZTjSbtabzI1aEOOALxSZSRISlAeA1D59NI9BD
 7QvPJAN4It1xZGdfGpydnaYIHzGlhKJl1ma7u0HMZFD0JWMZ3ear.bn5uz1s66_p3mFlCRB9SGAQ
 0M09IPhgsKUigcDgMp_fxc1d2c.FI72Gp0aTt8cc.k1IH3PMKNE3wc5IRpWLiEpjN1tFxuYmmRr4
 nZ97NCiaAgoAfQsLwGWyP7LuYWIZbsruuzxk4sfSbiaN7RrGagFVYXmwEerx.IbLZSshPglZR0QM
 oM78i9op9qMs_IioMZ22eCYZVGtG_62O..KQSAy1V.xEc0Ijgk0MxOO64R8MxM0cgap06LY7OEtr
 3fs8G71wA6lp4bWZBpqn2NnltYTzfCfr_YHjQDVyl7tGO5p4lKuSJZr8Pjy2KbeMZhBc1LigSM.B
 7gPd2_8u4yuhN7kl8m3vHvc6n5Q_fDn2LAwhVRJ7ueL83D7etSpR81Zhdumqkltav3PWvbD7t7S0
 aISGOF5UkR0Kth9vxQ9IqcqvzQVRDp7FIrnRKAmxGHKhp4W7YTfIDbVFxHl8mkOwCOAtyub.mLS9
 CTGuXIwnEnM4YOi77mFr8gIBcSrG9aUdcX0NSQDDyIs_T35j2DQPDnznxD16eIIOIVLHmtchTcxX
 YNMK_MYSKxwfzXp46kCY5etqDVqpKxXy4CDHeJ6pmBdPeWgguv4ULXx_95wljfx0Dwx7sDJ460ba
 gzwukj0vvarMvW9g.XKQ8MdWUoa_PxcHtJ15Yv3B5spRi1EferZxLfzgfAeFuR663K399O8Z1RUu
 e2t0nTE.Ea9.e_ISdvqq.Zqr09sgdcn20Nj8AFmZrypHevqt5A0VYnBlXWmFQ13gSqwBs9HWx.6z
 njLHc8J8iS7E15JAjfEBJX.0IXggCVhAvZJbcEBeK5q5kZitW9jPuY3TxuNJ4Kab_WYuJC.jskAV
 wWHLifxpmdF2OAw3uY9HeFJIxT3_izpul91ccI9CCzj_EXI_W.faP1dBlBwdTd0iDvov4QQv1qle
 6ZaN8VPNeOq2pnKN8kZH7Ea9hyvp0aSfgVTi4_eAFg13VHHqBN1q0mBjB7Uz1bQYBgMFmNpvScOL
 FryM.CqnMBnSykaz_YVXvEfy1TT4Y_e8nZO7MnH4kF6pcn7IangaHok2jPmwg5SXxd4z09LifgD7
 dA2GsbnQrey_7nhrW3dZqGQjrctIgKfxhqwQ_K66Y4qDYkA_SbP3MlYMoqOgMn4yUkDC1JMzvjRE
 g9_K5j3ElQyTqxN14H7QcKj4u9wmLMQWL.1fWjhGRDFac2lz9NRK.cprtrj6VXjFpl9gw0SIfxhs
 .V.GQLFwdOImJG2cJknYLFQi4AsEWeQRFej9oYty3LOCm91B7prb6J6NkOef42hQqw9UuFYeprol
 3pp.wb5jfcQ3MG7XelCh0XUlIjBem80n96.rgo24hyFE1369pmiDBGF5NNX3ZqKT6Z2RKJaKMBf4
 L14Y5EjRtYevutE.ZDbXX4fSAe6ELrhNKwwx2aX2Sfki.jXMYCtd_N6ucYo3HdhEuMiiRlShDCbH
 47qcyxu2uv2Ji0MMQ11Ay9YRI7dhvlHZtqYW7xLxaoATYmraBAr8ZJTNvA0t2nYnHoVn.sCfBS60
 9nW67p.Kq.hQiN5xPNFGzr3oMsUisByO0BCfkGQjndbMqno5Gx7rQXNQmmTXKsv.oV4SifxPFzKz
 jgpvgC4pyCTd6fEO6fxK5fegd4AxDaUNTQ16Mxg9P7Vkmc_D_aMWQdlglkuqoDAesh2vlnqAz6KT
 rUfpPr8LXMKiLlQ5OLkJyxpZdpp3NznOkS8erd48dSgI0jigLHZlxagVrPsLjrgEvGDHQXE3UFwK
 Nj1lZ0vp7RdJJ9Je4G4MaSqH7pgk_aJhrY5CgJpn3_X2VOX_u_xj_YnfhOmIH7kldhkNSXB_An_Y
 SPi7jUhMdgw9pSC1G2XV859iEq6Q5JTHF4iDX_87s_rf8WKS8ORzV41UbEjlkz.9bcYbAS7cDrkn
 4aM3oQ7swKEu7slvkb6nlhsyLil1jvYNMSnf9IRS6NSEUvCy5J.dvwCU6QwrBtL_7lu_Pa0btOcp
 9vPdPvjpmKjuGfyeHKb4lHnP9H7hI3rEf2HJukbLwRWsYD5jxDCkjTGVdUJNfbv72tXjra.kd4D4
 4rvVmoRpXO3IqTv51ArIzy3cLopOzwLC1Ugg07_oHpr2PnOFM.KLpA.SOGmqglUtHg7BjMA1QWeY
 PUqHQjyNsPute_RpaOVzufA--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 6bfc5ee9-478d-4524-8da5-a254e066c6d2
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Tue, 31 Dec 2024 17:23:42 +0000
Received: by hermes--production-gq1-5dd4b47f46-mb2l9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 20e8b2953a42cd7a3c2c540ac5b1a4f0;
          Tue, 31 Dec 2024 16:43:11 +0000 (UTC)
Message-ID: <5d7466ad-7790-4a08-86ba-82b0059562c1@schaufler-ca.com>
Date: Tue, 31 Dec 2024 08:43:09 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] fs: add loopback/bind mount specific security hook
To: Shervin Oloumi <enlightened@chromium.org>, mic@digikod.net,
 viro@zeniv.linux.org.uk
Cc: brauner@kernel.org, jack@suse.cz, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, gnoack@google.com, shuah@kernel.org,
 jorgelo@chromium.org, allenwebb@chromium.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20241231014632.589049-1-enlightened@chromium.org>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20241231014632.589049-1-enlightened@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.23040 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 12/30/2024 5:46 PM, Shervin Oloumi wrote:
> The main mount security hook (security_sb_mount) is called early in the
> process before the mount type is determined and the arguments are
> validated and converted to the appropriate format. Specifically, the
> source path is surfaced as a string, which is not appropriate for
> checking bind mount requests. For bind mounts the source should be
> validated and passed as a path struct (same as destination), after the
> mount type is determined. This allows the hook users to evaluate the
> mount attributes without the need to perform any validations or
> conversions out of band, which can introduce a TOCTOU race condition.
>
> The newly introduced hook is invoked only if the security_sb_mount hook
> passes, and only if the MS_BIND flag is detected. At this point the
> source of the mount has been successfully converted to a path struct
> using the kernel's kern_path API. This allows LSMs to target bind mount
> requests at the right stage, and evaluate the attributes in the right
> format, based on the type of mount.

I am not very happy about an LSM hook that is this specific.
Why restrict it to bind mounts? It seems that there might be other
valuable restrictions on mounts that are based on the path.

>
> This does not affect the functionality of the existing mount security
> hooks, including security_sb_mount. The new hook, can be utilized as a
> supplement to the main hook for further analyzing bind mount requests.
> This means that there is still the option of only using the main hook
> function, if all one wants to do is indiscriminately reject all bind
> mount requests, regardless of the source and destination arguments.
> However, if one needs to evaluate the source and destination of a bind
> mount request before making a decision, this hook function should be
> preferred. Of course, if a bind mount request does not make it past the
> security_sb_mount check, the bind mount hook function is never invoked.
>
> Signed-off-by: Shervin Oloumi <enlightened@chromium.org>
> ---
>  fs/namespace.c                |  4 ++++
>  include/linux/lsm_hook_defs.h |  1 +
>  include/linux/security.h      |  1 +
>  security/security.c           | 16 ++++++++++++++++
>  4 files changed, 22 insertions(+)
>
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 23e81c2a1e3f..c902608c9759 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2765,6 +2765,10 @@ static int do_loopback(struct path *path, const char *old_name,
>  	if (err)
>  		return err;
>  
> +	err = security_sb_bindmount(&old_path, path);

I can easily envision uses for this other than bind mounts.
Perhaps security_sb_mount_path()?

> +	if (err)
> +		goto out;
> +
>  	err = -EINVAL;
>  	if (mnt_ns_loop(old_path.dentry))
>  		goto out;
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index eb2937599cb0..3d1940239556 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -71,6 +71,7 @@ LSM_HOOK(int, 0, sb_show_options, struct seq_file *m, struct super_block *sb)
>  LSM_HOOK(int, 0, sb_statfs, struct dentry *dentry)
>  LSM_HOOK(int, 0, sb_mount, const char *dev_name, const struct path *path,
>  	 const char *type, unsigned long flags, void *data)
> +LSM_HOOK(int, 0, sb_bindmount, const struct path *old_path, const struct path *path)
>  LSM_HOOK(int, 0, sb_umount, struct vfsmount *mnt, int flags)
>  LSM_HOOK(int, 0, sb_pivotroot, const struct path *old_path,
>  	 const struct path *new_path)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index cbdba435b798..512ac656500e 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -365,6 +365,7 @@ int security_sb_show_options(struct seq_file *m, struct super_block *sb);
>  int security_sb_statfs(struct dentry *dentry);
>  int security_sb_mount(const char *dev_name, const struct path *path,
>  		      const char *type, unsigned long flags, void *data);
> +int security_sb_bindmount(const struct path *old_path, const struct path *path);
>  int security_sb_umount(struct vfsmount *mnt, int flags);
>  int security_sb_pivotroot(const struct path *old_path, const struct path *new_path);
>  int security_sb_set_mnt_opts(struct super_block *sb,
> diff --git a/security/security.c b/security/security.c
> index 09664e09fec9..bd7cb3df16f4 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1564,6 +1564,22 @@ int security_sb_mount(const char *dev_name, const struct path *path,
>  	return call_int_hook(sb_mount, dev_name, path, type, flags, data);
>  }
>  
> +/**
> + * security_sb_bindmount() - Loopback/bind mount specific permission check
> + * @old_path: source of loopback/bind mount
> + * @path: mount point
> + *
> + * This check is performed in addition to security_sb_mount and only if the
> + * mount type is determined to be loopback/bind mount (flags & MS_BIND).  It
> + * surfaces the mount source as a path struct.
> + *
> + * Return: Returns 0 if permission is granted.
> + */
> +int security_sb_bindmount(const struct path *old_path, const struct path *path)
> +{
> +	return call_int_hook(sb_bindmount, old_path, path);
> +}
> +
>  /**
>   * security_sb_umount() - Check permission for unmounting a filesystem
>   * @mnt: mounted filesystem
>
> base-commit: fc033cf25e612e840e545f8d5ad2edd6ba613ed5
