Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7E531AA87
	for <linux-security-module@vger.kernel.org>; Tue, 21 Jul 2026 01:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784598069; cv=none; b=jiUUvdioOI9l46vxute2zHW+uNciED7x6VTM+NbhXk/+tnvZruCprJK4j9W4bR+/Tzl4L7kxpD/u7xAEIEB/xSh3P3R8oOm6pAEkJ4cNmod1/h7Xciy/myRI0bN/X+S4PIq6MB3ALbQsJ5aHpkVpeiwDkMenBdlRFv0aZ+L9n8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784598069; c=relaxed/simple;
	bh=uABiYXMcIUesxHIxv7pNBOEDj1zRcFHVpqq6xQewtq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=je1ing6aXPHZ5gbVa0zWn3YZ3678be4yoGOBystHhWatWy8ggL0ptUYwJXvwzX+uj2Ac772CgoyL+x/zk+hvoA+fhCiQE/vLyqsJDJhJkj/V10Q1N/4VVgRyCMGgAbqURf1O0MesJb+k9oFVdQPehlcj9hHuYM50BYLCIAzPryU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=Wa/d7AEl; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="Wa/d7AEl"
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 550383F5EA
	for <linux-security-module@vger.kernel.org>; Tue, 21 Jul 2026 01:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1784598064;
	bh=Zwcu8f1J3utT2OxFomot25YUojHwKnfesARp2rbCN00=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type;
	b=Wa/d7AElrSBN1W1Qu/tSZLThdiThKD9jInkAK8ubTkdaUnXmg4Ehm3RYN2r9L1r0e
	 UZIKgUv2yt+yafEmMUDDWhwYW1XsuqVUho2rRymScLxIoxeXcBExGTcrtEBCCfEaiQ
	 kpbMyK4KMwKP7QxMz/LGMY0uYEMvlUmJFjgR4rir/wzmCgNgCzSqrSYRYHojohlnoL
	 +qKF9h6lYOdYz7dj3xtgTihn+Y1BoPjW5YqkAjQY1hUVN+BXXpj84kpBl2HzKEV3Xv
	 9VKy6Un6uLzh4Tu9S7GwpOqqW12BZjg0gSXRE49hXM+Bd9493Hb9oJDShl6HODGI/v
	 T/uT6fpC9nO7zkW63EkFnZjkW6xapnWy0wQJI+XHBXRjT6CLxK4ZZt6N4Vq2I0QSrg
	 J5d/x0jqqj14/9hGHQhGzK6f1E7WxBbIEWzQjQW9YBikcGHsfujqZ0ltZdUbuxbtdL
	 62f2RtUn4FR1xqakPMWV7m+4pHbYvj55J7SP8PjInkeKOZvpXox57UgIc/HzFNRWAs
	 mrmAa40pvDKWVQyNWFij1rfeGiV4dg4bHtBikmjML9cCEJPl+lARwQmXBmfpR+4JcU
	 9Jnb/xBtGhHdKF+8rYn6Rd29caUgwBaT65luB7NwnsrPWvp5Wwy3x3j6cBhamelahf
	 qY2SE9X6BA9nCk5CIWBJZrBM=
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cf1c86963bso37883955ad.0
        for <linux-security-module@vger.kernel.org>; Mon, 20 Jul 2026 18:41:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784598063; x=1785202863;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:from:content-language:references:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Zwcu8f1J3utT2OxFomot25YUojHwKnfesARp2rbCN00=;
        b=Ifd+pDH/JjqFC4kEhVM7G1vmGkZYLUveWocIH1IAcFTILo6BRJx50KS0T/Pr4g33yu
         Xd33X2qB634j9n6M8tQudmA6Rm4HmJ2YDSresVpOoJBz5wIQLQNuJglPqkBS0FS5SQfS
         IsXPrrK1Gedo+gVcAscvWaChLLZHSIV7PoSjujRePor+8YcOhZjIwOfWLx2evl/5EEvi
         LgbzV+NE2vg/M060H+e2X0MqfAMGwENSodgiys7Guoa8xbzcRmaMvYMQ6J5/YwNXLBXl
         4+sKw76sohI8PdxBjtgFz9Hbcj0VU1/xsn8A+W31vaoVNrBaK93QB3kalCJBxv+Cy++4
         BZng==
X-Forwarded-Encrypted: i=1; AHgh+RoUyYxk+608MmsuJmBArkJw00LCF1MBidkQwoHHF3CF5HgiQlXhBs/h88pNHhAwEV0h1KbsMGSNpO3I8DAcC6VrNjC550Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPe24P7KBp0XO3ZVQ8VPn4fzUFTe3gJ/dCA5dorbvPOq5XFZb+
	mVyFJbpgtmtuKZsWi4WIKGDTirCOAF2h17eH4dTnE/LzALuhfCKX+1n83HqUhqNcTTrw/k4oUZt
	GVCzgXc/sE2tP+ZBwjQv2COPR/NxS7UgHj4uTGOqm+tqKCfjl/gP+gn0F5S+hAqhnMIyB48qtcq
	+EqxDvuQQH+06K9DrfkDvBkpKURw==
X-Gm-Gg: AR+sD130sLoFBffWGfuVi5vTwxQxc9fNThKCma1LJT6aHOd2/fmMwRjncDfZhx/Na3V
	+W6x+XywLqe8V8MTlWUUddOMt6tzgrYlT3xBeaUhOs0930pS9J4StnAn5VfUyCJpwDip0G8qjA1
	WPAljmaZN9YHudPwWPR6QBIvD7irv21UFOprKA2hqtEaGATtYgZWc28uvFA3Q+66E9L8iPaXcmu
	l2BFRPxBQTuOCDvZgFodPh1GBxQtZ99oIkOSNHyVMrMfX+sLNHBLjiFa+LEDN5cvGui8vrb8H9J
	eIEQvX6IYynmKYGXqBPiEZxbuVAFcVtbgdR/sJ8AQWGgfculzg30R+3FHuKVpLrzzrryhoBDTOz
	/c/pQAKixe6NNQiE=
X-Received: by 2002:a17:903:2449:b0:2cc:80d6:b72 with SMTP id d9443c01a7336-2cf34a30f0emr159093925ad.20.1784598062844;
        Mon, 20 Jul 2026 18:41:02 -0700 (PDT)
X-Received: by 2002:a17:903:2449:b0:2cc:80d6:b72 with SMTP id d9443c01a7336-2cf34a30f0emr159093775ad.20.1784598062408;
        Mon, 20 Jul 2026 18:41:02 -0700 (PDT)
Received: from [192.168.192.71] ([50.47.147.90])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2cf3471eb94sm67902195ad.62.2026.07.20.18.41.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 18:41:01 -0700 (PDT)
Message-ID: <326a6ffc-8cb1-4842-8bf0-74dd58bfdf08@canonical.com>
Date: Mon, 20 Jul 2026 18:41:00 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] apparmor: leverage audit_log_n_untrustedstring() when
 possible
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org
References: <20260717215254.383183-2-paul@paul-moore.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20260717215254.383183-2-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/17/26 14:52, Paul Moore wrote:
> Make use of the audit_log_n_untrustedstring() function to simplify the
> code in aa_label_xaudit().
> 
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Acked-by: John Johansen <john.johansen@canonical.com>

unless you object I will pull this into the apparmor tree


> ---
>   security/apparmor/label.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/security/apparmor/label.c b/security/apparmor/label.c
> index 3fd384d8c41a..a165cadf8249 100644
> --- a/security/apparmor/label.c
> +++ b/security/apparmor/label.c
> @@ -1743,10 +1743,7 @@ void aa_label_xaudit(struct audit_buffer *ab, struct aa_ns *ns,
>   		str = (char *) label->hname;
>   		len = strlen(str);
>   	}
> -	if (audit_string_contains_control(str, len))
> -		audit_log_n_hex(ab, str, len);
> -	else
> -		audit_log_n_string(ab, str, len);
> +	audit_log_n_untrustedstring(ab, str, len);
>   
>   	kfree(name);
>   }

