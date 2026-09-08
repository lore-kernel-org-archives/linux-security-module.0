Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB8948F016
	for <linux-security-module@vger.kernel.org>; Tue,  8 Sep 2026 22:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788905151; cv=pass; b=qSuahBYJbBGjAP1uFXXs1nqXArRKq8ST7edPT1X0FBZaZ1b5HaGkZwIELWqWS1Ww3bgYNiFqdtLluNsuls6MxrMw3QoDFDGMIWYjetZbBpXQX8Maesord7q5fvPwPK78iu30rI7YufkHQCI3FNtZC7dF9jEPBqsPnZAH8WPIH3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788905151; c=relaxed/simple;
	bh=gWyldk0oc12yDTN1m54loFdW4UdsmUa/ZK1j4ZExUpk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EGnTNTm0aIiHV8e5e4nwzI/CHuX90+YOAshIZlQ3y2XnNFrpkZDs0P/HFK5ZUJuSF29XcAXKfAeAgovo95w8VgxK/MmI3ZVgh2EKvhIAH6Anah/pEKFkqbB4SP1C8fBjgc/coLwHuSj4WDD7dh6N/FMRreYcB9WReGuf+abgcL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZLRLTFZw; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZLRLTFZw"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2d6fe26ef1cso51852475ad.2
        for <linux-security-module@vger.kernel.org>; Tue, 08 Sep 2026 15:05:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788905148; cv=none;
        d=google.com; s=arc-20260327;
        b=AQ4LwzKT6cVSpS9BsCoK9BU2/ITpKTIpt+QgFMKCnm3Q2f6tUNwbB1Rb7JIfL13IoS
         HQEfLTJTwJZSVLZ3h1Cim2k9OWsRoYMzfWb8F82MKVGSqaW1nLSiJhLsHNx6uHcjLrdl
         a8XLoUMnFxpxEZSgj8eLtAWD7w7rzwYQPjTvHXXJsJXk3jS22Mm4/CUhxYEWXZjj+zKt
         NseiMd6DEXOLZm540Uzsxgt2no424/GV+ltAQjcYKb9V1UqxQvNl4WGaxCb/KkbvC+8s
         mvve1gJj7hmsnEeyd+LiMzsbvZHsqeppChFp5Nm3e9vTkM2Jg43qt+VvnzNa3pyCQKnA
         G3og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wViXqQw+49Q+sqlxh6pZf9kI4lGcySkRvR38g0HW4SQ=;
        fh=P32y61jgsfG4j8W9kmspPIkPUjwf0yacgswxv/nYgVI=;
        b=C4pQgaBca1Pc8QEEBPCy0+GAM3ke+TcJ95d9ZVFK03uHe0FLRDJ2/NIDCT7R1qqfHy
         XYUGX2pFHgkzj3NaSd6kooywqAqMX6DzFeUrWckqJ/JXjEyz27LlClPIlij3dVRh/+5b
         gXlXxnEXhKM9lYFBmohKPixCt7m17f4jweXOJbiX7R0fH+1qQLSc2ln0RO6aHvimB2ro
         rzO79cfs566iTjj/fzdlSa7wiCYuAwnCDaJWGE0uJj4kHQumr7MRG2YVodqQWJJ2GqQR
         VyyY4OZ6/1C9T0w69Gj4yMwpvjMRGknm7HcCZkElvprQDolmU9G/pp3AZ3GWX9Z2YKBO
         Vt5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1788905148; x=1789509948; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wViXqQw+49Q+sqlxh6pZf9kI4lGcySkRvR38g0HW4SQ=;
        b=ZLRLTFZwLnb/2GRIUNigIpydpUPDsmiveg10k8EXIkCTcHEUDSd+RkwAVSEpPLIGuH
         kIOqYVJmHZzAfexFzAlmVKCgoLzv2LjpeIQGs9ONCLNn0uA8rUrEoCHsbOdy9OpLX3qT
         8tpVgiri4S2nkwKCXj5DN2+GdfTWYec99FrEzKhnMpxfuKpZUu75y5Dw1Um7hSTQoSuC
         eaXZnaKLUVb/hJSZKbb2ZmhSDY//hKM/w7ZVt+RKv1JFZ5RJTY9aIDGnSaQD5V0gEjki
         U66rI1gkH9XZuCfrha+GExcm7CHZhtmGpG3etgue6tkV0j6GD1x1h+rIcsBnHYTGgbvF
         xlaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788905148; x=1789509948;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wViXqQw+49Q+sqlxh6pZf9kI4lGcySkRvR38g0HW4SQ=;
        b=CImUfuJpczMkc6pHsj/om2ICu5A+H3GXTQttVhyM4IEDH8Q2O0oei/q5bPohPDzY5K
         0pF9EZS+rGyqsi45Wdjf3a+giXKsMvdx0GOISPlipqyHh2E3EZm7METok/ebwz1yxwSJ
         l7N3wfPOHYErRuGkokiFTRCka70jjBXyMOyN5jMh9/pGSe1potc5ef9+qDp+w0lqCRYg
         StbFsYZF1UX4yMDbSfqxeVuxyBaTOjpm8+vVkQ+n4xlb08CweAU4ctMNTAu3q3EhL4f1
         LMomqXPYDvqHjuhiMBd16elhR/QenTzKPi/MJskQPZAbCmOw9DoNWPFdq7NGVAsO1ZXN
         8BGQ==
X-Forwarded-Encrypted: i=1; AKwUvBzR6u4ZLzfnzpx5AaE3VFXuW2wxDjEZ7KdD3P3IG+F7NmHGfSehX/HpE1pff39FVbWcVNh3+1ohmh6DGE0VvCslPWPKSbw=@vger.kernel.org
X-Gm-Message-State: AFuF++m6S+hlJXWm8UrN85sGnV4N70OIifUwUcSvI2Dh92zqN2RtWeqW
	2j/5MVzTaFQlWiNtnP+qAJa9ESczvXcKhHpw8Q7YU2jcTyPbdxNu0S2Hko121sXCEX8tT1nPOWD
	5g4q7PNPpl/z/CQAKzlQ0jAhQXr9XYfx97dx+0YKx
X-Gm-Gg: AYBFou2YlbqPrbIiKE+l7b1U1TFGsTR2rhl7HPKPEk7M3L9x3p9SEke9QxogZBP8ulQ
	kLfrlchBybuV+Hawmg9U41bcGuoJohvtUHl6ZYpmNh8LdV9K7o3KZl1juFqZDeAj537CKYD8bIM
	UHuaXtgWK5mIwjER1jf9JoE8rJb4Ba9ZXXurZsiEyMg/JpUr4L6LCcIvO145aRXgCUCzo4zdqgP
	lYe77zpOs6e1mriHJKrsrUe+TwNHanqnfmQ8jeGM3rCxBWVZQZlJR3PSgxMoDKxViWEcwobfKMU
	ysboj7WKNeWKccUolfRhxDOwNtRcscAL8E25IJGkNcVMS60lWNIuuFE45sYxP0xakCqPXWWpATA
	N
X-Received: by 2002:a17:90b:3ec5:b0:398:9c00:29ed with SMTP id
 98e67ed59e1d1-39b26277673mr45556792a91.21.1788905147387; Tue, 08 Sep 2026
 15:05:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904-lsm-mount-idmaps-v3-0-920a1963675d@amutable.com> <20260904-lsm-mount-idmaps-v3-1-920a1963675d@amutable.com>
In-Reply-To: <20260904-lsm-mount-idmaps-v3-1-920a1963675d@amutable.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 8 Sep 2026 18:05:34 -0400
X-Gm-Features: AcwNN1VBzLRcTymdA1zjcoOHYpTWayCftPPsC70quA8PGtg67RyLgDxcQLUcPf4
Message-ID: <CAHC9VhS5q2=6p2bi5c7CZ3mutji1xiKR2eFKgJ9C+XZsYgky2g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] lsm: expose mount idmaps to inode hooks
To: daan@amutable.com
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 10:48=E2=80=AFAM Daan De Meyer via B4 Relay
<devnull+daan.amutable.com@kernel.org> wrote:
>
> From: Daan De Meyer <daan@amutable.com>
>
> Pass the mount idmap through the create, link, symlink, mkdir, mknod,
> and permission hooks. Update the in-tree security implementations and
> non-VFS callers accordingly.
>
> Signed-off-by: Daan De Meyer <daan@amutable.com>
> ---
>  fs/cachefiles/security.c      |  4 +--
>  fs/namei.c                    | 18 +++++++-------
>  include/linux/lsm_hook_defs.h | 23 +++++++++--------
>  include/linux/security.h      | 58 +++++++++++++++++++++++++------------=
------
>  security/security.c           | 40 +++++++++++++++++------------
>  security/selinux/hooks.c      | 19 +++++++++-----
>  security/smack/smack_lsm.c    |  9 ++++---
>  7 files changed, 100 insertions(+), 71 deletions(-)

Casey, are you okay with the Smack changes (below)?

> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 8e88ac65fd7f..a45819d13c0d 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -1089,14 +1089,15 @@ static int smack_inode_init_security(struct inode=
 *inode, struct inode *dir,
>
>  /**
>   * smack_inode_link - Smack check on link
> + * @idmap: idmap of the mount
>   * @old_dentry: the existing object
>   * @dir: unused
>   * @new_dentry: the new object
>   *
>   * Returns 0 if access is permitted, an error code otherwise
>   */
> -static int smack_inode_link(struct dentry *old_dentry, struct inode *dir=
,
> -                           struct dentry *new_dentry)
> +static int smack_inode_link(struct mnt_idmap *idmap, struct dentry *old_=
dentry,
> +                           struct inode *dir, struct dentry *new_dentry)
>  {
>         struct smack_known *isp;
>         struct smk_audit_info ad;
> @@ -1226,6 +1227,7 @@ static int smack_inode_rename(struct inode *old_ino=
de,
>
>  /**
>   * smack_inode_permission - Smack version of permission()
> + * @idmap: idmap of the mount
>   * @inode: the inode in question
>   * @mask: the access requested
>   *
> @@ -1233,7 +1235,8 @@ static int smack_inode_rename(struct inode *old_ino=
de,
>   *
>   * Returns 0 if access is permitted, an error code otherwise
>   */
> -static int smack_inode_permission(struct inode *inode, int mask)
> +static int smack_inode_permission(struct mnt_idmap *idmap, struct inode =
*inode,
> +                                 int mask)
>  {
>         struct superblock_smack *sbsp =3D smack_superblock(inode->i_sb);
>         struct smk_audit_info ad;
>
> --
> 2.54.0

--=20
paul-moore.com
