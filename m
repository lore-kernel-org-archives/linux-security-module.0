Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564161;
	b=M8Ko+z5oVJjr6VVgt9XP1DES3GEVzjYzgI2hqMRhwAOuIOL+OtP7X9JFdbGds3KkGWZH
	 5ILlVj0Fx4iiQo4QSgySeH5NDWwoTSCIMSSsrfq8VlAYfehOkBkWfK9xjOp/cu9hh55Yt
	 bLXWi9yKxqWw9FAygYwJokV+NrQWvqrEuAxnNVUHbbpiLKJDjS/f5jiH1kj8g47/bRdPi
	 OgtOrUxPbB+hVvjQtJZKZdiS7tQ1uJUIfnZG0L5JcX8TFQQubM/SqXSRqr2niPo8besuA
	 Q6OfYV2ldXSnAgnW7HslsujGjV1JU32mL+9rLjeWIOVD3+GlKr44k9xMwW59MzXlDdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564161;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=8oHy35ptJ0fLQb2YrI1vdssfNtJpVRQvJ6BVJKFTHRg=;
	b=Ggv5P58kdT6t/GR9wg5Co1GNb63Hmy4Vq+t+xw7+2DRjw2SwupmZBkCx3z+7T1aOakD6
	 wotp5oMXVw3Fm7MaOKXCxguJ5/Htv84sRfZwCBXDndZMTKfF8Yr8XzaiH+ueXY15cnsXP
	 boDzd5J6dueDjQ7MkMv5nqhILBNpZ54CwDPdWKyR3Wt0vFg0zUNeDs/g8oQ39Z34/E1IJ
	 xX3O4m1q0U14bI4ZlYSASmJ9EcJN9R/R3BEWXNpbbQ3TDh/th6gr7w1DCChy0dqGe55O4
	 +1e6woK14XC14OyuN+munSbeJnvarbe1D1mEXd1oDbpHwj96Ajpfe3sfkVxY5Z5+Oog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=EgTTjz5w;
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAC4606A889
	for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 10:02:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBAC4606A889
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=EgTTjz5w
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c5067a2411bso135633966b.2
        for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 02:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564159; x=1795168959; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8oHy35ptJ0fLQb2YrI1vdssfNtJpVRQvJ6BVJKFTHRg=;
        b=EgTTjz5wCJxsGLytKYZU81rQbAzYRel258q4rVhi5vK2xrQmQDal1yzp7Dtf678if6
         JjRQl+ZMXR5MwM/OWFtCjapsFpKPIJy4k0q9tv42ACCpenoDrYRhgwteGx9fsXnPo36A
         CmpJgecE0sejy6MR6tgTdtDQCHZyCNaM/wReBJem7BxQRTbXuUIxXx4ekm3/N1csmjzv
         gCoizy5cyPI1qWsTUdiFYdDS/1za3AmjDubKBZhhOvaszW7al+E0zABuX1J+7mV9GIsQ
         KNDYaQIAk2oxmRBvszTyhTc1FmwCZoCx7jL+YHG3X20//Nw1xxSADrBopi8MjhF9SAS0
         utQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564159; x=1795168959;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8oHy35ptJ0fLQb2YrI1vdssfNtJpVRQvJ6BVJKFTHRg=;
        b=tsS44yMP9/alvd3mUBkOK518PSNdDFV/rDy8ZkzgCq0pggFomAOmumhGIE1s+S3DGA
         GVSwyt5SkJhsVN23PctVh+Mvy5mHA9u2rY+mtKOt74l8uLZqij0ksnQbgzfSfEZ5a94t
         LOj5sVpUGkI6rsBCUj6TTBFqXborbAzTEjiHVHek0H7vobEJbCsJb+vwi9fJRew7mGit
         Rke6ysI5MEf+83MhSKOUibW9LamR22dGWhVeEndv+arGalFyJ47OC9P3Uxa0z79JnO3Y
         ngipdPQa158ikQRcYKiy/DGiWNzF1iVNLHkfTzkmhXaj0rqhCv55nE34YvzxOE4MtuKE
         Ljjw==
X-Forwarded-Encrypted: i=1; AL+hErFnV+mp4EkL001DXO+ZR+BxRM72edJsf9iOfhwr8IgUZnwMaGb4VsqeDpm6j5thNTNk8KRA1E1wIu6dHxotJMrhrZ33beo=@vger.kernel.org
X-Gm-Message-State: APuU4Z891tzbnuu7Oqu4WxP+Qo+7GS9QGjGVMyaxXfbWG20/oBjirynM
	phUJ/fiVNao8/vloYOxQozBK230iNWx/AmrSNuzi2b3CKTS1TcZfeCfKU7PROs2/t6AM
X-Gm-Gg: AYBFou1rrQ24qPwQdX2PKkgA/Q3NMG76H+46VCw7f9mTr/NB+tJ7dtv7+Sy0WZVg2qT
	0lMLsaDXpam72ZmGQRjqyni8bSjKDRImMhAs9i9UBxApeop4g6m7yN1DuWjfksfiXKuRUIz5oqV
	pbvsDCW/r9s/iSiM68s4pG79kMNjUAIofHfDjfvO9K5C3lsDov+mqI78BnYePK8v20F6J6OOLws
	PKgTau7XrLTgCy3Vn+5epDouMBFYyvM79WieQlQ4rkC+yFOW5kkHg9kVU9LO3FHO3hsn7DxCCsT
	95SxjeIWiJts5oCS0w1p598I2JiOYLAZI7Lwp9V9mmpyoAkH65wEQuEEyqlFgCjFUKWfIwDTUMF
	5iDJ2SOthurCWCzqyVLYiXVGNnA0d7Hxw8VN8Frg9tfJeSnUasJAGv4C6I6sUb5U90y329LrGA+
	XAbWBjwrU6Od3aZAGwJGwLfiXl4yWrCTfhOXHGjp8btYPgSNMv5RkhA2Vz2u58fnkT2dG66ozZp
	S5Kar+MnTs3xOboa6nRIjedBttm35i33Kg/akq0djLHL24ZmZtLs1GVjM2QR8unvb1uD4kcaLDD
	vRT3b6HkuBaGyzGkSgPHxzKu9ioDjOLnXuriAsc82CWef24pAShbEXu0VwlaU5s=
X-Received: by 2002:a17:907:7b93:b0:c29:f5d5:5a9c with SMTP id a640c23a62f3a-c509654de57mr163595166b.38.1794564159104;
        Fri, 13 Nov 2026 02:02:39 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b23afdsm74417566b.13.2026.11.13.02.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:02:38 -0800 (PST)
Message-ID: <8c51aa1ad231dea30af06ecf761a971f5958d063.camel@amutable.com>
Subject: Re: [PATCH RFC 05/41] kernfs: use fc_init_pseudo()
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>, Josef
 Bacik	 <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, 	driver-core@lists.linux.dev,
 linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, 	fuse-devel@lists.linux.dev,
 linux-efi@vger.kernel.org, 	xen-devel@lists.xenproject.org,
 ocfs2-devel@lists.linux.dev, 	linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, 	linux-usb@vger.kernel.org, Amir Goldstein
 <amir73il@gmail.com>, 	linux-erofs@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org
Date: Fri, 13 Nov 2026 11:02:36 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-5-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-5-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, 2026-11-10 at 10:14 +0100, Christian Brauner wrote:
> Initialize all kernfs based filesystems as pseudo filesystems in
> kernfs_get_tree() instead of raising SB_I_NOEXEC and SB_I_NODEV by
> hand
> in kernfs_fill_super(). This adds SB_I_PSEUDO for sysfs, cgroupfs and
> resctrl.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/kernfs/mount.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
> index a0be784bfb06..6b60d212b003 100644
> --- a/fs/kernfs/mount.c
> +++ b/fs/kernfs/mount.c
> @@ -8,6 +8,7 @@
> =C2=A0 */
> =C2=A0
> =C2=A0#include <linux/fs.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/mount.h>
> =C2=A0#include <linux/init.h>
> =C2=A0#include <linux/magic.h>
> @@ -298,8 +299,6 @@ static int kernfs_fill_super(struct super_block
> *sb, struct kernfs_fs_context *k
> =C2=A0	struct dentry *root;
> =C2=A0
> =C2=A0	info->sb =3D sb;
> -	/* Userspace would break if executables or devices appear on
> sysfs */
> -	sb->s_iflags |=3D SB_I_NOEXEC | SB_I_NODEV;
> =C2=A0	sb->s_blocksize =3D PAGE_SIZE;
> =C2=A0	sb->s_blocksize_bits =3D PAGE_SHIFT;
> =C2=A0	sb->s_magic =3D kfc->magic;
> @@ -388,6 +387,7 @@ int kernfs_get_tree(struct fs_context *fc)
> =C2=A0	info->ns =3D kfc->ns_tag;
> =C2=A0	INIT_LIST_HEAD(&info->node);
> =C2=A0
> +	fc_init_pseudo(fc);
> =C2=A0	fc->s_fs_info =3D info;
> =C2=A0	sb =3D sget_fc(fc, kernfs_test_super, kernfs_set_super);
> =C2=A0	if (IS_ERR(sb))
