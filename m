Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592A319CC20
	for <linux-security-module@vger.kernel.org>; Wed, 23 Oct 2024 10:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729680787; cv=none; b=HlKtarfbf8vQV6eqnAJEZKCV0yXaAF4ctBLKVR8Ewmilojuph5NFlq0pJ0117fNplJnNX6EVV5fQ4Gcs7geD9XmYksv75p99lRVvGBcGtuI7HDipffmYB2WC45WVjlji6aAeoKpJao5sH5aB33wEgYiQBqGfvx3P7qC3iebfvo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729680787; c=relaxed/simple;
	bh=epJFyaXuHXQannN2KseksOhoFzpEPJjWMx3lolviOdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CraQfHH+k9yT6p4G+EXpxTQeDM1DAww+CcTnZZ3s6HmL+mnQZlHQuYcYvsTFnfpYumBtzbwkSqDpk8c9JBZhzctZ4p7yhXIijhmYfFpQd+IrLX0fzBaTXJYVP0VUFgIZADvhf0cLmeIZgW8UpzVDYcxdImG6l+zgtdkLjDSaMtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 49NAqvg2036413;
	Wed, 23 Oct 2024 19:52:57 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 49NAquWs036406
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 23 Oct 2024 19:52:56 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <6e4ae97f-5b70-457a-8173-00bbbb66d763@I-love.SAKURA.ne.jp>
Date: Wed, 23 Oct 2024 19:52:55 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: TOMOYO's pull request for v6.12
To: John Johansen <john.johansen@canonical.com>, Kees Cook <kees@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, Fan Wu <wufan@linux.microsoft.com>,
        =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        Mimi Zohar <zohar@linux.ibm.com>, Micah Morton <mortonm@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        KP Singh <kpsingh@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-security-module@vger.kernel.org
References: <CAHC9VhR=QjdoHG3wJgHFJkKYBg7vkQH2MpffgVzQ0tAByo_wRg@mail.gmail.com>
 <202410041305.544EA7E4E@keescook>
 <ece0c7bd-0d28-4562-8760-c54b0077583a@I-love.SAKURA.ne.jp>
 <202410041645.27A48DA@keescook>
 <2596b240-63a0-4daa-b048-a33fadd4f74f@canonical.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <2596b240-63a0-4daa-b048-a33fadd4f74f@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav401.rs.sakura.ne.jp
X-Virus-Status: clean

On 2024/10/05 12:38, John Johansen wrote:
> On 10/4/24 17:17, Kees Cook wrote:
>> (Out of curiosity, does RedHat build in AppArmor?)
>>
> 
> No they don't
> 

I think that AppArmor also has chance to get enabled in
at least Fedora kernels, for sending a pull request which
modifies kernel config options was accepted.

https://bugzilla.redhat.com/show_bug.cgi?id=2303689#c1
https://gitlab.com/cki-project/kernel-ark/-/merge_requests/3450

My goal is that TOMOYO is also enabled in RHEL kernels, as with
Landlock is currently trying.

https://gitlab.com/cki-project/kernel-ark/-/merge_requests/3454

