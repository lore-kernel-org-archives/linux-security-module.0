Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794903967;
	b=psZNxQn4EuEZLiNLnbzOlFOJ3Nvog97WAZcJ3iS5rplqoIvtNWxFajHzcL5A4a845KsB
	 8QNblgVaq29dk1iVMaJI7JeN+Sz6+RZkjzguzuP6L1ssWhwDEwNpgGCmt6laP68nS8PCy
	 J3KzN94qVSTSxSTL1uNbHK+3EVXTG6Du+0SqRZjngNQJfOrBNDXhbpw8GKKslteC6BzaK
	 JVKN1qYL4EuZ5auBGhvE9CBxtlDUl4LN2L/Aqs8o46ApB99INU6tRqEw/1mep0nB37bZO
	 SKT9SPE18oYh12jLAA2ru0HmbWQpJziQfVKhtUVYYM/g1lRuyfAKycM3b8CbdNsOZCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794903967;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=z/NZRmC5bENRF/WsK1hUt6gARTy1xozW3x04wBCWbAk=;
	b=MZTh1RwpGwDSUm5XeUNxkVqGIABdiXR4GDzsQfWYVNIyy0iQ3CHRL95TRdayJ9pJ8jWR
	 hPezpk3Yo1Tvf4Tpgc4rOEQRlyM0oYZK8ldcDfhapnh+4TJdJ7Z2nZk1ZKLwgEmyPJv3D
	 QO8R61FPs6FSLfM+c3Tr22DhCK/x4X9XdzErmQ9nVY9NKK/I5kqz297yAt04Im5FU+V4B
	 isNjrC0hC64F/dwJW8k99keyRCqaKhTFYjNeKl0V+vwOOJjdf3BAdZoPMHJAtFmWAQwr1
	 6yECZw3EtpuwLLImM1kEyWynAWa5TWHPC83lGDW0g8jKjA4sDvclXGnzCuqP+hsKCPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=cds43TFp;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158EF606A32F
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 08:26:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 158EF606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=cds43TFp
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4a5024b3c28so62300f8f.0
        for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 00:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794903965; x=1795508765; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=z/NZRmC5bENRF/WsK1hUt6gARTy1xozW3x04wBCWbAk=;
        b=cds43TFp7I9j7WPcDQvYfHpQ9LovbzzVif9J1GAb84gdrUsjaaD/ks8/CxWEGRZF0/
         68hyeBKuGnu6JbonI+DUrAk+S9ERoS7tOFFA4H5eAQDr7L4jclXV2ELfZ8mKm2Ufg0Vf
         wmDFKHpSFXtb9q6HdOEKHOgWOeHJI7n45fohFUmuSejGQMSPwWlozLhppiRP7NP6/RTN
         Xh3C0JkZ12tnXvLGCknth+xcOYp3m/oSfXqUlVI9cwzFe0Rue3P0S85bM03sQyFUoXwh
         8JJkMFcg0oB6zhSAQwaixAlqp7dYBZf2pow5RK/cSK97CWugz7jqMDtCMqYWg5eRSPcE
         y3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794903965; x=1795508765;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z/NZRmC5bENRF/WsK1hUt6gARTy1xozW3x04wBCWbAk=;
        b=eZrOHTghREvNDMkeWnVrbXiIrsXvE51Pyin/oz2itzwD5NSvzoaDKn1dNlUaDERWDl
         dw1NpcgT46TAJnCAXAyWjQU1It7UCw7aFsFBFqqSo0cZ06dVuYojjIquvLLgVXiBFjQt
         YK3Vk0tu61jQmq36nYU0pkamW46L5L+gipfrGi+PsAmrsMqI+ajg9ToJij5MlKMo45a/
         J8QUMP7VojpOxgEjEG2nOz+g0nEyq93wd2wFO8Poj5JC8U9vFRzzSIwjz5Uujin1P5QL
         bFUuBLF5WSebXSdYI69rlZzsN1BcF7aigILGuWYhxXVlG7/09a/XilCDiUsdTG6hlCNB
         BtZw==
X-Forwarded-Encrypted: i=1; AL+hErEjGJlm0Rk7/ZZgHjfrCmqK7GER7DyEz0zuTfm5PNJ4M7sO7k/ShWUWloTCgeiM/NiU7bbQ3MXJVshKJImI1HiZ1dAxEso=@vger.kernel.org
X-Gm-Message-State: APuU4Z/C04zG1nMJP5/RHqUkQMsbADf2/Gcm770SrbBbMOgl5/wfySxS
	R7WCJaxGKQQE8Yk5+HkE2odDCvOGCS55zpiOgN2FRqyLsBVNaRPesabMgTWAvt8/bh/Q
X-Gm-Gg: AYBFou3fy7GAeaRej9cVuqNmrP/iewgpQ/uxTOUKgvs/jGuOLBpUWaM711ZbkYOK+BO
	ORGTXBw9LTJ8kTTLcR4W/DKtjUs061M05tSJlc+m0EDx61vCtb5D6B5kzi9JYMwQs5Q+IpmvtUR
	z23X463yuQ3DTalJ4CQN9mCykjNL+0pZhzhgrj8OoPuQsrhqH+A5w+fc6odznyQOk206x2stORj
	aTRCaUo6omKg7wjEaO3WHn9BfL8eZZw3FS3XJ+Rpok1+pAK+X0g2pQzdrpR39JN8RTHTkl5rvkK
	aMym1KcPswJM8C6sSmXBc1Q1lbRrE3FgbVUNuvk3Z9e8YOpmdwVCrz2WtoEmmNiPw6B4F5v5app
	etu6rxmKQCl+++9JpF1EM9dbWMPGblybFV0YnR0EWEt3faHo96wm/CePcFBtqdOCIalN5O/bokb
	GJfXGMg6KMxDEJSyziFG+gK6mHlDVxQbHYRPluikh7jz7V4x3d47NQUT6NZMI7CmXTP03ZMjxSd
	CE4ThUcBisbLzouDmkcTAq6V6xzXbfAvbJuXACgcoX1GgnXAIq/F8Iz/qCa2vrYsNDNvG/4hGFF
	qHHUIZaaWvWx5UphTuffVAbSLhkjpoqFm6GUx0NUU/YD5yLhgwhrsx8KsJIC6nkELn2fmM3AaF/
	KFs3bpGfXaRbeZS9HxYTX5s7WoQXjHDEPUo0x2p4zw+yHhkYuR4dUnegL
X-Received: by 2002:a05:600c:5493:b0:4a1:c27d:e1a8 with SMTP id 5b1f17b1804b1-4bb783813a7mr42606245e9.10.1794903965400;
        Tue, 17 Nov 2026 00:26:05 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:de4c:6789:33ce:97c2? (p200300cf572c2800de4c678933ce97c2.dip0.t-ipconnect.de. [2003:cf:572c:2800:de4c:6789:33ce:97c2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb7ad9430asm12629125e9.15.2026.11.17.00.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:26:05 -0800 (PST)
Message-ID: <88041240268f70b218de7dfd58c41977d03a60d3.camel@amutable.com>
Subject: Re: [PATCH RFC v3 03/44] target: fileio: check that the backing
 file supports ->{read,write}_iter
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
 linux-kselftest@vger.kernel.org, Chris Down	 <chris@chrisdown.name>
Date: Tue, 17 Nov 2026 09:26:03 +0100
In-Reply-To: <20261116-work-loop-pseudo-v3-3-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
	 <20261116-work-loop-pseudo-v3-3-8cbbea1cf34f@kernel.org>
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

On Mon, 2026-11-16 at 12:04 +0100, Christian Brauner wrote:
> With fd_async_io=3D1 the fileio backend calls ->read_iter() and
> ->write_iter() of the backing file directly. The synchronous path
> goes
> through vfs_iter_read() and vfs_iter_write() which check for them but
> the aio path doesn't. So a backing file without them calls a NULL
> pointer on its first I/O.
>=20
> Refuse such files when configuring the device. On the synchronous
> path
> every read or write that needed the missing method failed with EINVAL
> anyway.
>=20
> Fixes: 769031c92c8b ("scsi: target: target/file: Add support of
> direct and async I/O")
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Chris Down <chris@chrisdown.name>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0drivers/target/target_core_file.c | 8 ++++++++
> =C2=A01 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/target/target_core_file.c
> b/drivers/target/target_core_file.c
> index ab9824a4852f1..a5391e57e9aa5 100644
> --- a/drivers/target/target_core_file.c
> +++ b/drivers/target/target_core_file.c
> @@ -144,6 +144,14 @@ static int fd_configure_device(struct se_device
> *dev)
> =C2=A0		goto fail;
> =C2=A0	}
> =C2=A0	fd_dev->fd_file =3D file;
> +
> +	if (!file->f_op->read_iter || !file->f_op->write_iter) {
> +		pr_err("FILEIO: %s lacks ->read_iter or -
> >write_iter\n",
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fd_dev->fd_dev_name);
> +		ret =3D -EINVAL;
> +		goto fail;
> +	}
> +
> =C2=A0	/*
> =C2=A0	 * If using a block backend with this struct file, we
> extract
> =C2=A0	 * fd_dev->fd_[block,dev]_size from struct block_device.
