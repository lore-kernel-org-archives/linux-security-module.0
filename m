Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794534190;
	b=gL3ehlVL/ZQFEdYPRkrs5comBGbdVp9bU9Ft+7cbj3MWAEniMr+eOuVJb7P+CUc3gZd+
	 TOdRNNU7zRFUKBlLQZj1BZJtxvcmKFNyCFX4KabOQO4ORzC7UyStZBp+YhbiP9TDHCajO
	 iAQsOmOkuFk+bjayFT70BsSQX7ZICnjhoqBv0mgajuqmWkp2XyagUJMg7ZdM0L9dJOe5e
	 eJD6DTcZwwVvAAxFNoSQzggI8C/2+0ymGaeMwiwEyyPju2JThgfIZHYIM4iMVnzcGu6dg
	 mApzRFBZ06QeevMskRP5FeYR2UdijNZZrrmb9NTTT7ysyIx/kYbPC6ByZkcjtJyEZsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794534190;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:CC:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
	bh=/mUva7h/RQXajijhNYfuRIEQFHQ8L8xWKkcs+bP4xWM=;
	b=j9Erg0Ylq/9h9lN7j+uJqRJwKGmGRnkLZ/hQNrxppW29Wb0Zt80m5cqKDUXuwMDwhcPm
	 fTkPVCuCByZBUM+a1IXR4lJQo0psmkiEp9woxTu2EN6WuedA1bQbiAaQKsH1+4vPCFSHr
	 E+1uO5J+iWsr3iz1Calbq0F/HGOHCZDCkB3oiqkPjdzYSeKWQVispDi2wcWhhurGRu+tN
	 Y9M7fszzRvXCE9nmEFGaFWZN5Fsr/KEwFoWwpSChZXFQhLme3aEFngW58dKX97zbP6PyI
	 viUaj6YziALxhZ8koKOR7sSUsRvXX1EqlOE3AWP5WoWIB5dm7/ualolVo1Da6hsHk6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=6kKACfwI;
	arc=none smtp.remote-ip=113.46.200.227
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80D8606A321
	for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 01:43:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D80D8606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=6kKACfwI
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=/mUva7h/RQXajijhNYfuRIEQFHQ8L8xWKkcs+bP4xWM=;
	b=6kKACfwI7/I63VNJn01bDk+tHWkerOM8oiKDJSYLymjB9/LpOSWgoAA+y7lvLpK3LaR+aM7R2
	xX7nKZfFaYaZ/X4YnGMEtYhNeOOal6hCb8cQogeyC5nmdEqtveftg38ePBjPS34VyUhGpaLAfqA
	JQnYn2Abm8FL9XYA3LrLMR4=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4jQg4m32nZznV75;
	Fri, 13 Nov 2026 09:43:04 +0800 (CST)
Received: from whupemk100010.china.huawei.com (unknown [7.152.184.41])
	by mail.maildlp.com (Postfix) with ESMTPS id 3C7CC40586;
	Fri, 13 Nov 2026 09:42:58 +0800 (CST)
Received: from [10.67.110.140] (10.67.110.140) by
 whupemk100010.china.huawei.com (7.152.184.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 13 Nov 2026 09:42:57 +0800
Message-ID: <46115a05-f659-4b47-80c4-c87d426ee105@huawei.com>
Date: Fri, 13 Nov 2026 09:42:55 +0800
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
Subject: Re: [PATCH] security: update lockdown_reasons[] reference
To: Baruch Siach <baruch@tkos.co.il>, Paul Moore <paul@paul-moore.com>, James
 Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
CC: <linux-security-module@vger.kernel.org>, Nicolas Bouchinet
	<nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>
References: <3283a389cc21862ab98eb891436568fc1d23b869.1794505077.git.baruch@tkos.co.il>
Content-Language: en-US
From: Cai Xinchen <caixinchen1@huawei.com>
In-Reply-To: <3283a389cc21862ab98eb891436568fc1d23b869.1794505077.git.baruch@tkos.co.il>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 whupemk100010.china.huawei.com (7.152.184.41)

Hello, Barush

lockdown_reasons[] is only used by the lockdown LSM after the audit data 
was removed from lsm_audit. I have sent a patch [1] to move 
lockdown_reasons back to security/lockdown/lockdown.c. Of course, the 
final decision will be made by the maintainers, whether to move it back 
to lockdown.c or keep it in security.h with only the comments modified.

[1] 
https://lore.kernel.org/all/20261110132818.2231593-6-caixinchen1@huawei.com/

Best regards.

Cai

On 11/13/2026 1:37 AM, Baruch Siach wrote:
> Commit 59438b46471ae6 ("security,lockdown,selinux: implement SELinux
> lockdown") moved lockdown_reasons[] from security/lockdown/lockdown.c to
> security/security.c. Update the documentation comment to match.
>
> Fixes: 59438b46471ae6 ("security,lockdown,selinux: implement SELinux lockdown")
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>   include/linux/security.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 40831fab5470..2782ee404f95 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -124,7 +124,7 @@ enum lsm_integrity_type {
>    * so.
>    *
>    * If you add to this, remember to extend lockdown_reasons in
> - * security/lockdown/lockdown.c.
> + * security/security.c.
>    */
>   enum lockdown_reason {
>   	LOCKDOWN_NONE,
