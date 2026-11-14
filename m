Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794698411;
	b=By+i53+PazCmrh/uyCw1ohwbv4wwh479ifztdkWmhreFfCTJsmoijOnrv4qogexpdPpl
	 2doUSYF6N+xXadVZ9f8dOBz3h5b7KowNmRjFhHwDF0oa/qasqbL4odIGjZjFas6WwOeQV
	 nwkVBygB+TNk5mi/6y8RQ0kDqJQ9XNZyF2DFC5K2mEg97i9roWjQ/Lsfp/dORxEvwnXN9
	 gyrgY1B9nPKTT8ntBdhcDR7ukOX8cdY9FLdsNOPlYgfiqzQbJitn62rSHoy/YK7rw3oiQ
	 0QSc6I3lfSxc18iswrHlysgQ/aQd6htH90DAQsxH2aSHFpb8QXb2TlvRHXjgXsXDHTg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794698411;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=98mXXJR5XCg4Z4S2yqrizowpYg4fQiN0pgPOU/BiUFY=;
	b=OdOLe7kS4xs670vt0Pgl2NhtOgIHnbgPgnt7ciJ/yAA1bowU3DiSqHqL1JHh9++divqB
	 tpxBCjZhOWQJK0yG+frmjcN0iYFv/789R5DI8v7BbES1bIHql+I/YEvq1yJB7PsXpSeW0
	 MY7UkpggJRhbZLbztgvrJqepV0FwR+d8PWsmcAaNMrUQpWEQEtkl0W1ZKTracy1j8QdbF
	 55HxVPq+jkwkjTsjqNFueAZUUjzy8Tz9OW+WXRgkdPBiGMoD9R+ZTwK+A+mdK0OYZzDDg
	 XLTd2VlkbErlCTm4IE8dkRyqiCY2dhI9KcYCd+jtdW6sZWVQ0eY9jzKhw+k1UDCDQHw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bZ4A5V+6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F358A606A329
	for <linux-security-module@vger.kernel.org>; Sat, 14 Nov 2026 23:20:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F358A606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bZ4A5V+6
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b70192ebceso4502086a12.0
        for <linux-security-module@vger.kernel.org>; Sat, 14 Nov 2026 15:20:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794698409; cv=none;
        d=google.com; s=arc-20260327;
        b=On0rRXXXdEOJ1KgRJxhiY1QVSnK7DJFMH5xybacamg2FoOvCbKY71OyiAzJ0M5gTYa
         nXDOCfBkQ6oGvG3gY5bHucXdw/DpelcnpAAt0zuvLmS+wR1++1fGu5YQo+0YvpC3/eaA
         kWBhxwNTcCD40h1caI+61CYrFR+Lt+zNBdVTI0Z7MupTV3eKXZRug6LhZzPmq7INuIYW
         Z5kiKLQTmftvsaaBV7K/oJJmQQym2S4jEFVvzX/KRZaK4IgEaYo/dcx0cdQCiNTULYfr
         zDzL5QXhj6IE/H+tm309WHUI+T0WuMT4UKfMLrHwBemKCLpnycB6I9xvuXjJQ1kNIxHW
         2L2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=98mXXJR5XCg4Z4S2yqrizowpYg4fQiN0pgPOU/BiUFY=;
        fh=rT5zqp6Gdjlg+imCAdQwMj4zJh/5mDtn8mJYWQESexY=;
        b=Zn7cyOoyI4IxajOUGBv7TsWqFrgXLzMCudGICCerXeD2fdsyCLgTfAWrLuGcyK0MQ4
         u9jbEzYATSnnaTGefLvxFqqG8PPrLCN6rquSIt7/M/7i5VbB0Phxt3VUikjSxS9GNS54
         o/AhPonHzciCNS89mV6xHaIBD6el6Mv1svy6Lnspv2K37IX5ZylIjsrJaKYlwoM8ZV87
         ffA/qDHK+Peat1p58+tbjrubHhRaZQePeIwnUApH3agKgJ9SR/ewyOUQO1V3egS60YWI
         hQ5/4o84Dg9JVvzJtnIIIGzVO2M+HrhLP+SLE1s6ASh/R129OdqwLJNjFUIpkXfx3IW5
         v9Ug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794698409; x=1795303209; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=98mXXJR5XCg4Z4S2yqrizowpYg4fQiN0pgPOU/BiUFY=;
        b=bZ4A5V+6Vs4HKIPLNbCXlaoHg6GUiZAgPE1CoHup/u8F9XnmCFMSb6naMqQFAl++mw
         +LZR0jt78s/FhrwMU+95xN0Ho10rZ/g9p6M/dfGpr9SfvlaOXM2WfiTCtO0CejnyefhK
         5gg17lDjyCI6S+pTTK/DIWzHtcTY1JHkLI4t/I/Teu6/Lgz9A0oKfkx231Ay53Fdu4Kp
         zCo0ecwmPzO3ZOIddRCFMjOjLH94BU3oXsC8cOhJgJSeLFwZkZlFyxo1cq6JVw7hHb6A
         21NW8PziNlBat7d4DfM9UgO0YIScpglsDnmQoGQNIOQhlOx3hw76q6t8+8jTPfBn24eS
         FVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794698409; x=1795303209;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=98mXXJR5XCg4Z4S2yqrizowpYg4fQiN0pgPOU/BiUFY=;
        b=rcx7pbBQkKJiH7STIq9vNmOh9UhowJBMdZXqVOqIkXXvMC65iAFusiFUEjAfmYSXtL
         9NYob3n6p4ANxzYHSeh3jjq9ViqqZv3W5GT2LvmkQzk1UyDqWcSIPp+38yi727oF75y4
         xVghlbyzTf+c5j+9nwtj3nAd9CILFYxXYIV6Zzbi6qIm7CSwF4SEwGaR+O8CNcvvHlnv
         T5Aac1pLd+ZPW62rQbk5HUm9KGfc7540C0FjSBweZCCA5wDRff9iFv5ZDH80Gh2oU7ym
         9RVIsMMWwZuKnZKsJ0aSRLCQL0bUjWXaJdX+iPNaWYGZ3fPqXNeWSgT6X3t8NVDhMGlj
         bGmA==
X-Forwarded-Encrypted: i=1; AL+hErFvKOxuFG6UpOdKpWT4TCNwCVeSe2GgbFxNxlo3NIxhC/VUsE0dkz7ToM51L4aGcFdHrU04pr87K+ii82KKvHPDVJg/f0Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Ikf2csZmhMirJMci6S3jlQn+h5CkdLOV+syKobF+XnCoq9Rh8
	ITTxM9GbqpXeZvt16OrPLQqgqbvajKJhkiX04hRkKPW/UNbnQEIAaRbbUa8oJCeg65BCo1aUF4c
	lUzbakl8GAlwrTtUH9S7sbyUbK+xEvao=
X-Gm-Gg: AYBFou0lFefphbg2KgK1V+cTM5yu1BXuOe7l3CY13Rk83P3ewAW7DMeBPZ3u27n+i40
	RWP7wWdN6bv+BdKtL4lJMlegsuqNmRKUHFNbidX7ZgVKtD59fLQrbjTg+oGcjt1oLJcLl1rJpq9
	WmZEYhcfsHyYgSe2RK+UgPssfY8eTrx6U9UUrJnw2tUBA0NcNeewA1aCV+8KGVXMzhkNS7qGKUA
	RSccpOaj222mYXPmfqvydNipFVl2PENn5aMDVBUhOFdknH2xsTZ3k9HwhrIAWnXZiNZqQQczo5K
	/NC28PLo0K3O52tBDeZa7G5dReGYQ7E9meZo7bKvFv1VhyFaifvqOaC3wohyKj5W8YmQewZDHvQ
	NAFL2m14ihA13J7t8gVQAlE48xsmG/qlEZC72esgElC36xm/6BN2GBNgwATdGeaMke32Icw==
X-Received: by 2002:a05:6402:e10:b0:6b7:f00e:5e56 with SMTP id
 4fb4d7f45d1cf-6b7f00e5f37mr1542816a12.1.1794698409123; Sat, 14 Nov 2026
 15:20:09 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
 <20261114-work-loop-pseudo-v2-33-98639a2286fb@kernel.org> <20261114120557.4bc1eb6e57218cdc@chrisdown.name>
In-Reply-To: <20261114120557.4bc1eb6e57218cdc@chrisdown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 15 Nov 2026 00:19:57 +0100
X-Gm-Features: AclHuK_YVxhIpv6JLzeNAX5mX5IHGfu05WS6uQ-TCKewxE3JKeci2PyA-UDMCbo
Message-ID: <CAOQ4uxhGxpBtMZ5kfuzR1tQAewiecoX7UjXQRo91QjJHH9T_Yw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 33/42] fs: add file_check_backing()
To: Chris Down <chris@chrisdown.name>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, 
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org, 
	xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev, 
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-usb@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 14, 2026 at 9:06=E2=80=AFPM Chris Down <chris@chrisdown.name> w=
rote:
>
> Hi Christian,
>
> Christian Brauner writes:
> >+      /* Look through stacking filesystems at the inode with the data. =
*/
> >+      if (d_real_inode(file->f_path.dentry)->i_sb->s_iflags & SB_I_PSEU=
DO)
> >+              return -EINVAL;
>
> This looks good in general, but what the bots said about O_PATH files
> here is real. With FMODE_PATH this is reached for a file that was never
> opened, so on overlayfs nothing has been through ovl_open() to look up
> the lowerdata of a metacopy file yet. ovl_d_real() then does the lookup
> itself, and when that fails it hits the WARN(1) at its end and returns
> the overlayfs dentry, so the check passes as well.
>
> Only fuse passes FMODE_PATH, so it takes CAP_SYS_ADMIN to get there, but
> it's easy to trigger with that. From a quick test with a metacopy file
> whose redirect into a data-only layer points at nothing, registering an
> O_PATH fd of it with FUSE_DEV_IOC_BACKING_OPEN gives
>
>      ovl_d_real(/f, 0): real dentry not found
>      WARNING: fs/overlayfs/super.c:79 at ovl_d_real+0xc9/0x210
>      [...]
>       file_check_backing+0x308/0x5e0
>       fuse_backing_new+0x219/0x4a0
>       fuse_backing_open+0xe8/0x390
>       fuse_dev_ioctl+0x53a/0x7d0
>
> and the ioctl still succeeds. A normal open of that file fails with
> ENOENT, so nothing could have used it as a backing file anyway, but with
> panic_on_warn this is now a panic.
>
> Maybe ovl_d_real() should just stop warning when the lookup fails, now
> that it has a caller that isn't trace_uprobe?

Yeh I guess that this needs to be a Fixes for lazy data lookup.

The correct fix would be to teach all the callers to deal with an error.

> The check would still pass
> for an O_PATH file whose lowerdata couldn't be looked up at that point,
> though.

One observation relevant to this patch set is that a datadir layer has no
business being a pseudo fs and that can and should be blocked explicitly
at overlayfs mount time.

The other observation is that fuse_passthrough_open() should probably
check the backing_file that was opened for io in addition to checking
in fuse_backing_open(), which could have different FMODE and specifically
could be FMODE_PATH.

Thanks,
Amir.
