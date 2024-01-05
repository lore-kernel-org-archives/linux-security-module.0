Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D5724B46
	for <linux-security-module@vger.kernel.org>; Fri,  5 Jan 2024 10:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tv5Mw9En"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6d9e62ff056so1058043b3a.1
        for <linux-security-module@vger.kernel.org>; Fri, 05 Jan 2024 02:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704451789; x=1705056589; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wLocSjS8QgQE6QZCGqJzckHpMJl/BPQh8y5KCzDAmLA=;
        b=Tv5Mw9EnQn4L0ErDW+k2mSSkpWBg8A7x0A4JLHs/fbHMG4OTxhA7zasGcqTXiwwHXg
         r6Ai51uaDCCq2L00hWw8cKajJpHMWNuruc2YIjUjJxTurrjdQDdkXbYSZL+1nRgDrXld
         EFzo/ZVe8kEgiu6mAHwyeuY49BaRSAO5NXLzK2bjkFi7yPoRf0vPNbQlIrcOAoYnuuZa
         zZw/5W0B6bXeQCh7DihbVcRPTsFvvjHRXWOVrIxkHTBfQvrW3y+git6Tv89pDg9S5N71
         Kd5y/DmL0BPITqbcwI4Z1E3Z0nVd+dHaK1KBP7leQx2xbuMDmwxCZHrAVGKPoWUIq+a1
         2NJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704451789; x=1705056589;
        h=content-transfer-encoding:autocrypt:subject:from:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wLocSjS8QgQE6QZCGqJzckHpMJl/BPQh8y5KCzDAmLA=;
        b=lciHBfV1OPrbKWFnkNn0kVSMzy7b93yTxEEZtdTC+tXKolZWlErY/K5peItx9fMxQ8
         /TEd9FRk8zfgKTBHx0fHraKtxFhYiqHKB3KD2W+ZyOahyvYO9VmNXHgM5vF5CjVEd2Lg
         21tvve+BH1pQy07jNxSOOncN8Vnt0AOLFJUq4KsLfbTd0Edeq8owE+qFYHN6YpXgAsAA
         b0vYZPtHtYH1F8xelsE2M3eyuBbPlkG0aXLYyG3sjGQe8NJp7p+KMANcrh8VU2AzvRWu
         ryf1fYh+O6OuM6mB+xg2ARHuFT5mfK2H9slYl5hYY2FRC+sUKiuI/hi7KT2pAugEDYwc
         B8wQ==
X-Gm-Message-State: AOJu0YxbgnaZo9ReZ5/II3dG2rSQdGF9hyycZMmsXKmsoU29PbcEiMYK
	fUMbhmXyXGYuM37+x0/u+TNxu9i7pdJ3aQ==
X-Google-Smtp-Source: AGHT+IGQCkOq9n9G9yaPxjHaKijfeOBPvYoiP+BucCXmRgKe/P5hnLvH5idQvl/AfyQpZTOWV4e60w==
X-Received: by 2002:aa7:860c:0:b0:6d9:8d6f:56ed with SMTP id p12-20020aa7860c000000b006d98d6f56edmr1859189pfn.5.1704451788979;
        Fri, 05 Jan 2024 02:49:48 -0800 (PST)
Received: from ?IPV6:2409:894d:e2c:2021:a4bf:7613:333a:27d4? ([2409:894d:e2c:2021:a4bf:7613:333a:27d4])
        by smtp.gmail.com with ESMTPSA id g14-20020aa7874e000000b006d96d753ca0sm1138230pfo.38.2024.01.05.02.49.47
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jan 2024 02:49:48 -0800 (PST)
Message-ID: <15e0e437-bf4d-4634-a110-968795dc3431@gmail.com>
Date: Fri, 5 Jan 2024 18:49:42 +0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-security-module@vger.kernel.org
From: "cauc.peter" <cauc.peter@gmail.com>
Subject: help for concepts about key management of the Linux kernel security
Autocrypt: addr=cauc.peter@gmail.com; keydata=
 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
 gDtM6HfU
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I recently studied articles related to key management of the Linux
kernel security module and found some strange concepts that bothered me,
such as the meaning of key Possession and its perms.
After reading the kernel keys.txt document and man 7 keyrings still no
solution.

For example, using the keyctl command in user mode to create a session
shell is different from directly creating a new shell, keyctl show @s
has different output. i think it maybe cause by perms. but no about 
further more explanation.
and How to add other shells to the same key session?

Looking forward to your answer, thank you very much

