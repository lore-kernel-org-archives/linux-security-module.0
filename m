Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A484EBAF7
	for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2026 11:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792410203; cv=none; b=lwNMPuOx+9BRL/Cwbq+6U2PUUK4PZ39Pq4pr5zLeCwqhSG28DMTxVw8URDrOzGkRmqJq/C1c5AeO1F+7Y57sZRK6ks7XfsF5e1aDRJi+PwY4I8cuvmq8eYCcZRA9OsaXYaL560DTL0WhcgnI5avG0W5V5xX5RVsk3zSEUpkNspI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792410203; c=relaxed/simple;
	bh=0h+fMlcy0nHUgqx0ZgNb3jSrGz0nmItuE/FyNlwIrZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZ0Ui6wH0vRWpvfqI1onVL1/RrYPB1U/rvrv5PbTnv1O2/JBPKE15ZgWPVyDZL1e4OET1ewsEgx3CfQEVxT4AUGZu2odExOj/aFJgB40WDZwDQBnzP/JSo+PF24oUXUQR+Y1S1TWzr+SYx2Y/rKwzs7oDOEeA+PLn4y8rS5lj1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oCnoYDeR; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oCnoYDeR"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a1cef0439aso21470235e9.0
        for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2026 04:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792410195; x=1793014995; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uPs8kNwzq2ixzAyx8BoNzSjliUbshG+1sbYaMKzI60Q=;
        b=oCnoYDeRKqohdjoF8yr1PWKPgjlJR2mynK3Kjw0YrYFdWEIOUbtfjYoSGPcg1BAe2H
         1DY4sGaClDUz5ITMycr6otyeVliHy73RZe1F2S0imQfR//X654PXu+KRRG+qJn+5Imqd
         AI33Mk3uXVl96Den2MWa9znDNxqIwXe+AS+Vy+TIJmqWia89kcDUkJ+2E7cAHexwmvfU
         dipwrGtY7YZIj2CluWUoxjLZlVxTJH2o++eXf28eNuPS7eV3ygGea33WzNOs2I2NTARY
         JPQiuAp0NTayS9tg69d+UFM9ZMAiJawDf3LxW0Jw0iS9e8G4fsWaO6r3/l/MWZdn3ryM
         Q4ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792410195; x=1793014995;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uPs8kNwzq2ixzAyx8BoNzSjliUbshG+1sbYaMKzI60Q=;
        b=0F2ddLbIK3QgdYBangPnC7Bnp6Z9zWxVuzhWvW82QLvaLIqD7Gbdqb98nLMPLjWujo
         2A8SY+uNonCt6jgey1/67B46yXgmq8jCbRII67z+UBUmjP+dwQdqfMBOLfu6l3vtLCQZ
         f4fj+R5LBJuiGMQb7xkNb1HfMHE0zAuprvkBtsEvKJukemD4rsV3ClCSsUSsXsaqyIxk
         OBrV7i7f0nqi9lAgGfEZwuYOvur9oPuJyHMOVvIOddisXb0yCdR9gKlWIFgH58WepPEc
         JoPa1/fY5rjocLBVPK1Rls/OtW7Rdnf5hAGJPa3kmn9LZeA21n8PHVbvHJEk+4SjEWo5
         3J+Q==
X-Forwarded-Encrypted: i=1; AKwUvBwmN4w4JMJ/NHlEb4w13xbK1cEL9qfRPJWEKaQ5UmBZuY/NWvdUGLeZHFAO2yDnvL1oRrzZqdm4xGd0hF/oj8Tnw7Ox/5Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYLOQ8zjkSGrBexYdeSrxDW0GXw6+bIRtb4Of8/oC0le6ufvJyBh
	a4XtHxK+6nK+LBEF7/vVQIgExRpTrhW0ZeFcMdgzEIy2SrJMpQ41t76L9+OQk5fYcA==
X-Gm-Gg: AYBFou1g5UVU2wPHM+tnXLDpEYk2fL9uCc9XMDr1MLbSc3rU3mgstiHbDB94QaxkmxU
	0+Wvsqknr2tqZ3XsnmZKFMSP7YWYV/y+bGSZz0thGSABkrw9+jA3AEgTa41MSBoE5Hp8ueFW2cx
	yxS+Cm1pzrKQ1KXZz2O1RaEwUWB/KaE+kT5PWCVIoSOsUlDW/Sx8Iqah4ToFW8J7oNL3vTZ+E9l
	r76DfRN3+dBuqok4SGDOeuJXrPO0yuxqTG4dvQDseLe9+EoLy6vdJQq0X5agaBQEbIQlOMOyayt
	ewpZsotu47DHr9VPshpRyjPCRwT1dPuQlsiV3gxZU7edatcYEksK/s2bdSqPkLRRW8LDzR7AlCP
	+eWPqP8RwLz03m6iy8jSwrm4UkaQvFruY5cShjGq0e4dHCTNY/jIdlJZmHVmCiKvQxaUUKk0lCl
	jslFgkQFSsJoIPccroSbi26bAMQaqm9WzVfym7yCsVOB8SxQpa/nT1t9DDdNCRNJEhGcUMfbhet
	YhGgtfkkOmq8U/z51BxW9rrYu9p/Ss=
X-Received: by 2002:a05:600c:3508:b0:49f:e772:6ddf with SMTP id 5b1f17b1804b1-4a1d762251bmr165269695e9.32.1792410194117;
        Mon, 19 Oct 2026 04:43:14 -0700 (PDT)
Received: from google.com ([2a00:79e0:288a:8:d186:2d44:63ff:537f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1e9423f20sm58112105e9.7.2026.10.19.04.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 04:43:13 -0700 (PDT)
Date: Mon, 19 Oct 2026 13:43:04 +0200
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: Justin Suess <utilityemal77@gmail.com>
Cc: Cai Xinchen <caixinchen1@huawei.com>, mic@digikod.net,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	corbet@lwn.net, skhan@linuxfoundation.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
	memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
	ihor.solodrai@linux.dev, rdunlap@infradead.org,
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
	johan@kernel.org, dlemoal@kernel.org, hch@lst.de, axboe@kernel.dk,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	dhowells@redhat.com, code@tyhicks.com, linkinjeon@kernel.org,
	sj1557.seo@samsung.com, yuezhang.mo@sony.com,
	hirofumi@mail.parknet.co.jp, cel@kernel.org, jlayton@kernel.org,
	neil@brown.name, okorniev@redhat.com, Dai.Ngo@oracle.com,
	tom@talpey.com, hyc.lee@gmail.com, miklos@szeredi.hu,
	amir73il@gmail.com, senozhatsky@chromium.org,
	chenxiaosong@chenxiaosong.com, kpsingh@kernel.org,
	matt@bobrowski.net, rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, john.johansen@canonical.com,
	georgia.garcia@canonical.com, zohar@linux.ibm.com,
	roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com, stephen.smalley.work@gmail.com,
	omosnacek@gmail.com, casey@schaufler-ca.com, takedakn@nttdata.co.jp,
	penguin-kernel@i-love.sakura.ne.jp, xiujianfeng@huawei.com,
	nanx95726@gmail.com, djwong@kernel.org, lujialin4@huawei.com,
	bpf@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	driver-core@lists.linux.dev, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev,
	ecryptfs@vger.kernel.org, exfat@lists.linux.dev,
	linux-nfs@vger.kernel.org, ntfs@lists.linux.dev,
	linux-unionfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, apparmor@lists.ubuntu.com,
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 -next 09/18] landlock: Add READ_METADATA and
 WRITE_METADATA access rights
Message-ID: <atYBVCIYE1zDb7do@google.com>
References: <20261015125425.3246251-1-caixinchen1@huawei.com>
 <20261015125425.3246251-10-caixinchen1@huawei.com>
 <atI20Vs7Du9-g1Hz@zenbox>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <atI20Vs7Du9-g1Hz@zenbox>

Hello!

On Fri, Oct 16, 2026 at 10:44:16AM -0400, Justin Suess wrote:
> On Thu, Oct 15, 2026 at 08:54:15PM +0800, Cai Xinchen wrote:
> > Add two new filesystem access rights to control file metadata access:
> > 
> > - LANDLOCK_ACCESS_FS_READ_METADATA: Read file or directory metadata
> >   (e.g. inode attributes, extended attributes and POSIX ACLs) through
> >   stat(2), fstat(2), lstat(2), newfstatat(2), getxattr(2) and
> >   friends, listxattr(2) and friends, and the POSIX ACL read
> >   operations.
> > - LANDLOCK_ACCESS_FS_WRITE_METADATA: Change file or directory
> >   metadata through chmod(2) and friends, chown(2) and friends,
> >   utimensat(2) and friends, setxattr(2) and friends, removexattr(2)
> >   and friends, and the POSIX ACL set and remove operations.
> > 
> > This follows the coarse-grained grouping approach discussed in the
> > mailing list [1], where file metadata operations are grouped by
> > security relevance rather than by individual syscall.
> > 
> > Implement the two rights by hooking the inode_getattr,
> > inode_file_getattr, inode_setattr, inode_file_setattr,
> > inode_setxattr, inode_getxattr, inode_listxattr, inode_removexattr,
> > inode_set_acl, inode_get_acl and inode_remove_acl LSM hooks, which
> > now receive a struct path thanks to the preceding VFS and LSM
> > refactoring.  The following system calls are now controlled:
> > 
> > - stat(2), fstat(2), lstat(2), newfstatat(2), getxattr(2) and
> >   friends, listxattr(2) and friends, POSIX ACL reads, and the
> >   chattr(1)/xfs_io style reads: ioctl(FS_IOC_GETFLAGS),
> >   ioctl(FS_IOC_FSGETXATTR) and file_getattr(2) via inode_getattr,
> >   inode_getxattr, inode_listxattr, inode_get_acl and
> >   inode_file_getattr (READ_METADATA)
> > - chmod(2), fchmod(2), fchmodat(2), fchmodat2(2), chown(2), fchown(2),
> >   lchown(2), fchownat(2), chgrp(2), utimensat(2), futimens(2),
> >   utime(2), setxattr(2) and friends, removexattr(2) and friends,
> >   POSIX ACL set and remove, and the chattr(1)/xfs_io style writes:
> >   ioctl(FS_IOC_SETFLAGS), ioctl(FS_IOC_FSSETXATTR) and
> >   file_setattr(2) via inode_setattr, inode_file_setattr,
> >   inode_setxattr, inode_removexattr, inode_set_acl and
> >   inode_remove_acl (WRITE_METADATA)
> > 
> > Both new rights are added to ACCESS_FILE as they apply to both files
> > and directories.
> > 
> > hook_inode_setattr only restricts explicit metadata changes, i.e. it
> > checks WRITE_METADATA only when the ia_valid mask contains
> > ATTR_MODE, ATTR_UID, ATTR_GID, ATTR_TIMES_SET or ATTR_TOUCH.
> > Metadata changes that the kernel performs implicitly, such as
> > timestamp updates on write(2) or size changes on truncate(2), are
> > therefore not restricted, and neither are chmod(2)/chown(2) calls
> > that do not change any attribute (e.g. chown(2) with -1/-1, which is
> > a no-op that never reaches the hook), matching the behavior of the
> > SELinux inode_setattr hook.
> > 
> > Stacking filesystems forward fileattr operations to underlying inodes
> > without calling the LSM hooks again (see the preceding patch), so a
> > fileattr operation on an overlayfs file is checked once on the
> > user-facing merged path and is not spuriously denied because of the
> > kernel-side creator credentials used for the forward.
> > 
> > Kernel-internal accesses performed with override_creds() (e.g.
> > overlayfs and cachefiles) are not affected because Landlock domains
> > are attached to credentials, and kernel threads without a Landlock
> > domain (e.g. nfsd and ksmbd) are not restricted either.
> > 
> > Remove stat(2), chmod(2), chown(2), setxattr(2) and utime(2) from the
> > list of file-related actions that cannot be restricted yet, and add
> > the names of the new rights to _LANDLOCK_ACCESS_FS_NAMES in
> > include/linux/landlock.h, which is shared by audit records and trace
> > events, so that denied accesses can be reported with a human-readable
> > name and the static assertion on fs_access_strings in
> > security/landlock/audit.c stays valid.
> > 
> > Increment the Landlock ABI version from 12 to 13, and update the ABI
> > version check in tools/testing/selftests/landlock/base_test.c
> > accordingly.
> >
> LANDLOCK_ACCESS_FS_*_METADATA should be checked at open time and follow
> the mechanic for the truncate right. Otherwise the access for already
> opened file descriptors would be changed. See hook_file_open in
> security/landlock/fs.c and this discussion here [1]
> 
> It should have clear documentation for this as well.
> 
> Justin
> [1] https://lore.kernel.org/all/20260929.Ahgoo4yeetai@digikod.net/


I agree with Justin here.

Apart from what I said in [1], Justin and Mickaël pointed out this
other aspect in which it is similar to *_TRUNCATE, in [2] and [3]:
System calls like fstat(2) operate on an already-opened file
descriptor, and the semantic that Landlock has so far been following
for these is that the effective access rights for that file descriptor
would be determined at the time of open(2) and stored in the opened
struct file, just as it has been done for the *_TRUNCATE and
*_IOCTL_DEV access rights in the hook_file_open() call which Justin
points to above.

That way, an already opened file acts as a handle for a "capability"
(in the more general sense of the word), and the things you can do
with that opened file don't change as the process enforces nested
Landlock domains.

Landlock's documentation describes this in
https://docs.kernel.org/userspace-api/landlock.html#rights-associated-with-file-descriptors

It feels that this would be in order for the *_METADATA rights as
well?  Does this seem reasonable to you?

(If you have arguments against that, I'm also more than happy to
discuss, but we should make a conscious decision. :-))

—Günther

[1] https://lore.kernel.org/all/arurOphe6QIx2Zr8@google.com/
[2] https://lore.kernel.org/all/arvjb0HJYh1KyEBB@suesslenovo/
[3] https://lore.kernel.org/all/20260929.Ahgoo4yeetai@digikod.net/

