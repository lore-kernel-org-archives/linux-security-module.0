Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167C5526A8C
	for <linux-security-module@vger.kernel.org>; Wed,  9 Sep 2026 11:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953517; cv=pass; b=ZM9CoqxJW8dk9jP1HPxnMl8GHjFH+aczFkwxRJnR7pR57HEZ3FirbDdt4y6Ah3HKTd6/Ub3kttwH/7EaiWd7IB7q+coB3CYEHugCmmBkQDTFLgaeKWM+8m0PoGrCQjrdCk29GjOx2ONzljZH02y4rFTnT96YJpevlfX1hOEPq0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953517; c=relaxed/simple;
	bh=5dfVrJoxl/aakjjCR9muNwRvZcP5yB39nnIlMDaXRj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jhW2rtBEH9bgvGeGF0uUsYcWdX7oIV9bFwJ7J7gUZUko6idxfE7reT2+PyMyeaVF9VlDqWNdGyXaigZKn3gcXz8h/cDuul6W4Iye3j8vmC7MketFut0c4FI2gPJyhJQmrsheIRyKXSYs5ZSva8IDtzjxQgiiJg8vdb61H2BX9e4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com; spf=pass smtp.mailfrom=amutable.com; dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b=fiPhn8SI; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b="fiPhn8SI"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-66de7e0bc85so4818706d50.2
        for <linux-security-module@vger.kernel.org>; Wed, 09 Sep 2026 04:31:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788953515; cv=none;
        d=google.com; s=arc-20260327;
        b=D2QK6aQtidbdkjD3aJGkdsqE8me2mq/qN2bwCxQ5CJtqg05sesywiNKSS5v7oZ7VaD
         TKyI96hS15mR3CWbzUe2XHGtZN41/2MVZXq02r8ZTMt58NdqIOYd9tu+PiA2Skst4DXs
         EaI8DCH8uYhC4c/5WBzwhkYXdWr0ZJZQqqPYnbc/75CAzldCz3l53CzMIfLJKBp9N87N
         gvO3/lDJKYJfw/+FZc/1i8WsudTxdWhFBIucUwbj9UWW0yJaOTTNmtSX6TfWzH9emm6G
         BGl8sxbGpvBSB7ybpkerTXT6yEHyVH0dLhf2BKnwUA6yWT/czV9OzSRrdYYE26pP7nkC
         C6Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PNU9Cs2GO/4YNQLjDLGYHiHc9eZguxtceoLERV9Q/wI=;
        fh=WP9n1UjKTryoU+wlWr8GK+N4iRQhHQujmTTEVjl1YyI=;
        b=iIHbU0YSfyarJb1Tef5kyYonC6fx2LP2B+zwxCgM/hU39mDiWQmgZiTC5ehb0L4ekq
         YeXmG1gNn/YIW/hJB6vCR1fSszfw6Bk35egCCjEX6nPVWxNT/JB24lh1ck077wVIm+RC
         545niQRwhkNkxK38NkWD8qpFDJ3CWdaTNOFF2IfoqKC7BXt2BUxHaf0nT/nx1M429Qps
         owHGOVWKomB5J5WWqh0k7jeB2p4fpVrdxo9M6bBgW1fu64PB0WOjq95pK2J1MHthkXm4
         ZHqoEkg9CkD8PiR5almjk5d01gPnO8vR1sXX6cuNt+Cb4Dcfn/KcTaVq56z/W8MuAvYE
         4LVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20251104.gappssmtp.com; s=20251104; t=1788953515; x=1789558315; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PNU9Cs2GO/4YNQLjDLGYHiHc9eZguxtceoLERV9Q/wI=;
        b=fiPhn8SIEYYssES90by9unrp/Ce7chBmnNyLNvlr/a7asm3iIJOzdYarZuKcoFtbEI
         lC9AA1FJ3JUIKRw5+LfWV89CXEcpirli76TmMDluvacxv1b2xXRhxm+KV6Bf2dT5ft5G
         9UJmQeTNyoB4r/rJKfKY4S8l45nWwCS05g86kD65L3JpC/JEbEBulVkOYIK0+jH9DBay
         XrC1X2sLEmORiwwM5Apk4sgIm/LqKkj+JCANIak9OBozFHBprfiQiRg6FpC5sEkgqUuX
         nZ1ZqlIiWrsG6DroC/sCu+YKUqqn933ETmf1lN7rei+pWl2wBqUPbIy7MvAYpJL/HRuR
         dnCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788953515; x=1789558315;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PNU9Cs2GO/4YNQLjDLGYHiHc9eZguxtceoLERV9Q/wI=;
        b=qgjt1fDzSQJsY6y5X7weIpgOvf3GYWfq/TpqDkM1T49x3jy6DqITRo8cpKvke1UBcx
         d4yjDDatWXZqwB5T7tXXXhsSAt5qAc4j84jKzwEz1WW5xkVI94LV78iezHh4C0c+KBe+
         4mEgv5o6DfJxjigTjX01P2zwommVjmMifk2WQNPy50/qt8TtGvncBTnqhVLq01FdRP0i
         2cHhiODueb8oHPZM3bmUpxlo0p/hBqQ59TJpJtTloIIVfXvl6PVNWZOMioNyxKGM4Wmk
         UAQRlXIdEeJNxRnpMQtNTIKeejSFxK2SY9EPPexneqQ8x9Mp68lqjzLlPYLCxwrCJfzn
         eAQA==
X-Forwarded-Encrypted: i=1; AKwUvBxgOO0RI5FL31ZG4S+3jSczHqOzUP5UBlmtThm/3p3A/eWN221uWC59KNqq506Y4s7xR96avs8v2bO/WoPnb8uggl4S31o=@vger.kernel.org
X-Gm-Message-State: AFuF++kVvVi9RhPPAGGRNxc2rIhugWiQjFLUA1O5E54crx9nQTX5L8bB
	TNbC7Cc7wYoENFKKhFf1bHZKu/IbN+6FFpsyZUyR9O+U1XOel+mB2yrslTsj/tGjLqJtHg3kfZB
	JlDSNMEPT/vlemRaZW9iwWh6Fk9Dd4pZmOCw2+YKvJaA=
X-Gm-Gg: AYBFou3SXZ2xONno/R1V/1e5NVVcDGL5/2bYWjQE/8GFG7J1Ytlrtqjx1P1/M/Yjj5N
	qCd/VqivJhOYBgUfkFYl9iJkDmfJibkOUhe/SeB8sc/zIJC2b4CdKx76zsCI5kQm2/brt9gCmqV
	0G0/oWX8N0+PSO7HpFmQO4D8/qnLDEmvmapATmKQXMAeQHsiakRIVfpz+/vAvU6l0UA+nabPzz9
	YyWS4tUeVQt/0awyVzN3uCkjg61S6Tv3+pCtZrrbeu1YQId2m2nME7LL5R8bfBBgH0sx1mdLsMF
	4dwkwVgKwYrm69Ze4RXqdl1H2gGSF/RaDTsRATisCHbTHwce2yzEu6u7DRpsSQMvBmU+spAdOya
	b+avd4YIbdWcN+oiDRJu96IMh
X-Received: by 2002:a05:690e:4888:20b0:66f:beb9:b1b4 with SMTP id
 956f58d0204a3-66fbeb9b4admr1905952d50.35.1788953514392; Wed, 09 Sep 2026
 04:31:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904-lsm-mount-idmaps-v3-0-920a1963675d@amutable.com>
 <20260904-lsm-mount-idmaps-v3-1-920a1963675d@amutable.com> <CAHC9VhS5q2=6p2bi5c7CZ3mutji1xiKR2eFKgJ9C+XZsYgky2g@mail.gmail.com>
In-Reply-To: <CAHC9VhS5q2=6p2bi5c7CZ3mutji1xiKR2eFKgJ9C+XZsYgky2g@mail.gmail.com>
From: Daan De Meyer <daan@amutable.com>
Date: Wed, 9 Sep 2026 13:31:42 +0200
X-Gm-Features: AcwNN1WF5wnirz-p9XhAjdbRh2yyDynGRgpa6C1inpir3KV7AQr5BoXmZV6UDsI
Message-ID: <CAPa8sAgVFXz4ZX-OR3YoRM3cOSqL613NnpWfgsbKiPjViOziBQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] lsm: expose mount idmaps to inode hooks
To: Paul Moore <paul@paul-moore.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> As long as you are okay with me updating the patch with the change
> above (and explicit on-list email would be good), I can swap in the
> paragraphs when I merge the patch so you don't need to do another
> respin.  However, if you would prefer to do a respin, that's fine too.

I'd be grateful if you could swap in the paragraphs, thank you!

Cheers,

Daan

On Wed, Sep 9, 2026 at 12:05=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Fri, Sep 4, 2026 at 10:48=E2=80=AFAM Daan De Meyer via B4 Relay
> <devnull+daan.amutable.com@kernel.org> wrote:
> >
> > From: Daan De Meyer <daan@amutable.com>
> >
> > Pass the mount idmap through the create, link, symlink, mkdir, mknod,
> > and permission hooks. Update the in-tree security implementations and
> > non-VFS callers accordingly.
> >
> > Signed-off-by: Daan De Meyer <daan@amutable.com>
> > ---
> >  fs/cachefiles/security.c      |  4 +--
> >  fs/namei.c                    | 18 +++++++-------
> >  include/linux/lsm_hook_defs.h | 23 +++++++++--------
> >  include/linux/security.h      | 58 +++++++++++++++++++++++++----------=
--------
> >  security/security.c           | 40 +++++++++++++++++------------
> >  security/selinux/hooks.c      | 19 +++++++++-----
> >  security/smack/smack_lsm.c    |  9 ++++---
> >  7 files changed, 100 insertions(+), 71 deletions(-)
>
> Casey, are you okay with the Smack changes (below)?
>
> > diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> > index 8e88ac65fd7f..a45819d13c0d 100644
> > --- a/security/smack/smack_lsm.c
> > +++ b/security/smack/smack_lsm.c
> > @@ -1089,14 +1089,15 @@ static int smack_inode_init_security(struct ino=
de *inode, struct inode *dir,
> >
> >  /**
> >   * smack_inode_link - Smack check on link
> > + * @idmap: idmap of the mount
> >   * @old_dentry: the existing object
> >   * @dir: unused
> >   * @new_dentry: the new object
> >   *
> >   * Returns 0 if access is permitted, an error code otherwise
> >   */
> > -static int smack_inode_link(struct dentry *old_dentry, struct inode *d=
ir,
> > -                           struct dentry *new_dentry)
> > +static int smack_inode_link(struct mnt_idmap *idmap, struct dentry *ol=
d_dentry,
> > +                           struct inode *dir, struct dentry *new_dentr=
y)
> >  {
> >         struct smack_known *isp;
> >         struct smk_audit_info ad;
> > @@ -1226,6 +1227,7 @@ static int smack_inode_rename(struct inode *old_i=
node,
> >
> >  /**
> >   * smack_inode_permission - Smack version of permission()
> > + * @idmap: idmap of the mount
> >   * @inode: the inode in question
> >   * @mask: the access requested
> >   *
> > @@ -1233,7 +1235,8 @@ static int smack_inode_rename(struct inode *old_i=
node,
> >   *
> >   * Returns 0 if access is permitted, an error code otherwise
> >   */
> > -static int smack_inode_permission(struct inode *inode, int mask)
> > +static int smack_inode_permission(struct mnt_idmap *idmap, struct inod=
e *inode,
> > +                                 int mask)
> >  {
> >         struct superblock_smack *sbsp =3D smack_superblock(inode->i_sb)=
;
> >         struct smk_audit_info ad;
> >
> > --
> > 2.54.0
>
> --
> paul-moore.com
