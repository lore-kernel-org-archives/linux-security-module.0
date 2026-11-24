Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795539221;
	b=wGcCBMqDa/9ZKeYSUXTa003u19QyuUtz2CPS8itMURYcYwDYHX18gxfjPEO4jmDNoLAo
	 t3sEoyYFJjvy26RE0y2JUz4gg+GE+BnG0NWABphRBtlDfKdoEVn1lPuLvRKkBvoRnhdqs
	 BXBoMfJK1VE4k73sAqrSyF3J1wEZkLd2rImg8Z+cw1MWu98PSt6KeNOtkAZK8HxCRm6qW
	 rC0cNAEWh2leTCuuF0Ns2hOZBVCYPKoyV4alrw0HFUBl/MtFa6RIBBt3w+vE6uzmXaeWb
	 VUJrvZ5/ome4EKDVy16keQmn4KdVlHEfe6IxwJamASlk0oYdVtNO848ro3v77jfJbAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795539221;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=hzW3l9V1ca76O/GAJMuhxZ7Oshk3Ho6LJEjIUjIXpy8=;
	b=qHLBOTUbw1oNR+SElFJPtMSRwcNENjG3CNFlu+d4gRTQbTHFo1aD50H+Lp1lTOXkivJB
	 G8KfUgE5rRfZFwt+ZDyxGS9wY9wjAKnFAv/UORTbBWpJEuz4wvQe5YurVBrM2j5BzPsRV
	 S3XJDjui9xEXcQ+pGchGUaBXVAf2wXb+Bj+6TKQYVjOFAWObZJc1XQw5afHFWYglJSD0Q
	 p9JTc62fO12ojXnW6+7i5H805gHkutA1+Eips7fNaGHtKi2ATTH654MZAGdW6vdxhI4VK
	 d/po/rQXG4mqQZkAIxfIGnaTg2yApnlg7d+B6VDlHWtfeoURDvn85sxumwJpQMV481g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sv7F+Pq3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0A9606A332;
	Tue, 24 Nov 2026 16:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sv7F+Pq3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3AFD1F000C0;
	Tue, 24 Nov 2026 16:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795539220;
	bh=hzW3l9V1ca76O/GAJMuhxZ7Oshk3Ho6LJEjIUjIXpy8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Sv7F+Pq3b4lQoY+bkvtMygoW5FQbi7b8AhW0Th/NMNexLFvNityGRvaCCnTm52wb6
	 Re02MmAzBNp//QtjQvNfz96lHB3XBn7TtltVWOYJKLm24GdI6fGKckf29okjLY4uWH
	 3MZ5Oqn+434nmFGtoM/vr+fY/OKoRiSE/wIHeNgjEPXyh9jKfbt8oWp1Z4EEwosvta
	 4p525n1UUfqKCr29KNcHKqVJsntOsdg/KKH6ovAGcUcmmhxCmPQJYinvDsFoDU9bir
	 e9YSpAwtYXU0L1EEYXgrPXDnsaK7c685tud2MNOMPgqxQrBj06C5mc/PsLJbRi61/n
	 lNYAQd36eTnnQ==
Date: Tue, 24 Nov 2026 17:53:35 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Jan Kara <jack@suse.cz>, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ima/evm: security.ima and security.evm get written to frozen
 filesystems
Message-ID: <20261124-eisstadion-burgen-kommt-c27ea3d3bf74@brauner>
References: <20261114-erstmal-vererben-leibhaftig-63db6f0c66ba@brauner>
 <7cbff903ec83459cb9779246feae1fb7f09f1ff9.camel@linux.ibm.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7cbff903ec83459cb9779246feae1fb7f09f1ff9.camel@linux.ibm.com>

On Mon, Nov 23, 2026 at 04:10:00PM -0500, Mimi Zohar wrote:
> The only option I came up with is to try sb_start_write_trylock() in
> ima_update_xattr(), after the hashing and just before the xattr write, and if it
> fails, defer only that write to a workqueue.

A workqueue doesn't work. It would cause spurious EBUSY and break uapi
guarantees. The worker has to pin the filesystem until after the thaw.

If it pins the mount then umount() after the last close() fails with
EBUSY until the worker has run. A simple

  fsfreeze -u /mnt
  umount /mnt

would do it.

If it pins the superblock instead then umount() succeeds but the device
stays busy and mkfs or mounting it again fails with EBUSY.

It's the same reason the final fput() is done from task_work and not
from a workqueue. Userspace expects devices and filesystem remounts to
work after umount() and last close().

> After thaw, an open could flush the
> pending update inline before verifying, so only the window during the freeze is
> affected.
>
> Options for that window:
>
>   1. Accept -EACCES for files closed during a freeze until thaw.

(1) is fine. And then we don't need the workqueue at all afaict.

close() uses sb_start_write_trylock() and if the filesystem is frozen it
leaves the update pending in the iint. The next open after the thaw
flushes it inline before verifying.

If the inode is evicted or the filesystem is unmounted before the next
open you are back at a stale hash.

>   2. Make the open wait for thaw. That changes behavior for read opens, and
>      the wait would have to happen before taking iint->mutex.

No, the read side never waits for a thaw. Even touch_atime() only uses a
trylock.

We could block in close() but only when an update may be needed. So that
could mean, takes sb_start_write() before iint->mutex if the file was
opened for writing and IMA_UPDATE_XATTR is set.

Iirc, close() already blocks on a frozen filesystem today. The last
close of an unlinked file on ext4 ends up in ext4_evict_inode() which
waits in sb_start_intwrite(). So it's not unheard of. Still disgusting
though.
