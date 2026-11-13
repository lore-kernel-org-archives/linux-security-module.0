Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.224
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794534623;
	b=bNnNj50cn7TtoLt1qGFqvCs683e9DoJC/BJulX1GYe004UphUJxFDWYcMVbpKxQTqPXn
	 oJLAl7mT++uFp55kKCzJXEcwuRwa9ZileOqylo53R4fx4dF8kyrA4gBYnKavMRtGdLLN8
	 WhLHN9oxeF7wcGyz5dQ2vrOVjjT9Q1LavOLDo4jlQmPiRd9+KDoJ79lS0OU35Bz0FDL1U
	 fcfczXv6hFYheNbXFXrOoBXRQf8o1qB/o+4ske/VnOGJ4twSUgjumdctnn1jwql7FOIvF
	 zaeMEDmvO7P+Jje/qlUl88C//3OK1NpTRhSWgs99rHRZ3Vp0pOxXRYFMYPvOyh6WCCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794534623;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=XaurxA0UgVcsFaq6j5TgjSCRQ4pu2slV4Dl26Ek+ouo=;
	b=vqKd1jMTvuoOBu5Zdqqjme9dz7FcGrr2OgJqy8ZBfuaw7Ha0iMB9R88w6gZGU98T7nAw
	 BPVWKxOc2QA2/03EG6Pbhwqw7/M+a+73EY6gP2/N4CFiqOCEeU7Y2yAbGB6h9zo38RVsI
	 NHTg6U4d0U414Ncd2q7vzAJUXGQpq5+u3xUdNHpV7e5LIiYSzsltnl3ThHm1Q8BpAFl3U
	 3CbcBLs0CuC54grL1ztFg7TLmvf1gN3wBGASZSSX5GUXQKHe5uGFYNmgjD9rryGC/m4Nz
	 7jxH63xyCd5Q11LkBVaMi31BZLOh7JKmgolxuuA6MObjSf6RFKY5uUGoF5jrbPMpTVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=eMvDXC1E;
	arc=none smtp.remote-ip=113.46.200.224
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742AD606A31C
	for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 01:50:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 742AD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=eMvDXC1E
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=XaurxA0UgVcsFaq6j5TgjSCRQ4pu2slV4Dl26Ek+ouo=;
	b=eMvDXC1ENEYmEXdKYHs05BCb/bWn1JigpK/MUGZFnpG3w/UM3KVBZXZ5tEfhHTq/HI0EA1Qbe
	jTWUj5tjRztvZ8Wu81OivwcswzNxwa+djXHiDSxv3bXGCFspT7UzcC1JJLdGx+KnEJQgsKGJ7Tu
	VuYuT4JC1MLDLSCLkD6Y28E=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4jQgDq0R37z1cySb;
	Fri, 13 Nov 2026 09:50:03 +0800 (CST)
Received: from kwepemk300018.china.huawei.com (unknown [7.202.194.246])
	by mail.maildlp.com (Postfix) with ESMTPS id 95D3240578;
	Fri, 13 Nov 2026 09:50:19 +0800 (CST)
Received: from [10.34.206.67] (10.34.206.67) by kwepemk300018.china.huawei.com
 (7.202.194.246) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 13 Nov
 2026 09:50:19 +0800
Message-ID: <9923142e-8775-4a5b-b016-7a2a9b743198@huawei.com>
Date: Fri, 13 Nov 2026 09:50:18 +0800
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
	<nicolas.bouchinet@oss.cyber.gouv.fr>
References: <3283a389cc21862ab98eb891436568fc1d23b869.1794505077.git.baruch@tkos.co.il>
From: Xiu Jianfeng <xiujianfeng@huawei.com>
In-Reply-To: <3283a389cc21862ab98eb891436568fc1d23b869.1794505077.git.baruch@tkos.co.il>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk300018.china.huawei.com (7.202.194.246)

On 11/13/2026 1:37 AM, Baruch Siach wrote:
> Commit 59438b46471ae6 ("security,lockdown,selinux: implement SELinux
> lockdown") moved lockdown_reasons[] from security/lockdown/lockdown.c to
> security/security.c. Update the documentation comment to match.

Hi Baruch,

Thanks for the patch.

However, Cai already has a patch under review that moves
lockdown_reasons[] back to security/lockdown/lockdown.c, and once it
gets merged, this issue will no longer exist.

You can check the discussion/patch here:
https://lore.kernel.org/all/20261110132818.2231593-6-caixinchen1@huawei.com/

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

