Received: from mail-07.mail-europe.com (mail-07.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BF4326941
	for <linux-security-module@vger.kernel.org>; Thu, 18 Jun 2026 19:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781811249; cv=none; b=jWKvicqz9G/mCA60D50HNueNv+1IZcDyEGuYA0gDoGtVPmBiDobIQR6OWX+eyzbxpJPkho8Y3nJ0OoBmu8UBO+Zi//rFo3jHXPG8n9ZvVxiCgr9ymPhiArjfh3H+I2vROE+iZ3Ru6f0bgMRbtjWgmjdsVf1C4iUzWToqSFYpQ5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781811249; c=relaxed/simple;
	bh=zJpLfMJZdepvRseZ7w4ZXSq6kJ0W3aoRJz67L83CCrc=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=L5ph3qFpssl/e9qsTj+Vo23GxYLDyk6xFoDIMW58oASgsJyeXysFH2riHWFy8vSSRv4TCZH4BHBp1zXLsha3+izZzQpalqJyMmHYnd5vGwfNUn7lYz8h68gngfERUmorT72lhNjHNUA1ScTwecG2bPU3GFCAdaqVqLEbn1tF0dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=P5WXhk61; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="P5WXhk61"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1781811230; x=1782070430;
	bh=zJpLfMJZdepvRseZ7w4ZXSq6kJ0W3aoRJz67L83CCrc=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=P5WXhk61tEy2ymXVb5VpOrWrdVuSvPQKtBmjjaF2XUp2flYuWOHMz2/1iZmFhh5X6
	 b9CKSgfnQHMaaydyC7E8cR3A+kC6NS9pwRWScyo/ELKsRyUFZFtYBUy9zTRts9JVOL
	 AwDjFgnwTkuejHT/yIzDm8yfg/trEkchs/qWcH6rcJDuowVJ3WDfbgIopvibq6jloi
	 nc5nHTUFNyAZ27qWOfgNO751H+3d6VP4HyLjUv8GlEKliJHeMpjSeguyCM3ZEb2q+k
	 kGC08xG3hKp41o1+1jiQbjmMosHWduEFtFvgcLoYJdXvnErRtNSORCFzBxnwX6h989
	 jG9i+cO7PH/TA==
Date: Thu, 18 Jun 2026 19:33:41 +0000
To: Song Liu <song@kernel.org>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, Serge Hallyn <serge@hallyn.com>, linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 7/8] vfs: Replace security_sb_mount/security_move_mount with granular hooks
Message-ID: <20260618193336.214276-1-hexlabsecurity@proton.me>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: 4daec48a73870feca77879a104fb21824743f168
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Song,

> +=09err =3D security_mount_change_type(path, ms_flags);

This gates the propagation change on the mount(2) path. The same change on
the newer mount_setattr(2)/open_tree_attr(2) path is left open:
do_mount_setattr() -> mount_setattr_commit() calls change_mnt_propagation()
for the propagation and writes the MNT_NOEXEC/NOSUID/NODEV/READONLY flags -=
-
the same work do_change_type() and do_reconfigure_mnt() do, but with no
hook. security_sb_mount() never reached that path either, so the gap isn't
new. But once this series checks the mount(2) propagation and remount
paths, mount_setattr(2) is the one path left without a check.

It's reachable. A Landlock domain denies mount(2) for the confined task, so
mount(MS_PRIVATE) and a remount clearing noexec both return -EPERM -- but
mount_setattr(propagation=3DMS_PRIVATE) and
mount_setattr(attr_clr=3DMOUNT_ATTR_NOEXEC) succeed, and the task then runs=
 a
binary on a mount the policy marked noexec. A SELinux/AppArmor policy that
denies the mount has the same gap. With this series applied,
do_mount_setattr() still carries no security_ call, so the divergence
stands.

Adding the propagation hook and a reconfigure hook in
mount_setattr_commit() would cover mount_setattr too. Happy to send that as
a patch if you want it folded in.

Bryam

