Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB151D63E4
	for <linux-security-module@vger.kernel.org>; Thu, 27 Nov 2025 01:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764207186; cv=none; b=DGteOqqYTDOIGDvE2I2/XJRr0mhVQ0qVOI6bnr9Ajawmtp/sCqgi6oHD9fPOfJ4JLGAFk+rieyuUy8gNkHoqaSwhL1Ak46PIoIOxdoGa8kcUuRIoqBnpzYRNgiWDT5qG/EQfU6ay+gtgFno1kHQchhTgUGsGd7aT4KsTi4SouxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764207186; c=relaxed/simple;
	bh=zG7eICmpLh1P0r32EvKYSVB1di/mnaIvX7NKk/VKS5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dzREQorIfF73jsaBoJ7yp6oqiLUxYNXaxvRAYdBJW7sRQCPeWyx8P1nUGnPl7n8lROiWi8tM/M4iJOMcDch0cvnWfKUeJVWvY4GKgCW7SnKU/Zy3a73+kTSRj7G0IE82Q9Vf4st4IlE5c0hv2B25m4MjrtxxxRAY6JLAqeTusRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=KSznulbO; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="KSznulbO"
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 14C213FB7C
	for <linux-security-module@vger.kernel.org>; Thu, 27 Nov 2025 01:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1764207180;
	bh=bHVUgP8TVtYbK/RH59jYqEOFLp2rfeRbE8F3eHfE2h8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=KSznulbO5R7CwtFn1aVVyZ+zM7sLofTkFM9Myb9JIpUwKooyUKLYieBUasZ2Ab7mp
	 UTmfKWKg0Hx5ZMNHG5OU6MIynkbfccW2IV6hjvVdRzXFRVVEGs8MFomuhbPIXxQdLq
	 ykEjuARYZxeZ8A+sC0do10w/gG9KLxiBK0XI2/02CncDn0m0WEZemUx57fDpD8Z45r
	 HiwTXk+W6l4DIb/0X6KUd7RUDD/em2sILeHlYSJHF0KcK5npGTJ8Q/t41SOXyowdOF
	 nUOLwA81oceAMePyGOTjs36xlXqkNaRb/YV0ZuZprIGIhKnJi1voXQlzRrCf1ERe/m
	 vLRUfvAHbQ5XqoJ17DkJAsPKuz5kQfB1PYQOZx9XxnXGPiex6g9utjG+4zPl7bpe4H
	 CFrbEPFZ7aX+E+vr6l6wqoZBB/Op3pk0kPbdIjWgMhLZ/m760eXzBTUckJ6C1IZKbK
	 TTmvtDjM7R7JWWDAW5tviKWUlKi2ZGaEa5EqF+H7u8MPgZCIr1jjZJP7ZgY0Bbv3wT
	 OCGwBAiBYplD9GfG5pVUUA1HxTAW+JMjR3zy9E0HpJ/+GkmRsWB6R5mWDOh9nPsTXI
	 0VGAa71wUCtgdYIln7ZTo9HrTmzTke62oYmkEqzFLI6vkvCqf04yUkUhjWNiR5Gse+
	 2yr/U/lB1NlOQ8iSVysv48VI=
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-bbcf3bd4c8fso235645a12.0
        for <linux-security-module@vger.kernel.org>; Wed, 26 Nov 2025 17:33:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764207178; x=1764811978;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bHVUgP8TVtYbK/RH59jYqEOFLp2rfeRbE8F3eHfE2h8=;
        b=XjOEMfacpZqCKQqm2gtOY3G851Fe/L5uVqMiwZ0sZBVWL2r1ybB0E8/MGXTGadZpbu
         SeXHAuTQwvI67tn5k5yruY9NuFmQygbp68bhSs8X+G7gW6SsW7tmj+awz52jQ3OeDMXz
         U+e8OSe1SgdP6IKz5XvNwOYway1VLzoGbK2RWtCBiFBBy62l1d5XAD8lhJS/PkweLmGj
         NLYF7jvgVr9BrBGtl8aKGLaqDwQGm+Abb1qDwQyDqnMoY+3ncwXzYc8SBJKOqPPk6ed2
         67+YuiK8mFHSnlpRXl1i75MNPiup/eX1FEn7h4cTIZ4fzvgOrzOkkdLb5uVT/+xhnZHx
         KgFA==
X-Forwarded-Encrypted: i=1; AJvYcCU90phLxyTF97JPzL5+xmvGgnwxPggEtinSpaMZfleu6X5SUjr3xLVQnbJhT8BMu2f9nJ0VGbBdQJ40c78TMOq6C2AUrp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCA56aDWwq6CDepmDJXFu5JrnWf+3ZE4A/uqiX4z6F76LIxVnP
	c+RXmMBVV06tjXBjZ4akbBbtbTqV2qGUd+Xbvh4vlKgGuncgg/nthKVBHRTzrPKzhQGJjVirdIj
	ZifrzAgWg7jcLDJbQsX/CeI78cVlUap/9TfrQuAB+CgDYMRVKnMnjpi/Y1ofgK6pYUikRKwqxlM
	sKnmOKLyMraXGMm80Xb3jED4/DLdmA
X-Gm-Gg: ASbGncto+Yf8hyxlrqwjIBlb0Q+Qxk6r5SFsHapLYBxbbzWDG/wnc61kuiKZFptbLFw
	3Hh3xie5ovT9SwsccogVSjrV14+XzjstmOG7BOoiKzPziQrBrU4FexvN2Zq38r5Yo/JI9OF3RLZ
	z7m1o7PgbGlgKofQyOisBPwIOLOPp+2j+NTVtgxswLhG0DA5oF+IG1HwdbhYJb9wjZ6lFIycv+H
	Wr74OGxT1RTt9lmVOkZBK81ZWP16lL47UjWh2K5xU2M53PiWF0VcM0NnXTSXRWYR8IMW2/qOw3U
	/IFwNX1HVmt8ZRcMRuE1DUGwT12zwRClYiWjXslf9+bfE7dgpU02KB/mSmtzl6OjzXEMrBlLgiF
	nHKN2Xn0dzVLzBW6d1+aeaoAR
X-Received: by 2002:a05:6a20:734a:b0:348:b6af:5023 with SMTP id adf61e73a8af0-3613e3c4f74mr32471019637.10.1764207178381;
        Wed, 26 Nov 2025 17:32:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9poROxMcqJmE/ZSFgYiynf+n9P/aaj4L9EtwLq9gxjSC4Men5EwCCzbfLvhQxV0VS86hawg==
X-Received: by 2002:a05:6a20:734a:b0:348:b6af:5023 with SMTP id adf61e73a8af0-3613e3c4f74mr32470984637.10.1764207177997;
        Wed, 26 Nov 2025 17:32:57 -0800 (PST)
Received: from [192.168.192.85] ([50.47.129.42])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-be509d58e47sm86462a12.31.2025.11.26.17.32.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 17:32:57 -0800 (PST)
Message-ID: <1da23c89-dc2c-41cb-8260-098deb8ae917@canonical.com>
Date: Wed, 26 Nov 2025 17:32:56 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] apparmor: Replace deprecated strcpy with memcpy in
 gen_symlink_name
To: Thorsten Blum <thorsten.blum@linux.dev>, Paul Moore
 <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>
Cc: apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251126165701.97158-2-thorsten.blum@linux.dev>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20251126165701.97158-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/26/25 08:57, Thorsten Blum wrote:
> strcpy() is deprecated; use memcpy() instead. Unlike strcpy(), memcpy()
> does not copy the NUL terminator from the source string, which would be
> overwritten anyway on every iteration when using strcpy(). snprintf()
> then ensures that 'char *s' is NUL-terminated.
> 
> Replace the hard-coded path length to remove the magic number 6, and add
> a comment explaining the extra 11 bytes.
> 
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

hey Thorsten,

sorry I have actually pulled these in, and tested them. I didn't send out
the acks yet because I have another patch that I was waiting on a proper
signed-off-by: on.

I am going to have to pull that one so I can push. I'll add acks now but
the push isn't going to happen for a few hours.

Acked-by: John Johansen <john.johansen@canonical.com>

>   security/apparmor/apparmorfs.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
> index 391a586d0557..4b2752200ce2 100644
> --- a/security/apparmor/apparmorfs.c
> +++ b/security/apparmor/apparmorfs.c
> @@ -1602,16 +1602,20 @@ static char *gen_symlink_name(int depth, const char *dirname, const char *fname)
>   {
>   	char *buffer, *s;
>   	int error;
> -	int size = depth * 6 + strlen(dirname) + strlen(fname) + 11;
> +	const char *path = "../../";
> +	size_t path_len = strlen(path);
> +	int size;
>   
> +	/* Extra 11 bytes: "raw_data" (9) + two slashes "//" (2) */
> +	size = depth * path_len + strlen(dirname) + strlen(fname) + 11;
>   	s = buffer = kmalloc(size, GFP_KERNEL);
>   	if (!buffer)
>   		return ERR_PTR(-ENOMEM);
>   
>   	for (; depth > 0; depth--) {
> -		strcpy(s, "../../");
> -		s += 6;
> -		size -= 6;
> +		memcpy(s, path, path_len);
> +		s += path_len;
> +		size -= path_len;
>   	}
>   
>   	error = snprintf(s, size, "raw_data/%s/%s", dirname, fname);


