Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CFF199EAD;
	Tue, 19 May 2026 00:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779150065; cv=none; b=gOoia48YmwkVZeRHi7HTFeijF8v4sdqI+Pwl2Y4wOU3LyhzbD5cPa57QwdAUYMuWo9BpRpkE1m7Bz+e54R1S31/O5jR2aPNVF9g54VYyxL3kWedD71C0A/y79ZJaqr+/ydd8l7U9ZoKaIwfIOXgywg5Citys/X9AOprwkhShI2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779150065; c=relaxed/simple;
	bh=g6jM78IAiwmiKKkEI1OsTMYPwII4biLAvajfrLflMm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QhmIx931sV0nwgPOUeGVVZorr22U9i/YicAmA6grqJ7m+VIXNhVpalc9YAgGHeuefJlLb/j52Lav16Bt7tvszFZzizza89Yc4yYVJcc5UjrVIep9uMvO6zPD+3uo929CngMbPPimduqJRX9dTXedD3jl2FPBtpI0zgKyDSp03J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LwNnBkQq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LwNnBkQq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E51EC2BCB7;
	Tue, 19 May 2026 00:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779150065;
	bh=g6jM78IAiwmiKKkEI1OsTMYPwII4biLAvajfrLflMm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LwNnBkQqWlTsR3QiBnUclIbtYOIBKYxJPhlnH+/VBpsQWfJdPmmhICceqPauQlmr9
	 dUr/t4b7lnipWnyE+riIeb9nrx8jDn+9oV2bXpEq0MSCNWzeOB7w5j38ZJBDmw3xRp
	 NqWLlrsb1L7eS76wKk2cFXoqfq5o0x2y1HutEZnEGuPg3MUSueE+7gMPLVznOiLL+t
	 sNeCXfcM3eAM3vyRHiIjSpjOUlXpcLqZz2YkC2UfDEBeF768WddjNgEwTjZMoymhMN
	 Xu4IuswwLpgBisFI71pr3RpXIvFZNHMacW3TzpVYMi5UXy4oEkQ8hPRFDAj93mGnO3
	 yh1wyrmZ22+Eg==
Date: Mon, 18 May 2026 20:21:03 -0400
From: Sasha Levin <sashal@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Song Liu <song@kernel.org>, corbet@lwn.net, akpm@linux-foundation.org,
	skhan@linuxfoundation.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	gregkh@linuxfoundation.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] killswitch: add per-function short-circuit mitigation
 primitive
Message-ID: <agus77KM_AHBUrP9@laps>
References: <20260507070547.2268452-1-sashal@kernel.org>
 <CAHC9VhTwDt2Bx8n0io9Qge_fUEnrHsxrFAQY+KaemKWqJqBQxw@mail.gmail.com>
 <CAPhsuW4TJRqQKXgcBYog8YgFLU2h2Zq9ReahxTYp_zpDyvO8AA@mail.gmail.com>
 <CAHC9VhS1DJNs9gDB6gD9WKhL08giSVajBskZ+=mY0AWRCAsw7Q@mail.gmail.com>
 <CAPhsuW5jQOzRTi1ea+=UPhx5W9bkBdivPagRE=O=nx0zf_vb8w@mail.gmail.com>
 <CAHC9VhTGDOJZDzEA31qc0S6FJpYNC4oD__HQ-65wqqwhng=V9Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhTGDOJZDzEA31qc0S6FJpYNC4oD__HQ-65wqqwhng=V9Q@mail.gmail.com>

On Mon, May 18, 2026 at 07:57:37PM -0400, Paul Moore wrote:
>On Mon, May 18, 2026 at 7:23 PM Song Liu <song@kernel.org> wrote:
>> On Mon, May 18, 2026 at 2:29 PM Paul Moore <paul@paul-moore.com> wrote:
>> [...]
>> > In my opinion, making killswitch an LSM is more of a procedural item
>> > that deals with how we view a capability like killswitch.  I
>> > personally view killswitch as somewhat similar to Lockdown, which is
>> > why I made the suggestion.
>> >
>> > The use of kprobes, while an interesting idea, presents problems as
>> > allowing any kernel symbol to be killed introduces the potential for
>> > security regressions.  As a reminder, some LSMs, as well as other
>> > kernel subsystems, have mechanisms in place to restrict root and/or
>> > enforce one-way configuration locks; while many people equate "root"
>> > with full control, in many cases today that is not strictly correct.
>> >
>> > Yes, kprobes have been around for some time, this is not a new
>> > problem, but killswitch makes it far more convenient and accessible to
>> > do dangerous things with kprobes.  If killswitch makes it past the RFC
>> > stage without any significant changes to its kill mechanism, we may
>> > need to start considering more liberal usage of NOKPROBE_SYMBOL()
>> > which I think would be an unfortunate casualty.
>>
>> I don't think we can use NOKPROBE_SYMBOL(). There are functions
>> that we don't want to killswitch, but still want to trace.
>
>That was exactly my point, but we need to figure something out so
>killswitch doesn't make it easier to cause a regression.

At this point it sounds like you're trying to stop root from shooting itself in
the foot, which we always avoided doing.

killswitch doesn't add any new functionality in that regard: rood can always
load a module, write to /dev/mem, etc which would allow it to do the same
thing. It's just a more convenient way to do it.

-- 
Thanks,
Sasha
