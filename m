Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84AF229B02
	for <linux-security-module@vger.kernel.org>; Fri, 15 Aug 2025 12:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755260929; cv=none; b=sKQFLBc/RctUpv6KTp6vWbM3JwclznGkpA5MMbvx2IbxzKEKgdQtgc5DmrjDTAtfTIAjSYofT5UZ/uQVODzauNd+Oxt3zDqkUcAUsnUPq3DAbsMP+81BiTIT5IRfcCGufzzo2cb9S2eGvT6Ni/D3A7dmCkN1JPneAgvVNXYws0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755260929; c=relaxed/simple;
	bh=LpFQvQEZLY7rXEx8rVKL1EKG/x0+GDQrKNPebN/3RSM=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=argglJ0kjcVufD+HBk3DdQNAcKTNxoS2CxVYQdQPWGDuT0UerILQaosSRsCWsgqiVG3AhstiGipWn8S0yecp/WTSTzAK79D+1JbiiQXHdV+3jcL7wZSgH/vqwSyNNqkvrPs8l5b9GFV22mxsVE2vVOiHMfjzK30Ri1TNlGeQ83E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4c3LtT6V9Cz2TTG3;
	Fri, 15 Aug 2025 20:25:53 +0800 (CST)
Received: from kwepemj100006.china.huawei.com (unknown [7.202.195.251])
	by mail.maildlp.com (Postfix) with ESMTPS id C2E34140149;
	Fri, 15 Aug 2025 20:28:36 +0800 (CST)
Received: from kwepemj100004.china.huawei.com (7.202.195.249) by
 kwepemj100006.china.huawei.com (7.202.195.251) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 15 Aug 2025 20:28:36 +0800
Received: from kwepemj100004.china.huawei.com ([7.202.195.249]) by
 kwepemj100004.china.huawei.com ([7.202.195.249]) with mapi id 15.02.1544.011;
 Fri, 15 Aug 2025 20:28:36 +0800
From: Xiujianfeng <xiujianfeng@huawei.com>
To: Dmitry Antipov <dmantipov@yandex.ru>, Nicolas Bouchinet
	<nicolas.bouchinet@oss.cyber.gouv.fr>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>
CC: "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>
Subject: Re: [PATCH] lockdown: avoid extra call to strlen() in lockdown_read()
Thread-Topic: [PATCH] lockdown: avoid extra call to strlen() in
 lockdown_read()
Thread-Index: AdwNtqKOkD5xINj9QaqwkRg56Io9cw==
Date: Fri, 15 Aug 2025 12:28:36 +0000
Message-ID: <d20a898c651c4e77bc32d01cf769682f@huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Dmitry,

> Since s*printf() family of functions returns the number of characters emi=
tted,
> avoid redundant call to strlen() in lockdown_read() and prefer
> snprintf() over sprintf() for an extra protection against buffer overflow=
.
>=20
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  security/lockdown/lockdown.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> index cf83afa1d879..10537d7c4437 100644
> --- a/security/lockdown/lockdown.c
> +++ b/security/lockdown/lockdown.c
> @@ -106,9 +106,13 @@ static ssize_t lockdown_read(struct file *filp, char
> __user *buf, size_t count,
>  			const char *label =3D lockdown_reasons[level];
>=20
>  			if (kernel_locked_down =3D=3D level)
> -				offset +=3D sprintf(temp+offset, "[%s] ", label);
> +				offset +=3D snprintf(temp + offset,
> +						   sizeof(temp) - offset,
> +						   "[%s] ", label);
>  			else
> -				offset +=3D sprintf(temp+offset, "%s ", label);
> +				offset +=3D snprintf(temp + offset,
> +						   sizeof(temp) - offset,
> +						   "%s ", label);
>  		}
>  	}
>=20
> @@ -116,7 +120,7 @@ static ssize_t lockdown_read(struct file *filp, char
> __user *buf, size_t count,
>  	if (offset > 0)
>  		temp[offset-1] =3D '\n';
>=20
> -	return simple_read_from_buffer(buf, count, ppos, temp, strlen(temp));
> +	return simple_read_from_buffer(buf, count, ppos, temp, offset);

Thanks for your patch.

Since the current `lockdown_levels` array is static and has only three memb=
ers,
and the total number of characters of these three reasons is far from excee=
ding 80,
there seems to be no risk of buffer overflow for now.

About the change to strlen, I think lockdown_read() is not on the hot path,=
 the impact
is minimal.

So I prefer to leave them as is, thanks.

Best regards,

Xiu

>  }
>=20
>  static ssize_t lockdown_write(struct file *file, const char __user *buf,
> --
> 2.50.1

