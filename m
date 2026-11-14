Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794686762;
	b=rOr7tjFmfMEmdLMwPE2r1ZRX9azlKilf2APR00fxkTFDPHPD+91a7dfdiSMLGxu0eU7Z
	 J4kbFbBnCNqDbEpW+f+727VxJbv+kqJpn9BbyZQmgmVlw7rGPirkiN8+BnbObJHStxMeS
	 cLpBY+FbKBPLzW6o3TnERUxmABetHWr3trSP7rZ9GCNndByrBF2gpOGwxbjUUoRBVyEQR
	 TRJFjh1Z+dKcigbZWGah7qbnY2uR1tg8vWJOVVEK/H6qnxCiybV2GEzYjUKVb5qAnyhx7
	 xoqj+x73VfX2iCrnrwxlbgGSWj7AInxtU1iWZh/FDljdJW9qvdkIYY5kwQgK+lzW64w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794686762;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=L9fh6nGpkdQ3PKE1Pv6VuACg3WWhS00/MicQv00SggM=;
	b=v1vhReUC5C0JMYYGz91uVTOsUdnuL26V/Zvj1WfeY+7FHEYFba/feDHhzLCaYV8WSXlo
	 2DXWk3wkSkbq3u+KtU9OEoP+Gr0TnYAGWn3OXD2+ofCluWSmeKKhywn1pBN/sw43JigTR
	 pudZTQaGWW2SpoxDjgJgdBzvyIhoHMhOOuekeMndztIxF88VjRri5onX6n1b6ICGLYq9v
	 Hl+U/zZBBomqLfyF2U6UdqrXIftMj5vRGOu2yZ8JqmXaOAyqdMJ2fEHFZdWwzUnNGEW1K
	 UMOxlelOunOAwyBLIRQxIXld+OWRqHpUIxa1O49XnLxPoQeFuqIUYtParInrOoB8DPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=WyNKKpAN;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A0960A3806
	for <linux-security-module@vger.kernel.org>; Sat, 14 Nov 2026 20:06:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6A0960A3806
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=WyNKKpAN
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3b09a83d12aso2481001a91.2
        for <linux-security-module@vger.kernel.org>; Sat, 14 Nov 2026 12:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794686761; x=1795291561; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L9fh6nGpkdQ3PKE1Pv6VuACg3WWhS00/MicQv00SggM=;
        b=WyNKKpANsG5sdrHWGAt+Y38DvSIGt+WnCUyNYCZoBM4YbSq3wCVAHI95jQ8BFTGgLn
         +vM7af/q0i5zrzjZXXnriwzXN4L/RbeBg/iztvO0eyeIXYNiQp/OYlS5LD9yZqr2gKgm
         1I+5A88e/cV4J0nLZfgp0f7sQwj9jY0Q4quBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794686761; x=1795291561;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L9fh6nGpkdQ3PKE1Pv6VuACg3WWhS00/MicQv00SggM=;
        b=YJWIFbYvH9+nr5EdBbW/Sep235/YYfmRNQqWWkoytrH1wdFpoTIGJ3fFYvoSFo0IzY
         32Brvg2cRRTwX4VqMu43wP+kGRPBgscuPwApeszs79gfKkt6PQUsNUCHW2YNUGs95ZBV
         2N796giWFIjegg/d27Rop6sMKBO+T/gLJ6Rqyfol8F/xr/d6PYdITjRlOTVKEDN7JWmZ
         uecemOUUBbavwIosPkAMfoO4Y2JUSJS975WS8n6QqZww+C+qRNv7fyXqFVhtRgGH4blq
         XUlR/jAYwaWsGlv0fA0JxMrguRklGMWfFqiG05eQFnJ+TTbs7ZlYSfDqv+tDTlAmXXcJ
         WeJQ==
X-Forwarded-Encrypted: i=1; AL+hErHPjbVIrlbC5XBzVJvupG+FRcvPURPzSLlmKVcl8HN4O69g7tKs2Z2jOkTZhYN/yeB2Go9GowR6AKH4/49htBeFLm3y/GI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9qnltxW18EwB1BGEZ9WL5tEkOvYlWXcWIVN08Tmtu3EPy3NH3l
	Dqz5CSpUh0B/3anDOp1o4bsCIBgGYtEESiIRl+1qNL89nlEhRcRLq/hkIphPu1sRVcQ=
X-Gm-Gg: AYBFou3q71gtXBOccSF6KBU+vJk+49aqPh55JUY7Cd8D6uDFe5n3HvMTvgTmamN/8/W
	pd9ghw+BEUxD35ZWF4knimLolSKkvIZV405TGPJ+CwxdjXmohPjczxrPuTBmdVFRIDN/OSY4ZwA
	RiyNpLOOWAa2xwcExa46w1srPhTpgJUjlmeY9jwvDetGZnFodH5PKJA2dweGgPgHnXYAcsD4Z8m
	pMGtjtKFgXPHEjuOQr2JjiRukj9JASPw8dAdyt571BXov8THh7cHYQWk8Y3aX9Nc/8iwSQre5Kk
	6QeKp1Y0ZC+G6FMaXj3q2VWQfS6iHBV6tYcM85dUy0RRKekLyV2xnTmDWqOg7Dh6q/P2Ehf4UZq
	e05WDBq5pfp5YyUMM9Xeatm2qysmmlwId1wQxt2gmJNm4sgSDUtMIuriyz3pLCcCqyYolwoD7zA
	UgBWjbHtUfyUZPNfKA51l9H796gEwXFN7O2p6aoxAO7cVXKe5k3CigpzhZP1Glkgu7qpHycqufT
	Aw99IrmzchizXlknXkP8z3ToBfOhgQnOSs6/qvVwPDW0q7GV4Yi936qxO/f4b0G2JSKaiRsSRQO
	mT37wGwOoL95w0acyugGK35/IBa+4/n8n3ZCWS5gYYptfyBBsXMXBAsMSYd6NwzKU7KyIrLRLNu
	uCPjZvAlsrW7GQZMjZ50w06UACb0740Z1q9Rz436PlzgI5iV2zyFYMYvwi8q7KJjLjdTytn5dJK
	kkpedAvIbTD3XpMOST1RrUsjmHlkuDvd6kV/rVijMKY/0CudoI6iZUxmsZ
X-Received: by 2002:a17:90b:2584:b0:3ac:9f00:3bc7 with SMTP id 98e67ed59e1d1-3b1b0ba61famr5629200a91.33.1794686761104;
        Sat, 14 Nov 2026 12:06:01 -0800 (PST)
Received: from [172.22.0.2] ([64.16.22.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b1e9ef15sm5258887a91.0.2026.11.14.12.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 12:06:00 -0800 (PST)
Date: Sat, 14 Nov 2026 12:05:57 -0800
From: Chris Down <chris@chrisdown.name>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>,
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	driver-core@lists.linux.dev, linux-mm@kvack.org, bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org,
	xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-usb@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
	linux-erofs@lists.ozlabs.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC v2 33/42] fs: add file_check_backing()
In-Reply-To: <20261114-work-loop-pseudo-v2-33-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
	<20261114-work-loop-pseudo-v2-33-98639a2286fb@kernel.org>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Message-ID: <20261114120557.4bc1eb6e57218cdc@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Christian,

Christian Brauner writes:
>+	/* Look through stacking filesystems at the inode with the data. */
>+	if (d_real_inode(file->f_path.dentry)->i_sb->s_iflags & SB_I_PSEUDO)
>+		return -EINVAL;

This looks good in general, but what the bots said about O_PATH files
here is real. With FMODE_PATH this is reached for a file that was never
opened, so on overlayfs nothing has been through ovl_open() to look up
the lowerdata of a metacopy file yet. ovl_d_real() then does the lookup
itself, and when that fails it hits the WARN(1) at its end and returns
the overlayfs dentry, so the check passes as well.

Only fuse passes FMODE_PATH, so it takes CAP_SYS_ADMIN to get there, but
it's easy to trigger with that. From a quick test with a metacopy file
whose redirect into a data-only layer points at nothing, registering an
O_PATH fd of it with FUSE_DEV_IOC_BACKING_OPEN gives

     ovl_d_real(/f, 0): real dentry not found
     WARNING: fs/overlayfs/super.c:79 at ovl_d_real+0xc9/0x210
     [...]
      file_check_backing+0x308/0x5e0
      fuse_backing_new+0x219/0x4a0
      fuse_backing_open+0xe8/0x390
      fuse_dev_ioctl+0x53a/0x7d0

and the ioctl still succeeds. A normal open of that file fails with
ENOENT, so nothing could have used it as a backing file anyway, but with
panic_on_warn this is now a panic.

Maybe ovl_d_real() should just stop warning when the lookup fails, now
that it has a caller that isn't trace_uprobe? The check would still pass
for an O_PATH file whose lowerdata couldn't be looked up at that point,
though.

Thanks!

Chris
