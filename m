Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12C117C8D
	for <linux-security-module@vger.kernel.org>; Sat,  5 Oct 2024 04:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728103197; cv=none; b=oIdSgeY3IxDWDehV5e8Wxu+2/HJzT85sOURY9z6XDDCHmZQnhMaTe4Ke9fdyZhsfZQTZRIcS2vfVyuoIW/JLzbefdPYqaQSP23PeDBydfZ4niFn5Sq1j77kRczZhIClWNt1pURikxCqy42e4hAV6OWA98lnGkLhhJOLSTKYAfx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728103197; c=relaxed/simple;
	bh=GOSPyiEEn/4/3Leje/D8mIP3RNPB7sAFZgeEYGxGBkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WZLGLTtTyK1ln956a7g1tQ1o/YKXqUPYRhT59UkNgD7nIuLshWVghNSVuKXcjoyacVBf0blRTdJzPS3fnNgCaZkowmo1quC4jDfcBLt+mwDDOzSH7e6B1CuOVC3C4aN87pf7sRfdv0L2rt6U70JqpE/gfXvBlq1Vtv1ew8e07Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=f6GlQJd1; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="f6GlQJd1"
Received: from [192.168.192.84] (unknown [50.39.103.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 41B723F76A;
	Sat,  5 Oct 2024 04:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1728103192;
	bh=jNV6io2yLiu4j5YEJzphLk3h51A04sM63xo1F7CgGN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=f6GlQJd1FV0FcIQncAxLKwlstFVxvtQnw6FB5budSHWVser4IvV9KUd1m5YJt8il6
	 +Bm7lpViKBXDY9Y93xt6v5Ccys5RDRcGaLb0uRbFFIw+llQSVLHuXB4AZpToQR2JhT
	 E+yupJTawc3OmZtZDCBciGUTi70Q4PPTOwW38BxrHLJchqvTIIf5Q5VfBpoNtUptW4
	 bZTkqdyFgBEK4k80KblBjz6MrHh8TI/q6CsAFxvQf6gq3eBI5TazmTARhpHGwaeUCy
	 qTo2EgV5CA5JY5dFtB7lUuHeF1JITLivk0EzOTfafaMtHDDYPdNZSulgH5a9nNUhNZ
	 FZseI97qJC8+Q==
Message-ID: <f5caecda-6afa-4338-8f8e-e1629b115b4f@canonical.com>
Date: Fri, 4 Oct 2024 21:39:46 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: TOMOYO's pull request for v6.12
To: "Serge E. Hallyn" <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Fan Wu <wufan@linux.microsoft.com>, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>, Mimi Zohar <zohar@linux.ibm.com>,
 Micah Morton <mortonm@chromium.org>, Casey Schaufler
 <casey@schaufler-ca.com>, Roberto Sassu <roberto.sassu@huawei.com>,
 KP Singh <kpsingh@kernel.org>, Kees Cook <keescook@chromium.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-security-module@vger.kernel.org
References: <CAHC9VhR=QjdoHG3wJgHFJkKYBg7vkQH2MpffgVzQ0tAByo_wRg@mail.gmail.com>
 <20241003024307.GA833999@mail.hallyn.com>
 <CAHC9VhSa-Jpqmej=3WsLFvSKWamZjFDwUpLHrJOyxaPPujM6ww@mail.gmail.com>
 <20241003162940.GA848724@mail.hallyn.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20241003162940.GA848724@mail.hallyn.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/3/24 09:29, Serge E. Hallyn wrote:
> On Thu, Oct 03, 2024 at 11:32:39AM -0400, Paul Moore wrote:
>> On Wed, Oct 2, 2024 at 10:43 PM Serge E. Hallyn <serge@hallyn.com> wrote:
>>> On Wed, Oct 02, 2024 at 04:12:50PM -0400, Paul Moore wrote:
>>>> Hi all,
>>>>
>>>> Hopefully by now you've at least seen the TOMOYO v6.12 pull request
>>>> thread; if you haven't read it yet, I suggest you do so before reading
>>>> the rest of this mail:
>>>>
>>>> https://lore.kernel.org/all/0c4b443a-9c72-4800-97e8-a3816b6a9ae2@I-love.SAKURA.ne.jp
>>>>
>>>> Of the three commits in the pull request, the commit which concerns me
>>>> the most is 8b985bbfabbe ("tomoyo: allow building as a loadable LSM
>>>> module").  The commit worries me as it brings management of the TOMOYO
>>>> LSM callbacks into TOMOYO itself, overriding the LSM framework.
>>>> Jonathan raises a similar point, although his issue is more focused on
>>>> the symbol export approach itself, rather than conceptual issues
>>>> relating to the LSM framework.  I will admit there are some high level
>>>> similarities to this approach and the BPF LSM, but I believe we can
>>>> say that the BPF LSM exception is necessary due to the nature of BPF,
>>>> and not something we want to see duplicated outside of that one
>>>> special case.
>>>>
>>>> As I wrote in my original response to this pull request, this is not
>>>> something I would accept in a new LSM submission and thus I feel
>>>> compelled to speak out against this change and submit a revert to
>>>> Linus.  However, as the LSM framework exists to satisfy the needs of
>>>> the individual LSMs, I've tried to ensure that significant changes
>>>> like these are done with support of the majority of LSMs.  I
>>>> understand that in a case like this, reverting LSM-specific commits,
>>>> individual LSM maintainers may not want to speak up on the issue so
>>>> I'm going to let this message sit on-list until Friday morning, unless
>>>> I see the majority of the LSMs voicing support *against* reverting the
>>>> TOMOYO commit above (and the other related commit) I will proceed with
>>>> submitting the revert to Linus on Friday.  I would prefer if all
>>>> responses are sent on-list, but you can also mail me privately with
>>>> your objection to the revert and I will include it in the count.
>>>>
>>>> Thanks.
>>>
>>> Huh!  Honestly, when I read the thread, especially Jon's comments, I was
>>> worried.  But getting a chance to look at the patch now, it actually
>>> seems good to me.  No one is getting affected unless they enable
>>> CONFIG_TOMOYO_LKM.  Even those distros which have been enabling TOMOYO
>>> won't be exporting new hooks without a config change, iiuc.
>>
>> I don't want to set a precedent of individual LSMs managing how they
>> plug into the rest of the kernel; at best it results in a lot of code
>> duplication between the individual LSM and the framework, at worst it
>> opens the door for buggy interactions and difficult to predict
>> behavior.  Look at all the work we've done over the past couple of
>> years to cleanup how the LSM framework manages the individual LSM
>> callbacks both to reduce the chances of error and improve performance.
> 
> That's reasonable.  And I agree with John that, because of the way this
> was "snuck in", if I were a distro building a tomoyo-enabled kernel, I
> would now have trust issues.  But I don't think anyone else will come
> to Tetsuo's defense, so I just wanted to point out that, while the
> process was very much done wrongly, I think code-wise he's done the most
> responsible thing he could - given his end goals.  Even so,
> 
its an interesting approach. Its something I am willing to discuss further
as an extension module of the LSM, not in an individual LSM.

>> Sidestepping this by allowing individual LSMs to implement their own
>> layer of callback management is a big step backwards and not something
>> I want to see supported.
> 
> Well, this didn't occur to me last night, but what I'd be curious to
> hear is whether Tetsuo has discussed this with RedHat.  Because unless
> this makes them say "ok we'll enable that", it still doesn't help him.
> And I don't imagine them agreeing to enable the CONFIG_TOMOYO_LKM.
> 
> -serge

