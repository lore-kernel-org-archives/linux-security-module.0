Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C295A3FFFAD;
	Mon, 13 Jul 2026 12:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783944386; cv=none; b=K2MHWJpGc2uKeaSP3KEBCLhlmqV129R8k7yoZs6zdH9e8JTzIpbtYuWDnOzEjQ7ApTJ0GE8pX2sBJGXaO1vqJrC+sTGvi3Yko0fiDD89SB5JEWBs5GjkDiA+XZiXVoYEsRKxRcHqHdyb6laDLRrZJ15RbUqTieLYDuUwlUXWy84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783944386; c=relaxed/simple;
	bh=+U2YPWx1RxAYwnDpvWoHE0tolOR4X7Nd8pwGzbocKso=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fNqGMFxCepXJqA7rZuYWi6KknL715jZs88OrTyQii0RW8EOZSTIjoCF4AxgGtTUXJuyHXLovmCopwB1cFRSkr6nTOgyE6o1Nyic90r32rOG/DmCJM2A68K8wKIVePbcSGwDEbkpDSf66mOh9mF4xR9NBcU8g/cTXra4dXjkmP6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.196])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTPS id 4gzLbd28yHzpTqY;
	Mon, 13 Jul 2026 20:00:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id F2B524056C;
	Mon, 13 Jul 2026 20:06:15 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP1 (Coremail) with UTF8SMTPA id LxC2BwDHpLav1FRqIuqSAA--.10071S2;
	Mon, 13 Jul 2026 13:06:15 +0100 (CET)
Message-ID: <8c757ecb48c7dd733eb10c3927e9db94cb056fb0.camel@huaweicloud.com>
Subject: Re: [PATCH -next] ima: add cond_resched() in ima_calc_file_hash_tfm
 loop
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Gaosheng Cui <cuigaosheng1@huawei.com>, lujialin4@huawei.com, 
 zohar@linux.ibm.com, roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com, 
 eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org
Date: Mon, 13 Jul 2026 14:06:04 +0200
In-Reply-To: <20260713111022.2418849-1-cuigaosheng1@huawei.com>
References: <20260713111022.2418849-1-cuigaosheng1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwDHpLav1FRqIuqSAA--.10071S2
X-Coremail-Antispam: 1UD129KBjvJXoW7trWDKw1DWry8Zw45Xw4UCFg_yoW8WFy8pa
	9agayvkryDCFyUuFsrCF9agF1fC3yUAFy7WrWvgryDJF9Ivr1vqry7GrWj9r43GrWFyr18
	ta9F9ryDA3Wqv37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQANBGpUWsYlyQABsH

On Mon, 2026-07-13 at 11:10 +0000, Gaosheng Cui wrote:
> When hashing large files, the while loop in ima_calc_file_hash_tfm
> processes PAGE_SIZE chunks without any scheduling point, which can
> cause soft lockup warnings:
> watchdog: BUG: soft lockup - CPU#0 stuck for 50s!
> Call Trace:
>   _sha256_update+0x12d/0x1a0
>   ima_calc_file_hash_tfm+0xfb/0x150
>   ima_calc_file_hash+0x6e/0x160
>   ima_collect_measurement+0x202/0x340
>   process_measurement+0x3a9/0xb30
>   ima_file_check+0x56/0xa0
>   do_open+0x11b/0x250
>   path_openat+0x10b/0x1d0
>   do_filp_open+0xa9/0x150
>   do_sys_openat2+0x223/0x2a0
>   __x64_sys_openat+0x54/0xa0
>   do_syscall_64+0x59/0x110
>   entry_SYSCALL_64_after_hwframe+0x78/0xe2
>=20
> Add cond_resched() at the end of each loop iteration to voluntarily
> yield the CPU when needed.
>=20
> Fixes: 3323eec921ef ("integrity: IMA as an integrity service provider")
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
>  security/integrity/ima/ima_crypto.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima=
/ima_crypto.c
> index 0d72b48249ee..3b7d41a9fd18 100644
> --- a/security/integrity/ima/ima_crypto.c
> +++ b/security/integrity/ima/ima_crypto.c
> @@ -233,6 +233,8 @@ static int ima_calc_file_hash_tfm(struct file *file,
>  		rc =3D crypto_shash_update(shash, rbuf, rbuf_len);
>  		if (rc)
>  			break;
> +
> +		cond_resched();

I would recommend not doing at every loop but every 4 MB at least:

if (IS_ALIGNED(offset, SZ_4M))
        cond_resched();

Thanks

Roberto

>  	}
>  	kfree(rbuf);
>  out:

