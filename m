Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA1412B73
	for <linux-security-module@vger.kernel.org>; Sun,  5 Jan 2025 17:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736099326; cv=none; b=qxzD4xSdCXhr/mG2wO9Jq7wUxMYNxKuRSeKnOVDAaU6dDHtsoLpYZlH7M5TKQSL4FGySjwB2aRxlp2yklpOKeJWcGXH3eE8ql8hcrNNhwpkncNFqiE3FWEK5d71vLzGymUud5HCXBu7R1ChB/Hg+cFDZKpfqMaI1P76IcWAcVCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736099326; c=relaxed/simple;
	bh=VSKGgBXQitW70O3PlbpQGia2OfQLlQk/cJr0CNetNwQ=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=oA4Qg2+IyguCp9X6JgkWn1by8chU8SvOBxwapziqYbV0Mf1Z0uJhfUQOVxHZjuaXLq5O9ft2SJRCHvSLw7rK6iTRGIClu9WdO9+4y/GsrIOSSDyyfmxjRn78X7WxWPlqdUmEU9tihxefsxNCIyulskf7Aa3+qLqhWC//VBa/C3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=AEqyPlUp; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="AEqyPlUp"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6d8f75b31bfso121295156d6.3
        for <linux-security-module@vger.kernel.org>; Sun, 05 Jan 2025 09:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1736099323; x=1736704123; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eqFAn42MR7s18zOlzS1GbLo3k3bDKDCPzEgFCfO1vGQ=;
        b=AEqyPlUps09mnZk+9/ejA3Nl+Xm06DvS15Agk6gT5GY+nvQrxLJO0K0Xw7CpRmGHnh
         TnHjHPWd7s4Gc2iAzfN+a8bFGcQZnwuK+BUXUW0BNm2L86LqRxZHi7m+zqeDCsmZU5mW
         P09IjgbC/wMakH49fN8LcLfZCEoPMFbQYDAvsQMS+trE4kZ1rpVRchh/eatnRRyxVpt+
         /kPcxJ1yvtoloLcR4j+dwO4i81V9HuSiAEC3dst3OgM0YJexjWsW104SB3c2mY2MDjiS
         7nehPqhsSYITgJCkPI+0kCCb9z/Erdj2BHNWx4oL6TSWgBlUizxTFmYxwp27x5dI4D9O
         YQ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736099323; x=1736704123;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eqFAn42MR7s18zOlzS1GbLo3k3bDKDCPzEgFCfO1vGQ=;
        b=J0La2l4XPEXp8NrJDm0JaJlqW72f4fhwGarwXU9Yi+CT0Y9LOsBjaZwamI+oR+UIzA
         WpkB9CUlbF/dEP1V49IxyB9qGyPvO9yw6olVXbyuizatOXiBGejiK4FieIizgiILO8Wt
         de7vTzo/zPBNhgOdKi36KLXG9EZs63Px/EYm4ElMy7TvPcJrUt9ZBPL+1WQ5Rl1mne3+
         ipO1LGZ3ZKOeFFPzHeIJeuFw0Y495Xwn5ndMXMR4Cd90mLI833iOKC0vikmxCjuA4Hg9
         GpoMadTWcQBWIzoER1B7l3greQtu+MotwfTMFDXHYfdTLE4S/Y7Zs8YEKlhTqatW6lMy
         spng==
X-Forwarded-Encrypted: i=1; AJvYcCUqLhrdbxBhn+cVO2vJeHnUK2WEhWYyUd3KRozb6P7TqJwnmWloRZrTjNNAwlavmKcE1Cl14m5qOjlahdu+ucHTG8H4tW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfGb46cggxi1O2aLPCwKAVRM11/j5VlY3v4QgKsJ38UMphU9Wa
	T+NL0+W+cTYaHm4LFOParOjMo6n4z7k2Gcijlg3NUFlHDffAQQi5sVb2ZbrjnA==
X-Gm-Gg: ASbGncvyG20/q6491SfeLnPcLw8rGDa5Ty2/uCoaAbtIJ4kaR4qohYamcP0nV7UX0Q0
	5DcmgJ1RA5z154L21OiQfOmkMr+HHY4b3vLgAQy2dFpGbmLWbEzOCCauK5HT89nJl6u6gLcpr7w
	UPE/8TUJwGmgzCRGu9vyHblCGP0KiNSpiIwrcTaH2EBe4cweJqvDmAA21GNAJKyzuzYPSzlSDjb
	YyARKNC846u0l0PvRrQeXou0T7Et3OU+7lxtCVyfIjegIxPGKY=
X-Google-Smtp-Source: AGHT+IEBG2Jubo3FltlrYRM8ERHRDZ/LXGRqqLAqTN9MUrsepD9bPzsvEaQWRSOl1ScA1KyeHxxvaA==
X-Received: by 2002:ad4:5f89:0:b0:6d8:8416:9c54 with SMTP id 6a1803df08f44-6dd2333272amr1029158056d6.16.1736099322941;
        Sun, 05 Jan 2025 09:48:42 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd180ebe59sm162056656d6.27.2025.01.05.09.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2025 09:48:42 -0800 (PST)
Date: Sun, 05 Jan 2025 12:48:41 -0500
Message-ID: <2f7db63290c5c81513721f10a65f602e@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250105_1245/pstg-lib:20250105_1245/pstg-pwork:20250105_1245
From: Paul Moore <paul@paul-moore.com>
To: Tanya Agarwal <tanyaagarwal25699@gmail.com>, jmorris@namei.org, serge@hallyn.com
Cc: kees@kernel.org, yuehaibing@huawei.com, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, matthewgarrett@google.com, skhan@linuxfoundation.org, anupnewsmail@gmail.com, tanyaagarwal25699@gmail.com
Subject: Re: [PATCH v3] lockdown: Initialize array before use
References: <20250105070537.58334-1-tanyaagarwal25699@gmail.com>
In-Reply-To: <20250105070537.58334-1-tanyaagarwal25699@gmail.com>

On Jan  5, 2025 Tanya Agarwal <tanyaagarwal25699@gmail.com> wrote:
> 
> The static code analysis tool "Coverity Scan" pointed the following
> details out for further development considerations:
> CID 1486102: Uninitialized scalar variable (UNINIT)
> uninit_use_in_call: Using uninitialized value *temp when calling
> strlen.
> 
> Conclusion:
> Initialize array before use in lockdown_read() to satisfy the static
> analyzer.
> 
> Fixes: 000d388ed3bb ("security: Add a static lockdown policy LSM")
> Signed-off-by: Tanya Agarwal <tanyaagarwal25699@gmail.com>

I removed the 'Fixes:' tag as the code isn't actually broken as we
discussed in previous iterations of this patch.  I also edited the
subject line and commit description a bit, but otherwise this is
fine.  Merged into lsm/dev.

--
paul-moore.com
