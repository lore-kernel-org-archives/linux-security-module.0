Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985C32236F7
	for <linux-security-module@vger.kernel.org>; Tue, 14 Jan 2025 23:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736895621; cv=none; b=po2/JzdCDFoVu4nRPxQHsQLyZ/+2QFuJwHQVCjiFtsz9Ydtgf/4gWydV89GHLt7wYNCA2hq6mC/rrc7C6QEBXo+irY3oz2g9MjowF9J0vMACFsWmArurbwyRhlNlC3xNY9AxIHiDwt2BD5jz6Xidc5vVj0GE3gMxvxaDY8m39J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736895621; c=relaxed/simple;
	bh=suNZXz59Sz+AYEidJeKgqkinZ87y8iwjQ/kG/RA+K0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aSC19E1hSh6C/kIUPornCvxXQabRSht+qIyiI/M+Nm0P64RE+F17nZMMbwK3Dm5dfeCawVFoezQK7wGZaMe+MF1lxFnq+2rYDjsjmPyKiTlSkmRFCEiH3USIZiEmKVrtIs7A1KNt8stQ3L8sTV5wWAr8yhJHahvtZrZXageoqMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 50EMxWp9094037;
	Wed, 15 Jan 2025 07:59:32 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 50EMxWeh094032
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 15 Jan 2025 07:59:32 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <1b4275ad-a07b-4647-9d2b-48af08cdbebe@I-love.SAKURA.ne.jp>
Date: Wed, 15 Jan 2025 07:59:33 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Docs/security: update cmdline keyword usage
To: Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>, Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <sergeh@kernel.org>,
        linux-security-module@vger.kernel.org,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        John Johansen <john.johansen@canonical.com>,
        John Johansen <john@apparmor.net>, Jonathan Corbet <corbet@lwn.net>
References: <20250114225156.10458-1-rdunlap@infradead.org>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20250114225156.10458-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav403.rs.sakura.ne.jp
X-Virus-Status: clean

On 2025/01/15 7:51, Randy Dunlap wrote:
> Use "lsm=name,..." instead "security=name,..." since the latter is
> deprecated.

Sorry, but security= is for specifying only one of exclusive LSM modules
whereas lsm= is for specifying both one of exclusive LSM modules and
all of non-exclusive LSM modules. That is, you can't deprecate
security= using s/security=/lsm=/g .

