Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794323279;
	b=SdIPd9oLoZcDlBfVBGg83F7jJ4J1xKIJvDtvFkgst59njLWUTRQMcoDskYqpWTkUwzY7
	 9Ikjut5a0PMVcDo0d4AHzIUr/SFOTA0qPaF5iMyYs6bk4bSfz8OpQHz3kEwGZXl7Y5TgK
	 DOgHTQdvUmaZlrBJe6faKoa1ngqkJpgXn+54MUFxOY1iz9/AvGNyB+y2469NvyU/4DQM1
	 8EqzYqqJJcm817TNbGAMZOjivbGEvoompm4RKYDxgMr2yV4rgHQ+lZFH7G7X7ZzvYDD6b
	 t9Q4lXvGbGiHy5/HqF7fngeByO2KK3plABEs/O1i1azdxgb/yyzH5S2twmttxRVHO2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323279;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=JtM9UtzYhAWCxTCfoBKbcmHIR3U4Wq7tzdw7gboBY64=;
	b=H1bqhPBrlz13jPzGwp0S2xgF0vXBbSOAj9sBr+id7JCpMhCI5cWpJgEozqMTCHPR3BKv
	 KAP4L0kChF8r3a84NSOmnCqvAY7M/RGMxLyhd4Mm6REjMqLyQ+Lxe8eXaRvcZJa4Mjtms
	 6h9ocGiQ+Th42+aCeIbVtAfe/kfqlkeHKkdNRlKXWHONYbgHDwNzobOEHsB1EOoto8bSy
	 CqltYfnkLDP/vZ10Ot4UmsLwlnh5y9wOLUqin5WJp6FREEduSQ+AjNYxrRXygvU5nBQYE
	 fO1tkKwXxE1iGX6I8qSQ9wFtQXQZ9keRSg7S7VCXHnfQn1Okr03UeHdfmmSMHnHqk4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LHozpx7Z;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5F160A262A
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 15:07:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B5F160A262A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LHozpx7Z
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e977109392so12284645ad.0
        for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 07:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794323277; x=1794928077; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JtM9UtzYhAWCxTCfoBKbcmHIR3U4Wq7tzdw7gboBY64=;
        b=LHozpx7ZkQyIUBsAkv4C311vzxfheFN2pzrL9Y/FTHkEXQzaVUkMAz9U9wFUejAOr8
         YATASi40x9WcOvyF4dkS6SJQ2bBJHO0yE68WsOT8oewufPXMhMYT6O7d4/5H33a+EMHR
         jjCu1KqktdAA/9c8ZIpbjFjA/3BLyNbgEZc3fS3F9+PTZ5y3jCgkJQ9rhGft5ONP+cJO
         aTEF5vn9sQP8UWqDXO8UszNcV0yZFTKvtrsUk25y1Sz/3h5njQt9uj1PBQLO+FuWPgpB
         LsGoLTWDE/iFYFuKD+GJLya2PXFipxPXM8zYDthkWkjgd0549O004Xgoom3qc/ylK84T
         vykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794323277; x=1794928077;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JtM9UtzYhAWCxTCfoBKbcmHIR3U4Wq7tzdw7gboBY64=;
        b=INpOZa/gU6zIkS9Ai9dxaWuun4a7lHDLmzlROi3y8gbfYw6BI1OWP2agFCMyPP0fBv
         /zLOkD8r76fVifFKEnl0Og5Xl4ge4YpKvS8gkNWJtRmGoYhbnbDjk5RHh4jeQKHIWzWr
         /XndruoDX8JKXmcrtSDD1WIJlEnaAqYwzv/C2VckM6vJ6jZHX/nwPe854bMkr+qBeomu
         LQlhEZoit96p8vYhhFr3JbPovRdSo8dHCShFpuPMEv4YZmWfSl2POXK8PGANRSkG8nGy
         UqkR8ClJ/r6ODBbFSpVkBrNh40EoWrbwVMREulzvGM0OoFXStwXlWnrtb55LZcwadl5H
         rXKw==
X-Forwarded-Encrypted: i=1; AL+hErHTL5hQILJ9Ll7nZr0CXaFTv/4CQIt5WiB0sKQMbfBcyZSHEo7AhwbMBY+hYszTpo3x/aaKHRq9saabEt05EpuX+T2O5kI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8iQjTkLvnwZ1wLiI93LmtQQNSHi7/MhhiU6IDk5PGYUpWnm0iJ
	w4lu2je7jAvclFx+f2fL9o5NcTrZP2uO7uPR3rsQxN6dwEp2uw+xQyfK
X-Gm-Gg: AYBFou0SvpVhYbhdiGFqsbgm7BdCmszRgUfhpsSB5EBP0Jua7dCVXkLGczwP/Dy3hQN
	NCwLUb20ITzXkxrAKEGS765l1QvNM9Fr7ZUuX3qyX+pOK9id8+0hgL3ERYOMWUP2iHUavD7bOI+
	/PBxDvPU8hnUubok+n6odvlDQLxGAI2s8nY3ix56fZzmgwuU8XlpkwUl8VsKuIb3ytJrWWA3hXc
	DhJIzc23WOWORC7hnXeRoYLvrhIMEPMEgn3rqx8ZB+nLGltnctPYKt0Ykm5ImRMeigzlihKfRvv
	i0Sx6vmlV7/6D7AEOg2R2z3ytSqnjJ8NR02Lvsbij0dlY9eTHhhkL7FXhfHevdeVTzbvAmJ4xn+
	7pYgfG4PxUMs2eeYZhaYns+VyAjkgVPUiA2JDz3gkmlbECizS+wTbpITPixD/dbAfAgJwnRRyET
	8LgfJqFXrufjaS4BQnOLj3KjhQG0S27pin5zfi9WYkaxIoMdxXptz2GEmaeKhOEE/OAXKwxksnk
	KPESYYLwoAOMPiTelE4rD2x/IpLSz8mjp0ClvjMw5a5B4AmJJ/6NVMrWkikGPKbmK4LOgF3xGR+
	PD1Hpmr9YvOypp8fdI8PKoHMZ1t3zqwqzaQKJ4c8dyBaCxh0+oBuiMUkJaklcDngGbNDglNkgSx
	yd8f8E3gJgW4=
X-Received: by 2002:a17:902:d481:b0:2ed:1ef3:9ec with SMTP id d9443c01a7336-2edb9172a2dmr26826345ad.14.1794323276968;
        Tue, 10 Nov 2026 07:07:56 -0800 (PST)
Received: from [192.168.2.6] ([27.75.101.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6d78dbcsm10397575ad.27.2026.11.10.07.07.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 07:07:56 -0800 (PST)
Message-ID: <71f76e5e-ce24-4a71-863a-169ad262c510@gmail.com>
Date: Tue, 10 Nov 2026 22:07:46 +0700
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 36/41] nvmet: refuse files on pseudo filesystems as
 namespace backing files
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>,
 Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, driver-core@lists.linux.dev,
 linux-mm@kvack.org, bpf@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
 apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, fuse-devel@lists.linux.dev,
 linux-efi@vger.kernel.org, xen-devel@lists.xenproject.org,
 ocfs2-devel@lists.linux.dev, linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-usb@vger.kernel.org,
 Amir Goldstein <amir73il@gmail.com>, linux-erofs@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-36-4c998976c6c7@kernel.org>
Content-Language: en-US
From: Bui Nguyen Nhu Quynh <kaylovefoss@gmail.com>
In-Reply-To: <20261110-work-loop-pseudo-v1-36-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/10/2026 4:14 PM, Christian Brauner wrote:
> The file backend takes any path that isn't a block device. With
> buffered_io=1 that includes files on procfs or sysfs which then get read
> and written by a kernel worker on behalf of the host. Refuse files on
> pseudo filesystems just like loop does.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  drivers/nvme/target/io-cmd-file.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
> index dfa8aa46188c..71c69bac5394 100644
> --- a/drivers/nvme/target/io-cmd-file.c
> +++ b/drivers/nvme/target/io-cmd-file.c
> @@ -52,6 +52,11 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
>  		goto err;
>  	}
>  
> +	if (file_is_pseudo(ns->file)) {
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
>  	nvmet_file_ns_revalidate(ns);
>  
>  	/*
> 

I noticed patch 41/41 doesn't include a test for nvmet. Would it make
sense to add one with buffered_io=1? The test would need a pseudo file
that can be opened with O_RDWR and supports both read_iter and
write_iter. Otherwise, it could pass without ever reaching the new
file_is_pseudo() check.

Thanks.
