Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A013B6C13;
	Tue, 19 May 2026 20:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779220858; cv=none; b=sUip8OH51m1u6Sycv/9axrrfRGG08uOnRv8pNhtqeITsUj5B5CbWksBEUB/T2tWRsh4rtA83JN7pNyFEXM3KAPcnx+aDxWhe0ZckGoLWDhE0j/D6lwf3ABaCHGQkfey18ELoLPcmfLvKU2O9DwDckai7GxgxKfL8jOtXTJqOek0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779220858; c=relaxed/simple;
	bh=EV//t36Qewy54DotybfRxWzNFmRS5Z8tPXSiAf9UDM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3MBug6hAM1ZR6nOGUk43tbtuiVPBFJH8JheftIk032bzZmCyIvq4h73xGlGPbmqO83xTf38LaOtkD90t93KcB5YWjB5eGpOy1invC2R1PWEnVomxu2WY4XK1PMrR4VSQMJbxsu/Ouk/95kIgfv4S6MlkI9neG6w30DixlOSHtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPVB+E0W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPVB+E0W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7204A1F00897;
	Tue, 19 May 2026 20:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779220856;
	bh=l6u4GkLF989nvdhrsR+1+7/Gmo+JF6wLCkLmsTT5XP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DPVB+E0WDwr5+uGKB1CfTqFPBStYFBnXxYAU/m0Z2ohgOpNQkbBUpjik2WoaWlIXa
	 5B+7CQsN5GH9AQe+OTkKBq2ks0YGnnUABv/Z/XInGy4yy7M72nzGmDd1Ff5iizVU/9
	 1qWzD3tzTbGD+qG101alr40LU0VLbaAJzXgvOhw/utVc9/yXTOoddVDN9OI/YX3Y0h
	 ro/W3eYeRV692ZxUr/o8sBXxpbgeOCYlmL13cSboQEW8U40uNaNCeUKPZOwVAGzlmk
	 7zEsLbL1Og3O9A2iX8CQqOGCTAcbbvC2l7Idq3M+hlos90ycL3yEnMU1XjLGzrvPns
	 DgRr/nxLmigTg==
Date: Tue, 19 May 2026 16:00:55 -0400
From: Sasha Levin <sashal@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Song Liu <song@kernel.org>, corbet@lwn.net, akpm@linux-foundation.org,
	skhan@linuxfoundation.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	gregkh@linuxfoundation.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] killswitch: add per-function short-circuit mitigation
 primitive
Message-ID: <agzBd9mMt3Zf7j1j@laps>
References: <20260507070547.2268452-1-sashal@kernel.org>
 <CAHC9VhTwDt2Bx8n0io9Qge_fUEnrHsxrFAQY+KaemKWqJqBQxw@mail.gmail.com>
 <CAPhsuW4TJRqQKXgcBYog8YgFLU2h2Zq9ReahxTYp_zpDyvO8AA@mail.gmail.com>
 <CAHC9VhS1DJNs9gDB6gD9WKhL08giSVajBskZ+=mY0AWRCAsw7Q@mail.gmail.com>
 <aguvV8QCxK28ZHct@laps>
 <CAHC9VhTEs7rCaoPG7cWAzyVkN3ztdadHAq0g8mEy_MgCiCe=0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhTEs7rCaoPG7cWAzyVkN3ztdadHAq0g8mEy_MgCiCe=0g@mail.gmail.com>

On Mon, May 18, 2026 at 11:08:38PM -0400, Paul Moore wrote:
>On Mon, May 18, 2026 at 8:31 PM Sasha Levin <sashal@kernel.org> wrote:
>> On Mon, May 18, 2026 at 05:29:32PM -0400, Paul Moore wrote:
>> >From my perspective there are two different issues here: should
>> >killswitch be a LSM, and should killswitch leverage kprobes to be able
>> >to "kill" security related symbols.  After all, are we okay with
>> >killswitch killing capable() and friends?
>>
>> killswitch doesn't do it on it's own. It may be instructed by root to do that,
>> at which point that is root's problem.
>
>As I mentioned previously, there are cases where we can restrict
>root's privileges today, but a functional killswitch would allow that
>restriction to be bypassed.  My last email to Song has an example with
>SELinux.

This would be handled by just disabling killswitch in those scenarios like how
we do with lockdown, no?

>> >In my opinion, making killswitch an LSM is more of a procedural item
>> >that deals with how we view a capability like killswitch.  I
>> >personally view killswitch as somewhat similar to Lockdown, which is
>> >why I made the suggestion.
>>
>> Maybe I'm not all that familiar with LSMs, but we would need to be able to stop
>> "random" code paths from executing, and I don't think we can create LSM hooks
>> at that granularity, no?
>
>I don't see any LSM hooks in this revision of killswitch, and as long
>as it is based on a kprobes I can't imagine it would ever use any.  As
>I mentioned above, my killswitch-as-a-LSM comment is primarily about
>killswitch filling a role very similar to Lockdown.

My question was more about how to structure killswitch as an LSM. I want to be
able to poke at pretty much any function in the kernel, rather than restrict
access to a known list of functions.

>> >The use of kprobes, while an interesting idea, presents problems as
>> >allowing any kernel symbol to be killed introduces the potential for
>> >security regressions.  As a reminder, some LSMs, as well as other
>> >kernel subsystems, have mechanisms in place to restrict root and/or
>> >enforce one-way configuration locks; while many people equate "root"
>> >with full control, in many cases today that is not strictly correct.
>>
>> killswitch "complies" with lockdown. Is there a different scenario which we
>> should be blocking?
>
>See the SELinux example I mentioned in my email to Song.
>
>> >Yes, kprobes have been around for some time, this is not a new
>> >problem, but killswitch makes it far more convenient and accessible to
>> >do dangerous things with kprobes.  If killswitch makes it past the RFC
>> >stage without any significant changes to its kill mechanism, we may
>> >need to start considering more liberal usage of NOKPROBE_SYMBOL()
>> >which I think would be an unfortunate casualty.
>>
>> Why? If I don't really mind the security impact, I want to be able to have a
>> killswitch-like interface on my systems. If an attacker is in my systems,
>> killswitch is the least of my concerns I think.
>>
>> If you are security concious, just don't enable CONFIG_KILLSWITCH?
>
>Isn't the whole point of killswitch to have it enabled everywhere
>because you never know when you might want/need it?

Right. We have different usecases. If you want selinux/lockdown/etc and a
really crippled root, that should be an option. If you choose to allow
something like killswitch, it should be an option too.

-- 
Thanks,
Sasha
