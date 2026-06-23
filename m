Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3FF3BCD05
	for <linux-security-module@vger.kernel.org>; Tue, 23 Jun 2026 07:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782199710; cv=none; b=M3fbd2Z+ceLSonclESaN3sZY+KbA4cl3KTgX+M/b3qXu4NHZ3ggHfD0DSZurXXxqvVYHU1UbT58p5KKbUg/IQkacMy8oCpKeXIa95Ycwo/HTY0kK1Q1Mua4+NyStz68azyRacQihLc3khWKWEWBW0is7Uyy9kEPxt2Ipmj/9uz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782199710; c=relaxed/simple;
	bh=8lFFiIdUx3EtUM+OeeCp8luriWolvgzZuwhEAxmnv2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oxjqWYNLtndUYitlY7MRZ9PWedCVjIb4bdpndlNX8m5TNdZQmEzhSRXRtCu8pMInCTyrRZBdCsd7lEV0Klea6s4w9tJEANeXMLmZVkEy+WMUFQtXntVXgQHNTS+aM/5h4yfljON7f5Tf3thFBk714Qvvg+DXMp+5Q/BOk4is40M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=UoQSDQ2i; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="UoQSDQ2i"
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3FAF73F135
	for <linux-security-module@vger.kernel.org>; Tue, 23 Jun 2026 07:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1782199705;
	bh=bkRIte71CXccE+Op+7B5pNVTpu2UqEKWzUWu4L5OYWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=UoQSDQ2i1bR+xkIbOeSojXZgNhFsmeYyMAA/YIEqBDsfRVvn5dQkzfBh7E/198yUa
	 OgiVI175wJc3LLil4iRDvtwBymJa1umo8m4VblaSwfo8eA4RURzvsPBjGFABqj0YDf
	 9vM2jQ4x5EKb7L7NZAHUE6Hj0NXfnLIPwQxREa9bUjO4uNYgg/Z/94UbAkapx70eYI
	 beqFAxs6MZZagmXDIYt2DPTVbtA+xzMFJQqvruRd6+u6JyV9zr1O3N7y7igAv1zJK3
	 UGrOTSjDcidZUviQ1GzTZwehQB0iyMKxcRW3g6Yy7rpU72lSZ+1mrspZkKd1r7dOqr
	 M5tDHm0ln4cBTccIL/ZbHfm8EduEN9TD7M1tJ306ZTKj7bRALpcLlLTAZ6AG3P99T6
	 a7NLvjwSNL0bG9OhVyG+dbpOtpcIB0ZMiGvi7dZEFztqHDcLJxJ34ZQTCDilfZNh+I
	 BjEhd4tG5ijlt2PEux8+Yaao1GyHNh1PvAWqBRtCLYESkDa2EYwUz0qg2CL8gWk/nU
	 ULwzgHp/M/oD9pGOqzkE1mEtxZr0ivIDlzdcCxqykn2Z8dxG7l5qjBtE98b3/FZOQy
	 sUl26oS6vYV56IlKezSXI4uOLKCUFREZxEYLAGuwHCXmKdpvdxWH8aWQgy6czQjJXV
	 xaecIeTQDHi4rtHgmGLbPvfA=
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2c10cd7df22so94075825ad.2
        for <linux-security-module@vger.kernel.org>; Tue, 23 Jun 2026 00:28:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782199704; x=1782804504;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bkRIte71CXccE+Op+7B5pNVTpu2UqEKWzUWu4L5OYWk=;
        b=ZF+2480i66rv9fcy6PbHcVvEu+fVTI9TTrb8UyAkv8LNoM1hv9TzUJBrz3qeO5GKQQ
         gP8z60pjSonNQkQLrJWmQad05zrLdTCsC/pXVyXg8SdWGWQnVDzpa4DH/KsoJBqHwHyj
         0x+SNk0ZGbCfVqO28ikmWJrD9weXovKZK2D+FeF56Jpi+s0Dacs4c1vdZort5J6HXO9h
         WjDnCXSFv/GbbqcLJVL8d68wdyEl0aCp78F/2Jsas1l1PU7g/SBREa/NWDMgpVfA+ALb
         9UiW0y50ZYOTMaJHC2XoL+JlLiBB0zhgn+Purdw7Ttf3h7AlU4aHQILm8HNg7ODqvXOD
         ifsQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq9QlDEiBNwRRntrT0HYL+euiLh1Dryi4YnLDMMsZSrGBWkzjNiUkqDbKFnNFcIjhjoNjq4X0K+PxvF1VXYn9DpjM7kBsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ8yGrGTkIwopb+o3+bQT7tSeBPK2kvmyuej0W1fTP8OjY6dXv
	AyEri+KK2ZO+n1tsbWC8DM2vmFl06VndYpodCF2NfoDOrVzbRsNR4RAsB2NcrN8UGr7VsJXTwtt
	8Yp8E5AXk9hl/FjgUm0VxhQS34zP8b9KMNtF74EH6TdgAsh5b+KvmyazW8lmJGBGTJGwdE6b/qB
	RjbHeP7MVUcz9ChkU2vg==
X-Gm-Gg: AfdE7cmXGp3lrJlTz9mDs4dImq7T2URUIkJEHh+KXhCviBhi6WuHArtC2aZocBP+cl3
	MrYJ2tQQ9TUe3P2pm2JMF91F+fhTyJeT3dMsQQcy7/ROh7UvTlHZOUwV/zw0NFApgBdYgq5JYXO
	s7LB6s78Hkspjz9imNOW4QlPP3xAlKi0jOu1tlk1QwZMEChDw7e/h4jFjJkOmVNEN5lAZb6NNKt
	egUSxysQ8JyayJZX7TtKR3RI+10DW9NriqsfiKYSEN8ACS3gwBwt7lbNUOqGUFoocnfqappYiCa
	g1J40KffFLmlxehU9XqmEMbhaS1/WbzZg4HejM0iEVZuER9An7yFSm1T9NUhYlwMALeZ2cTjmQo
	ALy2qkTZq/0GYm77BIDuxW3p05Q==
X-Received: by 2002:a17:903:1248:b0:2c1:42d2:40a with SMTP id d9443c01a7336-2c718cc902bmr201048115ad.9.1782199703885;
        Tue, 23 Jun 2026 00:28:23 -0700 (PDT)
X-Received: by 2002:a17:903:1248:b0:2c1:42d2:40a with SMTP id d9443c01a7336-2c718cc902bmr201047875ad.9.1782199703540;
        Tue, 23 Jun 2026 00:28:23 -0700 (PDT)
Received: from [192.168.192.71] ([50.47.147.90])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2c743bfdad0sm119516585ad.63.2026.06.23.00.28.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 00:28:23 -0700 (PDT)
Message-ID: <76b0ab87-1137-4054-b7a4-98ac61891c36@canonical.com>
Date: Tue, 23 Jun 2026 00:28:21 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] apparmor: mv get_loaddata_common_ref() into
 CONFIG_SECURITY_APPARMOR_EXPORT_BINARY block
To: yaolu@kylinos.cn, paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com
Cc: apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, k2ci <kernel-bot@kylinos.cn>
References: <20260623015049.41392-1-yaolu@kylinos.cn>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20260623015049.41392-1-yaolu@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/22/26 18:50, yaolu@kylinos.cn wrote:
> From: Lu Yao <yaolu@kylinos.cn>
> 
> When SECURITY_APPARMOR_EXPORT_BINARY is not set, the compiler emits an
> unused-function warning which is promoted to an error with -Werror:
>    security/apparmor/apparmorfs.c:177:28: error: ‘get_loaddata_common_ref’ defined but not used [-Werror=unused-function]
> 
> Move the function into the #ifdef block to match its only call site,
> silencing the warning.
> 
> Fixes: 8e135b8aee5a ("apparmor: fix race between freeing data and fs accessing it")
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: Lu Yao <yaolu@kylinos.cn>

the patch is fine but this was already fixed by

d62d9bfe050f4 security/apparmor/apparmorfs.c: conditionally compile get_loaddata_common_ref()

that is queued up in apparmor-next, that was just adding a simple ifdef wrapper, if you want
to rework/rebase your patch to move the fn, and drop the extra ifdef, I have no objections
to pulling it in


> ---
>   security/apparmor/apparmorfs.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
> index ededaf46f3ca..f762b101d682 100644
> --- a/security/apparmor/apparmorfs.c
> +++ b/security/apparmor/apparmorfs.c
> @@ -174,14 +174,6 @@ static struct aa_proxy *get_proxy_common_ref(struct aa_common_ref *ref)
>   	return NULL;
>   }
>   
> -static struct aa_loaddata *get_loaddata_common_ref(struct aa_common_ref *ref)
> -{
> -	if (ref)
> -		return aa_get_i_loaddata(container_of(ref, struct aa_loaddata,
> -						      count));
> -	return NULL;
> -}
> -
>   static void aa_put_common_ref(struct aa_common_ref *ref)
>   {
>   	if (!ref)
> @@ -1318,6 +1310,14 @@ static const struct file_operations seq_rawdata_ ##NAME ##_fops = {	      \
>   	.release	= seq_rawdata_release,				      \
>   }									      \
>   
> +static struct aa_loaddata *get_loaddata_common_ref(struct aa_common_ref *ref)
> +{
> +	if (ref)
> +		return aa_get_i_loaddata(container_of(ref, struct aa_loaddata,
> +						      count));
> +	return NULL;
> +}
> +
>   static int seq_rawdata_open(struct inode *inode, struct file *file,
>   			    int (*show)(struct seq_file *, void *))
>   {

