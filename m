Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F89838886F
	for <linux-security-module@vger.kernel.org>; Sat, 23 May 2026 12:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779540296; cv=none; b=HmLG0Cu9Hu5XwHTiXizCXfCSvFeQ59Qo/hsq3JC6ARuSQl2tWHro+QEEGZALth9DS3FshlKTVBj8dsdF6bfP5IlRpWOkTU/N7uNiiHtuDj6Oufs5eZWkXEJaBaVsvC/RmdPbWW0KeFOdkzFqotSYF6+jyGFingHOdkwxCwK0fQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779540296; c=relaxed/simple;
	bh=mxMjcqPsrTTHQ41OFE/mqjg2Xv7NZ6Tz5jpr8xsDtwM=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=tqH7KOTZOB0HFOyL1kFKu6w2Q2yQ1QYcpzuxYuMOxpg3zQAt1e+hfGjGnmTUIWn7ZzF7e24jxedbvEQIvUZvMi1dfkeax296jR9XXiPZWEoPf7XSE9BQJyymeaHgxh4DkKAG+9Gn4aYTeqV2fUlyZKX2CgQMvWbvWnnRwo4f7P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=WWP7LJYw; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WWP7LJYw"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-914bf787977so105076885a.2
        for <linux-security-module@vger.kernel.org>; Sat, 23 May 2026 05:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1779540294; x=1780145094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0LksLbhtazVmpD7Ii2kkUdPDpZ2WDbYazrrJ3Trqh+M=;
        b=WWP7LJYwJLkHGyI/20tlTFM59kH3jAOQECs0Qv0heuirGQbM0CiZOOyDCS+EkisPDV
         QwYZyGmA6klU5rishyVZ6OUNa3EVzbcZQysThjp0IuKcWbbUIOsAQ0Ze8UpJynsOohJp
         7Hba9O1r2WLGs+ZJvt4pgrgDx7pLoL0ntjdB3lJ6fKriDHm39o3K5isj+OFrKWP3r8CF
         jDjq4JTGqCuVD929ZiB68wK4xFrQ60HM2c46IC75kuEvqWTD2nMuO2h8hyUEcKDoafSC
         EH3+rA3ht3OEi0jIWzi0EPeaut32EOgWBveVAcOCGeRbF1b/p3KVf15euJHNjSoDphu6
         nD4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779540294; x=1780145094;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0LksLbhtazVmpD7Ii2kkUdPDpZ2WDbYazrrJ3Trqh+M=;
        b=S27WpjM9jc0IDjVoNaR2VQOL38C3zh9U3xOvfOLpxoTtWAG8Zm6ee9pZHSOvARVQFh
         9UtlubHLQWmx9Uzs6IxzxhfJp7mMbd7Rm13lV9TvswD0dgH1ypp9SvaJTGx0/Lm9f1vk
         pEELdobMLTeZccfpl+yExAsFxxA9gxnwS1bJ3O6ie6yGANx9jhuxKJcttS8edr6y+hAq
         cW2g46Y6ZJm6IbOWst0cFAJtIArxHarkGqAKIqVlXadvPgMTtupf/u2pIcjwqpjeUCwd
         W7IoQoMH458z9xmRkckxWfJU10yIS+ydVXwf9ChiIrDpCnYxWDBKEXsgmSf3OGABYmGo
         jUhQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Xu1IK9CefM3E6Fb3ank+XZiCL3MhnRvWqty6TsIqQUPiKuX12fxbAxkl9PqIst+gyvLQUMvvw1GXhkt/XbxAI5QcdU9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKMlvZqrNYcRaHme1O+ovKtbxW5/D9SuyU6QJa35fKv+tIyZ0D
	A4LDcVC4MAkV0czATnusSFeuNXSVyRwx0aGNf48JpyVXxsb+Xp8mFeAis6bngjjlAg==
X-Gm-Gg: Acq92OHVuxzsuNKXNJC2NcnGPDfQSV/R1bFTkRGARxSlBuLTtV51OS6Z9rE/VyPIPvr
	cfdi686KAUJQtpMaYdYD0GISye/mO607OaAHB+Xdhs5kYw4ASbQYeDf09hcdDE2lgKh6L2pck1b
	Xi4dnXECap7X8Ezx85AHrCtgF+f/1bknWdohnbQVtGMopaGRRQOjJNdA0H+eqrjOU6U7tte7OO6
	BFbmJY3LzdLzRJ5Rm0mYAzltpaDW1pbf2gd1IkrAUhROtdcebWf+itKidVV0ki/Z2nEpf2krfiK
	3rbvYtaTbyINSduwhPZBZ/nuB7vNVTlhorJeHwrCdIiBgf71eOMaXzJQus+v8tqDLHOqqHF3Vtq
	EVbVVsDlrb8Tb0JsMqfBE6M9ZAUhnuLLQBlXFlZv3bZmoFGxWcTPwRmCnaJ+WL/vohDYEUO4vce
	heNa6I/k9HFdYBWmq6KJEjW2s=
X-Received: by 2002:a05:620a:2915:b0:914:9bed:943e with SMTP id af79cd13be357-914b4a0ea73mr1145371085a.45.1779540294334;
        Sat, 23 May 2026 05:44:54 -0700 (PDT)
Received: from [10.234.26.20] ([108.147.98.162])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914bb9d5b8esm398096085a.29.2026.05.23.05.44.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 May 2026 05:44:53 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: <bboscaccy@linux.microsoft.com>
CC: KP Singh <kpsingh@kernel.org>, LSM List <linux-security-module@vger.kernel.org>, bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, James Bottomley <James.Bottomley@hansenpartnership.com>
Date: Sat, 23 May 2026 07:44:52 -0500
Message-ID: <19e54ddf1a0.2843.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <19e54da1d28.2843.85c95baa4474aabc7814e68940a78392@paul-moore.com>
References: <20260522023234.3778588-1-kpsingh@kernel.org>
 <CAHC9VhTk3qovnQQjK0C_FWU605j6Yi+-poMVVMS8WycRFg9xhQ@mail.gmail.com>
 <CAADnVQLbCz8nCLS2W=Hpk3hVSBqHGuGyVjeKYPnNDhhu_1UiPQ@mail.gmail.com>
 <19e54da1d28.2843.85c95baa4474aabc7814e68940a78392@paul-moore.com>
User-Agent: AquaMail/1.58.1 (build: 105801620)
Subject: Re: [PATCH bpf-next 00/13] Signed BPF + IPE Policies
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On May 23, 2026 7:40:42 AM Paul Moore <paul@paul-moore.com> wrote:
> On May 23, 2026 3:40:46 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> sashiko spotted it too.
>> All other sashiko bugs were ignored as well.
>
> Link? I didn't see any feedback from sashiko feedback on list and to the
> best of my knowledge it hasn't been enabled for LSM patches.

https://sashiko.dev/#/patchset/20260507191416.2984054-1-bboscaccy%40linux.microsoft.com

Blaise, I know you've got another patch coming soon - please take a look at 
the link above and see if there is anything else that needs to be addressed.

--
paul-moore.com


