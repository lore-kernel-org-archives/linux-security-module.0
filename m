Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B6E1CBEB9
	for <linux-security-module@vger.kernel.org>; Thu, 21 Nov 2024 23:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732233232; cv=none; b=ahQZVgQ2vDLlaHfSclziqBwSk/gJebhNcl3wxUFBKfRafKiOMpXM9elC5d2d2hN2PFYrTLGMJ3qgXlcUJshGk5Fwt/DBdDiWu5XgMEcTZgMAwSIEUIHgRT55zt4trLG7ShRQq8XRFX8wBOfLQw5FCCRjapGH3/sKqUBFH9/llRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732233232; c=relaxed/simple;
	bh=j8HtVc2jXBan6FbqE277Xt6/3C49W0fYTo4fzxzIsb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZJI7ot8t10OaXmMX16uJ3LQNzT5z6Xz+3CPERjMkxP6f9A/Y3BGVIY9nOdILeOGIIai/8B2a3nurJGBoe7W9dDIH8BJUZ9Y11wcUPN5kgV65xAVsmTFMz6KpLcxwUQ0pn4lVLPOmO0m8YooaesDOMYjf0MVswcldAjosNP3OVXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Zepq4qXS; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Zepq4qXS"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-83ab21c26e5so52017839f.1
        for <linux-security-module@vger.kernel.org>; Thu, 21 Nov 2024 15:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1732233230; x=1732838030; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ljvFTLckgMBXyc/hCWJm3TmPmL56Vi1djSJCVHusK+0=;
        b=Zepq4qXS4bnFi4qOXhrW+Tdl6Bs9VtX8EKZEdpU8FGyHf0F/IwzVsKarg0m4q3LHCx
         rhFC2JhI5GH9RFGKa6xZWRv6Xqo9KV5LMenF7UcIodxREy6axtFlmWRzmrsa8CJ0xWWY
         q4fIhhe+FknbBqFgdtcEBOQfDpCQcP3zW9vk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732233230; x=1732838030;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ljvFTLckgMBXyc/hCWJm3TmPmL56Vi1djSJCVHusK+0=;
        b=iZSsBSnaRvNjAaYmAznPfS9KLKAyN+CRiS/+WhiBUS7XIFUkdyR8Uvea6s5d+GhP2K
         jKNkicYGyfWBBeeAOU0WlCeBoZkF/Q8RuJGo/TeLm5tplIaLFHtxhElktuG7pVE/U5YP
         92FRDEcsOGNBQUfEhQSKClzsCB7f+gDUgJ2miRo/2ELdELYWfv257JjHyZbibOAV9f6b
         6ApUs0MXdZGmlAZmkmQxBtZv2cYCGpHV0p9rUa0D1DL6UV1szFS61sUdjNXaIAS3u3Li
         CHu9nifyXxvcyULQm3Kut2+5LCfNAkXA2LkDAewPRY8rU5UeWX2jb+XuYojHppZEGsfc
         Upgw==
X-Forwarded-Encrypted: i=1; AJvYcCVCEc/dJKWaK+62sXImv5xUsjDpmUPTwOXCL5D0b6sKt0lwZgzQqrOISNph1NKO0CbQ3QPLGv++z/FCWOGtfcD6Kx77EQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG0vqRAJ01Pd+ITuf+egyQBLQDpF+5XGTxgU0UGI5vQjWenmhP
	zTPU/BujBZH+e3OetcZYw/mmuyzh+YUI27jrKXPAjODbhdVG9YfDU6dmdtW6Bbo=
X-Gm-Gg: ASbGnctmXlnuFSqkA66jKrlUFhKQ72ey2w9XyRgfNBEl7XJJ+bjCtLn7ExbpWQStiNl
	xZZykT+qKjd2SYtYHAcUoiJkYQd7ivReY3YIZ0fwYN9mPFySbAC8tzzO2x82kHS+qmgQ7mzQtWK
	8aT/ec9EDg0LhClizylQoEu7bE8judpPjxMbsO3go+oCTt7VN2uzaousMNTL+Ka9N1rDNWVsaqy
	kM+YzLUAkuv2+RD6f+vxcS4lm85bLfE2BZng8U0Cw6gWN0CieH+q3JQmt2HHw==
X-Google-Smtp-Source: AGHT+IF96MGQRTP0elvAz6sBTHwpiq8D9SyOiWFimZgfz4bG069DfMpMT/a7a5sO+nbaJTtWXJBa8g==
X-Received: by 2002:a05:6602:6405:b0:837:7e21:1688 with SMTP id ca18e2360f4ac-83ecdcf315cmr96081939f.11.1732233230456;
        Thu, 21 Nov 2024 15:53:50 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e1cfe19f0fsm359847173.12.2024.11.21.15.53.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 15:53:49 -0800 (PST)
Message-ID: <39e8f416-d136-4307-989a-361bf729e688@linuxfoundation.org>
Date: Thu, 21 Nov 2024 16:53:48 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2 v2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
To: Christoph Hellwig <hch@lst.de>, Theodore Ts'o <tytso@mit.edu>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
 Michal Hocko <mhocko@suse.com>, Dave Chinner <david@fromorbit.com>,
 Andrew Morton <akpm@linux-foundation.org>, Yafang Shao
 <laoar.shao@gmail.com>, jack@suse.cz, Christian Brauner
 <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-bcachefs@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 "conduct@kernel.org" <conduct@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <citv2v6f33hoidq75xd2spaqxf7nl5wbmmzma4wgmrwpoqidhj@k453tmq7vdrk>
 <22a3da3d-6bca-48c6-a36f-382feb999374@linuxfoundation.org>
 <vvulqfvftctokjzy3ookgmx2ja73uuekvby3xcc2quvptudw7e@7qj4gyaw2zfo>
 <71b51954-15ba-4e73-baea-584463d43a5c@linuxfoundation.org>
 <cl6nyxgqccx7xfmrohy56h3k5gnvtdin5azgscrsclkp6c3ko7@hg6wt2zdqkd3>
 <9efc2edf-c6d6-494d-b1bf-64883298150a@linuxfoundation.org>
 <be7f4c32-413e-4154-abe3-8b87047b5faa@linuxfoundation.org>
 <nu6cezr5ilc6vm65l33hrsz5tyjg5yu6n22tteqvx6fewjxqgq@biklf3aqlook>
 <v2ur4jcqvjc4cqdbllij5gh6inlsxp3vmyswyhhjiv6m6nerxq@mrekyulqghv2>
 <20241120234759.GA3707860@mit.edu> <20241121042558.GA20176@lst.de>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241121042558.GA20176@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/20/24 21:25, Christoph Hellwig wrote:
> On Wed, Nov 20, 2024 at 03:47:59PM -0800, Theodore Ts'o wrote:
>> On Wed, Nov 20, 2024 at 05:55:03PM -0500, Kent Overstreet wrote:
>>> Shuah, would you be willing to entertain the notion of modifying your...
>>
>> Kent, I'd like to gently remind you that Shuah is not speaking in her
>> personal capacity, but as a representative of the Code of Conduct
>> Committee[1], as she has noted in her signature.  The Code of Conduct
>> Committee is appointed by, and reports to, the TAB[2], which is an
>> elected body composed of kernel developers and maintainers.
> 
> FYI, without taking any stance on the issue under debate here, I find the
> language used by Shuah on behalf of the Code of Conduct committee
> extremely patronising and passive aggressive.  This might be because I
> do not have an American academic class background, but I would suggest
> that the code of conduct committee should educate itself about
> communicating without projecting this implicit cultural and class bias
> so blatantly.

I tend to use formal style when I speak on behalf of the Code of Conduct
committee. I would label it as very formal bordering on pedantic.
  
Would you prefer less formal style in the CoC communication?

I am open to educating myself.

thanks,
-- Shuah


