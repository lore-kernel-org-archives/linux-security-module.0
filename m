Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395071D540
	for <linux-security-module@vger.kernel.org>; Sun, 26 Jan 2025 12:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737896382; cv=none; b=Xh6HVTK8BRMxUL6waVTtzJ6TXIJzmRaoW8SkFAIYk484M6iGJ2b/4WioLsF34JhfLDasJiepJ87J1VDBi4sfRoQAxjVHPApdswpPhrTMfG2gvmpV6lrXvCdMUj2T+kUoOtJuguFDF/UuUv9bn4lrKQGen8Cy1EOr/AO9sQ8ljH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737896382; c=relaxed/simple;
	bh=Mn/enMoPyRDapTosiaUAIRaHTA0OkiFhpdpp0dA+fIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=URaSKR7T+92ykGBPZBd4CbYtilLNzatJpc8/t+RipVukcxtx8KtJpHGYkV6YUzVyC662dLxD1OOeCHkZAfwRGclycj7KISrZsgcag0vY8wQyfIm9Ibz0qoophXPDXGnjhAxcIz7GU2T3uUdzqd8OY5bSvIVc4APZ0T1kGnF8miw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 50QCxS43019576;
	Sun, 26 Jan 2025 21:59:28 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 50QCxScl019571
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 26 Jan 2025 21:59:28 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <3a1e933f-9a3c-4cb8-b3c2-a8a55698a5c0@I-love.SAKURA.ne.jp>
Date: Sun, 26 Jan 2025 21:59:27 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tomoyo: fix spelling error
To: Tanya Agarwal <tanyaagarwal25699@gmail.com>
References: <20250123194759.2759-1-tanyaagarwal25699@gmail.com>
Content-Language: en-US
Cc: linux-security-module <linux-security-module@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20250123194759.2759-1-tanyaagarwal25699@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav301.rs.sakura.ne.jp
X-Virus-Status: clean

On 2025/01/24 4:48, Tanya Agarwal wrote:
> From: Tanya Agarwal <tanyaagarwal25699@gmail.com>
> 
> Fix spelling error in security/tomoyo module comments that were
> identified using the codespell tool.
> No functional changes - documentation only.
> 
> Signed-off-by: Tanya Agarwal <tanyaagarwal25699@gmail.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

Applied as
https://sourceforge.net/p/tomoyo/tomoyo.git/ci/41f198d58b6f2b36f9f8a4481d517369b324e773/ .

Thanks.

